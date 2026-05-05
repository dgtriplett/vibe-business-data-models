-- Metric views for domain: customer | Business: Power and Utilities | Version: 1 | Generated on: 2026-04-29 23:09:06

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`customer_account`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core customer account metrics tracking account base, growth, and program adoption rates"
  source: "`power_and_utilities`.`customer`.`account`"
  dimensions:
    - name: "account_status"
      expr: account_status
      comment: "Current status of the account (active, inactive, closed)"
    - name: "account_type"
      expr: account_type
      comment: "Type of account (residential, commercial, industrial)"
    - name: "service_territory_code"
      expr: service_territory_code
      comment: "Geographic service territory identifier"
    - name: "billing_cycle_code"
      expr: billing_cycle_code
      comment: "Billing cycle assignment for the account"
    - name: "collection_status"
      expr: collection_status
      comment: "Current collection status (current, delinquent, collections)"
    - name: "credit_rating"
      expr: credit_rating
      comment: "Credit rating classification of the account"
    - name: "disconnect_status"
      expr: disconnect_status
      comment: "Service disconnection status"
    - name: "open_year"
      expr: YEAR(open_date)
      comment: "Year the account was opened"
    - name: "open_month"
      expr: DATE_TRUNC('MONTH', open_date)
      comment: "Month the account was opened"
    - name: "language_preference"
      expr: language_preference
      comment: "Customer preferred language for communications"
  measures:
    - name: "total_accounts"
      expr: COUNT(DISTINCT account_id)
      comment: "Total number of unique customer accounts"
    - name: "autopay_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_pay_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts enrolled in automatic payment"
    - name: "paperless_billing_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN paperless_billing_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts enrolled in paperless billing"
    - name: "demand_response_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN demand_response_enrolled_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts enrolled in demand response programs"
    - name: "net_metering_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN net_metering_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts with net metering enabled (solar/DER)"
    - name: "low_income_assistance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN low_income_assistance_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts receiving low-income assistance"
    - name: "life_support_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN life_support_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts with life support equipment (critical for outage prioritization)"
    - name: "medical_baseline_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN medical_baseline_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts on medical baseline program"
    - name: "ev_customer_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN electric_vehicle_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts with electric vehicles (key for load forecasting)"
    - name: "energy_efficiency_program_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN energy_efficiency_program_flag = TRUE THEN account_id END) / NULLIF(COUNT(DISTINCT account_id), 0), 2)
      comment: "Percentage of accounts enrolled in energy efficiency programs"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`customer_service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service agreement metrics tracking contracted capacity, program enrollment, and service characteristics"
  source: "`power_and_utilities`.`customer`.`customer_service_agreement`"
  dimensions:
    - name: "sa_status"
      expr: sa_status
      comment: "Service agreement status (active, pending, terminated)"
    - name: "sa_type"
      expr: sa_type
      comment: "Type of service agreement"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity being served (electric, gas, dual)"
    - name: "rate_class"
      expr: rate_class
      comment: "Rate classification (residential, commercial, industrial)"
    - name: "service_phase"
      expr: service_phase
      comment: "Electrical service phase (single, three-phase)"
    - name: "service_voltage"
      expr: service_voltage
      comment: "Service voltage level"
    - name: "load_profile_type"
      expr: load_profile_type
      comment: "Load profile classification for forecasting"
    - name: "nem_program_type"
      expr: nem_program_type
      comment: "Net energy metering program type"
    - name: "start_year"
      expr: YEAR(start_date)
      comment: "Year service agreement started"
    - name: "start_month"
      expr: DATE_TRUNC('MONTH', start_date)
      comment: "Month service agreement started"
  measures:
    - name: "total_service_agreements"
      expr: COUNT(DISTINCT customer_service_agreement_id)
      comment: "Total number of active service agreements"
    - name: "total_contracted_demand_kw"
      expr: SUM(CAST(contracted_demand_kw AS DOUBLE))
      comment: "Total contracted demand capacity in kilowatts"
    - name: "avg_contracted_demand_kw"
      expr: AVG(CAST(contracted_demand_kw AS DOUBLE))
      comment: "Average contracted demand per service agreement"
    - name: "total_estimated_annual_usage_kwh"
      expr: SUM(CAST(estimated_annual_usage_kwh AS DOUBLE))
      comment: "Total estimated annual electric usage across all agreements"
    - name: "total_estimated_annual_usage_therms"
      expr: SUM(CAST(estimated_annual_usage_therms AS DOUBLE))
      comment: "Total estimated annual gas usage across all agreements"
    - name: "nem_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN nem_enrolled_flag = TRUE THEN customer_service_agreement_id END) / NULLIF(COUNT(DISTINCT customer_service_agreement_id), 0), 2)
      comment: "Percentage of service agreements with net energy metering"
    - name: "dr_program_enrollment_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN dr_program_enrolled_flag = TRUE THEN customer_service_agreement_id END) / NULLIF(COUNT(DISTINCT customer_service_agreement_id), 0), 2)
      comment: "Percentage of service agreements enrolled in demand response programs"
    - name: "ev_charging_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN ev_charging_flag = TRUE THEN customer_service_agreement_id END) / NULLIF(COUNT(DISTINCT customer_service_agreement_id), 0), 2)
      comment: "Percentage of service agreements with EV charging (critical for grid planning)"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total customer deposits held"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`customer_enrollment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Program enrollment metrics tracking participation, incentives, and load reduction commitments"
  source: "`power_and_utilities`.`customer`.`enrollment`"
  dimensions:
    - name: "program_type"
      expr: program_type
      comment: "Type of program (demand response, energy efficiency, renewable)"
    - name: "program_name"
      expr: program_name
      comment: "Specific program name"
    - name: "enrollment_status"
      expr: enrollment_status
      comment: "Current enrollment status (active, pending, cancelled)"
    - name: "eligibility_status"
      expr: eligibility_status
      comment: "Eligibility verification status"
    - name: "channel"
      expr: channel
      comment: "Enrollment channel (web, phone, agent, partner)"
    - name: "cancellation_reason_code"
      expr: cancellation_reason_code
      comment: "Reason code for enrollment cancellation"
    - name: "enrollment_year"
      expr: YEAR(enrollment_date)
      comment: "Year customer enrolled in program"
    - name: "enrollment_month"
      expr: DATE_TRUNC('MONTH', enrollment_date)
      comment: "Month customer enrolled in program"
  measures:
    - name: "total_enrollments"
      expr: COUNT(DISTINCT enrollment_id)
      comment: "Total number of program enrollments"
    - name: "total_committed_load_reduction_kw"
      expr: SUM(CAST(committed_load_reduction_kw AS DOUBLE))
      comment: "Total committed load reduction capacity in kilowatts (critical for grid reliability)"
    - name: "avg_committed_load_reduction_kw"
      expr: AVG(CAST(committed_load_reduction_kw AS DOUBLE))
      comment: "Average committed load reduction per enrollment"
    - name: "total_incentive_amount"
      expr: SUM(CAST(incentive_amount AS DOUBLE))
      comment: "Total incentive payments committed to customers"
    - name: "avg_incentive_amount"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount per enrollment"
    - name: "total_monthly_credit_amount"
      expr: SUM(CAST(monthly_credit_amount AS DOUBLE))
      comment: "Total monthly bill credits issued to enrolled customers"
    - name: "auto_renew_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN auto_renew_flag = TRUE THEN enrollment_id END) / NULLIF(COUNT(DISTINCT enrollment_id), 0), 2)
      comment: "Percentage of enrollments with auto-renewal enabled"
    - name: "terms_acceptance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN terms_accepted_flag = TRUE THEN enrollment_id END) / NULLIF(COUNT(DISTINCT enrollment_id), 0), 2)
      comment: "Percentage of enrollments with accepted terms and conditions"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN cancellation_date IS NOT NULL THEN enrollment_id END) / NULLIF(COUNT(DISTINCT enrollment_id), 0), 2)
      comment: "Percentage of enrollments that have been cancelled"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`customer_interaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer service interaction metrics tracking resolution efficiency, satisfaction, and channel performance"
  source: "`power_and_utilities`.`customer`.`interaction`"
  dimensions:
    - name: "interaction_type"
      expr: interaction_type
      comment: "Type of customer interaction (inquiry, complaint, service request)"
    - name: "channel"
      expr: channel
      comment: "Communication channel (phone, web, mobile, in-person)"
    - name: "contact_reason_code"
      expr: contact_reason_code
      comment: "Primary reason for customer contact"
    - name: "interaction_status"
      expr: interaction_status
      comment: "Current status of the interaction (open, closed, escalated)"
    - name: "resolution_code"
      expr: resolution_code
      comment: "Resolution outcome code"
    - name: "priority_level"
      expr: priority_level
      comment: "Priority level assigned to interaction"
    - name: "complaint_category"
      expr: complaint_category
      comment: "Category of complaint if applicable"
    - name: "inbound_outbound_indicator"
      expr: inbound_outbound_indicator
      comment: "Direction of interaction (inbound from customer, outbound from utility)"
    - name: "interaction_year"
      expr: YEAR(start_timestamp)
      comment: "Year interaction occurred"
    - name: "interaction_month"
      expr: DATE_TRUNC('MONTH', start_timestamp)
      comment: "Month interaction occurred"
  measures:
    - name: "total_interactions"
      expr: COUNT(DISTINCT interaction_id)
      comment: "Total number of customer interactions"
    - name: "first_contact_resolution_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN first_contact_resolution_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions resolved on first contact (key service quality metric)"
    - name: "sla_compliance_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN sla_met_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions meeting service level agreement targets"
    - name: "escalation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN escalation_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions requiring escalation"
    - name: "complaint_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN complaint_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions classified as complaints (regulatory reporting metric)"
    - name: "callback_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN callback_requested_flag = TRUE AND callback_completed_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT CASE WHEN callback_requested_flag = TRUE THEN interaction_id END), 0), 2)
      comment: "Percentage of requested callbacks that were completed"
    - name: "regulatory_reportable_interaction_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_reportable_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions requiring regulatory reporting"
    - name: "payment_arrangement_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN payment_arrangement_flag = TRUE THEN interaction_id END) / NULLIF(COUNT(DISTINCT interaction_id), 0), 2)
      comment: "Percentage of interactions resulting in payment arrangements"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`customer_credit_deposit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer deposit metrics tracking deposit liability, refunds, and interest accrual"
  source: "`power_and_utilities`.`customer`.`credit_deposit`"
  dimensions:
    - name: "deposit_status"
      expr: deposit_status
      comment: "Current status of the deposit (held, refunded, forfeited)"
    - name: "deposit_type"
      expr: deposit_type
      comment: "Type of deposit (credit, service, reconnection)"
    - name: "deposit_reason_code"
      expr: deposit_reason_code
      comment: "Reason deposit was required"
    - name: "refund_method"
      expr: refund_method
      comment: "Method used for deposit refund (check, credit, transfer)"
    - name: "waiver_reason"
      expr: waiver_reason
      comment: "Reason deposit requirement was waived"
    - name: "received_year"
      expr: YEAR(received_date)
      comment: "Year deposit was received"
    - name: "received_month"
      expr: DATE_TRUNC('MONTH', received_date)
      comment: "Month deposit was received"
  measures:
    - name: "total_deposits"
      expr: COUNT(DISTINCT credit_deposit_id)
      comment: "Total number of customer deposits"
    - name: "total_deposit_liability"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit liability held by utility (balance sheet metric)"
    - name: "total_applied_amount"
      expr: SUM(CAST(applied_amount AS DOUBLE))
      comment: "Total deposit amounts applied to customer bills"
    - name: "total_refund_amount"
      expr: SUM(CAST(refund_amount AS DOUBLE))
      comment: "Total deposit amounts refunded to customers"
    - name: "total_accrued_interest"
      expr: SUM(CAST(accrued_interest_amount AS DOUBLE))
      comment: "Total interest accrued on customer deposits (regulatory requirement)"
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per customer"
    - name: "deposit_waiver_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN waiver_flag = TRUE THEN credit_deposit_id END) / NULLIF(COUNT(DISTINCT credit_deposit_id), 0), 2)
      comment: "Percentage of deposits that were waived"
    - name: "consent_obtained_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN consent_obtained_flag = TRUE THEN credit_deposit_id END) / NULLIF(COUNT(DISTINCT credit_deposit_id), 0), 2)
      comment: "Percentage of deposits with proper customer consent"
    - name: "regulatory_reportable_deposit_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN regulatory_reportable_flag = TRUE THEN credit_deposit_id END) / NULLIF(COUNT(DISTINCT credit_deposit_id), 0), 2)
      comment: "Percentage of deposits requiring regulatory reporting"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`customer_premise`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Premise metrics tracking distributed energy resources, service characteristics, and risk factors"
  source: "`power_and_utilities`.`customer`.`premise`"
  dimensions:
    - name: "premise_status"
      expr: premise_status
      comment: "Current status of the premise (active, inactive, pending)"
    - name: "premise_type"
      expr: premise_type
      comment: "Type of premise (residential, commercial, industrial)"
    - name: "classification"
      expr: classification
      comment: "Premise classification"
    - name: "electric_service_territory"
      expr: electric_service_territory
      comment: "Electric service territory code"
    - name: "gas_service_territory"
      expr: gas_service_territory
      comment: "Gas service territory code"
    - name: "rate_zone"
      expr: rate_zone
      comment: "Rate zone assignment"
    - name: "climate_zone"
      expr: climate_zone
      comment: "Climate zone classification"
    - name: "wildfire_risk_zone"
      expr: wildfire_risk_zone
      comment: "Wildfire risk zone classification (critical for PSPS planning)"
    - name: "ami_deployment_status"
      expr: ami_deployment_status
      comment: "Advanced metering infrastructure deployment status"
    - name: "heating_fuel_type"
      expr: heating_fuel_type
      comment: "Primary heating fuel type"
    - name: "state"
      expr: state
      comment: "State where premise is located"
  measures:
    - name: "total_premises"
      expr: COUNT(DISTINCT premise_id)
      comment: "Total number of service premises"
    - name: "solar_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN solar_installation_indicator = TRUE THEN premise_id END) / NULLIF(COUNT(DISTINCT premise_id), 0), 2)
      comment: "Percentage of premises with solar installations (key for grid planning)"
    - name: "total_solar_capacity_kw"
      expr: SUM(CAST(solar_capacity_kw AS DOUBLE))
      comment: "Total installed solar capacity in kilowatts"
    - name: "avg_solar_capacity_kw"
      expr: AVG(CAST(solar_capacity_kw AS DOUBLE))
      comment: "Average solar capacity per installation"
    - name: "battery_storage_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN battery_storage_indicator = TRUE THEN premise_id END) / NULLIF(COUNT(DISTINCT premise_id), 0), 2)
      comment: "Percentage of premises with battery storage (critical for grid flexibility)"
    - name: "total_battery_capacity_kwh"
      expr: SUM(CAST(battery_capacity_kwh AS DOUBLE))
      comment: "Total installed battery storage capacity in kilowatt-hours"
    - name: "ev_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN electric_vehicle_indicator = TRUE THEN premise_id END) / NULLIF(COUNT(DISTINCT premise_id), 0), 2)
      comment: "Percentage of premises with electric vehicles (load forecasting input)"
    - name: "smart_thermostat_penetration_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN smart_thermostat_indicator = TRUE THEN premise_id END) / NULLIF(COUNT(DISTINCT premise_id), 0), 2)
      comment: "Percentage of premises with smart thermostats (demand response potential)"
    - name: "life_support_premise_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN life_support_indicator = TRUE THEN premise_id END) / NULLIF(COUNT(DISTINCT premise_id), 0), 2)
      comment: "Percentage of premises with life support equipment (outage prioritization)"
    - name: "wildfire_risk_premise_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN wildfire_risk_zone IS NOT NULL AND wildfire_risk_zone != '' THEN premise_id END) / NULLIF(COUNT(DISTINCT premise_id), 0), 2)
      comment: "Percentage of premises in wildfire risk zones (PSPS planning metric)"
    - name: "flood_zone_premise_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN flood_zone_indicator = TRUE THEN premise_id END) / NULLIF(COUNT(DISTINCT premise_id), 0), 2)
      comment: "Percentage of premises in flood zones (resilience planning)"
    - name: "low_income_premise_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN low_income_indicator = TRUE THEN premise_id END) / NULLIF(COUNT(DISTINCT premise_id), 0), 2)
      comment: "Percentage of premises qualifying for low-income programs"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`customer_party`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer party metrics tracking customer base composition, credit profile, and program eligibility"
  source: "`power_and_utilities`.`customer`.`party`"
  dimensions:
    - name: "party_type"
      expr: party_type
      comment: "Type of party (individual, business, government)"
    - name: "customer_class"
      expr: customer_class
      comment: "Customer classification (residential, commercial, industrial)"
    - name: "credit_class"
      expr: credit_class
      comment: "Credit classification for risk assessment"
    - name: "lifecycle_status"
      expr: lifecycle_status
      comment: "Customer lifecycle status (prospect, active, inactive, former)"
    - name: "language_preference"
      expr: language_preference
      comment: "Preferred language for communications"
    - name: "identity_verification_status"
      expr: identity_verification_status
      comment: "Status of identity verification"
    - name: "industry_code"
      expr: industry_code
      comment: "Industry classification code for business customers"
    - name: "customer_since_year"
      expr: YEAR(customer_since_date)
      comment: "Year customer relationship began"
  measures:
    - name: "total_parties"
      expr: COUNT(DISTINCT party_id)
      comment: "Total number of unique customer parties"
    - name: "vip_customer_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN vip_indicator = TRUE THEN party_id END) / NULLIF(COUNT(DISTINCT party_id), 0), 2)
      comment: "Percentage of customers designated as VIP"
    - name: "low_income_eligibility_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN low_income_assistance_indicator = TRUE THEN party_id END) / NULLIF(COUNT(DISTINCT party_id), 0), 2)
      comment: "Percentage of customers eligible for low-income assistance programs"
    - name: "medical_baseline_eligibility_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN medical_baseline_indicator = TRUE THEN party_id END) / NULLIF(COUNT(DISTINCT party_id), 0), 2)
      comment: "Percentage of customers eligible for medical baseline program"
    - name: "paperless_billing_adoption_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN paperless_billing_indicator = TRUE THEN party_id END) / NULLIF(COUNT(DISTINCT party_id), 0), 2)
      comment: "Percentage of customers enrolled in paperless billing"
    - name: "marketing_opt_in_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN marketing_opt_in_indicator = TRUE THEN party_id END) / NULLIF(COUNT(DISTINCT party_id), 0), 2)
      comment: "Percentage of customers opted in to marketing communications"
    - name: "do_not_contact_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN do_not_contact_indicator = TRUE THEN party_id END) / NULLIF(COUNT(DISTINCT party_id), 0), 2)
      comment: "Percentage of customers with do-not-contact flag"
    - name: "identity_verified_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN identity_verification_status = 'Verified' THEN party_id END) / NULLIF(COUNT(DISTINCT party_id), 0), 2)
      comment: "Percentage of customers with verified identity"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`customer_move_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Move order metrics tracking service start/stop efficiency, appointment performance, and deposit requirements"
  source: "`power_and_utilities`.`customer`.`move_order`"
  dimensions:
    - name: "move_order_status"
      expr: move_order_status
      comment: "Current status of the move order (pending, scheduled, completed, cancelled)"
    - name: "move_type"
      expr: move_type
      comment: "Type of move (move-in, move-out, transfer)"
    - name: "service_type"
      expr: service_type
      comment: "Type of service being moved (electric, gas, dual)"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority level of the move order"
    - name: "processing_channel"
      expr: processing_channel
      comment: "Channel through which move was requested (web, phone, agent)"
    - name: "stop_reason_code"
      expr: stop_reason_code
      comment: "Reason for service stop"
    - name: "cancellation_reason"
      expr: cancellation_reason
      comment: "Reason move order was cancelled"
    - name: "rejection_reason"
      expr: rejection_reason
      comment: "Reason move order was rejected"
    - name: "requested_year"
      expr: YEAR(requested_effective_date)
      comment: "Year move was requested"
    - name: "requested_month"
      expr: DATE_TRUNC('MONTH', requested_effective_date)
      comment: "Month move was requested"
  measures:
    - name: "total_move_orders"
      expr: COUNT(DISTINCT move_order_id)
      comment: "Total number of move orders processed"
    - name: "appointment_required_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN appointment_required_indicator = TRUE THEN move_order_id END) / NULLIF(COUNT(DISTINCT move_order_id), 0), 2)
      comment: "Percentage of moves requiring field appointments"
    - name: "deposit_required_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN deposit_required_indicator = TRUE THEN move_order_id END) / NULLIF(COUNT(DISTINCT move_order_id), 0), 2)
      comment: "Percentage of moves requiring customer deposits"
    - name: "total_deposit_amount"
      expr: SUM(CAST(deposit_amount AS DOUBLE))
      comment: "Total deposit amounts collected for move orders"
    - name: "avg_deposit_amount"
      expr: AVG(CAST(deposit_amount AS DOUBLE))
      comment: "Average deposit amount per move order"
    - name: "final_read_completion_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN final_read_indicator = TRUE THEN move_order_id END) / NULLIF(COUNT(DISTINCT move_order_id), 0), 2)
      comment: "Percentage of move-outs with completed final meter reads"
    - name: "cancellation_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN cancellation_reason IS NOT NULL AND cancellation_reason != '' THEN move_order_id END) / NULLIF(COUNT(DISTINCT move_order_id), 0), 2)
      comment: "Percentage of move orders that were cancelled"
    - name: "rejection_rate"
      expr: ROUND(100.0 * COUNT(DISTINCT CASE WHEN rejection_reason IS NOT NULL AND rejection_reason != '' THEN move_order_id END) / NULLIF(COUNT(DISTINCT move_order_id), 0), 2)
      comment: "Percentage of move orders that were rejected"
$$;