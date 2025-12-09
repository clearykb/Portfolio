USE AutoService_Cleary;
GO

IF OBJECT_ID('dbo.vw_CustomerSpendingSummary', 'V') IS NOT NULL
    DROP VIEW dbo.vw_CustomerSpendingSummary;
GO

CREATE VIEW dbo.vw_CustomerSpendingSummary
AS
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COUNT(DISTINCT so.ServiceOrderID) AS ServiceOrderCount,
    SUM(ISNULL(so.LaborTotal,0) + ISNULL(so.PartsTotal,0)) AS TotalAmountSpent
FROM dbo.Customers c
LEFT JOIN dbo.Vehicles v
    ON c.CustomerID = v.CustomerID
LEFT JOIN dbo.ServiceOrders so
    ON v.VehicleID = so.VehicleID
GROUP BY
    c.CustomerID, c.FirstName, c.LastName;
GO
