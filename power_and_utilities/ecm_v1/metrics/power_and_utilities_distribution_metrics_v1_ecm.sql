-- Metric views for domain: distribution | Business: Power and Utilities | Version: 1 | Generated on: 2026-05-05 03:39:44

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`distribution_outage_event`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Key reliability contribution metrics for distribution outages"
  source: "`power_and_utilities_v2`.`distribution`.`distribution_outage_event`"
  dimensions:
    - name: "outage_type"
      expr: outage_type
      comment: "Category of outage (e.g., weather, equipment)"
  measures:
    - name: "outage_count"
      expr: COUNT(1)
      comment: "Total number of outage events"
    - name: "total_caidi_contribution"
      expr: SUM(CAST(caidi_contribution AS DOUBLE))
      comment: "Sum of CAIDI contribution across outages (minutes)"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`distribution_transformer`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Transformer fleet health and utilization"
  source: "`power_and_utilities_v2`.`distribution`.`distribution_transformer`"
  dimensions:
    - name: "transformer_type"
      expr: transformer_type
      comment: "Design type of transformer (e.g., pole‑mounted, pad‑mounted)"
  measures:
    - name: "transformer_count"
      expr: COUNT(1)
      comment: "Number of transformers in the fleet"
    - name: "total_transformer_capacity_kva"
      expr: SUM(CAST(rating_kva AS DOUBLE))
      comment: "Aggregate rated capacity of all transformers (kVA)"
    - name: "average_load_factor_percent"
      expr: AVG(CAST(load_factor_percent AS DOUBLE))
      comment: "Average load factor across transformers"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`distribution_feeder`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Feeder performance and reliability"
  source: "`power_and_utilities_v2`.`distribution`.`feeder`"
  dimensions:
    - name: "feeder_type"
      expr: feeder_type
      comment: "Classification of feeder (e.g., primary, secondary)"
    - name: "is_critical_infrastructure"
      expr: is_critical_infrastructure
      comment: "Flag indicating critical infrastructure feeder"
  measures:
    - name: "feeder_count"
      expr: COUNT(1)
      comment: "Number of feeders"
    - name: "total_feeder_length_km"
      expr: SUM(CAST(length_km AS DOUBLE))
      comment: "Combined length of all feeders (km)"
    - name: "average_daily_load_mwh"
      expr: AVG(CAST(average_daily_load_mwh AS DOUBLE))
      comment: "Mean daily energy delivered per feeder (MWh)"
    - name: "average_outage_duration_min"
      expr: AVG(CAST(average_outage_duration_min AS DOUBLE))
      comment: "Mean outage duration per feeder (minutes)"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`distribution_service_point`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Service point portfolio overview"
  source: "`power_and_utilities_v2`.`distribution`.`distribution_service_point`"
  dimensions:
    - name: "service_type"
      expr: service_type
      comment: "Type of service (residential, commercial, industrial)"
    - name: "voltage_class"
      expr: voltage_class
      comment: "Voltage class of the service point"
  measures:
    - name: "service_point_count"
      expr: COUNT(1)
      comment: "Total service points"
    - name: "average_service_capacity_kw"
      expr: AVG(CAST(service_capacity_kw AS DOUBLE))
      comment: "Mean service point capacity (kW)"
    - name: "primary_service_point_count"
      expr: SUM(CASE WHEN is_primary_service_point THEN 1 ELSE 0 END)
      comment: "Number of primary service points"
$$;

CREATE OR REPLACE VIEW `power_and_utilities_v2`.`_metrics`.`distribution_conductor_span`
WITH METRICS
LANGUAGE YAML
AS $$
  version: 1.1
  comment: "Conductor span inventory and electrical characteristics"
  source: "`power_and_utilities_v2`.`distribution`.`conductor_span`"
  dimensions:
    - name: "line_category"
      expr: line_category
      comment: "Category of line (e.g., overhead, underground)"
    - name: "is_critical_infrastructure"
      expr: is_critical_infrastructure
      comment: "Critical infrastructure flag for the span"
  measures:
    - name: "conductor_span_count"
      expr: COUNT(1)
      comment: "Number of conductor spans"
    - name: "total_conductor_length_ft"
      expr: SUM(CAST(length_ft AS DOUBLE))
      comment: "Total length of conductor spans (feet)"
    - name: "average_line_voltage_kv"
      expr: AVG(CAST(line_voltage_kv AS DOUBLE))
      comment: "Mean line voltage across spans (kV)"
$$;