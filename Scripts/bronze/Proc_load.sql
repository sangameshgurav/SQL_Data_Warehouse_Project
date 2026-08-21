/* Purpose

This stored procedure is responsible for loading raw data from CRM and ERP CSV source files into the Bronze layer of the Data Warehouse.

It:

Truncates existing Bronze tables before loading fresh data.
Uses BULK INSERT to load CSV files efficiently.
Tracks individual table load duration and overall batch duration.
Displays progress and status messages during execution.
Uses TRY...CATCH to handle and report errors during the loading process.
*/

Create or Alter PROCEDURE Bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME,@start_batch_time DATETIME, @End_Batch_time DATETIME;
	BEGIN TRY
		SET @start_batch_time = GETDATE();
		Print'========================================================================================'
		Print 'Loading Bronze layer';
		Print'========================================================================================'



		Print'----------------------------------------------------------------------------------------'
		Print 'Loading CRM Section';
		Print'----------------------------------------------------------------------------------------'

		SET @start_time = GETDATE();
		Print '>> Truncating the table =Bronze.crm_cust_info >>';
		TRUNCATE TABLE Bronze.crm_cust_info;

		Print '>> Inserting the data into the table =Bronze.crm_cust_info >>';
		BULK INSERT Bronze.crm_cust_info
		FROM 'C:\Users\ADMIN\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH (
		Firstrow=2,
		FIELDTERMINATOR = ',',
		TABLOCK

		);
		
		SET @end_time = GETDATE();
		Print'>>Load duration: '+ CAST( DATEDIFF(SECOND,@Start_time,@end_time) AS NVARCHAR) +'Seconds';
		Print'----------------------------------------------------------------------------------------'


		SET @start_time = GETDATE();
		Print '>> Truncating the table =Bronze.crm_prod_info >>';
		TRUNCATE TABLE Bronze.crm_prod_info;

		Print '>> Inserting the data into the table =Bronze.crm_prod_info >>';
		BULK INSERT Bronze.crm_prod_info
		FROM 'C:\Users\ADMIN\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH (
		Firstrow=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		Print'>>Load duration: '+ CAST( DATEDIFF(SECOND,@Start_time,@end_time) AS NVARCHAR) +'Seconds';
		Print'----------------------------------------------------------------------------------------'



		SET @end_time = GETDATE();
		Print '>> Truncating the table =Bronze.crm_sales_details >>';
		TRUNCATE TABLE Bronze.crm_sales_details;

		Print '>> Inserting the data into the table =Bronze.crm_sales_details  >>';
		BULK INSERT Bronze.crm_sales_details
		FROM 'C:\Users\ADMIN\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH (
		Firstrow=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		SET @end_time = GETDATE();
		Print'>>Load duration: '+ CAST( DATEDIFF(SECOND,@Start_time,@end_time) AS NVARCHAR) +'Seconds';
		Print'----------------------------------------------------------------------------------------'



		Print'----------------------------------------------------------------------------------------'
		Print 'Loading ERP Section';
		Print'----------------------------------------------------------------------------------------'

		SET @end_time = GETDATE();
		Print '>> Truncating the table =Bronze.erp_cust_az12 >>';
		TRUNCATE TABLE Bronze.erp_cust_az12;

		Print '>> Inserting the data into the table =Bronze.erp_cust_az12 >>';
		BULK INSERT Bronze.erp_cust_az12
		FROM 'C:\Users\ADMIN\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH (
		Firstrow=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		SET @end_time = GETDATE();
		Print'>>Load duration: '+ CAST( DATEDIFF(SECOND,@Start_time,@end_time) AS NVARCHAR) +'Seconds';
		Print'----------------------------------------------------------------------------------------'


		SET @end_time = GETDATE();
		Print '>> Truncating the table =Bronze.erp_loc_a101 >>';
		TRUNCATE TABLE Bronze.erp_loc_a101;

		Print '>> Inserting the data into the table =Bronze.erp_loc_a101 >>';
		BULK INSERT Bronze.erp_loc_a101
		FROM 'C:\Users\ADMIN\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH (
		Firstrow=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);

		SET @end_time = GETDATE();
		Print'>>Load duration: '+ CAST( DATEDIFF(SECOND,@Start_time,@end_time) AS NVARCHAR) +'Seconds';
		Print'----------------------------------------------------------------------------------------'


		SET @end_time = GETDATE();
		Print '>> Truncating the table =Bronze.erp_px_cat_g1v1 >>';
		TRUNCATE TABLE Bronze.erp_px_cat_g1v1;

		Print '>> Inserting the data into the table =Bronze.erp_px_cat_g1v1>>';
		BULK INSERT Bronze.erp_px_cat_g1v1
		FROM 'C:\Users\ADMIN\Downloads\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH (
		Firstrow=2,
		FIELDTERMINATOR = ',',
		TABLOCK
		);
		SET @end_time = GETDATE();
		Print'>>Load duration: '+ CAST( DATEDIFF(SECOND,@Start_time,@end_time) AS NVARCHAR) +'Seconds';
		Print'----------------------------------------------------------------------------------------'
		SET @End_Batch_time = GETDATE();
		Print 'Loading Bronze Layer is Completed';	
		Print'>> Total Load duration: '+ CAST( DATEDIFF(SECOND,@Start_batch_time,@end_batch_time) AS NVARCHAR) +'Seconds';
		Print'----------------------------------------------------------------------------------------'


	END TRY
	BEGIN CATCH
		Print'----------------------------------------------------------------------------------------'
		Print 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		Print'ERROR MESSAGE'+ ERROR_MESSAGE();
		Print'ERROR MESSAGE'+ CAST(ERROR_MESSAGE() AS NVARCHAR);
		Print'ERROR MESSAGE'+ CAST(ERROR_STATE() AS NVARCHAR);	

		Print'----------------------------------------------------------------------------------------'

	END CATCH
END
