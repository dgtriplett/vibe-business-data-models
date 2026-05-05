-- Metric views for domain: supply | Business: Power and Utilities | Version: 1 | Generated on: 2026-04-29 23:09:06

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`supply_procurement_spend`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Strategic procurement spend metrics tracking total spend, order velocity, and supplier concentration for executive spend management and sourcing decisions"
  source: "`power_and_utilities`.`supply`.`purchase_order`"
  dimensions:
    - name: "po_fiscal_year"
      expr: YEAR(po_date)
      comment: "Fiscal year of purchase order for annual spend trending"
    - name: "po_fiscal_quarter"
      expr: CONCAT('Q', QUARTER(po_date))
      comment: "Fiscal quarter for quarterly spend analysis"
    - name: "po_fiscal_month"
      expr: DATE_TRUNC('MONTH', po_date)
      comment: "Month of purchase order for monthly spend trending"
    - name: "po_status"
      expr: po_status
      comment: "Purchase order status for pipeline and completion analysis"
    - name: "po_type"
      expr: po_type
      comment: "Purchase order type for spend categorization"
    - name: "material_group"
      expr: material_group
      comment: "Material group for commodity spend analysis"
    - name: "purchasing_organization"
      expr: purchasing_organization
      comment: "Purchasing organization for decentralized spend governance"
    - name: "purchasing_group"
      expr: purchasing_group
      comment: "Purchasing group for buyer performance and workload analysis"
    - name: "priority_code"
      expr: priority_code
      comment: "Priority code for urgent vs standard procurement analysis"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity spend consolidation"
  measures:
    - name: "total_po_spend"
      expr: SUM(CAST(total_po_value AS DOUBLE))
      comment: "Total purchase order spend - primary KPI for procurement budget management and supplier spend analysis"
    - name: "total_po_spend_with_tax"
      expr: SUM(CAST(total_po_value_with_tax AS DOUBLE))
      comment: "Total purchase order spend including tax for cash flow and budget planning"
    - name: "total_freight_cost"
      expr: SUM(CAST(freight_amount AS DOUBLE))
      comment: "Total freight costs for logistics efficiency and supplier negotiation"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for tax planning and compliance reporting"
    - name: "po_count"
      expr: COUNT(DISTINCT purchase_order_id)
      comment: "Number of distinct purchase orders for procurement velocity and workload analysis"
    - name: "avg_po_value"
      expr: AVG(CAST(total_po_value AS DOUBLE))
      comment: "Average purchase order value for spend consolidation and small-order reduction initiatives"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors for supplier base rationalization and concentration risk"
    - name: "freight_as_pct_of_spend"
      expr: ROUND(100.0 * SUM(CAST(freight_amount AS DOUBLE)) / NULLIF(SUM(CAST(total_po_value AS DOUBLE)), 0), 2)
      comment: "Freight cost as percentage of total spend for logistics efficiency benchmarking"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`supply_inventory_health`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Inventory health and working capital metrics tracking stock levels, turnover, and stockout risk for supply chain optimization and cash management"
  source: "`power_and_utilities`.`supply`.`inventory_stock`"
  dimensions:
    - name: "warehouse_id"
      expr: warehouse_id
      comment: "Warehouse identifier for location-specific inventory analysis"
    - name: "plant_code"
      expr: plant_code
      comment: "Plant code for facility-level inventory management"
    - name: "storage_location_code"
      expr: storage_location_code
      comment: "Storage location for granular inventory positioning"
    - name: "abc_classification"
      expr: abc_classification
      comment: "ABC classification for prioritized inventory management"
    - name: "stock_status"
      expr: stock_status
      comment: "Stock status for availability and quality analysis"
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type for inventory category analysis"
    - name: "procurement_type"
      expr: procurement_type
      comment: "Procurement type for sourcing strategy analysis"
    - name: "reorder_point_breach_flag"
      expr: reorder_point_breach_flag
      comment: "Reorder point breach indicator for stockout risk monitoring"
    - name: "safety_stock_breach_flag"
      expr: safety_stock_breach_flag
      comment: "Safety stock breach indicator for critical shortage alerts"
    - name: "last_activity_month"
      expr: DATE_TRUNC('MONTH', last_goods_receipt_date)
      comment: "Month of last goods receipt for slow-moving inventory identification"
  measures:
    - name: "total_inventory_value"
      expr: SUM(CAST(total_inventory_valuation_amount AS DOUBLE))
      comment: "Total inventory valuation for working capital management and balance sheet reporting"
    - name: "unrestricted_stock_quantity"
      expr: SUM(CAST(unrestricted_stock_quantity AS DOUBLE))
      comment: "Total unrestricted stock quantity available for operations"
    - name: "blocked_stock_quantity"
      expr: SUM(CAST(blocked_stock_quantity AS DOUBLE))
      comment: "Total blocked stock quantity for quality and obsolescence management"
    - name: "reserved_stock_quantity"
      expr: SUM(CAST(reserved_quantity AS DOUBLE))
      comment: "Total reserved stock quantity for demand fulfillment visibility"
    - name: "in_transit_stock_quantity"
      expr: SUM(CAST(in_transit_stock_quantity AS DOUBLE))
      comment: "Total in-transit stock quantity for supply chain visibility"
    - name: "quality_inspection_stock_quantity"
      expr: SUM(CAST(quality_inspection_stock_quantity AS DOUBLE))
      comment: "Total stock in quality inspection for quality process efficiency"
    - name: "avg_moving_average_cost"
      expr: AVG(CAST(moving_average_cost_per_unit AS DOUBLE))
      comment: "Average moving average cost per unit for cost trending and variance analysis"
    - name: "reorder_point_breach_count"
      expr: SUM(CASE WHEN reorder_point_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of materials breaching reorder point for replenishment urgency"
    - name: "safety_stock_breach_count"
      expr: SUM(CASE WHEN safety_stock_breach_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of materials breaching safety stock for critical shortage risk"
    - name: "unique_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of unique materials in inventory for SKU rationalization"
    - name: "blocked_stock_pct"
      expr: ROUND(100.0 * SUM(CAST(blocked_stock_quantity AS DOUBLE)) / NULLIF(SUM(CAST(unrestricted_stock_quantity AS DOUBLE) + CAST(blocked_stock_quantity AS DOUBLE)), 0), 2)
      comment: "Blocked stock as percentage of total stock for quality and obsolescence KPI"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`supply_vendor_performance`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor performance scorecard metrics tracking delivery, quality, safety, and compliance for supplier management and sourcing decisions"
  source: "`power_and_utilities`.`supply`.`vendor_performance`"
  dimensions:
    - name: "evaluation_year"
      expr: YEAR(evaluation_date)
      comment: "Year of evaluation for annual vendor review cycles"
    - name: "evaluation_quarter"
      expr: CONCAT('Q', QUARTER(evaluation_date))
      comment: "Quarter of evaluation for quarterly business reviews"
    - name: "evaluation_type"
      expr: evaluation_type
      comment: "Evaluation type for performance review categorization"
    - name: "evaluation_status"
      expr: evaluation_status
      comment: "Evaluation status for review completion tracking"
    - name: "preferred_vendor_list_eligible_flag"
      expr: preferred_vendor_list_eligible_flag
      comment: "Preferred vendor eligibility for strategic sourcing decisions"
    - name: "corrective_action_plan_required_flag"
      expr: corrective_action_plan_required_flag
      comment: "Corrective action requirement for vendor improvement tracking"
    - name: "corrective_action_plan_status"
      expr: corrective_action_plan_status
      comment: "Corrective action status for remediation progress monitoring"
    - name: "contract_renewal_recommendation"
      expr: contract_renewal_recommendation
      comment: "Contract renewal recommendation for sourcing strategy decisions"
  measures:
    - name: "avg_overall_performance_rating"
      expr: AVG(CAST(overall_performance_rating AS DOUBLE))
      comment: "Average overall vendor performance rating for supplier scorecard and strategic sourcing"
    - name: "avg_on_time_delivery_rate"
      expr: AVG(CAST(on_time_delivery_rate AS DOUBLE))
      comment: "Average on-time delivery rate for supply chain reliability assessment"
    - name: "avg_invoice_accuracy_rate"
      expr: AVG(CAST(invoice_accuracy_rate AS DOUBLE))
      comment: "Average invoice accuracy rate for accounts payable efficiency"
    - name: "avg_material_rejection_rate"
      expr: AVG(CAST(material_rejection_rate AS DOUBLE))
      comment: "Average material rejection rate for quality performance tracking"
    - name: "avg_safety_compliance_score"
      expr: AVG(CAST(safety_compliance_score AS DOUBLE))
      comment: "Average safety compliance score for contractor safety management"
    - name: "avg_osha_recordable_incident_rate"
      expr: AVG(CAST(osha_recordable_incident_rate AS DOUBLE))
      comment: "Average OSHA recordable incident rate for safety benchmarking"
    - name: "avg_emr_score"
      expr: AVG(CAST(emr_score AS DOUBLE))
      comment: "Average experience modification rate for insurance and risk assessment"
    - name: "total_evaluated_spend"
      expr: SUM(CAST(total_spend_amount AS DOUBLE))
      comment: "Total spend evaluated for weighted performance analysis"
    - name: "vendor_evaluation_count"
      expr: COUNT(DISTINCT vendor_performance_id)
      comment: "Number of vendor evaluations for review coverage tracking"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors evaluated for supplier base management"
    - name: "preferred_vendor_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN preferred_vendor_list_eligible_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT vendor_performance_id), 0), 2)
      comment: "Percentage of evaluations resulting in preferred vendor status for sourcing quality"
    - name: "corrective_action_required_pct"
      expr: ROUND(100.0 * SUM(CASE WHEN corrective_action_plan_required_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT vendor_performance_id), 0), 2)
      comment: "Percentage of evaluations requiring corrective action for vendor risk management"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`supply_fuel_delivery`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Fuel delivery and quality metrics tracking fuel costs, BTU content, and environmental compliance for generation cost management and regulatory reporting"
  source: "`power_and_utilities`.`supply`.`fuel_delivery`"
  dimensions:
    - name: "delivery_year"
      expr: YEAR(delivery_date)
      comment: "Year of fuel delivery for annual fuel cost trending"
    - name: "delivery_quarter"
      expr: CONCAT('Q', QUARTER(delivery_date))
      comment: "Quarter of fuel delivery for seasonal fuel cost analysis"
    - name: "delivery_month"
      expr: DATE_TRUNC('MONTH', delivery_date)
      comment: "Month of fuel delivery for monthly fuel cost tracking"
    - name: "fuel_type"
      expr: fuel_type
      comment: "Fuel type for generation fuel mix and cost analysis"
    - name: "delivery_status"
      expr: delivery_status
      comment: "Delivery status for fuel supply chain reliability"
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Inspection outcome for fuel quality compliance"
    - name: "environmental_compliance_flag"
      expr: environmental_compliance_flag
      comment: "Environmental compliance indicator for regulatory adherence"
    - name: "origin_location"
      expr: origin_location
      comment: "Origin location for fuel sourcing and transportation analysis"
    - name: "delivery_point_code"
      expr: delivery_point_code
      comment: "Delivery point for plant-specific fuel logistics"
    - name: "currency_code"
      expr: currency_code
      comment: "Currency code for multi-currency fuel cost consolidation"
  measures:
    - name: "total_fuel_cost"
      expr: SUM(CAST(total_delivery_cost AS DOUBLE))
      comment: "Total fuel delivery cost for generation cost management and fuel budget tracking"
    - name: "total_transportation_cost"
      expr: SUM(CAST(transportation_cost AS DOUBLE))
      comment: "Total fuel transportation cost for logistics efficiency and supplier negotiation"
    - name: "total_delivered_quantity"
      expr: SUM(CAST(delivered_quantity AS DOUBLE))
      comment: "Total fuel quantity delivered for generation capacity planning"
    - name: "total_btu_content"
      expr: SUM(CAST(btu_content AS DOUBLE))
      comment: "Total BTU content delivered for energy output and heat rate analysis"
    - name: "avg_unit_price"
      expr: AVG(CAST(unit_price AS DOUBLE))
      comment: "Average fuel unit price for cost trending and market benchmarking"
    - name: "avg_heat_rate"
      expr: AVG(CAST(heat_rate_mmbtu_per_unit AS DOUBLE))
      comment: "Average heat rate for generation efficiency and fuel quality assessment"
    - name: "avg_sulfur_content_pct"
      expr: AVG(CAST(sulfur_content_percent AS DOUBLE))
      comment: "Average sulfur content percentage for emissions compliance and environmental reporting"
    - name: "avg_ash_content_pct"
      expr: AVG(CAST(ash_content_percent AS DOUBLE))
      comment: "Average ash content percentage for fuel quality and maintenance cost impact"
    - name: "avg_moisture_content_pct"
      expr: AVG(CAST(moisture_content_percent AS DOUBLE))
      comment: "Average moisture content percentage for fuel quality and combustion efficiency"
    - name: "fuel_delivery_count"
      expr: COUNT(DISTINCT fuel_delivery_id)
      comment: "Number of fuel deliveries for supply chain velocity and logistics planning"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique fuel vendors for supplier diversification and concentration risk"
    - name: "transportation_cost_pct"
      expr: ROUND(100.0 * SUM(CAST(transportation_cost AS DOUBLE)) / NULLIF(SUM(CAST(total_delivery_cost AS DOUBLE)), 0), 2)
      comment: "Transportation cost as percentage of total fuel cost for logistics efficiency benchmarking"
    - name: "environmental_compliance_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN environmental_compliance_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT fuel_delivery_id), 0), 2)
      comment: "Environmental compliance rate for regulatory adherence and risk management"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`supply_goods_receipt`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Goods receipt and quality metrics tracking receiving efficiency, inspection outcomes, and three-way match for procurement cycle time and quality management"
  source: "`power_and_utilities`.`supply`.`goods_receipt`"
  dimensions:
    - name: "receipt_year"
      expr: YEAR(posting_date)
      comment: "Year of goods receipt for annual receiving volume trending"
    - name: "receipt_quarter"
      expr: CONCAT('Q', QUARTER(posting_date))
      comment: "Quarter of goods receipt for quarterly receiving analysis"
    - name: "receipt_month"
      expr: DATE_TRUNC('MONTH', posting_date)
      comment: "Month of goods receipt for monthly receiving velocity"
    - name: "gr_status"
      expr: gr_status
      comment: "Goods receipt status for receiving process tracking"
    - name: "movement_type"
      expr: movement_type
      comment: "Movement type for goods receipt categorization"
    - name: "inspection_outcome"
      expr: inspection_outcome
      comment: "Inspection outcome for quality acceptance rate"
    - name: "quality_inspection_required_flag"
      expr: quality_inspection_required_flag
      comment: "Quality inspection requirement for quality process coverage"
    - name: "delivery_completed_flag"
      expr: delivery_completed_flag
      comment: "Delivery completion indicator for order fulfillment tracking"
    - name: "over_delivery_tolerance_exceeded_flag"
      expr: over_delivery_tolerance_exceeded_flag
      comment: "Over-delivery tolerance breach for receiving accuracy"
    - name: "under_delivery_tolerance_exceeded_flag"
      expr: under_delivery_tolerance_exceeded_flag
      comment: "Under-delivery tolerance breach for supplier performance"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Reversal indicator for goods receipt error rate"
    - name: "stock_type"
      expr: stock_type
      comment: "Stock type for inventory classification"
  measures:
    - name: "total_goods_receipt_value"
      expr: SUM(CAST(valuation_amount AS DOUBLE))
      comment: "Total goods receipt valuation for inventory capitalization and working capital tracking"
    - name: "total_received_quantity"
      expr: SUM(CAST(received_quantity AS DOUBLE))
      comment: "Total quantity received for receiving throughput and capacity planning"
    - name: "goods_receipt_count"
      expr: COUNT(DISTINCT goods_receipt_id)
      comment: "Number of goods receipts for receiving velocity and workload analysis"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors with receipts for supplier base activity"
    - name: "unique_material_count"
      expr: COUNT(DISTINCT material_master_id)
      comment: "Number of unique materials received for SKU velocity analysis"
    - name: "quality_inspection_required_count"
      expr: SUM(CASE WHEN quality_inspection_required_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of receipts requiring quality inspection for quality workload planning"
    - name: "over_delivery_count"
      expr: SUM(CASE WHEN over_delivery_tolerance_exceeded_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of over-delivery tolerance breaches for supplier performance management"
    - name: "under_delivery_count"
      expr: SUM(CASE WHEN under_delivery_tolerance_exceeded_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of under-delivery tolerance breaches for supplier reliability tracking"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of goods receipt reversals for receiving error rate and process quality"
    - name: "delivery_tolerance_breach_rate"
      expr: ROUND(100.0 * (SUM(CASE WHEN over_delivery_tolerance_exceeded_flag = TRUE THEN 1 ELSE 0 END) + SUM(CASE WHEN under_delivery_tolerance_exceeded_flag = TRUE THEN 1 ELSE 0 END)) / NULLIF(COUNT(DISTINCT goods_receipt_id), 0), 2)
      comment: "Delivery tolerance breach rate for supplier delivery accuracy KPI"
    - name: "reversal_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT goods_receipt_id), 0), 2)
      comment: "Goods receipt reversal rate for receiving process quality and error reduction"
$$;

CREATE OR REPLACE VIEW `power_and_utilities`.`_metrics`.`supply_vendor_invoice`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Vendor invoice and payment metrics tracking invoice processing efficiency, payment timeliness, and three-way match for accounts payable performance and cash management"
  source: "`power_and_utilities`.`supply`.`vendor_invoice`"
  dimensions:
    - name: "invoice_fiscal_year"
      expr: fiscal_year
      comment: "Fiscal year of invoice for annual AP volume trending"
    - name: "invoice_fiscal_period"
      expr: fiscal_period
      comment: "Fiscal period of invoice for period-close AP analysis"
    - name: "invoice_month"
      expr: DATE_TRUNC('MONTH', invoice_date)
      comment: "Month of invoice for monthly AP velocity"
    - name: "invoice_status"
      expr: invoice_status
      comment: "Invoice status for AP pipeline and aging analysis"
    - name: "invoice_type"
      expr: invoice_type
      comment: "Invoice type for AP categorization"
    - name: "three_way_match_status"
      expr: three_way_match_status
      comment: "Three-way match status for procurement control effectiveness"
    - name: "payment_block_indicator"
      expr: payment_block_indicator
      comment: "Payment block indicator for AP exception management"
    - name: "duplicate_invoice_flag"
      expr: duplicate_invoice_flag
      comment: "Duplicate invoice indicator for AP control quality"
    - name: "reversal_indicator"
      expr: reversal_indicator
      comment: "Reversal indicator for invoice error rate"
    - name: "payment_method"
      expr: payment_method
      comment: "Payment method for payment process optimization"
    - name: "company_code"
      expr: company_code
      comment: "Company code for multi-entity AP consolidation"
  measures:
    - name: "total_invoice_amount"
      expr: SUM(CAST(net_invoice_amount AS DOUBLE))
      comment: "Total net invoice amount for AP liability and cash flow forecasting"
    - name: "total_gross_invoice_amount"
      expr: SUM(CAST(gross_invoice_amount AS DOUBLE))
      comment: "Total gross invoice amount for spend visibility before discounts"
    - name: "total_discount_captured"
      expr: SUM(CAST(discount_amount AS DOUBLE))
      comment: "Total discount amount captured for early payment savings and working capital optimization"
    - name: "total_tax_amount"
      expr: SUM(CAST(tax_amount AS DOUBLE))
      comment: "Total tax amount for tax accrual and compliance reporting"
    - name: "total_withholding_tax"
      expr: SUM(CAST(withholding_tax_amount AS DOUBLE))
      comment: "Total withholding tax for tax compliance and vendor payment reconciliation"
    - name: "invoice_count"
      expr: COUNT(DISTINCT vendor_invoice_id)
      comment: "Number of vendor invoices for AP throughput and workload analysis"
    - name: "unique_vendor_count"
      expr: COUNT(DISTINCT vendor_id)
      comment: "Number of unique vendors invoiced for supplier payment activity"
    - name: "payment_block_count"
      expr: SUM(CASE WHEN payment_block_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of invoices with payment blocks for AP exception management"
    - name: "duplicate_invoice_count"
      expr: SUM(CASE WHEN duplicate_invoice_flag = TRUE THEN 1 ELSE 0 END)
      comment: "Count of duplicate invoices for AP control effectiveness"
    - name: "reversal_count"
      expr: SUM(CASE WHEN reversal_indicator = TRUE THEN 1 ELSE 0 END)
      comment: "Count of invoice reversals for AP error rate and process quality"
    - name: "payment_block_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN payment_block_indicator = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT vendor_invoice_id), 0), 2)
      comment: "Payment block rate for AP exception management and process improvement"
    - name: "duplicate_invoice_rate"
      expr: ROUND(100.0 * SUM(CASE WHEN duplicate_invoice_flag = TRUE THEN 1 ELSE 0 END) / NULLIF(COUNT(DISTINCT vendor_invoice_id), 0), 2)
      comment: "Duplicate invoice rate for AP control quality and fraud prevention"
    - name: "discount_capture_rate"
      expr: ROUND(100.0 * SUM(CAST(discount_amount AS DOUBLE)) / NULLIF(SUM(CAST(gross_invoice_amount AS DOUBLE)), 0), 2)
      comment: "Discount capture rate as percentage of gross spend for working capital optimization KPI"
$$;