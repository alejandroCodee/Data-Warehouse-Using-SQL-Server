-- Drop CRM Customer Info staging table if it exists
IF OBJECT_ID('silver.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_cust_info;

-- Customer information cleaned and standardized for silver layer
CREATE TABLE silver.crm_cust_info (
    cst_id             INT,                 -- Customer ID (possibly surrogate or natural key)
    cst_key            NVARCHAR(50),        -- Business key across systems
    cst_firstname      NVARCHAR(50), 
    cst_lastname       NVARCHAR(50), 
    cst_marital_status NVARCHAR(50), 
    cst_gndr           NVARCHAR(50), 
    cst_create_date    DATE,                -- Original CRM creation date
    dwh_create_date    DATETIME2 DEFAULT GETDATE()  -- Timestamp of load into DWH
);

-- Drop Product Info table if it exists
IF OBJECT_ID('silver.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE silver.crm_prd_info;

-- Product master table for CRM cleaned version
CREATE TABLE silver.crm_prd_info (
    prd_id         INT, 
    prd_key        NVARCHAR(50), 
    prd_nm         NVARCHAR(50), 
    prd_cost       INT,                     -- Consider using DECIMAL for cost
    prd_line       NVARCHAR(50), 
    prd_start_dt   DATETIME, 
    prd_end_dt     DATETIME, 
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Drop Sales Details table if it exists
IF OBJECT_ID('silver.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE silver.crm_sales_details;

-- CRM sales transactional data cleaned version
CREATE TABLE silver.crm_sales_details (
    sls_ord_num   NVARCHAR(50),             -- Order number
    sls_prd_key   NVARCHAR(50),             -- Product business key
    sls_cust_id   INT,                      -- Customer ID
    sls_order_dt  INT,                      -- Consider converting to proper DATE or DATETIME
    sls_ship_dt   INT,
    sls_due_dt    INT,
    sls_sales     INT,                      -- Total amount (consider using DECIMAL)
    sls_quantity  INT, 
    sls_price     INT,                      -- Unit price
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Drop ERP location table if it exists
IF OBJECT_ID('silver.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE silver.erp_loc_a101;

-- ERP location master table (e.g., country mapping)
CREATE TABLE silver.erp_loc_a101 (
    cid             NVARCHAR(50), 
    cntry           NVARCHAR(50),           -- Country code or name
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Drop ERP customer demographics table if it exists
IF OBJECT_ID('silver.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE silver.erp_cust_az12;

-- Additional customer demographics from ERP system
CREATE TABLE silver.erp_cust_az12 (
    cid             NVARCHAR(50),           -- Customer ID reference
    bdate           DATE,                   -- Birth date
    gen             NVARCHAR(50),           -- Gender
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);

-- Drop ERP product categorization table if it exists
IF OBJECT_ID('silver.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE silver.erp_px_cat_g1v2;

-- Product category hierarchy and maintenance tagging
CREATE TABLE silver.erp_px_cat_g1v2 (
    id              NVARCHAR(50),           -- ID for product or category
    cat             NVARCHAR(50),           -- Main category
    subcat          NVARCHAR(50),           -- Subcategory
    maintenance     NVARCHAR(50),           -- Maintenance tag (e.g., active/inactive)
    dwh_create_date DATETIME2 DEFAULT GETDATE()
);
