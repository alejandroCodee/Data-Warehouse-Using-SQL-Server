# 📦 Data Warehouse Project Using SQL Server

This project implements a **modern Data Warehouse architecture** that consolidates sales, customer, and product data from CRM and ERP systems using the Medallion Architecture **Bronze, Silver, and Gold layer pattern**.

The primary objective is to deliver a **clean, integrated, and analytics-ready dataset** for business intelligence tools such as Power BI, while maintaining data quality, traceability, and performance across each processing stage.

---

## 🌐 Architecture Overview

### 🥉 Bronze Layer
Raw data ingestion from multiple operational sources (CRM and ERP).  
Data is stored in its original form with **minimal or no transformation**.

### 🥈 Silver Layer
Cleaned, standardized, and joined datasets.  
At this stage:
- Business rules are applied  
- Data quality checks are performed  
- Relationships between sources are resolved

### 🥇 Gold Layer
Optimized **star-schema models** ready for reporting and analytics.  
Fact and dimension tables are prepared to support business KPIs and dashboards.

---
