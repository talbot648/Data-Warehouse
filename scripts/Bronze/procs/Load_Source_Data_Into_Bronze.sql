/*
This script is for loading the raw csv data as a full load into bronze tables in the Data Warehouse.
Date Created: 17/09/26
Author: Charles Talbot
Purpose: Ingest raw data to be transformed to silver.
*/

CREATE PROCEDURE loadSourceDataIntoBronze

USE [DataWarehouse];
GO

path = 'C:\Users\charles.talbot\Documents\Data-Warehouse\Source\';

