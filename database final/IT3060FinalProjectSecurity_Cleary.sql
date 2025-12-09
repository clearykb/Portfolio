------------------------------------------------------------
-- IT3060 Final Project - Security Plan
-- Student: Cleary
-- This script creates:
-- 1. SQL Server Login
-- 2. Database User
-- 3. GRANT permissions
-- 4. REVOKE permissions
------------------------------------------------------------

-----------------------------
-- 1. Create a server login
-----------------------------
-- NOTE: Replace 'StrongPassword123!' with any password your SQL Server allows
CREATE LOGIN AutoServiceUser_Cleary
WITH PASSWORD = 'StrongPassword123!';
GO

------------------------------------------------------------
-- 2. Create a database user for this login
------------------------------------------------------------
USE AutoService_Cleary;
GO

CREATE USER AutoServiceUser_Cleary
FOR LOGIN AutoServiceUser_Cleary;
GO

------------------------------------------------------------
-- 3. GRANT read-only permissions to a specific object
-- Example: Grant SELECT permission on Customers table
------------------------------------------------------------
GRANT SELECT ON dbo.Customers TO AutoServiceUser_Cleary;
GO

------------------------------------------------------------
-- 4. REVOKE permissions (demonstration)
-- Example: Remove the SELECT permission
------------------------------------------------------------
REVOKE SELECT ON dbo.Customers FROM AutoServiceUser_Cleary;
GO

PRINT 'Security script executed successfully.';
