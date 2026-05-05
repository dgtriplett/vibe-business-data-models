-- Metric views for domain: transmission | Business: Power and Utilities | Version: 1 | Generated on: 2026-04-29 23:09:06

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`transmission_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic transmission line performance and capacity utilization metrics for grid planning and asset management decisions"
  source: "`power_and_utilities`.`transmission`.`line`"
  dimensions:
    - name: "voltage_class_kv"
      expr: voltage_class_kv
      comment: "Voltage class in kilovolts for segmentation by transmission tier"
    - name: "line_type"
      expr: line_type
      comment: "Type of transmission line (overhead, underground, etc.)"
    - name: "operating_status"
      expr: operating_status
      comment: "Current operational status of the line"
    - name: "nerc_cip_applicable"
      expr: nerc_cip_applicable
      comment: "Whether line is subject to NERC CIP cybersecurity standards"
    - name: "bes_classified"
      expr: bes_classified
      comment: "Bulk Electric System classification flag for reliability oversight"
    - name: "rto_iso_region"
      expr: rto_iso_region
      comment: "Regional transmission organization or independent system operator region"
    - name: "state_code"
      expr: state_code
      comment: "State code for regulatory and geographic analysis"
    - name: "in_service_year"
      expr: YEAR(in_service_date)
      comment: "Year the line was placed in service for age cohort analysis"
  measures:
    - name: "total_line_count"
      expr: COUNT(1)
      comment: "Total number of transmission lines"
    - name: "total_circuit_miles"
      expr: SUM(CAST(length_miles AS DOUBLE))
      comment: "Total circuit miles of transmission lines for network size measurement"
    - name: "total_rated_capacity_mva"
      expr: SUM(CAST(rated_capacity_mva AS DOUBLE))
      comment: "Total rated capacity in MVA across all lines for system capability assessment"
    - name: "total_transfer_capability_mw"
      expr: SUM(CAST(total_transfer_capability_mw AS DOUBLE))
      comment: "Total transfer capability in MW for grid planning and market operations"
    - name: "avg_capacity_utilization_pct"
      expr: ROUND(100.0 * AVG(CAST(available_transfer_capability_mw AS DOUBLE) / NULLIF(CAST(total_transfer_capability_mw AS DOUBLE), 0)), 2)
      comment: "Average capacity utilization percentage indicating how much of rated capability is available"
    - name: "avg_line_age_years"
      expr: AVG(DATEDIFF(CURRENT_DATE(), in_service_date) / 365.25)
      comment: "Average age of transmission lines in years for asset renewal planning"
    - name: "total_commissioning_cost_usd"
      expr: SUM(CAST(commissioning_cost_usd AS DOUBLE))
      comment: "Total historical commissioning cost for capital investment tracking"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`transmission_substation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Critical substation capacity and reliability metrics for transmission infrastructure investment and operational decisions"
  source: "`power_and_utilities`.`transmission`.`transmission_substation`"
  dimensions:
    - name: "voltage_high_kv"
      expr: voltage_high_kv
      comment: "High-side voltage class in kV for substation tier segmentation"
    - name: "operating_status"
      expr: operating_status
      comment: "Current operational status of the substation"
    - name: "nerc_cip_classification"
      expr: nerc_cip_classification
      comment: "NERC CIP cybersecurity classification level"
    - name: "bes_flag"
      expr: bes_flag
      comment: "Bulk Electric System designation for reliability compliance"
    - name: "rto_iso_region"
      expr: rto_iso_region
      comment: "RTO/ISO region for market and operational coordination"
    - name: "state_code"
      expr: state_code
      comment: "State code for regulatory jurisdiction analysis"
    - name: "substation_type"
      expr: substation_type
      comment: "Type of substation (switching, transformation, etc.)"
    - name: "commissioning_year"
      expr: YEAR(commissioning_date)
      comment: "Year commissioned for age cohort and investment vintage analysis"
  measures:
    - name: "total_substation_count"
      expr: COUNT(1)
      comment: "Total number of transmission substations"
    - name: "total_installed_capacity_mva"
      expr: SUM(CAST(installed_capacity_mva AS DOUBLE))
      comment: "Total installed transformation capacity in MVA for system capability assessment"
    - name: "avg_installed_capacity_mva"
      expr: AVG(CAST(installed_capacity_mva AS DOUBLE))
      comment: "Average installed capacity per substation for sizing benchmarks"
    - name: "total_original_cost_usd"
      expr: SUM(CAST(original_cost_usd AS DOUBLE))
      comment: "Total original capital cost for rate base and depreciation analysis"
    - name: "avg_substation_age_years"
      expr: AVG(DATEDIFF(CURRENT_DATE(), commissioning_date) / 365.25)
      comment: "Average age of substations in years for asset renewal prioritization"
    - name: "total_transformer_banks"
      expr: SUM(CAST(num_transformer_banks AS DOUBLE))
      comment: "Total number of transformer banks across all substations"
    - name: "total_transmission_lines_connected"
      expr: SUM(CAST(num_transmission_lines AS DOUBLE))
      comment: "Total transmission lines connected to substations for network topology analysis"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`transmission_transformer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transformer asset health and capacity metrics for maintenance planning and reliability management decisions"
  source: "`power_and_utilities`.`transmission`.`transformer`"
  dimensions:
    - name: "voltage_class"
      expr: voltage_class
      comment: "Voltage class of the transformer"
    - name: "transformer_type"
      expr: transformer_type
      comment: "Type of transformer (power, autotransformer, etc.)"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status"
    - name: "dga_condition_code"
      expr: dga_condition_code
      comment: "Dissolved gas analysis condition code indicating asset health"
    - name: "is_bes_asset"
      expr: is_bes_asset
      comment: "Bulk Electric System asset designation"
    - name: "nerc_cip_asset_class"
      expr: nerc_cip_asset_class
      comment: "NERC CIP cybersecurity asset classification"
    - name: "cooling_class"
      expr: cooling_class
      comment: "Cooling class (ONAN, ONAF, etc.) affecting capacity ratings"
    - name: "manufacture_decade"
      expr: CONCAT(SUBSTRING(manufacture_year, 1, 3), '0s')
      comment: "Decade of manufacture for vintage cohort analysis"
  measures:
    - name: "total_transformer_count"
      expr: COUNT(1)
      comment: "Total number of transmission transformers"
    - name: "total_nameplate_capacity_mva"
      expr: SUM(CAST(mva_rating_nameplate AS DOUBLE))
      comment: "Total nameplate capacity in MVA for system capability planning"
    - name: "total_ultimate_capacity_mva"
      expr: SUM(CAST(mva_rating_ultimate AS DOUBLE))
      comment: "Total ultimate capacity in MVA including emergency ratings"
    - name: "avg_capacity_headroom_pct"
      expr: ROUND(100.0 * AVG((CAST(mva_rating_ultimate AS DOUBLE) - CAST(mva_rating_nameplate AS DOUBLE)) / NULLIF(CAST(mva_rating_nameplate AS DOUBLE), 0)), 2)
      comment: "Average capacity headroom percentage between ultimate and nameplate ratings for emergency capability assessment"
    - name: "avg_transformer_age_years"
      expr: AVG(DATEDIFF(CURRENT_DATE(), in_service_date) / 365.25)
      comment: "Average age of transformers in years for replacement planning"
    - name: "total_oil_volume_gallons"
      expr: SUM(CAST(oil_volume_gallons AS DOUBLE))
      comment: "Total oil volume in gallons for environmental risk and maintenance planning"
    - name: "avg_impedance_pct"
      expr: AVG(CAST(impedance_pct AS DOUBLE))
      comment: "Average impedance percentage for fault current and protection coordination analysis"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`transmission_outage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transmission outage frequency, duration, and impact metrics for reliability performance and regulatory compliance reporting"
  source: "`power_and_utilities`.`transmission`.`outage`"
  dimensions:
    - name: "outage_type"
      expr: outage_type
      comment: "Type of outage (planned, forced, emergency)"
    - name: "outage_status"
      expr: outage_status
      comment: "Current status of the outage"
    - name: "cause_code"
      expr: cause_code
      comment: "Root cause code for outage categorization"
    - name: "nerc_region"
      expr: nerc_region
      comment: "NERC region for reliability reporting"
    - name: "voltage_level_kv"
      expr: voltage_level_kv
      comment: "Voltage level of outaged element"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during outage for cause analysis"
    - name: "nerc_tads_reporting_flag"
      expr: nerc_tads_reporting_flag
      comment: "Whether outage is reportable to NERC Transmission Availability Data System"
    - name: "outage_year"
      expr: YEAR(actual_start_timestamp)
      comment: "Year of outage for trend analysis"
    - name: "outage_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month of outage for seasonal pattern analysis"
  measures:
    - name: "total_outage_count"
      expr: COUNT(1)
      comment: "Total number of transmission outages"
    - name: "total_outage_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total outage duration in hours for availability calculation"
    - name: "avg_outage_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average outage duration in hours for restoration performance assessment"
    - name: "total_load_impact_mw"
      expr: SUM(CAST(load_impact_mw AS DOUBLE))
      comment: "Total load impact in MW for system reliability impact measurement"
    - name: "avg_load_impact_mw"
      expr: AVG(CAST(load_impact_mw AS DOUBLE))
      comment: "Average load impact per outage in MW"
    - name: "total_customers_affected"
      expr: SUM(CAST(customers_affected_count AS DOUBLE))
      comment: "Total customers affected across all outages for service quality metrics"
    - name: "forced_outage_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN outage_type = 'Forced' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Forced outage rate as percentage of total outages for reliability benchmarking"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`transmission_congestion_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transmission congestion frequency, cost, and constraint metrics for market efficiency and grid expansion investment decisions"
  source: "`power_and_utilities`.`transmission`.`congestion_event`"
  dimensions:
    - name: "constraint_type"
      expr: constraint_type
      comment: "Type of transmission constraint causing congestion"
    - name: "event_status"
      expr: event_status
      comment: "Current status of the congestion event"
    - name: "nerc_region"
      expr: nerc_region
      comment: "NERC region where congestion occurred"
    - name: "voltage_level_kv"
      expr: voltage_level_kv
      comment: "Voltage level of constrained element"
    - name: "binding_constraint_flag"
      expr: binding_constraint_flag
      comment: "Whether constraint was binding in market clearing"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather condition during congestion event"
    - name: "market_interval_type"
      expr: market_interval_type
      comment: "Market interval type (real-time, day-ahead)"
    - name: "event_year"
      expr: YEAR(event_start_timestamp)
      comment: "Year of congestion event for trend analysis"
    - name: "event_month"
      expr: DATE_TRUNC('MONTH', event_start_timestamp)
      comment: "Month of congestion event for seasonal pattern analysis"
  measures:
    - name: "total_congestion_event_count"
      expr: COUNT(1)
      comment: "Total number of congestion events for frequency tracking"
    - name: "total_congestion_cost_usd"
      expr: SUM(CAST(congestion_cost_usd AS DOUBLE))
      comment: "Total congestion cost in USD for market efficiency and investment justification"
    - name: "avg_congestion_cost_per_event_usd"
      expr: AVG(CAST(congestion_cost_usd AS DOUBLE))
      comment: "Average congestion cost per event for severity assessment"
    - name: "total_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Total congestion duration in hours for constraint persistence measurement"
    - name: "avg_duration_hours"
      expr: AVG(CAST(duration_hours AS DOUBLE))
      comment: "Average congestion duration per event"
    - name: "total_curtailed_mw"
      expr: SUM(CAST(curtailed_mw AS DOUBLE))
      comment: "Total curtailed energy in MW for market impact assessment"
    - name: "total_generation_redispatch_mw"
      expr: SUM(CAST(generation_redispatch_mw AS DOUBLE))
      comment: "Total generation redispatch in MW for operational cost impact"
    - name: "avg_shadow_price_per_mwh"
      expr: AVG(CAST(shadow_price_per_mwh AS DOUBLE))
      comment: "Average shadow price per MWh indicating marginal value of constraint relief"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`transmission_interconnection_request`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Generation interconnection queue metrics for renewable integration planning and transmission expansion prioritization"
  source: "`power_and_utilities`.`transmission`.`interconnection_request`"
  dimensions:
    - name: "request_status"
      expr: request_status
      comment: "Current status of interconnection request"
    - name: "project_type"
      expr: project_type
      comment: "Type of generation project (solar, wind, storage, etc.)"
    - name: "technology_type"
      expr: technology_type
      comment: "Specific technology type"
    - name: "study_phase"
      expr: study_phase
      comment: "Current study phase (feasibility, system impact, facilities)"
    - name: "is_network_resource"
      expr: is_network_resource
      comment: "Whether project will be a network resource"
    - name: "is_energy_only"
      expr: is_energy_only
      comment: "Whether project is energy-only interconnection"
    - name: "requires_nerc_registration"
      expr: requires_nerc_registration
      comment: "Whether project requires NERC registration"
    - name: "submission_year"
      expr: YEAR(submission_date)
      comment: "Year of request submission for queue vintage analysis"
  measures:
    - name: "total_request_count"
      expr: COUNT(1)
      comment: "Total number of interconnection requests in queue"
    - name: "total_requested_capacity_mw"
      expr: SUM(CAST(requested_capacity_mw AS DOUBLE))
      comment: "Total requested generation capacity in MW for grid planning"
    - name: "avg_requested_capacity_mw"
      expr: AVG(CAST(requested_capacity_mw AS DOUBLE))
      comment: "Average project size in MW for interconnection sizing trends"
    - name: "total_estimated_interconnection_cost_usd"
      expr: SUM(CAST(estimated_interconnection_facility_cost AS DOUBLE))
      comment: "Total estimated interconnection facility cost for capital planning"
    - name: "total_estimated_network_upgrade_cost_usd"
      expr: SUM(CAST(estimated_network_upgrade_cost AS DOUBLE))
      comment: "Total estimated network upgrade cost for transmission investment needs"
    - name: "avg_interconnection_cost_per_mw"
      expr: AVG(CAST(estimated_interconnection_facility_cost AS DOUBLE) / NULLIF(CAST(requested_capacity_mw AS DOUBLE), 0))
      comment: "Average interconnection cost per MW for cost benchmarking"
    - name: "avg_queue_time_days"
      expr: AVG(DATEDIFF(COALESCE(interconnection_agreement_executed_date, CURRENT_DATE()), submission_date))
      comment: "Average time in queue from submission to agreement execution for process efficiency tracking"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`transmission_balancing_authority`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Balancing authority capacity and performance metrics for reliability coordination and resource adequacy assessment"
  source: "`power_and_utilities`.`transmission`.`balancing_authority`"
  dimensions:
    - name: "ba_type"
      expr: ba_type
      comment: "Type of balancing authority"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status"
    - name: "nerc_region"
      expr: nerc_region
      comment: "NERC region for reliability coordination"
    - name: "interconnection"
      expr: interconnection
      comment: "Interconnection (Eastern, Western, ERCOT)"
    - name: "market_operator_flag"
      expr: market_operator_flag
      comment: "Whether BA operates organized markets"
    - name: "ferc_jurisdiction_flag"
      expr: ferc_jurisdiction_flag
      comment: "Whether BA is under FERC jurisdiction"
    - name: "lmp_pricing_flag"
      expr: lmp_pricing_flag
      comment: "Whether BA uses locational marginal pricing"
  measures:
    - name: "total_ba_count"
      expr: COUNT(1)
      comment: "Total number of balancing authorities"
    - name: "total_registered_capacity_mw"
      expr: SUM(CAST(registered_capacity_mw AS DOUBLE))
      comment: "Total registered generation capacity in MW for resource adequacy assessment"
    - name: "total_peak_demand_mw"
      expr: SUM(CAST(peak_demand_mw AS DOUBLE))
      comment: "Total peak demand in MW for load forecasting and planning"
    - name: "avg_reserve_margin_pct"
      expr: ROUND(100.0 * AVG((CAST(registered_capacity_mw AS DOUBLE) - CAST(peak_demand_mw AS DOUBLE)) / NULLIF(CAST(peak_demand_mw AS DOUBLE), 0)), 2)
      comment: "Average reserve margin percentage for resource adequacy compliance"
    - name: "total_service_territory_sq_mi"
      expr: SUM(CAST(service_territory_area_sq_mi AS DOUBLE))
      comment: "Total service territory area in square miles"
    - name: "avg_cps1_threshold_pct"
      expr: AVG(CAST(cps1_threshold_percent AS DOUBLE))
      comment: "Average CPS1 threshold percentage for frequency control performance"
    - name: "avg_disturbance_control_standard_mw"
      expr: AVG(CAST(disturbance_control_standard_mw AS DOUBLE))
      comment: "Average disturbance control standard in MW for reliability compliance"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`transmission_interchange_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy interchange volume and curtailment metrics for market operations and transmission utilization analysis"
  source: "`power_and_utilities`.`transmission`.`interchange_schedule`"
  dimensions:
    - name: "schedule_type"
      expr: schedule_type
      comment: "Type of interchange schedule"
    - name: "market_type"
      expr: market_type
      comment: "Market type (day-ahead, real-time, bilateral)"
    - name: "curtailment_flag"
      expr: curtailment_flag
      comment: "Whether schedule was curtailed"
    - name: "is_dynamic_transfer"
      expr: is_dynamic_transfer
      comment: "Whether schedule is a dynamic transfer"
    - name: "source_ba_code"
      expr: source_ba_code
      comment: "Source balancing authority code"
    - name: "sink_ba_code"
      expr: sink_ba_code
      comment: "Sink balancing authority code"
    - name: "operating_date"
      expr: operating_date
      comment: "Operating date for daily analysis"
    - name: "operating_month"
      expr: DATE_TRUNC('MONTH', operating_date)
      comment: "Operating month for trend analysis"
  measures:
    - name: "total_schedule_count"
      expr: COUNT(1)
      comment: "Total number of interchange schedules"
    - name: "total_scheduled_mwh"
      expr: SUM(CAST(energy_mwh AS DOUBLE))
      comment: "Total scheduled energy in MWh for interchange volume tracking"
    - name: "total_curtailed_mw"
      expr: SUM(CAST(curtailed_mw AS DOUBLE))
      comment: "Total curtailed capacity in MW for transmission constraint impact"
    - name: "curtailment_rate_pct"
      expr: ROUND(100.0 * SUM(CAST(curtailed_mw AS DOUBLE)) / NULLIF(SUM(CAST(scheduled_mw AS DOUBLE)), 0), 2)
      comment: "Curtailment rate as percentage of scheduled MW for transmission adequacy assessment"
    - name: "avg_scheduled_mw"
      expr: AVG(CAST(scheduled_mw AS DOUBLE))
      comment: "Average scheduled MW per interchange"
    - name: "total_inadvertent_mw"
      expr: SUM(CAST(inadvertent_mw AS DOUBLE))
      comment: "Total inadvertent interchange in MW for ACE and frequency control analysis"
    - name: "schedule_accuracy_pct"
      expr: ROUND(100.0 * (1.0 - AVG(ABS(CAST(actual_mw AS DOUBLE) - CAST(scheduled_mw AS DOUBLE)) / NULLIF(CAST(scheduled_mw AS DOUBLE), 0))), 2)
      comment: "Schedule accuracy percentage for operational performance measurement"
$$;