-- Metric views for domain: safety | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`safety_incident`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core incident KPI view for safety leadership"
  source: "`power_and_utilities_v2`.`safety`.`incident`"
  dimensions:
    - name: "incident_year"
      expr: YEAR(incident_timestamp)
      comment: "Calendar year of the incident"
    - name: "incident_month"
      expr: MONTH(incident_timestamp)
      comment: "Calendar month of the incident"
    - name: "incident_type"
      expr: incident_type
      comment: "Classification of the incident (e.g., Spill, Fire, Electrical)"
    - name: "severity"
      expr: severity
      comment: "Severity level assigned to the incident"
    - name: "incident_status"
      expr: incident_status
      comment: "Current status of the incident (Open, Closed, etc.)"
    - name: "facility_id"
      expr: facility_id
      comment: "Facility where the incident occurred"
  measures:
    - name: "total_incidents"
      expr: COUNT(1)
      comment: "Total number of safety incidents recorded"
    - name: "fatality_incidents"
      expr: SUM(CASE WHEN fatality_flag THEN 1 ELSE 0 END)
      comment: "Count of incidents that resulted in a fatality"
    - name: "near_miss_incidents"
      expr: SUM(CASE WHEN near_miss_flag THEN 1 ELSE 0 END)
      comment: "Count of near‑miss incidents"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`safety_audit_finding`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key audit‑finding metrics to monitor safety audit effectiveness"
  source: "`power_and_utilities_v2`.`safety`.`audit_finding`"
  dimensions:
    - name: "audit_year"
      expr: YEAR(audit_date)
      comment: "Year the audit was performed"
    - name: "audit_month"
      expr: MONTH(audit_date)
      comment: "Month the audit was performed"
    - name: "audit_type"
      expr: audit_type
      comment: "Type of audit (e.g., Internal, External)"
    - name: "audit_category"
      expr: audit_category
      comment: "Category of the audit finding"
    - name: "severity"
      expr: severity
      comment: "Severity level of the finding"
    - name: "location"
      expr: location
      comment: "Physical location tied to the finding"
  measures:
    - name: "total_findings"
      expr: COUNT(1)
      comment: "Total audit findings captured"
    - name: "critical_findings"
      expr: SUM(CASE WHEN severity = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of findings marked as Critical"
    - name: "open_findings"
      expr: SUM(CASE WHEN audit_finding_status = 'Open' THEN 1 ELSE 0 END)
      comment: "Findings that are still open"
    - name: "closed_findings"
      expr: SUM(CASE WHEN audit_finding_status = 'Closed' THEN 1 ELSE 0 END)
      comment: "Findings that have been closed"
    - name: "average_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across all findings"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`safety_corrective_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to track effectiveness and cost of corrective actions"
  source: "`power_and_utilities_v2`.`safety`.`corrective_action`"
  dimensions:
    - name: "action_type"
      expr: action_type
      comment: "Category of corrective action"
    - name: "priority"
      expr: priority
      comment: "Priority level assigned to the action"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level associated with the action"
    - name: "is_closed"
      expr: is_closed
      comment: "Whether the action is closed (True/False)"
    - name: "facility_id"
      expr: facility_id
      comment: "Facility linked to the corrective action"
  measures:
    - name: "total_actions"
      expr: COUNT(1)
      comment: "Total corrective actions recorded"
    - name: "closed_actions"
      expr: SUM(CASE WHEN is_closed THEN 1 ELSE 0 END)
      comment: "Number of actions that have been closed"
    - name: "average_cost_estimate"
      expr: AVG(CAST(cost_estimate AS DOUBLE))
      comment: "Average estimated cost of corrective actions"
    - name: "average_cost_actual"
      expr: AVG(CAST(cost_actual AS DOUBLE))
      comment: "Average actual cost incurred for corrective actions"
    - name: "overdue_actions"
      expr: SUM(CASE WHEN target_completion_date < CURRENT_DATE() AND NOT is_closed THEN 1 ELSE 0 END)
      comment: "Count of actions past target completion date and not closed"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`safety_emergency_drill`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Drill performance and cost metrics for safety readiness"
  source: "`power_and_utilities_v2`.`safety`.`emergency_drill`"
  dimensions:
    - name: "drill_year"
      expr: YEAR(drill_timestamp)
      comment: "Year the drill took place"
    - name: "drill_month"
      expr: MONTH(drill_timestamp)
      comment: "Month the drill took place"
    - name: "drill_type"
      expr: drill_type
      comment: "Type of emergency drill"
    - name: "drill_status"
      expr: emergency_drill_status
      comment: "Current status of the drill"
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where the drill was performed"
  measures:
    - name: "total_drills"
      expr: COUNT(1)
      comment: "Total number of emergency drills conducted"
    - name: "average_drill_cost_actual"
      expr: AVG(CAST(drill_cost_actual AS DOUBLE))
      comment: "Average actual cost per drill"
    - name: "compliant_drills"
      expr: SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Count of drills that met compliance criteria"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`safety_environmental_compliance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental compliance KPIs to monitor emission performance and regulatory adherence"
  source: "`power_and_utilities_v2`.`safety`.`environmental_compliance`"
  dimensions:
    - name: "facility_id"
      expr: facility_id
      comment: "Facility associated with the compliance record"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Overall compliance status (Compliant, Non‑Compliant)"
  measures:
    - name: "total_records"
      expr: COUNT(1)
      comment: "Total environmental compliance records"
    - name: "compliant_records"
      expr: SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Number of records marked as compliant"
    - name: "average_measured_co2"
      expr: AVG(CAST(measured_co2_tons AS DOUBLE))
      comment: "Average measured CO2 emissions (tons)"
    - name: "co2_exceedance_count"
      expr: SUM(CASE WHEN exceedance_flag_co2 THEN 1 ELSE 0 END)
      comment: "Count of periods where CO2 emissions exceeded limits"
$$;