-- Metric views for domain: distribution | Business: Power and Utilities | Version: 1 | Generated on: 2026-04-29 23:11:06

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_bus`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bus business metrics"
  source: "`power_and_utilities`.`distribution`.`bus`"
  dimensions:
    - name: "Bus Name"
      expr: bus_name
    - name: "Bus Number"
      expr: bus_number
    - name: "Bus Type"
      expr: bus_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criticality Rating"
      expr: criticality_rating
    - name: "Der Interconnection Flag"
      expr: der_interconnection_flag
    - name: "Description"
      expr: description
    - name: "Energized Flag"
      expr: energized_flag
    - name: "Grounding Type"
      expr: grounding_type
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Load Serving Flag"
      expr: load_serving_flag
    - name: "Next Maintenance Date"
      expr: next_maintenance_date
    - name: "Operational Status"
      expr: operational_status
    - name: "Ownership Type"
      expr: ownership_type
    - name: "Phase Configuration"
      expr: phase_configuration
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bus"
      expr: COUNT(DISTINCT bus_id)
    - name: "Total Active Power Mw"
      expr: SUM(active_power_mw)
    - name: "Average Active Power Mw"
      expr: AVG(active_power_mw)
    - name: "Total Base Voltage Kv"
      expr: SUM(base_voltage_kv)
    - name: "Average Base Voltage Kv"
      expr: AVG(base_voltage_kv)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Max Voltage Limit Pu"
      expr: SUM(max_voltage_limit_pu)
    - name: "Average Max Voltage Limit Pu"
      expr: AVG(max_voltage_limit_pu)
    - name: "Total Min Voltage Limit Pu"
      expr: SUM(min_voltage_limit_pu)
    - name: "Average Min Voltage Limit Pu"
      expr: AVG(min_voltage_limit_pu)
    - name: "Total Reactive Power Mvar"
      expr: SUM(reactive_power_mvar)
    - name: "Average Reactive Power Mvar"
      expr: AVG(reactive_power_mvar)
    - name: "Total Short Circuit Mva"
      expr: SUM(short_circuit_mva)
    - name: "Average Short Circuit Mva"
      expr: AVG(short_circuit_mva)
    - name: "Total Voltage Angle Degrees"
      expr: SUM(voltage_angle_degrees)
    - name: "Average Voltage Angle Degrees"
      expr: AVG(voltage_angle_degrees)
    - name: "Total Voltage Level Kv"
      expr: SUM(voltage_level_kv)
    - name: "Average Voltage Level Kv"
      expr: AVG(voltage_level_kv)
    - name: "Total Voltage Magnitude Pu"
      expr: SUM(voltage_magnitude_pu)
    - name: "Average Voltage Magnitude Pu"
      expr: AVG(voltage_magnitude_pu)
    - name: "Total X R Ratio"
      expr: SUM(x_r_ratio)
    - name: "Average X R Ratio"
      expr: AVG(x_r_ratio)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_city_gate_station`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "City Gate Station business metrics"
  source: "`power_and_utilities`.`distribution`.`city_gate_station`"
  dimensions:
    - name: "Asset Criticality Rating"
      expr: asset_criticality_rating
    - name: "Backup Supply Available"
      expr: backup_supply_available
    - name: "City"
      expr: city
    - name: "Construction Material"
      expr: construction_material
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Emergency Shutdown Capable"
      expr: emergency_shutdown_capable
    - name: "Facility Size Classification"
      expr: facility_size_classification
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Meter Count"
      expr: meter_count
    - name: "Next Inspection Due Date"
      expr: next_inspection_due_date
    - name: "Notes"
      expr: notes
    - name: "Odorization Required"
      expr: odorization_required
    - name: "Operational Status"
      expr: operational_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct City Gate Station"
      expr: COUNT(DISTINCT city_gate_station_id)
    - name: "Total Design Capacity Mcfd"
      expr: SUM(design_capacity_mcfd)
    - name: "Average Design Capacity Mcfd"
      expr: AVG(design_capacity_mcfd)
    - name: "Total Inlet Pressure Psig"
      expr: SUM(inlet_pressure_psig)
    - name: "Average Inlet Pressure Psig"
      expr: AVG(inlet_pressure_psig)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Outlet Pressure Psig"
      expr: SUM(outlet_pressure_psig)
    - name: "Average Outlet Pressure Psig"
      expr: AVG(outlet_pressure_psig)
    - name: "Total Service Territory Code"
      expr: SUM(service_territory_code)
    - name: "Average Service Territory Code"
      expr: AVG(service_territory_code)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_crew_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Crew Dispatch business metrics"
  source: "`power_and_utilities`.`distribution`.`crew_dispatch`"
  dimensions:
    - name: "After Hours Flag"
      expr: after_hours_flag
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Completion Notes"
      expr: completion_notes
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crew Count"
      expr: crew_count
    - name: "Customer Contact Name"
      expr: customer_contact_name
    - name: "Customer Contact Phone"
      expr: customer_contact_phone
    - name: "Customer Present Required"
      expr: customer_present_required
    - name: "Dispatch Arrival Timestamp"
      expr: dispatch_arrival_timestamp
    - name: "Dispatch Assigned Timestamp"
      expr: dispatch_assigned_timestamp
    - name: "Dispatch Cancelled Timestamp"
      expr: dispatch_cancelled_timestamp
    - name: "Dispatch Completed Timestamp"
      expr: dispatch_completed_timestamp
    - name: "Dispatch Description"
      expr: dispatch_description
    - name: "Dispatch En Route Timestamp"
      expr: dispatch_en_route_timestamp
    - name: "Dispatch Location Address"
      expr: dispatch_location_address
    - name: "Dispatch Location City"
      expr: dispatch_location_city
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Crew Dispatch"
      expr: COUNT(DISTINCT crew_dispatch_id)
    - name: "Total Actual Duration Hours"
      expr: SUM(actual_duration_hours)
    - name: "Average Actual Duration Hours"
      expr: AVG(actual_duration_hours)
    - name: "Total Dispatch Location Latitude"
      expr: SUM(dispatch_location_latitude)
    - name: "Average Dispatch Location Latitude"
      expr: AVG(dispatch_location_latitude)
    - name: "Total Dispatch Location Longitude"
      expr: SUM(dispatch_location_longitude)
    - name: "Average Dispatch Location Longitude"
      expr: AVG(dispatch_location_longitude)
    - name: "Total Estimated Duration Hours"
      expr: SUM(estimated_duration_hours)
    - name: "Average Estimated Duration Hours"
      expr: AVG(estimated_duration_hours)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_demand_response_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Demand Response Event business metrics"
  source: "`power_and_utilities`.`distribution`.`demand_response_event`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customers Notified Count"
      expr: customers_notified_count
    - name: "Customers Responding Count"
      expr: customers_responding_count
    - name: "Data Source System"
      expr: data_source_system
    - name: "Derms Integrated Flag"
      expr: derms_integrated_flag
    - name: "Dispatch Source"
      expr: dispatch_source
    - name: "Event Duration Minutes"
      expr: event_duration_minutes
    - name: "Event End Timestamp"
      expr: event_end_timestamp
    - name: "Event Number"
      expr: event_number
    - name: "Event Outcome Status"
      expr: event_outcome_status
    - name: "Event Start Timestamp"
      expr: event_start_timestamp
    - name: "Event Status"
      expr: event_status
    - name: "Event Type"
      expr: event_type
    - name: "Nerc Reportable Flag"
      expr: nerc_reportable_flag
    - name: "Notification Lead Time Minutes"
      expr: notification_lead_time_minutes
    - name: "Notification Method"
      expr: notification_method
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Demand Response Event"
      expr: COUNT(DISTINCT demand_response_event_id)
    - name: "Total Actual Load Reduction Kw"
      expr: SUM(actual_load_reduction_kw)
    - name: "Average Actual Load Reduction Kw"
      expr: AVG(actual_load_reduction_kw)
    - name: "Total Ambient Temperature F"
      expr: SUM(ambient_temperature_f)
    - name: "Average Ambient Temperature F"
      expr: AVG(ambient_temperature_f)
    - name: "Total Baseline Load Kw"
      expr: SUM(baseline_load_kw)
    - name: "Average Baseline Load Kw"
      expr: AVG(baseline_load_kw)
    - name: "Total Curtailment Compliance Rate"
      expr: SUM(curtailment_compliance_rate)
    - name: "Average Curtailment Compliance Rate"
      expr: AVG(curtailment_compliance_rate)
    - name: "Total Incentive Payment Amount"
      expr: SUM(incentive_payment_amount)
    - name: "Average Incentive Payment Amount"
      expr: AVG(incentive_payment_amount)
    - name: "Total Lmp Price Per Mwh"
      expr: SUM(lmp_price_per_mwh)
    - name: "Average Lmp Price Per Mwh"
      expr: AVG(lmp_price_per_mwh)
    - name: "Total Load Reduction Percentage"
      expr: SUM(load_reduction_percentage)
    - name: "Average Load Reduction Percentage"
      expr: AVG(load_reduction_percentage)
    - name: "Total Penalty Amount"
      expr: SUM(penalty_amount)
    - name: "Average Penalty Amount"
      expr: AVG(penalty_amount)
    - name: "Total System Peak Load Mw"
      expr: SUM(system_peak_load_mw)
    - name: "Average System Peak Load Mw"
      expr: AVG(system_peak_load_mw)
    - name: "Total Target Load Reduction Kw"
      expr: SUM(target_load_reduction_kw)
    - name: "Average Target Load Reduction Kw"
      expr: AVG(target_load_reduction_kw)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_der_dispatch`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Der Dispatch business metrics"
  source: "`power_and_utilities`.`distribution`.`der_dispatch`"
  dimensions:
    - name: "Communication Status"
      expr: communication_status
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dispatch Instruction"
      expr: dispatch_instruction
    - name: "Dispatch Timestamp"
      expr: dispatch_timestamp
    - name: "Opt Out Flag"
      expr: opt_out_flag
    - name: "Participation Status"
      expr: participation_status
    - name: "Response Duration Minutes"
      expr: response_duration_minutes
    - name: "Updated Timestamp"
      expr: updated_timestamp
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Dispatch Timestamp Month"
      expr: DATE_TRUNC('MONTH', dispatch_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Der Dispatch"
      expr: COUNT(DISTINCT der_dispatch_id)
    - name: "Total Baseline Kw"
      expr: SUM(baseline_kw)
    - name: "Average Baseline Kw"
      expr: AVG(baseline_kw)
    - name: "Total Incentive Earned"
      expr: SUM(incentive_earned)
    - name: "Average Incentive Earned"
      expr: AVG(incentive_earned)
    - name: "Total Response Kw"
      expr: SUM(response_kw)
    - name: "Average Response Kw"
      expr: AVG(response_kw)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_der_interconnection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Der Interconnection business metrics"
  source: "`power_and_utilities`.`distribution`.`der_interconnection`"
  dimensions:
    - name: "Advanced Inverter Functions Enabled"
      expr: advanced_inverter_functions_enabled
    - name: "Anti Islanding Protection Type"
      expr: anti_islanding_protection_type
    - name: "Application Date"
      expr: application_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Segment"
      expr: customer_segment
    - name: "Der Type"
      expr: der_type
    - name: "Derms Device Code"
      expr: derms_device_code
    - name: "Derms Integrated"
      expr: derms_integrated
    - name: "Export Limitation Flag"
      expr: export_limitation_flag
    - name: "Ieee1547 Compliance Status"
      expr: ieee1547_compliance_status
    - name: "Installer License Number"
      expr: installer_license_number
    - name: "Installer Name"
      expr: installer_name
    - name: "Interconnection Agreement Date"
      expr: interconnection_agreement_date
    - name: "Interconnection Agreement Type"
      expr: interconnection_agreement_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Der Interconnection"
      expr: COUNT(DISTINCT der_interconnection_id)
    - name: "Total Export Capacity Kw"
      expr: SUM(export_capacity_kw)
    - name: "Average Export Capacity Kw"
      expr: AVG(export_capacity_kw)
    - name: "Total Installed Capacity Kw Ac"
      expr: SUM(installed_capacity_kw_ac)
    - name: "Average Installed Capacity Kw Ac"
      expr: AVG(installed_capacity_kw_ac)
    - name: "Total Installed Capacity Kw Dc"
      expr: SUM(installed_capacity_kw_dc)
    - name: "Average Installed Capacity Kw Dc"
      expr: AVG(installed_capacity_kw_dc)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Storage Capacity Kwh"
      expr: SUM(storage_capacity_kwh)
    - name: "Average Storage Capacity Kwh"
      expr: AVG(storage_capacity_kwh)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_distribution_outage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution Outage Event business metrics"
  source: "`power_and_utilities`.`distribution`.`distribution_outage_event`"
  dimensions:
    - name: "Actual Customers Affected"
      expr: actual_customers_affected
    - name: "Cause Code"
      expr: cause_code
    - name: "Cause Description"
      expr: cause_description
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Crew Arrival Timestamp"
      expr: crew_arrival_timestamp
    - name: "Crew Dispatch Timestamp"
      expr: crew_dispatch_timestamp
    - name: "Customers Restored Partial"
      expr: customers_restored_partial
    - name: "Estimated Customers Affected"
      expr: estimated_customers_affected
    - name: "Event Number"
      expr: event_number
    - name: "Event Status"
      expr: event_status
    - name: "Fault Location Description"
      expr: fault_location_description
    - name: "Ieee1366 Exclusion Flag"
      expr: ieee1366_exclusion_flag
    - name: "Ieee1366 Exclusion Reason"
      expr: ieee1366_exclusion_reason
    - name: "Major Event Day Flag"
      expr: major_event_day_flag
    - name: "Momentary Interruption Count"
      expr: momentary_interruption_count
    - name: "Mutual Aid Flag"
      expr: mutual_aid_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Distribution Outage Event"
      expr: COUNT(DISTINCT distribution_outage_event_id)
    - name: "Total Caidi Minutes"
      expr: SUM(caidi_minutes)
    - name: "Average Caidi Minutes"
      expr: AVG(caidi_minutes)
    - name: "Total Fault Latitude"
      expr: SUM(fault_latitude)
    - name: "Average Fault Latitude"
      expr: AVG(fault_latitude)
    - name: "Total Fault Longitude"
      expr: SUM(fault_longitude)
    - name: "Average Fault Longitude"
      expr: AVG(fault_longitude)
    - name: "Total Saidi Contribution Minutes"
      expr: SUM(saidi_contribution_minutes)
    - name: "Average Saidi Contribution Minutes"
      expr: AVG(saidi_contribution_minutes)
    - name: "Total Saifi Contribution"
      expr: SUM(saifi_contribution)
    - name: "Average Saifi Contribution"
      expr: AVG(saifi_contribution)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_distribution_substation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Distribution Substation business metrics"
  source: "`power_and_utilities`.`distribution`.`distribution_substation`"
  dimensions:
    - name: "Commissioning Date"
      expr: commissioning_date
    - name: "Construction Work Order"
      expr: construction_work_order
    - name: "County Name"
      expr: county_name
    - name: "Customers Served Count"
      expr: customers_served_count
    - name: "Decommission Date"
      expr: decommission_date
    - name: "Division Code"
      expr: division_code
    - name: "Ems Node Code"
      expr: ems_node_code
    - name: "Feeder Count"
      expr: feeder_count
    - name: "Gis Feature Code"
      expr: gis_feature_code
    - name: "Is Automated Switching"
      expr: is_automated_switching
    - name: "Is Normally Open Tie"
      expr: is_normally_open_tie
    - name: "Is Scada Monitored"
      expr: is_scada_monitored
    - name: "Land Parcel Number"
      expr: land_parcel_number
    - name: "Last Major Upgrade Date"
      expr: last_major_upgrade_date
    - name: "Nem Interconnection Count"
      expr: nem_interconnection_count
    - name: "Nerc Bes Applicable"
      expr: nerc_bes_applicable
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Distribution Substation"
      expr: COUNT(DISTINCT distribution_substation_id)
    - name: "Total Der Hosting Capacity Mw"
      expr: SUM(der_hosting_capacity_mw)
    - name: "Average Der Hosting Capacity Mw"
      expr: AVG(der_hosting_capacity_mw)
    - name: "Total Installed Capacity Mva"
      expr: SUM(installed_capacity_mva)
    - name: "Average Installed Capacity Mva"
      expr: AVG(installed_capacity_mva)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Load Factor Pct"
      expr: SUM(load_factor_pct)
    - name: "Average Load Factor Pct"
      expr: AVG(load_factor_pct)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Peak Load Mw"
      expr: SUM(peak_load_mw)
    - name: "Average Peak Load Mw"
      expr: AVG(peak_load_mw)
    - name: "Total Primary Voltage Kv"
      expr: SUM(primary_voltage_kv)
    - name: "Average Primary Voltage Kv"
      expr: AVG(primary_voltage_kv)
    - name: "Total Saidi Contribution Min"
      expr: SUM(saidi_contribution_min)
    - name: "Average Saidi Contribution Min"
      expr: AVG(saidi_contribution_min)
    - name: "Total Secondary Voltage Kv"
      expr: SUM(secondary_voltage_kv)
    - name: "Average Secondary Voltage Kv"
      expr: AVG(secondary_voltage_kv)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_district`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "District business metrics"
  source: "`power_and_utilities`.`distribution`.`district`"
  dimensions:
    - name: "Commercial Customer Count"
      expr: commercial_customer_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Count"
      expr: customer_count
    - name: "Der Interconnection Count"
      expr: der_interconnection_count
    - name: "Description"
      expr: description
    - name: "District Code"
      expr: district_code
    - name: "District Manager Name"
      expr: district_manager_name
    - name: "District Office Address"
      expr: district_office_address
    - name: "District Office Phone"
      expr: district_office_phone
    - name: "District Type"
      expr: district_type
    - name: "Dms District Code"
      expr: dms_district_code
    - name: "Effective Date"
      expr: effective_date
    - name: "Emergency Contact Phone"
      expr: emergency_contact_phone
    - name: "End Date"
      expr: end_date
    - name: "Feeder Count"
      expr: feeder_count
    - name: "Gis District Code"
      expr: gis_district_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct District"
      expr: COUNT(DISTINCT district_id)
    - name: "Total Annual Energy Delivered Mwh"
      expr: SUM(annual_energy_delivered_mwh)
    - name: "Average Annual Energy Delivered Mwh"
      expr: AVG(annual_energy_delivered_mwh)
    - name: "Total Annual Gas Delivered Mcf"
      expr: SUM(annual_gas_delivered_mcf)
    - name: "Average Annual Gas Delivered Mcf"
      expr: AVG(annual_gas_delivered_mcf)
    - name: "Total Caidi Index"
      expr: SUM(caidi_index)
    - name: "Average Caidi Index"
      expr: AVG(caidi_index)
    - name: "Total Electric Circuit Miles"
      expr: SUM(electric_circuit_miles)
    - name: "Average Electric Circuit Miles"
      expr: AVG(electric_circuit_miles)
    - name: "Total Gas Main Miles"
      expr: SUM(gas_main_miles)
    - name: "Average Gas Main Miles"
      expr: AVG(gas_main_miles)
    - name: "Total Peak Demand Mw"
      expr: SUM(peak_demand_mw)
    - name: "Average Peak Demand Mw"
      expr: AVG(peak_demand_mw)
    - name: "Total Saidi Index"
      expr: SUM(saidi_index)
    - name: "Average Saidi Index"
      expr: AVG(saidi_index)
    - name: "Total Saifi Index"
      expr: SUM(saifi_index)
    - name: "Average Saifi Index"
      expr: AVG(saifi_index)
    - name: "Total Service Area Square Miles"
      expr: SUM(service_area_square_miles)
    - name: "Average Service Area Square Miles"
      expr: AVG(service_area_square_miles)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_feeder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Feeder business metrics"
  source: "`power_and_utilities`.`distribution`.`feeder`"
  dimensions:
    - name: "Capacitor Bank Count"
      expr: capacitor_bank_count
    - name: "Circuit Configuration"
      expr: circuit_configuration
    - name: "Conductor Size Kcmil"
      expr: conductor_size_kcmil
    - name: "Customer Count"
      expr: customer_count
    - name: "Der Interconnection Count"
      expr: der_interconnection_count
    - name: "Dms Circuit Code"
      expr: dms_circuit_code
    - name: "Feeder Name"
      expr: feeder_name
    - name: "Feeder Number"
      expr: feeder_number
    - name: "Gis Feature Code"
      expr: gis_feature_code
    - name: "In Service Date"
      expr: in_service_date
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Nem Customer Count"
      expr: nem_customer_count
    - name: "Next Inspection Date"
      expr: next_inspection_date
    - name: "Notes"
      expr: notes
    - name: "Oms Circuit Code"
      expr: oms_circuit_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Feeder"
      expr: COUNT(DISTINCT feeder_id)
    - name: "Total Caidi Annual"
      expr: SUM(caidi_annual)
    - name: "Average Caidi Annual"
      expr: AVG(caidi_annual)
    - name: "Total Der Capacity Mw"
      expr: SUM(der_capacity_mw)
    - name: "Average Der Capacity Mw"
      expr: AVG(der_capacity_mw)
    - name: "Total Length Miles"
      expr: SUM(length_miles)
    - name: "Average Length Miles"
      expr: AVG(length_miles)
    - name: "Total Nominal Voltage Kv"
      expr: SUM(nominal_voltage_kv)
    - name: "Average Nominal Voltage Kv"
      expr: AVG(nominal_voltage_kv)
    - name: "Total Peak Load Mw"
      expr: SUM(peak_load_mw)
    - name: "Average Peak Load Mw"
      expr: AVG(peak_load_mw)
    - name: "Total Rated Capacity Mva"
      expr: SUM(rated_capacity_mva)
    - name: "Average Rated Capacity Mva"
      expr: AVG(rated_capacity_mva)
    - name: "Total Saidi Annual"
      expr: SUM(saidi_annual)
    - name: "Average Saidi Annual"
      expr: AVG(saidi_annual)
    - name: "Total Saifi Annual"
      expr: SUM(saifi_annual)
    - name: "Average Saifi Annual"
      expr: AVG(saifi_annual)
    - name: "Total Underground Percentage"
      expr: SUM(underground_percentage)
    - name: "Average Underground Percentage"
      expr: AVG(underground_percentage)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_gas_leak_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gas Leak Survey business metrics"
  source: "`power_and_utilities`.`distribution`.`gas_leak_survey`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Gas Concentration Ppm"
      expr: gas_concentration_ppm
    - name: "Leak Detected Flag"
      expr: leak_detected_flag
    - name: "Leak Grade"
      expr: leak_grade
    - name: "Leak Location Description"
      expr: leak_location_description
    - name: "Phmsa Incident Number"
      expr: phmsa_incident_number
    - name: "Phmsa Reportable Flag"
      expr: phmsa_reportable_flag
    - name: "Pipeline Material"
      expr: pipeline_material
    - name: "Pipeline Segment Type"
      expr: pipeline_segment_type
    - name: "Prior Survey Date"
      expr: prior_survey_date
    - name: "Puc Reporting Status"
      expr: puc_reporting_status
    - name: "Puc Submission Date"
      expr: puc_submission_date
    - name: "Repair Completion Date"
      expr: repair_completion_date
    - name: "Repair Due Date"
      expr: repair_due_date
    - name: "Repair Priority"
      expr: repair_priority
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gas Leak Survey"
      expr: COUNT(DISTINCT gas_leak_survey_id)
    - name: "Total Ambient Temperature F"
      expr: SUM(ambient_temperature_f)
    - name: "Average Ambient Temperature F"
      expr: AVG(ambient_temperature_f)
    - name: "Total Leak Latitude"
      expr: SUM(leak_latitude)
    - name: "Average Leak Latitude"
      expr: AVG(leak_latitude)
    - name: "Total Leak Longitude"
      expr: SUM(leak_longitude)
    - name: "Average Leak Longitude"
      expr: AVG(leak_longitude)
    - name: "Total Leak Size Estimate Mcf Per Day"
      expr: SUM(leak_size_estimate_mcf_per_day)
    - name: "Average Leak Size Estimate Mcf Per Day"
      expr: AVG(leak_size_estimate_mcf_per_day)
    - name: "Total Operating Pressure Psig"
      expr: SUM(operating_pressure_psig)
    - name: "Average Operating Pressure Psig"
      expr: AVG(operating_pressure_psig)
    - name: "Total Pipeline Diameter Inches"
      expr: SUM(pipeline_diameter_inches)
    - name: "Average Pipeline Diameter Inches"
      expr: AVG(pipeline_diameter_inches)
    - name: "Total Survey Duration Hours"
      expr: SUM(survey_duration_hours)
    - name: "Average Survey Duration Hours"
      expr: AVG(survey_duration_hours)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_gas_main`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gas Main business metrics"
  source: "`power_and_utilities`.`distribution`.`gas_main`"
  dimensions:
    - name: "Cathodic Protection Flag"
      expr: cathodic_protection_flag
    - name: "Cathodic Protection Type"
      expr: cathodic_protection_type
    - name: "Coating Type"
      expr: coating_type
    - name: "County"
      expr: county
    - name: "Crossing Type"
      expr: crossing_type
    - name: "Dimp Threat Rank"
      expr: dimp_threat_rank
    - name: "District Code"
      expr: district_code
    - name: "Encased Flag"
      expr: encased_flag
    - name: "Gis Feature Code"
      expr: gis_feature_code
    - name: "Installation Date"
      expr: installation_date
    - name: "Installation Year"
      expr: installation_year
    - name: "Installed By"
      expr: installed_by
    - name: "Joint Type"
      expr: joint_type
    - name: "Leak Survey Date"
      expr: leak_survey_date
    - name: "Leak Survey Method"
      expr: leak_survey_method
    - name: "Main Code"
      expr: main_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gas Main"
      expr: COUNT(DISTINCT gas_main_id)
    - name: "Total Maop Psig"
      expr: SUM(maop_psig)
    - name: "Average Maop Psig"
      expr: AVG(maop_psig)
    - name: "Total Nominal Diameter In"
      expr: SUM(nominal_diameter_in)
    - name: "Average Nominal Diameter In"
      expr: AVG(nominal_diameter_in)
    - name: "Total Operating Pressure Psig"
      expr: SUM(operating_pressure_psig)
    - name: "Average Operating Pressure Psig"
      expr: AVG(operating_pressure_psig)
    - name: "Total Pipe Depth In"
      expr: SUM(pipe_depth_in)
    - name: "Average Pipe Depth In"
      expr: AVG(pipe_depth_in)
    - name: "Total Segment Length Ft"
      expr: SUM(segment_length_ft)
    - name: "Average Segment Length Ft"
      expr: AVG(segment_length_ft)
    - name: "Total Wall Thickness In"
      expr: SUM(wall_thickness_in)
    - name: "Average Wall Thickness In"
      expr: AVG(wall_thickness_in)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_gas_network_node`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gas Network Node business metrics"
  source: "`power_and_utilities`.`distribution`.`gas_network_node`"
  dimensions:
    - name: "City"
      expr: city
    - name: "Commissioned Date"
      expr: commissioned_date
    - name: "Country Code"
      expr: country_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criticality Rating"
      expr: criticality_rating
    - name: "Customer Count"
      expr: customer_count
    - name: "Decommissioned Date"
      expr: decommissioned_date
    - name: "Description"
      expr: description
    - name: "Gis Feature Code"
      expr: gis_feature_code
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Next Inspection Due Date"
      expr: next_inspection_due_date
    - name: "Node Name"
      expr: node_name
    - name: "Node Number"
      expr: node_number
    - name: "Node Status"
      expr: node_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gas Network Node"
      expr: COUNT(DISTINCT gas_network_node_id)
    - name: "Total Design Pressure Psig"
      expr: SUM(design_pressure_psig)
    - name: "Average Design Pressure Psig"
      expr: AVG(design_pressure_psig)
    - name: "Total Elevation Ft"
      expr: SUM(elevation_ft)
    - name: "Average Elevation Ft"
      expr: AVG(elevation_ft)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Maximum Allowable Operating Pressure Psig"
      expr: SUM(maximum_allowable_operating_pressure_psig)
    - name: "Average Maximum Allowable Operating Pressure Psig"
      expr: AVG(maximum_allowable_operating_pressure_psig)
    - name: "Total Operating Pressure Psig"
      expr: SUM(operating_pressure_psig)
    - name: "Average Operating Pressure Psig"
      expr: AVG(operating_pressure_psig)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_gas_service_lateral`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Gas Service Lateral business metrics"
  source: "`power_and_utilities`.`distribution`.`gas_service_lateral`"
  dimensions:
    - name: "Cathodic Protection Flag"
      expr: cathodic_protection_flag
    - name: "Cathodic Protection Type"
      expr: cathodic_protection_type
    - name: "City"
      expr: city
    - name: "Coating Type"
      expr: coating_type
    - name: "County"
      expr: county
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Dimp Threat Rank"
      expr: dimp_threat_rank
    - name: "District Code"
      expr: district_code
    - name: "Efv Installation Date"
      expr: efv_installation_date
    - name: "Excess Flow Valve Flag"
      expr: excess_flow_valve_flag
    - name: "Gis Feature Code"
      expr: gis_feature_code
    - name: "Installation Date"
      expr: installation_date
    - name: "Installation Year"
      expr: installation_year
    - name: "Installed By"
      expr: installed_by
    - name: "Joint Type"
      expr: joint_type
    - name: "Last Leak Survey Date"
      expr: last_leak_survey_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Gas Service Lateral"
      expr: COUNT(DISTINCT gas_service_lateral_id)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Length Ft"
      expr: SUM(length_ft)
    - name: "Average Length Ft"
      expr: AVG(length_ft)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Maop Psig"
      expr: SUM(maop_psig)
    - name: "Average Maop Psig"
      expr: AVG(maop_psig)
    - name: "Total Nominal Diameter In"
      expr: SUM(nominal_diameter_in)
    - name: "Average Nominal Diameter In"
      expr: AVG(nominal_diameter_in)
    - name: "Total Operating Pressure Psig"
      expr: SUM(operating_pressure_psig)
    - name: "Average Operating Pressure Psig"
      expr: AVG(operating_pressure_psig)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_load_profile`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Load Profile business metrics"
  source: "`power_and_utilities`.`distribution`.`load_profile`"
  dimensions:
    - name: "Computation Method"
      expr: computation_method
    - name: "Computed Timestamp"
      expr: computed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Count"
      expr: customer_count
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Data Source System"
      expr: data_source_system
    - name: "Demand Response Event Flag"
      expr: demand_response_event_flag
    - name: "Estimation Method"
      expr: estimation_method
    - name: "Gis Feature Code"
      expr: gis_feature_code
    - name: "Hosting Capacity Analysis Flag"
      expr: hosting_capacity_analysis_flag
    - name: "Measurement Interval Minutes"
      expr: measurement_interval_minutes
    - name: "Measurement Point Name"
      expr: measurement_point_name
    - name: "Measurement Point Type"
      expr: measurement_point_type
    - name: "Measurement Timestamp"
      expr: measurement_timestamp
    - name: "Planning Area Code"
      expr: planning_area_code
    - name: "Scada Point Code"
      expr: scada_point_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Load Profile"
      expr: COUNT(DISTINCT load_profile_id)
    - name: "Total Ambient Temperature F"
      expr: SUM(ambient_temperature_f)
    - name: "Average Ambient Temperature F"
      expr: AVG(ambient_temperature_f)
    - name: "Total Apparent Power Kva"
      expr: SUM(apparent_power_kva)
    - name: "Average Apparent Power Kva"
      expr: AVG(apparent_power_kva)
    - name: "Total Average Voltage V"
      expr: SUM(average_voltage_v)
    - name: "Average Average Voltage V"
      expr: AVG(average_voltage_v)
    - name: "Total Circuit Miles"
      expr: SUM(circuit_miles)
    - name: "Average Circuit Miles"
      expr: AVG(circuit_miles)
    - name: "Total Current Amperes"
      expr: SUM(current_amperes)
    - name: "Average Current Amperes"
      expr: AVG(current_amperes)
    - name: "Total Der Penetration Percent"
      expr: SUM(der_penetration_percent)
    - name: "Average Der Penetration Percent"
      expr: AVG(der_penetration_percent)
    - name: "Total Energy Delivered Kwh"
      expr: SUM(energy_delivered_kwh)
    - name: "Average Energy Delivered Kwh"
      expr: AVG(energy_delivered_kwh)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Load Factor"
      expr: SUM(load_factor)
    - name: "Average Load Factor"
      expr: AVG(load_factor)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Peak Demand Kw"
      expr: SUM(peak_demand_kw)
    - name: "Average Peak Demand Kw"
      expr: AVG(peak_demand_kw)
    - name: "Total Power Factor"
      expr: SUM(power_factor)
    - name: "Average Power Factor"
      expr: AVG(power_factor)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_network_model`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Network Model business metrics"
  source: "`power_and_utilities`.`distribution`.`network_model`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Count"
      expr: customer_count
    - name: "Der Integration Enabled"
      expr: der_integration_enabled
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Feeder Count"
      expr: feeder_count
    - name: "Gas Pipeline Safety Compliant"
      expr: gas_pipeline_safety_compliant
    - name: "Gis Layer Reference"
      expr: gis_layer_reference
    - name: "Last Validation Date"
      expr: last_validation_date
    - name: "Model Description"
      expr: model_description
    - name: "Model Name"
      expr: model_name
    - name: "Model Source System"
      expr: model_source_system
    - name: "Model Status"
      expr: model_status
    - name: "Model Type"
      expr: model_type
    - name: "Model Version"
      expr: model_version
    - name: "Node Count"
      expr: node_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Network Model"
      expr: COUNT(DISTINCT network_model_id)
    - name: "Total Der Capacity Mw"
      expr: SUM(der_capacity_mw)
    - name: "Average Der Capacity Mw"
      expr: AVG(der_capacity_mw)
    - name: "Total Peak Load Mw"
      expr: SUM(peak_load_mw)
    - name: "Average Peak Load Mw"
      expr: AVG(peak_load_mw)
    - name: "Total Reliability Index Caidi"
      expr: SUM(reliability_index_caidi)
    - name: "Average Reliability Index Caidi"
      expr: AVG(reliability_index_caidi)
    - name: "Total Reliability Index Saidi"
      expr: SUM(reliability_index_saidi)
    - name: "Average Reliability Index Saidi"
      expr: AVG(reliability_index_saidi)
    - name: "Total Reliability Index Saifi"
      expr: SUM(reliability_index_saifi)
    - name: "Average Reliability Index Saifi"
      expr: AVG(reliability_index_saifi)
    - name: "Total Total Circuit Miles"
      expr: SUM(total_circuit_miles)
    - name: "Average Total Circuit Miles"
      expr: AVG(total_circuit_miles)
    - name: "Total Voltage Level Kv"
      expr: SUM(voltage_level_kv)
    - name: "Average Voltage Level Kv"
      expr: AVG(voltage_level_kv)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_pole`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Pole business metrics"
  source: "`power_and_utilities`.`distribution`.`pole`"
  dimensions:
    - name: "City"
      expr: city
    - name: "Class Rating"
      expr: class_rating
    - name: "County Name"
      expr: county_name
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criticality Rating"
      expr: criticality_rating
    - name: "Data Source System"
      expr: data_source_system
    - name: "Fcc Pole Attachment Compliance Status"
      expr: fcc_pole_attachment_compliance_status
    - name: "Gis Structure Number"
      expr: gis_structure_number
    - name: "Ground Line Condition"
      expr: ground_line_condition
    - name: "Inspection Date"
      expr: inspection_date
    - name: "Inspection Result"
      expr: inspection_result
    - name: "Installation Date"
      expr: installation_date
    - name: "Installation Year"
      expr: installation_year
    - name: "Joint Use Attachment Count"
      expr: joint_use_attachment_count
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Material Type"
      expr: material_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Pole"
      expr: COUNT(DISTINCT pole_id)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Book Value"
      expr: SUM(book_value)
    - name: "Average Book Value"
      expr: AVG(book_value)
    - name: "Total Height Ft"
      expr: SUM(height_ft)
    - name: "Average Height Ft"
      expr: AVG(height_ft)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Loading Percentage"
      expr: SUM(loading_percentage)
    - name: "Average Loading Percentage"
      expr: AVG(loading_percentage)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Vegetation Clearance Zone Ft"
      expr: SUM(vegetation_clearance_zone_ft)
    - name: "Average Vegetation Clearance Zone Ft"
      expr: AVG(vegetation_clearance_zone_ft)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_protective_device`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Protective Device business metrics"
  source: "`power_and_utilities`.`distribution`.`protective_device`"
  dimensions:
    - name: "Communication Protocol"
      expr: communication_protocol
    - name: "Control Type"
      expr: control_type
    - name: "Coordination Group"
      expr: coordination_group
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criticality Rating"
      expr: criticality_rating
    - name: "Current State"
      expr: current_state
    - name: "Customers Affected"
      expr: customers_affected
    - name: "Der Interconnection Flag"
      expr: der_interconnection_flag
    - name: "Device Function Code"
      expr: device_function_code
    - name: "Device Name"
      expr: device_name
    - name: "Device Number"
      expr: device_number
    - name: "Device Type"
      expr: device_type
    - name: "Environmental Rating"
      expr: environmental_rating
    - name: "Gas Insulated"
      expr: gas_insulated
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Protective Device"
      expr: COUNT(DISTINCT protective_device_id)
    - name: "Total Interrupting Capacity Ka"
      expr: SUM(interrupting_capacity_ka)
    - name: "Average Interrupting Capacity Ka"
      expr: AVG(interrupting_capacity_ka)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Rated Current Amperes"
      expr: SUM(rated_current_amperes)
    - name: "Average Rated Current Amperes"
      expr: AVG(rated_current_amperes)
    - name: "Total Rated Voltage Kv"
      expr: SUM(rated_voltage_kv)
    - name: "Average Rated Voltage Kv"
      expr: AVG(rated_voltage_kv)
    - name: "Total Replacement Cost Usd"
      expr: SUM(replacement_cost_usd)
    - name: "Average Replacement Cost Usd"
      expr: AVG(replacement_cost_usd)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_reliability_index`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Reliability Index business metrics"
  source: "`power_and_utilities`.`distribution`.`reliability_index`"
  dimensions:
    - name: "Computation Method"
      expr: computation_method
    - name: "Computed Timestamp"
      expr: computed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Source System"
      expr: data_source_system
    - name: "Index Version"
      expr: index_version
    - name: "Interruption Cause Category"
      expr: interruption_cause_category
    - name: "Med Event Count"
      expr: med_event_count
    - name: "Med Exclusion Flag"
      expr: med_exclusion_flag
    - name: "Nerc Reportable Flag"
      expr: nerc_reportable_flag
    - name: "Notes"
      expr: notes
    - name: "Puc Docket Number"
      expr: puc_docket_number
    - name: "Puc Reporting Status"
      expr: puc_reporting_status
    - name: "Puc Submission Date"
      expr: puc_submission_date
    - name: "Reporting Frequency"
      expr: reporting_frequency
    - name: "Reporting Level"
      expr: reporting_level
    - name: "Reporting Period End"
      expr: reporting_period_end
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Reliability Index"
      expr: COUNT(DISTINCT reliability_index_id)
    - name: "Total Caidi Minutes"
      expr: SUM(caidi_minutes)
    - name: "Average Caidi Minutes"
      expr: AVG(caidi_minutes)
    - name: "Total Circuit Miles"
      expr: SUM(circuit_miles)
    - name: "Average Circuit Miles"
      expr: AVG(circuit_miles)
    - name: "Total Maifi Count"
      expr: SUM(maifi_count)
    - name: "Average Maifi Count"
      expr: AVG(maifi_count)
    - name: "Total Med Excluded Saidi Minutes"
      expr: SUM(med_excluded_saidi_minutes)
    - name: "Average Med Excluded Saidi Minutes"
      expr: AVG(med_excluded_saidi_minutes)
    - name: "Total Overhead Circuit Miles"
      expr: SUM(overhead_circuit_miles)
    - name: "Average Overhead Circuit Miles"
      expr: AVG(overhead_circuit_miles)
    - name: "Total Prior Year Saidi Minutes"
      expr: SUM(prior_year_saidi_minutes)
    - name: "Average Prior Year Saidi Minutes"
      expr: AVG(prior_year_saidi_minutes)
    - name: "Total Prior Year Saifi Count"
      expr: SUM(prior_year_saifi_count)
    - name: "Average Prior Year Saifi Count"
      expr: AVG(prior_year_saifi_count)
    - name: "Total Saidi Minutes"
      expr: SUM(saidi_minutes)
    - name: "Average Saidi Minutes"
      expr: AVG(saidi_minutes)
    - name: "Total Saidi With Med Minutes"
      expr: SUM(saidi_with_med_minutes)
    - name: "Average Saidi With Med Minutes"
      expr: AVG(saidi_with_med_minutes)
    - name: "Total Saifi Count"
      expr: SUM(saifi_count)
    - name: "Average Saifi Count"
      expr: AVG(saifi_count)
    - name: "Total Saifi With Med Count"
      expr: SUM(saifi_with_med_count)
    - name: "Average Saifi With Med Count"
      expr: AVG(saifi_with_med_count)
    - name: "Total Total Customer Interruptions"
      expr: SUM(total_customer_interruptions)
    - name: "Average Total Customer Interruptions"
      expr: AVG(total_customer_interruptions)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_service_area`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Area business metrics"
  source: "`power_and_utilities`.`distribution`.`service_area`"
  dimensions:
    - name: "Commercial Customer Count"
      expr: commercial_customer_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Count"
      expr: customer_count
    - name: "Der Interconnection Count"
      expr: der_interconnection_count
    - name: "Description"
      expr: description
    - name: "Distribution Feeder Count"
      expr: distribution_feeder_count
    - name: "Distribution Substation Count"
      expr: distribution_substation_count
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Geographic Boundary"
      expr: geographic_boundary
    - name: "Industrial Customer Count"
      expr: industrial_customer_count
    - name: "Last Boundary Update Date"
      expr: last_boundary_update_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Name"
      expr: name
    - name: "Nem Customer Count"
      expr: nem_customer_count
    - name: "Regulatory Jurisdiction"
      expr: regulatory_jurisdiction
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Area"
      expr: COUNT(DISTINCT service_area_id)
    - name: "Total Annual Energy Consumption Mwh"
      expr: SUM(annual_energy_consumption_mwh)
    - name: "Average Annual Energy Consumption Mwh"
      expr: AVG(annual_energy_consumption_mwh)
    - name: "Total Annual Gas Throughput Mcf"
      expr: SUM(annual_gas_throughput_mcf)
    - name: "Average Annual Gas Throughput Mcf"
      expr: AVG(annual_gas_throughput_mcf)
    - name: "Total Area Square Miles"
      expr: SUM(area_square_miles)
    - name: "Average Area Square Miles"
      expr: AVG(area_square_miles)
    - name: "Total Caidi Minutes"
      expr: SUM(caidi_minutes)
    - name: "Average Caidi Minutes"
      expr: AVG(caidi_minutes)
    - name: "Total Centroid Latitude"
      expr: SUM(centroid_latitude)
    - name: "Average Centroid Latitude"
      expr: AVG(centroid_latitude)
    - name: "Total Centroid Longitude"
      expr: SUM(centroid_longitude)
    - name: "Average Centroid Longitude"
      expr: AVG(centroid_longitude)
    - name: "Total Der Capacity Mw"
      expr: SUM(der_capacity_mw)
    - name: "Average Der Capacity Mw"
      expr: AVG(der_capacity_mw)
    - name: "Total Electric Overhead Line Miles"
      expr: SUM(electric_overhead_line_miles)
    - name: "Average Electric Overhead Line Miles"
      expr: AVG(electric_overhead_line_miles)
    - name: "Total Electric Underground Line Miles"
      expr: SUM(electric_underground_line_miles)
    - name: "Average Electric Underground Line Miles"
      expr: AVG(electric_underground_line_miles)
    - name: "Total Gas Main Miles"
      expr: SUM(gas_main_miles)
    - name: "Average Gas Main Miles"
      expr: AVG(gas_main_miles)
    - name: "Total Peak Demand Mw"
      expr: SUM(peak_demand_mw)
    - name: "Average Peak Demand Mw"
      expr: AVG(peak_demand_mw)
    - name: "Total Saidi Minutes"
      expr: SUM(saidi_minutes)
    - name: "Average Saidi Minutes"
      expr: AVG(saidi_minutes)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_service_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Point business metrics"
  source: "`power_and_utilities`.`distribution`.`service_point`"
  dimensions:
    - name: "Ami Enabled Flag"
      expr: ami_enabled_flag
    - name: "City"
      expr: city
    - name: "Connect Date"
      expr: connect_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Der Interconnect Flag"
      expr: der_interconnect_flag
    - name: "Disconnect Date"
      expr: disconnect_date
    - name: "Dr Program Enrolled Flag"
      expr: dr_program_enrolled_flag
    - name: "Ev Charger Flag"
      expr: ev_charger_flag
    - name: "Gas Meter Set Code"
      expr: gas_meter_set_code
    - name: "Gas Pressure Class"
      expr: gas_pressure_class
    - name: "Gis Last Updated Date"
      expr: gis_last_updated_date
    - name: "Gis Parcel Code"
      expr: gis_parcel_code
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Load Class Code"
      expr: load_class_code
    - name: "Meter Read Cycle"
      expr: meter_read_cycle
    - name: "Meter Socket Code"
      expr: meter_socket_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Point"
      expr: COUNT(DISTINCT service_point_id)
    - name: "Total Contract Demand Kw"
      expr: SUM(contract_demand_kw)
    - name: "Average Contract Demand Kw"
      expr: AVG(contract_demand_kw)
    - name: "Total Der Capacity Kw"
      expr: SUM(der_capacity_kw)
    - name: "Average Der Capacity Kw"
      expr: AVG(der_capacity_kw)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Service Lateral Length Ft"
      expr: SUM(service_lateral_length_ft)
    - name: "Average Service Lateral Length Ft"
      expr: AVG(service_lateral_length_ft)
    - name: "Total Service Voltage V"
      expr: SUM(service_voltage_v)
    - name: "Average Service Voltage V"
      expr: AVG(service_voltage_v)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_service_point_dr_participation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Point Dr Participation business metrics"
  source: "`power_and_utilities`.`distribution`.`service_point_dr_participation`"
  dimensions:
    - name: "Compliance Flag"
      expr: compliance_flag
    - name: "Enrollment Status"
      expr: enrollment_status
    - name: "Notification Method"
      expr: notification_method
    - name: "Notification Sent Timestamp"
      expr: notification_sent_timestamp
    - name: "Opt Out Flag"
      expr: opt_out_flag
    - name: "Participation Status"
      expr: participation_status
    - name: "Notification Sent Timestamp Month"
      expr: DATE_TRUNC('MONTH', notification_sent_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Point Dr Participation"
      expr: COUNT(DISTINCT service_point_dr_participation_id)
    - name: "Total Actual Load Kw"
      expr: SUM(actual_load_kw)
    - name: "Average Actual Load Kw"
      expr: AVG(actual_load_kw)
    - name: "Total Baseline Kw"
      expr: SUM(baseline_kw)
    - name: "Average Baseline Kw"
      expr: AVG(baseline_kw)
    - name: "Total Curtailment Percentage"
      expr: SUM(curtailment_percentage)
    - name: "Average Curtailment Percentage"
      expr: AVG(curtailment_percentage)
    - name: "Total Incentive Earned"
      expr: SUM(incentive_earned)
    - name: "Average Incentive Earned"
      expr: AVG(incentive_earned)
    - name: "Total Response Kw"
      expr: SUM(response_kw)
    - name: "Average Response Kw"
      expr: AVG(response_kw)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_service_territory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Territory business metrics"
  source: "`power_and_utilities`.`distribution`.`service_territory`"
  dimensions:
    - name: "Boundary Description"
      expr: boundary_description
    - name: "Boundary Geojson"
      expr: boundary_geojson
    - name: "Climate Zone"
      expr: climate_zone
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Effective Date"
      expr: effective_date
    - name: "Franchise Agreement Number"
      expr: franchise_agreement_number
    - name: "Franchise Expiration Date"
      expr: franchise_expiration_date
    - name: "Jurisdiction Type"
      expr: jurisdiction_type
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Nem Interconnection Count"
      expr: nem_interconnection_count
    - name: "Notes"
      expr: notes
    - name: "Primary Contact Email"
      expr: primary_contact_email
    - name: "Primary Contact Name"
      expr: primary_contact_name
    - name: "Primary Contact Phone"
      expr: primary_contact_phone
    - name: "Regulatory Jurisdiction"
      expr: regulatory_jurisdiction
    - name: "Status"
      expr: status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Territory"
      expr: COUNT(DISTINCT service_territory_id)
    - name: "Total Annual Energy Sales Mwh"
      expr: SUM(annual_energy_sales_mwh)
    - name: "Average Annual Energy Sales Mwh"
      expr: AVG(annual_energy_sales_mwh)
    - name: "Total Caidi Minutes"
      expr: SUM(caidi_minutes)
    - name: "Average Caidi Minutes"
      expr: AVG(caidi_minutes)
    - name: "Total Customer Count"
      expr: SUM(customer_count)
    - name: "Average Customer Count"
      expr: AVG(customer_count)
    - name: "Total Der Capacity Mw"
      expr: SUM(der_capacity_mw)
    - name: "Average Der Capacity Mw"
      expr: AVG(der_capacity_mw)
    - name: "Total Electric Circuit Miles"
      expr: SUM(electric_circuit_miles)
    - name: "Average Electric Circuit Miles"
      expr: AVG(electric_circuit_miles)
    - name: "Total Gas Pipeline Miles"
      expr: SUM(gas_pipeline_miles)
    - name: "Average Gas Pipeline Miles"
      expr: AVG(gas_pipeline_miles)
    - name: "Total Gas Throughput Mcf"
      expr: SUM(gas_throughput_mcf)
    - name: "Average Gas Throughput Mcf"
      expr: AVG(gas_throughput_mcf)
    - name: "Total Peak Demand Mw"
      expr: SUM(peak_demand_mw)
    - name: "Average Peak Demand Mw"
      expr: AVG(peak_demand_mw)
    - name: "Total Population Served"
      expr: SUM(population_served)
    - name: "Average Population Served"
      expr: AVG(population_served)
    - name: "Total Saidi Minutes"
      expr: SUM(saidi_minutes)
    - name: "Average Saidi Minutes"
      expr: AVG(saidi_minutes)
    - name: "Total Saifi Count"
      expr: SUM(saifi_count)
    - name: "Average Saifi Count"
      expr: AVG(saifi_count)
    - name: "Total Service Area Square Miles"
      expr: SUM(service_area_square_miles)
    - name: "Average Service Area Square Miles"
      expr: AVG(service_area_square_miles)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_service_transformer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service Transformer business metrics"
  source: "`power_and_utilities`.`distribution`.`service_transformer`"
  dimensions:
    - name: "City"
      expr: city
    - name: "Connected Customer Count"
      expr: connected_customer_count
    - name: "Cooling Type"
      expr: cooling_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Criticality Rating"
      expr: criticality_rating
    - name: "Der Interconnection Flag"
      expr: der_interconnection_flag
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Manufacture Year"
      expr: manufacture_year
    - name: "Next Inspection Due Date"
      expr: next_inspection_due_date
    - name: "Operational Status"
      expr: operational_status
    - name: "Ownership Type"
      expr: ownership_type
    - name: "Phase Configuration"
      expr: phase_configuration
    - name: "Postal Code"
      expr: postal_code
    - name: "Retirement Date"
      expr: retirement_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Service Transformer"
      expr: COUNT(DISTINCT service_transformer_id)
    - name: "Total Acquisition Cost"
      expr: SUM(acquisition_cost)
    - name: "Average Acquisition Cost"
      expr: AVG(acquisition_cost)
    - name: "Total Asset Condition Score"
      expr: SUM(asset_condition_score)
    - name: "Average Asset Condition Score"
      expr: AVG(asset_condition_score)
    - name: "Total Book Value"
      expr: SUM(book_value)
    - name: "Average Book Value"
      expr: AVG(book_value)
    - name: "Total Impedance Percent"
      expr: SUM(impedance_percent)
    - name: "Average Impedance Percent"
      expr: AVG(impedance_percent)
    - name: "Total Kva Rating"
      expr: SUM(kva_rating)
    - name: "Average Kva Rating"
      expr: AVG(kva_rating)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Load Factor Percent"
      expr: SUM(load_factor_percent)
    - name: "Average Load Factor Percent"
      expr: AVG(load_factor_percent)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Peak Load Kva"
      expr: SUM(peak_load_kva)
    - name: "Average Peak Load Kva"
      expr: AVG(peak_load_kva)
    - name: "Total Primary Voltage"
      expr: SUM(primary_voltage)
    - name: "Average Primary Voltage"
      expr: AVG(primary_voltage)
    - name: "Total Secondary Voltage"
      expr: SUM(secondary_voltage)
    - name: "Average Secondary Voltage"
      expr: AVG(secondary_voltage)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_switching_operation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Switching Operation business metrics"
  source: "`power_and_utilities`.`distribution`.`switching_operation`"
  dimensions:
    - name: "Authorized Timestamp"
      expr: authorized_timestamp
    - name: "Completed Timestamp"
      expr: completed_timestamp
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customers Affected Count"
      expr: customers_affected_count
    - name: "Device Identifier"
      expr: device_identifier
    - name: "Device Operated"
      expr: device_operated
    - name: "Dms System Source"
      expr: dms_system_source
    - name: "Gis Location Reference"
      expr: gis_location_reference
    - name: "Major Event Day Flag"
      expr: major_event_day_flag
    - name: "Nerc Reportable Flag"
      expr: nerc_reportable_flag
    - name: "Operation Status"
      expr: operation_status
    - name: "Operation Timestamp"
      expr: operation_timestamp
    - name: "Operation Type"
      expr: operation_type
    - name: "Post Switch Configuration"
      expr: post_switch_configuration
    - name: "Pre Switch Configuration"
      expr: pre_switch_configuration
    - name: "Rollback Flag"
      expr: rollback_flag
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Switching Operation"
      expr: COUNT(DISTINCT switching_operation_id)
    - name: "Total Authorizing Supervisor Employee Number"
      expr: SUM(authorizing_supervisor_employee_number)
    - name: "Average Authorizing Supervisor Employee Number"
      expr: AVG(authorizing_supervisor_employee_number)
    - name: "Total Interruption Duration Minutes"
      expr: SUM(interruption_duration_minutes)
    - name: "Average Interruption Duration Minutes"
      expr: AVG(interruption_duration_minutes)
    - name: "Total Load Transferred Kw"
      expr: SUM(load_transferred_kw)
    - name: "Average Load Transferred Kw"
      expr: AVG(load_transferred_kw)
    - name: "Total Operator Employee Number"
      expr: SUM(operator_employee_number)
    - name: "Average Operator Employee Number"
      expr: AVG(operator_employee_number)
    - name: "Total Voltage Level Kv"
      expr: SUM(voltage_level_kv)
    - name: "Average Voltage Level Kv"
      expr: AVG(voltage_level_kv)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_voltage_regulation_device`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Voltage Regulation Device business metrics"
  source: "`power_and_utilities`.`distribution`.`voltage_regulation_device`"
  dimensions:
    - name: "Communication Protocol"
      expr: communication_protocol
    - name: "Control Mode"
      expr: control_mode
    - name: "Cvr Enrolled"
      expr: cvr_enrolled
    - name: "Der Hosting Zone"
      expr: der_hosting_zone
    - name: "Device Code"
      expr: device_code
    - name: "Device Name"
      expr: device_name
    - name: "Device Subtype"
      expr: device_subtype
    - name: "Device Type"
      expr: device_type
    - name: "Ferc Account Number"
      expr: ferc_account_number
    - name: "Gis Object Code"
      expr: gis_object_code
    - name: "In Service Date"
      expr: in_service_date
    - name: "Installation Date"
      expr: installation_date
    - name: "Last Maintenance Date"
      expr: last_maintenance_date
    - name: "Last Tap Position"
      expr: last_tap_position
    - name: "Last Tap Position Timestamp"
      expr: last_tap_position_timestamp
    - name: "Maximo Asset Code"
      expr: maximo_asset_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Voltage Regulation Device"
      expr: COUNT(DISTINCT voltage_regulation_device_id)
    - name: "Total Bandwidth V"
      expr: SUM(bandwidth_v)
    - name: "Average Bandwidth V"
      expr: AVG(bandwidth_v)
    - name: "Total Circuit Mile Marker"
      expr: SUM(circuit_mile_marker)
    - name: "Average Circuit Mile Marker"
      expr: AVG(circuit_mile_marker)
    - name: "Total Cumulative Tap Operations"
      expr: SUM(cumulative_tap_operations)
    - name: "Average Cumulative Tap Operations"
      expr: AVG(cumulative_tap_operations)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Rated Kva"
      expr: SUM(rated_kva)
    - name: "Average Rated Kva"
      expr: AVG(rated_kva)
    - name: "Total Rated Kvar"
      expr: SUM(rated_kvar)
    - name: "Average Rated Kvar"
      expr: AVG(rated_kvar)
    - name: "Total Rated Voltage Kv"
      expr: SUM(rated_voltage_kv)
    - name: "Average Rated Voltage Kv"
      expr: AVG(rated_voltage_kv)
    - name: "Total Time Delay Seconds"
      expr: SUM(time_delay_seconds)
    - name: "Average Time Delay Seconds"
      expr: AVG(time_delay_seconds)
    - name: "Total Voltage Setpoint V"
      expr: SUM(voltage_setpoint_v)
    - name: "Average Voltage Setpoint V"
      expr: AVG(voltage_setpoint_v)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`distribution_zone`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Zone business metrics"
  source: "`power_and_utilities`.`distribution`.`zone`"
  dimensions:
    - name: "Commercial Customer Count"
      expr: commercial_customer_count
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Count"
      expr: customer_count
    - name: "Description"
      expr: description
    - name: "Effective Date"
      expr: effective_date
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Gas Service Lateral Count"
      expr: gas_service_lateral_count
    - name: "Gis Boundary Wkt"
      expr: gis_boundary_wkt
    - name: "Industrial Customer Count"
      expr: industrial_customer_count
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Nem Interconnection Count"
      expr: nem_interconnection_count
    - name: "Notes"
      expr: notes
    - name: "Pole Count"
      expr: pole_count
    - name: "Residential Customer Count"
      expr: residential_customer_count
    - name: "Status"
      expr: status
    - name: "Transformer Count"
      expr: transformer_count
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Zone"
      expr: COUNT(DISTINCT zone_id)
    - name: "Total Caidi Minutes"
      expr: SUM(caidi_minutes)
    - name: "Average Caidi Minutes"
      expr: AVG(caidi_minutes)
    - name: "Total Centroid Latitude"
      expr: SUM(centroid_latitude)
    - name: "Average Centroid Latitude"
      expr: AVG(centroid_latitude)
    - name: "Total Centroid Longitude"
      expr: SUM(centroid_longitude)
    - name: "Average Centroid Longitude"
      expr: AVG(centroid_longitude)
    - name: "Total Circuit Miles"
      expr: SUM(circuit_miles)
    - name: "Average Circuit Miles"
      expr: AVG(circuit_miles)
    - name: "Total Der Capacity Mw"
      expr: SUM(der_capacity_mw)
    - name: "Average Der Capacity Mw"
      expr: AVG(der_capacity_mw)
    - name: "Total Gas Main Miles"
      expr: SUM(gas_main_miles)
    - name: "Average Gas Main Miles"
      expr: AVG(gas_main_miles)
    - name: "Total Operating Pressure Psig"
      expr: SUM(operating_pressure_psig)
    - name: "Average Operating Pressure Psig"
      expr: AVG(operating_pressure_psig)
    - name: "Total Peak Demand Mw"
      expr: SUM(peak_demand_mw)
    - name: "Average Peak Demand Mw"
      expr: AVG(peak_demand_mw)
    - name: "Total Saidi Minutes"
      expr: SUM(saidi_minutes)
    - name: "Average Saidi Minutes"
      expr: AVG(saidi_minutes)
    - name: "Total Saifi Count"
      expr: SUM(saifi_count)
    - name: "Average Saifi Count"
      expr: AVG(saifi_count)
    - name: "Total Underground Percentage"
      expr: SUM(underground_percentage)
    - name: "Average Underground Percentage"
      expr: AVG(underground_percentage)
    - name: "Total Voltage Level Kv"
      expr: SUM(voltage_level_kv)
    - name: "Average Voltage Level Kv"
      expr: AVG(voltage_level_kv)
$$;