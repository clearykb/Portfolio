USE AutoService_Cleary;
GO

IF OBJECT_ID('dbo.vw_RecentServiceOrders', 'V') IS NOT NULL
    DROP VIEW dbo.vw_RecentServiceOrders;
GO

CREATE VIEW dbo.vw_RecentServiceOrders
AS
SELECT TOP 100
    so.ServiceOrderID,
    so.ServiceDate,
    so.Status,
    c.FirstName + ' ' + c.LastName AS CustomerName,
    v.Make,
    v.Model,
    v.[Year],
    v.LicensePlate,
    so.LaborTotal,
    so.PartsTotal,
    (so.LaborTotal + so.PartsTotal) AS OrderTotal
FROM dbo.ServiceOrders so
INNER JOIN dbo.Vehicles v
    ON so.VehicleID = v.VehicleID
INNER JOIN dbo.Customers c
    ON v.CustomerID = c.CustomerID
ORDER BY so.ServiceDate DESC, so.ServiceOrderID DESC;
GO
