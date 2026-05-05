-- Metric views for domain: property | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`property_acquisition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key acquisition KPIs to monitor spend, pricing trends and critical infrastructure exposure"
  source: "`power_and_utilities_v2`.`property`.`acquisition`"
  dimensions:
    - name: "acquisition_status"
      expr: acquisition_status
      comment: "Current status of the acquisition (e.g., pending, closed)"
    - name: "acquisition_type"
      expr: acquisition_type
      comment: "Type of acquisition (e.g., purchase, lease)"
    - name: "country"
      expr: country
      comment: "Country where the acquisition took place"
    - name: "state"
      expr: state
      comment: "State/region of the acquisition"
    - name: "closing_year"
      expr: DATE_TRUNC('year', closing_date)
      comment: "Year the acquisition closed"
  measures:
    - name: "total_acquisition_cost"
      expr: SUM(CAST(purchase_price AS DOUBLE))
      comment: "Total purchase price of all acquisitions"
    - name: "average_acquisition_price"
      expr: AVG(CAST(purchase_price AS DOUBLE))
      comment: "Average purchase price per acquisition"
    - name: "acquisition_count"
      expr: COUNT(1)
      comment: "Number of acquisition records"
    - name: "critical_infrastructure_acquisition_count"
      expr: SUM(CASE WHEN is_critical_infrastructure THEN 1 ELSE 0 END)
      comment: "Count of acquisitions flagged as critical infrastructure"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`property_disposition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Disposition performance metrics for asset divestiture and profitability analysis"
  source: "`power_and_utilities_v2`.`property`.`disposition`"
  dimensions:
    - name: "disposition_type"
      expr: disposition_type
      comment: "Category of disposition (sale, transfer, etc.)"
    - name: "disposition_status"
      expr: disposition_status
      comment: "Current status of the disposition"
    - name: "effective_year"
      expr: DATE_TRUNC('year', effective_date)
      comment: "Year the disposition became effective"
  measures:
    - name: "total_gain_loss_amount"
      expr: SUM(CAST(gain_loss_amount AS DOUBLE))
      comment: "Total gain or loss across dispositions"
    - name: "average_gain_loss_amount"
      expr: AVG(CAST(gain_loss_amount AS DOUBLE))
      comment: "Average gain/loss per disposition"
    - name: "disposition_count"
      expr: COUNT(1)
      comment: "Number of disposition records"
    - name: "total_net_proceeds"
      expr: SUM(CAST(net_proceeds AS DOUBLE))
      comment: "Total net proceeds from dispositions"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`property_lease_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial health of lease portfolio measured by payment volumes and trends"
  source: "`power_and_utilities_v2`.`property`.`lease_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current processing status of the payment"
    - name: "payment_method"
      expr: payment_method
      comment: "Method used for the payment (e.g., ACH, credit card)"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the payment amount"
    - name: "payment_year"
      expr: DATE_TRUNC('year', payment_date)
      comment: "Year the payment was made"
  measures:
    - name: "total_lease_payment_gross"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Sum of gross lease payment amounts"
    - name: "total_lease_payment_net"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Sum of net lease payment amounts after adjustments"
    - name: "average_lease_payment_gross"
      expr: AVG(CAST(amount_gross AS DOUBLE))
      comment: "Average gross lease payment per transaction"
    - name: "lease_payment_count"
      expr: COUNT(1)
      comment: "Number of lease payment records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`property_facility_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational safety and compliance monitoring for facilities"
  source: "`power_and_utilities_v2`.`property`.`facility_inspection`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Identifier of the inspected facility"
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection (e.g., safety, environmental)"
    - name: "inspection_year"
      expr: DATE_TRUNC('year', inspection_date)
      comment: "Year the inspection took place"
  measures:
    - name: "inspection_count"
      expr: COUNT(1)
      comment: "Total number of facility inspections performed"
    - name: "compliant_inspection_count"
      expr: SUM(CASE WHEN compliance_flag THEN 1 ELSE 0 END)
      comment: "Count of inspections that were compliant"
    - name: "corrective_action_required_count"
      expr: SUM(CASE WHEN corrective_action_required THEN 1 ELSE 0 END)
      comment: "Count of inspections requiring corrective action"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`property_environmental_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental risk and remediation cost tracking for regulatory compliance"
  source: "`power_and_utilities_v2`.`property`.`environmental_condition`"
  dimensions:
    - name: "condition_type"
      expr: condition_type
      comment: "Type of environmental condition (e.g., soil, water)"
    - name: "condition_severity"
      expr: condition_severity
      comment: "Severity level of the condition"
    - name: "regulatory_agency"
      expr: regulatory_agency
      comment: "Agency overseeing the condition"
    - name: "discovery_year"
      expr: DATE_TRUNC('year', discovery_date)
      comment: "Year the condition was discovered"
  measures:
    - name: "total_actual_remediation_cost"
      expr: SUM(CAST(actual_remediation_cost AS DOUBLE))
      comment: "Total actual cost incurred for environmental remediation"
    - name: "average_actual_remediation_cost"
      expr: AVG(CAST(actual_remediation_cost AS DOUBLE))
      comment: "Average remediation cost per condition"
    - name: "environmental_condition_count"
      expr: COUNT(1)
      comment: "Number of environmental condition records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`property_tax_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Tax revenue and assessment overview for financial planning"
  source: "`power_and_utilities_v2`.`property`.`tax_record`"
  dimensions:
    - name: "tax_year"
      expr: tax_year
      comment: "Fiscal year of the tax record"
    - name: "tax_type"
      expr: tax_type
      comment: "Type of tax (e.g., property, sales)"
    - name: "county"
      expr: county
      comment: "County jurisdiction for the tax"
    - name: "payment_status"
      expr: payment_status
      comment: "Current payment status of the tax bill"
  measures:
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount billed"
    - name: "total_assessed_value"
      expr: SUM(CAST(total_assessed_value AS DOUBLE))
      comment: "Aggregate assessed value of properties"
    - name: "tax_record_count"
      expr: COUNT(1)
      comment: "Number of tax record entries"
$$;