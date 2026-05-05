-- Metric views for domain: finance | Business: Power and Utilities | Version: 1 | Generated on: 2026-04-29 23:09:06

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`finance_capex_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital project performance metrics including budget variance, cost overruns, AFUDC accruals, and project portfolio health indicators for investment decision-making and regulatory rate case preparation"
  source: "`power_and_utilities`.`finance`.`capex_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the capital project (e.g., planning, in-progress, completed, closed)"
    - name: "project_type"
      expr: project_type
      comment: "Type of capital project (e.g., generation, transmission, distribution, IT, facilities)"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the project for rate recovery purposes"
    - name: "service_territory"
      expr: service_territory
      comment: "Service territory where the project is located"
    - name: "justification_category"
      expr: justification_category
      comment: "Business justification category (e.g., reliability, compliance, growth, replacement)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of project authorization or execution"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for the capital project (e.g., plant, equipment, infrastructure)"
    - name: "program_name"
      expr: program_name
      comment: "Program or portfolio name grouping related projects"
    - name: "afudc_eligible"
      expr: afudc_eligible
      comment: "Whether the project is eligible for Allowance for Funds Used During Construction"
    - name: "is_blanket_project"
      expr: is_blanket_project
      comment: "Whether this is a blanket project covering multiple small work orders"
    - name: "authorization_year"
      expr: YEAR(authorization_date)
      comment: "Year the project was authorized"
    - name: "in_service_year"
      expr: YEAR(actual_in_service_date)
      comment: "Year the project was placed in service"
  measures:
    - name: "total_authorized_budget"
      expr: SUM(CAST(authorized_budget_amount AS DOUBLE))
      comment: "Total authorized budget across all projects"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_cost_to_date AS DOUBLE))
      comment: "Total actual costs incurred to date across all projects"
    - name: "total_revised_budget"
      expr: SUM(CAST(revised_budget_amount AS DOUBLE))
      comment: "Total revised budget reflecting approved changes"
    - name: "total_estimated_cost_at_completion"
      expr: SUM(CAST(estimated_cost_at_completion AS DOUBLE))
      comment: "Total estimated final cost at project completion"
    - name: "budget_variance_amount"
      expr: SUM((CAST(actual_cost_to_date AS DOUBLE)) - (CAST(authorized_budget_amount AS DOUBLE)))
      comment: "Total budget variance (actual cost minus authorized budget) indicating cost overruns or savings"
    - name: "budget_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(actual_cost_to_date AS DOUBLE)) - SUM(CAST(authorized_budget_amount AS DOUBLE))) / NULLIF(SUM(CAST(authorized_budget_amount AS DOUBLE)), 0), 2)
      comment: "Budget variance as percentage of authorized budget for performance tracking"
    - name: "total_afudc_accrued"
      expr: SUM(CAST(afudc_accrued_amount AS DOUBLE))
      comment: "Total Allowance for Funds Used During Construction accrued, representing financing cost capitalized during construction"
    - name: "total_ciac_amount"
      expr: SUM(CAST(ciac_amount AS DOUBLE))
      comment: "Total Contributions in Aid of Construction received, reducing net rate base"
    - name: "total_plant_additions"
      expr: SUM(CAST(plant_addition_amount AS DOUBLE))
      comment: "Total plant additions to be capitalized and included in rate base"
    - name: "project_count"
      expr: COUNT(DISTINCT capex_project_id)
      comment: "Number of distinct capital projects"
    - name: "avg_project_cost"
      expr: AVG(CAST(actual_cost_to_date AS DOUBLE))
      comment: "Average actual cost per project for portfolio benchmarking"
    - name: "afudc_eligible_project_count"
      expr: COUNT(DISTINCT CASE WHEN afudc_eligible = TRUE THEN capex_project_id END)
      comment: "Count of projects eligible for AFUDC treatment"
    - name: "ciac_project_count"
      expr: COUNT(DISTINCT CASE WHEN ciac_indicator = TRUE THEN capex_project_id END)
      comment: "Count of projects with customer contributions"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`finance_capex_expenditure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capital expenditure transaction metrics tracking spending velocity, capitalization status, AFUDC eligibility, and budget consumption for cash flow management and regulatory compliance"
  source: "`power_and_utilities`.`finance`.`capex_expenditure`"
  dimensions:
    - name: "expenditure_type"
      expr: expenditure_type
      comment: "Type of capital expenditure (e.g., labor, material, contractor, equipment)"
    - name: "capitalization_status"
      expr: capitalization_status
      comment: "Status of capitalization (e.g., pending, capitalized, expensed)"
    - name: "is_capitalized"
      expr: is_capitalized
      comment: "Whether the expenditure has been capitalized to fixed assets"
    - name: "is_afudc_eligible"
      expr: is_afudc_eligible
      comment: "Whether the expenditure is eligible for AFUDC treatment"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the expenditure"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the expenditure"
    - name: "ferc_plant_account"
      expr: ferc_plant_account
      comment: "FERC plant account code for regulatory reporting"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class of the expenditure"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction for rate recovery"
    - name: "service_territory"
      expr: service_territory
      comment: "Service territory where expenditure occurred"
    - name: "expenditure_month"
      expr: DATE_TRUNC('MONTH', expenditure_date)
      comment: "Month of expenditure for trend analysis"
    - name: "expenditure_quarter"
      expr: DATE_TRUNC('QUARTER', expenditure_date)
      comment: "Quarter of expenditure for quarterly reporting"
  measures:
    - name: "total_expenditure_amount"
      expr: SUM(CAST(expenditure_amount AS DOUBLE))
      comment: "Total capital expenditure amount for cash flow tracking"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted amount for expenditures"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net expenditure amount after adjustments"
    - name: "total_afudc_amount"
      expr: SUM(CAST(afudc_amount AS DOUBLE))
      comment: "Total AFUDC capitalized on expenditures"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on capital expenditures"
    - name: "expenditure_count"
      expr: COUNT(DISTINCT capex_expenditure_id)
      comment: "Number of distinct capital expenditure transactions"
    - name: "avg_expenditure_amount"
      expr: AVG(CAST(expenditure_amount AS DOUBLE))
      comment: "Average expenditure amount per transaction"
    - name: "capitalized_expenditure_amount"
      expr: SUM(CASE WHEN is_capitalized = TRUE THEN CAST(expenditure_amount AS DOUBLE) ELSE 0 END)
      comment: "Total expenditure amount that has been capitalized"
    - name: "afudc_eligible_expenditure_amount"
      expr: SUM(CASE WHEN is_afudc_eligible = TRUE THEN CAST(expenditure_amount AS DOUBLE) ELSE 0 END)
      comment: "Total expenditure amount eligible for AFUDC treatment"
    - name: "budget_utilization_pct"
      expr: ROUND(100.0 * SUM(CAST(expenditure_amount AS DOUBLE)) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of budget consumed by actual expenditures"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fixed asset portfolio metrics including net book value, accumulated depreciation, rate base eligibility, and asset retirement obligations for regulatory rate-making and financial reporting"
  source: "`power_and_utilities`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_status"
      expr: asset_status
      comment: "Current status of the fixed asset (e.g., active, retired, under construction)"
    - name: "asset_type"
      expr: asset_type
      comment: "Type of fixed asset (e.g., generation, transmission, distribution, general plant)"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for depreciation and accounting purposes"
    - name: "ferc_plant_account"
      expr: ferc_plant_account
      comment: "FERC plant account code for regulatory reporting"
    - name: "is_rate_base_eligible"
      expr: is_rate_base_eligible
      comment: "Whether the asset is eligible for inclusion in regulatory rate base"
    - name: "is_regulatory_asset"
      expr: is_regulatory_asset
      comment: "Whether the asset is classified as a regulatory asset"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the asset"
    - name: "utility_type"
      expr: utility_type
      comment: "Utility type (e.g., electric, gas, water)"
    - name: "service_territory"
      expr: service_territory
      comment: "Service territory where the asset is located"
    - name: "functional_class"
      expr: functional_class
      comment: "Functional classification of the asset"
    - name: "vintage_year"
      expr: vintage_year
      comment: "Year the asset was originally placed in service"
    - name: "in_service_year"
      expr: YEAR(in_service_date)
      comment: "Year the asset was placed in service"
  measures:
    - name: "total_original_cost"
      expr: SUM(CAST(original_cost AS DOUBLE))
      comment: "Total original cost of fixed assets representing gross plant investment"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation reducing gross plant to net book value"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of fixed assets (original cost minus accumulated depreciation)"
    - name: "total_afudc_amount"
      expr: SUM(CAST(afudc_amount AS DOUBLE))
      comment: "Total AFUDC capitalized on fixed assets"
    - name: "total_ciac_amount"
      expr: SUM(CAST(ciac_amount AS DOUBLE))
      comment: "Total customer contributions reducing net rate base"
    - name: "total_asset_retirement_obligation"
      expr: SUM(CAST(asset_retirement_obligation AS DOUBLE))
      comment: "Total asset retirement obligation liability for future decommissioning costs"
    - name: "total_cost_of_removal"
      expr: SUM(CAST(cost_of_removal AS DOUBLE))
      comment: "Total estimated cost of removal for retired assets"
    - name: "asset_count"
      expr: COUNT(DISTINCT fixed_asset_id)
      comment: "Number of distinct fixed assets in the portfolio"
    - name: "rate_base_eligible_nbv"
      expr: SUM(CASE WHEN is_rate_base_eligible = TRUE THEN CAST(net_book_value AS DOUBLE) ELSE 0 END)
      comment: "Net book value of assets eligible for regulatory rate base inclusion"
    - name: "avg_remaining_useful_life"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life in years across the asset portfolio"
    - name: "depreciation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_depreciation AS DOUBLE)) / NULLIF(SUM(CAST(original_cost AS DOUBLE)), 0), 2)
      comment: "Portfolio-wide depreciation rate as percentage of original cost"
    - name: "avg_asset_age_years"
      expr: AVG(DATEDIFF(CURRENT_DATE(), in_service_date) / 365.25)
      comment: "Average age of assets in years since in-service date"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`finance_journal_entry_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "General ledger transaction metrics tracking debits, credits, account activity, and financial statement movements for period close, audit, and financial reporting"
  source: "`power_and_utilities`.`finance`.`journal_entry_line`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of GL account (e.g., asset, liability, equity, revenue, expense)"
    - name: "debit_credit_indicator"
      expr: debit_credit_indicator
      comment: "Whether the line is a debit or credit entry"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the journal entry"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the journal entry"
    - name: "ferc_account_code"
      expr: ferc_account_code
      comment: "FERC account code for regulatory reporting"
    - name: "capex_opex_indicator"
      expr: capex_opex_indicator
      comment: "Whether the entry is capital or operating expenditure"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction for the transaction"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Whether this is a reversal entry"
    - name: "posting_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of posting for trend analysis"
    - name: "posting_quarter"
      expr: DATE_TRUNC('QUARTER', posting_date)
      comment: "Quarter of posting for quarterly reporting"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(amount_transaction_currency AS DOUBLE))
      comment: "Total transaction amount in original transaction currency"
    - name: "total_company_currency_amount"
      expr: SUM(CAST(amount_company_currency AS DOUBLE))
      comment: "Total amount in company reporting currency for consolidated reporting"
    - name: "total_debit_amount"
      expr: SUM(CASE WHEN debit_credit_indicator = 'D' THEN CAST(amount_company_currency AS DOUBLE) ELSE 0 END)
      comment: "Total debit amount for balance verification"
    - name: "total_credit_amount"
      expr: SUM(CASE WHEN debit_credit_indicator = 'C' THEN CAST(amount_company_currency AS DOUBLE) ELSE 0 END)
      comment: "Total credit amount for balance verification"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount on journal entries"
    - name: "journal_line_count"
      expr: COUNT(DISTINCT journal_entry_line_id)
      comment: "Number of distinct journal entry lines"
    - name: "avg_line_amount"
      expr: AVG(CAST(amount_company_currency AS DOUBLE))
      comment: "Average amount per journal entry line"
    - name: "reversal_line_count"
      expr: COUNT(DISTINCT CASE WHEN reversal_indicator = TRUE THEN journal_entry_line_id END)
      comment: "Count of reversal journal entry lines"
    - name: "capex_amount"
      expr: SUM(CASE WHEN capex_opex_indicator = 'CAPEX' THEN CAST(amount_company_currency AS DOUBLE) ELSE 0 END)
      comment: "Total capital expenditure amount from journal entries"
    - name: "opex_amount"
      expr: SUM(CASE WHEN capex_opex_indicator = 'OPEX' THEN CAST(amount_company_currency AS DOUBLE) ELSE 0 END)
      comment: "Total operating expenditure amount from journal entries"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`finance_opex_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operating expenditure metrics tracking O&M spending, budget variance, regulatory jurisdiction allocation, and rate case test year expenses for cost management and regulatory filings"
  source: "`power_and_utilities`.`finance`.`opex_transaction`"
  dimensions:
    - name: "expense_category"
      expr: expense_category
      comment: "Category of operating expense (e.g., labor, materials, services, utilities)"
    - name: "ferc_account_code"
      expr: ferc_account_code
      comment: "FERC account code for regulatory expense classification"
    - name: "functional_area"
      expr: functional_area
      comment: "Functional area incurring the expense"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction for cost allocation and rate recovery"
    - name: "utility_type"
      expr: utility_type
      comment: "Utility type (electric, gas, water) for the expense"
    - name: "is_rate_case_includable"
      expr: is_rate_case_includable
      comment: "Whether the expense is includable in rate case test year"
    - name: "is_capex_reclassified"
      expr: is_capex_reclassified
      comment: "Whether the expense was reclassified from capital"
    - name: "approval_status"
      expr: approval_status
      comment: "Approval status of the expense transaction"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the expense"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the expense"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of transaction for trend analysis"
  measures:
    - name: "total_transaction_amount"
      expr: SUM(CAST(transaction_amount AS DOUBLE))
      comment: "Total operating expenditure transaction amount"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net operating expenditure after adjustments"
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budgeted operating expenditure"
    - name: "total_overhead_allocation"
      expr: SUM(CAST(overhead_allocation_amount AS DOUBLE))
      comment: "Total overhead allocated to operating expenses"
    - name: "opex_transaction_count"
      expr: COUNT(DISTINCT opex_transaction_id)
      comment: "Number of distinct operating expenditure transactions"
    - name: "avg_transaction_amount"
      expr: AVG(CAST(transaction_amount AS DOUBLE))
      comment: "Average operating expenditure per transaction"
    - name: "budget_variance_amount"
      expr: SUM((CAST(transaction_amount AS DOUBLE)) - (CAST(budget_amount AS DOUBLE)))
      comment: "Operating expenditure budget variance (actual minus budget)"
    - name: "budget_variance_pct"
      expr: ROUND(100.0 * (SUM(CAST(transaction_amount AS DOUBLE)) - SUM(CAST(budget_amount AS DOUBLE))) / NULLIF(SUM(CAST(budget_amount AS DOUBLE)), 0), 2)
      comment: "Operating expenditure budget variance as percentage of budget"
    - name: "rate_case_includable_amount"
      expr: SUM(CASE WHEN is_rate_case_includable = TRUE THEN CAST(transaction_amount AS DOUBLE) ELSE 0 END)
      comment: "Total operating expenditure includable in rate case test year"
    - name: "reclassified_from_capex_amount"
      expr: SUM(CASE WHEN is_capex_reclassified = TRUE THEN CAST(transaction_amount AS DOUBLE) ELSE 0 END)
      comment: "Total operating expenditure reclassified from capital"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`finance_depreciation_run`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Depreciation calculation run metrics tracking monthly depreciation expense, accumulated depreciation, gross plant, and run execution quality for financial close and regulatory reporting"
  source: "`power_and_utilities`.`finance`.`depreciation_run`"
  dimensions:
    - name: "run_status"
      expr: run_status
      comment: "Status of the depreciation run (e.g., completed, failed, in-progress)"
    - name: "run_type"
      expr: run_type
      comment: "Type of depreciation run (e.g., regular, adjustment, simulation)"
    - name: "is_simulation"
      expr: is_simulation
      comment: "Whether this is a simulation run or actual posting"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the depreciation run"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the depreciation run"
    - name: "depreciation_method_code"
      expr: depreciation_method_code
      comment: "Depreciation method applied in the run"
    - name: "ferc_plant_account"
      expr: ferc_plant_account
      comment: "FERC plant account for the depreciation calculation"
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code for the depreciation run"
    - name: "run_month"
      expr: DATE_TRUNC('MONTH', run_date)
      comment: "Month of the depreciation run"
  measures:
    - name: "total_depreciation_expense"
      expr: SUM(CAST(total_depreciation_amount AS DOUBLE))
      comment: "Total depreciation expense calculated in the run for income statement impact"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation_amount AS DOUBLE))
      comment: "Total accumulated depreciation balance after the run"
    - name: "total_gross_plant"
      expr: SUM(CAST(gross_plant_amount AS DOUBLE))
      comment: "Total gross plant amount subject to depreciation"
    - name: "total_planned_depreciation"
      expr: SUM(CAST(planned_depreciation_amount AS DOUBLE))
      comment: "Total planned depreciation amount for variance analysis"
    - name: "depreciation_run_count"
      expr: COUNT(DISTINCT depreciation_run_id)
      comment: "Number of distinct depreciation runs executed"
    - name: "avg_depreciation_rate"
      expr: AVG(CAST(depreciation_rate AS DOUBLE))
      comment: "Average depreciation rate applied across runs"
    - name: "depreciation_variance_amount"
      expr: SUM((CAST(total_depreciation_amount AS DOUBLE)) - (CAST(planned_depreciation_amount AS DOUBLE)))
      comment: "Variance between actual and planned depreciation"
    - name: "effective_depreciation_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(total_depreciation_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_plant_amount AS DOUBLE)), 0), 2)
      comment: "Effective depreciation rate as percentage of gross plant"
    - name: "successful_run_count"
      expr: COUNT(DISTINCT CASE WHEN run_status = 'completed' THEN depreciation_run_id END)
      comment: "Count of successfully completed depreciation runs"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`finance_regulatory_asset_entry`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory asset and liability metrics tracking deferred costs, amortization, carrying charges, and rate base treatment for regulatory accounting and rate case preparation"
  source: "`power_and_utilities`.`finance`.`regulatory_asset_entry`"
  dimensions:
    - name: "entry_type"
      expr: entry_type
      comment: "Type of regulatory entry (e.g., asset, liability, deferral)"
    - name: "entry_status"
      expr: entry_status
      comment: "Status of the regulatory entry (e.g., active, fully amortized, pending approval)"
    - name: "amortization_method"
      expr: amortization_method
      comment: "Method used to amortize the regulatory asset or liability"
    - name: "ferc_account_code"
      expr: ferc_account_code
      comment: "FERC account code for regulatory reporting"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the asset or liability"
    - name: "is_rate_base_eligible"
      expr: is_rate_base_eligible
      comment: "Whether the regulatory asset is eligible for rate base inclusion"
    - name: "is_afudc_eligible"
      expr: is_afudc_eligible
      comment: "Whether the regulatory asset is eligible for AFUDC treatment"
    - name: "functional_class"
      expr: functional_class
      comment: "Functional classification of the regulatory asset"
    - name: "utility_type"
      expr: utility_type
      comment: "Utility type (electric, gas, water) for the regulatory asset"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the regulatory entry"
    - name: "recognition_year"
      expr: YEAR(recognition_date)
      comment: "Year the regulatory asset was recognized"
  measures:
    - name: "total_original_amount"
      expr: SUM(CAST(original_amount AS DOUBLE))
      comment: "Total original amount of regulatory assets and liabilities"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current unamortized balance of regulatory assets and liabilities"
    - name: "total_accumulated_amortization"
      expr: SUM(CAST(accumulated_amortization AS DOUBLE))
      comment: "Total accumulated amortization of regulatory assets"
    - name: "total_annual_amortization"
      expr: SUM(CAST(annual_amortization_amount AS DOUBLE))
      comment: "Total annual amortization expense for regulatory assets"
    - name: "total_carrying_cost"
      expr: SUM(CAST(carrying_cost_amount AS DOUBLE))
      comment: "Total carrying cost (interest) accrued on regulatory assets"
    - name: "total_afudc_amount"
      expr: SUM(CAST(afudc_amount AS DOUBLE))
      comment: "Total AFUDC capitalized on regulatory assets"
    - name: "total_ciac_amount"
      expr: SUM(CAST(ciac_amount AS DOUBLE))
      comment: "Total customer contributions reducing regulatory assets"
    - name: "regulatory_entry_count"
      expr: COUNT(DISTINCT regulatory_asset_entry_id)
      comment: "Number of distinct regulatory asset and liability entries"
    - name: "rate_base_eligible_balance"
      expr: SUM(CASE WHEN is_rate_base_eligible = TRUE THEN CAST(current_balance AS DOUBLE) ELSE 0 END)
      comment: "Current balance of regulatory assets eligible for rate base inclusion"
    - name: "avg_carrying_cost_rate"
      expr: AVG(CAST(carrying_cost_rate AS DOUBLE))
      comment: "Average carrying cost rate applied to regulatory assets"
    - name: "amortization_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(accumulated_amortization AS DOUBLE)) / NULLIF(SUM(CAST(original_amount AS DOUBLE)), 0), 2)
      comment: "Percentage of original regulatory asset amount that has been amortized"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`finance_rate_case_cost_study`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate case cost study metrics tracking revenue requirements, rate base, authorized returns, cost of capital, and revenue deficiency for regulatory rate filings and settlement negotiations"
  source: "`power_and_utilities`.`finance`.`rate_case_cost_study`"
  dimensions:
    - name: "study_type"
      expr: study_type
      comment: "Type of rate case cost study (e.g., general rate case, interim rate adjustment)"
    - name: "filing_status"
      expr: filing_status
      comment: "Status of the rate case filing (e.g., pending, approved, settled)"
    - name: "jurisdiction_type"
      expr: jurisdiction_type
      comment: "Type of regulatory jurisdiction (e.g., state, federal)"
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction for the rate case"
    - name: "test_year_type"
      expr: test_year_type
      comment: "Type of test year (e.g., historical, forward-looking, hybrid)"
    - name: "settlement_reached"
      expr: settlement_reached
      comment: "Whether a settlement was reached with intervenors"
    - name: "pbr_target_included"
      expr: pbr_target_included
      comment: "Whether performance-based ratemaking targets are included"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the rate case was filed"
    - name: "test_year"
      expr: YEAR(test_year_start_date)
      comment: "Test year for the rate case study"
  measures:
    - name: "total_revenue_requirement"
      expr: SUM(CAST(revenue_requirement_amount AS DOUBLE))
      comment: "Total revenue requirement requested in rate case filings"
    - name: "total_rate_base"
      expr: SUM(CAST(rate_base_amount AS DOUBLE))
      comment: "Total rate base (net plant investment) for return calculation"
    - name: "total_revenue_deficiency"
      expr: SUM(CAST(revenue_deficiency_amount AS DOUBLE))
      comment: "Total revenue deficiency (gap between requirement and existing revenue)"
    - name: "total_existing_revenue"
      expr: SUM(CAST(existing_revenue_amount AS DOUBLE))
      comment: "Total existing revenue at current rates"
    - name: "total_depreciation_expense"
      expr: SUM(CAST(depreciation_expense_amount AS DOUBLE))
      comment: "Total depreciation expense included in revenue requirement"
    - name: "total_om_expense"
      expr: SUM(CAST(om_expense_amount AS DOUBLE))
      comment: "Total operations and maintenance expense in revenue requirement"
    - name: "total_income_tax_expense"
      expr: SUM(CAST(income_tax_expense_amount AS DOUBLE))
      comment: "Total income tax expense in revenue requirement"
    - name: "total_property_tax_expense"
      expr: SUM(CAST(property_tax_expense_amount AS DOUBLE))
      comment: "Total property tax expense in revenue requirement"
    - name: "total_capex"
      expr: SUM(CAST(capex_amount AS DOUBLE))
      comment: "Total capital expenditure included in rate base"
    - name: "avg_authorized_roe"
      expr: AVG(CAST(authorized_roe_pct AS DOUBLE))
      comment: "Average authorized return on equity percentage"
    - name: "avg_wacc"
      expr: AVG(CAST(wacc_pct AS DOUBLE))
      comment: "Average weighted average cost of capital"
    - name: "rate_case_count"
      expr: COUNT(DISTINCT rate_case_cost_study_id)
      comment: "Number of distinct rate case cost studies"
    - name: "revenue_increase_pct"
      expr: ROUND(100.0 * SUM(CAST(revenue_deficiency_amount AS DOUBLE)) / NULLIF(SUM(CAST(existing_revenue_amount AS DOUBLE)), 0), 2)
      comment: "Percentage revenue increase requested (deficiency as percent of existing revenue)"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`finance_tax_provision`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax provision metrics tracking current and deferred tax expense, accumulated deferred income taxes (ADIT), excess deferred taxes, and effective tax rates for financial reporting and regulatory rate-making"
  source: "`power_and_utilities`.`finance`.`tax_provision`"
  dimensions:
    - name: "provision_type"
      expr: provision_type
      comment: "Type of tax provision (e.g., quarterly, annual, amended)"
    - name: "provision_status"
      expr: provision_status
      comment: "Status of the tax provision (e.g., draft, approved, filed)"
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the tax provision"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the tax provision"
    - name: "federal_tax_jurisdiction"
      expr: federal_tax_jurisdiction
      comment: "Federal tax jurisdiction"
    - name: "state_tax_jurisdiction"
      expr: state_tax_jurisdiction
      comment: "State tax jurisdiction"
    - name: "rate_case_test_year_flag"
      expr: rate_case_test_year_flag
      comment: "Whether this provision is for a rate case test year"
  measures:
    - name: "total_tax_expense"
      expr: SUM(CAST(total_tax_expense AS DOUBLE))
      comment: "Total income tax expense (current plus deferred) for the period"
    - name: "total_current_federal_tax"
      expr: SUM(CAST(current_federal_tax_expense AS DOUBLE))
      comment: "Total current federal income tax expense"
    - name: "total_current_state_tax"
      expr: SUM(CAST(current_state_tax_expense AS DOUBLE))
      comment: "Total current state income tax expense"
    - name: "total_deferred_federal_tax"
      expr: SUM(CAST(deferred_federal_tax_expense AS DOUBLE))
      comment: "Total deferred federal income tax expense"
    - name: "total_deferred_state_tax"
      expr: SUM(CAST(deferred_state_tax_expense AS DOUBLE))
      comment: "Total deferred state income tax expense"
    - name: "total_adit_balance"
      expr: SUM(CAST(adit_balance AS DOUBLE))
      comment: "Total accumulated deferred income tax balance reducing rate base"
    - name: "total_excess_deferred_taxes"
      expr: SUM(CAST(excess_deferred_income_taxes AS DOUBLE))
      comment: "Total excess deferred income taxes from tax reform requiring amortization"
    - name: "total_pre_tax_income"
      expr: SUM(CAST(pre_tax_book_income AS DOUBLE))
      comment: "Total pre-tax book income before tax provision"
    - name: "total_taxable_income"
      expr: SUM(CAST(taxable_income AS DOUBLE))
      comment: "Total taxable income for tax return purposes"
    - name: "total_itc_unamortized"
      expr: SUM(CAST(itc_unamortized_balance AS DOUBLE))
      comment: "Total unamortized investment tax credit balance"
    - name: "avg_effective_tax_rate"
      expr: AVG(CAST(effective_tax_rate_pct AS DOUBLE))
      comment: "Average effective tax rate as percentage of pre-tax income"
    - name: "provision_count"
      expr: COUNT(DISTINCT tax_provision_id)
      comment: "Number of distinct tax provisions"
    - name: "book_tax_difference"
      expr: SUM((CAST(pre_tax_book_income AS DOUBLE)) - (CAST(taxable_income AS DOUBLE)))
      comment: "Total book-tax difference (pre-tax book income minus taxable income)"
$$;