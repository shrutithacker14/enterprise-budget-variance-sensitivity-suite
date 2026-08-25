-- ============================================================================
-- Script: 02_budget_variance_analysis.sql
-- Description: Clean Budget vs. Actuals spend analysis by department
-- ============================================================================

-- Step 1: Calculate total actual spend for each department and category
WITH actual_spend_summary AS (
    SELECT 
        fiscal_year,
        department,
        expense_category,
        COUNT(transaction_id)  AS total_invoices,
        SUM(actual_amount_usd) AS total_spent_usd
    FROM fact_erp_general_ledger
    GROUP BY fiscal_year, department, expense_category
)

-- Step 2: Compare budget vs actuals and assign a simple health status
SELECT 
    b.fiscal_year,
    b.department,
    b.expense_category,
    b.allocated_budget_usd AS budget_limit,
    COALESCE(a.total_spent_usd, 0) AS actual_spent,
    (b.allocated_budget_usd - COALESCE(a.total_spent_usd, 0)) AS remaining_budget,
    ROUND((COALESCE(a.total_spent_usd, 0) / b.allocated_budget_usd) * 100.0, 1) AS burn_rate_pct,
    CASE 
        WHEN COALESCE(a.total_spent_usd, 0) > b.allocated_budget_usd THEN 'Over Budget'
        WHEN (COALESCE(a.total_spent_usd, 0) / b.allocated_budget_usd) >= 0.85 THEN 'At Risk'
        ELSE 'On Track'
    END AS budget_status
FROM dim_department_budget b
LEFT JOIN actual_spend_summary a
    ON  b.fiscal_year      = a.fiscal_year
    AND b.department       = a.department
    AND b.expense_category = a.expense_category
ORDER BY burn_rate_pct DESC;