# Data Warehouse Project Using SQL Server

This project implements a **modern Data Warehouse architecture** that consolidates sales, customer, and product data from CRM and ERP systems using the Medallion Architecture **Bronze, Silver, and Gold layer pattern**.

The primary objective is to deliver a **clean, integrated, and analytics-ready dataset** for business intelligence tools such as Power BI, while maintaining data quality, traceability, and performance across each processing stage.

---

## 📊 Project Overview

This project builds a complete **Data Warehouse** using SQL Server following the Medallion Architecture (Bronze, Silver, Gold). It integrates **sales, customer, and product data** from raw CSV files coming from both CRM and ERP systems, transforming them into an analytics-ready star schema.

A **Data Warehouse (DWH)** enables organizations to centralize and consolidate large volumes of historical and operational data. This allows for:
- Fast and reliable querying
- Clean and consistent data models
- Building robust BI dashboards (e.g., Power BI)

This type of architecture is **essential for making data-driven decisions**, improving reporting accuracy, and empowering departments like sales, marketing, and finance.

---

## ⚙️ Project Requirements for Deployment

- SQL Server (2019 or above recommended)
- SSMS (SQL Server Management Studio) or Azure Data Studio
- CSV source data (provided in `datasets/source_crm` and `datasets/source_erp`)
- Basic SQL knowledge to execute the scripts

**Optional:**
- Power BI Desktop (for consuming Gold Layer outputs)

---

## 📁 Repository Structure

```
├── datasets/
│   ├── source_crm/
│   │   ├── cust_info.csv
│   │   ├── prd_info.csv
│   │   └── sales_details.csv
│   └── source_erp/
│       ├── CUST_AZ12.csv
│       ├── LOC_A101.csv
│       └── PX_CAT_G1V2.csv

├── scripts/
│   ├── init_database.sql
│   ├── bronze/
│   │   ├── ddl_bronze.sql
│   │   └── proc_load_bronze.sql
│   ├── silver/
│   │   ├── ddl_silver.sql
│   │   └── proc_load_silver.sql
│   └── gold/
│       └── ddl_gold.sql

├── schemas/
│   └── [Schema diagrams and documentation]

├── tests/
│   ├── quality_checks_silver.sql
│   └── quality_checks_gold.sql

├── LICENSE
└── README.md
```

---

## 🚀 How to Run This Project

1. **Initialize the database**  
   Open SQL Server and execute `scripts/init_database.sql` to create the base database.

2. **Create Bronze Tables and Load Raw Data**  
   - Run `scripts/bronze/ddl_bronze.sql` to create the raw tables  
   - Run `scripts/bronze/proc_load_bronze.sql` to load data from CSV files into the bronze layer

3. **Create Silver Tables and Apply Transformations**  
   - Run `scripts/silver/ddl_silver.sql`  
   - Run `scripts/silver/proc_load_silver.sql`

4. **Create Gold Layer Tables**  
   - Run `scripts/gold/ddl_gold.sql`

5. **Run Data Quality Tests (optional but recommended)**  
   - `tests/quality_checks_silver.sql`  
   - `tests/quality_checks_gold.sql`

6. **Consume with BI Tools (optional)**  
   You can now connect Power BI or any other BI tool to the **Gold Layer** tables.

---

## 🙌 Credits

Developed by **AlejandroCodee**  
Data Architecture, SQL Modeling, and GitHub Documentation

Images and diagrams designed with ❤️ to explain and visualize complex ETL workflows and schemas.

---
