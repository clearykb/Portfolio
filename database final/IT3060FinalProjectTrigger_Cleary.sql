USE AutoService_Cleary;
GO

IF OBJECT_ID('dbo.trg_ServiceItems_RecalculateTotals', 'TR') IS NOT NULL
    DROP TRIGGER dbo.trg_ServiceItems_RecalculateTotals;
GO

CREATE TRIGGER dbo.trg_ServiceItems_RecalculateTotals
ON dbo.ServiceItems
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    --------------------------------------------------------
    -- Identify which ServiceOrderID values were affected
    --------------------------------------------------------
    ;WITH ChangedOrders AS
    (
        SELECT DISTINCT ServiceOrderID FROM inserted
        UNION
        SELECT DISTINCT ServiceOrderID FROM deleted
    )
    UPDATE so
    SET
        LaborTotal = ISNULL(s.LaborTotal, 0),
        PartsTotal = ISNULL(s.PartsTotal, 0)
    FROM dbo.ServiceOrders so
    INNER JOIN ChangedOrders co
        ON so.ServiceOrderID = co.ServiceOrderID
    OUTER APPLY
    (
        SELECT
            SUM(si.LaborHours * si.LaborRate) AS LaborTotal,
            SUM(si.PartsCost)                 AS PartsTotal
        FROM dbo.ServiceItems si
        WHERE si.ServiceOrderID = co.ServiceOrderID
    ) s;

    PRINT 'Trigger trg_ServiceItems_RecalculateTotals executed and recalculated order totals.';
END;
GO
