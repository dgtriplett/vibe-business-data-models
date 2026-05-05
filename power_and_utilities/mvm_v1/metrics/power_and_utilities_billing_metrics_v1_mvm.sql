-- Metric views for domain: billing | Business: Power and Utilities | Version: 1 | Generated on: 2026-04-29 23:12:07

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`billing_bill_cycle`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill Cycle business metrics"
  source: "`power_and_utilities`.`billing`.`bill_cycle`"
  dimensions:
    - name: "Auto Pay Eligible Flag"
      expr: auto_pay_eligible_flag
    - name: "Bill Date"
      expr: bill_date
    - name: "Bill Generation Offset Days"
      expr: bill_generation_offset_days
    - name: "Budget Billing Eligible Flag"
      expr: budget_billing_eligible_flag
    - name: "Commodity Type"
      expr: commodity_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Class"
      expr: customer_class
    - name: "Cycle Code"
      expr: cycle_code
    - name: "Cycle Description"
      expr: cycle_description
    - name: "Cycle Frequency"
      expr: cycle_frequency
    - name: "Cycle Name"
      expr: cycle_name
    - name: "Cycle Status"
      expr: cycle_status
    - name: "Effective Date"
      expr: effective_date
    - name: "Estimated Account Count"
      expr: estimated_account_count
    - name: "Estimated Billing Flag"
      expr: estimated_billing_flag
    - name: "Expiration Date"
      expr: expiration_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bill Cycle"
      expr: COUNT(DISTINCT bill_cycle_id)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`billing_bill_dispute`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Bill Dispute business metrics"
  source: "`power_and_utilities`.`billing`.`bill_dispute`"
  dimensions:
    - name: "Adjustment Reason Code"
      expr: adjustment_reason_code
    - name: "Assigned Department"
      expr: assigned_department
    - name: "Billing Period End Date"
      expr: billing_period_end_date
    - name: "Billing Period Start Date"
      expr: billing_period_start_date
    - name: "Closed Date"
      expr: closed_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Contact Email"
      expr: customer_contact_email
    - name: "Customer Contact Name"
      expr: customer_contact_name
    - name: "Customer Contact Phone"
      expr: customer_contact_phone
    - name: "Customer Satisfaction Rating"
      expr: customer_satisfaction_rating
    - name: "Dispute Description"
      expr: dispute_description
    - name: "Dispute Number"
      expr: dispute_number
    - name: "Dispute Open Date"
      expr: dispute_open_date
    - name: "Dispute Open Timestamp"
      expr: dispute_open_timestamp
    - name: "Dispute Reason Code"
      expr: dispute_reason_code
    - name: "Dispute Status"
      expr: dispute_status
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Bill Dispute"
      expr: COUNT(DISTINCT bill_dispute_id)
    - name: "Total Assigned Analyst Code"
      expr: SUM(assigned_analyst_code)
    - name: "Average Assigned Analyst Code"
      expr: AVG(assigned_analyst_code)
    - name: "Total Credit Amount"
      expr: SUM(credit_amount)
    - name: "Average Credit Amount"
      expr: AVG(credit_amount)
    - name: "Total Disputed Amount"
      expr: SUM(disputed_amount)
    - name: "Average Disputed Amount"
      expr: AVG(disputed_amount)
    - name: "Total Disputed Kwh"
      expr: SUM(disputed_kwh)
    - name: "Average Disputed Kwh"
      expr: AVG(disputed_kwh)
    - name: "Total Disputed Mcf"
      expr: SUM(disputed_mcf)
    - name: "Average Disputed Mcf"
      expr: AVG(disputed_mcf)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`billing_billing_service_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Billing Service Agreement business metrics"
  source: "`power_and_utilities`.`billing`.`billing_service_agreement`"
  dimensions:
    - name: "Activated Timestamp"
      expr: activated_timestamp
    - name: "Agreement Number"
      expr: agreement_number
    - name: "Agreement Status"
      expr: agreement_status
    - name: "Agreement Type"
      expr: agreement_type
    - name: "Auto Pay Flag"
      expr: auto_pay_flag
    - name: "Budget Billing Flag"
      expr: budget_billing_flag
    - name: "Collection Status"
      expr: collection_status
    - name: "Commodity Type"
      expr: commodity_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Rating"
      expr: credit_rating
    - name: "Customer Class"
      expr: customer_class
    - name: "Deposit Held Date"
      expr: deposit_held_date
    - name: "End Date"
      expr: end_date
    - name: "Last Bill Date"
      expr: last_bill_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Last Payment Date"
      expr: last_payment_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Billing Service Agreement"
      expr: COUNT(DISTINCT billing_service_agreement_id)
    - name: "Total Average Monthly Usage Kwh"
      expr: SUM(average_monthly_usage_kwh)
    - name: "Average Average Monthly Usage Kwh"
      expr: AVG(average_monthly_usage_kwh)
    - name: "Total Average Monthly Usage Mcf"
      expr: SUM(average_monthly_usage_mcf)
    - name: "Average Average Monthly Usage Mcf"
      expr: AVG(average_monthly_usage_mcf)
    - name: "Total Contract Demand Kw"
      expr: SUM(contract_demand_kw)
    - name: "Average Contract Demand Kw"
      expr: AVG(contract_demand_kw)
    - name: "Total Current Balance"
      expr: SUM(current_balance)
    - name: "Average Current Balance"
      expr: AVG(current_balance)
    - name: "Total Deposit Amount"
      expr: SUM(deposit_amount)
    - name: "Average Deposit Amount"
      expr: AVG(deposit_amount)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`billing_collections_action`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections Action business metrics"
  source: "`power_and_utilities`.`billing`.`collections_action`"
  dimensions:
    - name: "Action Category"
      expr: action_category
    - name: "Action Code"
      expr: action_code
    - name: "Action Name"
      expr: action_name
    - name: "Action Sequence"
      expr: action_sequence
    - name: "Applicable Customer Class"
      expr: applicable_customer_class
    - name: "Auto Trigger Enabled"
      expr: auto_trigger_enabled
    - name: "Auto Trigger Rule"
      expr: auto_trigger_rule
    - name: "Cost Recoverable"
      expr: cost_recoverable
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Reporting Impact"
      expr: credit_reporting_impact
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Description"
      expr: description
    - name: "Dispute Eligible"
      expr: dispute_eligible
    - name: "Effective End Date"
      expr: effective_end_date
    - name: "Effective Start Date"
      expr: effective_start_date
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Collections Action"
      expr: COUNT(DISTINCT collections_action_id)
    - name: "Total Cost Amount"
      expr: SUM(cost_amount)
    - name: "Average Cost Amount"
      expr: AVG(cost_amount)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`billing_collections_case`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Collections Case business metrics"
  source: "`power_and_utilities`.`billing`.`collections_case`"
  dimensions:
    - name: "Actual Disconnect Date"
      expr: actual_disconnect_date
    - name: "Agency Referral Date"
      expr: agency_referral_date
    - name: "Assigned Collections Agent"
      expr: assigned_collections_agent
    - name: "Bankruptcy Case Number"
      expr: bankruptcy_case_number
    - name: "Bankruptcy Filing Date"
      expr: bankruptcy_filing_date
    - name: "Bankruptcy Flag"
      expr: bankruptcy_flag
    - name: "Case Closed Date"
      expr: case_closed_date
    - name: "Case Number"
      expr: case_number
    - name: "Case Opened Date"
      expr: case_opened_date
    - name: "Case Status"
      expr: case_status
    - name: "Collections Agency Name"
      expr: collections_agency_name
    - name: "Collections Stage"
      expr: collections_stage
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Customer Contact Email"
      expr: customer_contact_email
    - name: "Customer Contact Phone"
      expr: customer_contact_phone
    - name: "Days Past Due"
      expr: days_past_due
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Collections Case"
      expr: COUNT(DISTINCT collections_case_id)
    - name: "Total Collections Cost"
      expr: SUM(collections_cost)
    - name: "Average Collections Cost"
      expr: AVG(collections_cost)
    - name: "Total Last Payment Amount"
      expr: SUM(last_payment_amount)
    - name: "Average Last Payment Amount"
      expr: AVG(last_payment_amount)
    - name: "Total Original Debt Amount"
      expr: SUM(original_debt_amount)
    - name: "Average Original Debt Amount"
      expr: AVG(original_debt_amount)
    - name: "Total Past Due Amount"
      expr: SUM(past_due_amount)
    - name: "Average Past Due Amount"
      expr: AVG(past_due_amount)
    - name: "Total Total Recovered Amount"
      expr: SUM(total_recovered_amount)
    - name: "Average Total Recovered Amount"
      expr: AVG(total_recovered_amount)
    - name: "Total Write Off Amount"
      expr: SUM(write_off_amount)
    - name: "Average Write Off Amount"
      expr: AVG(write_off_amount)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`billing_credit_adjustment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Credit Adjustment business metrics"
  source: "`power_and_utilities`.`billing`.`credit_adjustment`"
  dimensions:
    - name: "Adjustment Number"
      expr: adjustment_number
    - name: "Adjustment Status"
      expr: adjustment_status
    - name: "Adjustment Type"
      expr: adjustment_type
    - name: "Approved By User Code"
      expr: approved_by_user_code
    - name: "Approved By User Name"
      expr: approved_by_user_name
    - name: "Authorization Level"
      expr: authorization_level
    - name: "Comments"
      expr: comments
    - name: "Created By User Code"
      expr: created_by_user_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Notification Sent"
      expr: customer_notification_sent
    - name: "Effective Date"
      expr: effective_date
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Gl Posting Status"
      expr: gl_posting_status
    - name: "Last Modified By User Code"
      expr: last_modified_by_user_code
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Credit Adjustment"
      expr: COUNT(DISTINCT credit_adjustment_id)
    - name: "Total Adjustment Amount"
      expr: SUM(adjustment_amount)
    - name: "Average Adjustment Amount"
      expr: AVG(adjustment_amount)
    - name: "Total Tax Impact Amount"
      expr: SUM(tax_impact_amount)
    - name: "Average Tax Impact Amount"
      expr: AVG(tax_impact_amount)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`billing_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice business metrics"
  source: "`power_and_utilities`.`billing`.`invoice`"
  dimensions:
    - name: "Bill Period End Date"
      expr: bill_period_end_date
    - name: "Bill Period Start Date"
      expr: bill_period_start_date
    - name: "Billing Days"
      expr: billing_days
    - name: "Commodity Type"
      expr: commodity_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Delivery Method"
      expr: delivery_method
    - name: "Disconnection Notice Flag"
      expr: disconnection_notice_flag
    - name: "Dispute Flag"
      expr: dispute_flag
    - name: "Dispute Reason"
      expr: dispute_reason
    - name: "Due Date"
      expr: due_date
    - name: "Gl Posting Date"
      expr: gl_posting_date
    - name: "Invoice Date"
      expr: invoice_date
    - name: "Invoice Number"
      expr: invoice_number
    - name: "Invoice Status"
      expr: invoice_status
    - name: "Invoice Type"
      expr: invoice_type
    - name: "Meter Read Type"
      expr: meter_read_type
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice"
      expr: COUNT(DISTINCT invoice_id)
    - name: "Total Consumption Kwh"
      expr: SUM(consumption_kwh)
    - name: "Average Consumption Kwh"
      expr: AVG(consumption_kwh)
    - name: "Total Consumption Therms"
      expr: SUM(consumption_therms)
    - name: "Average Consumption Therms"
      expr: AVG(consumption_therms)
    - name: "Total Current Charges Amount"
      expr: SUM(current_charges_amount)
    - name: "Average Current Charges Amount"
      expr: AVG(current_charges_amount)
    - name: "Total Customer Charge Amount"
      expr: SUM(customer_charge_amount)
    - name: "Average Customer Charge Amount"
      expr: AVG(customer_charge_amount)
    - name: "Total Demand Charge Amount"
      expr: SUM(demand_charge_amount)
    - name: "Average Demand Charge Amount"
      expr: AVG(demand_charge_amount)
    - name: "Total Energy Charge Amount"
      expr: SUM(energy_charge_amount)
    - name: "Average Energy Charge Amount"
      expr: AVG(energy_charge_amount)
    - name: "Total Fac Adjustment Amount"
      expr: SUM(fac_adjustment_amount)
    - name: "Average Fac Adjustment Amount"
      expr: AVG(fac_adjustment_amount)
    - name: "Total Late Fee Amount"
      expr: SUM(late_fee_amount)
    - name: "Average Late Fee Amount"
      expr: AVG(late_fee_amount)
    - name: "Total Outstanding Balance Amount"
      expr: SUM(outstanding_balance_amount)
    - name: "Average Outstanding Balance Amount"
      expr: AVG(outstanding_balance_amount)
    - name: "Total Payment Received Amount"
      expr: SUM(payment_received_amount)
    - name: "Average Payment Received Amount"
      expr: AVG(payment_received_amount)
    - name: "Total Peak Demand Kw"
      expr: SUM(peak_demand_kw)
    - name: "Average Peak Demand Kw"
      expr: AVG(peak_demand_kw)
    - name: "Total Previous Balance Amount"
      expr: SUM(previous_balance_amount)
    - name: "Average Previous Balance Amount"
      expr: AVG(previous_balance_amount)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`billing_invoice_line`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Invoice Line business metrics"
  source: "`power_and_utilities`.`billing`.`invoice_line`"
  dimensions:
    - name: "Adjustment Reason Code"
      expr: adjustment_reason_code
    - name: "Billing Period End Date"
      expr: billing_period_end_date
    - name: "Billing Period Start Date"
      expr: billing_period_start_date
    - name: "Charge Description"
      expr: charge_description
    - name: "Charge Type Code"
      expr: charge_type_code
    - name: "Cost Center Code"
      expr: cost_center_code
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Disputed Flag"
      expr: disputed_flag
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Last Updated Timestamp"
      expr: last_updated_timestamp
    - name: "Line Number"
      expr: line_number
    - name: "Print Sequence"
      expr: print_sequence
    - name: "Rate Component Code"
      expr: rate_component_code
    - name: "Regulatory Rider Code"
      expr: regulatory_rider_code
    - name: "Revenue Class Code"
      expr: revenue_class_code
    - name: "Revenue Recognition Date"
      expr: revenue_recognition_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Invoice Line"
      expr: COUNT(DISTINCT invoice_line_id)
    - name: "Total Line Amount"
      expr: SUM(line_amount)
    - name: "Average Line Amount"
      expr: AVG(line_amount)
    - name: "Total Proration Factor"
      expr: SUM(proration_factor)
    - name: "Average Proration Factor"
      expr: AVG(proration_factor)
    - name: "Total Tax Amount"
      expr: SUM(tax_amount)
    - name: "Average Tax Amount"
      expr: AVG(tax_amount)
    - name: "Total Total Line Amount"
      expr: SUM(total_line_amount)
    - name: "Average Total Line Amount"
      expr: AVG(total_line_amount)
    - name: "Total Unit Rate"
      expr: SUM(unit_rate)
    - name: "Average Unit Rate"
      expr: AVG(unit_rate)
    - name: "Total Usage Quantity"
      expr: SUM(usage_quantity)
    - name: "Average Usage Quantity"
      expr: AVG(usage_quantity)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`billing_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment business metrics"
  source: "`power_and_utilities`.`billing`.`payment`"
  dimensions:
    - name: "Allocation Method"
      expr: allocation_method
    - name: "Auto Pay Flag"
      expr: auto_pay_flag
    - name: "Bank Account Number Last Four"
      expr: bank_account_number_last_four
    - name: "Bank Routing Number"
      expr: bank_routing_number
    - name: "Batch Reference"
      expr: batch_reference
    - name: "Budget Billing Flag"
      expr: budget_billing_flag
    - name: "Channel"
      expr: channel
    - name: "Check Number"
      expr: check_number
    - name: "Cleared Timestamp"
      expr: cleared_timestamp
    - name: "Confirmation Number"
      expr: confirmation_number
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Credit Card Last Four"
      expr: credit_card_last_four
    - name: "Credit Card Type"
      expr: credit_card_type
    - name: "Currency Code"
      expr: currency_code
    - name: "Gl Account Code"
      expr: gl_account_code
    - name: "Gl Posting Date"
      expr: gl_posting_date
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment"
      expr: COUNT(DISTINCT payment_id)
    - name: "Total Amount"
      expr: SUM(amount)
    - name: "Average Amount"
      expr: AVG(amount)
    - name: "Total Applied Amount"
      expr: SUM(applied_amount)
    - name: "Average Applied Amount"
      expr: AVG(applied_amount)
    - name: "Total Nsf Fee Amount"
      expr: SUM(nsf_fee_amount)
    - name: "Average Nsf Fee Amount"
      expr: AVG(nsf_fee_amount)
    - name: "Total Unapplied Amount"
      expr: SUM(unapplied_amount)
    - name: "Average Unapplied Amount"
      expr: AVG(unapplied_amount)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`billing_payment_arrangement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Payment Arrangement business metrics"
  source: "`power_and_utilities`.`billing`.`payment_arrangement`"
  dimensions:
    - name: "Actual Completion Date"
      expr: actual_completion_date
    - name: "Approval Date"
      expr: approval_date
    - name: "Approved By User Code"
      expr: approved_by_user_code
    - name: "Arrangement End Date"
      expr: arrangement_end_date
    - name: "Arrangement Notes"
      expr: arrangement_notes
    - name: "Arrangement Number"
      expr: arrangement_number
    - name: "Arrangement Start Date"
      expr: arrangement_start_date
    - name: "Arrangement Status"
      expr: arrangement_status
    - name: "Arrangement Type"
      expr: arrangement_type
    - name: "Auto Pay Enrolled"
      expr: auto_pay_enrolled
    - name: "Broken Date"
      expr: broken_date
    - name: "Cancellation Reason"
      expr: cancellation_reason
    - name: "Cancelled Date"
      expr: cancelled_date
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Grace Period Days"
      expr: grace_period_days
    - name: "Installment Frequency"
      expr: installment_frequency
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Payment Arrangement"
      expr: COUNT(DISTINCT payment_arrangement_id)
    - name: "Total Down Payment Amount"
      expr: SUM(down_payment_amount)
    - name: "Average Down Payment Amount"
      expr: AVG(down_payment_amount)
    - name: "Total Installment Amount"
      expr: SUM(installment_amount)
    - name: "Average Installment Amount"
      expr: AVG(installment_amount)
    - name: "Total Interest Accrued"
      expr: SUM(interest_accrued)
    - name: "Average Interest Accrued"
      expr: AVG(interest_accrued)
    - name: "Total Interest Rate"
      expr: SUM(interest_rate)
    - name: "Average Interest Rate"
      expr: AVG(interest_rate)
    - name: "Total Remaining Balance"
      expr: SUM(remaining_balance)
    - name: "Average Remaining Balance"
      expr: AVG(remaining_balance)
    - name: "Total Total Deferred Amount"
      expr: SUM(total_deferred_amount)
    - name: "Average Total Deferred Amount"
      expr: AVG(total_deferred_amount)
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`billing_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Rate Schedule business metrics"
  source: "`power_and_utilities`.`billing`.`rate_schedule`"
  dimensions:
    - name: "Approval Date"
      expr: approval_date
    - name: "Commodity Type"
      expr: commodity_type
    - name: "Created Timestamp"
      expr: created_timestamp
    - name: "Currency Code"
      expr: currency_code
    - name: "Customer Class"
      expr: customer_class
    - name: "Demand Charge Uom"
      expr: demand_charge_uom
    - name: "Effective Date"
      expr: effective_date
    - name: "Eligibility Criteria"
      expr: eligibility_criteria
    - name: "Energy Rate Uom"
      expr: energy_rate_uom
    - name: "Expiration Date"
      expr: expiration_date
    - name: "Interruptible Flag"
      expr: interruptible_flag
    - name: "Last Modified Timestamp"
      expr: last_modified_timestamp
    - name: "Net Metering Eligible Flag"
      expr: net_metering_eligible_flag
    - name: "Rate Case Docket"
      expr: rate_case_docket
    - name: "Rate Code"
      expr: rate_code
    - name: "Rate Name"
      expr: rate_name
  measures:
    - name: "Row Count"
      expr: COUNT(1)
    - name: "Distinct Rate Schedule"
      expr: COUNT(DISTINCT rate_schedule_id)
    - name: "Total Base Energy Rate"
      expr: SUM(base_energy_rate)
    - name: "Average Base Energy Rate"
      expr: AVG(base_energy_rate)
    - name: "Total Customer Charge"
      expr: SUM(customer_charge)
    - name: "Average Customer Charge"
      expr: AVG(customer_charge)
    - name: "Total Demand Charge Rate"
      expr: SUM(demand_charge_rate)
    - name: "Average Demand Charge Rate"
      expr: AVG(demand_charge_rate)
    - name: "Total Minimum Charge"
      expr: SUM(minimum_charge)
    - name: "Average Minimum Charge"
      expr: AVG(minimum_charge)
$$;