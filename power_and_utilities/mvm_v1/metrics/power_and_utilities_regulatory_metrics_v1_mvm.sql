-- Metric views for domain: regulatory | Business: Power and Utilities | Version: 1 | Generated on: 2026-04-29 23:09:06

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`regulatory_rate_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core rate case financial and performance metrics tracking requested vs approved revenue requirements, ROE, and rate base outcomes"
  source: "`power_and_utilities`.`regulatory`.`rate_case`"
  dimensions:
    - name: "case_type"
      expr: case_type
      comment: "Type of rate case (general, fuel adjustment, etc.)"
    - name: "case_status"
      expr: case_status
      comment: "Current status of the rate case proceeding"
    - name: "filing_jurisdiction_state"
      expr: filing_jurisdiction_state
      comment: "State jurisdiction where rate case was filed"
    - name: "regulatory_jurisdiction"
      expr: regulatory_jurisdiction
      comment: "Regulatory body jurisdiction"
    - name: "test_year_type"
      expr: test_year_type
      comment: "Type of test year used (historical, forward, hybrid)"
    - name: "settlement_indicator"
      expr: settlement_indicator
      comment: "Whether case was settled vs litigated"
    - name: "pbr_indicator"
      expr: pbr_indicator
      comment: "Performance-based ratemaking indicator"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the rate case was filed"
    - name: "filing_quarter"
      expr: CONCAT('Q', QUARTER(filing_date), '-', YEAR(filing_date))
      comment: "Quarter and year of filing"
  measures:
    - name: "total_rate_cases"
      expr: COUNT(1)
      comment: "Total number of rate cases"
    - name: "total_requested_revenue_requirement"
      expr: SUM(CAST(requested_revenue_requirement AS DOUBLE))
      comment: "Total revenue requirement requested across all rate cases"
    - name: "total_approved_revenue_requirement"
      expr: SUM(CAST(approved_revenue_requirement AS DOUBLE))
      comment: "Total revenue requirement approved by regulators"
    - name: "total_requested_rate_base"
      expr: SUM(CAST(requested_rate_base AS DOUBLE))
      comment: "Total rate base requested"
    - name: "total_approved_rate_base"
      expr: SUM(CAST(approved_rate_base AS DOUBLE))
      comment: "Total rate base approved by regulators"
    - name: "avg_requested_roe_pct"
      expr: AVG(CAST(requested_roe_pct AS DOUBLE))
      comment: "Average requested return on equity percentage"
    - name: "avg_approved_roe_pct"
      expr: AVG(CAST(approved_roe_pct AS DOUBLE))
      comment: "Average approved return on equity percentage"
    - name: "avg_approval_rate_revenue"
      expr: AVG(ROUND(100.0 * CAST(approved_revenue_requirement AS DOUBLE) / NULLIF(CAST(requested_revenue_requirement AS DOUBLE), 0), 2))
      comment: "Average percentage of requested revenue requirement that was approved"
    - name: "settlement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN settlement_indicator = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of rate cases resolved through settlement"
    - name: "avg_days_to_final_order"
      expr: AVG(DATEDIFF(final_order_date, filing_date))
      comment: "Average number of days from filing to final order"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`regulatory_compliance_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance obligation tracking and risk exposure metrics for regulatory requirements across jurisdictions"
  source: "`power_and_utilities`.`regulatory`.`compliance_obligation`"
  dimensions:
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of compliance obligation"
    - name: "obligation_category"
      expr: obligation_category
      comment: "Category of compliance obligation"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current compliance status"
    - name: "governing_body"
      expr: governing_body
      comment: "Regulatory body governing this obligation"
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction for the obligation"
    - name: "risk_priority"
      expr: risk_priority
      comment: "Risk priority level (high, medium, low)"
    - name: "compliance_frequency"
      expr: compliance_frequency
      comment: "Frequency of compliance reporting or action required"
    - name: "ghg_reporting_applicable"
      expr: ghg_reporting_applicable
      comment: "Whether GHG reporting applies to this obligation"
    - name: "nerc_violation_risk_factor"
      expr: nerc_violation_risk_factor
      comment: "NERC violation risk factor classification"
  measures:
    - name: "total_compliance_obligations"
      expr: COUNT(1)
      comment: "Total number of compliance obligations"
    - name: "active_obligations"
      expr: SUM(CASE WHEN compliance_status = 'Active' THEN 1 ELSE 0 END)
      comment: "Count of active compliance obligations"
    - name: "total_penalty_exposure_usd"
      expr: SUM(CAST(penalty_exposure_usd AS DOUBLE))
      comment: "Total potential penalty exposure across all obligations"
    - name: "avg_penalty_exposure_per_obligation"
      expr: AVG(CAST(penalty_exposure_usd AS DOUBLE))
      comment: "Average penalty exposure per compliance obligation"
    - name: "high_risk_obligation_count"
      expr: SUM(CASE WHEN risk_priority = 'High' THEN 1 ELSE 0 END)
      comment: "Count of high-risk compliance obligations"
    - name: "overdue_obligations"
      expr: SUM(CASE WHEN next_due_date < CURRENT_DATE() AND compliance_status != 'Completed' THEN 1 ELSE 0 END)
      comment: "Count of obligations past their due date"
    - name: "avg_days_since_last_assessment"
      expr: AVG(DATEDIFF(CURRENT_DATE(), last_assessment_date))
      comment: "Average days since last compliance assessment"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`regulatory_compliance_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Compliance event and violation tracking with penalty and remediation metrics"
  source: "`power_and_utilities`.`regulatory`.`compliance_event`"
  dimensions:
    - name: "event_type"
      expr: event_type
      comment: "Type of compliance event"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Current status of the compliance event"
    - name: "compliance_domain"
      expr: compliance_domain
      comment: "Domain of compliance (environmental, safety, reliability, etc.)"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the event"
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction"
    - name: "risk_level"
      expr: risk_level
      comment: "Risk level of the event"
    - name: "violation_severity_level"
      expr: violation_severity_level
      comment: "Severity level of violation if applicable"
    - name: "self_report_indicator"
      expr: self_report_indicator
      comment: "Whether event was self-reported"
    - name: "penalty_paid_indicator"
      expr: penalty_paid_indicator
      comment: "Whether penalty has been paid"
    - name: "event_year"
      expr: YEAR(event_date)
      comment: "Year the compliance event occurred"
  measures:
    - name: "total_compliance_events"
      expr: COUNT(1)
      comment: "Total number of compliance events"
    - name: "total_penalty_amount"
      expr: SUM(CAST(penalty_amount AS DOUBLE))
      comment: "Total penalty amounts assessed"
    - name: "total_penalties_paid"
      expr: SUM(CASE WHEN penalty_paid_indicator = true THEN CAST(penalty_amount AS DOUBLE) ELSE 0 END)
      comment: "Total penalties that have been paid"
    - name: "total_penalties_outstanding"
      expr: SUM(CASE WHEN penalty_paid_indicator = false THEN CAST(penalty_amount AS DOUBLE) ELSE 0 END)
      comment: "Total penalties not yet paid"
    - name: "avg_penalty_per_event"
      expr: AVG(CAST(penalty_amount AS DOUBLE))
      comment: "Average penalty amount per compliance event"
    - name: "self_reported_event_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN self_report_indicator = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of events that were self-reported"
    - name: "closed_event_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN closed_indicator = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of compliance events that are closed"
    - name: "avg_days_to_closure"
      expr: AVG(DATEDIFF(closure_date, event_date))
      comment: "Average days from event occurrence to closure"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`regulatory_emissions_report`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental emissions reporting metrics tracking pollutant quantities, intensities, and compliance verification"
  source: "`power_and_utilities`.`regulatory`.`emissions_report`"
  dimensions:
    - name: "pollutant_type"
      expr: pollutant_type
      comment: "Type of pollutant being reported"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type used in generation"
    - name: "reporting_agency"
      expr: reporting_agency
      comment: "Agency to which emissions are reported"
    - name: "reporting_period_type"
      expr: reporting_period_type
      comment: "Type of reporting period (annual, quarterly, monthly)"
    - name: "submission_status"
      expr: submission_status
      comment: "Status of the emissions report submission"
    - name: "verified_indicator"
      expr: verified_indicator
      comment: "Whether emissions have been third-party verified"
    - name: "ghg_scope"
      expr: ghg_scope
      comment: "GHG emissions scope (Scope 1, 2, or 3)"
    - name: "measurement_methodology"
      expr: measurement_methodology
      comment: "Methodology used to measure emissions"
    - name: "reporting_year"
      expr: YEAR(reporting_period_end_date)
      comment: "Year of the reporting period end"
  measures:
    - name: "total_emissions_reports"
      expr: COUNT(1)
      comment: "Total number of emissions reports"
    - name: "total_emissions_quantity_tons"
      expr: SUM(CAST(emissions_quantity_tons AS DOUBLE))
      comment: "Total emissions quantity in tons"
    - name: "total_co2e_metric_tons"
      expr: SUM(CAST(co2e_quantity_metric_tons AS DOUBLE))
      comment: "Total CO2 equivalent emissions in metric tons"
    - name: "total_gross_generation_mwh"
      expr: SUM(CAST(gross_generation_mwh AS DOUBLE))
      comment: "Total gross generation in MWh"
    - name: "avg_emissions_intensity_lbs_per_mwh"
      expr: AVG(CAST(emissions_intensity_lbs_per_mwh AS DOUBLE))
      comment: "Average emissions intensity in pounds per MWh"
    - name: "total_fuel_consumption"
      expr: SUM(CAST(fuel_consumption_quantity AS DOUBLE))
      comment: "Total fuel consumption quantity"
    - name: "total_heat_input_mmbtu"
      expr: SUM(CAST(heat_input_mmbtu AS DOUBLE))
      comment: "Total heat input in MMBtu"
    - name: "verification_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN verified_indicator = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of emissions reports that are verified"
    - name: "total_allowances_surrendered"
      expr: SUM(CAST(allowances_surrendered AS DOUBLE))
      comment: "Total emissions allowances surrendered"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`regulatory_cpcn_application`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Certificate of Public Convenience and Necessity application metrics tracking project approvals, capex, and capacity additions"
  source: "`power_and_utilities`.`regulatory`.`cpcn_application`"
  dimensions:
    - name: "application_status"
      expr: application_status
      comment: "Current status of CPCN application"
    - name: "infrastructure_type"
      expr: infrastructure_type
      comment: "Type of infrastructure (generation, transmission, distribution)"
    - name: "fuel_technology_type"
      expr: fuel_technology_type
      comment: "Fuel or technology type for generation projects"
    - name: "jurisdiction_code"
      expr: jurisdiction_code
      comment: "Regulatory jurisdiction code"
    - name: "state_code"
      expr: state_code
      comment: "State where project is located"
    - name: "environmental_review_status"
      expr: environmental_review_status
      comment: "Status of environmental review"
    - name: "rate_base_eligible_flag"
      expr: rate_base_eligible_flag
      comment: "Whether project is eligible for rate base treatment"
    - name: "rec_eligible_flag"
      expr: rec_eligible_flag
      comment: "Whether project is eligible for renewable energy credits"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the CPCN application was filed"
  measures:
    - name: "total_cpcn_applications"
      expr: COUNT(1)
      comment: "Total number of CPCN applications"
    - name: "total_estimated_capex_usd"
      expr: SUM(CAST(estimated_capex_usd AS DOUBLE))
      comment: "Total estimated capital expenditure for all applications"
    - name: "avg_estimated_capex_per_project"
      expr: AVG(CAST(estimated_capex_usd AS DOUBLE))
      comment: "Average estimated capex per CPCN project"
    - name: "total_applied_capacity_mw"
      expr: SUM(CAST(applied_capacity_mw AS DOUBLE))
      comment: "Total generation capacity applied for in MW"
    - name: "avg_capacity_per_project_mw"
      expr: AVG(CAST(applied_capacity_mw AS DOUBLE))
      comment: "Average capacity per generation project in MW"
    - name: "total_line_length_miles"
      expr: SUM(CAST(line_length_miles AS DOUBLE))
      comment: "Total transmission line length in miles"
    - name: "approval_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN application_status = 'Approved' THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of CPCN applications approved"
    - name: "avg_days_to_decision"
      expr: AVG(DATEDIFF(decision_date, filing_date))
      comment: "Average days from filing to regulatory decision"
    - name: "total_ghg_emissions_impact_tons"
      expr: SUM(CAST(ghg_emissions_impact_tons AS DOUBLE))
      comment: "Total estimated GHG emissions impact in tons"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`regulatory_cost_recovery_mechanism`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Cost recovery mechanism tracking for regulatory assets, riders, and deferred cost balances"
  source: "`power_and_utilities`.`regulatory`.`cost_recovery_mechanism`"
  dimensions:
    - name: "mechanism_type"
      expr: mechanism_type
      comment: "Type of cost recovery mechanism"
    - name: "mechanism_code"
      expr: mechanism_code
      comment: "Code identifying the mechanism"
    - name: "cost_recovery_mechanism_status"
      expr: cost_recovery_mechanism_status
      comment: "Current status of the mechanism"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the mechanism"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction for the mechanism"
    - name: "service_type"
      expr: service_type
      comment: "Service type (electric, gas)"
    - name: "customer_class_scope"
      expr: customer_class_scope
      comment: "Customer classes subject to the mechanism"
    - name: "recovery_method"
      expr: recovery_method
      comment: "Method of cost recovery"
    - name: "regulatory_asset_liability"
      expr: regulatory_asset_liability
      comment: "Whether mechanism creates asset or liability"
    - name: "prudency_review_required"
      expr: prudency_review_required
      comment: "Whether prudency review is required"
  measures:
    - name: "total_cost_recovery_mechanisms"
      expr: COUNT(1)
      comment: "Total number of cost recovery mechanisms"
    - name: "total_current_balance"
      expr: SUM(CAST(current_balance AS DOUBLE))
      comment: "Total current balance across all mechanisms"
    - name: "total_authorized_amount"
      expr: SUM(CAST(total_authorized_amount AS DOUBLE))
      comment: "Total authorized recovery amount"
    - name: "total_disallowed_amount"
      expr: SUM(CAST(disallowed_amount AS DOUBLE))
      comment: "Total disallowed costs"
    - name: "total_wip_balance"
      expr: SUM(CAST(wip_balance AS DOUBLE))
      comment: "Total work-in-progress balance"
    - name: "avg_interest_rate_pct"
      expr: AVG(CAST(interest_rate_pct AS DOUBLE))
      comment: "Average interest rate on deferred balances"
    - name: "avg_current_rate_amount"
      expr: AVG(CAST(current_rate_amount AS DOUBLE))
      comment: "Average current rate amount"
    - name: "total_annual_cap_amount"
      expr: SUM(CAST(annual_cap_amount AS DOUBLE))
      comment: "Total annual recovery caps"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`regulatory_docket`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Regulatory docket and proceeding metrics tracking case volumes, timelines, and outcomes across jurisdictions"
  source: "`power_and_utilities`.`regulatory`.`docket`"
  dimensions:
    - name: "proceeding_type"
      expr: proceeding_type
      comment: "Type of regulatory proceeding"
    - name: "proceeding_subtype"
      expr: proceeding_subtype
      comment: "Subtype of proceeding"
    - name: "docket_status"
      expr: docket_status
      comment: "Current status of the docket"
    - name: "regulatory_body"
      expr: regulatory_body
      comment: "Regulatory body overseeing the docket"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the proceeding"
    - name: "service_type"
      expr: service_type
      comment: "Service type (electric, gas, water)"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level of the docket"
    - name: "settlement_reached"
      expr: settlement_reached
      comment: "Whether settlement was reached"
    - name: "hearing_required"
      expr: hearing_required
      comment: "Whether evidentiary hearing was required"
    - name: "filing_year"
      expr: YEAR(filing_date)
      comment: "Year the docket was filed"
  measures:
    - name: "total_dockets"
      expr: COUNT(1)
      comment: "Total number of regulatory dockets"
    - name: "total_requested_revenue_requirement"
      expr: SUM(CAST(requested_revenue_requirement AS DOUBLE))
      comment: "Total revenue requirement requested"
    - name: "total_approved_revenue_requirement"
      expr: SUM(CAST(approved_revenue_requirement AS DOUBLE))
      comment: "Total revenue requirement approved"
    - name: "avg_requested_ror"
      expr: AVG(CAST(requested_rate_of_return AS DOUBLE))
      comment: "Average requested rate of return"
    - name: "avg_approved_ror"
      expr: AVG(CAST(approved_rate_of_return AS DOUBLE))
      comment: "Average approved rate of return"
    - name: "settlement_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN settlement_reached = true THEN 1 ELSE 0 END) / NULLIF(COUNT(1), 0), 2)
      comment: "Percentage of dockets resolved through settlement"
    - name: "avg_days_filing_to_final_order"
      expr: AVG(DATEDIFF(final_order_date, filing_date))
      comment: "Average days from filing to final order"
    - name: "avg_days_filing_to_hearing"
      expr: AVG(DATEDIFF(hearing_date, filing_date))
      comment: "Average days from filing to hearing"
    - name: "total_estimated_capex"
      expr: SUM(CAST(estimated_capex AS DOUBLE))
      comment: "Total estimated capital expenditure for CPCN dockets"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`regulatory_prudency_review`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Prudency review metrics tracking regulatory scrutiny of utility expenditures and disallowances"
  source: "`power_and_utilities`.`regulatory`.`prudency_review`"
  dimensions:
    - name: "review_type"
      expr: review_type
      comment: "Type of prudency review"
    - name: "review_status"
      expr: review_status
      comment: "Current status of the review"
    - name: "reviewing_body"
      expr: reviewing_body
      comment: "Regulatory body conducting the review"
    - name: "jurisdiction_state"
      expr: jurisdiction_state
      comment: "State jurisdiction"
    - name: "final_determination"
      expr: final_determination
      comment: "Final determination outcome"
    - name: "settlement_indicator"
      expr: settlement_indicator
      comment: "Whether review was settled"
    - name: "appeal_indicator"
      expr: appeal_indicator
      comment: "Whether determination was appealed"
    - name: "review_year"
      expr: YEAR(review_period_start_date)
      comment: "Year of review period start"
  measures:
    - name: "total_prudency_reviews"
      expr: COUNT(1)
      comment: "Total number of prudency reviews"
    - name: "total_expenditure_under_review"
      expr: SUM(CAST(total_expenditure_under_review_amt AS DOUBLE))
      comment: "Total expenditure amount under prudency review"
    - name: "total_capex_under_review"
      expr: SUM(CAST(capex_under_review_amt AS DOUBLE))
      comment: "Total capital expenditure under review"
    - name: "total_opex_under_review"
      expr: SUM(CAST(opex_under_review_amt AS DOUBLE))
      comment: "Total operating expenditure under review"
    - name: "total_disallowed_amount"
      expr: SUM(CAST(disallowed_amt AS DOUBLE))
      comment: "Total costs disallowed by regulators"
    - name: "total_approved_recovery"
      expr: SUM(CAST(approved_recovery_amt AS DOUBLE))
      comment: "Total amount approved for recovery"
    - name: "avg_disallowance_rate"
      expr: AVG(ROUND(100.0 * CAST(disallowed_amt AS DOUBLE) / NULLIF(CAST(total_expenditure_under_review_amt AS DOUBLE), 0), 2))
      comment: "Average percentage of expenditures disallowed"
    - name: "avg_days_to_final_determination"
      expr: AVG(DATEDIFF(final_determination_date, initiation_date))
      comment: "Average days from initiation to final determination"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`regulatory_rps_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Renewable Portfolio Standard program metrics tracking compliance targets, costs, and renewable energy mandates"
  source: "`power_and_utilities`.`regulatory`.`rps_program`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of RPS program"
    - name: "program_status"
      expr: program_status
      comment: "Current status of the program"
    - name: "jurisdiction"
      expr: jurisdiction
      comment: "Jurisdiction of the RPS program"
    - name: "regulatory_authority"
      expr: regulatory_authority
      comment: "Regulatory authority administering the program"
    - name: "compliance_year"
      expr: compliance_year
      comment: "Compliance year for the program"
    - name: "banking_allowed"
      expr: banking_allowed
      comment: "Whether REC banking is allowed"
    - name: "rec_trading_allowed"
      expr: rec_trading_allowed
      comment: "Whether REC trading is allowed"
    - name: "cost_recovery_mechanism"
      expr: cost_recovery_mechanism
      comment: "Mechanism for recovering RPS compliance costs"
  measures:
    - name: "total_rps_programs"
      expr: COUNT(1)
      comment: "Total number of RPS programs"
    - name: "avg_target_percentage"
      expr: AVG(CAST(target_percentage AS DOUBLE))
      comment: "Average renewable energy target percentage"
    - name: "total_target_mwh"
      expr: SUM(CAST(target_mwh AS DOUBLE))
      comment: "Total renewable energy target in MWh"
    - name: "avg_solar_carve_out_pct"
      expr: AVG(CAST(carve_out_solar_percentage AS DOUBLE))
      comment: "Average solar carve-out percentage"
    - name: "avg_wind_carve_out_pct"
      expr: AVG(CAST(carve_out_wind_percentage AS DOUBLE))
      comment: "Average wind carve-out percentage"
    - name: "avg_penalty_rate"
      expr: AVG(CAST(penalty_rate AS DOUBLE))
      comment: "Average penalty rate for non-compliance"
    - name: "avg_acp_rate"
      expr: AVG(CAST(alternative_compliance_payment_rate AS DOUBLE))
      comment: "Average alternative compliance payment rate"
    - name: "total_cost_cap_amount"
      expr: SUM(CAST(cost_cap_amount AS DOUBLE))
      comment: "Total cost cap amounts across programs"
    - name: "avg_ghg_reduction_target_pct"
      expr: AVG(CAST(ghg_reduction_target_percentage AS DOUBLE))
      comment: "Average GHG reduction target percentage"
$$;