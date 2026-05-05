-- Metric views for domain: generation | Business: Power and Utilities | Version: 1 | Generated on: 2026-04-29 23:10:45

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`generation_capacity_resource`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity Resource business metrics"
  source: "`power_and_utilities`.`generation`.`capacity_resource`"
  dimensions:
    - name: "Accreditation Period End Date"
      expr: accreditation_period_end_date
    - name: "Accreditation Period Start Date"
      expr: accreditation_period_start_date
    - name: "Bonus Payment Eligible Flag"
      expr: bonus_payment_eligible_flag
    - name: "Capacity Commitment Period End Date"
      expr: capacity_commitment_period_end_date
    - name: "Capacity Commitment Period Start Date"
      expr: capacity_commitment_period_start_date
    - name: "Capacity Interconnection Rights Flag"
      expr: capacity_interconnection_rights_flag
    - name: "Capacity Market Product Type"
      expr: capacity_market_product_type
    - name: "Capacity Transfer Rights Flag"
      expr: capacity_transfer_rights_flag
    - name: "Capacity Zone"
      expr: capacity_zone
    - name: "Demand Response Resource Flag"
      expr: demand_response_resource_flag
    - name: "Energy Storage Resource Flag"
      expr: energy_storage_resource_flag
    - name: "Last Accreditation Test Date"
      expr: last_accreditation_test_date
    - name: "Must Offer Obligation Flag"
      expr: must_offer_obligation_flag
    - name: "Next Accreditation Test Date"
      expr: next_accreditation_test_date
    - name: "Planning Year"
      expr: planning_year
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Capacity Resource"
      expr: COUNT(DISTINCT capacity_resource_id)
    - name: "Total Accredited Capacity Mw"
      expr: SUM(accredited_capacity_mw)
    - name: "Average Accredited Capacity Mw"
      expr: AVG(accredited_capacity_mw)
    - name: "Total Auction Clearing Price Per Mw Day"
      expr: SUM(auction_clearing_price_per_mw_day)
    - name: "Average Auction Clearing Price Per Mw Day"
      expr: AVG(auction_clearing_price_per_mw_day)
    - name: "Total Capacity Revenue Amount"
      expr: SUM(capacity_revenue_amount)
    - name: "Average Capacity Revenue Amount"
      expr: AVG(capacity_revenue_amount)
    - name: "Total Equivalent Forced Outage Rate Eford"
      expr: SUM(equivalent_forced_outage_rate_eford)
    - name: "Average Equivalent Forced Outage Rate Eford"
      expr: AVG(equivalent_forced_outage_rate_eford)
    - name: "Total Installed Capacity Icap Mw"
      expr: SUM(installed_capacity_icap_mw)
    - name: "Average Installed Capacity Icap Mw"
      expr: AVG(installed_capacity_icap_mw)
    - name: "Total Non Performance Charge Rate"
      expr: SUM(non_performance_charge_rate)
    - name: "Average Non Performance Charge Rate"
      expr: AVG(non_performance_charge_rate)
    - name: "Total Performance Obligation Mw"
      expr: SUM(performance_obligation_mw)
    - name: "Average Performance Obligation Mw"
      expr: AVG(performance_obligation_mw)
    - name: "Total Unforced Capacity Ucap Mw"
      expr: SUM(unforced_capacity_ucap_mw)
    - name: "Average Unforced Capacity Ucap Mw"
      expr: AVG(unforced_capacity_ucap_mw)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`generation_dispatch_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Dispatch Schedule business metrics"
  source: "`power_and_utilities`.`generation`.`dispatch_schedule`"
  dimensions:
    - name: "Ancillary Service Flag"
      expr: ancillary_service_flag
    - name: "Commitment Flag"
      expr: commitment_flag
    - name: "Control Area"
      expr: control_area
    - name: "Dispatch Instruction Timestamp"
      expr: dispatch_instruction_timestamp
    - name: "Dispatch Status"
      expr: dispatch_status
    - name: "Dispatch Type"
      expr: dispatch_type
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Minimum Down Time Hours"
      expr: minimum_down_time_hours
    - name: "Minimum Up Time Hours"
      expr: minimum_up_time_hours
    - name: "Must Run Flag"
      expr: must_run_flag
    - name: "Operating Hour"
      expr: operating_hour
    - name: "Schedule Created Timestamp"
      expr: schedule_created_timestamp
    - name: "Schedule Date"
      expr: schedule_date
    - name: "Schedule Notes"
      expr: schedule_notes
    - name: "Schedule Source System"
      expr: schedule_source_system
    - name: "Schedule Type"
      expr: schedule_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Dispatch Schedule"
      expr: COUNT(DISTINCT dispatch_schedule_id)
    - name: "Total Economic Dispatch Mw"
      expr: SUM(economic_dispatch_mw)
    - name: "Average Economic Dispatch Mw"
      expr: AVG(economic_dispatch_mw)
    - name: "Total Emissions Rate Lbs Per Mwh"
      expr: SUM(emissions_rate_lbs_per_mwh)
    - name: "Average Emissions Rate Lbs Per Mwh"
      expr: AVG(emissions_rate_lbs_per_mwh)
    - name: "Total Forecast Load Mw"
      expr: SUM(forecast_load_mw)
    - name: "Average Forecast Load Mw"
      expr: AVG(forecast_load_mw)
    - name: "Total Fuel Burn Forecast Mmbtu"
      expr: SUM(fuel_burn_forecast_mmbtu)
    - name: "Average Fuel Burn Forecast Mmbtu"
      expr: AVG(fuel_burn_forecast_mmbtu)
    - name: "Total Heat Rate Btu Per Kwh"
      expr: SUM(heat_rate_btu_per_kwh)
    - name: "Average Heat Rate Btu Per Kwh"
      expr: AVG(heat_rate_btu_per_kwh)
    - name: "Total Marginal Cost Usd Per Mwh"
      expr: SUM(marginal_cost_usd_per_mwh)
    - name: "Average Marginal Cost Usd Per Mwh"
      expr: AVG(marginal_cost_usd_per_mwh)
    - name: "Total Maximum Generation Mw"
      expr: SUM(maximum_generation_mw)
    - name: "Average Maximum Generation Mw"
      expr: AVG(maximum_generation_mw)
    - name: "Total Minimum Generation Mw"
      expr: SUM(minimum_generation_mw)
    - name: "Average Minimum Generation Mw"
      expr: AVG(minimum_generation_mw)
    - name: "Total Ramp Rate Mw Per Min"
      expr: SUM(ramp_rate_mw_per_min)
    - name: "Average Ramp Rate Mw Per Min"
      expr: AVG(ramp_rate_mw_per_min)
    - name: "Total Regulation Reserve Mw"
      expr: SUM(regulation_reserve_mw)
    - name: "Average Regulation Reserve Mw"
      expr: AVG(regulation_reserve_mw)
    - name: "Total Scheduled Mw Output"
      expr: SUM(scheduled_mw_output)
    - name: "Average Scheduled Mw Output"
      expr: AVG(scheduled_mw_output)
    - name: "Total Spinning Reserve Mw"
      expr: SUM(spinning_reserve_mw)
    - name: "Average Spinning Reserve Mw"
      expr: AVG(spinning_reserve_mw)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`generation_emissions_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Emissions Record business metrics"
  source: "`power_and_utilities`.`generation`.`emissions_record`"
  dimensions:
    - name: "Allowance Account Number"
      expr: allowance_account_number
    - name: "Cems Monitor Status"
      expr: cems_monitor_status
    - name: "Comments"
      expr: comments
    - name: "Control Equipment Status"
      expr: control_equipment_status
    - name: "Data Source System"
      expr: data_source_system
    - name: "Data Substitution Flag"
      expr: data_substitution_flag
    - name: "Ecmps Submission Date"
      expr: ecmps_submission_date
    - name: "Ecmps Submission Status"
      expr: ecmps_submission_status
    - name: "Ecmps Tracking Number"
      expr: ecmps_tracking_number
    - name: "Fuel Consumption Unit"
      expr: fuel_consumption_unit
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Ghg Inventory Category"
      expr: ghg_inventory_category
    - name: "Measurement Method"
      expr: measurement_method
    - name: "Pollutant Type"
      expr: pollutant_type
    - name: "Qa Certification Date"
      expr: qa_certification_date
    - name: "Qa Test Result"
      expr: qa_test_result
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Emissions Record"
      expr: COUNT(DISTINCT emissions_record_id)
    - name: "Total Allowance Consumption"
      expr: SUM(allowance_consumption)
    - name: "Average Allowance Consumption"
      expr: AVG(allowance_consumption)
    - name: "Total Ambient Temperature F"
      expr: SUM(ambient_temperature_f)
    - name: "Average Ambient Temperature F"
      expr: AVG(ambient_temperature_f)
    - name: "Total Carbon Content Percent"
      expr: SUM(carbon_content_percent)
    - name: "Average Carbon Content Percent"
      expr: AVG(carbon_content_percent)
    - name: "Total Carbon Cost Total"
      expr: SUM(carbon_cost_total)
    - name: "Average Carbon Cost Total"
      expr: AVG(carbon_cost_total)
    - name: "Total Carbon Price Per Ton"
      expr: SUM(carbon_price_per_ton)
    - name: "Average Carbon Price Per Ton"
      expr: AVG(carbon_price_per_ton)
    - name: "Total Control Efficiency Percent"
      expr: SUM(control_efficiency_percent)
    - name: "Average Control Efficiency Percent"
      expr: AVG(control_efficiency_percent)
    - name: "Total Data Quality Score"
      expr: SUM(data_quality_score)
    - name: "Average Data Quality Score"
      expr: AVG(data_quality_score)
    - name: "Total Emission Quantity Tons"
      expr: SUM(emission_quantity_tons)
    - name: "Average Emission Quantity Tons"
      expr: AVG(emission_quantity_tons)
    - name: "Total Emission Rate Lbs Per Mmbtu"
      expr: SUM(emission_rate_lbs_per_mmbtu)
    - name: "Average Emission Rate Lbs Per Mmbtu"
      expr: AVG(emission_rate_lbs_per_mmbtu)
    - name: "Total Fuel Consumption Quantity"
      expr: SUM(fuel_consumption_quantity)
    - name: "Average Fuel Consumption Quantity"
      expr: AVG(fuel_consumption_quantity)
    - name: "Total Gross Generation Mwh"
      expr: SUM(gross_generation_mwh)
    - name: "Average Gross Generation Mwh"
      expr: AVG(gross_generation_mwh)
    - name: "Total Heat Input Mmbtu"
      expr: SUM(heat_input_mmbtu)
    - name: "Average Heat Input Mmbtu"
      expr: AVG(heat_input_mmbtu)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`generation_environmental_permit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental Permit business metrics"
  source: "`power_and_utilities`.`generation`.`environmental_permit`"
  dimensions:
    - name: "Compliance Status"
      expr: compliance_status
    - name: "Contact Email"
      expr: contact_email
    - name: "Contact Phone"
      expr: contact_phone
    - name: "Control Equipment Required"
      expr: control_equipment_required
    - name: "Data Source System"
      expr: data_source_system
    - name: "Effective Date"
      expr: effective_date
    - name: "Enforcement Action Flag"
      expr: enforcement_action_flag
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Issuance Date"
      expr: issuance_date
    - name: "Issuing Agency"
      expr: issuing_agency
    - name: "Issuing Agency Code"
      expr: issuing_agency_code
    - name: "Last Inspection Date"
      expr: last_inspection_date
    - name: "Last Inspection Result"
      expr: last_inspection_result
    - name: "Last Violation Date"
      expr: last_violation_date
    - name: "Monitoring Frequency"
      expr: monitoring_frequency
    - name: "Permit Conditions"
      expr: permit_conditions
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Environmental Permit"
      expr: COUNT(DISTINCT environmental_permit_id)
    - name: "Total Control Efficiency Required Percent"
      expr: SUM(control_efficiency_required_percent)
    - name: "Average Control Efficiency Required Percent"
      expr: AVG(control_efficiency_required_percent)
    - name: "Total Cooling Water Intake Limit Mgd"
      expr: SUM(cooling_water_intake_limit_mgd)
    - name: "Average Cooling Water Intake Limit Mgd"
      expr: AVG(cooling_water_intake_limit_mgd)
    - name: "Total Emission Limit Tons Per Year"
      expr: SUM(emission_limit_tons_per_year)
    - name: "Average Emission Limit Tons Per Year"
      expr: AVG(emission_limit_tons_per_year)
    - name: "Total Emission Rate Limit Lbs Per Mmbtu"
      expr: SUM(emission_rate_limit_lbs_per_mmbtu)
    - name: "Average Emission Rate Limit Lbs Per Mmbtu"
      expr: AVG(emission_rate_limit_lbs_per_mmbtu)
    - name: "Total Hazardous Waste Quantity Limit Tons Per Month"
      expr: SUM(hazardous_waste_quantity_limit_tons_per_month)
    - name: "Average Hazardous Waste Quantity Limit Tons Per Month"
      expr: AVG(hazardous_waste_quantity_limit_tons_per_month)
    - name: "Total Penalty Amount Usd"
      expr: SUM(penalty_amount_usd)
    - name: "Average Penalty Amount Usd"
      expr: AVG(penalty_amount_usd)
    - name: "Total Permit Fee Amount Usd"
      expr: SUM(permit_fee_amount_usd)
    - name: "Average Permit Fee Amount Usd"
      expr: AVG(permit_fee_amount_usd)
    - name: "Total Water Discharge Limit Mgd"
      expr: SUM(water_discharge_limit_mgd)
    - name: "Average Water Discharge Limit Mgd"
      expr: AVG(water_discharge_limit_mgd)
    - name: "Total Water Temperature Limit F"
      expr: SUM(water_temperature_limit_f)
    - name: "Average Water Temperature Limit F"
      expr: AVG(water_temperature_limit_f)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`generation_fuel_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel Consumption business metrics"
  source: "`power_and_utilities`.`generation`.`fuel_consumption`"
  dimensions:
    - name: "Cems Reconciliation Flag"
      expr: cems_reconciliation_flag
    - name: "Comments"
      expr: comments
    - name: "Consumption Date"
      expr: consumption_date
    - name: "Consumption Timestamp"
      expr: consumption_timestamp
    - name: "Data Quality Code"
      expr: data_quality_code
    - name: "Data Source"
      expr: data_source
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Eia Reporting Flag"
      expr: eia_reporting_flag
    - name: "Fac Recovery Eligible Flag"
      expr: fac_recovery_eligible_flag
    - name: "Fuel Subtype"
      expr: fuel_subtype
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Operating Mode"
      expr: operating_mode
    - name: "Quantity Unit"
      expr: quantity_unit
    - name: "Record Created Timestamp"
      expr: record_created_timestamp
    - name: "Record Updated Timestamp"
      expr: record_updated_timestamp
    - name: "Consumption Date Month"
      expr: DATE_TRUNC('MONTH', consumption_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fuel Consumption"
      expr: COUNT(DISTINCT fuel_consumption_id)
    - name: "Total Ambient Temperature F"
      expr: SUM(ambient_temperature_f)
    - name: "Average Ambient Temperature F"
      expr: AVG(ambient_temperature_f)
    - name: "Total Ch4 Emissions Factor"
      expr: SUM(ch4_emissions_factor)
    - name: "Average Ch4 Emissions Factor"
      expr: AVG(ch4_emissions_factor)
    - name: "Total Co2 Emissions Factor"
      expr: SUM(co2_emissions_factor)
    - name: "Average Co2 Emissions Factor"
      expr: AVG(co2_emissions_factor)
    - name: "Total Fuel Cost Per Unit"
      expr: SUM(fuel_cost_per_unit)
    - name: "Average Fuel Cost Per Unit"
      expr: AVG(fuel_cost_per_unit)
    - name: "Total Generation Output Mwh"
      expr: SUM(generation_output_mwh)
    - name: "Average Generation Output Mwh"
      expr: AVG(generation_output_mwh)
    - name: "Total Heat Content Per Unit"
      expr: SUM(heat_content_per_unit)
    - name: "Average Heat Content Per Unit"
      expr: AVG(heat_content_per_unit)
    - name: "Total Heat Rate Btu Per Kwh"
      expr: SUM(heat_rate_btu_per_kwh)
    - name: "Average Heat Rate Btu Per Kwh"
      expr: AVG(heat_rate_btu_per_kwh)
    - name: "Total Nox Emissions Factor"
      expr: SUM(nox_emissions_factor)
    - name: "Average Nox Emissions Factor"
      expr: AVG(nox_emissions_factor)
    - name: "Total Quantity Consumed"
      expr: SUM(quantity_consumed)
    - name: "Average Quantity Consumed"
      expr: AVG(quantity_consumed)
    - name: "Total So2 Emissions Factor"
      expr: SUM(so2_emissions_factor)
    - name: "Average So2 Emissions Factor"
      expr: AVG(so2_emissions_factor)
    - name: "Total Total Co2 Emissions Tons"
      expr: SUM(total_co2_emissions_tons)
    - name: "Average Total Co2 Emissions Tons"
      expr: AVG(total_co2_emissions_tons)
    - name: "Total Total Fuel Cost Usd"
      expr: SUM(total_fuel_cost_usd)
    - name: "Average Total Fuel Cost Usd"
      expr: AVG(total_fuel_cost_usd)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`generation_fuel_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel Contract business metrics"
  source: "`power_and_utilities`.`generation`.`fuel_contract`"
  dimensions:
    - name: "Contract Amendment Count"
      expr: contract_amendment_count
    - name: "Contract Name"
      expr: contract_name
    - name: "Contract Number"
      expr: contract_number
    - name: "Contract Status"
      expr: contract_status
    - name: "Contract Type"
      expr: contract_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Delivery Period"
      expr: delivery_period
    - name: "Delivery Point Description"
      expr: delivery_point_description
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Force Majeure Provision Flag"
      expr: force_majeure_provision_flag
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Last Amendment Date"
      expr: last_amendment_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Minimum Take Unit Of Measure"
      expr: minimum_take_unit_of_measure
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fuel Contract"
      expr: COUNT(DISTINCT fuel_contract_id)
    - name: "Total Ash Content Limit Percent"
      expr: SUM(ash_content_limit_percent)
    - name: "Average Ash Content Limit Percent"
      expr: AVG(ash_content_limit_percent)
    - name: "Total Base Price"
      expr: SUM(base_price)
    - name: "Average Base Price"
      expr: AVG(base_price)
    - name: "Total Btu Content Specification"
      expr: SUM(btu_content_specification)
    - name: "Average Btu Content Specification"
      expr: AVG(btu_content_specification)
    - name: "Total Contract Owner Employee Code"
      expr: SUM(contract_owner_employee_code)
    - name: "Average Contract Owner Employee Code"
      expr: AVG(contract_owner_employee_code)
    - name: "Total Contract Value Total"
      expr: SUM(contract_value_total)
    - name: "Average Contract Value Total"
      expr: AVG(contract_value_total)
    - name: "Total Contracted Volume"
      expr: SUM(contracted_volume)
    - name: "Average Contracted Volume"
      expr: AVG(contracted_volume)
    - name: "Total Minimum Take Obligation"
      expr: SUM(minimum_take_obligation)
    - name: "Average Minimum Take Obligation"
      expr: AVG(minimum_take_obligation)
    - name: "Total Moisture Content Limit Percent"
      expr: SUM(moisture_content_limit_percent)
    - name: "Average Moisture Content Limit Percent"
      expr: AVG(moisture_content_limit_percent)
    - name: "Total Sulfur Content Limit Percent"
      expr: SUM(sulfur_content_limit_percent)
    - name: "Average Sulfur Content Limit Percent"
      expr: AVG(sulfur_content_limit_percent)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`generation_fuel_inventory`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel Inventory business metrics"
  source: "`power_and_utilities`.`generation`.`fuel_inventory`"
  dimensions:
    - name: "Batch Number"
      expr: batch_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Environmental Permit Number"
      expr: environmental_permit_number
    - name: "Fac Eligible Flag"
      expr: fac_eligible_flag
    - name: "Fuel Grade"
      expr: fuel_grade
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Inventory Date"
      expr: inventory_date
    - name: "Inventory Status"
      expr: inventory_status
    - name: "Last Physical Count Date"
      expr: last_physical_count_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Quality Certification Number"
      expr: quality_certification_number
    - name: "Quality Test Date"
      expr: quality_test_date
    - name: "Receipt Date"
      expr: receipt_date
    - name: "Unit Of Measure"
      expr: unit_of_measure
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Inventory Date Month"
      expr: DATE_TRUNC('MONTH', inventory_date)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Fuel Inventory"
      expr: COUNT(DISTINCT fuel_inventory_id)
    - name: "Total Ash Content Percent"
      expr: SUM(ash_content_percent)
    - name: "Average Ash Content Percent"
      expr: AVG(ash_content_percent)
    - name: "Total Average Daily Consumption Rate"
      expr: SUM(average_daily_consumption_rate)
    - name: "Average Average Daily Consumption Rate"
      expr: AVG(average_daily_consumption_rate)
    - name: "Total Btu Content"
      expr: SUM(btu_content)
    - name: "Average Btu Content"
      expr: AVG(btu_content)
    - name: "Total Days Of Burn Remaining"
      expr: SUM(days_of_burn_remaining)
    - name: "Average Days Of Burn Remaining"
      expr: AVG(days_of_burn_remaining)
    - name: "Total Economic Order Quantity"
      expr: SUM(economic_order_quantity)
    - name: "Average Economic Order Quantity"
      expr: AVG(economic_order_quantity)
    - name: "Total Enrichment Level Percent"
      expr: SUM(enrichment_level_percent)
    - name: "Average Enrichment Level Percent"
      expr: AVG(enrichment_level_percent)
    - name: "Total Ghg Emissions Factor"
      expr: SUM(ghg_emissions_factor)
    - name: "Average Ghg Emissions Factor"
      expr: AVG(ghg_emissions_factor)
    - name: "Total Maximum Storage Capacity"
      expr: SUM(maximum_storage_capacity)
    - name: "Average Maximum Storage Capacity"
      expr: AVG(maximum_storage_capacity)
    - name: "Total Minimum Operating Reserve"
      expr: SUM(minimum_operating_reserve)
    - name: "Average Minimum Operating Reserve"
      expr: AVG(minimum_operating_reserve)
    - name: "Total Moisture Content Percent"
      expr: SUM(moisture_content_percent)
    - name: "Average Moisture Content Percent"
      expr: AVG(moisture_content_percent)
    - name: "Total Nitrogen Content Percent"
      expr: SUM(nitrogen_content_percent)
    - name: "Average Nitrogen Content Percent"
      expr: AVG(nitrogen_content_percent)
    - name: "Total Quantity On Hand"
      expr: SUM(quantity_on_hand)
    - name: "Average Quantity On Hand"
      expr: AVG(quantity_on_hand)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`generation_generating_unit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Generating Unit business metrics"
  source: "`power_and_utilities`.`generation`.`generating_unit`"
  dimensions:
    - name: "Ancillary Services Capable"
      expr: ancillary_services_capable
    - name: "Balancing Authority"
      expr: balancing_authority
    - name: "Black Start Capable"
      expr: black_start_capable
    - name: "Carbon Capture Enabled"
      expr: carbon_capture_enabled
    - name: "Commercial Operation Date"
      expr: commercial_operation_date
    - name: "Cooling System Type"
      expr: cooling_system_type
    - name: "Dispatch Priority"
      expr: dispatch_priority
    - name: "Eia Generator Code"
      expr: eia_generator_code
    - name: "Emissions Control Equipment"
      expr: emissions_control_equipment
    - name: "Fuel Primary"
      expr: fuel_primary
    - name: "Fuel Secondary"
      expr: fuel_secondary
    - name: "Last Major Overhaul Date"
      expr: last_major_overhaul_date
    - name: "Manufacturer"
      expr: manufacturer
    - name: "Model Number"
      expr: model_number
    - name: "Must Run Designation"
      expr: must_run_designation
    - name: "Nerc Unit Code"
      expr: nerc_unit_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Generating Unit"
      expr: COUNT(DISTINCT generating_unit_id)
    - name: "Total Capacity Factor Target Pct"
      expr: SUM(capacity_factor_target_pct)
    - name: "Average Capacity Factor Target Pct"
      expr: AVG(capacity_factor_target_pct)
    - name: "Total Heat Rate Btu Per Kwh"
      expr: SUM(heat_rate_btu_per_kwh)
    - name: "Average Heat Rate Btu Per Kwh"
      expr: AVG(heat_rate_btu_per_kwh)
    - name: "Total Interconnection Voltage Kv"
      expr: SUM(interconnection_voltage_kv)
    - name: "Average Interconnection Voltage Kv"
      expr: AVG(interconnection_voltage_kv)
    - name: "Total Minimum Stable Load Mw"
      expr: SUM(minimum_stable_load_mw)
    - name: "Average Minimum Stable Load Mw"
      expr: AVG(minimum_stable_load_mw)
    - name: "Total Nameplate Capacity Mw"
      expr: SUM(nameplate_capacity_mw)
    - name: "Average Nameplate Capacity Mw"
      expr: AVG(nameplate_capacity_mw)
    - name: "Total Net Summer Capacity Mw"
      expr: SUM(net_summer_capacity_mw)
    - name: "Average Net Summer Capacity Mw"
      expr: AVG(net_summer_capacity_mw)
    - name: "Total Net Winter Capacity Mw"
      expr: SUM(net_winter_capacity_mw)
    - name: "Average Net Winter Capacity Mw"
      expr: AVG(net_winter_capacity_mw)
    - name: "Total Ramp Rate Mw Per Min"
      expr: SUM(ramp_rate_mw_per_min)
    - name: "Average Ramp Rate Mw Per Min"
      expr: AVG(ramp_rate_mw_per_min)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`generation_generation_outage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Generation Outage Event business metrics"
  source: "`power_and_utilities`.`generation`.`generation_outage_event`"
  dimensions:
    - name: "Affected System"
      expr: affected_system
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Environmental Incident Flag"
      expr: environmental_incident_flag
    - name: "Extension Reason"
      expr: extension_reason
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Nerc Gads Reportable Flag"
      expr: nerc_gads_reportable_flag
    - name: "Nerc Gads Submission Date"
      expr: nerc_gads_submission_date
    - name: "Outage Approval Date"
      expr: outage_approval_date
    - name: "Outage Cause Code"
      expr: outage_cause_code
    - name: "Outage Cause Description"
      expr: outage_cause_description
    - name: "Outage Coordinator"
      expr: outage_coordinator
    - name: "Outage End Timestamp"
      expr: outage_end_timestamp
    - name: "Outage Extension Flag"
      expr: outage_extension_flag
    - name: "Outage Number"
      expr: outage_number
    - name: "Outage Start Timestamp"
      expr: outage_start_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Generation Outage Event"
      expr: COUNT(DISTINCT generation_outage_event_id)
    - name: "Total Available Capacity Mw"
      expr: SUM(available_capacity_mw)
    - name: "Average Available Capacity Mw"
      expr: AVG(available_capacity_mw)
    - name: "Total Derated Capacity Mw"
      expr: SUM(derated_capacity_mw)
    - name: "Average Derated Capacity Mw"
      expr: AVG(derated_capacity_mw)
    - name: "Total Efor Contribution Hours"
      expr: SUM(efor_contribution_hours)
    - name: "Average Efor Contribution Hours"
      expr: AVG(efor_contribution_hours)
    - name: "Total Estimated Revenue Impact Usd"
      expr: SUM(estimated_revenue_impact_usd)
    - name: "Average Estimated Revenue Impact Usd"
      expr: AVG(estimated_revenue_impact_usd)
    - name: "Total Lost Generation Mwh"
      expr: SUM(lost_generation_mwh)
    - name: "Average Lost Generation Mwh"
      expr: AVG(lost_generation_mwh)
    - name: "Total Maintenance Cost Usd"
      expr: SUM(maintenance_cost_usd)
    - name: "Average Maintenance Cost Usd"
      expr: AVG(maintenance_cost_usd)
    - name: "Total Outage Duration Hours"
      expr: SUM(outage_duration_hours)
    - name: "Average Outage Duration Hours"
      expr: AVG(outage_duration_hours)
    - name: "Total Replacement Power Cost Usd"
      expr: SUM(replacement_power_cost_usd)
    - name: "Average Replacement Power Cost Usd"
      expr: AVG(replacement_power_cost_usd)
    - name: "Total Scheduled Duration Hours"
      expr: SUM(scheduled_duration_hours)
    - name: "Average Scheduled Duration Hours"
      expr: AVG(scheduled_duration_hours)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`generation_plant`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Plant business metrics"
  source: "`power_and_utilities`.`generation`.`plant`"
  dimensions:
    - name: "Balancing Authority"
      expr: balancing_authority
    - name: "Commercial Operation Date"
      expr: commercial_operation_date
    - name: "Construction Year"
      expr: construction_year
    - name: "County"
      expr: county
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Eia Plant Code"
      expr: eia_plant_code
    - name: "Emissions Controlled"
      expr: emissions_controlled
    - name: "Ems Resource Reference"
      expr: ems_resource_reference
    - name: "Ferc Plant Code"
      expr: ferc_plant_code
    - name: "Fuel Type"
      expr: fuel_type
    - name: "Iso Rto Region"
      expr: iso_rto_region
    - name: "Last Major Upgrade Date"
      expr: last_major_upgrade_date
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Nerc Plant Code"
      expr: nerc_plant_code
    - name: "Operator Name"
      expr: operator_name
    - name: "Plant Code"
      expr: plant_code
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Plant"
      expr: COUNT(DISTINCT plant_id)
    - name: "Total Capacity Factor Percent"
      expr: SUM(capacity_factor_percent)
    - name: "Average Capacity Factor Percent"
      expr: AVG(capacity_factor_percent)
    - name: "Total Heat Rate Btu Per Kwh"
      expr: SUM(heat_rate_btu_per_kwh)
    - name: "Average Heat Rate Btu Per Kwh"
      expr: AVG(heat_rate_btu_per_kwh)
    - name: "Total Interconnection Voltage Kv"
      expr: SUM(interconnection_voltage_kv)
    - name: "Average Interconnection Voltage Kv"
      expr: AVG(interconnection_voltage_kv)
    - name: "Total Latitude"
      expr: SUM(latitude)
    - name: "Average Latitude"
      expr: AVG(latitude)
    - name: "Total Longitude"
      expr: SUM(longitude)
    - name: "Average Longitude"
      expr: AVG(longitude)
    - name: "Total Minimum Load Mw"
      expr: SUM(minimum_load_mw)
    - name: "Average Minimum Load Mw"
      expr: AVG(minimum_load_mw)
    - name: "Total Nameplate Capacity Mw"
      expr: SUM(nameplate_capacity_mw)
    - name: "Average Nameplate Capacity Mw"
      expr: AVG(nameplate_capacity_mw)
    - name: "Total Net Capacity Mw"
      expr: SUM(net_capacity_mw)
    - name: "Average Net Capacity Mw"
      expr: AVG(net_capacity_mw)
    - name: "Total Ownership Percentage"
      expr: SUM(ownership_percentage)
    - name: "Average Ownership Percentage"
      expr: AVG(ownership_percentage)
    - name: "Total Ramp Rate Mw Per Minute"
      expr: SUM(ramp_rate_mw_per_minute)
    - name: "Average Ramp Rate Mw Per Minute"
      expr: AVG(ramp_rate_mw_per_minute)
    - name: "Total Startup Time Hours"
      expr: SUM(startup_time_hours)
    - name: "Average Startup Time Hours"
      expr: AVG(startup_time_hours)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`generation_unit_output`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Unit Output business metrics"
  source: "`power_and_utilities`.`generation`.`unit_output`"
  dimensions:
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Data Quality Flag"
      expr: data_quality_flag
    - name: "Dispatch Mode"
      expr: dispatch_mode
    - name: "Interval Duration Minutes"
      expr: interval_duration_minutes
    - name: "Interval Timestamp"
      expr: interval_timestamp
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Rps Eligible Flag"
      expr: rps_eligible_flag
    - name: "Rto Settlement Flag"
      expr: rto_settlement_flag
    - name: "Scada Source Tag"
      expr: scada_source_tag
    - name: "Unit Status"
      expr: unit_status
    - name: "Created Timestamp Month"
      expr: DATE_TRUNC('MONTH', created_timestamp)
    - name: "Interval Timestamp Month"
      expr: DATE_TRUNC('MONTH', interval_timestamp)
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Unit Output"
      expr: COUNT(DISTINCT unit_output_id)
    - name: "Total Ambient Temperature F"
      expr: SUM(ambient_temperature_f)
    - name: "Average Ambient Temperature F"
      expr: AVG(ambient_temperature_f)
    - name: "Total Auxiliary Load Mwh"
      expr: SUM(auxiliary_load_mwh)
    - name: "Average Auxiliary Load Mwh"
      expr: AVG(auxiliary_load_mwh)
    - name: "Total Barometric Pressure Inhg"
      expr: SUM(barometric_pressure_inhg)
    - name: "Average Barometric Pressure Inhg"
      expr: AVG(barometric_pressure_inhg)
    - name: "Total Capacity Factor Percent"
      expr: SUM(capacity_factor_percent)
    - name: "Average Capacity Factor Percent"
      expr: AVG(capacity_factor_percent)
    - name: "Total Co2 Emissions Tons"
      expr: SUM(co2_emissions_tons)
    - name: "Average Co2 Emissions Tons"
      expr: AVG(co2_emissions_tons)
    - name: "Total Frequency Hz"
      expr: SUM(frequency_hz)
    - name: "Average Frequency Hz"
      expr: AVG(frequency_hz)
    - name: "Total Fuel Consumption Mmbtu"
      expr: SUM(fuel_consumption_mmbtu)
    - name: "Average Fuel Consumption Mmbtu"
      expr: AVG(fuel_consumption_mmbtu)
    - name: "Total Gross Generation Mwh"
      expr: SUM(gross_generation_mwh)
    - name: "Average Gross Generation Mwh"
      expr: AVG(gross_generation_mwh)
    - name: "Total Heat Rate Btu Per Kwh"
      expr: SUM(heat_rate_btu_per_kwh)
    - name: "Average Heat Rate Btu Per Kwh"
      expr: AVG(heat_rate_btu_per_kwh)
    - name: "Total Net Generation Mwh"
      expr: SUM(net_generation_mwh)
    - name: "Average Net Generation Mwh"
      expr: AVG(net_generation_mwh)
    - name: "Total Nox Emissions Lbs"
      expr: SUM(nox_emissions_lbs)
    - name: "Average Nox Emissions Lbs"
      expr: AVG(nox_emissions_lbs)
    - name: "Total Reactive Power Mvar"
      expr: SUM(reactive_power_mvar)
    - name: "Average Reactive Power Mvar"
      expr: AVG(reactive_power_mvar)
$$;