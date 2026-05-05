-- Metric views for domain: der | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`der_dispatch_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for dispatch events, including response and pricing metrics"
  source: "`power_and_utilities_v2`.`der`.`dispatch_event`"
  dimensions:
    - name: "market"
      expr: market
      comment: "Market where the dispatch occurred"
    - name: "dispatch_event_status"
      expr: dispatch_event_status
      comment: "Status of the dispatch event"
    - name: "is_emergency"
      expr: is_emergency
      comment: "Flag indicating if the dispatch was an emergency"
    - name: "is_automated"
      expr: is_automated
      comment: "Flag indicating if the dispatch was automated"
    - name: "dispatch_date"
      expr: DATE_TRUNC('day', dispatch_timestamp)
      comment: "Date of the dispatch event"
  measures:
    - name: "total_actual_response_mw"
      expr: SUM(CAST(actual_response AS DOUBLE))
      comment: "Total actual response (MW) across all dispatch events"
    - name: "avg_bid_price"
      expr: AVG(CAST(bid_price AS DOUBLE))
      comment: "Average bid price for dispatch events"
    - name: "avg_offer_price"
      expr: AVG(CAST(offer_price AS DOUBLE))
      comment: "Average offer price for dispatch events"
    - name: "total_lmp_reference"
      expr: SUM(CAST(lmp_reference AS DOUBLE))
      comment: "Sum of LMP reference values across dispatch events"
    - name: "total_dispatch_events"
      expr: COUNT(1)
      comment: "Count of dispatch events"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`der_bess_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational efficiency metrics for battery energy storage system (BESS) operations"
  source: "`power_and_utilities_v2`.`der`.`bess_operation`"
  dimensions:
    - name: "operation_mode"
      expr: operation_mode
      comment: "Operating mode of the BESS"
    - name: "health_status"
      expr: health_status
      comment: "Health status of the BESS"
    - name: "event_date"
      expr: DATE_TRUNC('day', event_timestamp)
      comment: "Date of the BESS event"
  measures:
    - name: "total_energy_throughput_kwh"
      expr: SUM(CAST(energy_throughput_kwh AS DOUBLE))
      comment: "Total energy throughput for BESS operations"
    - name: "avg_round_trip_efficiency_pct"
      expr: AVG(CAST(round_trip_efficiency_pct AS DOUBLE))
      comment: "Average round‑trip efficiency percentage"
    - name: "avg_degradation_estimate_pct"
      expr: AVG(CAST(degradation_estimate_pct AS DOUBLE))
      comment: "Average degradation estimate percentage"
    - name: "avg_power_setpoint_kw"
      expr: AVG(CAST(power_setpoint_kw AS DOUBLE))
      comment: "Average power setpoint (kW)"
    - name: "total_bess_operations"
      expr: COUNT(1)
      comment: "Count of BESS operation records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`der_program_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic enrollment metrics for Distributed Energy Resource (DER) programs"
  source: "`power_and_utilities_v2`.`der`.`der_program_enrollment`"
  dimensions:
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current status of the enrollment"
    - name: "region_code"
      expr: region_code
      comment: "Geographic region code of the enrollment"
    - name: "voltage_level"
      expr: voltage_level
      comment: "Voltage level associated with the enrollment"
    - name: "is_aggregated"
      expr: is_aggregated
      comment: "Flag indicating if the enrollment is aggregated"
    - name: "enrollment_month"
      expr: DATE_TRUNC('month', enrollment_date)
      comment: "Month of enrollment"
  measures:
    - name: "total_enrolled_capacity_mw"
      expr: SUM(CAST(capacity_kw AS DOUBLE))
      comment: "Total capacity (MW) enrolled in DER programs"
    - name: "avg_incentive_amount"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount per enrollment"
    - name: "enrollment_count"
      expr: COUNT(1)
      comment: "Number of DER program enrollments"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`der_performance_summary`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for DER asset performance summaries"
  source: "`power_and_utilities_v2`.`der`.`performance_summary`"
  dimensions:
    - name: "performance_summary_status"
      expr: performance_summary_status
      comment: "Status of the performance summary record"
    - name: "period_year"
      expr: DATE_TRUNC('year', period_start_date)
      comment: "Year of the performance period"
    - name: "period_month"
      expr: DATE_TRUNC('month', period_start_date)
      comment: "Month of the performance period"
  measures:
    - name: "total_actual_output_kwh"
      expr: SUM(CAST(actual_output_kwh AS DOUBLE))
      comment: "Total actual output (kWh) across performance periods"
    - name: "total_expected_output_kwh"
      expr: SUM(CAST(expected_output_kwh AS DOUBLE))
      comment: "Total expected output (kWh) across performance periods"
    - name: "avg_capacity_factor_pct"
      expr: AVG(CAST(capacity_factor_pct AS DOUBLE))
      comment: "Average capacity factor percentage"
    - name: "avg_availability_factor_pct"
      expr: AVG(CAST(availability_factor_pct AS DOUBLE))
      comment: "Average availability factor percentage"
    - name: "avg_performance_ratio_pct"
      expr: AVG(CAST(performance_ratio_pct AS DOUBLE))
      comment: "Average performance ratio percentage"
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of performance summary records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`der_microgrid`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic operational metrics for microgrid deployments"
  source: "`power_and_utilities_v2`.`der`.`microgrid`"
  dimensions:
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if the microgrid is designated critical"
    - name: "microgrid_status"
      expr: microgrid_status
      comment: "Operational status of the microgrid"
    - name: "microgrid_type"
      expr: microgrid_type
      comment: "Type/category of the microgrid"
  measures:
    - name: "total_critical_load_kw"
      expr: SUM(CAST(critical_load_kw AS DOUBLE))
      comment: "Total critical load (kW) served by microgrids"
    - name: "avg_storage_capacity_kwh"
      expr: AVG(CAST(storage_capacity_kwh AS DOUBLE))
      comment: "Average storage capacity (kWh) of microgrids"
    - name: "total_microgrid_capacity_kw"
      expr: SUM(CAST(capacity_kw AS DOUBLE))
      comment: "Total installed capacity (kW) of microgrids"
    - name: "microgrid_count"
      expr: COUNT(1)
      comment: "Number of microgrid records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`der_nem_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and capacity metrics for Net Energy Metering (NEM) accounts"
  source: "`power_and_utilities_v2`.`der`.`nem_account`"
  dimensions:
    - name: "net_metering_status"
      expr: net_metering_status
      comment: "Current status of net metering"
    - name: "net_metering_type"
      expr: net_metering_type
      comment: "Type of net metering arrangement"
    - name: "vpp_participation_flag"
      expr: vpp_participation_flag
      comment: "Flag indicating participation in virtual power plant programs"
    - name: "regulatory_reporting_flag"
      expr: regulatory_reporting_flag
      comment: "Flag indicating if regulatory reporting is required"
  measures:
    - name: "total_net_metering_capacity_kw"
      expr: SUM(CAST(net_metering_capacity_kw AS DOUBLE))
      comment: "Total net metering capacity (kW) across NEM accounts"
    - name: "avg_export_compensation_rate"
      expr: AVG(CAST(export_compensation_rate AS DOUBLE))
      comment: "Average export compensation rate"
    - name: "total_credit_balance"
      expr: SUM(CAST(credit_balance AS DOUBLE))
      comment: "Total credit balance across NEM accounts"
    - name: "nem_account_count"
      expr: COUNT(1)
      comment: "Number of NEM accounts"
$$;