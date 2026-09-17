/*
Cretae Bronze tables for the data warehouse. These tables are the raw data from the source systems, 
and will be transformed to create the Silver tables.
Date Created: 17/09/26
Author: Charles Talbot
Purpose: Ingest raw data to be transformed to silver.
*/

USE [DataWarehouse];
GO

IF OBJECT_ID('bronze.crm_customers', 'U') IS NOT NULL --this will drop the database, use with caution
    DROP TABLE bronze.crm_customers;
CREATE TABLE bronze.crm_customers (
	customer_id NVARCHAR (10),
	first_name NVARCHAR (30),
	last_name NVARCHAR (30),
	email NVARCHAR (100),
	phone NVARCHAR (30),
	address NVARCHAR(50),
	city NVARCHAR(30),
	state NVARCHAR(30),
	zip_code INT,
	country NVARCHAR(30),
	signup_date DATE,
	customer_segment NVARCHAR(30)
);
GO

IF OBJECT_ID('bronze.pim_products', 'U') IS NOT NULL
    DROP TABLE bronze.pim_products;
CREATE TABLE bronze.pim_products (
	product_id NVARCHAR (10),
	product_name NVARCHAR (50),
	category NVARCHAR (20),
	subcategory NVARCHAR(20),
	brand NVARCHAR(20),
	supplier NVARCHAR(50),
	unit_cost DECIMAL(10,2),
	unit_price DECIMAL(10,2)
);
GO

IF OBJECT_ID('bronze.internal_stores', 'U') IS NOT NULL
    DROP TABLE bronze.internal_stores;
CREATE TABLE bronze.internal_stores (
	store_id NVARCHAR(5),
	store_name NVARCHAR(50),
	store_type NVARCHAR(20),
	address NVARCHAR(50),
	city NVARCHAR(30),
	state NVARCHAR(30),
	region NVARCHAR(20),
	open_date DATE
);
GO

IF OBJECT_ID('bronze.internal_employees', 'U') IS NOT NULL
    DROP TABLE bronze.internal_employees;
CREATE TABLE bronze.internal_employees (
    employee_id  NVARCHAR(10),
    first_name   NVARCHAR(30),
    last_name    NVARCHAR(30),
    email        NVARCHAR(100),
    store_id     NVARCHAR(10),
    role         NVARCHAR(50),
    hire_date    DATE
);
GO

IF OBJECT_ID('bronze.internal_promotions', 'U') IS NOT NULL
    DROP TABLE bronze.internal_promotions;
CREATE TABLE bronze.internal_promotions(
    promo_code    NVARCHAR(20),
    description   NVARCHAR(200),
    discount_pct  INT,
    start_date    DATE,
    end_date      DATE
);
GO

IF OBJECT_ID('bronze.ecom_orderItems', 'U') IS NOT NULL
    DROP TABLE bronze.ecom_orderItems;
CREATE TABLE bronze.ecom_orderItems (
    order_id       NVARCHAR(20),
    line_item_id   NVARCHAR(20),
    product_id     NVARCHAR(20),
    quantity       NVARCHAR(10),
    price          DECIMAL(10,2),
    discount_pct   INT
);
GO

IF OBJECT_ID('bronze.ecom_orders', 'U') IS NOT NULL
    DROP TABLE bronze.ecom_orders;
CREATE TABLE bronze.ecom_orders (
    order_id            NVARCHAR(20),
    customer_id         NVARCHAR(20),
    order_placed_at     DATETIMEOFFSET(7),
    fulfillment_status  NVARCHAR(20),
    payment_gateway     NVARCHAR(20),
    discount_code       NVARCHAR(20),
    shipping_cost       DECIMAL(10,2),
    currency            NVARCHAR(10)
);
GO

IF OBJECT_ID('bronze.pos_orderItems', 'U') IS NOT NULL
    DROP TABLE bronze.pos_orderItems;
CREATE TABLE bronze.pos_orders (
    transaction_id        NVARCHAR(20),
    store_id              NVARCHAR(10),
    register_id           NVARCHAR(10),
    cashier_id            NVARCHAR(10),
    transaction_datetime  DATETIME2(7),
    tender_type           NVARCHAR(20),
    order_status          NVARCHAR(20),
    loyalty_customer_id   NVARCHAR(20),
    discount_code         NVARCHAR(20)
);
GO

IF OBJECT_ID('bronze.pos_orderItems', 'U') IS NOT NULL
    DROP TABLE bronze.pos_orderItems;
CREATE TABLE bronze.pos_orderItems (
    transaction_id        NVARCHAR(20),
    line_no               SMALLINT,
    sku                   NVARCHAR(20),
    qty                   SMALLINT,
    unit_price            DECIMAL(10,2),
    discount_amt          INT
);
GO