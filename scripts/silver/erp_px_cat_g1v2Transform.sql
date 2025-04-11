/*
After DDL script for silver layer run this script to transform and load silver table named "silver.erp_px_cat_g1v2".
Here we are transorming table "bronze.erp_px_cat_g1v2" from bronze layer into a table "silver.erp_px_cat_g1v2" that we need for silver layer.
*/

INSERT INTO silver.erp_px_cat_g1v2 (
	id,
	cat,
	subcat,
	maintenance
)

SELECT
id,
cat,
subcat,
maintenance
FROM bronze.erp_px_cat_g1v2
