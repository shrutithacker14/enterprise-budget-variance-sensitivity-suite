# Enterprise Financial Scenario & Budget Variance Analysis Suite

An enterprise-grade financial planning, budget variance tracking, and scenario sensitivity suite modeling corporate performance across a **50,000+ transaction General Ledger** ($78.5M baseline ARR).

---

## 📸 Executive Visual Previews

### 1. Multi-Year Income Statement (P&L Forecast)
![Enterprise P&L Projections](model_preview.png)

### 2. Two-Variable EBITDA Sensitivity Matrix
![EBITDA Sensitivity Matrix](sensitivity_matrix.png)

### 3. Interactive Scenario Toggle Engine
![Scenario Inputs](scenario_inputs.png)

---

## 📌 Project Overview & Business Context
Financial planning teams require dynamic tools to track actual department spend against allocated budgets and simulate how macroeconomic shifts impact operating margins.

This repository delivers an end-to-end analytical workflow:
1. **Warehouse SQL Layer:** Ingests raw ERP transaction logs and aggregates spend by department and cost center to calculate budget burn rates and automated risk flags.
2. **Dynamic 3-Statement Excel Model:** Features a scenario toggle (`Bear`, `Base`, `Bull`) driven by dynamic indexing, automated YoY variance tracking, and a two-variable sensitivity grid testing 36 distinct economic combinations.
3. **Executive Strategy Brief:** Translates quantitative findings into actionable recommendations (FinOps savings, headcount phasing, and margin safety thresholds).

---

## 🏗️ Architecture & Data Workflow
