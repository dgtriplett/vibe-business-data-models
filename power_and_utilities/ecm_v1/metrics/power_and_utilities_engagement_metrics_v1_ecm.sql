-- Metric views for domain: engagement | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`engagement_opportunity`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key opportunity pipeline metrics for sales leadership"
  source: "`power_and_utilities_v2`.`engagement`.`opportunity`"
  dimensions:
    - name: "opportunity_stage"
      expr: stage
      comment: "Current stage of the opportunity (e.g., Qualification, Proposal, Closed)"
  measures:
    - name: "opportunity_count"
      expr: COUNT(1)
      comment: "Number of opportunity records"
    - name: "total_opportunity_amount_usd"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Total estimated annual revenue across all opportunities"
    - name: "average_estimated_revenue_usd"
      expr: AVG(CAST(estimated_annual_revenue_usd AS DOUBLE))
      comment: "Average estimated annual revenue per opportunity"
    - name: "weighted_probability_revenue_usd"
      expr: SUM(CAST(estimated_annual_revenue_usd AS DOUBLE) * CAST(probability_of_close_pct AS DOUBLE) / 100.0)
      comment: "Revenue weighted by probability of close"
    - name: "average_probability_pct"
      expr: AVG(CAST(probability_of_close_pct AS DOUBLE))
      comment: "Average probability of close percentage"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`engagement_large_customer_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial exposure and revenue potential of large customer contracts"
  source: "`power_and_utilities_v2`.`engagement`.`large_customer_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of contract (e.g., Fixed, Variable)"
  measures:
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of large customer contracts"
    - name: "total_contract_value_usd"
      expr: SUM(CAST(contract_value AS DOUBLE))
      comment: "Aggregate contract value for large customers"
    - name: "average_contract_value_usd"
      expr: AVG(CAST(contract_value AS DOUBLE))
      comment: "Average contract value"
    - name: "total_credit_limit_usd"
      expr: SUM(CAST(credit_limit AS DOUBLE))
      comment: "Total credit limit across contracts"
    - name: "average_credit_limit_usd"
      expr: AVG(CAST(credit_limit AS DOUBLE))
      comment: "Average credit limit per contract"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`engagement_dsm_incentive_payment`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Incentive payment effectiveness and cost tracking for demand-side management programs"
  source: "`power_and_utilities_v2`.`engagement`.`dsm_incentive_payment`"
  dimensions:
    - name: "payment_status"
      expr: payment_status
      comment: "Current status of the payment (e.g., Paid, Pending)"
  measures:
    - name: "payment_count"
      expr: COUNT(1)
      comment: "Number of DSM incentive payments processed"
    - name: "total_gross_payment_usd"
      expr: SUM(CAST(amount_gross AS DOUBLE))
      comment: "Total gross DSM incentive payments"
    - name: "total_net_payment_usd"
      expr: SUM(CAST(amount_net AS DOUBLE))
      comment: "Total net DSM incentive payments after adjustments"
    - name: "total_fee_amount_usd"
      expr: SUM(CAST(fee_amount AS DOUBLE))
      comment: "Total fees associated with DSM incentive payments"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`engagement_energy_audit`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy audit outcomes that drive efficiency initiatives"
  source: "`power_and_utilities_v2`.`engagement`.`energy_audit`"
  dimensions:
    - name: "audit_status"
      expr: audit_status
      comment: "Current status of the audit (e.g., Completed, In Progress)"
  measures:
    - name: "audit_count"
      expr: COUNT(1)
      comment: "Number of energy audits performed"
    - name: "total_estimated_savings_usd"
      expr: SUM(CAST(estimated_energy_cost_savings_usd AS DOUBLE))
      comment: "Cumulative estimated energy cost savings from audits"
    - name: "average_estimated_savings_usd"
      expr: AVG(CAST(estimated_energy_cost_savings_usd AS DOUBLE))
      comment: "Average estimated savings per audit"
    - name: "total_demand_reduction_kw"
      expr: SUM(CAST(demand_reduction_kw AS DOUBLE))
      comment: "Total demand reduction identified across audits"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`engagement_satisfaction_survey`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Customer satisfaction insights for service quality monitoring"
  source: "`power_and_utilities_v2`.`engagement`.`satisfaction_survey`"
  dimensions:
    - name: "survey_type"
      expr: survey_type
      comment: "Classification of the survey (e.g., Post-Service, Annual)"
  measures:
    - name: "survey_response_count"
      expr: COUNT(1)
      comment: "Total number of satisfaction surveys collected"
    - name: "high_satisfaction_count"
      expr: SUM(CASE WHEN overall_satisfaction_score = 'High' THEN 1 ELSE 0 END)
      comment: "Count of surveys reporting high overall satisfaction"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`engagement_vpp_agreement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Virtual Power Plant agreement capacity and participation metrics"
  source: "`power_and_utilities_v2`.`engagement`.`vpp_agreement`"
  dimensions:
    - name: "agreement_status"
      expr: agreement_status
      comment: "Current status of the VPP agreement (e.g., Active, Terminated)"
  measures:
    - name: "vpp_agreement_count"
      expr: COUNT(1)
      comment: "Number of VPP agreements active"
    - name: "total_committed_capacity_kw"
      expr: SUM(CAST(total_committed_capacity_kw AS DOUBLE))
      comment: "Aggregate committed capacity across VPP agreements"
    - name: "average_capacity_per_agreement_kw"
      expr: AVG(CAST(total_committed_capacity_kw AS DOUBLE))
      comment: "Average committed capacity per VPP agreement"
$$;