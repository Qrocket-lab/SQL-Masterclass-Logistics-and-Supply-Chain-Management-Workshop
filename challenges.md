# 📝 Logistics SQL Challenges

Use the four tables (`Warehouses`, `Inventory`, `Routes`, `Shipments`) to solve the following problems.

---

## Tier 1: Beginner Fundamentals (SELECT, WHERE, ORDER BY)

| # | Goal | Hint |
| :--- | :--- | :--- |
| **1** | **All Delayed Shipments:** Retrieve all details for shipments with a `status` of 'Delayed'. | Simple `WHERE` clause on the `Shipments` table. |
| **2** | **High-Distance Routes:** Find the `route_id`, `start_city`, and `end_city` for all routes longer than 300 km. | Filter the `Routes` table. |
| **3** | **North Region Stock:** List all products and their `stock_level` found in the 'North' region warehouses. | Requires a `JOIN` between `Inventory` and `Warehouses`. |
| **4** | **Inventory Check:** List all products that are currently **below** their `reorder_threshold`. | Filter the `Inventory` table. |
| **5** | **Recent Deliveries:** List all shipments, ordered by their `actual_delivery_date` from newest to oldest. | Use `ORDER BY ... DESC`. |

---

## Tier 2: Intermediate Aggregation and Joins (GROUP BY, HAVING)

| # | Goal | Hint |
| :--- | :--- | :--- |
| **6** | **Total Stock by Region:** Calculate the total combined `stock_level` for all products in each `region`. | Requires a `JOIN`, `SUM()`, and `GROUP BY` the region. |
| **7** | **Shipments Per Route:** Count the total number of shipments completed for each `route_id`. | Use `COUNT()` and `GROUP BY route_id`. |
| **8** | **Underperforming Warehouses (HAVING):** Find the `warehouse_id` that has handled fewer than **3** shipments in total. | Use `COUNT()` and the `HAVING` clause on the `Shipments` table. |
| **9** | **Product Popularity:** Find the name of the product that is currently stocked in the most different warehouses. | Requires self-aggregation on the `Inventory` table to count distinct `warehouse_id`s per `product_name`. |
| **10** | **Unused Routes:** Find the `start_city` and `end_city` of routes that have **never** been used for a shipment. | Use a `LEFT JOIN` from `Routes` to `Shipments` and check for `NULL` shipment records. |

---

## Tier 3: Advanced Analytics (Window Functions and CTEs)

| # | Challenge | Technique |
| :--- | :--- | :--- |
| **11** | **Time Between Deliveries:** For all shipments originating from 'Central Hub A' (`warehouse_id = 1`), calculate the **number of days** between each delivery and the one immediately preceding it. | Use the **`LAG()`** Window Function on the `actual_delivery_date`. |
| **12** | **Shipment Sequence:** Assign a sequence number (1, 2, 3...) to all shipments within the 'North' region, ordered by their `shipment_date`. | Use `ROW_NUMBER() OVER (PARTITION BY region ORDER BY shipment_date)`. |
| **13** | **High-Distance Routes (CTE):** Find all shipments that traveled a route distance greater than the **overall average route distance** across all routes. | Use a **CTE** to calculate the overall average distance, then `JOIN` and filter in the main query. |
| **14** | **Delivery Delay Flag:** Retrieve all shipment details. For each shipment, add a column that flags it as 'Delayed' if the `status` is 'Delayed' AND the actual delivery date is **later** than the shipment date. | Use a `CASE` statement. (A simple challenge to enforce conditional logic). |
| **15** | **Regional Performance Ranking (CTEs and RANK):** Rank the regions based on their total combined shipment count (highest count = Rank 1). | Use one **CTE** to count shipments per region, and a second **CTE** or the main query to apply the `RANK()` Window Function. |
