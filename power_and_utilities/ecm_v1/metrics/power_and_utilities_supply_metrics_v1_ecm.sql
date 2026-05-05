-- Metric views for domain: supply | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`supply_fuel_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key performance indicators for fuel receipt operations"
  source: "`power_and_utilities_v2`.`supply`.`fuel_receipt`"
  dimensions:
    - name: "fuel_type"
      expr: fuel_type
      comment: "Type of fuel received"
    - name: "primary_fuel_vendor_id"
      expr: primary_fuel_vendor_id
      comment: "Primary vendor supplying the fuel"
    - name: "plant_id"
      expr: plant_id
      comment: "Generation plant receiving the fuel"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency of the transaction"
    - name: "receipt_month"
      expr: DATE_TRUNC('month', receipt_timestamp)
      comment: "Month of receipt"
  measures:
    - name: "total_fuel_quantity"
      expr: SUM(CAST(quantity AS DOUBLE))
      comment: "Total quantity of fuel received (tons) across the period"
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_cost AS DOUBLE))
      comment: "Total monetary cost of fuel received"
    - name: "average_cost_per_unit"
      expr: AVG(CAST(cost_per_unit AS DOUBLE))
      comment: "Average cost per unit of fuel"
    - name: "average_ash_content_percent"
      expr: AVG(CAST(ash_content_percent AS DOUBLE))
      comment: "Average ash content percentage of received fuel"
    - name: "average_sulfur_content_percent"
      expr: AVG(CAST(sulfur_content_percent AS DOUBLE))
      comment: "Average sulfur content percentage of received fuel"
    - name: "receipt_count"
      expr: COUNT(1)
      comment: "Number of fuel receipt records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`supply_purchase_order`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Financial and volume KPIs for procurement activity"
  source: "`power_and_utilities_v2`.`supply`.`purchase_order`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor supplying the goods/services"
    - name: "plant_id"
      expr: plant_id
      comment: "Plant associated with the purchase order"
    - name: "order_status"
      expr: order_status
      comment: "Current status of the purchase order"
    - name: "order_month"
      expr: DATE_TRUNC('month', order_date)
      comment: "Month of the order"
  measures:
    - name: "total_order_amount"
      expr: SUM(CAST(total_amount AS DOUBLE))
      comment: "Total monetary value of purchase orders"
    - name: "average_order_amount"
      expr: AVG(CAST(total_amount AS DOUBLE))
      comment: "Average monetary value per purchase order"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount across purchase orders"
    - name: "order_count"
      expr: COUNT(1)
      comment: "Number of purchase order records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`supply_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Aggregated vendor performance indicators used for supplier management"
  source: "`power_and_utilities_v2`.`supply`.`vendor_performance`"
  dimensions:
    - name: "vendor_id"
      expr: vendor_id
      comment: "Vendor being evaluated"
    - name: "evaluation_month"
      expr: DATE_TRUNC('month', evaluation_period_start)
      comment: "Month of the evaluation period start"
  measures:
    - name: "average_overall_score"
      expr: AVG(CAST(overall_score AS DOUBLE))
      comment: "Average overall performance score for vendors"
    - name: "average_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on‑time delivery rate across evaluations"
    - name: "average_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate"
    - name: "average_quality_rejection_rate"
      expr: AVG(CAST(quality_rejection_rate AS DOUBLE))
      comment: "Average quality rejection rate"
    - name: "evaluation_count"
      expr: COUNT(1)
      comment: "Number of vendor performance evaluations"
$$;