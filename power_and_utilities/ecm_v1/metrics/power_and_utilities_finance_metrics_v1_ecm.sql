-- Metric views for domain: finance | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`finance_ap_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key payable metrics derived from AP invoices"
  source: "`power_and_utilities_v2`.`finance`.`ap_invoice`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the invoice"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., month) of the invoice"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Current status of the invoice"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the invoice amounts"
    - name: "is_intercompany"
      expr: is_intercompany
      comment: "Flag indicating inter‑company invoice"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross amount of all AP invoices"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net amount after discounts and taxes"
    - name: "total_discount_amount"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount granted on AP invoices"
    - name: "invoice_count"
      expr: COUNT(1)
      comment: "Number of AP invoice records"
    - name: "distinct_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors invoiced"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`finance_ar_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Receivable performance metrics from AR transactions"
  source: "`power_and_utilities_v2`.`finance`.`ar_transaction`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the transaction"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of the transaction"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the AR transaction"
    - name: "revenue_category"
      expr: revenue_category
      comment: "Revenue classification"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "is_intercompany"
      expr: intercompany_flag
      comment: "Flag indicating inter‑company transaction"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(invoice_amount AS DOUBLE))
      comment: "Total invoiced amount to customers"
    - name: "total_paid_amount"
      expr: SUM(CAST(paid_amount AS DOUBLE))
      comment: "Total amount actually received"
    - name: "total_outstanding_balance"
      expr: SUM(CAST(outstanding_balance AS DOUBLE))
      comment: "Total amount still due"
    - name: "transaction_count"
      expr: COUNT(1)
      comment: "Number of AR transaction records"
    - name: "distinct_counterparty_count"
      expr: COUNT(DISTINCT counterparty_id)
      comment: "Number of unique customers/counterparties"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`finance_fixed_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset valuation and depreciation health metrics"
  source: "`power_and_utilities_v2`.`finance`.`fixed_asset`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Classification of the asset (e.g., plant, equipment)"
    - name: "asset_status"
      expr: asset_status
      comment: "Current operational status of the asset"
    - name: "in_service_year"
      expr: YEAR(in_service_date)
      comment: "Year the asset entered service"
    - name: "depreciation_start_year"
      expr: YEAR(depreciation_start_date)
      comment: "Year depreciation began for the asset"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center responsible for the asset"
  measures:
    - name: "total_original_cost"
      expr: SUM(CAST(original_cost AS DOUBLE))
      comment: "Sum of original acquisition cost for all fixed assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across assets"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Aggregate net book value of the asset portfolio"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of fixed asset records"
    - name: "average_useful_life_years"
      expr: AVG(CAST(useful_life_years AS DOUBLE))
      comment: "Average useful life (years) of assets"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`finance_financial_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core financial health indicators from consolidated statements"
  source: "`power_and_utilities_v2`.`finance`.`financial_statement`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of the statement"
    - name: "fiscal_quarter"
      expr: fiscal_quarter
      comment: "Fiscal quarter (Q1‑Q4)"
    - name: "statement_type"
      expr: statement_type
      comment: "Type of financial statement (e.g., balance_sheet, income_statement)"
    - name: "reporting_unit"
      expr: reporting_unit
      comment: "Reporting unit or segment"
  measures:
    - name: "total_revenue"
      expr: SUM(CAST(total_revenue_amt AS DOUBLE))
      comment: "Total revenue reported in financial statements"
    - name: "total_ebitda"
      expr: SUM(CAST(ebitda_amt AS DOUBLE))
      comment: "Total EBITDA across statements"
    - name: "total_net_income"
      expr: SUM(CAST(net_income_amt AS DOUBLE))
      comment: "Aggregate net income"
    - name: "total_assets"
      expr: SUM(CAST(total_assets_amt AS DOUBLE))
      comment: "Sum of total assets"
    - name: "total_liabilities"
      expr: SUM(CAST(total_liabilities_amt AS DOUBLE))
      comment: "Sum of total liabilities"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`finance_budget`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budget planning and control metrics"
  source: "`power_and_utilities_v2`.`finance`.`budget`"
  dimensions:
    - name: "fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year the budget applies to"
    - name: "fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period (e.g., month) of the budget"
    - name: "budget_type"
      expr: budget_type
      comment: "Classification of the budget (e.g., operating, capital)"
    - name: "budget_category"
      expr: budget_category
      comment: "Business category of the budget"
    - name: "cost_center_id"
      expr: cost_center_id
      comment: "Cost center associated with the budget"
  measures:
    - name: "total_planned_amount"
      expr: SUM(CAST(planned_amount AS DOUBLE))
      comment: "Total budgeted amount across all lines"
    - name: "budget_line_count"
      expr: COUNT(1)
      comment: "Number of budget line records"
    - name: "average_variance_threshold_pct"
      expr: AVG(CAST(variance_threshold_pct AS DOUBLE))
      comment: "Average variance tolerance percentage across budgets"
$$;