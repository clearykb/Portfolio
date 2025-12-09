USE AutoService_Cleary;
GO

------------------------------------------------------------
-- Insert Customers (5 records)
------------------------------------------------------------
INSERT INTO dbo.Customers
    (FirstName, LastName, Phone, Email, StreetAddress, City, [State], ZipCode)
VALUES
    ('John',  'Smith',   '555-111-2222', 'john.smith@example.com',  '101 Main St',   'Cincinnati', 'OH', '45224'),
    ('Maria', 'Lopez',   '555-222-3333', 'maria.lopez@example.com', '22 Oak Ave',    'Cincinnati', 'OH', '45211'),
    ('David', 'Johnson', '555-333-4444', 'david.j@example.com',     '890 Pine Rd',   'Colerain',   'OH', '45239'),
    ('Emily', 'Davis',   '555-444-5555', 'emily.d@example.com',     '45 Maple Dr',   'Fairfield',  'OH', '45014'),
    ('Chris', 'Brown',   '555-555-6666', 'chris.b@example.com',     '77 River Way',  'Hamilton',   'OH', '45011');
GO

------------------------------------------------------------
-- Insert Vehicles (5 records)
-- Assumes CustomerID values 1-5 match the inserts above
------------------------------------------------------------
INSERT INTO dbo.Vehicles
    (CustomerID, VIN, Make, Model, [Year], LicensePlate, Color)
VALUES
    (1, '1FAFP404X1F123456', 'Ford',       'Focus',    2012, 'ABC123', 'Blue'),
    (2, '2G1WF52E859123456', 'Chevrolet',  'Impala',   2015, 'XYZ789', 'Silver'),
    (3, 'ZARFAEEN0H1234567', 'Alfa Romeo', 'Giulia',   2017, 'GIULIA', 'Red'),
    (4, '1HGCM82633A123456', 'Honda',      'Accord',   2010, 'HONDA1', 'Black'),
    (5, '1J4FA49S54P123456', 'Jeep',       'Wrangler', 2018, 'JEEP4X4','Green');
GO

------------------------------------------------------------
-- Insert ServiceOrders (5 records)
-- Assumes VehicleID 1-5 exist
------------------------------------------------------------
INSERT INTO dbo.ServiceOrders
    (VehicleID, ServiceDate, Odometer, Status, LaborTotal, PartsTotal, Notes)
VALUES
    (1, '2025-03-01', 120000, 'Completed', 120.00,  80.00,  'Oil change and tire rotation'),
    (2, '2025-03-05',  90000, 'Completed', 200.00, 150.00, 'Brake pads and rotors'),
    (3, '2025-03-10',  65000, 'Completed', 250.00, 200.00, 'Coolant leak diagnosis and repair'),
    (4, '2025-03-15', 150000, 'Open',       0.00,   0.00,  'Check engine light on'),
    (5, '2025-03-20',  50000, 'Completed', 180.00, 120.00, 'Transmission service');
GO

------------------------------------------------------------
-- Insert ServiceItems (7 records total, linked to orders 1–5)
------------------------------------------------------------
INSERT INTO dbo.ServiceItems
    (ServiceOrderID, Description, LaborHours, LaborRate, PartsCost)
VALUES
    (1, 'Oil change',                   0.5,  90.00, 30.00),
    (1, 'Tire rotation',                0.7,  90.00,  0.00),
    (2, 'Front brake pads and rotors',  1.5,  95.00, 200.00),
    (3, 'Coolant leak diagnosis',       1.0, 100.00,  0.00),
    (3, 'Replace coolant hose',         0.8, 100.00, 80.00),
    (4, 'Diagnostic for check engine',  1.0,  95.00,  0.00),
    (5, 'Transmission fluid service',   1.2, 110.00,120.00);
GO
