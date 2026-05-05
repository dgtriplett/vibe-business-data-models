-- Metric views for domain: billing | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`billing_bill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key billing invoice KPIs at the bill level."
  source: "`power_and_utilities_v2`.`billing`.`bill`"
  dimensions:
    - name: "bill_status"
      expr: bill_status
      comment: "Current status of the bill"
    - name: "bill_type"
      expr: bill_type
      comment: "Type/category of the bill"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the bill"
    - name: "billing_month"
      expr: DATE_TRUNC('month', billing_period_start)
      comment: "Billing month"
    - name: "due_date"
      expr: due_date
      comment: "Bill due date"
    - name: "payment_status"
      expr: payment_status
      comment: "Payment status of the bill"
  measures:
    - name: "bill_count"
      expr: COUNT(1)
      comment: "Number of bills"
    - name: "total_bill_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Sum of total amount across bills"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Sum of tax amount across bills"
    - name: "average_bill_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average total amount per bill"
    - name: "average_kwh_per_bill"
      expr: AVG(CAST(total_kwh AS DOUBLE))
      comment: "Average kilowatt-hours per bill"
    - name: "revenue_recognition_total"
      expr: SUM(CAST(revenue_recognition_amount AS DOUBLE))
      comment: "Total revenue recognized"
    - name: "paid_bill_count"
      expr: COUNT(CASE WHEN payment_status = 'Paid' THEN 1 END)
      comment: "Number of bills with payment status Paid"
    - name: "unpaid_bill_count"
      expr: COUNT(CASE WHEN payment_status = 'Unpaid' THEN 1 END)
      comment: "Number of bills with payment status Unpaid"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment transaction KPIs."
  source: "`power_and_utilities_v2`.`billing`.`payment`"
  dimensions:
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for payment"
    - name: "payment_status"
      expr: payment_status
      comment: "Status of the payment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment"
    - name: "payment_month"
      expr: DATE_TRUNC('month', payment_timestamp)
      comment: "Month of payment"
    - name: "is_auto_pay"
      expr: is_auto_pay
      comment: "Whether payment was auto‑pay"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of payment records"
    - name: "total_payment_amount"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross payment amount"
    - name: "total_refund_amount"
      expr: SUM(CAST(CASE WHEN is_refund THEN amount_gross ELSE 0 END AS DOUBLE))
      comment: "Total amount refunded"
    - name: "average_payment_amount"
      expr: AVG(CAST(amount_gross AS DOUBLE))
      comment: "Average gross payment amount"
    - name: "auto_pay_payment_count"
      expr: COUNT(CASE WHEN is_auto_pay THEN 1 END)
      comment: "Count of auto‑pay payments"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`billing_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Adjustment transaction KPIs."
  source: "`power_and_utilities_v2`.`billing`.`adjustment`"
  dimensions:
    - name: "adjustment_type"
      expr: adjustment_type
      comment: "Type of adjustment"
    - name: "adjustment_status"
      expr: adjustment_status
      comment: "Current status of adjustment"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of adjustment"
    - name: "adjustment_month"
      expr: DATE_TRUNC('month', adjustment_timestamp)
      comment: "Month of adjustment"
  measures:
    - name: "adjustment_count"
      expr: COUNT(1)
      comment: "Number of adjustments"
    - name: "total_gross_adjustment"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Sum of gross adjustment amounts"
    - name: "total_net_adjustment"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Sum of net adjustment amounts"
    - name: "average_gross_adjustment"
      expr: AVG(CAST(amount_gross AS DOUBLE))
      comment: "Average gross adjustment amount"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`billing_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Account‑level financial health KPIs."
  source: "`power_and_utilities_v2`.`billing`.`billing_account`"
  dimensions:
    - name: "account_class"
      expr: account_class
      comment: "Classification of the account"
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle code"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the account balances"
    - name: "is_suspended"
      expr: is_suspended
      comment: "Whether the account is suspended"
    - name: "account_status"
      expr: billing_account_status
      comment: "Current status of the billing account"
  measures:
    - name: "account_count"
      expr: COUNT(1)
      comment: "Number of billing accounts"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Sum of current balances across accounts"
    - name: "total_arrears_balance"
      expr: SUM(CAST(arrears_balance AS DOUBLE))
      comment: "Sum of arrears balances"
    - name: "average_current_balance"
      expr: AVG(CAST(current_balance AS DOUBLE))
      comment: "Average current balance per account"
    - name: "suspended_account_count"
      expr: COUNT(CASE WHEN is_suspended THEN 1 END)
      comment: "Count of suspended accounts"
$$;