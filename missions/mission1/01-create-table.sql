CREATE DATABASE Sales;

drop table if exists [dbo].[walmart_ecommerce_product_details]
create table [dbo].[walmart_ecommerce_product_details]
(
	[id] [int] not null,
	[source_unique_id] [char](32) not null,
	[crawl_timestamp] [nvarchar](50) not null,
	[product_url] [nvarchar](200) not null,
	[product_name] [nvarchar](200) not null,
	[description] [nvarchar](max) null,
	[list_price] [decimal](18, 10) null,
	[sale_price] [decimal](18, 10) null,
	[brand] [nvarchar](500) null,
	[item_number] [bigint] null,
	[gtin] [bigint] null,
	[package_size] [nvarchar](500) null,
	[category] [nvarchar](1000) null,
	[postal_code] [nvarchar](10) null,
	[available] [nvarchar](10) not null,
	[embedding] [vector](1536) null
)
go


/*
	Cleanup if needed
*/
if not exists(select * from sys.symmetric_keys where [name] = '##MS_DatabaseMasterKey##')
begin
	create master key encryption by password = 'Pa$$w0rd!123'
end
go
if exists(select * from sys.[external_data_sources] where name = 'openai_playground')
begin
	drop external data source [openai_playground];
end
go
if exists(select * from sys.[database_scoped_credentials] where name = 'openai_playground')
begin
	drop database scoped credential [openai_playground];
end
go

/*
	Create database scoped credential and external data source.
	File is assumed to be in a path like: 
	https://<myaccount>.blob.core.windows.net/playground/walmart/walmart-product-with-embeddings-dataset-usa.csv

	Please note that it is recommened to avoid using SAS tokens: the best practice is to use Managed Identity as described here:
	https://learn.microsoft.com/en-us/sql/relational-databases/import-export/import-bulk-data-by-using-bulk-insert-or-openrowset-bulk-sql-server?view=sql-server-ver16#bulk-importing-from-azure-blob-storage
*/
create database scoped credential [openai_playground]
with identity = 'SHARED ACCESS SIGNATURE',
secret = 'sv=2018-03-28&spr=https&st=2026-01-27T22%3A02%3A11Z&se=2026-01-28T22%3A02%3A11Z&sr=c&sp=rl&sig=f4gaxPghrc8yZO7MzrAT86r%2FIpqD%2FlpQOLeIoUGSBek%3D'; -- make sure not to include the ? at the beginning
go
create external data source [openai_playground]
with 
( 
	type = blob_storage,
 	location = 'http://127.0.0.1:10000/devstoreaccount1/playground',
 	credential = [openai_playground]
);
go

/*
    Import data
*/
bulk insert dbo.[walmart_ecommerce_product_details]
from 'walmart/walmart-product-with-embeddings-dataset-usa.csv'
with (
	data_source = 'openai_playground',
    format = 'csv',
    firstrow = 2,
    codepage = '65001',
	fieldterminator = ',',
	rowterminator = '0x0a',
    fieldquote = '"',
    batchsize = 1000,
    tablock
)
go

/*
	Add indexes
*/
create unique clustered index ixc on dbo.[walmart_ecommerce_product_details](id)
go