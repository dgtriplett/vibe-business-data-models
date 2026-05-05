-- Metric views for domain: asset | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`asset_capex_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and schedule health of capital projects"
  source: "`power_and_utilities_v2`.`asset`.`asset_capex_project`"
  dimensions:
    - name: "project_status"
      expr: project_status
      comment: "Current status of the project"
    - name: "project_type"
      expr: project_type
      comment: "Category or type of the project"
    - name: "geographic_region"
      expr: geographic_region
      comment: "Geographic region where the project is located"
    - name: "in_service_year"
      expr: DATE_TRUNC('year', in_service_date_actual)
      comment: "Year the asset entered service"
  measures:
    - name: "total_actual_spend"
      expr: SUM(CAST(actual_spend_to_date_amount AS DOUBLE))
      comment: "Cumulative actual spend to date for capital projects"
    - name: "total_budget_variance"
      expr: SUM(CAST(budget_variance_amount AS DOUBLE))
      comment: "Sum of budget variance amounts across projects"
    - name: "average_forecast_at_completion"
      expr: AVG(CAST(forecast_at_completion_amount AS DOUBLE))
      comment: "Average forecasted cost at completion for projects"
    - name: "project_count"
      expr: COUNT(1)
      comment: "Number of capital projects"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`asset_depreciation_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Depreciation accounting metrics for asset portfolio"
  source: "`power_and_utilities_v2`.`asset`.`depreciation_schedule`"
  dimensions:
    - name: "asset_category"
      expr: asset_category
      comment: "High‑level category of the asset"
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code used for accounting"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Method used to calculate depreciation"
    - name: "schedule_year"
      expr: DATE_TRUNC('year', schedule_effective_date)
      comment: "Fiscal year of the depreciation schedule"
  measures:
    - name: "total_annual_depreciation_expense"
      expr: SUM(CAST(annual_depreciation_expense AS DOUBLE))
      comment: "Total annual depreciation expense for assets"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Cumulative depreciation recorded to date"
    - name: "average_book_reserve_percentage"
      expr: AVG(CAST(book_reserve_percentage AS DOUBLE))
      comment: "Average reserve percentage applied to book values"
    - name: "asset_count"
      expr: COUNT(1)
      comment: "Number of asset depreciation records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`asset_failure_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability and outage impact metrics for asset failures"
  source: "`power_and_utilities_v2`.`asset`.`failure_event`"
  dimensions:
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity rating of the failure"
    - name: "failure_type"
      expr: failure_type
      comment: "Type/category of the failure"
    - name: "asset_criticality_tier"
      expr: asset_criticality_tier
      comment: "Criticality tier of the affected asset"
    - name: "failure_year"
      expr: DATE_TRUNC('year', failure_date)
      comment: "Year the failure occurred"
  measures:
    - name: "total_energy_not_supplied_mwh"
      expr: SUM(CAST(energy_not_supplied_mwh AS DOUBLE))
      comment: "Total megawatt‑hours of energy not supplied due to failures"
    - name: "total_load_lost_mw"
      expr: SUM(CAST(load_lost_mw AS DOUBLE))
      comment: "Total megawatt load lost across failure events"
    - name: "average_outage_duration_minutes"
      expr: AVG(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Average outage duration in minutes per failure event"
    - name: "failure_count"
      expr: COUNT(1)
      comment: "Number of recorded failure events"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`asset_risk_assessment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic risk assessment metrics for asset portfolio"
  source: "`power_and_utilities_v2`.`asset`.`risk_assessment`"
  dimensions:
    - name: "risk_tier"
      expr: risk_tier
      comment: "Risk tier classification (e.g., High, Medium, Low)"
    - name: "risk_driver_primary"
      expr: risk_driver_primary
      comment: "Primary driver influencing the risk"
    - name: "assessment_method"
      expr: assessment_method
      comment: "Methodology used for the risk assessment"
    - name: "assessment_year"
      expr: DATE_TRUNC('year', assessment_date)
      comment: "Year the risk assessment was performed"
  measures:
    - name: "average_composite_risk_index"
      expr: AVG(CAST(composite_risk_index AS DOUBLE))
      comment: "Average composite risk index across assessments"
    - name: "total_estimated_failure_cost_usd"
      expr: SUM(CAST(estimated_failure_cost_usd AS DOUBLE))
      comment: "Total estimated cost of potential failures in USD"
    - name: "high_risk_assessment_count"
      expr: SUM(CASE WHEN risk_tier = 'High' THEN 1 ELSE 0 END)
      comment: "Count of assessments classified as high risk"
    - name: "assessment_count"
      expr: COUNT(1)
      comment: "Total number of risk assessments"
$$;