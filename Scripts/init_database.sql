/*==============================================================
    Create Database: DataWarehouse
    Description: Creates the DataWarehouse database and
                 Bronze, Silver, and Gold schemas if they
                 do not already exist.
==============================================================*/

USE master;
GO

-- Create the database only if it does not already exist
IF NOT EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'DataWarehouse'
)
BEGIN
    CREATE DATABASE DataWarehouse;
    PRINT 'Database [DataWarehouse] created successfully.';
END
ELSE
BEGIN
    PRINT 'Database [DataWarehouse] already exists.';
END
GO


/*==============================================================
    Create Schemas
==============================================================*/

USE DataWarehouse;
GO

-- Create Bronze Schema
IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'Bronze'
)
BEGIN
    EXEC('CREATE SCHEMA Bronze');
    PRINT 'Schema [Bronze] created successfully.';
END
ELSE
BEGIN
    PRINT 'Schema [Bronze] already exists.';
END
GO


-- Create Silver Schema
IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'Silver'
)
BEGIN
    EXEC('CREATE SCHEMA Silver');
    PRINT 'Schema [Silver] created successfully.';
END
ELSE
BEGIN
    PRINT 'Schema [Silver] already exists.';
END
GO


-- Create Gold Schema
IF NOT EXISTS (
    SELECT 1
    FROM sys.schemas
    WHERE name = 'Gold'
)
BEGIN
    EXEC('CREATE SCHEMA Gold');
    PRINT 'Schema [Gold] created successfully.';
END
ELSE
BEGIN
    PRINT 'Schema [Gold] already exists.';
END
GO
