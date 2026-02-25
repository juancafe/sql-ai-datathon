CREATE DATABASE TestDatabase;
GO

USE TestDatabase;
CREATE TABLE dbo.MyFirstImport (
   PersonID smallint,
   FirstName varchar(25),
   LastName varchar(30),
   BirthDate Date
   );