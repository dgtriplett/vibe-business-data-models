-- Metric views for domain: transmission | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`transmission_line_asset`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key asset‑level KPIs for transmission lines to support capacity planning and maintenance prioritization"
  source: "`power_and_utilities_v2`.`transmission`.`line`"
  dimensions:
    - name: "asset_class"
      expr: asset_class
      comment: "Classification of the line asset (e.g., overhead, underground)"
    - name: "line_type"
      expr: line_type
      comment: "Technical type of line (e.g., AC, DC)"
    - name: "voltage_kv"
      expr: voltage_kv
      comment: "Design voltage level of the line in kV"
    - name: "rto_iso_region"
      expr: rto_iso_region
      comment: "Regional ISO/RTO jurisdiction"
  measures:
    - name: "total_line_length_miles"
      expr: SUM(CAST(length_miles AS DOUBLE))
      comment: "Total physical length of transmission lines in miles"
    - name: "total_line_capacity_mw"
      expr: SUM(CAST(capacity_mw AS DOUBLE))
      comment: "Aggregate MW capacity of all lines"
    - name: "average_thermal_rating_mva"
      expr: AVG(CAST(thermal_rating_mva AS DOUBLE))
      comment: "Mean thermal rating across lines, indicating asset capability"
    - name: "line_count"
      expr: COUNT(1)
      comment: "Number of line records"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`transmission_outage`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Outage performance metrics to drive reliability improvement initiatives"
  source: "`power_and_utilities_v2`.`transmission`.`transmission_outage`"
  dimensions:
    - name: "outage_type"
      expr: outage_type
      comment: "Categorization of outage (e.g., Planned, Unplanned, Critical)"
    - name: "cause_code"
      expr: cause_code
      comment: "Root‑cause classification code"
    - name: "affected_market"
      expr: affected_market
      comment: "Market area impacted by the outage"
    - name: "outage_status"
      expr: transmission_outage_status
      comment: "Current status of the outage record"
  measures:
    - name: "total_outage_count"
      expr: COUNT(1)
      comment: "Number of outage events recorded"
    - name: "total_impact_mw"
      expr: SUM(CAST(impact_mw AS DOUBLE))
      comment: "Cumulative MW impact of outages"
    - name: "total_impact_mva"
      expr: SUM(CAST(impact_mva AS DOUBLE))
      comment: "Cumulative MVA impact of outages"
    - name: "critical_outage_count"
      expr: SUM(CASE WHEN outage_type = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of outages flagged as critical"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`transmission_power_flow_snapshot`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Operational snapshot KPIs for real‑time grid performance monitoring"
  source: "`power_and_utilities_v2`.`transmission`.`power_flow_snapshot`"
  dimensions:
    - name: "region_code"
      expr: region_code
      comment: "Regional code for the snapshot"
    - name: "snapshot_type"
      expr: snapshot_type
      comment: "Type of snapshot (e.g., Base, Contingency)"
    - name: "snapshot_status"
      expr: snapshot_status
      comment: "Processing status of the snapshot"
    - name: "is_critical"
      expr: is_critical
      comment: "Flag indicating if snapshot reflects a critical system state"
  measures:
    - name: "snapshot_count"
      expr: COUNT(1)
      comment: "Number of power‑flow snapshots captured"
    - name: "total_system_load_mw"
      expr: SUM(CAST(system_load_mw AS DOUBLE))
      comment: "Aggregate system load across all snapshots"
    - name: "total_generation_mw"
      expr: SUM(CAST(total_generation_mw AS DOUBLE))
      comment: "Total generation reported in snapshots"
    - name: "total_transmission_losses_mw"
      expr: SUM(CAST(transmission_losses_mw AS DOUBLE))
      comment: "Cumulative transmission losses"
    - name: "average_voltage_kv"
      expr: AVG(CAST(voltage_avg_kv AS DOUBLE))
      comment: "Mean average voltage across snapshots"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`transmission_transformer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transformer asset health and capacity metrics to guide capital planning"
  source: "`power_and_utilities_v2`.`transmission`.`transmission_transformer`"
  dimensions:
    - name: "asset_type"
      expr: asset_type
      comment: "Type of transformer asset (e.g., Step‑up, Step‑down)"
    - name: "ownership_type"
      expr: ownership_type
      comment: "Ownership model of the transformer"
    - name: "primary_voltage_kv"
      expr: primary_voltage_kv
      comment: "Primary voltage rating in kV"
    - name: "transmission_substation_id"
      expr: transmission_substation_id
      comment: "Identifier of the substation housing the transformer"
  measures:
    - name: "transformer_count"
      expr: COUNT(1)
      comment: "Number of transformer assets"
    - name: "total_transformer_capacity_mva"
      expr: SUM(CAST(mva_rating_normal AS DOUBLE))
      comment: "Combined normal MVA rating of all transformers"
    - name: "average_age_years"
      expr: AVG(CAST(age_years AS DOUBLE))
      comment: "Mean age of transformers in years"
    - name: "critical_transformer_count"
      expr: SUM(CASE WHEN criticality = 'Critical' THEN 1 ELSE 0 END)
      comment: "Count of transformers marked as critical"
$$;