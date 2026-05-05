-- Metric views for domain: asset | Business: Power and Utilities | Version: 1 | Generated on: 2026-04-29 23:09:06

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`asset_condition`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset health and condition assessment metrics tracking health index, remaining useful life, and risk scores to support predictive maintenance and capital planning decisions"
  source: "`power_and_utilities`.`asset`.`condition`"
  dimensions:
    - name: "assessment_status"
      expr: assessment_status
      comment: "Current status of the condition assessment (e.g., completed, pending, in-progress)"
    - name: "assessment_method"
      expr: assessment_method
      comment: "Method used for condition assessment (e.g., visual inspection, thermal imaging, oil analysis)"
    - name: "corrosion_level"
      expr: corrosion_level
      comment: "Severity level of corrosion detected on the asset"
    - name: "replacement_urgency"
      expr: replacement_urgency
      comment: "Urgency classification for asset replacement (e.g., immediate, high, medium, low)"
    - name: "maintenance_recommendation"
      expr: maintenance_recommendation
      comment: "Recommended maintenance action based on condition assessment"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the asset meets regulatory compliance standards"
    - name: "trend"
      expr: trend
      comment: "Condition trend direction (improving, stable, degrading)"
    - name: "assessor_organization"
      expr: assessor_organization
      comment: "Organization that performed the condition assessment"
    - name: "assessment_year"
      expr: YEAR(assessment_date)
      comment: "Year the condition assessment was performed"
    - name: "assessment_month"
      expr: DATE_TRUNC('MONTH', assessment_date)
      comment: "Month the condition assessment was performed"
  measures:
    - name: "total_condition_assessments"
      expr: COUNT(1)
      comment: "Total number of condition assessments performed"
    - name: "avg_health_index"
      expr: AVG(CAST(health_index AS DOUBLE))
      comment: "Average health index score across assessed assets (higher indicates better health)"
    - name: "avg_remaining_useful_life_years"
      expr: AVG(CAST(remaining_useful_life_years AS DOUBLE))
      comment: "Average remaining useful life in years across assessed assets"
    - name: "avg_risk_score"
      expr: AVG(CAST(risk_score AS DOUBLE))
      comment: "Average risk score across assessed assets (higher indicates greater risk)"
    - name: "total_assessment_cost"
      expr: SUM(CAST(assessment_cost AS DOUBLE))
      comment: "Total cost incurred for condition assessments"
    - name: "avg_overall_condition_score"
      expr: AVG(CAST(overall_condition_score AS DOUBLE))
      comment: "Average overall condition score across assessed assets"
    - name: "avg_mechanical_condition_score"
      expr: AVG(CAST(mechanical_condition_score AS DOUBLE))
      comment: "Average mechanical condition score indicating mechanical health"
    - name: "avg_insulation_condition_score"
      expr: AVG(CAST(insulation_condition_score AS DOUBLE))
      comment: "Average insulation condition score for electrical assets"
    - name: "distinct_assets_assessed"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of unique assets that have been assessed"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`asset_failure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset failure and reliability metrics tracking failure rates, outage impacts, and restoration performance to drive reliability improvement and regulatory compliance"
  source: "`power_and_utilities`.`asset`.`failure_event`"
  dimensions:
    - name: "failure_cause_category"
      expr: failure_cause_category
      comment: "Root cause category of the failure (e.g., equipment, weather, human error)"
    - name: "failure_mode"
      expr: failure_mode
      comment: "Specific mode of failure (e.g., short circuit, mechanical break, overload)"
    - name: "failure_severity"
      expr: failure_severity
      comment: "Severity classification of the failure event"
    - name: "equipment_type"
      expr: equipment_type
      comment: "Type of equipment that failed"
    - name: "asset_criticality_rating"
      expr: asset_criticality_rating
      comment: "Criticality rating of the failed asset"
    - name: "weather_condition"
      expr: weather_condition
      comment: "Weather conditions at time of failure"
    - name: "forced_outage_flag"
      expr: forced_outage_flag
      comment: "Whether the failure resulted in a forced outage"
    - name: "major_event_day_flag"
      expr: major_event_day_flag
      comment: "Whether the failure occurred during a major event day (MED)"
    - name: "nerc_reportable_flag"
      expr: nerc_reportable_flag
      comment: "Whether the failure is reportable to NERC"
    - name: "puc_reportable_flag"
      expr: puc_reportable_flag
      comment: "Whether the failure is reportable to the Public Utility Commission"
    - name: "rca_completed_flag"
      expr: rca_completed_flag
      comment: "Whether root cause analysis has been completed"
    - name: "failure_year"
      expr: YEAR(failure_timestamp)
      comment: "Year the failure occurred"
    - name: "failure_month"
      expr: DATE_TRUNC('MONTH', failure_timestamp)
      comment: "Month the failure occurred"
  measures:
    - name: "total_failure_events"
      expr: COUNT(1)
      comment: "Total number of asset failure events"
    - name: "total_failure_cost"
      expr: SUM(CAST(failure_cost_amount AS DOUBLE))
      comment: "Total direct cost of failures including repair and restoration"
    - name: "total_repair_cost"
      expr: SUM(CAST(repair_cost_amount AS DOUBLE))
      comment: "Total cost of repairs following failures"
    - name: "total_consequential_cost"
      expr: SUM(CAST(consequential_cost_amount AS DOUBLE))
      comment: "Total consequential costs from failures (e.g., lost revenue, penalties)"
    - name: "total_customer_minutes_interrupted"
      expr: SUM(CAST(customer_minutes_interrupted AS DOUBLE))
      comment: "Total customer-minutes of interruption caused by failures (key SAIDI input)"
    - name: "total_outage_duration_minutes"
      expr: SUM(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Total duration of outages in minutes across all failure events"
    - name: "avg_outage_duration_minutes"
      expr: AVG(CAST(outage_duration_minutes AS DOUBLE))
      comment: "Average outage duration per failure event in minutes"
    - name: "total_saidi_contribution"
      expr: SUM(CAST(saidi_contribution AS DOUBLE))
      comment: "Total contribution to System Average Interruption Duration Index (regulatory metric)"
    - name: "total_saifi_contribution"
      expr: SUM(CAST(saifi_contribution AS DOUBLE))
      comment: "Total contribution to System Average Interruption Frequency Index (regulatory metric)"
    - name: "distinct_failed_assets"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of unique assets that experienced failures"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`asset_work_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Work order execution and cost performance metrics tracking labor efficiency, cost variance, and schedule adherence to optimize maintenance operations and capital deployment"
  source: "`power_and_utilities`.`asset`.`work_order`"
  dimensions:
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order (e.g., corrective, preventive, capital, emergency)"
    - name: "work_order_status"
      expr: work_order_status
      comment: "Current status of the work order (e.g., open, in-progress, completed, closed)"
    - name: "priority"
      expr: priority
      comment: "Priority level of the work order"
    - name: "cost_classification"
      expr: cost_classification
      comment: "Cost classification (e.g., capital, O&M, expense)"
    - name: "craft_trade_required"
      expr: craft_trade_required
      comment: "Craft or trade skill required for the work"
    - name: "outage_required_flag"
      expr: outage_required_flag
      comment: "Whether the work requires an outage"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the work is driven by regulatory compliance"
    - name: "afudc_eligible_flag"
      expr: afudc_eligible_flag
      comment: "Whether the work is eligible for Allowance for Funds Used During Construction"
    - name: "scheduled_start_year"
      expr: YEAR(scheduled_start_date)
      comment: "Year the work order is scheduled to start"
    - name: "scheduled_start_month"
      expr: DATE_TRUNC('MONTH', scheduled_start_date)
      comment: "Month the work order is scheduled to start"
    - name: "actual_start_month"
      expr: DATE_TRUNC('MONTH', actual_start_timestamp)
      comment: "Month the work order actually started"
  measures:
    - name: "total_work_orders"
      expr: COUNT(1)
      comment: "Total number of work orders"
    - name: "total_estimated_cost"
      expr: SUM(CAST(estimated_total_cost AS DOUBLE))
      comment: "Total estimated cost across all work orders"
    - name: "total_actual_cost"
      expr: SUM(CAST(actual_total_cost AS DOUBLE))
      comment: "Total actual cost incurred across all work orders"
    - name: "total_actual_labor_hours"
      expr: SUM(CAST(actual_labor_hours AS DOUBLE))
      comment: "Total actual labor hours consumed across all work orders"
    - name: "total_estimated_labor_hours"
      expr: SUM(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Total estimated labor hours across all work orders"
    - name: "total_actual_material_cost"
      expr: SUM(CAST(actual_material_cost AS DOUBLE))
      comment: "Total actual material cost across all work orders"
    - name: "total_estimated_material_cost"
      expr: SUM(CAST(estimated_material_cost AS DOUBLE))
      comment: "Total estimated material cost across all work orders"
    - name: "avg_actual_labor_hours"
      expr: AVG(CAST(actual_labor_hours AS DOUBLE))
      comment: "Average actual labor hours per work order"
    - name: "avg_estimated_labor_hours"
      expr: AVG(CAST(estimated_labor_hours AS DOUBLE))
      comment: "Average estimated labor hours per work order"
    - name: "distinct_assets_worked"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of unique assets that had work orders"
    - name: "distinct_locations_worked"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of unique locations where work was performed"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`asset_inspection`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Asset inspection program performance metrics tracking inspection completion, deficiency identification, and compliance adherence to ensure regulatory compliance and asset reliability"
  source: "`power_and_utilities`.`asset`.`inspection_record`"
  dimensions:
    - name: "inspection_type"
      expr: inspection_type
      comment: "Type of inspection performed (e.g., routine, compliance, condition-based)"
    - name: "inspection_status"
      expr: inspection_status
      comment: "Current status of the inspection record"
    - name: "inspection_method"
      expr: inspection_method
      comment: "Method used for inspection (e.g., visual, thermal, ultrasonic)"
    - name: "inspection_result"
      expr: inspection_result
      comment: "Overall result of the inspection (e.g., pass, fail, conditional)"
    - name: "inspection_program"
      expr: inspection_program
      comment: "Inspection program the record belongs to"
    - name: "deficiency_identified_flag"
      expr: deficiency_identified_flag
      comment: "Whether any deficiencies were identified during inspection"
    - name: "deficiency_severity"
      expr: deficiency_severity
      comment: "Severity level of identified deficiencies"
    - name: "corrective_action_required_flag"
      expr: corrective_action_required_flag
      comment: "Whether corrective action is required based on inspection findings"
    - name: "corrective_action_priority"
      expr: corrective_action_priority
      comment: "Priority level for required corrective actions"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the inspection meets regulatory compliance requirements"
    - name: "inspection_year"
      expr: YEAR(inspection_date)
      comment: "Year the inspection was performed"
    - name: "inspection_month"
      expr: DATE_TRUNC('MONTH', inspection_date)
      comment: "Month the inspection was performed"
  measures:
    - name: "total_inspections"
      expr: COUNT(1)
      comment: "Total number of inspections performed"
    - name: "total_deficiencies_identified"
      expr: SUM(CAST(deficiency_count AS DOUBLE))
      comment: "Total number of deficiencies identified across all inspections"
    - name: "avg_deficiencies_per_inspection"
      expr: AVG(CAST(deficiency_count AS DOUBLE))
      comment: "Average number of deficiencies identified per inspection"
    - name: "distinct_assets_inspected"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of unique assets that were inspected"
    - name: "distinct_inspectors"
      expr: COUNT(DISTINCT inspector_id)
      comment: "Number of unique inspectors who performed inspections"
    - name: "distinct_inspection_crews"
      expr: COUNT(DISTINCT inspection_crew_id)
      comment: "Number of unique inspection crews deployed"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`asset_facility`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Facility asset value and depreciation metrics tracking book value, accumulated depreciation, and capacity utilization to support financial reporting and capital planning"
  source: "`power_and_utilities`.`asset`.`facility`"
  dimensions:
    - name: "facility_type"
      expr: facility_type
      comment: "Type of facility (e.g., substation, generating station, service center)"
    - name: "facility_subtype"
      expr: facility_subtype
      comment: "Subtype classification of the facility"
    - name: "asset_class"
      expr: asset_class
      comment: "Asset class for accounting and regulatory purposes"
    - name: "operational_status"
      expr: operational_status
      comment: "Current operational status of the facility"
    - name: "criticality_rating"
      expr: criticality_rating
      comment: "Criticality rating of the facility to system operations"
    - name: "ferc_account_code"
      expr: ferc_account_code
      comment: "FERC account code for regulatory reporting"
    - name: "depreciation_method"
      expr: depreciation_method
      comment: "Depreciation method applied to the facility"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory jurisdiction governing the facility"
    - name: "service_territory"
      expr: service_territory
      comment: "Service territory the facility serves"
    - name: "owner_organization"
      expr: owner_organization
      comment: "Organization that owns the facility"
    - name: "operating_organization"
      expr: operating_organization
      comment: "Organization that operates the facility"
    - name: "in_service_year"
      expr: YEAR(in_service_date)
      comment: "Year the facility was placed in service"
  measures:
    - name: "total_facilities"
      expr: COUNT(1)
      comment: "Total number of facilities"
    - name: "total_original_cost"
      expr: SUM(CAST(original_cost AS DOUBLE))
      comment: "Total original cost of all facilities (gross plant value)"
    - name: "total_accumulated_depreciation"
      expr: SUM(CAST(accumulated_depreciation AS DOUBLE))
      comment: "Total accumulated depreciation across all facilities"
    - name: "total_net_book_value"
      expr: SUM(CAST(net_book_value AS DOUBLE))
      comment: "Total net book value of all facilities (rate base component)"
    - name: "total_nameplate_capacity"
      expr: SUM(CAST(nameplate_capacity AS DOUBLE))
      comment: "Total nameplate capacity across all facilities"
    - name: "avg_nameplate_capacity"
      expr: AVG(CAST(nameplate_capacity AS DOUBLE))
      comment: "Average nameplate capacity per facility"
    - name: "distinct_locations"
      expr: COUNT(DISTINCT location_id)
      comment: "Number of unique locations where facilities are situated"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`asset_pm_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Preventive maintenance program effectiveness metrics tracking schedule adherence, resource planning, and maintenance frequency to optimize asset uptime and reduce unplanned failures"
  source: "`power_and_utilities`.`asset`.`pm_schedule`"
  dimensions:
    - name: "frequency_type"
      expr: frequency_type
      comment: "Type of maintenance frequency (e.g., time-based, condition-based, usage-based)"
    - name: "frequency_unit"
      expr: frequency_unit
      comment: "Unit of frequency measurement (e.g., days, months, cycles)"
    - name: "schedule_status"
      expr: schedule_status
      comment: "Current status of the PM schedule"
    - name: "priority"
      expr: priority
      comment: "Priority level of the scheduled maintenance"
    - name: "work_order_type"
      expr: work_order_type
      comment: "Type of work order generated by the PM schedule"
    - name: "required_craft"
      expr: required_craft
      comment: "Craft or trade skill required for the maintenance"
    - name: "outage_required_flag"
      expr: outage_required_flag
      comment: "Whether the maintenance requires an outage"
    - name: "auto_generate_work_order_flag"
      expr: auto_generate_work_order_flag
      comment: "Whether work orders are automatically generated from this schedule"
    - name: "seasonal_restriction"
      expr: seasonal_restriction
      comment: "Any seasonal restrictions on when maintenance can be performed"
    - name: "asset_class_code"
      expr: asset_class_code
      comment: "Asset class code the PM schedule applies to"
  measures:
    - name: "total_pm_schedules"
      expr: COUNT(1)
      comment: "Total number of preventive maintenance schedules"
    - name: "total_estimated_duration_hours"
      expr: SUM(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Total estimated labor hours required across all PM schedules"
    - name: "avg_estimated_duration_hours"
      expr: AVG(CAST(estimated_duration_hours AS DOUBLE))
      comment: "Average estimated duration per PM activity in hours"
    - name: "total_estimated_outage_duration_hours"
      expr: SUM(CAST(estimated_outage_duration_hours AS DOUBLE))
      comment: "Total estimated outage hours required for all PM activities"
    - name: "avg_estimated_outage_duration_hours"
      expr: AVG(CAST(estimated_outage_duration_hours AS DOUBLE))
      comment: "Average estimated outage duration per PM activity in hours"
    - name: "distinct_assets_on_pm"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of unique assets covered by PM schedules"
    - name: "distinct_cost_centers"
      expr: COUNT(DISTINCT cost_center_id)
      comment: "Number of unique cost centers responsible for PM activities"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`asset_warranty`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Warranty coverage and claims performance metrics tracking warranty value realization, claim success rates, and coverage gaps to maximize vendor accountability and reduce unplanned costs"
  source: "`power_and_utilities`.`asset`.`warranty`"
  dimensions:
    - name: "warranty_type"
      expr: warranty_type
      comment: "Type of warranty coverage (e.g., manufacturer, extended, performance)"
    - name: "warranty_status"
      expr: warranty_status
      comment: "Current status of the warranty"
    - name: "coverage_scope"
      expr: coverage_scope
      comment: "Scope of warranty coverage (e.g., parts only, parts and labor, full)"
    - name: "transferable_flag"
      expr: transferable_flag
      comment: "Whether the warranty is transferable to a new owner"
    - name: "prorated_flag"
      expr: prorated_flag
      comment: "Whether warranty coverage is prorated over time"
    - name: "regulatory_compliance_flag"
      expr: regulatory_compliance_flag
      comment: "Whether the warranty meets regulatory compliance requirements"
    - name: "warranty_start_year"
      expr: YEAR(start_date)
      comment: "Year the warranty coverage started"
    - name: "warranty_expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the warranty coverage expires"
  measures:
    - name: "total_warranties"
      expr: COUNT(1)
      comment: "Total number of warranty records"
    - name: "total_claims_filed"
      expr: SUM(CAST(claims_filed_count AS DOUBLE))
      comment: "Total number of warranty claims filed"
    - name: "total_claims_approved_amount"
      expr: SUM(CAST(claims_approved_amount AS DOUBLE))
      comment: "Total dollar value of approved warranty claims (cost recovery)"
    - name: "total_claims_denied_amount"
      expr: SUM(CAST(claims_denied_amount AS DOUBLE))
      comment: "Total dollar value of denied warranty claims"
    - name: "total_claims_pending_amount"
      expr: SUM(CAST(claims_pending_amount AS DOUBLE))
      comment: "Total dollar value of pending warranty claims"
    - name: "total_maximum_claim_value"
      expr: SUM(CAST(maximum_claim_value AS DOUBLE))
      comment: "Total maximum claimable value across all warranties"
    - name: "total_deductible_amount"
      expr: SUM(CAST(deductible_amount AS DOUBLE))
      comment: "Total deductible amounts across all warranties"
    - name: "avg_claims_per_warranty"
      expr: AVG(CAST(claims_filed_count AS DOUBLE))
      comment: "Average number of claims filed per warranty"
    - name: "distinct_assets_under_warranty"
      expr: COUNT(DISTINCT master_id)
      comment: "Number of unique assets covered by active warranties"
    - name: "distinct_vendors"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors providing warranty coverage"
$$;