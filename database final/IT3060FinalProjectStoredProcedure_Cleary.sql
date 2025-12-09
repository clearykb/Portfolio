USE AutoService_Cleary;
GO

IF OBJECT_ID('dbo.usp_GetCustomerOrdersByStatus', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_GetCustomerOrdersByStatus;
GO

CREATE PROCEDURE dbo.usp_GetCustomerOrdersByStatus
    @CustomerLastName NVARCHAR(50),
    @Status           NVARCHAR(20)
AS
BEGIN
    SET NOCOUNT ON;

    --------------------------------------------------------
    -- Decision logic: validate parameters
    --------------------------------------------------------
    IF @CustomerLastName IS NULL OR LTRIM(RTRIM(@CustomerLastName)) = ''
    BEGIN
        PRINT 'Customer last name is required.';
        RETURN;
    END

    IF @Status NOT IN ('Open', 'Completed', 'Cancelled')
    BEGIN
        PRINT 'Status must be Open, Completed, or Cancelled.';
        RETURN;
    END

    --------------------------------------------------------
    -- Main query: return matching service orders
    --------------------------------------------------------
    SELECT
        c.FirstName,
        c.LastName,
        so.ServiceOrderID,
        so.ServiceDate,
        so.Status,
        so.LaborTotal,
        so.PartsTotal,
        (so.LaborTotal + so.PartsTotal) AS OrderTotal,
        v.Make,
        v.Model,
        v.[Year],
        v.LicensePlate
    FROM dbo.Customers c
    INNER JOIN dbo.Vehicles v
        ON c.CustomerID = v.CustomerID
    INNER JOIN dbo.ServiceOrders so
        ON v.VehicleID = so.VehicleID
    WHERE c.LastName = @CustomerLastName
      AND so.Status   = @Status
    ORDER BY so.ServiceDate DESC, so.ServiceOrderID DESC;
END;
GO
