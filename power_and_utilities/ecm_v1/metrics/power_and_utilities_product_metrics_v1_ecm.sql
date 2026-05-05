-- Metric views for domain: product | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`product_ee_measure`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for energy efficiency measures, supporting sustainability and incentive analysis"
  source: "`power_and_utilities_v2`.`product`.`ee_measure`"
  dimensions:
    - name: "ee_measure_category"
      expr: ee_measure_category
      comment: "Category of the EE measure (e.g., lighting, HVAC)"
  measures:
    - name: "total_estimated_annual_energy_savings_kwh"
      expr: SUM(CAST(estimated_annual_energy_savings_kwh AS DOUBLE))
      comment: "Total estimated annual energy savings (kWh) across all EE measures"
    - name: "avg_incentive_amount"
      expr: AVG(CAST(incentive_amount AS DOUBLE))
      comment: "Average incentive amount offered per EE measure"
    - name: "measure_count"
      expr: COUNT(1)
      comment: "Number of EE measures recorded"
    - name: "pilot_measure_count"
      expr: SUM(CASE WHEN is_pilot THEN 1 ELSE 0 END)
      comment: "Count of EE measures that are designated as pilot programs"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`product_program`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic metrics for product programs to monitor budget, enrollment and load reduction goals"
  source: "`power_and_utilities_v2`.`product`.`product_program`"
  dimensions:
    - name: "program_category"
      expr: program_category
      comment: "High‑level category of the program (e.g., demand response, rebate)"
  measures:
    - name: "total_budget_amount"
      expr: SUM(CAST(budget_amount AS DOUBLE))
      comment: "Total budget allocated to product programs"
    - name: "avg_load_reduction_target_kw"
      expr: AVG(CAST(load_reduction_target_kw AS DOUBLE))
      comment: "Average load reduction target (kW) per program"
    - name: "total_current_enrollment"
      expr: SUM(CAST(current_enrollment AS DOUBLE))
      comment: "Aggregate current enrollment across programs"
    - name: "total_enrollment_capacity"
      expr: SUM(CAST(enrollment_capacity AS DOUBLE))
      comment: "Aggregate enrollment capacity across programs"
    - name: "program_count"
      expr: COUNT(1)
      comment: "Number of product programs"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`product_service_plan`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Metrics to evaluate environmental performance and offering breadth of service plans"
  source: "`power_and_utilities_v2`.`product`.`service_plan`"
  dimensions:
    - name: "plan_category"
      expr: plan_category
      comment: "Category of the service plan (e.g., residential, commercial)"
  measures:
    - name: "avg_carbon_intensity"
      expr: AVG(CAST(carbon_intensity AS DOUBLE))
      comment: "Average carbon intensity (gCO2/kWh) across service plans"
    - name: "avg_renewable_energy_percentage"
      expr: AVG(CAST(renewable_energy_percentage AS DOUBLE))
      comment: "Average renewable energy share (%) in service plans"
    - name: "plan_count"
      expr: COUNT(1)
      comment: "Number of distinct service plans"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`product_special_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key financial and consumption metrics for special contracts to support risk and revenue analysis"
  source: "`power_and_utilities_v2`.`product`.`special_contract`"
  dimensions:
    - name: "contract_type"
      expr: contract_type
      comment: "Type of special contract (e.g., PPA, capacity)"
  measures:
    - name: "total_annual_consumption_max_mwh"
      expr: SUM(CAST(annual_consumption_max_mwh AS DOUBLE))
      comment: "Total maximum annual consumption (MWh) across special contracts"
    - name: "avg_demand_charge_rate"
      expr: AVG(CAST(demand_charge_rate AS DOUBLE))
      comment: "Average demand charge rate ($/kW) for special contracts"
    - name: "contract_count"
      expr: COUNT(1)
      comment: "Number of special contracts"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`product_rate_schedule`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial metrics for rate schedules to monitor pricing and demand charge exposure"
  source: "`power_and_utilities_v2`.`product`.`rate_schedule`"
  dimensions:
    - name: "rate_category"
      expr: rate_category
      comment: "Category of the rate schedule (e.g., residential, commercial)"
  measures:
    - name: "total_demand_charge"
      expr: SUM(CAST(demand_charge AS DOUBLE))
      comment: "Total demand charge amount across rate schedules"
    - name: "avg_price_per_unit"
      expr: AVG(CAST(price_per_unit AS DOUBLE))
      comment: "Average price per unit ($) across rate schedules"
    - name: "rate_schedule_count"
      expr: COUNT(1)
      comment: "Number of rate schedules"
$$;