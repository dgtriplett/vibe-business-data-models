-- Metric views for domain: technology | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`technology_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and operational metrics for technology applications"
  source: "`power_and_utilities_v2`.`technology`.`application`"
  dimensions:
    - name: "application_tier"
      expr: application_tier
      comment: "Tier classification of the application (e.g., enterprise, departmental)"
  measures:
    - name: "total_annual_cost_usd"
      expr: SUM(CAST(cost_annual_usd AS DOUBLE))
      comment: "Total annual cost across all applications in USD"
    - name: "average_annual_cost_usd"
      expr: AVG(CAST(cost_annual_usd AS DOUBLE))
      comment: "Average annual cost per application in USD"
    - name: "count_applications"
      expr: COUNT(1)
      comment: "Number of application records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`technology_change_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial impact and volume of technology change requests"
  source: "`power_and_utilities_v2`.`technology`.`change_request`"
  dimensions:
    - name: "change_type"
      expr: change_type
      comment: "High‑level category of the change (e.g., software, hardware)"
  measures:
    - name: "total_estimated_cost_usd"
      expr: SUM(CAST(estimated_cost AS DOUBLE))
      comment: "Sum of estimated costs for all change requests in USD"
    - name: "total_actual_cost_usd"
      expr: SUM(CAST(actual_cost AS DOUBLE))
      comment: "Sum of actual costs incurred for change requests in USD"
    - name: "count_change_requests"
      expr: COUNT(1)
      comment: "Total number of change request records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`technology_cyber_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Risk‑focused metrics for cyber security incidents"
  source: "`power_and_utilities_v2`.`technology`.`cyber_incident`"
  dimensions:
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the cyber incident (e.g., malware, phishing)"
  measures:
    - name: "total_impact_estimate_usd"
      expr: SUM(CAST(impact_estimate_usd AS DOUBLE))
      comment: "Aggregate estimated financial impact of cyber incidents in USD"
    - name: "count_cyber_incidents"
      expr: COUNT(1)
      comment: "Number of cyber incident records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`technology_it_service`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Budgetary and reliability metrics for IT services"
  source: "`power_and_utilities_v2`.`technology`.`it_service`"
  dimensions:
    - name: "it_service_category"
      expr: it_service_category
      comment: "Business category of the IT service"
  measures:
    - name: "total_annual_budget_usd"
      expr: SUM(CAST(annual_budget_amount AS DOUBLE))
      comment: "Total annual budget allocated to IT services in USD"
    - name: "average_availability_target_percent"
      expr: AVG(CAST(availability_target_percent AS DOUBLE))
      comment: "Average availability target percentage across services"
    - name: "count_it_services"
      expr: COUNT(1)
      comment: "Number of IT service records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`technology_tech_project`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial performance and ROI metrics for technology projects"
  source: "`power_and_utilities_v2`.`technology`.`tech_project`"
  dimensions:
    - name: "tech_project_status"
      expr: tech_project_status
      comment: "Current lifecycle status of the technology project"
  measures:
    - name: "total_budget_amount_usd"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to technology projects in USD"
    - name: "total_actual_spend_usd"
      expr: SUM(CAST(actual_spend AS DOUBLE))
      comment: "Total actual spend for technology projects in USD"
    - name: "average_actual_roi_percent"
      expr: AVG(CAST(actual_roi_percent AS DOUBLE))
      comment: "Average actual ROI percent across projects"
    - name: "count_tech_projects"
      expr: COUNT(1)
      comment: "Number of technology project records"
$$;