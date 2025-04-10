/*

Script purpose:
  Creating database named  "DataWarehouse" after checking if it already exists.
  If the database exists, it is dropped and recreated.
  It also creates schemes named "bronze", "silver", "gold".

Warning:
  Running this script will drop the entire 'DataWarehouse' database if it exists.

*/


USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

CREATE DATABASE DataWarehouse;

USE DataWarehouse;

CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
