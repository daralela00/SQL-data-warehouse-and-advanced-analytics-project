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

-- Data standardization and consistency

SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

-- Check for invalidate date orders

SELECT *
FROM bronze.crm_prd_info
where prd_end_dt < prd_start_dt
  
-- Checking whole table 
SELECT * FROM silver.crm_cust_info
