-- Metric views for domain: customer | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health of customer accounts"
  source: "`power_and_utilities_v2`.`customer`.`customer_account`"
  dimensions:
    - name: "account_type"
      expr: account_type
      comment: "Type of account (e.g., Residential, Commercial)"
    - name: "account_status"
      expr: customer_account_status
      comment: "Current status of the account"
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_from)
      comment: "Month when the account became effective"
  measures:
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all customer accounts (USD)"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`customer_complaint`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Complaint handling performance"
  source: "`power_and_utilities_v2`.`customer`.`complaint`"
  dimensions:
    - name: "complaint_status"
      expr: complaint_status
      comment: "Current status of the complaint (e.g., Open, Closed)"
    - name: "complaint_type"
      expr: complaint_type
      comment: "Category of the complaint"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the complaint"
    - name: "complaint_month"
      expr: DATE_TRUNC('month', created_timestamp)
      comment: "Month the complaint was created"
  measures:
    - name: "total_complaints"
      expr: COUNT(1)
      comment: "Total number of complaints received"
    - name: "resolved_complaints"
      expr: COUNT(CASE WHEN resolution_status = 'Resolved' THEN 1 END)
      comment: "Number of complaints that have been resolved"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`customer_service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Projected consumption and contract activity"
  source: "`power_and_utilities_v2`.`customer`.`service_agreement`"
  dimensions:
    - name: "service_agreement_status"
      expr: service_agreement_status
      comment: "Current status of the service agreement"
    - name: "rate_schedule_id"
      expr: rate_schedule_id
      comment: "Identifier of the rate schedule applied"
    - name: "contract_start_month"
      expr: DATE_TRUNC('month', contract_start_date)
      comment: "Month when the contract started"
  measures:
    - name: "total_estimated_annual_usage_mwh"
      expr: SUM(CAST(estimated_annual_usage_mwh AS DOUBLE))
      comment: "Sum of estimated annual usage (MWh) across all service agreements"
    - name: "average_monthly_usage_kwh"
      expr: AVG(CAST(estimated_monthly_usage_kwh AS DOUBLE))
      comment: "Average estimated monthly usage (kWh) per agreement"
    - name: "active_service_agreements"
      expr: COUNT(CASE WHEN service_agreement_status = 'Active' THEN 1 END)
      comment: "Number of service agreements that are currently active"
$$;