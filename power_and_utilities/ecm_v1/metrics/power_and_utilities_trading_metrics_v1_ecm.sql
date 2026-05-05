-- Metric views for domain: trading | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`trading_trade`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Core trade activity KPIs for the utility's trading desk"
  source: "`power_and_utilities_v2`.`trading`.`trade`"
  dimensions:
    - name: "trade_date"
      expr: DATE_TRUNC('day', trade_date)
      comment: "Trade execution date (day level)"
    - name: "market_type"
      expr: market_type
      comment: "Market classification (e.g., day-ahead, real-time)"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity being traded (e.g., electricity, gas)"
    - name: "trade_status"
      expr: trade_status
      comment: "Current status of the trade"
    - name: "trade_type"
      expr: trade_type
      comment: "Buy or sell indicator"
    - name: "rto_iso_market"
      expr: rto_iso_market
      comment: "Regional transmission organization or ISO market"
    - name: "portfolio_id"
      expr: portfolio_id
      comment: "Portfolio identifier for the trade"
  measures:
    - name: "total_trade_value_usd"
      expr: SUM(CAST(total_contract_value AS DOUBLE))
      comment: "Total contract value of trades in USD"
    - name: "total_volume_mwh"
      expr: SUM(CAST(volume_quantity AS DOUBLE))
      comment: "Total traded volume in MWh"
    - name: "average_trade_price_usd"
      expr: AVG(CAST(price AS DOUBLE))
      comment: "Average price per unit across trades in USD"
    - name: "trade_count"
      expr: COUNT(1)
      comment: "Number of trade records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`trading_position`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Position‑level exposure and performance metrics"
  source: "`power_and_utilities_v2`.`trading`.`position`"
  dimensions:
    - name: "valuation_date"
      expr: DATE_TRUNC('day', valuation_date)
      comment: "Date of position valuation"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity of the position"
    - name: "market_id"
      expr: market_id
      comment: "Market identifier where the position is held"
    - name: "position_status"
      expr: position_status
      comment: "Operational status of the position"
    - name: "portfolio_id"
      expr: portfolio_id
      comment: "Portfolio to which the position belongs"
  measures:
    - name: "total_mark_to_market_usd"
      expr: SUM(CAST(mark_to_market_value AS DOUBLE))
      comment: "Aggregate mark‑to‑market value of positions in USD"
    - name: "total_unrealized_pnl_usd"
      expr: SUM(CAST(unrealized_pnl AS DOUBLE))
      comment: "Total unrealized profit & loss across positions in USD"
    - name: "average_market_price_usd"
      expr: AVG(CAST(market_price AS DOUBLE))
      comment: "Average market price observed for positions in USD"
    - name: "position_count"
      expr: COUNT(1)
      comment: "Number of position records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`trading_lmp_price`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "LMP pricing insights for market operations"
  source: "`power_and_utilities_v2`.`trading`.`lmp_price`"
  dimensions:
    - name: "operating_date"
      expr: DATE_TRUNC('day', operating_date)
      comment: "Date of LMP observation"
    - name: "pricing_zone"
      expr: pricing_zone
      comment: "Pricing zone or node identifier"
    - name: "commodity_type"
      expr: commodity_type
      comment: "Commodity type for the LMP"
    - name: "market_id"
      expr: market_id
      comment: "Market identifier for the LMP"
  measures:
    - name: "average_lmp_total_usd"
      expr: AVG(CAST(lmp_total AS DOUBLE))
      comment: "Average locational marginal price total across intervals in USD"
    - name: "total_congestion_component_usd"
      expr: SUM(CAST(congestion_component AS DOUBLE))
      comment: "Aggregate congestion component of LMP in USD"
    - name: "lmp_price_count"
      expr: COUNT(1)
      comment: "Number of LMP price records"
$$;