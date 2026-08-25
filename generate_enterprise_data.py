import numpy as np
import pandas as pd

np.random.seed(42)
n_records = 50000

departments = ['Engineering', 'Marketing', 'Sales', 'Operations', 'Finance & Legal', 'Product & Design', 'Customer Success']
dept_weights = [0.28, 0.22, 0.18, 0.12, 0.08, 0.07, 0.05]

dept_categories = {
    'Engineering': ['Cloud Infrastructure', 'Salaries & Contractors', 'DevOps Tooling', 'Hardware & Peripherals'],
    'Marketing': ['Paid Performance Ads', 'Events & Sponsorships', 'Content & SEO Agencies', 'Brand & Creative Assets'],
    'Sales': ['Travel & Entertainment', 'Commissions & Incentives', 'CRM & Enablement Software', 'Client Hospitality'],
    'Operations': ['SaaS Licenses & ERP', 'Office Facilities & Lease', 'Logistics & Shipping', 'Professional Services'],
    'Finance & Legal': ['External Audit & Tax', 'Legal Counsel & Retainers', 'Treasury & Bank Fees', 'Payroll Processing'],
    'Product & Design': ['UX Research & UserTesting', 'Prototyping Software', 'Design Contractors'],
    'Customer Success': ['Ticketing & Support Tools', 'Customer Advisory Board', 'Retention Swag & Gifting']
}

print(f"Generated {n_records} realistic ERP general ledger records across {len(departments)} core departments.")
