# Enterprise Financial Scenario & Budget Sensitivity Suite

[![SQL](https://img.shields.io/badge/SQL-Data%20Warehouse%20(PostgreSQL%2FRedshift)-blue.svg)](#)
[![Data Volume](https://img.shields.io/badge/Dataset-50%2C000%2B%20ERP%20Transactions-success.svg)](#)
[![Excel](https://img.shields.io/badge/Excel-Advanced%20Financial%20Modeling%20%26%20DAX-green.svg)](#)
[![Domain](https://img.shields.io/badge/Domain-Corporate%20FP%26A%20%7C%20Strategic%20Finance-orange.svg)](#)

## 📌 Executive Overview
An enterprise-grade financial planning, variance tracking, and scenario sensitivity engine designed to model macroeconomic turbulence across a **50,000+ transaction ERP general ledger** ($78.5M baseline ARR).

This production-style portfolio project includes:
- **Warehouse-Scale SQL Pipeline:** Multi-CTE data aggregation engine calculating YoY budget burns, QoQ velocity shifts, and automated risk scoring.
- **Dynamic 3-Statement P&L Model:** Built in Excel with multi-case scenario indexing (Bear, Base, Bull), automated variance logic, and dynamic sensitivity data grids.
- **Executive Strategy Brief:** A formal C-suite financial memo outlining EBITDA margin risks and FinOps recommendations.

---

## 🏗️ Architecture & Data Pipeline

```
50,000+ ERP Ledger Rows ──► SQL Warehouse Pipeline ──► Dynamic Scenario Engine ──► Two-Way Sensitivity Grid
(General Ledger Logs)         (Multi-CTE Analytics)      (Interactive Excel P&L)    (EBITDA Stress Testing)
```

1. **ERP Ingestion & Schema:** `sql/01_ddl_and_warehouse_schema.sql` creates normalized dimensional and fact tables.
2. **Variance Analysis Engine:** `sql/02_advanced_variance_analysis.sql` extracts annualized run-rates and flags department budget breaches.
3. **Financial Sensitivity Engine:** `models/enterprise_budget_sensitivity_model_v2.xlsx` drives multi-variable scenario modeling.

---

## 📊 High-Level Financial Projections

| Scenario | Revenue Forecast | Operating EBITDA | EBITDA Margin | Net Income |
| :--- | :--- | :--- | :--- | :--- |
| **Conservative (Bear)** | $85.17M | **$12.72M** | 14.9% | $7.96M |
| **Base Case (Target)** | **$91.45M** | **$17.38M** | **19.0%** | **$11.83M** |
| **Aggressive (Bull)** | $100.48M | **$22.17M** | 22.1% | $15.77M |

* **Sensitivity Benchmark:** Every 1.0% increase in cloud and OPEX inflation requires a **1.45% offset in top-line growth** to maintain target EBITDA margins.

---

## 📂 Repository Layout

```text
├── data/
│   ├── enterprise_erp_general_ledger_50k.csv   # 50,000 transaction records across 7 departments
│   └── department_budget_allocations.csv       # Multi-year department budget baselines
├── sql/
│   ├── 01_ddl_and_warehouse_schema.sql         # Production DDL schema and indexing strategy
│   └── 02_advanced_variance_analysis.sql       # Multi-CTE budget burn & run-rate engine
├── models/
│   └── enterprise_budget_sensitivity_model_v2.xlsx # Formatted 3-tab financial model
├── reports/
│   └── executive_financial_brief.md            # C-suite executive strategy memo
├── scripts/
│   └── generate_enterprise_data.py             # Reproducible Python generation script
├── .gitignore
└── README.md
```

---

## 🛠️ Reproduction & Setup Guide

### 1. Database Execution
```bash
psql -h <host> -U <user> -d finance_warehouse -f sql/01_ddl_and_warehouse_schema.sql
psql -h <host> -U <user> -d finance_warehouse -f sql/02_advanced_variance_analysis.sql
```

### 2. Financial Model Exploration
- Open `models/enterprise_budget_sensitivity_model_v2.xlsx`.
- Select `Cell C4` on the **Scenario Engine & Inputs** sheet to toggle between **Bear**, **Base**, and **Bull** scenarios.
