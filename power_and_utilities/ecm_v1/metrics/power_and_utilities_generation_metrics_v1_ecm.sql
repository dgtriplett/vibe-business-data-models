-- Metric views for domain: generation | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`generation_energy_output`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key generation performance metrics derived from the energy_output fact table."
  source: "`power_and_utilities_v2`.`generation`.`energy_output`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Identifier of the generating plant."
    - name: "generating_unit_id"
      expr: generating_unit_id
      comment: "Identifier of the generating unit."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Primary fuel type of the unit (e.g., coal, gas, wind)."
    - name: "is_renewable"
      expr: is_renewable
      comment: "Flag indicating whether the generation is from a renewable source."
    - name: "record_month"
      expr: DATE_TRUNC('month', record_created_timestamp)
      comment: "Month of the record creation, used for time‑based analysis."
  measures:
    - name: "total_net_generation_mwh"
      expr: SUM(CAST(net_generation_mwh AS DOUBLE))
      comment: "Total net electricity generated in MWh across all plants and units."
    - name: "total_gross_generation_mwh"
      expr: SUM(CAST(gross_generation_mwh AS DOUBLE))
      comment: "Total gross electricity generated in MWh (before plant losses)."
    - name: "average_capacity_factor_percent"
      expr: AVG(CAST(capacity_factor_percent AS DOUBLE))
      comment: "Average capacity factor percentage, indicating utilization of nameplate capacity."
    - name: "renewable_net_generation_mwh"
      expr: SUM(CASE WHEN is_renewable THEN CAST(net_generation_mwh AS DOUBLE) ELSE 0 END)
      comment: "Net generation from renewable resources only."
    - name: "total_co2_emissions_tons"
      expr: SUM(CAST(emissions_co2_tons AS DOUBLE))
      comment: "Total CO2 emissions associated with the generated electricity."
    - name: "total_fuel_type_co2_emissions_tons"
      expr: SUM(CAST(emissions_co2_tons AS DOUBLE))
      comment: "Total CO2 emissions (numeric measure for BI to combine with fuel type dimension)."
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`generation_capacity_resource`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity resource commitments and revenue forecasts."
  source: "`power_and_utilities_v2`.`generation`.`capacity_resource`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant associated with the capacity resource."
    - name: "capacity_zone"
      expr: capacity_zone
      comment: "Geographic capacity zone."
    - name: "delivery_year"
      expr: delivery_year
      comment: "Fiscal year for which capacity is delivered."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type linked to the capacity resource."
    - name: "must_offer_obligation"
      expr: must_offer_obligation
      comment: "Indicates if the resource is subject to a must‑offer obligation."
    - name: "effective_month"
      expr: DATE_TRUNC('month', effective_date)
      comment: "Month of the effective date for the capacity contract."
  measures:
    - name: "total_cleared_capacity_mw"
      expr: SUM(CAST(cleared_capacity_mw AS DOUBLE))
      comment: "Total cleared capacity (MW) awarded to the utility."
    - name: "total_capacity_obligation_mw"
      expr: SUM(CAST(capacity_obligation_mw AS DOUBLE))
      comment: "Total capacity obligation (MW) the utility must meet."
    - name: "total_capacity_revenue_usd"
      expr: SUM(CAST(capacity_revenue_forecast_usd AS DOUBLE))
      comment: "Forecasted revenue from capacity products in USD."
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of capacity resource records."
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`generation_emissions_record`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Environmental emissions tracking per generating unit."
  source: "`power_and_utilities_v2`.`generation`.`emissions_record`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where emissions were measured."
    - name: "generating_unit_id"
      expr: generating_unit_id
      comment: "Generating unit identifier."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the unit."
    - name: "balancing_area_id"
      expr: balancing_area_id
      comment: "Balancing area identifier."
    - name: "certification_status"
      expr: certification_status
      comment: "Regulatory certification status."
    - name: "measurement_month"
      expr: DATE_TRUNC('month', measurement_timestamp)
      comment: "Month of the emissions measurement."
  measures:
    - name: "total_co2_emissions_tons"
      expr: SUM(CAST(co2_emissions_tons AS DOUBLE))
      comment: "Total CO2 emissions reported."
    - name: "total_nox_emissions_tons"
      expr: SUM(CAST(nox_emissions_tons AS DOUBLE))
      comment: "Total NOx emissions reported."
    - name: "total_so2_emissions_tons"
      expr: SUM(CAST(so2_emissions_tons AS DOUBLE))
      comment: "Total SO2 emissions reported."
    - name: "average_co2_rate_per_mwh"
      expr: AVG(CAST(co2_rate_per_mwh AS DOUBLE))
      comment: "Average CO2 emission rate per MWh generated."
    - name: "record_count"
      expr: COUNT(1)
      comment: "Number of emissions records."
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`generation_outage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outage impact metrics for generation assets."
  source: "`power_and_utilities_v2`.`generation`.`generation_outage`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant experiencing the outage."
    - name: "generating_unit_id"
      expr: generating_unit_id
      comment: "Unit affected by the outage."
    - name: "outage_type"
      expr: outage_type
      comment: "Classification of outage (forced, planned, etc.)."
    - name: "cause_category"
      expr: cause_category
      comment: "Root cause category of the outage."
    - name: "outage_month"
      expr: DATE_TRUNC('month', start_timestamp)
      comment: "Month when the outage started."
  measures:
    - name: "total_outage_duration_hours"
      expr: SUM(CAST(duration_hours AS DOUBLE))
      comment: "Cumulative outage duration in hours."
    - name: "outage_event_count"
      expr: COUNT(1)
      comment: "Number of outage events recorded."
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`generation_forecast`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Generation forecast accuracy and volume metrics."
  source: "`power_and_utilities_v2`.`generation`.`forecast`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant for which the forecast is made."
    - name: "generating_unit_id"
      expr: generating_unit_id
      comment: "Generating unit identifier."
    - name: "horizon_type"
      expr: horizon_type
      comment: "Forecast horizon (e.g., day-ahead, week-ahead)."
    - name: "forecast_status"
      expr: forecast_status
      comment: "Current status of the forecast (approved, provisional, etc.)."
    - name: "forecast_month"
      expr: DATE_TRUNC('month', period_start)
      comment: "Month of the forecast period start."
  measures:
    - name: "total_forecasted_net_generation_mwh"
      expr: SUM(CAST(forecasted_net_generation_mwh AS DOUBLE))
      comment: "Total forecasted net generation in MWh."
    - name: "average_forecast_error_percent"
      expr: AVG(CAST(error_percent AS DOUBLE))
      comment: "Average forecast error percentage across all forecasts."
    - name: "forecast_record_count"
      expr: COUNT(1)
      comment: "Number of forecast records."
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`generation_fuel_consumption`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel consumption and cost efficiency metrics."
  source: "`power_and_utilities_v2`.`generation`.`fuel_consumption`"
  dimensions:
    - name: "plant_id"
      expr: plant_id
      comment: "Plant where fuel was consumed."
    - name: "generating_unit_id"
      expr: generating_unit_id
      comment: "Generating unit identifier."
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel consumed."
    - name: "reporting_month"
      expr: DATE_TRUNC('month', reporting_period_start)
      comment: "Month of the reporting period."
  measures:
    - name: "total_fuel_energy_output_mwh"
      expr: SUM(CAST(energy_output_mwh AS DOUBLE))
      comment: "Total energy output attributed to fuel consumption."
    - name: "total_fuel_cost_usd"
      expr: SUM(CAST(total_fuel_cost AS DOUBLE))
      comment: "Total cost of fuel consumed in USD."
    - name: "average_heat_rate_btu_per_kwh"
      expr: AVG(CAST(heat_rate AS DOUBLE))
      comment: "Average heat rate (BTU per kWh) indicating fuel efficiency."
    - name: "fuel_consumption_record_count"
      expr: COUNT(1)
      comment: "Number of fuel consumption records."
$$;