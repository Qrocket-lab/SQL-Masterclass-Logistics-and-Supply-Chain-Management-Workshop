# 🚚 SQL Masterclass: Logistics and Supply Chain Analytics

This repository hosts a hands-on workshop focused on leveraging SQL for **Logistics and Supply Chain Management**. This dataset allows you to practice analyzing inventory movement, delivery efficiency, and route optimization.

## 🎯 Learning Objectives

* **Foundational Skills (Tier 1):** Practice querying inventory, filtering based on route status, and ordering by delivery time.
* **Intermediate Skills (Tier 2):** Implement aggregations (`SUM`, `COUNT`) to find total shipments per region and identify warehouses with low stock levels.
* **Advanced Analytics (Tier 3):** Master **Window Functions** (`LAG`, `LEAD`) for sequential analysis (e.g., time between deliveries) and use **CTEs** to compare performance against a calculated average threshold.

## 🛠️ Getting Started

To follow along with the challenges, you must first set up the database schema and populate it with mock data. All necessary SQL code is provided in the **`database_setup.sql`** file.

### Logistics Schema Overview

The dataset consists of four core tables:

| Table Name | Description | Key Fields |
| :--- | :--- | :--- |
| **`Warehouses`** | Storage locations and their regions. | `warehouse_id`, `region` |
| **`Inventory`** | Stock levels for various products at each warehouse. | `inventory_id`, `product_name`, `stock_level` |
| **`Routes`** | Defined delivery paths and their distance. | `route_id`, `start_city`, `end_city` |
| **`Shipments`** | Individual delivery records, including actual delivery time. | `shipment_id`, `route_id` (FK), `actual_delivery_date` |

## 📝 Challenge Walkthrough

Navigate to the **`challenges.md`** file to start the workshop. Once you've attempted the problems, you can find the verified SQL solutions in the **`solutions.sql`** file.

Good luck! 🚛
