-- Metric views for domain: market | Business: Power and Utilities | Version: 1 | Generated on: 2026-04-29 23:09:06

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`market_settlement_statement`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial settlement performance and cash flow metrics for wholesale market transactions"
  source: "`power_and_utilities`.`market`.`settlement_statement`"
  dimensions:
    - name: "billing_period_start_date"
      expr: billing_period_start_date
      comment: "Start date of the billing period for settlement"
    - name: "billing_period_end_date"
      expr: billing_period_end_date
      comment: "End date of the billing period for settlement"
    - name: "market_type"
      expr: market_type
      comment: "Type of market (day-ahead, real-time, capacity, ancillary)"
    - name: "statement_status"
      expr: statement_status
      comment: "Current status of the settlement statement"
    - name: "statement_run_type"
      expr: statement_run_type
      comment: "Type of settlement run (initial, resettlement, final)"
    - name: "is_disputed"
      expr: is_disputed
      comment: "Flag indicating whether the statement is under dispute"
    - name: "operating_month"
      expr: DATE_TRUNC('MONTH', operating_day)
      comment: "Operating month for time-series analysis"
    - name: "payment_month"
      expr: DATE_TRUNC('MONTH', payment_date)
      comment: "Payment month for cash flow analysis"
  measures:
    - name: "total_settlement_count"
      expr: COUNT(1)
      comment: "Total number of settlement statements"
    - name: "net_settlement_amount"
      expr: SUM(CAST(net_settlement_amount_usd AS DOUBLE))
      comment: "Total net settlement amount (charges minus credits) in USD"
    - name: "total_energy_charges"
      expr: SUM(CAST(energy_charges_usd AS DOUBLE))
      comment: "Total energy charges across all settlements"
    - name: "total_energy_credits"
      expr: SUM(CAST(energy_credits_usd AS DOUBLE))
      comment: "Total energy credits across all settlements"
    - name: "total_capacity_charges"
      expr: SUM(CAST(capacity_charges_usd AS DOUBLE))
      comment: "Total capacity charges across all settlements"
    - name: "total_capacity_credits"
      expr: SUM(CAST(capacity_credits_usd AS DOUBLE))
      comment: "Total capacity credits across all settlements"
    - name: "total_ancillary_charges"
      expr: SUM(CAST(ancillary_service_charges_usd AS DOUBLE))
      comment: "Total ancillary service charges"
    - name: "total_ancillary_credits"
      expr: SUM(CAST(ancillary_service_credits_usd AS DOUBLE))
      comment: "Total ancillary service credits"
    - name: "total_transmission_charges"
      expr: SUM(CAST(transmission_charges_usd AS DOUBLE))
      comment: "Total transmission charges"
    - name: "total_congestion_credits"
      expr: SUM(CAST(congestion_credits_usd AS DOUBLE))
      comment: "Total congestion credits received"
    - name: "total_dispute_amount"
      expr: SUM(CAST(dispute_amount_usd AS DOUBLE))
      comment: "Total amount under dispute across all statements"
    - name: "total_energy_volume_mwh"
      expr: SUM(CAST(total_energy_volume_mwh AS DOUBLE))
      comment: "Total energy volume settled in MWh"
    - name: "avg_weighted_lmp"
      expr: AVG(CAST(weighted_avg_lmp_usd_per_mwh AS DOUBLE))
      comment: "Average weighted LMP across settlements in USD per MWh"
    - name: "disputed_statement_count"
      expr: COUNT(CASE WHEN is_disputed = TRUE THEN 1 END)
      comment: "Count of statements currently under dispute"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`market_dispatch_award`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Generation dispatch and market clearing performance metrics"
  source: "`power_and_utilities`.`market`.`dispatch_award`"
  dimensions:
    - name: "operating_date"
      expr: operating_date
      comment: "Operating date for the dispatch award"
    - name: "market_type"
      expr: market_type
      comment: "Type of market (day-ahead, real-time)"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the dispatched resource"
    - name: "generation_technology"
      expr: generation_technology
      comment: "Generation technology type"
    - name: "is_renewable"
      expr: is_renewable
      comment: "Flag indicating renewable energy resource"
    - name: "is_reliability_dispatch"
      expr: is_reliability_dispatch
      comment: "Flag indicating reliability-driven dispatch"
    - name: "commitment_status"
      expr: commitment_status
      comment: "Commitment status of the dispatch award"
    - name: "award_status"
      expr: award_status
      comment: "Current status of the dispatch award"
    - name: "operating_month"
      expr: DATE_TRUNC('MONTH', operating_date)
      comment: "Operating month for time-series analysis"
  measures:
    - name: "total_dispatch_count"
      expr: COUNT(1)
      comment: "Total number of dispatch awards"
    - name: "total_scheduled_mw"
      expr: SUM(CAST(scheduled_mw AS DOUBLE))
      comment: "Total scheduled megawatts across all dispatch awards"
    - name: "total_ancillary_service_mw"
      expr: SUM(CAST(ancillary_service_mw AS DOUBLE))
      comment: "Total ancillary service megawatts dispatched"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount_usd AS DOUBLE))
      comment: "Total settlement amount for dispatch awards in USD"
    - name: "avg_lmp"
      expr: AVG(CAST(lmp_usd_per_mwh AS DOUBLE))
      comment: "Average locational marginal price in USD per MWh"
    - name: "avg_lmp_energy_component"
      expr: AVG(CAST(lmp_energy_component_usd_per_mwh AS DOUBLE))
      comment: "Average energy component of LMP"
    - name: "avg_lmp_congestion_component"
      expr: AVG(CAST(lmp_congestion_component_usd_per_mwh AS DOUBLE))
      comment: "Average congestion component of LMP"
    - name: "avg_lmp_loss_component"
      expr: AVG(CAST(lmp_loss_component_usd_per_mwh AS DOUBLE))
      comment: "Average loss component of LMP"
    - name: "avg_heat_rate"
      expr: AVG(CAST(heat_rate_btu_per_kwh AS DOUBLE))
      comment: "Average heat rate in BTU per kWh"
    - name: "avg_ghg_emissions_rate"
      expr: AVG(CAST(ghg_emissions_rate_lbs_per_mwh AS DOUBLE))
      comment: "Average GHG emissions rate in lbs per MWh"
    - name: "total_startup_cost"
      expr: SUM(CAST(startup_cost_usd AS DOUBLE))
      comment: "Total startup costs across all dispatch awards"
    - name: "total_no_load_cost"
      expr: SUM(CAST(no_load_cost_usd_per_hr AS DOUBLE))
      comment: "Total no-load costs"
    - name: "total_rec_quantity"
      expr: SUM(CAST(rec_quantity AS DOUBLE))
      comment: "Total renewable energy certificates quantity"
    - name: "reliability_dispatch_count"
      expr: COUNT(CASE WHEN is_reliability_dispatch = TRUE THEN 1 END)
      comment: "Count of reliability-driven dispatches"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`market_ppa_contract`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Power purchase agreement portfolio and procurement performance metrics"
  source: "`power_and_utilities`.`market`.`ppa_contract`"
  dimensions:
    - name: "contract_status"
      expr: contract_status
      comment: "Current status of the PPA contract"
    - name: "contract_type"
      expr: contract_type
      comment: "Type of PPA contract"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the contracted resource"
    - name: "is_renewable"
      expr: is_renewable
      comment: "Flag indicating renewable energy contract"
    - name: "rec_bundled"
      expr: rec_bundled
      comment: "Flag indicating whether RECs are bundled with energy"
    - name: "capacity_market_eligible"
      expr: capacity_market_eligible
      comment: "Flag indicating capacity market eligibility"
    - name: "state_jurisdiction"
      expr: state_jurisdiction
      comment: "State jurisdiction for regulatory purposes"
    - name: "ferc_filing_status"
      expr: ferc_filing_status
      comment: "FERC filing status of the contract"
    - name: "effective_year"
      expr: YEAR(effective_date)
      comment: "Year the contract became effective"
    - name: "expiration_year"
      expr: YEAR(expiration_date)
      comment: "Year the contract expires"
  measures:
    - name: "total_contract_count"
      expr: COUNT(1)
      comment: "Total number of PPA contracts"
    - name: "total_contracted_capacity_mw"
      expr: SUM(CAST(contracted_capacity_mw AS DOUBLE))
      comment: "Total contracted capacity in megawatts"
    - name: "total_contracted_energy_mwh"
      expr: SUM(CAST(contracted_energy_mwh AS DOUBLE))
      comment: "Total contracted energy in megawatt-hours"
    - name: "total_annual_energy_mwh"
      expr: SUM(CAST(annual_energy_mwh AS DOUBLE))
      comment: "Total annual energy commitment across all contracts"
    - name: "avg_energy_price_per_mwh"
      expr: AVG(CAST(energy_price_per_mwh AS DOUBLE))
      comment: "Average energy price in USD per MWh"
    - name: "avg_capacity_price_per_mw_month"
      expr: AVG(CAST(capacity_price_per_mw_month AS DOUBLE))
      comment: "Average capacity price in USD per MW-month"
    - name: "avg_contract_term_years"
      expr: AVG(CAST(contract_term_years AS DOUBLE))
      comment: "Average contract term in years"
    - name: "total_rec_quantity_annual"
      expr: SUM(CAST(rec_quantity_annual AS DOUBLE))
      comment: "Total annual renewable energy certificates quantity"
    - name: "total_minimum_take_mwh"
      expr: SUM(CAST(minimum_take_mwh AS DOUBLE))
      comment: "Total minimum take-or-pay energy commitment"
    - name: "total_credit_support_amount"
      expr: SUM(CAST(credit_support_amount AS DOUBLE))
      comment: "Total credit support amount across all contracts"
    - name: "renewable_contract_count"
      expr: COUNT(CASE WHEN is_renewable = TRUE THEN 1 END)
      comment: "Count of renewable energy contracts"
    - name: "bundled_rec_contract_count"
      expr: COUNT(CASE WHEN rec_bundled = TRUE THEN 1 END)
      comment: "Count of contracts with bundled RECs"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`market_capacity_obligation`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity market obligation and resource adequacy performance metrics"
  source: "`power_and_utilities`.`market`.`capacity_obligation`"
  dimensions:
    - name: "delivery_year"
      expr: delivery_year
      comment: "Delivery year for the capacity obligation"
    - name: "obligation_status"
      expr: obligation_status
      comment: "Current status of the capacity obligation"
    - name: "obligation_type"
      expr: obligation_type
      comment: "Type of capacity obligation"
    - name: "resource_type"
      expr: resource_type
      comment: "Type of capacity resource"
    - name: "auction_type"
      expr: auction_type
      comment: "Type of capacity auction"
    - name: "compliance_status"
      expr: compliance_status
      comment: "Compliance status of the obligation"
    - name: "is_demand_response"
      expr: is_demand_response
      comment: "Flag indicating demand response resource"
    - name: "rec_eligible"
      expr: rec_eligible
      comment: "Flag indicating REC eligibility"
    - name: "locational_deliverability_area"
      expr: locational_deliverability_area
      comment: "Locational deliverability area for the obligation"
    - name: "obligation_start_month"
      expr: DATE_TRUNC('MONTH', obligation_start_date)
      comment: "Start month of the obligation period"
  measures:
    - name: "total_obligation_count"
      expr: COUNT(1)
      comment: "Total number of capacity obligations"
    - name: "total_committed_mw"
      expr: SUM(CAST(committed_mw AS DOUBLE))
      comment: "Total committed capacity in megawatts"
    - name: "total_installed_capacity_mw"
      expr: SUM(CAST(installed_capacity_mw AS DOUBLE))
      comment: "Total installed capacity in megawatts"
    - name: "total_unforced_capacity_mw"
      expr: SUM(CAST(unforced_capacity_mw AS DOUBLE))
      comment: "Total unforced capacity (UCAP) in megawatts"
    - name: "total_capacity_revenue"
      expr: SUM(CAST(total_capacity_revenue AS DOUBLE))
      comment: "Total capacity revenue across all obligations"
    - name: "avg_clearing_price_per_mw_day"
      expr: AVG(CAST(clearing_price_per_mw_day AS DOUBLE))
      comment: "Average clearing price in USD per MW-day"
    - name: "avg_performance_test_result_mw"
      expr: AVG(CAST(performance_test_result_mw AS DOUBLE))
      comment: "Average performance test result in megawatts"
    - name: "avg_eford_rate"
      expr: AVG(CAST(eford_rate AS DOUBLE))
      comment: "Average equivalent forced outage rate"
    - name: "total_non_performance_charge"
      expr: SUM(CAST(non_performance_charge_amount AS DOUBLE))
      comment: "Total non-performance charge amount"
    - name: "avg_planning_reserve_margin_pct"
      expr: AVG(CAST(planning_reserve_margin_pct AS DOUBLE))
      comment: "Average planning reserve margin percentage"
    - name: "demand_response_obligation_count"
      expr: COUNT(CASE WHEN is_demand_response = TRUE THEN 1 END)
      comment: "Count of demand response capacity obligations"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`market_rec_transaction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Renewable energy certificate trading and compliance performance metrics"
  source: "`power_and_utilities`.`market`.`rec_transaction`"
  dimensions:
    - name: "transaction_type"
      expr: transaction_type
      comment: "Type of REC transaction (purchase, sale, retirement)"
    - name: "transaction_status"
      expr: transaction_status
      comment: "Current status of the transaction"
    - name: "compliance_program"
      expr: compliance_program
      comment: "Compliance program for which RECs are used"
    - name: "energy_source_type"
      expr: energy_source_type
      comment: "Energy source type of the RECs"
    - name: "vintage_year"
      expr: vintage_year
      comment: "Vintage year of the RECs"
    - name: "is_bundled"
      expr: is_bundled
      comment: "Flag indicating bundled RECs with energy"
    - name: "is_eligible_for_rps"
      expr: is_eligible_for_rps
      comment: "Flag indicating RPS eligibility"
    - name: "generation_facility_state"
      expr: generation_facility_state
      comment: "State where generation facility is located"
    - name: "transaction_month"
      expr: DATE_TRUNC('MONTH', transaction_date)
      comment: "Month of the transaction"
    - name: "retirement_month"
      expr: DATE_TRUNC('MONTH', retirement_date)
      comment: "Month of REC retirement"
  measures:
    - name: "total_transaction_count"
      expr: COUNT(1)
      comment: "Total number of REC transactions"
    - name: "total_rec_quantity_mwh"
      expr: SUM(CAST(quantity_mwh AS DOUBLE))
      comment: "Total REC quantity in megawatt-hours"
    - name: "total_gross_amount"
      expr: SUM(CAST(gross_amount AS DOUBLE))
      comment: "Total gross transaction amount"
    - name: "total_net_amount"
      expr: SUM(CAST(net_amount AS DOUBLE))
      comment: "Total net transaction amount after fees"
    - name: "total_transaction_fee"
      expr: SUM(CAST(transaction_fee AS DOUBLE))
      comment: "Total transaction fees paid"
    - name: "avg_price_per_rec"
      expr: AVG(CAST(price_per_rec AS DOUBLE))
      comment: "Average price per REC in USD"
    - name: "bundled_transaction_count"
      expr: COUNT(CASE WHEN is_bundled = TRUE THEN 1 END)
      comment: "Count of bundled REC transactions"
    - name: "rps_eligible_transaction_count"
      expr: COUNT(CASE WHEN is_eligible_for_rps = TRUE THEN 1 END)
      comment: "Count of RPS-eligible transactions"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`market_lmp_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Locational marginal price volatility and market efficiency metrics"
  source: "`power_and_utilities`.`market`.`lmp_price`"
  dimensions:
    - name: "market_day"
      expr: market_day
      comment: "Market day for the LMP price"
    - name: "operating_date"
      expr: operating_date
      comment: "Operating date for the LMP price"
    - name: "market_type"
      expr: market_type
      comment: "Type of market (day-ahead, real-time)"
    - name: "peak_period_type"
      expr: peak_period_type
      comment: "Peak period classification (on-peak, off-peak)"
    - name: "season_code"
      expr: season_code
      comment: "Season code for seasonal analysis"
    - name: "is_holiday"
      expr: is_holiday
      comment: "Flag indicating holiday pricing"
    - name: "is_price_cap_applied"
      expr: is_price_cap_applied
      comment: "Flag indicating price cap application"
    - name: "is_binding_constraint"
      expr: is_binding_constraint
      comment: "Flag indicating binding transmission constraint"
    - name: "congestion_direction"
      expr: congestion_direction
      comment: "Direction of congestion"
    - name: "price_status"
      expr: price_status
      comment: "Status of the price data"
    - name: "market_month"
      expr: DATE_TRUNC('MONTH', market_day)
      comment: "Market month for time-series analysis"
  measures:
    - name: "total_price_observation_count"
      expr: COUNT(1)
      comment: "Total number of LMP price observations"
    - name: "avg_lmp_total"
      expr: AVG(CAST(lmp_total_per_mwh AS DOUBLE))
      comment: "Average total LMP in USD per MWh"
    - name: "avg_energy_component"
      expr: AVG(CAST(energy_component_per_mwh AS DOUBLE))
      comment: "Average energy component of LMP"
    - name: "avg_congestion_component"
      expr: AVG(CAST(congestion_component_per_mwh AS DOUBLE))
      comment: "Average congestion component of LMP"
    - name: "avg_loss_component"
      expr: AVG(CAST(loss_component_per_mwh AS DOUBLE))
      comment: "Average loss component of LMP"
    - name: "max_lmp_total"
      expr: MAX(CAST(lmp_total_per_mwh AS DOUBLE))
      comment: "Maximum total LMP observed"
    - name: "min_lmp_total"
      expr: MIN(CAST(lmp_total_per_mwh AS DOUBLE))
      comment: "Minimum total LMP observed"
    - name: "binding_constraint_count"
      expr: COUNT(CASE WHEN is_binding_constraint = TRUE THEN 1 END)
      comment: "Count of intervals with binding transmission constraints"
    - name: "price_cap_applied_count"
      expr: COUNT(CASE WHEN is_price_cap_applied = TRUE THEN 1 END)
      comment: "Count of intervals where price cap was applied"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`market_energy_bid`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Energy market bidding strategy and clearing performance metrics"
  source: "`power_and_utilities`.`market`.`energy_bid`"
  dimensions:
    - name: "operating_date"
      expr: operating_date
      comment: "Operating date for the energy bid"
    - name: "market_type"
      expr: market_type
      comment: "Type of market (day-ahead, real-time)"
    - name: "bid_status"
      expr: bid_status
      comment: "Current status of the bid"
    - name: "bid_type"
      expr: bid_type
      comment: "Type of bid submitted"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type of the bidding resource"
    - name: "must_run_flag"
      expr: must_run_flag
      comment: "Flag indicating must-run status"
    - name: "self_schedule_flag"
      expr: self_schedule_flag
      comment: "Flag indicating self-scheduled bid"
    - name: "rec_eligible_flag"
      expr: rec_eligible_flag
      comment: "Flag indicating REC eligibility"
    - name: "operating_month"
      expr: DATE_TRUNC('MONTH', operating_date)
      comment: "Operating month for time-series analysis"
  measures:
    - name: "total_bid_count"
      expr: COUNT(1)
      comment: "Total number of energy bids submitted"
    - name: "total_bid_quantity_mw"
      expr: SUM(CAST(bid_quantity_mw AS DOUBLE))
      comment: "Total bid quantity in megawatts"
    - name: "total_cleared_quantity_mw"
      expr: SUM(CAST(cleared_quantity_mw AS DOUBLE))
      comment: "Total cleared quantity in megawatts"
    - name: "avg_bid_price_per_mwh"
      expr: AVG(CAST(bid_price_per_mwh AS DOUBLE))
      comment: "Average bid price in USD per MWh"
    - name: "avg_cleared_price_per_mwh"
      expr: AVG(CAST(cleared_price_per_mwh AS DOUBLE))
      comment: "Average cleared price in USD per MWh"
    - name: "total_settlement_amount"
      expr: SUM(CAST(settlement_amount_usd AS DOUBLE))
      comment: "Total settlement amount for cleared bids"
    - name: "total_startup_cost"
      expr: SUM(CAST(startup_cost_usd AS DOUBLE))
      comment: "Total startup costs bid"
    - name: "total_no_load_cost"
      expr: SUM(CAST(no_load_cost_usd_per_hr AS DOUBLE))
      comment: "Total no-load costs bid"
    - name: "avg_maximum_capacity_mw"
      expr: AVG(CAST(maximum_capacity_mw AS DOUBLE))
      comment: "Average maximum capacity bid"
    - name: "avg_minimum_load_mw"
      expr: AVG(CAST(minimum_load_mw AS DOUBLE))
      comment: "Average minimum load bid"
    - name: "must_run_bid_count"
      expr: COUNT(CASE WHEN must_run_flag = TRUE THEN 1 END)
      comment: "Count of must-run bids"
    - name: "self_scheduled_bid_count"
      expr: COUNT(CASE WHEN self_schedule_flag = TRUE THEN 1 END)
      comment: "Count of self-scheduled bids"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`market_capacity_market_auction`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Capacity market auction clearing and procurement performance metrics"
  source: "`power_and_utilities`.`market`.`capacity_market_auction`"
  dimensions:
    - name: "delivery_year"
      expr: delivery_year
      comment: "Delivery year for the capacity auction"
    - name: "auction_status"
      expr: auction_status
      comment: "Current status of the auction"
    - name: "auction_type"
      expr: auction_type
      comment: "Type of capacity auction"
    - name: "capacity_performance_product_flag"
      expr: capacity_performance_product_flag
      comment: "Flag indicating capacity performance product"
    - name: "minimum_offer_price_rule_applied"
      expr: minimum_offer_price_rule_applied
      comment: "Flag indicating MOPR application"
    - name: "variable_resource_requirement_curve_applied"
      expr: variable_resource_requirement_curve_applied
      comment: "Flag indicating VRR curve application"
    - name: "auction_open_month"
      expr: DATE_TRUNC('MONTH', auction_open_timestamp)
      comment: "Month when auction opened"
  measures:
    - name: "total_auction_count"
      expr: COUNT(1)
      comment: "Total number of capacity auctions"
    - name: "avg_clearing_price_per_mw_day"
      expr: AVG(CAST(clearing_price_usd_per_mw_day AS DOUBLE))
      comment: "Average clearing price in USD per MW-day"
    - name: "total_capacity_procured_mw"
      expr: SUM(CAST(total_capacity_procured_mw AS DOUBLE))
      comment: "Total capacity procured in megawatts"
    - name: "avg_reliability_requirement_mw"
      expr: AVG(CAST(reliability_requirement_mw AS DOUBLE))
      comment: "Average reliability requirement in megawatts"
    - name: "avg_net_cone"
      expr: AVG(CAST(net_cost_of_new_entry_usd_per_mw_day AS DOUBLE))
      comment: "Average net cost of new entry in USD per MW-day"
    - name: "avg_planning_reserve_margin_pct"
      expr: AVG(CAST(planning_reserve_margin_percent AS DOUBLE))
      comment: "Average planning reserve margin percentage"
$$;