EXEC bronze.load_bronze;

-- CREATION OF STORED PROCEDURE SINCE THIS IS A COMMON QUERY
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
	BEGIN 
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY 
	
	SET @batch_start_time = GETDATE();
	PRINT '==============================================';
	PRINT 'Loading Bronze Layer';
	PRINT '==============================================';

	PRINT '----------------------------------------------';
	PRINT 'Loading CRM Tables';
	PRINT '----------------------------------------------';

	SET @start_time = GETDATE();
	-- WE DELETE THE TABLE CONTENT BEFORE INSERTING ANOTHER TIME (avoiding duplicates)
	PRINT '>> Truncating Table: bronze.crm_cust_info';
	TRUNCATE TABLE bronze.crm_cust_info;

	PRINT '>> Inserting Data Into Table: bronze.crm_cust_info';
	-- INSERT OF BIG AMOUNT OF DATA
	BULK INSERT bronze.crm_cust_info

	-- WE SPECIFIED THE PATH OF THE CSV FILE
	FROM 'C:\Users\Admin\Documents\CARRERA\PORTFOLIO\Data-Warehouse-Using-SQL-Server\datasets\source_crm\cust_info.csv'

	-- ADD SOME SPECIFICATIONS OF THE SOURCE
	WITH (
		-- ACTUAL DATA STARTS IN THE SECOND ROW
		FIRSTROW = 2,
		-- THE DATA USE , AS A DELIMITER
		FIELDTERMINATOR = ',',
		-- DURING THE OPERATION THE TABLE GETS LOCK (for performance)
		TABLOCK 
	);
	SET @end_time = GETDATE();
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> -------------'

	-- WE REPEAT THESE QUERIES FOR ALL THE TABLES

	SET @start_time = GETDATE();
	PRINT '>> Truncating Table: bronze.crm_prd_info';
	TRUNCATE TABLE bronze.crm_prd_info;
	PRINT '>> Inserting Data Into Table: bronze.crm_prd_info';
	BULK INSERT bronze.crm_prd_info
	FROM 'C:\Users\Admin\Documents\CARRERA\PORTFOLIO\Data-Warehouse-Using-SQL-Server\datasets\source_crm\prd_info.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
	);
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> -------------'


	SET @start_time = GETDATE();
	PRINT '>> Truncating Table: bronze.crm_sales_details';
	TRUNCATE TABLE bronze.crm_sales_details;
	PRINT '>> Inserting Data Into Table: bronze.crm_sales_details';
	BULK INSERT bronze.crm_sales_details
	FROM 'C:\Users\Admin\Documents\CARRERA\PORTFOLIO\Data-Warehouse-Using-SQL-Server\datasets\source_crm\sales_details.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
	);
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> -------------'

	PRINT '----------------------------------------------';
	PRINT 'Loading ERP Tables';
	PRINT '----------------------------------------------';

	SET @start_time = GETDATE();
	PRINT '>> Truncating Table: bronze.erp_cust_az12';
	TRUNCATE TABLE bronze.erp_cust_az12;
	PRINT '>> Inserting Data Into Table: bronze.erp_cust_az12';
	BULK INSERT bronze.erp_cust_az12
	FROM 'C:\Users\Admin\Documents\CARRERA\PORTFOLIO\Data-Warehouse-Using-SQL-Server\datasets\source_erp\CUST_AZ12.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
	);
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> -------------'

	SET @start_time = GETDATE();
	PRINT '>> Truncating Table: bronze.erp_loc_a101';
	TRUNCATE TABLE bronze.erp_loc_a101;
	PRINT '>> Inserting Data Into Table: bronze.erp_loc_a101';
	BULK INSERT bronze.erp_loc_a101
	FROM 'C:\Users\Admin\Documents\CARRERA\PORTFOLIO\Data-Warehouse-Using-SQL-Server\datasets\source_erp\LOC_A101.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
	);
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> -------------'

	SET @start_time = GETDATE();
	PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
	TRUNCATE TABLE bronze.erp_px_cat_g1v2;
	PRINT '>> Inserting Data Into Table: bronze.erp_px_cat_g1v2';
	BULK INSERT bronze.erp_px_cat_g1v2
	FROM 'C:\Users\Admin\Documents\CARRERA\PORTFOLIO\Data-Warehouse-Using-SQL-Server\datasets\source_erp\PX_CAT_G1V2.csv'
	WITH (
		FIRSTROW = 2,
		FIELDTERMINATOR = ',',
		TABLOCK 
	);
	PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
	PRINT '>> -------------'
	
	SET @batch_end_time = GETDATE();
	PRINT '=================================================';
	PRINT 'Loading Bronze Layer is Completed';
	PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
	PRINT '=================================================';


	END TRY 
	BEGIN CATCH 
		PRINT '================================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '================================================='
	END CATCH
END