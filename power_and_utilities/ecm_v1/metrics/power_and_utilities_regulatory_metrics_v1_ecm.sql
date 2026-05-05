-- Metric views for domain: regulatory | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`regulatory_filing`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and timeliness KPIs for regulatory filings"
  source: "`power_and_utilities_v2`.`regulatory`.`filing`"
  dimensions:
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body responsible for the filing"
    - name: "filing_year"
      expr: DATE_TRUNC('year', filing_date)
      comment: "Year of filing"
    - name: "filing_month"
      expr: DATE_TRUNC('month', filing_date)
      comment: "Month of filing"
  measures:
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Sum of gross amounts for all regulatory filings"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Sum of net amounts for all regulatory filings"
    - name: "filing_count"
      expr: COUNT(1)
      comment: "Number of filing records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`regulatory_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key compliance obligation metrics for risk and penalty monitoring"
  source: "`power_and_utilities_v2`.`regulatory`.`compliance_obligation`"
  dimensions:
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the obligation"
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation"
    - name: "compliance_year"
      expr: DATE_TRUNC('year', compliance_deadline)
      comment: "Year of the compliance deadline"
  measures:
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total monetary penalties across obligations"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score for compliance obligations"
    - name: "obligation_count"
      expr: COUNT(1)
      comment: "Total number of compliance obligations"
    - name: "compliant_obligation_count"
      expr: SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Count of obligations with a compliant status"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`regulatory_rate_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and status metrics for regulatory rate cases"
  source: "`power_and_utilities_v2`.`regulatory`.`rate_case`"
  dimensions:
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction of the rate case"
    - name: "case_type"
      expr: case_type
      comment: "Type/category of the rate case"
    - name: "submission_year"
      expr: DATE_TRUNC('year', case_submission_deadline)
      comment: "Year the case was submitted"
  measures:
    - name: "total_authorized_revenue"
      expr: SUM(CAST(authorized_revenue_requirement AS DOUBLE))
      comment: "Sum of authorized revenue requirements across rate cases"
    - name: "total_requested_revenue"
      expr: SUM(CAST(requested_revenue_requirement AS DOUBLE))
      comment: "Sum of requested revenue requirements across rate cases"
    - name: "total_allowed_rate"
      expr: SUM(CAST(total_allowed_rate AS DOUBLE))
      comment: "Sum of total allowed rates across rate cases"
    - name: "rate_case_count"
      expr: COUNT(1)
      comment: "Number of rate case records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`regulatory_emission_allowance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emission allowance inventory and utilization metrics"
  source: "`power_and_utilities_v2`.`regulatory`.`emission_allowance`"
  dimensions:
    - name: "program_name"
      expr: program_name
      comment: "Program under which the allowance is issued"
    - name: "reporting_year"
      expr: DATE_TRUNC('year', reporting_period_start)
      comment: "Reporting year for the allowance"
  measures:
    - name: "total_quantity_tons"
      expr: SUM(CAST(quantity_tons AS DOUBLE))
      comment: "Total emission allowance quantity in tons"
    - name: "total_surrendered_quantity"
      expr: SUM(CAST(surrendered_quantity AS DOUBLE))
      comment: "Total surrendered emission allowance quantity"
    - name: "total_remaining_quantity"
      expr: SUM(CAST(remaining_quantity AS DOUBLE))
      comment: "Total remaining emission allowance quantity"
    - name: "allowance_record_count"
      expr: COUNT(1)
      comment: "Number of emission allowance records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`regulatory_docket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and volume metrics for regulatory dockets"
  source: "`power_and_utilities_v2`.`regulatory`.`docket`"
  dimensions:
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body handling the docket"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the docket"
    - name: "docket_year"
      expr: DATE_TRUNC('year', filing_date)
      comment: "Year the docket was filed"
  measures:
    - name: "total_regulatory_fee"
      expr: SUM(CAST(regulatory_fee_amount AS DOUBLE))
      comment: "Total regulatory fees across dockets"
    - name: "docket_count"
      expr: COUNT(1)
      comment: "Number of docket records"
$$;