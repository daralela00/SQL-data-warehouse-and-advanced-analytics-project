/*
Quality chekcs for silver layer.
*/

-- Check for Nulls or duplicates
-- Here we expect no results

Select
cst_id,
COUNT (*)
FROM silver.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL

-- Checking unwatned Spaces
-- Here we expect no results

SELECT cst_lastname
FROM silver.crm_cust_info
WHERE cst_lastname != TRIM(cst_lastname)

-- Check for Nulls or negative numbers
-- We expect no results here

SELECT prd_key
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data standardization and consistency

SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

-- Check for invalidate date orders

SELECT *
FROM bronze.crm_prd_info
where prd_end_dt < prd_start_dt

-- Check for invalid dates

SELECT
NULLIF(sls_order_dt, 0) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0
OR LEN(sls_order_dt) != 8
OR sls_order_dt > 20500101
OR sls_order_dt < 19000101

-- Check for invalid date orders

SELECT
*
FROM bronze.crm_sales_details
WHERE sls_order_dt > sls_ship_dt OR sls_order_dt > sls_due_dt

-- Checking data consistency: Between sales, quantity and price
-- sales = quantity * price
-- values must not be NULL, zero or negative

SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM bronze.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 OR sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price

-- Check out of range dates

SELECT DISTINCT
bdate
FROM bronze.erp_cust_az12
WHERE bdate < '1925-01-01' OR bdate > GETDATE()
  
-- Checking whole table 
SELECT * FROM silver.crm_cust_info
