------------------------------------------------------------
-- IT3060 Final Project - Create Database and Tables
-- Student: Cleary
------------------------------------------------------------

-- 1. Create the database
IF DB_ID('AutoService_Cleary') IS NULL
BEGIN
    CREATE DATABASE AutoService_Cleary;
END
GO

-- 2. Use the new database
USE AutoService_Cleary;
GO

------------------------------------------------------------
-- 3. Create Customers table
------------------------------------------------------------
IF OBJECT_ID('dbo.Customers', 'U') IS NOT NULL
    DROP TABLE dbo.Customers;
GO

CREATE TABLE dbo.Customers
(
    CustomerID      INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    FirstName       NVARCHAR(50)  NOT NULL,
    LastName        NVARCHAR(50)  NOT NULL,
    Phone           NVARCHAR(20)  NOT NULL,
    Email           NVARCHAR(100) NULL,
    StreetAddress   NVARCHAR(100) NOT NULL,
    City            NVARCHAR(50)  NOT NULL,
    [State]         NVARCHAR(2)   NOT NULL,
    ZipCode         NVARCHAR(10)  NOT NULL,
    DateCreated     DATETIME      NOT NULL DEFAULT(GETDATE())
);
GO

------------------------------------------------------------
-- 4. Create Vehicles table
------------------------------------------------------------
IF OBJECT_ID('dbo.Vehicles', 'U') IS NOT NULL
    DROP TABLE dbo.Vehicles;
GO

CREATE TABLE dbo.Vehicles
(
    VehicleID       INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    CustomerID      INT           NOT NULL,
    VIN             NVARCHAR(17)  NOT NULL,
    Make            NVARCHAR(50)  NOT NULL,
    Model           NVARCHAR(50)  NOT NULL,
    [Year]          INT           NOT NULL,
    LicensePlate    NVARCHAR(15)  NULL,
    Color           NVARCHAR(30)  NULL
);

ALTER TABLE dbo.Vehicles
ADD CONSTRAINT FK_Vehicles_Customers
    FOREIGN KEY (CustomerID)
    REFERENCES dbo.Customers(CustomerID);
GO

------------------------------------------------------------
-- 5. Create ServiceOrders table
------------------------------------------------------------
IF OBJECT_ID('dbo.ServiceOrders', 'U') IS NOT NULL
    DROP TABLE dbo.ServiceOrders;
GO

CREATE TABLE dbo.ServiceOrders
(
    ServiceOrderID  INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    VehicleID       INT           NOT NULL,
    ServiceDate     DATE          NOT NULL,
    Odometer        INT           NULL,
    Status          NVARCHAR(20)  NOT NULL DEFAULT('Open'),
    LaborTotal      DECIMAL(10,2) NOT NULL DEFAULT(0),
    PartsTotal      DECIMAL(10,2) NOT NULL DEFAULT(0),
    Notes           NVARCHAR(500) NULL
);

ALTER TABLE dbo.ServiceOrders
ADD CONSTRAINT FK_ServiceOrders_Vehicles
    FOREIGN KEY (VehicleID)
    REFERENCES dbo.Vehicles(VehicleID);
GO

ALTER TABLE dbo.ServiceOrders
ADD CONSTRAINT CK_ServiceOrders_Status
CHECK (Status IN ('Open', 'Completed', 'Cancelled'));
GO

------------------------------------------------------------
-- 6. Create ServiceItems table
------------------------------------------------------------
IF OBJECT_ID('dbo.ServiceItems', 'U') IS NOT NULL
    DROP TABLE dbo.ServiceItems;
GO

CREATE TABLE dbo.ServiceItems
(
    ServiceItemID   INT IDENTITY(1,1) NOT NULL PRIMARY KEY,
    ServiceOrderID  INT           NOT NULL,
    Description     NVARCHAR(200) NOT NULL,
    LaborHours      DECIMAL(5,2)  NOT NULL DEFAULT(0),
    LaborRate       DECIMAL(10,2) NOT NULL DEFAULT(0),
    PartsCost       DECIMAL(10,2) NOT NULL DEFAULT(0),

    LineTotal       AS (LaborHours * LaborRate + PartsCost) PERSISTED
);

ALTER TABLE dbo.ServiceItems
ADD CONSTRAINT FK_ServiceItems_ServiceOrders
    FOREIGN KEY (ServiceOrderID)
    REFERENCES dbo.ServiceOrders(ServiceOrderID);
GO
