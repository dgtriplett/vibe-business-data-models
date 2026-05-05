-- Metric views for domain: metering | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`metering_service_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated consumption and infrastructure metrics for metering service points."
  source: "`power_and_utilities_v2`.`metering`.`metering_service_point`"
  dimensions:
    - name: "state"
      expr: state
      comment: "State where the service point is located."
    - name: "city"
      expr: city
      comment: "City of the service point."
    - name: "service_type"
      expr: service_type
      comment: "Type of service (electric, gas)."
    - name: "is_critical_infrastructure"
      expr: is_critical_infrastructure
      comment: "Flag indicating critical infrastructure."
    - name: "service_point_status"
      expr: metering_service_point_status
      comment: "Operational status of the service point."
    - name: "created_date"
      expr: DATE_TRUNC('day', created_timestamp)
      comment: "Date the service point record was created."
  measures:
    - name: "total_estimated_annual_consumption_kwh"
      expr: SUM(CAST(estimated_annual_consumption_kwh AS DOUBLE))
      comment: "Sum of estimated annual consumption (kWh) for service points."
    - name: "critical_infra_count"
      expr: SUM(CASE WHEN is_critical_infrastructure THEN 1 ELSE 0 END)
      comment: "Number of critical infrastructure service points."
    - name: "avg_service_voltage_kv"
      expr: AVG(CAST(service_voltage_kv AS DOUBLE))
      comment: "Average service voltage (kV) across service points."
    - name: "total_service_points"
      expr: COUNT(1)
      comment: "Total number of service point records."
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`metering_tou_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Time‑of‑Use schedule pricing and configuration metrics."
  source: "`power_and_utilities_v2`.`metering`.`tou_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of TOU schedule (e.g., peak, off‑peak)."
    - name: "season"
      expr: season
      comment: "Season associated with the schedule."
    - name: "day_type"
      expr: day_type
      comment: "Day type (weekday, weekend, holiday)."
    - name: "is_default"
      expr: is_default
      comment: "Indicates if this schedule is the default."
    - name: "effective_start_date"
      expr: DATE_TRUNC('day', effective_start_date)
      comment: "Start date of schedule effectiveness."
  measures:
    - name: "avg_price_multiplier"
      expr: AVG(CAST(price_multiplier AS DOUBLE))
      comment: "Average price multiplier across TOU schedules."
    - name: "default_schedule_count"
      expr: SUM(CASE WHEN is_default THEN 1 ELSE 0 END)
      comment: "Count of schedules marked as default."
    - name: "total_schedules"
      expr: COUNT(1)
      comment: "Total number of TOU schedule records."
$$;