-- ============================================================================
-- Enterprise ERP General Ledger & Budget Allocation Data Warehouse Schema
-- Target: PostgreSQL / AWS Redshift / Snowflake / BigQuery
-- ============================================================================

CREATE TABLE dim_department_budget (
    budget_id VARCHAR(32) PRIMARY KEY,
    fiscal_year INT NOT NULL,
    cost_center VARCHAR(10) NOT NULL,
    department VARCHAR(50) NOT NULL,
    expense_category VARCHAR(60) NOT NULL,
    allocated_budget_usd NUMERIC(15, 2) NOT NULL,
    budget_owner VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fact_erp_general_ledger (
    transaction_id VARCHAR(20) PRIMARY KEY,
    posting_date DATE NOT NULL,
    fiscal_year INT NOT NULL,
    fiscal_quarter VARCHAR(5) NOT NULL,
    cost_center VARCHAR(10) NOT NULL,
    department VARCHAR(50) NOT NULL,
    expense_category VARCHAR(60) NOT NULL,
    vendor_name VARCHAR(120) NOT NULL,
    actual_amount_usd NUMERIC(15, 2) NOT NULL,
    payment_status VARCHAR(20) NOT NULL,
    ingested_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_ledger_dept_year ON fact_erp_general_ledger (fiscal_year, department);
CREATE INDEX idx_ledger_posting_date ON fact_erp_general_ledger (posting_date);
CREATE INDEX idx_budget_lookup ON dim_department_budget (fiscal_year, department, expense_category);
