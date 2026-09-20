/*
This script is for loading the raw csv data as a full load into bronze tables in the Data Warehouse.
Date Created: 17/09/26
Author: Charles Talbot
Purpose: Ingest raw data to be transformed to silver.
*/

USE [DataWarehouse];
GO

CREATE PROCEDURE loadSourceDataIntoBronze 
AS
BEGIN
	DECLARE @start_time DATETIME,
			@end_time DATETIME,
			@batch_start_time DATETIME,
			@batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();

		PRINT('****************************************')
		PRINT('Loading Bronze Layer')
		PRINT('****************************************')

		SET @start_time = GETDATE();
		PRINT('Truncating Table: crm_customers')
		TRUNCATE TABLE bronze.crm_customers; --ensures no duplicates are loaded into the table
		PRINT('Inserting Table: crm_customers')
		BULK INSERT bronze.crm_customers
		FROM 'C:\Users\charles.talbot\Documents\Data-Warehouse\Source\customers.csv'
		WITH (
			FORMAT = 'CSV',
			ROWTERMINATOR = '0x0a',
			FIRSTROW = 2, -- headers are first row
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT ('Duration of Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds')
		PRINT('****************************************')
		

		SET @start_time = GETDATE();
		PRINT('Truncating Table: ecom_orderItems')
		TRUNCATE TABLE bronze.ecom_orderItems;
		PRINT('Inserting Table: ecom_orderItems')
		BULK INSERT bronze.ecom_orderItems
		FROM 'C:\Users\charles.talbot\Documents\Data-Warehouse\Source\ecommerce_order_items.csv'
		WITH (
			FORMAT = 'CSV',
			ROWTERMINATOR = '0x0a',
			FIRSTROW = 2, -- headers are first row
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT ('Duration of Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds')
		PRINT('****************************************')

		SET @start_time = GETDATE();
		PRINT('Truncating Table: ecom_orders')
		TRUNCATE TABLE bronze.ecom_orders;
		PRINT('Inserting Table: ecom_orders')
		BULK INSERT bronze.ecom_orders
		FROM 'C:\Users\charles.talbot\Documents\Data-Warehouse\Source\ecommerce_orders.csv'
		WITH (
			FORMAT = 'CSV',
			ROWTERMINATOR = '0x0a',
			FIRSTROW = 2, -- headers are first row
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT ('Duration of Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds')
		PRINT('****************************************')

		SET @start_time = GETDATE();
		PRINT('Truncating Table: internal_employees')
		TRUNCATE TABLE bronze.internal_employees;
		PRINT('Inserting Table: internal_employees')
		BULK INSERT bronze.internal_employees
		FROM 'C:\Users\charles.talbot\Documents\Data-Warehouse\Source\employees.csv'
		WITH (
			FORMAT = 'CSV',
			ROWTERMINATOR = '0x0a',
			FIRSTROW = 2, -- headers are first row
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT ('Duration of Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds')
		PRINT('****************************************')

		SET @start_time = GETDATE();
		PRINT('Truncating Table: internal_promotions')
		TRUNCATE TABLE bronze.internal_promotions;
		PRINT('Inserting Table: internal_promotions')
		BULK INSERT bronze.internal_promotions
		FROM 'C:\Users\charles.talbot\Documents\Data-Warehouse\Source\promotions.csv'
		WITH (
			FORMAT = 'CSV',
			ROWTERMINATOR = '0x0a',
			FIRSTROW = 2, -- headers are first row
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT ('Duration of Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds')
		PRINT('****************************************')

		SET @start_time = GETDATE();
		PRINT('Truncating Table: internal_stores')
		TRUNCATE TABLE bronze.internal_stores;
		PRINT('Inserting Table: internal_stores')
		BULK INSERT bronze.internal_stores
		FROM 'C:\Users\charles.talbot\Documents\Data-Warehouse\Source\stores.csv'
		WITH (
			FORMAT = 'CSV',
			ROWTERMINATOR = '0x0a',
			FIRSTROW = 2, -- headers are first row
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT ('Duration of Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds')
		PRINT('****************************************')

		SET @start_time = GETDATE();
		PRINT('Truncating Table: pim_products')
		TRUNCATE TABLE bronze.pim_products;
		PRINT('Inserting Table: pim_products')
		BULK INSERT bronze.pim_products
		FROM 'C:\Users\charles.talbot\Documents\Data-Warehouse\Source\products.csv'
		WITH (
			FORMAT = 'CSV',
			ROWTERMINATOR = '0x0a',
			FIRSTROW = 2, -- headers are first row
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT ('Duration of Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds')
		PRINT('****************************************')

		SET @start_time = GETDATE();
		PRINT('Truncating Table: pos_orderItems')
		TRUNCATE TABLE bronze.pos_orderItems;
		PRINT('Inserting Table: pos_orderItems')
		BULK INSERT bronze.pos_orderItems
		FROM 'C:\Users\charles.talbot\Documents\Data-Warehouse\Source\pos_order_items.csv'
		WITH (
			FORMAT = 'CSV',
			ROWTERMINATOR = '0x0a',
			FIRSTROW = 2, -- headers are first row
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT ('Duration of Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds')
		PRINT('****************************************')

		SET @start_time = GETDATE();
		PRINT('Truncating table: pos_orders')
		TRUNCATE TABLE bronze.pos_orders;
		PRINT('Inserting Table: pos_orders')
		BULK INSERT bronze.pos_orders
		FROM 'C:\Users\charles.talbot\Documents\Data-Warehouse\Source\pos_orders.csv'
		WITH (
			FORMAT = 'CSV',
			ROWTERMINATOR = '0x0a',
			FIRSTROW = 2, -- headers are first row
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT ('Duration of Load: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS NVARCHAR(10)) + ' seconds')
		PRINT('****************************************')

	END TRY
	BEGIN CATCH
		PRINT('ERROR OCCURED DURING LOAD OF SOURCE DATA INTO BRONZE LAYER')
		PRINT('ERROR MESSAGE: ' + ERROR_MESSAGE())
		PRINT('ERROR NUMBER: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10)))
	END CATCH

		SET @batch_end_time = GETDATE();
		PRINT ('Total Duration of Load: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR(10)) + ' seconds')
	END;
GO