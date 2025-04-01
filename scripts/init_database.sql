/*
===============================================================
Create Database and Schemas
===============================================================

Script Purpose:
  This script creates a new database named 'DataWarehouse' after checking if it already exists.
  If the databas exists, it is dropped and recreated. Additionally, the script sets up three scehmas
  within the database: 'bronze', 'silver', and 'gold'.

WARNING:
  Running this script will drop the entire 'DataWarehouse' database if it exists.
  All data in the database will be permanently deleted, Proceed with caution
  and ensure youhave proper backups before running this script.
*/

USE master;
GO

--Drop and recreate the 'DataWarehouse' database

IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN  
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK INMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO
  
-- Creation of the database
CREATE DATABASE DataWarehouse;
GO 
  
-- We set our database for working
USE DataWarehouse;
GO
  
-- Creation of schemas
-- Schemas: A schema in SQL Server is a logical container within a database used to group and organize related database objects like tables, views, and procedures.

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
