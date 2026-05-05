-- Metric views for domain: gridops | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`gridops_alarm_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key alarm event metrics for operational awareness and reliability management."
  source: "`power_and_utilities_v2`.`gridops`.`alarm_event`"
  dimensions:
    - name: "balancing_area_id"
      expr: balancing_area_id
      comment: "Balancing area identifier."
    - name: "control_zone_id"
      expr: control_zone_id
      comment: "Control zone identifier."
    - name: "alarm_category"
      expr: alarm_category
      comment: "Category of the alarm (e.g., Critical, Warning)."
    - name: "alarm_state"
      expr: alarm_state
      comment: "Current state of the alarm (e.g., Active, Cleared)."
    - name: "alarm_date"
      expr: DATE_TRUNC('day', alarm_timestamp)
      comment: "Date of the alarm occurrence."
  measures:
    - name: "total_alarms"
      expr: COUNT(1)
      comment: "Total number of alarm events."
    - name: "critical_alarms"
      expr: SUM(CASE WHEN alarm_category = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of alarms classified as Critical severity."
    - name: "acknowledged_alarms"
      expr: SUM(CASE WHEN acknowledged_flag THEN 1 ELSE 0 END)
      comment: "Number of alarms that have been acknowledged by an operator."
    - name: "shelved_alarms"
      expr: SUM(CASE WHEN shelved_flag THEN 1 ELSE 0 END)
      comment: "Number of alarms that were shelved."
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`gridops_dr_dispatch_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand response dispatch effectiveness and compliance metrics."
  source: "`power_and_utilities_v2`.`gridops`.`dr_dispatch_event`"
  dimensions:
    - name: "balancing_area_id"
      expr: balancing_area_id
      comment: "Balancing area where the dispatch occurred."
    - name: "employee_id"
      expr: employee_id
      comment: "Employee responsible for the dispatch."
    - name: "dispatch_status"
      expr: dispatch_status
      comment: "Current status of the dispatch (e.g., Issued, Completed)."
    - name: "dispatch_start_date"
      expr: DATE_TRUNC('day', dispatch_start_timestamp)
      comment: "Date the dispatch was started."
  measures:
    - name: "total_dispatches"
      expr: COUNT(1)
      comment: "Total number of demand response dispatch events."
    - name: "total_actual_reduction_mw"
      expr: SUM(CAST(actual_mw_reduction AS DOUBLE))
      comment: "Aggregate megawatts actually reduced across all dispatches."
    - name: "average_performance_percentage"
      expr: AVG(CAST(performance_percentage AS DOUBLE))
      comment: "Average performance percentage of DR dispatches."
    - name: "compliant_dispatches"
      expr: SUM(CASE WHEN compliance_status = 'Compliant' THEN 1 ELSE 0 END)
      comment: "Count of dispatches that met compliance criteria."
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`gridops_energy_balance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy balance summary metrics to monitor supply‑demand equilibrium and generation mix."
  source: "`power_and_utilities_v2`.`gridops`.`energy_balance`"
  dimensions:
    - name: "balancing_area_id"
      expr: balancing_area_id
      comment: "Balancing area identifier."
    - name: "operating_date"
      expr: operating_date
      comment: "Date of the operating interval."
    - name: "record_status"
      expr: record_status
      comment: "Status flag for the record (e.g., Finalized, Draft)."
  measures:
    - name: "total_load_mwh"
      expr: SUM(CAST(total_load_mwh AS DOUBLE))
      comment: "Total load recorded in megawatt-hours."
    - name: "total_generation_mwh"
      expr: SUM(CAST(total_generation_mwh AS DOUBLE))
      comment: "Total generation recorded in megawatt-hours."
    - name: "total_renewable_generation_mwh"
      expr: SUM(CAST(renewable_generation_mwh AS DOUBLE))
      comment: "Total renewable generation in megawatt-hours."
    - name: "total_fossil_generation_mwh"
      expr: SUM(CAST(fossil_generation_mwh AS DOUBLE))
      comment: "Total fossil generation in megawatt-hours."
    - name: "average_frequency_hz"
      expr: AVG(CAST(frequency_hz AS DOUBLE))
      comment: "Average system frequency in hertz for the interval."
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`gridops_outage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outage event metrics for reliability and impact assessment."
  source: "`power_and_utilities_v2`.`gridops`.`gridops_outage_event`"
  dimensions:
    - name: "balancing_area_id"
      expr: balancing_area_id
      comment: "Balancing area where the outage occurred."
    - name: "outage_cause_code"
      expr: outage_cause_code
      comment: "Code describing the cause of the outage."
    - name: "outage_type"
      expr: outage_type
      comment: "Type of outage (e.g., Planned, Unplanned)."
    - name: "outage_start_date"
      expr: DATE_TRUNC('day', outage_start_timestamp)
      comment: "Date the outage started."
    - name: "critical_infrastructure_affected_flag"
      expr: critical_infrastructure_affected_flag
      comment: "Flag indicating if critical infrastructure was affected."
  measures:
    - name: "total_outages"
      expr: COUNT(1)
      comment: "Total number of outage events recorded."
    - name: "total_customer_minutes_interrupted"
      expr: SUM(CAST(customer_minutes_interrupted AS DOUBLE))
      comment: "Aggregate customer‑minutes of interruption across all outages."
    - name: "critical_infrastructure_outages"
      expr: SUM(CASE WHEN critical_infrastructure_affected_flag THEN 1 ELSE 0 END)
      comment: "Count of outages that impacted critical infrastructure."
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`gridops_load_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load forecast accuracy and volume metrics to support planning and reliability operations."
  source: "`power_and_utilities_v2`.`gridops`.`load_forecast`"
  dimensions:
    - name: "balancing_area_id"
      expr: balancing_area_id
      comment: "Balancing area for the forecast."
    - name: "forecast_date"
      expr: forecast_date
      comment: "Date of the forecast."
    - name: "is_peak_period"
      expr: is_peak_period
      comment: "Flag indicating if the forecast is for a peak period."
    - name: "is_reliability_event"
      expr: is_reliability_event
      comment: "Flag indicating if the forecast is tied to a reliability event."
  measures:
    - name: "total_forecasted_demand_mw"
      expr: SUM(CAST(forecasted_demand_mw AS DOUBLE))
      comment: "Total forecasted demand in megawatts."
    - name: "total_actual_demand_mw"
      expr: SUM(CAST(actual_demand_mw AS DOUBLE))
      comment: "Total actual demand in megawatts."
    - name: "total_forecast_error_mwh"
      expr: SUM(CAST(forecast_error_mw AS DOUBLE))
      comment: "Aggregate forecast error in megawatt‑hours."
    - name: "average_forecast_error_pct"
      expr: AVG(CAST(forecast_error_pct AS DOUBLE))
      comment: "Average forecast error percentage across all forecasts."
$$;