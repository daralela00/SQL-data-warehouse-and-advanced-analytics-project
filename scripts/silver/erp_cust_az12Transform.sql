/*
After DDL script for silver layer run this script to transform and load silver table named "silver.erp_cust_az12".
Here we are transorming table "bronze.erp_cust_az12" from bronze layer into a table "silver.erp_cust_az12" that we need for silver layer.
*/

TRUNCATE TABLE silver.erp_cust_az12;

INSERT INTO  silver.erp_cust_az12 (
	cid,
	bdate,
	gen
)

SELECT
CASE WHEN cid LIKE 'NAS%' THEN SUBSTRING(cid, 4, LEN(cid))
	 ELSE cid
END AS cid,
CASE WHEN bdate > GETDATE() THEN NULL
	 ELSE bdate
END AS bdate,
CASE WHEN UPPER(TRIM(gen)) IN ('F', 'FEMALE') THEN 'Female'
	 WHEN UPPER(TRIM(gen)) IN ('M', 'MALE') THEN 'Male'
	 ELSE 'n/a'
END AS gen
FROM bronze.erp_cust_az12
