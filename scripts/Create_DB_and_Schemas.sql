/*
 Create Database and Schemas for Data Warehouse
 Author: [Charles Talbot]
 Date Created: 16/09/2026
 Purpose: Creating a Data Warehouse Database and defining our Bronze, Silver and Gold Schemas where data will be stored and transformed.
*/
USE [master];	
GO

--drop Database if it exists
if EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE [DataWarehouse] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [DataWarehouse];
END
GO;

--Create Database
CREATE DATABASE [DataWarehouse];
GO


--Create Schemas
USE [DataWarehouse];
GO

CREATE SCHEMA [bronze];
GO
CREATE SCHEMA [silver];
GO
CREATE SCHEMA [gold];
GO