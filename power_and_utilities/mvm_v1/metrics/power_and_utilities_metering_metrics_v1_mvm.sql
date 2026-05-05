-- Metric views for domain: metering | Business: Power and Utilities | Version: 1 | Generated on: 2026-04-29 23:09:06

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`metering_daily_usage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Daily energy consumption and demand metrics for billing, forecasting, and customer analytics"
  source: "`power_and_utilities`.`metering`.`daily_usage_summary`"
  dimensions:
    - name: "summary_date"
      expr: summary_date
      comment: "Date of the daily usage summary"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Type of commodity (electric, gas)"
    - name: "rate_schedule_code"
      expr: rate_schedule_code
      comment: "Rate schedule applied to the usage"
    - name: "meter_read_source"
      expr: meter_read_source
      comment: "Source of meter reading (AMI, manual, estimated)"
    - name: "vee_status"
      expr: vee_status
      comment: "Validation, estimation, and editing status"
    - name: "net_metering_flag"
      expr: net_metering_flag
      comment: "Indicates if net metering is enabled"
    - name: "dr_event_flag"
      expr: dr_event_flag
      comment: "Indicates if a demand response event occurred"
    - name: "outage_flag"
      expr: outage_flag
      comment: "Indicates if an outage occurred during the day"
    - name: "billing_ready_flag"
      expr: billing_ready_flag
      comment: "Indicates if data is ready for billing"
  measures:
    - name: "total_consumption_kwh"
      expr: SUM(CAST(total_consumption AS DOUBLE))
      comment: "Total energy consumption in kWh across all meters and days"
    - name: "total_net_consumption_kwh"
      expr: SUM(CAST(net_consumption_kwh AS DOUBLE))
      comment: "Total net consumption (consumption minus generation) in kWh"
    - name: "total_generation_kwh"
      expr: SUM(CAST(generation_kwh AS DOUBLE))
      comment: "Total energy generation in kWh from customer-owned generation"
    - name: "total_peak_demand_kw"
      expr: SUM(CAST(peak_demand_kw AS DOUBLE))
      comment: "Sum of peak demand in kW across all meters and days"
    - name: "avg_peak_demand_kw"
      expr: AVG(CAST(peak_demand_kw AS DOUBLE))
      comment: "Average peak demand in kW per daily summary record"
    - name: "total_on_peak_consumption_kwh"
      expr: SUM(CAST(on_peak_consumption AS DOUBLE))
      comment: "Total on-peak consumption in kWh for time-of-use analysis"
    - name: "total_off_peak_consumption_kwh"
      expr: SUM(CAST(off_peak_consumption AS DOUBLE))
      comment: "Total off-peak consumption in kWh for time-of-use analysis"
    - name: "on_peak_consumption_pct"
      expr: ROUND(100.0 * SUM(CAST(on_peak_consumption AS DOUBLE)) / NULLIF(SUM(CAST(total_consumption AS DOUBLE)), 0), 2)
      comment: "Percentage of total consumption occurring during on-peak periods"
    - name: "total_load_reduction_kwh"
      expr: SUM(CAST(load_reduction_kwh AS DOUBLE))
      comment: "Total load reduction achieved through demand response programs"
    - name: "avg_data_completeness_pct"
      expr: AVG(CAST(data_completeness_percentage AS DOUBLE))
      comment: "Average data completeness percentage across daily summaries"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score for metering data integrity monitoring"
    - name: "total_reactive_energy_kvarh"
      expr: SUM(CAST(reactive_energy_kvarh AS DOUBLE))
      comment: "Total reactive energy in kVARh for power quality analysis"
    - name: "avg_power_factor"
      expr: AVG(CAST(power_factor AS DOUBLE))
      comment: "Average power factor for power quality and efficiency analysis"
    - name: "unique_meters"
      expr: COUNT(DISTINCT meter_id)
      comment: "Count of unique meters with daily usage data"
    - name: "unique_service_points"
      expr: COUNT(DISTINCT service_point_id)
      comment: "Count of unique service points with daily usage data"
    - name: "unique_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Count of unique customer accounts with daily usage data"
    - name: "daily_summary_count"
      expr: COUNT(1)
      comment: "Total number of daily usage summary records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`metering_interval_reads`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Interval-level energy consumption and demand metrics for granular load analysis and forecasting"
  source: "`power_and_utilities`.`metering`.`interval_read`"
  dimensions:
    - name: "interval_start_timestamp"
      expr: interval_start_timestamp
      comment: "Start timestamp of the interval reading"
    - name: "interval_end_timestamp"
      expr: interval_end_timestamp
      comment: "End timestamp of the interval reading"
    - name: "interval_duration_minutes"
      expr: interval_duration_minutes
      comment: "Duration of the interval in minutes (typically 15, 30, or 60)"
    - name: "data_source"
      expr: data_source
      comment: "Source of interval data (AMI, SCADA, manual)"
    - name: "read_quality_code"
      expr: read_quality_code
      comment: "Quality code for the interval reading"
    - name: "vee_status"
      expr: vee_status
      comment: "Validation, estimation, and editing status"
    - name: "estimation_method"
      expr: estimation_method
      comment: "Method used for estimating missing or invalid intervals"
    - name: "exception_flag"
      expr: exception_flag
      comment: "Indicates if the interval has data quality exceptions"
    - name: "dr_event_flag"
      expr: dr_event_flag
      comment: "Indicates if a demand response event was active during this interval"
    - name: "power_outage_flag"
      expr: power_outage_flag
      comment: "Indicates if a power outage occurred during this interval"
    - name: "reverse_flow_flag"
      expr: reverse_flow_flag
      comment: "Indicates reverse energy flow (generation exceeding consumption)"
    - name: "billing_determinant_flag"
      expr: billing_determinant_flag
      comment: "Indicates if this interval is used for billing calculations"
    - name: "time_zone_code"
      expr: time_zone_code
      comment: "Time zone of the interval reading"
    - name: "dst_flag"
      expr: dst_flag
      comment: "Indicates if daylight saving time was in effect"
  measures:
    - name: "total_consumption_kwh"
      expr: SUM(CAST(consumption_value AS DOUBLE))
      comment: "Total energy consumption in kWh across all intervals"
    - name: "total_net_consumption_kwh"
      expr: SUM(CAST(net_consumption_value AS DOUBLE))
      comment: "Total net consumption (consumption minus generation) in kWh"
    - name: "total_demand_kw"
      expr: SUM(CAST(demand_value AS DOUBLE))
      comment: "Total demand in kW across all intervals"
    - name: "avg_demand_kw"
      expr: AVG(CAST(demand_value AS DOUBLE))
      comment: "Average demand in kW per interval"
    - name: "max_demand_kw"
      expr: MAX(CAST(demand_value AS DOUBLE))
      comment: "Maximum demand in kW observed across all intervals"
    - name: "total_reactive_energy_kvarh"
      expr: SUM(CAST(reactive_energy_value AS DOUBLE))
      comment: "Total reactive energy in kVARh for power quality analysis"
    - name: "avg_power_factor"
      expr: AVG(CAST(power_factor AS DOUBLE))
      comment: "Average power factor across intervals for efficiency analysis"
    - name: "avg_voltage"
      expr: AVG(CAST(voltage_value AS DOUBLE))
      comment: "Average voltage across intervals for power quality monitoring"
    - name: "avg_temperature"
      expr: AVG(CAST(temperature_value AS DOUBLE))
      comment: "Average temperature during intervals for weather correlation analysis"
    - name: "load_factor"
      expr: ROUND(100.0 * AVG(CAST(demand_value AS DOUBLE)) / NULLIF(MAX(CAST(demand_value AS DOUBLE)), 0), 2)
      comment: "Load factor percentage indicating how efficiently capacity is utilized"
    - name: "unique_meters"
      expr: COUNT(DISTINCT meter_id)
      comment: "Count of unique meters with interval data"
    - name: "unique_service_points"
      expr: COUNT(DISTINCT service_point_id)
      comment: "Count of unique service points with interval data"
    - name: "interval_read_count"
      expr: COUNT(1)
      comment: "Total number of interval readings"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`metering_meter_events`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter event metrics for outage detection, tamper monitoring, and operational intelligence"
  source: "`power_and_utilities`.`metering`.`meter_event`"
  dimensions:
    - name: "event_timestamp"
      expr: event_timestamp
      comment: "Timestamp when the meter event occurred"
    - name: "event_type"
      expr: event_type
      comment: "Type of meter event (outage, tamper, voltage, communication)"
    - name: "event_code"
      expr: event_code
      comment: "Specific event code for detailed classification"
    - name: "event_severity"
      expr: event_severity
      comment: "Severity level of the event (critical, high, medium, low)"
    - name: "event_source_system"
      expr: event_source_system
      comment: "System that generated the event (AMI, MDMS, OMS)"
    - name: "acknowledgment_status"
      expr: acknowledgment_status
      comment: "Status of event acknowledgment by operations"
    - name: "notification_sent_flag"
      expr: notification_sent_flag
      comment: "Indicates if notification was sent for this event"
    - name: "field_investigation_required_flag"
      expr: field_investigation_required_flag
      comment: "Indicates if field investigation is required"
    - name: "forwarded_to_oms_flag"
      expr: forwarded_to_oms_flag
      comment: "Indicates if event was forwarded to outage management system"
  measures:
    - name: "total_events"
      expr: COUNT(1)
      comment: "Total number of meter events"
    - name: "unique_meters_with_events"
      expr: COUNT(DISTINCT meter_id)
      comment: "Count of unique meters that generated events"
    - name: "unique_service_points_with_events"
      expr: COUNT(DISTINCT service_point_id)
      comment: "Count of unique service points with meter events"
    - name: "avg_response_time_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(acknowledged_timestamp) - UNIX_TIMESTAMP(event_timestamp)) / 60.0 AS DOUBLE))
      comment: "Average time in minutes from event occurrence to acknowledgment"
    - name: "avg_resolution_time_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(resolved_timestamp) - UNIX_TIMESTAMP(event_timestamp)) / 60.0 AS DOUBLE))
      comment: "Average time in minutes from event occurrence to resolution"
    - name: "avg_outage_duration_minutes"
      expr: AVG(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Average outage duration in minutes for outage events"
    - name: "total_outage_minutes"
      expr: SUM(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Total outage duration in minutes across all outage events"
    - name: "avg_signal_strength_dbm"
      expr: AVG(CAST(signal_strength_dbm AS DOUBLE))
      comment: "Average signal strength in dBm for communication-related events"
    - name: "avg_voltage_reading"
      expr: AVG(CAST(voltage_reading AS DOUBLE))
      comment: "Average voltage reading for voltage-related events"
    - name: "avg_power_factor"
      expr: AVG(CAST(power_factor AS DOUBLE))
      comment: "Average power factor for power quality events"
    - name: "event_acknowledgment_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN acknowledged_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events that have been acknowledged"
    - name: "event_resolution_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN resolved_timestamp IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events that have been resolved"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`metering_vee_quality`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Validation, estimation, and editing metrics for data quality monitoring and regulatory compliance"
  source: "`power_and_utilities`.`metering`.`vee_event`"
  dimensions:
    - name: "vee_processing_timestamp"
      expr: vee_processing_timestamp
      comment: "Timestamp when VEE processing occurred"
    - name: "vee_status"
      expr: vee_status
      comment: "Status of VEE processing (valid, estimated, edited, failed)"
    - name: "estimation_method"
      expr: estimation_method
      comment: "Method used for estimating missing or invalid data"
    - name: "measurement_type"
      expr: measurement_type
      comment: "Type of measurement being validated (consumption, demand, voltage)"
    - name: "read_quality_code"
      expr: read_quality_code
      comment: "Quality code assigned to the reading"
    - name: "validation_exception_code"
      expr: validation_exception_code
      comment: "Code for validation exceptions"
    - name: "billing_impact_flag"
      expr: billing_impact_flag
      comment: "Indicates if VEE event impacts billing"
    - name: "regulatory_reportable_flag"
      expr: regulatory_reportable_flag
      comment: "Indicates if VEE event must be reported to regulators"
    - name: "analyst_override_flag"
      expr: analyst_override_flag
      comment: "Indicates if analyst manually overrode VEE results"
  measures:
    - name: "total_vee_events"
      expr: COUNT(1)
      comment: "Total number of VEE events processed"
    - name: "unique_meters_with_vee_events"
      expr: COUNT(DISTINCT meter_id)
      comment: "Count of unique meters with VEE events"
    - name: "unique_service_points_with_vee_events"
      expr: COUNT(DISTINCT service_point_id)
      comment: "Count of unique service points with VEE events"
    - name: "avg_data_quality_score"
      expr: AVG(CAST(data_quality_score AS DOUBLE))
      comment: "Average data quality score across VEE events"
    - name: "avg_estimation_confidence_score"
      expr: AVG(CAST(estimation_confidence_score AS DOUBLE))
      comment: "Average confidence score for estimated values"
    - name: "total_variance_amount"
      expr: SUM(CAST(variance_amount AS DOUBLE))
      comment: "Total variance amount between original and corrected values"
    - name: "avg_variance_percentage"
      expr: AVG(CAST(variance_percentage AS DOUBLE))
      comment: "Average variance percentage for VEE corrections"
    - name: "estimation_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN estimation_method IS NOT NULL THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of readings that required estimation"
    - name: "analyst_override_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN analyst_override_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of VEE events that required analyst override"
    - name: "billing_impact_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN billing_impact_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of VEE events that impact billing"
    - name: "regulatory_reportable_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_reportable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of VEE events requiring regulatory reporting"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`metering_meter_tests`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Meter testing and accuracy metrics for regulatory compliance and asset performance management"
  source: "`power_and_utilities`.`metering`.`meter_test`"
  dimensions:
    - name: "test_date"
      expr: test_date
      comment: "Date when meter test was performed"
    - name: "test_type"
      expr: test_type
      comment: "Type of meter test (accuracy, calibration, functional)"
    - name: "test_result"
      expr: test_result
      comment: "Result of the test (pass, fail, conditional)"
    - name: "test_status"
      expr: test_status
      comment: "Status of the test (completed, pending, cancelled)"
    - name: "test_location"
      expr: test_location
      comment: "Location where test was performed (field, lab, shop)"
    - name: "compliance_cycle_code"
      expr: compliance_cycle_code
      comment: "Regulatory compliance cycle code"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates if test meets regulatory compliance requirements"
    - name: "test_standard_applied"
      expr: test_standard_applied
      comment: "Testing standard applied (ANSI, IEC, etc.)"
  measures:
    - name: "total_tests"
      expr: COUNT(1)
      comment: "Total number of meter tests performed"
    - name: "unique_meters_tested"
      expr: COUNT(DISTINCT meter_id)
      comment: "Count of unique meters tested"
    - name: "avg_as_found_accuracy_pct"
      expr: AVG(CAST(as_found_accuracy_percent AS DOUBLE))
      comment: "Average as-found accuracy percentage before any adjustments"
    - name: "avg_as_left_accuracy_pct"
      expr: AVG(CAST(as_left_accuracy_percent AS DOUBLE))
      comment: "Average as-left accuracy percentage after adjustments"
    - name: "avg_full_load_accuracy_pct"
      expr: AVG(CAST(full_load_accuracy_percent AS DOUBLE))
      comment: "Average accuracy at full load conditions"
    - name: "avg_light_load_accuracy_pct"
      expr: AVG(CAST(light_load_accuracy_percent AS DOUBLE))
      comment: "Average accuracy at light load conditions"
    - name: "avg_demand_register_accuracy_pct"
      expr: AVG(CAST(demand_register_accuracy_percent AS DOUBLE))
      comment: "Average demand register accuracy percentage"
    - name: "test_pass_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN test_result = 'pass' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests that passed"
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of tests meeting regulatory compliance"
    - name: "avg_test_duration_minutes"
      expr: AVG(CAST(test_duration_minutes AS DOUBLE))
      comment: "Average duration of meter tests in minutes"
    - name: "accuracy_improvement_pct"
      expr: AVG(CAST(as_left_accuracy_percent AS DOUBLE)) - AVG(CAST(as_found_accuracy_percent AS DOUBLE))
      comment: "Average improvement in accuracy from as-found to as-left"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`metering_remote_service_actions`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Remote connect/disconnect and service action metrics for operational efficiency and customer service"
  source: "`power_and_utilities`.`metering`.`remote_service_action`"
  dimensions:
    - name: "command_timestamp"
      expr: command_timestamp
      comment: "Timestamp when remote command was issued"
    - name: "action_type"
      expr: action_type
      comment: "Type of remote action (connect, disconnect, load limit)"
    - name: "action_subtype"
      expr: action_subtype
      comment: "Subtype of remote action for detailed classification"
    - name: "result_status"
      expr: result_status
      comment: "Result status of the action (success, failure, pending)"
    - name: "failure_reason_code"
      expr: failure_reason_code
      comment: "Code for action failure reason"
    - name: "initiating_system"
      expr: initiating_system
      comment: "System that initiated the remote action"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the action (emergency, high, normal, low)"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Indicates if action complies with regulatory requirements"
    - name: "customer_notification_sent"
      expr: customer_notification_sent
      comment: "Indicates if customer was notified of the action"
  measures:
    - name: "total_remote_actions"
      expr: COUNT(1)
      comment: "Total number of remote service actions executed"
    - name: "unique_meters_with_actions"
      expr: COUNT(DISTINCT meter_id)
      comment: "Count of unique meters with remote actions"
    - name: "unique_service_points_with_actions"
      expr: COUNT(DISTINCT service_point_id)
      comment: "Count of unique service points with remote actions"
    - name: "unique_accounts_with_actions"
      expr: COUNT(DISTINCT account_id)
      comment: "Count of unique customer accounts with remote actions"
    - name: "action_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN result_status = 'success' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of remote actions that succeeded"
    - name: "avg_response_time_seconds"
      expr: AVG(CAST(response_time_seconds AS DOUBLE))
      comment: "Average response time in seconds for remote actions"
    - name: "avg_execution_time_minutes"
      expr: AVG(CAST((UNIX_TIMESTAMP(completion_timestamp) - UNIX_TIMESTAMP(execution_timestamp)) / 60.0 AS DOUBLE))
      comment: "Average time in minutes from execution to completion"
    - name: "avg_signal_strength_dbm"
      expr: AVG(CAST(signal_strength_dbm AS DOUBLE))
      comment: "Average signal strength in dBm during remote actions"
    - name: "avg_load_limit_kw"
      expr: AVG(CAST(load_limit_kw AS DOUBLE))
      comment: "Average load limit in kW for load limiting actions"
    - name: "customer_notification_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN customer_notification_sent = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of actions where customer was notified"
    - name: "regulatory_compliance_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN regulatory_compliance_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of actions meeting regulatory compliance"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`metering_ami_endpoints`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "AMI endpoint health and communication metrics for network performance and reliability monitoring"
  source: "`power_and_utilities`.`metering`.`ami_endpoint`"
  dimensions:
    - name: "communication_status"
      expr: communication_status
      comment: "Current communication status of the AMI endpoint"
    - name: "network_type"
      expr: network_type
      comment: "Type of communication network (RF mesh, cellular, PLC)"
    - name: "manufacturer_name"
      expr: manufacturer_name
      comment: "Manufacturer of the AMI endpoint"
    - name: "firmware_version"
      expr: firmware_version
      comment: "Firmware version of the endpoint"
    - name: "head_end_system_code"
      expr: head_end_system_code
      comment: "Head-end system managing the endpoint"
    - name: "encryption_enabled_flag"
      expr: encryption_enabled_flag
      comment: "Indicates if encryption is enabled"
    - name: "remote_disconnect_capable_flag"
      expr: remote_disconnect_capable_flag
      comment: "Indicates if endpoint supports remote disconnect"
    - name: "outage_detection_enabled_flag"
      expr: outage_detection_enabled_flag
      comment: "Indicates if outage detection is enabled"
    - name: "tamper_detection_flag"
      expr: tamper_detection_flag
      comment: "Indicates if tamper detection is active"
  measures:
    - name: "total_ami_endpoints"
      expr: COUNT(1)
      comment: "Total number of AMI endpoints"
    - name: "unique_meters_with_ami"
      expr: COUNT(DISTINCT meter_id)
      comment: "Count of unique meters with AMI endpoints"
    - name: "unique_service_points_with_ami"
      expr: COUNT(DISTINCT service_point_id)
      comment: "Count of unique service points with AMI endpoints"
    - name: "avg_signal_strength_dbm"
      expr: AVG(CAST(signal_strength_baseline_dbm AS DOUBLE))
      comment: "Average baseline signal strength in dBm"
    - name: "avg_battery_level_pct"
      expr: AVG(CAST(battery_level_percent AS DOUBLE))
      comment: "Average battery level percentage for battery-powered endpoints"
    - name: "communication_success_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN communication_status = 'active' THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints with active communication"
    - name: "encryption_enabled_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN encryption_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints with encryption enabled"
    - name: "remote_disconnect_capable_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN remote_disconnect_capable_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints capable of remote disconnect"
    - name: "outage_detection_enabled_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN outage_detection_enabled_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints with outage detection enabled"
    - name: "tamper_detection_rate"
      expr: ROUND(100.0 * COUNT(CASE WHEN tamper_detection_flag = TRUE THEN 1 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of endpoints with active tamper detection"
    - name: "avg_days_since_firmware_update"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), CAST(last_firmware_update_timestamp AS DATE)) AS DOUBLE))
      comment: "Average days since last firmware update"
    - name: "avg_days_since_successful_communication"
      expr: AVG(CAST(DATEDIFF(CURRENT_DATE(), CAST(last_successful_communication_timestamp AS DATE)) AS DOUBLE))
      comment: "Average days since last successful communication"
$$;