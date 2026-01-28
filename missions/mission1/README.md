# Mission 1: Creating Embeddings and Performing Search

You will be guided through implementing semantic search capabilities using embedding models and Azure SQL Database. In this mission, you will:

## Learning Objectives
- **Convert Text to Vectors**: Use an embedding model to convert text into high-dimensional vector representations
- **Store Embeddings**: Store embeddings efficiently in Azure SQL Database
- **Query with Vector Similarity**: Query the database using vector similarity to find semantically related content
- **Maintain Embeddings**: Keep embeddings updated as data changes

## Prerequisites
1. Azure SQL Database with populated data
1. Embedding model access (you can use the free AI Proxy to generate embeddings for free)

## Walkthrough
### Create a SQL Database

You have two options to create an SQL Database:
- Azure SQL Database instance
- Local SQL Server instance (SQL Server 2025 or later)

#### Option 1: Create an Azure SQL Database
#### Option 2: Create a Local SQL Server Instance
Create an Azure SQL Database using the Azure Portal. You can follow the Quickstart: Create a single database in Azure SQL Database using the Azure portal guide to create a new Azure SQL Database.

Use a client tool like Azure Data Studio to connect to an Azure SQL database.

## Next Steps
After completing this mission, you will have implemented a semantic search solution that can find relevant information based on meaning rather than just keywords.
Proceed to [Mission 2: Retrieval Augmented Generation (RAG)](/missions/mission2/README.md) to learn how to build an end-to-end RAG pipeline that combines embeddings with language model generation.