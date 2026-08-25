-- ============================================================================
-- Executive Financial Variance, Run-Rate & Overspend Risk Detection Engine
-- Multi-CTE Pipeline Calculating YoY Variance, Burn Rate & Risk Classifications
-- ============================================================================

WITH QuarterlySpendAggregates AS (
    SELECT 
        fiscal_year,
        fiscal_quarter,
        cost_center,
        department,
        expense_category,
        COUNT(transaction_id) AS transaction_count,
        SUM(actual_amount_usd) AS total_quarterly_spend,
        AVG(actual_amount_usd) AS avg_ticket_size,
        MAX(actual_amount_usd) AS max_single_expense
    FROM fact_erp_general_ledger
    GROUP BY fiscal_year, fiscal_quarter, cost_center, department, expense_category
),

AnnualizedActuals AS (
    SELECT 
        fiscal_year,
        cost_center,
        department,
        expense_category,
        SUM(total_quarterly_spend) AS ytd_actual_spend,
        SUM(transaction_count) AS total_ytd_transactions,
        -- Calculate Q1 to Q2 Quarter-over-Quarter momentum
        SUM(CASE WHEN fiscal_quarter = 'Q2' THEN total_quarterly_spend ELSE 0 END) -
        SUM(CASE WHEN fiscal_quarter = 'Q1' THEN total_quarterly_spend ELSE 0 END) AS qoq_variance_amount
    FROM QuarterlySpendAggregates
    GROUP BY fiscal_year, cost_center, department, expense_category
),

BudgetVarianceEngine AS (
    SELECT 
        b.fiscal_year,
        b.cost_center,
        b.department,
        b.expense_category,
        b.budget_owner,
        b.allocated_budget_usd,
        COALESCE(a.ytd_actual_spend, 0.00) AS ytd_actual_spend,
        (b.allocated_budget_usd - COALESCE(a.ytd_actual_spend, 0.00)) AS unallocated_budget_balance,
        ROUND((COALESCE(a.ytd_actual_spend, 0.00) / NULLIF(b.allocated_budget_usd, 0)) * 100, 2) AS budget_burn_percentage,
        COALESCE(a.qoq_variance_amount, 0.00) AS qoq_spend_acceleration,
        COALESCE(a.total_ytd_transactions, 0) AS total_transactions
    FROM dim_department_budget b
    LEFT JOIN AnnualizedActuals a
        ON b.fiscal_year = a.fiscal_year
        AND b.department = a.department
        AND b.expense_category = a.expense_category
)

SELECT 
    fiscal_year,
    cost_center,
    department,
    expense_category,
    budget_owner,
    allocated_budget_usd,
    ytd_actual_spend,
    unallocated_budget_balance,
    budget_burn_percentage,
    qoq_spend_acceleration,
    total_transactions,
    -- Dynamic Enterprise Risk Classification
    CASE 
        WHEN budget_burn_percentage > 100.0 THEN 'CRITICAL: BUDGET BREACH'
        WHEN budget_burn_percentage >= 85.0 THEN 'HIGH RISK: IMPENDING OVERRUN'
        WHEN budget_burn_percentage >= 65.0 THEN 'MODERATE: NORMAL BURN'
        ELSE 'LOW: UNDERUTILIZED'
    END AS financial_health_status,
    -- 12-Month Linear Annualized Forecast
    ROUND((ytd_actual_spend / 7.0) * 12.0, 2) AS annualized_projected_spend,
    -- Projected Year-End Variance ($)
    ROUND(bve.allocated_budget_usd - ((ytd_actual_spend / 7.0) * 12.0), 2) AS projected_year_end_surplus_deficit
FROM BudgetVarianceEngine bve
ORDER BY fiscal_year DESC, budget_burn_percentage DESC;
