/*
After DDL script for silver layer run this script to transform and load silver table named "silver.erp_loc_a101".
Here we are transorming table "bronze.erp_loc_a101" from bronze layer into a table "silver.erp_loc_a101" that we need for silver layer.
*/

TRUNCATE TABLE silver.erp_loc_a101;

INSERT INTO silver.erp_loc_a101 (
	cid,
	cntry
)

SELECT
REPLACE(cid, '-', '') cid,
CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany'
	 WHEN TRIM(cntry) in ('US', 'USA') THEN 'United States'
	 WHEN TRIM(cntry) = '' OR cntry IS NULL THEN 'n/a'
	 ELSE cntry
END AS cntry
FROM bronze.erp_loc_a101
