-- Check if the CRM Customer Info table exists in the 'bronze' schema and drop it if it does
IF OBJECT_ID('bronze.crm_cust_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_cust_info;
GO

-- Create a staging table for CRM Customer Information
-- This table holds basic customer attributes from the CRM system
CREATE TABLE bronze.crm_cust_info (
    cst_id INT,                         -- Customer ID (possibly surrogate or natural key)
    cst_key NVARCHAR(50),              -- Customer unique key used across systems
    cst_firstname NVARCHAR(50),        -- First name of the customer
    cst_lastname NVARCHAR(50),         -- Last name of the customer
    cst_marital_status NVARCHAR(50),   -- Marital status (e.g., single, married)
    cst_gndr NVARCHAR(50),             -- Gender (standardized if possible)
    cst_create_date DATE               -- Date when the customer was registered/created
);

-- Drop and recreate the CRM Product Information table
IF OBJECT_ID('bronze.crm_prd_info', 'U') IS NOT NULL
    DROP TABLE bronze.crm_prd_info;

-- Product master data from CRM, typically enriched with pricing and lifecycle info
CREATE TABLE bronze.crm_prd_info (
    prd_id       INT,                  -- Product ID
    prd_key      NVARCHAR(50),         -- Product key (possibly used in joins with sales)
    prd_nm       NVARCHAR(50),         -- Name of the product
    prd_cost     INT,                  -- Cost of the product (could be better as DECIMAL)
    prd_line     NVARCHAR(50),         -- Product line or category
    prd_start_dt DATETIME,             -- Product availability start date
    prd_end_dt   DATETIME              -- Product availability end date
);

-- Drop and recreate the CRM Sales Details table
IF OBJECT_ID('bronze.crm_sales_details', 'U') IS NOT NULL
    DROP TABLE bronze.crm_sales_details;

-- Sales transaction-level detail from CRM
-- Note: Consider converting dates to DATE or DATETIME instead of storing as INT
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num  NVARCHAR(50),         -- Sales order number
    sls_prd_key  NVARCHAR(50),         -- Product key (foreign key to product table)
    sls_cust_id  INT,                  -- Customer ID (foreign key to customer table)
    sls_order_dt INT,                  -- Order date (should ideally be DATE or DATETIME)
    sls_ship_dt  INT,                  -- Shipping date
    sls_due_dt   INT,                  -- Due date
    sls_sales    INT,                  -- Total sale amount
    sls_quantity INT,                  -- Quantity sold
    sls_price    INT                   -- Unit price at time of sale
);

-- Drop and recreate ERP Location Table (A101)
IF OBJECT_ID('bronze.erp_loc_a101', 'U') IS NOT NULL
    DROP TABLE bronze.erp_loc_a101;

-- Basic location mapping from ERP system
CREATE TABLE bronze.erp_loc_a101 (
    cid    NVARCHAR(50),               -- Customer or company ID
    cntry  NVARCHAR(50)                -- Country of residence or operation
);

-- Drop and recreate ERP Customer Attributes Table (AZ12)
IF OBJECT_ID('bronze.erp_cust_az12', 'U') IS NOT NULL
    DROP TABLE bronze.erp_cust_az12;

-- Supplemental customer info from ERP, such as birthdate and gender
CREATE TABLE bronze.erp_cust_az12 (
    cid    NVARCHAR(50),               -- Customer ID (used to join with CRM data)
    bdate  DATE,                       -- Birth date of the customer
    gen    NVARCHAR(50)                -- Gender (should be harmonized with CRM data)
);

-- Drop and recreate ERP Product Category Table (G1V2)
IF OBJECT_ID('bronze.erp_px_cat_g1v2', 'U') IS NOT NULL
    DROP TABLE bronze.erp_px_cat_g1v2;

-- Product category classification used in ERP
-- This can be useful for grouping and filtering products in reports
CREATE TABLE bronze.erp_px_cat_g1v2 (
    id           NVARCHAR(50),         -- Unique product or category ID
    cat          NVARCHAR(50),         -- Main category name
    subcat       NVARCHAR(50),         -- Subcategory for more granular grouping
    maintenance  NVARCHAR(50)          -- Maintenance category or tag (could relate to servicing)
);
