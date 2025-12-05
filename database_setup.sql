-- SQL Masterclass: Logistics and Supply Chain - Database Setup

-- This file contains the complete SQL code to create the necessary tables
-- and populate them with mock data for the challenges.

-----------------------------------------------------
-- 1. SCHEMA CREATION
-----------------------------------------------------

-- 1. Warehouses Table
CREATE TABLE Warehouses (
    warehouse_id INTEGER PRIMARY KEY,
    warehouse_name VARCHAR(100),
    region VARCHAR(50)
);

-- 2. Inventory Table (Many-to-Many via warehouse_id)
CREATE TABLE Inventory (
    inventory_id INTEGER PRIMARY KEY,
    warehouse_id INTEGER REFERENCES Warehouses(warehouse_id),
    product_name VARCHAR(100),
    stock_level INTEGER,
    reorder_threshold INTEGER
);

-- 3. Routes Table
CREATE TABLE Routes (
    route_id VARCHAR(10) PRIMARY KEY,
    start_city VARCHAR(50),
    end_city VARCHAR(50),
    distance_km DECIMAL(10, 2)
);

-- 4. Shipments Table (Actual deliveries)
CREATE TABLE Shipments (
    shipment_id INTEGER PRIMARY KEY,
    route_id VARCHAR(10) REFERENCES Routes(route_id),
    warehouse_id INTEGER REFERENCES Warehouses(warehouse_id),
    shipment_date DATE,
    actual_delivery_date DATE,
    status VARCHAR(20) -- e.g., 'Delivered', 'In Transit', 'Delayed'
);

-----------------------------------------------------
-- 2. MOCK DATA INSERTION
-----------------------------------------------------

-- Mock Data for Warehouses
INSERT INTO Warehouses (warehouse_id, warehouse_name, region) VALUES
(1, 'Central Hub A', 'North'),
(2, 'Regional Depot B', 'South'),
(3, 'Coastal Facility C', 'West');

-- Mock Data for Inventory
INSERT INTO Inventory (inventory_id, warehouse_id, product_name, stock_level, reorder_threshold) VALUES
(101, 1, 'Widget X', 500, 100), -- Central Hub
(102, 1, 'Gadget Y', 80, 150),  -- Central Hub (Below threshold)
(103, 2, 'Widget X', 200, 150), -- Regional Depot
(104, 2, 'Unit Z', 50, 75),     -- Regional Depot (Below threshold)
(105, 3, 'Gadget Y', 300, 100); -- Coastal Facility

-- Mock Data for Routes
INSERT INTO Routes (route_id, start_city, end_city, distance_km) VALUES
('R100', 'New York', 'Boston', 350.50),
('R200', 'Dallas', 'Houston', 380.00),
('R300', 'LA', 'San Diego', 190.25);

-- Mock Data for Shipments
INSERT INTO Shipments (shipment_id, route_id, warehouse_id, shipment_date, actual_delivery_date, status) VALUES
(10001, 'R100', 1, '2023-11-01', '2023-11-02', 'Delivered'), -- North
(10002, 'R200', 2, '2023-11-05', '2023-11-08', 'Delayed'),   -- South (3 days)
(10003, 'R100', 1, '2023-11-10', '2023-11-11', 'Delivered'), -- North
(10004, 'R300', 3, '2023-11-15', '2023-11-16', 'Delivered'), -- West
(10005, 'R200', 2, '2023-11-20', '2023-11-21', 'Delivered'), -- South
(10006, 'R100', 1, '2023-11-25', '2023-11-28', 'Delayed'),   -- North (3 days)
(10007, 'R300', 3, '2023-12-01', '2023-12-02', 'Delivered'); -- West
