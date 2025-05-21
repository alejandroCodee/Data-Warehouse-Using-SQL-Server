-- Drop the customer dimension view if it already exists
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
    DROP VIEW gold.dim_customers;
GO 

-- Create the Customer Dimension View
-- Enriches CRM data with ERP info (e.g., country, birthdate, gender)
CREATE VIEW gold.dim_customers AS 
SELECT 
    ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,  -- Surrogate key for dimensional model
    ci.cst_id AS customer_id,                              -- Source system customer ID
    ci.cst_key AS customer_number,                         -- Business key used across systems
    ci.cst_firstname AS first_name, 
    ci.cst_lastname AS last_name, 
    la.cntry AS country,                                   -- Country info from ERP
    ci.cst_marital_status AS marital_status, 
    -- Use gender from CRM when available, fallback to ERP gender otherwise
    CASE 
        WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr         
        ELSE COALESCE(ca.gen, 'n/a')
    END AS gender,                                         
    ca.bdate AS birthdate,                                 -- Birthdate from ERP
    ci.cst_create_date AS create_date                      -- Creation date from CRM
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
    ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
    ON ci.cst_key = la.cid;
GO


-- Drop the product dimension view if it already exists
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
    DROP VIEW gold.dim_products;
GO

-- Create the Product Dimension View
-- Combines CRM product info with ERP product categorization
CREATE VIEW gold.dim_product AS 
SELECT 
    ROW_NUMBER() OVER (ORDER BY pn.prd_start_dt, pn.prd_key) AS product_key,  -- Surrogate key
    pn.prd_id AS product_id,                       -- Source system product ID
    pn.prd_key AS product_number,                  -- Business product key
    pn.prd_nm AS product_name,                     -- Name of the product
    pn.cat_id AS category,                         -- Reference to category ID
    pc.cat AS subcategory,                         -- Main category (renamed as subcategory in logic)
    pc.subcat,                                     -- Subcategory from ERP
    pc.maintenance,                                -- Maintenance classification
    pn.prd_cost AS cost,                           -- Cost of product
    pn.prd_line AS product_line,                   -- Product line/category
    pn.prd_start_dt AS start_date                  -- Availability start date
FROM silver.crm_prd_info pn
LEFT JOIN silver.erp_px_cat_g1v2 pc
    ON pn.cat_id = pc.id
WHERE prd_end_dt IS NULL;                          -- Exclude inactive/historical products
GO 


-- Drop the sales fact view if it already exists
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
    DROP VIEW gold.fact_sales;
GO

-- Create the Sales Fact View
-- Combines sales transactions with dimension lookups
CREATE VIEW gold.fact_sales AS 
SELECT
    sd.sls_ord_num AS order_number,                -- Order identifier
    pr.product_key,                                -- Surrogate product key from dim_product
    cu.customer_key,                               -- Surrogate customer key from dim_customers
    sd.sls_order_dt AS order_date, 
    sd.sls_ship_dt AS shipping_date,
    sd.sls_due_dt AS due_date,
    sd.sls_sales AS sales_amount,                  -- Total amount of sale
    sd.sls_quantity AS quantity,                   -- Number of items sold
    sd.sls_price AS price                          -- Price per unit
FROM silver.crm_sales_details sd
LEFT JOIN gold.dim_product pr
    ON sd.sls_prd_key = pr.product_number
LEFT JOIN gold.dim_customers cu 
    ON sd.sls_cust_id = cu.customer_id;
GO
