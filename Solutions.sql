-- SQL Masterclass: Logistics and Supply Chain - Verified Solutions

-----------------------------------------------------
-- TIER 1: BEGINNER FUNDAMENTALS
-----------------------------------------------------

-- #Task 1: All Delayed Shipments
SELECT * FROM Shipments 
WHERE status = 'Delayed';

-- #Task 2: High-Distance Routes (> 300 km)
SELECT route_id, start_city, end_city 
FROM Routes 
WHERE distance_km > 300.00;

-- #Task 3: North Region Stock (JOIN)
SELECT T1.product_name, T1.stock_level 
FROM Inventory AS T1 
JOIN Warehouses AS T2 ON T1.warehouse_id = T2.warehouse_id 
WHERE T2.region = 'North';

-- #Task 4: Inventory Below Reorder Threshold
SELECT product_name, stock_level, reorder_threshold
FROM Inventory 
WHERE stock_level < reorder_threshold;

-- #Task 5: Recent Deliveries (Newest to Oldest)
SELECT * FROM Shipments 
ORDER BY actual_delivery_date DESC;

-----------------------------------------------------
-- TIER 2: INTERMEDIATE AGGREGATION AND JOINS
-----------------------------------------------------

-- #Task 6: Total Stock by Region
SELECT T2.region, SUM(T1.stock_level) AS total_region_stock 
FROM Inventory AS T1 
JOIN Warehouses AS T2 ON T1.warehouse_id = T2.warehouse_id 
GROUP BY T2.region;

-- #Task 7: Shipments Per Route
SELECT route_id, COUNT(shipment_id) AS total_shipments 
FROM Shipments 
GROUP BY route_id;

-- #Task 8: Underperforming Warehouses (HAVING Count < 3)
SELECT warehouse_id 
FROM Shipments 
GROUP BY warehouse_id 
HAVING COUNT(shipment_id) < 3;

-- #Task 9: Product Popularity (Stocked in most warehouses)
SELECT 
    product_name, 
    COUNT(DISTINCT warehouse_id) AS warehouse_count
FROM Inventory 
GROUP BY product_name
ORDER BY warehouse_count DESC
LIMIT 1;

-- #Task 10: Unused Routes (LEFT JOIN / NULL Check)
SELECT T1.start_city, T1.end_city 
FROM Routes AS T1 
LEFT JOIN Shipments AS T2 ON T1.route_id = T2.route_id 
WHERE T2.shipment_id IS NULL;

-----------------------------------------------------
-- TIER 3: ADVANCED ANALYTICS (WINDOW FUNCTIONS & CTEs)
-----------------------------------------------------

-- #Challenge 11: Time Between Deliveries (LAG)
WITH WarehouseShipments AS (
    SELECT 
        actual_delivery_date,
        LAG(actual_delivery_date, 1) OVER (ORDER BY actual_delivery_date) AS previous_delivery_date
    FROM Shipments 
    WHERE warehouse_id = 1 -- Central Hub A
)
SELECT 
    actual_delivery_date, 
    previous_delivery_date,
    -- Calculate the difference in days (syntax depends on your SQL flavor: PostgreSQL/SQL Server uses DATE_PART/DATEDIFF)
    actual_delivery_date - previous_delivery_date AS days_since_last_delivery
FROM WarehouseShipments
WHERE previous_delivery_date IS NOT NULL; -- Exclude the first shipment

-- #Challenge 12: Shipment Sequence (ROW_NUMBER)
SELECT 
    T1.shipment_id,
    T1.shipment_date,
    T2.region,
    ROW_NUMBER() OVER (PARTITION BY T2.region ORDER BY T1.shipment_date ASC) AS region_shipment_sequence
FROM Shipments AS T1 
JOIN Warehouses AS T2 ON T1.warehouse_id = T2.warehouse_id
WHERE T2.region = 'North' -- Filter to the North region
ORDER BY region_shipment_sequence;

-- #Challenge 13: High-Distance Routes (CTE)
WITH AvgRouteDistance AS (
    -- Stage 1: Calculate the overall average route distance
    SELECT AVG(distance_km) AS overall_avg_distance 
    FROM Routes
)
-- Main Query: Find shipments whose route is longer than the average
SELECT 
    T1.shipment_id, 
    T2.route_id,
    T2.distance_km
FROM Shipments AS T1 
JOIN Routes AS T2 ON T1.route_id = T2.route_id
WHERE T2.distance_km > (SELECT overall_avg_distance FROM AvgRouteDistance);

-- #Challenge 14: Delivery Delay Flag (CASE Statement)
SELECT
    shipment_id,
    status,
    shipment_date,
    actual_delivery_date,
    CASE 
        WHEN status = 'Delayed' AND actual_delivery_date > shipment_date THEN 'FLAGGED_DELAY'
        WHEN status = 'Delivered' AND actual_delivery_date > shipment_date THEN 'MILD_DELAY'
        ELSE 'OK'
    END AS delay_assessment
FROM Shipments;

-- #Challenge 15: Regional Performance Ranking (CTEs and RANK)
WITH RegionalShipmentCount AS (
    -- Stage 1: Count total shipments per region
    SELECT 
        T2.region, 
        COUNT(T1.shipment_id) AS total_shipments 
    FROM Shipments AS T1 
    JOIN Warehouses AS T2 ON T1.warehouse_id = T2.warehouse_id 
    GROUP BY T2.region
)
-- Final Query: Rank the regions based on their total shipment count
SELECT 
    region, 
    total_shipments,
    RANK() OVER (ORDER BY total_shipments DESC) AS region_rank
FROM RegionalShipmentCount
ORDER BY region_rank;
