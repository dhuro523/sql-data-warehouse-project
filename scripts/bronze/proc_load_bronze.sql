exec bronze.load_bronze

create or alter procedure bronze.load_bronze as
begin
	declare @start_time datetime, @end_time datetime, @batch_start_time datetime, @batch_end_time datetime;
	begin try
		print'===========================';
		print 'Loading Broze Layer';
		print'===========================';

		print'===========================';
		print'Loading CRM Tabels'
		print'===========================';

-- First Table =======================================================================
		set @start_time = getdate();
		print '>> Truncating Table: bronze.crm_cust_info ';
		truncate table bronze.crm_cust_info;

		print'>> Inserting Data Into Table: bronze.crm_cust_info';
		bulk insert bronze.crm_cust_info
		from 'C:\warehouse\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' + cast( datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';

-- End First Table ======================================================================

-- Second table ============================================================================

		set @start_time = getdate();
		print '>> Truncating Table: bronze.crm_prd_info ';
		truncate table bronze.crm_prd_info;

		print'>> Inserting Data Into Table: bronze.crm_prd_info';
		bulk insert bronze.crm_prd_info
		from 'C:\warehouse\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' + cast( datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';

-- End Second Table ======================================================================


-- Third Table ======================================================================


		set @start_time = getdate();

		print '>> Truncating Table: bronze.crm_sales_details ';
		truncate table bronze.crm_sales_details;

		print'>> Inserting Data Into Table: bronze.crm_sales_details';
		bulk insert bronze.crm_sales_details
		from 'C:\warehouse\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' + cast( datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';

-- End Third Table ======================================================================

-- Fourth Table ======================================================================


		print'===========================';
		print'Loading ERP Tabels'
		print'===========================';

		set @start_time = getdate();

		print '>> Truncating Table: bronze.erp_loc_a101 ';
		truncate table bronze.erp_loc_a101;

		print'>> Inserting Data Into Table: bronze.erp_loc_a101';
		bulk insert bronze.erp_loc_a101
		from 'C:\warehouse\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' + cast( datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';

-- End Fourth Table ======================================================================


-- Fitht Table ======================================================================

		set @start_time = getdate();
		print '>> Truncating Table: bronze.erp_cust_az12 ';
		truncate table bronze.erp_cust_az12;

		print'>> Inserting Data Into Table: bronze.erp_cust_az12';
		bulk insert bronze.erp_cust_az12
		from 'C:\warehouse\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' + cast( datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';

-- End fifth Table ======================================================================


-- Sixth Table ======================================================================

		set @start_time = getdate();
		print '>> Truncating Table: bronze.erp_px_cat_g1v2 ';
		truncate table bronze.erp_px_cat_g1v2;

		print'>> Inserting Data Into Table: bronze.erp_px_cat_g1v2';
		bulk insert bronze.erp_px_cat_g1v2
		from 'C:\warehouse\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		with (
			firstrow = 2,
			fieldterminator = ',',
			tablock
		);
		set @end_time = getdate();
		print'>> Load Duration: ' + cast( datediff(second, @start_time, @end_time) as nvarchar) + ' seconds';

-- End sixth Table ======================================================================
	
	set @batch_end_time = getdate();
	print 'Loading Bronze Layer'
	print ' - Toatal load duration: ' + cast(datediff(second, @batch_start_time, @batch_end_time) as nvarchar) + ' seconds'
	end try
	begin catch
		print '=============='
		print ' Error Occured During Bronze Layer'
		print 'Error Message' + Error_Message();
		print 'Error Message' + cast(Error_Number() as varchar)
		print '=============='
	end catch
end
