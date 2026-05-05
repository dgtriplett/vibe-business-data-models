-- Schema for Domain: transmission | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`transmission` COMMENT 'Manages the high-voltage bulk electric system (BES) including transmission lines, substations, transformers, and grid interconnections. Serves as the SSOT for transmission topology, line ratings, outage events, power flow data, and SCADA-sourced EMS telemetry. Supports FERC tariff compliance, RTO/ISO scheduling, LMP settlement inputs, and NERC CIP compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`line` (
    `line_id` BIGINT COMMENT 'Primary key for line',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Asset Management requires each transmission line to be recorded as an asset for depreciation, maintenance planning, and regulatory reporting.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Required for NERC/ISO interchange scheduling reports that assign each transmission line to a balancing area for market settlement.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Dedicated Transmission Service Agreement requires linking each dedicated line to the customer account that owns it for billing and compliance reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: OPEX budgeting report requires each transmission line to be charged to a specific cost center for maintenance and operation costs.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Industrial customers often have dedicated transmission lines; linking lines to the owning account enables billing, capacity allocation, and reliability planning.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: A transmission line connects two substations; add FK to the originating substation.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Transmission Service Rate Assignment: each line is assigned a rate schedule for billing and FERC reporting, required by the Transmission Service Rate Determination process.',
    `right_of_way_id` BIGINT COMMENT 'Foreign key linking to transmission.right_of_way. Business justification: Each line runs within a right‑of‑way corridor; link line to its corridor.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: SCADA system monitors each transmission line; required for real‑time monitoring reports and outage analysis.',
    `telecom_circuit_id` BIGINT COMMENT 'Foreign key linking to technology.telecom_circuit. Business justification: Telemetry circuits provide data links for line monitoring; required for SCADA data feed and regulatory reporting.',
    `ampacity_amps` DECIMAL(18,2) COMMENT 'Maximum continuous current the line can carry, in amperes.',
    `asset_class` STRING COMMENT 'High‑level classification of the asset within the utilitys asset hierarchy.. Valid values are `transmission|substation|switchgear`',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum power transfer capability of the line in megawatts.',
    `circuit_designation` STRING COMMENT 'Circuit identifier (e.g., A, B, C) used in system schematics.',
    `condition_code` STRING COMMENT 'Standardized code representing the lines physical condition.. Valid values are `good|fair|poor|critical`',
    `conductor_size_mm2` DECIMAL(18,2) COMMENT 'Cross‑sectional area of the conductor in square millimetres.',
    `conductor_type` STRING COMMENT 'Material and construction type of the conductor.. Valid values are `ACSR|AAAC|Aluminum|Copper|HTLS|XLP`',
    `construction_year` STRING COMMENT 'Calendar year the line was originally constructed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was first created in the system.',
    `depreciation_end_date` DATE COMMENT 'Date when depreciation of the line asset ends (typically end of useful life).',
    `depreciation_start_date` DATE COMMENT 'Date when depreciation of the line asset begins.',
    `environmental_sensitivity_flag` BOOLEAN COMMENT 'True if the line traverses environmentally sensitive areas requiring special compliance.',
    `ferc_jurisdiction_flag` BOOLEAN COMMENT 'True if the line falls under Federal Energy Regulatory Commission jurisdiction.',
    `gis_route_geometry` STRING COMMENT 'Well‑Known Text representation of the lines geographic route.',
    `in_service_date` DATE COMMENT 'Date the line entered commercial service.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent condition inspection.',
    `length_miles` DECIMAL(18,2) COMMENT 'Total length of the transmission line segment in miles.',
    `line_code` STRING COMMENT 'External business code or tag used to reference the line in operational systems.. Valid values are `^[A-Z0-9_-]+$`',
    `line_name` STRING COMMENT 'Human‑readable name or designation of the transmission line.',
    `line_type` STRING COMMENT 'Physical configuration of the line.. Valid values are `overhead|underground|submarine|cable|HVDC`',
    `nerc_bes_classification` STRING COMMENT 'Indicates whether the line is part of the Bulk Electric System as defined by NERC.. Valid values are `BES|Non-BES`',
    `next_inspection_due_date` DATE COMMENT 'Planned date for the next scheduled inspection.',
    `operational_status` STRING COMMENT 'Current operational state of the line.. Valid values are `in_service|out_of_service|planned|decommissioned|maintenance`',
    `out_of_service_date` DATE COMMENT 'Date the line was retired or taken out of service (null if still active).',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Utilitys ownership share of the line expressed as a percent.',
    `protection_scheme` STRING COMMENT 'Primary protection methodology applied to the line.. Valid values are `distance|differential|pilot|relay|none`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the line meets all applicable regulatory requirements.',
    `right_of_way_type` STRING COMMENT 'Legal type of the corridor in which the line is situated.. Valid values are `public|private|easement|lease`',
    `rto_iso_region` STRING COMMENT 'Regional transmission organization or independent system operator region for market scheduling.. Valid values are `CAISO|ERCOT|MISO|PJM|NYISO|ISO-NE`',
    `thermal_rating_mva` DECIMAL(18,2) COMMENT 'Maximum continuous thermal rating of the line in megavolt‑amperes.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    `voltage_kv` DECIMAL(18,2) COMMENT 'Nominal voltage class of the line expressed in kilovolts.',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Master record for each high-voltage bulk electric system (BES) transmission line segment owned or operated by the utility. Captures line identifier, voltage class (kV), circuit designation, conductor type and size, thermal rating (MVA), length (miles), in-service date, NERC BES classification, FERC jurisdiction flag, RTO/ISO region, GIS route geometry, ownership percentage, and operational status. Serves as the SSOT for transmission line identity and physical characteristics. Referenced by topology, line_rating, outage, protection_relay, right_of_way, and contingency products.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` (
    `transmission_substation_id` BIGINT COMMENT 'Unique system-generated identifier for the transmission substation.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: GIS location of each substation is stored centrally for mapping, emergency response, and crew dispatch.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Substations are capital assets tracked in the Asset Registry for lifecycle, depreciation, and compliance reporting.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Customer‑owned substation management mandates associating the substation record with the owning CI account for asset‑customer accountability.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Substation OPEX allocation uses a cost center; the Substation Cost Allocation Report links each substation to its cost center.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Emergency response plans reference a designated crew for each substation; crew_id enables rapid mobilization.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Some high‑voltage substations are owned/leased by a primary industrial customer; the FK supports asset ownership tracking and cost recovery.',
    `disaster_recovery_plan_id` BIGINT COMMENT 'Identifier of the emergency response plan associated with the substation.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to regulatory.environmental_permit. Business justification: Substation construction requires an EPA environmental permit; linking substation to environmental_permit_id tracks permit compliance.',
    `facility_id` BIGINT COMMENT 'Official facility identifier assigned by the Federal Energy Regulatory Commission.',
    `finance_capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.finance_capex_project. Business justification: Substation capital improvements are managed as Capex Projects; linking enables project cost roll‑up and reporting.',
    `gis_boundary_id` BIGINT COMMENT 'Identifier of the GIS polygon that defines the substation footprint.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Regulatory reporting and tax assessment require linking each substation to the parcel it occupies, enabling FERC and local tax filings.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Substation SCADA provides status and control; essential for substation performance dashboards and regulatory compliance.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Operational planning and emergency response group substations by site, required by the utility’s Integrated Operations Center for coordinated outage management.',
    `address` STRING COMMENT 'Full street address of the substation, including city, state, zip, and country.',
    `area_sqft` DECIMAL(18,2) COMMENT 'Total footprint area of the substation in square feet.',
    `asset_classification_code` STRING COMMENT 'Code representing the asset classification hierarchy.',
    `asset_condition_rating` STRING COMMENT 'Numeric rating (1‑5) of the assets condition.',
    `asset_condition_status` STRING COMMENT 'Current condition of the substation asset.. Valid values are `good|fair|poor|critical`',
    `asset_depreciation_method` STRING COMMENT 'Method used to calculate depreciation for the substation asset.. Valid values are `straight_line|declining_balance|units_of_production`',
    `asset_depreciation_start_date` DATE COMMENT 'Date depreciation calculations began for the substation.',
    `asset_lifecycle_stage` STRING COMMENT 'Current lifecycle stage of the substation asset.. Valid values are `planning|construction|in_service|retired|decommissioned`',
    `commissioning_date` DATE COMMENT 'Date the substation was officially commissioned for service.',
    `construction_year` STRING COMMENT 'Calendar year the substation was constructed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the substation record was first created in the lakehouse.',
    `criticality_rating` STRING COMMENT 'Rating (1‑5) indicating the substations importance to grid reliability.',
    `decommission_date` DATE COMMENT 'Date the substation was retired or removed from service, if applicable.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the emergency contact responsible for the substation.. Valid values are `^+?[0-9]{1,3}[ -]?(?[0-9]{1,4})?[ -]?[0-9]{3,4}[ -]?[0-9]{3,4}$`',
    `gis_polygon_reference` STRING COMMENT 'Identifier of the GIS polygon that defines the substation footprint.',
    `gps_latitude` DOUBLE COMMENT 'Geographic latitude coordinate of the substation location.',
    `gps_longitude` DOUBLE COMMENT 'Geographic longitude coordinate of the substation location.',
    `high_voltage_kv` DECIMAL(18,2) COMMENT 'Nominal high‑side voltage rating of the substation in kilovolts.',
    `in_service_date` DATE COMMENT 'Date the substation entered commercial operation.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection of the substation.',
    `low_voltage_kv` DECIMAL(18,2) COMMENT 'Nominal low‑side voltage rating of the substation in kilovolts.',
    `maintenance_contract_expiry` DATE COMMENT 'Expiration date of the active maintenance contract.',
    `maintenance_contract_status` STRING COMMENT 'Current status of the substations maintenance contract.. Valid values are `active|expired|none`',
    `nerc_cip_classification` STRING COMMENT 'Critical Infrastructure Protection classification per NERC standards.. Valid values are `high|medium|low`',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `number_of_bays` STRING COMMENT 'Count of bays (circuit breaker slots) available in the substation.',
    `operational_status` STRING COMMENT 'Current operational state of the substation.. Valid values are `operational|maintenance|outage|decommissioned|planned`',
    `operator_entity` STRING COMMENT 'Entity responsible for day‑to‑day operation of the substation.',
    `owner_entity` STRING COMMENT 'Legal entity that owns the substation.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score derived from asset condition, location, and criticality.',
    `rto_node_code` STRING COMMENT 'Identifier of the node used for RTO/ISO market scheduling and LMP settlement.',
    `site_type` STRING COMMENT 'Physical environment of the substation.. Valid values are `indoor|outdoor|underground`',
    `substation_type` STRING COMMENT 'Classification of the substation based on its primary function.. Valid values are `switching|transformer|converter|breaker|bus|other`',
    `transformer_capacity_mva` DECIMAL(18,2) COMMENT 'Total installed transformer capacity at the substation measured in megavolt‑amperes.',
    `transmission_substation_name` STRING COMMENT 'Human‑readable name of the transmission substation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the substation record.',
    CONSTRAINT pk_transmission_substation PRIMARY KEY(`transmission_substation_id`)
) COMMENT 'Master record for each transmission-level substation facility including high-side and low-side voltage levels, substation type (switching, transformer, converter), GPS coordinates, GIS polygon reference, NERC CIP classification (high/medium/low impact), FERC facility ID, RTO/ISO node identifier, installed transformer capacity (MVA), number of bays, in-service date, and operational status. Serves as the SSOT for substation identity and topology within the transmission domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` (
    `transmission_transformer_id` BIGINT COMMENT 'System-generated unique identifier for the transmission transformer record.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Precise transformer coordinates are needed by field crews; linking to Asset.Location provides a single source of truth.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Transformers are high‑value assets; linking to the registry enables maintenance schedules, reliability analysis, and financial tracking.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Transformers are capital assets; depreciation runs and asset registers require a FK to the Fixed Asset record.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Asset acquisition workflow records the purchase order that procured each transformer, supporting asset lifecycle and audit compliance.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Transformers are monitored via SCADA for temperature, load, and fault detection; needed for reliability reporting.',
    `transmission_substation_id` BIGINT COMMENT 'Reference to the substation where the transformer is located.',
    `age_years` DECIMAL(18,2) COMMENT 'Calculated age of the transformer in years since installation.',
    `asset_type` STRING COMMENT 'Broad classification of the transformer within asset hierarchy.. Valid values are `step_up|step_down|auto|regulating`',
    `condition_rating` DECIMAL(18,2) COMMENT 'Overall condition rating on a 0‑10 scale, where higher values indicate better condition.',
    `cooling_type` STRING COMMENT 'Cooling method used for the transformer oil (e.g., ONAN, ONAF, OFAF, OFWF).. Valid values are `ONAN|ONAF|OFAF|OFWF`',
    `criticality` STRING COMMENT 'Criticality level for reliability planning (critical, non‑critical, unknown).. Valid values are `critical|non_critical|unknown`',
    `decommission_date` DATE COMMENT 'Date the transformer was removed from service, if applicable.',
    `design_type` STRING COMMENT 'Indicates whether the transformer follows a standard design, a custom specification, or is a prototype.. Valid values are `standard|custom|prototype`',
    `has_bushing_inspection` BOOLEAN COMMENT 'Indicates whether the transformer has a documented bushing inspection program (yes/no).',
    `impedance_percent` DECIMAL(18,2) COMMENT 'Percent impedance of the transformer, representing voltage drop under load.',
    `in_service_date` DATE COMMENT 'Date the transformer was placed into service.',
    `installation_date` DATE COMMENT 'Date the transformer was physically installed at the substation.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity.',
    `last_test_date` DATE COMMENT 'Date of the most recent routine test or inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the transformer location.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the transformer location.',
    `losses_watts` DECIMAL(18,2) COMMENT 'Typical iron and copper losses under rated load, measured in watts.',
    `maintenance_interval_months` STRING COMMENT 'Planned interval between routine maintenance activities, expressed in months.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the transformer.',
    `manufacturer_part_number` STRING COMMENT 'Part number used by the manufacturer for ordering and warranty.',
    `model_number` STRING COMMENT 'Manufacturers model designation for the transformer.',
    `mva_rating_emergency` DECIMAL(18,2) COMMENT 'Short‑term emergency power rating of the transformer in megavolt-amperes.',
    `mva_rating_normal` DECIMAL(18,2) COMMENT 'Continuous power rating of the transformer in megavolt-amperes under normal operating conditions.',
    `nerc_bes_flag` STRING COMMENT 'Indicates whether the transformer is part of the NERC‑defined Bulk Electric System (yes/no).. Valid values are `yes|no`',
    `next_maintenance_due` DATE COMMENT 'Scheduled date for the next planned maintenance.',
    `oil_volume_liters` DECIMAL(18,2) COMMENT 'Total volume of insulating oil contained in the transformer, measured in liters.',
    `ownership_type` STRING COMMENT 'Indicates whether the transformer is owned by the utility (internal) or leased/third‑party (external).. Valid values are `internal|external`',
    `primary_voltage_kv` DECIMAL(18,2) COMMENT 'Rated primary side voltage of the transformer in kilovolts.',
    `rated_short_circuit_current_ka` DECIMAL(18,2) COMMENT 'Maximum short‑circuit current the transformer can safely withstand, expressed in kilo‑amperes.',
    `secondary_voltage_kv` DECIMAL(18,2) COMMENT 'Rated secondary side voltage of the transformer in kilovolts.',
    `serial_number` STRING COMMENT 'Manufacturer‑assigned serial number for traceability.',
    `tag_number` STRING COMMENT 'Unique alphanumeric tag assigned to the transformer for field identification.',
    `tap_changer_type` STRING COMMENT 'Type of tap changer installed (step‑up, step‑down, automatic, regulating).. Valid values are `step_up|step_down|auto|regulating`',
    `thermal_rating_c` DECIMAL(18,2) COMMENT 'Maximum allowable operating temperature of the transformer windings.',
    `transmission_transformer_status` STRING COMMENT 'Current operational status of the transformer.. Valid values are `in_service|out_of_service|retired|maintenance|decommissioned`',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty on the transformer expires.',
    CONSTRAINT pk_transmission_transformer PRIMARY KEY(`transmission_transformer_id`)
) COMMENT 'Master record for each power transformer installed at a transmission substation. Captures transformer tag number, manufacturer, model, MVA rating (normal/emergency), primary and secondary voltage (kV), impedance (%), cooling type (ONAN/ONAF/OFAF), oil volume, tap changer type, NERC BES flag, in-service date, last test date, and condition rating. Linked to substation and Maximo EAM asset record. Distinct from distribution transformers owned by the distribution domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`topology` (
    `topology_id` BIGINT COMMENT 'Primary key for topology',
    `control_zone_id` BIGINT COMMENT 'Foreign key linking to gridops.control_zone. Business justification: Topology change records are scoped to control zones; linking enables zone‑specific topology snapshots for operational planning.',
    `bus_id` BIGINT COMMENT 'Identifier of the originating bus in the branch connection.',
    `line_id` BIGINT COMMENT 'Logical circuit grouping identifier for planning and operations.',
    `to_bus_id` BIGINT COMMENT 'Identifier of the terminating bus in the branch connection.',
    `transmission_substation_id` BIGINT COMMENT 'Identifier of the substation to which the branch is attached.',
    `branch_reference` STRING COMMENT 'External business identifier for the transmission branch (line or transformer).',
    `branch_type` STRING COMMENT 'Indicates whether the branch is a transmission line or a transformer.. Valid values are `line|transformer`',
    `conductor_type` STRING COMMENT 'Material composition of the line conductor.. Valid values are `copper|aluminum|composite`',
    `convergence_status` STRING COMMENT 'Result of the power‑flow solver for this snapshot.. Valid values are `converged|not_converged|partial`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the topology record was first created.',
    `data_quality_flag` STRING COMMENT 'Indicator of the data quality assessment for this record.. Valid values are `good|questionable|bad`',
    `effective_date` DATE COMMENT 'Date on which this topology version becomes effective.',
    `geographic_region` STRING COMMENT 'NERC region or other geographic classification for the branch.',
    `impedance_r_pu` DECIMAL(18,2) COMMENT 'Per‑unit resistance component of the branch impedance.',
    `impedance_x_pu` DECIMAL(18,2) COMMENT 'Per‑unit reactance component of the branch impedance.',
    `interchange_condition` STRING COMMENT 'Operational condition influencing power interchange (e.g., normal, contingency).. Valid values are `normal|contingency|emergency`',
    `is_critical_infrastructure` BOOLEAN COMMENT 'True if the branch is designated as critical infrastructure under NERC CIP.',
    `last_outage_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent outage event affecting this branch.',
    `length_mi` DECIMAL(18,2) COMMENT 'Physical length of the transmission line segment in miles.',
    `line_charging_mvar` DECIMAL(18,2) COMMENT 'Total line charging reactive power in megavolt‑amps reactive.',
    `losses_mw` DECIMAL(18,2) COMMENT 'Calculated active power losses on the branch in megawatts.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or operational notes.',
    `power_flow_mvar` DECIMAL(18,2) COMMENT 'Real‑time reactive power flow on the branch in megavolt‑amps reactive.',
    `power_flow_mw` DECIMAL(18,2) COMMENT 'Real‑time active power flow on the branch in megawatts.',
    `source_system` STRING COMMENT 'Originating system that supplied the topology data.. Valid values are `GE_PowerOn|OSIsoft_PI`',
    `susceptance_b_pu` DECIMAL(18,2) COMMENT 'Per‑unit shunt susceptance of the branch.',
    `tap_ratio` DECIMAL(18,2) COMMENT 'Tap ratio applied to a transformer branch; 1.0 for lines.',
    `thermal_rating_mva` DECIMAL(18,2) COMMENT 'Maximum continuous power the branch can carry safely, expressed in megavolt‑amps.',
    `topology_status` STRING COMMENT 'Current operational status of the branch.. Valid values are `in_service|out_of_service|planned|retired`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the topology record.',
    `version_number` BIGINT COMMENT 'Surrogate key linking to a separate versioning table for historical snapshots.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage rating of the branch in kilovolts.',
    CONSTRAINT pk_topology PRIMARY KEY(`topology_id`)
) COMMENT 'Represents the network connectivity model (bus-branch model) of the bulk electric system used by EMS, power flow solvers, and state estimation. Each record defines a directed branch (from-bus to to-bus) with associated transmission line or transformer, impedance parameters (R, X, B in per-unit), line charging, transformer tap ratio, and topology version effective date. Includes time-stamped power flow solution snapshots capturing system MW, MVAR, losses, convergence status, and interchange conditions for post-event analysis and NERC reliability assessments. Supports SCADA-driven real-time network model updates, RTO/ISO contingency analysis, and IRP planning inputs. Sourced from GE PowerOn EMS and OSIsoft PI Historian.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`bus` (
    `bus_id` BIGINT COMMENT 'Unique surrogate key for each electrical bus node.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Balancing area load/ generation forecasts aggregate bus‑level data; bus‑to‑balancing‑area mapping is required for accurate forecasts.',
    `transformer_associated_transmission_transformer_id` BIGINT COMMENT 'Identifier of the transformer directly connected to the bus, if any.',
    `transmission_substation_id` BIGINT COMMENT 'Identifier of the substation that physically hosts the bus.',
    `transmission_transformer_id` BIGINT COMMENT 'Identifier of the transformer directly connected to the bus, if any.',
    `area` STRING COMMENT 'Geographic or market area to which the bus belongs.',
    `bus_description` STRING COMMENT 'Free‑form text describing the bus, its role, or special characteristics.',
    `bus_name` STRING COMMENT 'Human‑readable name of the bus, often used in schematics and reports.',
    `bus_number` STRING COMMENT 'Alphanumeric identifier assigned by SCADA/EMS for the bus.',
    `bus_status` STRING COMMENT 'Current operational status of the bus.. Valid values are `active|inactive|planned|decommissioned`',
    `bus_type` STRING COMMENT 'Classification of the bus for power‑flow calculations: PQ (load), PV (generator), or slack/reference.. Valid values are `PQ|PV|slack`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the bus record was first created in the data lake.',
    `data_source_system` STRING COMMENT 'Name of the originating operational system (e.g., GE PowerOn EMS).',
    `data_source_timestamp` TIMESTAMP COMMENT 'Timestamp when the source system recorded the bus data.',
    `effective_from` DATE COMMENT 'Date on which the bus becomes effective for operational use.',
    `effective_until` DATE COMMENT 'Date on which the bus is retired or de‑commissioned; null if still active.',
    `grounding_type` STRING COMMENT 'Grounding configuration of the bus.. Valid values are `solid|resistance|reactor`',
    `is_critical_bus` BOOLEAN COMMENT 'True if the bus is designated as critical for system reliability studies.',
    `is_reserved` BOOLEAN COMMENT 'Indicates whether the bus is reserved for future expansion or special projects.',
    `is_slack` BOOLEAN COMMENT 'True if the bus is designated as the slack/reference bus in power‑flow studies.',
    `last_outage_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent outage event affecting the bus.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the bus location.',
    `long_term_rating_mva` DECIMAL(18,2) COMMENT 'Long‑term (e.g., 1‑hour) apparent power rating.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the bus location.',
    `maintenance_status` STRING COMMENT 'Current maintenance state of the bus.. Valid values are `scheduled|in_progress|completed|none`',
    `maintenance_window_end` TIMESTAMP COMMENT 'Planned end time for scheduled maintenance.',
    `maintenance_window_start` TIMESTAMP COMMENT 'Planned start time for scheduled maintenance.',
    `max_continuous_rating_mva` DECIMAL(18,2) COMMENT 'Maximum continuous apparent power rating of the bus in megavolt‑amperes.',
    `outage_flag` BOOLEAN COMMENT 'True if the bus is currently out of service due to an outage.',
    `ownership_type` STRING COMMENT 'Indicates who owns the bus asset.. Valid values are `utility|third_party|joint`',
    `regulatory_compliance_cip` BOOLEAN COMMENT 'True if the bus is covered by NERC CIP security requirements.',
    `rto_iso_node` STRING COMMENT 'Identifier of the pricing node used for LMP settlement.',
    `short_term_rating_mva` DECIMAL(18,2) COMMENT 'Short‑term (e.g., 30‑minute) apparent power rating.',
    `substation_name` STRING COMMENT 'Name of the hosting substation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the bus record.',
    `version_number` STRING COMMENT 'Monotonically increasing version for optimistic concurrency control.',
    `voltage_kv` DECIMAL(18,2) COMMENT 'Rated nominal voltage of the bus in kilovolts.',
    `zone` STRING COMMENT 'Control zone or balancing area for the bus.',
    CONSTRAINT pk_bus PRIMARY KEY(`bus_id`)
) COMMENT 'Master record for each electrical bus node in the transmission network model. Captures bus name, bus number (EMS/SCADA identifier), substation association, nominal voltage (kV), bus type (PQ, PV, slack/reference), area and zone assignment, RTO/ISO pricing node (pnode) identifier for LMP settlement, and active status. Forms the node set of the bus-branch topology model used in power flow, state estimation, and contingency analysis. Each bus maps to a physical location within a substation. Sourced from GE PowerOn EMS.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`line_rating` (
    `line_rating_id` BIGINT COMMENT 'System-generated unique identifier for each line rating record.',
    `line_id` BIGINT COMMENT 'Identifier of the transmission line segment to which this rating applies.',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'Assumed ambient temperature used in the rating calculation, expressed in degrees Celsius.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the rating complies with applicable regulatory requirements (e.g., FERC Order 881).',
    `conductor_temperature_limit_c` DECIMAL(18,2) COMMENT 'Maximum allowable conductor temperature for the rating, expressed in degrees Celsius.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rating record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the rating expires; null if indefinite.',
    `effective_start_date` DATE COMMENT 'Date on which the rating becomes effective.',
    `issuing_authority` STRING COMMENT 'Regulatory or internal body that issued the rating.. Valid values are `internal|FERC|NERC|state_puc`',
    `line_rating_description` STRING COMMENT 'Free‑form text describing assumptions, methodology, or special notes for the rating.',
    `line_rating_status` STRING COMMENT 'Current lifecycle status of the rating record.. Valid values are `active|inactive|retired|pending`',
    `notes` STRING COMMENT 'Additional operational notes or comments.',
    `rating_amps` DECIMAL(18,2) COMMENT 'Maximum current the line can carry under the specified conditions, expressed in amperes.',
    `rating_category` STRING COMMENT 'Broad category of the rating (thermal, voltage, or ampacity).. Valid values are `thermal|voltage|ampacity`',
    `rating_code` STRING COMMENT 'External business code or identifier assigned to the rating by the issuing authority.',
    `rating_label` STRING COMMENT 'Descriptive label for the rating (e.g., "Summer Normal Rating").',
    `rating_methodology` STRING COMMENT 'Approach used to derive the rating (static calculation, dynamic line rating via sensors, or model‑based).. Valid values are `static|dynamic|dlr_sensor|dlr_model`',
    `rating_mva` DECIMAL(18,2) COMMENT 'Maximum apparent power the line can carry under the specified conditions, expressed in megavolt‑amperes.',
    `rating_type` STRING COMMENT 'Classification of the rating based on duration and operating conditions.. Valid values are `normal|long_term|short_term|emergency`',
    `rating_version` STRING COMMENT 'Version number of the rating record for change tracking.',
    `season` STRING COMMENT 'Seasonal band to which the rating applies.. Valid values are `winter|spring|summer|fall`',
    `solar_radiation_w_per_m2` DECIMAL(18,2) COMMENT 'Assumed solar radiation used in dynamic rating, expressed in watts per square meter.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rating record.',
    `wind_speed_mps` DECIMAL(18,2) COMMENT 'Assumed wind speed for dynamic rating calculations, expressed in meters per second.',
    CONSTRAINT pk_line_rating PRIMARY KEY(`line_rating_id`)
) COMMENT 'Stores seasonal, static, and dynamic thermal ratings for each transmission line segment expressed in MVA and amperes. Captures rating type (normal, long-time emergency, short-time emergency), season or ambient temperature band, conductor temperature limit, wind speed and solar assumptions, rating effective date range, rating methodology (static vs. dynamic line rating — DLR via sensors or weather models), and issuing authority. Supports real-time congestion management, N-1 contingency analysis, FERC Order 881 ambient-adjusted ratings compliance, and capacity allocation for transmission service requests.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` (
    `transmission_outage_id` BIGINT COMMENT 'Unique surrogate key for each transmission outage record.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Outage response process assigns a restoration crew; crew_id links outage to the crew executing repairs.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Regulatory reporting requires linking each transmission outage to a safety incident record for NERC incident reporting and root‑cause analysis.',
    `incident_ticket_id` BIGINT COMMENT 'Foreign key linking to technology.incident_ticket. Business justification: Outage events generate IT incident tickets for outage management system; needed for incident tracking and SLA compliance.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Regulatory outage reporting tracks the primary affected customer account per transmission outage for settlement and performance metrics.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Repair and material procurement for an outage are captured in a purchase order; linking supports cost allocation and post‑outage analysis.',
    `special_contract_id` BIGINT COMMENT 'Foreign key linking to product.special_contract. Business justification: Outage Compensation: outages are linked to special contracts that specify compensation and settlement rules, required for regulatory compliance and customer settlement reporting.',
    `storm_event_id` BIGINT COMMENT 'Foreign key linking to workforce.storm_event. Business justification: Regulatory outage‑storm correlation report requires linking each outage to the causing storm event for FERC/NERC reporting.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Outages are often on a specific line; capture that relationship.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Outage restoration contracts assign a specific vendor to each outage, required for NERC CIP reporting and performance tracking.',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to regulatory.violation_notice. Business justification: Regulatory violation notices are issued for unplanned outages; outage record references violation_notice_id for audit and enforcement.',
    `actual_end` TIMESTAMP COMMENT 'Date and time when the outage was restored and power resumed.',
    `actual_start` TIMESTAMP COMMENT 'Date and time when the outage actually began.',
    `affected_market` STRING COMMENT 'RTO/ISO market region impacted by the outage (e.g., PJM, MISO, ERCOT).',
    `cause_code` STRING COMMENT 'Detailed code describing the specific cause of the outage, aligned with utility internal taxonomy.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the outage record was first created in the data lake.',
    `duration_minutes` STRING COMMENT 'Total duration of the outage in minutes, calculated from actual start and end times.',
    `impact_mva` DECIMAL(18,2) COMMENT 'Maximum megavolt‑ampere rating affected, used for reactive power considerations.',
    `impact_mw` DECIMAL(18,2) COMMENT 'Maximum megawatt capacity lost due to the outage.',
    `nerc_cause_category` STRING COMMENT 'Standard NERC classification of the root cause for the outage.. Valid values are `equipment_failure|weather|human_error|operational|other`',
    `outage_description` STRING COMMENT 'Brief free‑text description of the outage purpose or circumstances.',
    `outage_number` STRING COMMENT 'External identifier assigned to the outage request, used for tracking and regulatory reporting.',
    `outage_type` STRING COMMENT 'Classification of the outage based on its origin and planning status.. Valid values are `planned|forced|emergency|unplanned`',
    `reportable_flag` BOOLEAN COMMENT 'Indicates whether the outage must be reported to NERC OE‑417 compliance.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the outage request was initially submitted.',
    `restoration_details` STRING COMMENT 'Narrative description of actions taken to restore service and any lessons learned.',
    `scheduled_end` TIMESTAMP COMMENT 'Requested end date and time for the outage as approved in the schedule.',
    `scheduled_start` TIMESTAMP COMMENT 'Requested start date and time for the outage as approved in the schedule.',
    `transmission_outage_status` STRING COMMENT 'Current lifecycle state of the outage record.. Valid values are `requested|approved|in_progress|completed|cancelled`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the outage record.',
    CONSTRAINT pk_transmission_outage PRIMARY KEY(`transmission_outage_id`)
) COMMENT 'Transactional record of each planned or forced outage event on a transmission facility (line, transformer, bus, or substation). Captures outage request number, facility affected, outage type (planned maintenance, forced/unplanned, emergency), cause code, NERC outage cause category, requested start/end datetime, actual start/end datetime, MW/MVA impact, affected RTO/ISO market window, NERC OE-417 reportability flag, and restoration details. Sourced from GE PowerOn OMS and coordinated with RTO/ISO outage scheduling.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` (
    `power_flow_snapshot_id` BIGINT COMMENT 'Unique surrogate key for each power flow snapshot record.',
    `contingency_id` BIGINT COMMENT 'Identifier of the contingency case (if any) associated with this snapshot.',
    `angle_avg_deg` DECIMAL(18,2) COMMENT 'Mean voltage phase angle across all buses, degrees.',
    `angle_max_deg` DECIMAL(18,2) COMMENT 'Largest voltage phase angle in degrees across the network.',
    `angle_min_deg` DECIMAL(18,2) COMMENT 'Smallest voltage phase angle in degrees across the network.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the snapshot record was first loaded into the lakehouse.',
    `data_source` STRING COMMENT 'Originating system that supplied the snapshot data.. Valid values are `OSIsoft_PI|GE_PowerOn`',
    `frequency_hz` DECIMAL(18,2) COMMENT 'Average system frequency measured in hertz at the snapshot time.',
    `generation_forecast_mw` DECIMAL(18,2) COMMENT 'Projected generation dispatch used for the snapshot, megawatts.',
    `interchange_schedule_mw` DECIMAL(18,2) COMMENT 'Scheduled power interchange values applied in the snapshot.',
    `is_critical` BOOLEAN COMMENT 'True if the snapshot occurs during a critical operating period (e.g., peak load, emergency).',
    `load_forecast_mw` DECIMAL(18,2) COMMENT 'Projected system load used for the snapshot, megawatts.',
    `notes` STRING COMMENT 'Free‑form comments or annotations related to the snapshot.',
    `region_code` STRING COMMENT 'Code of the transmission control zone or region for the snapshot.',
    `snapshot_status` STRING COMMENT 'Indicates whether the state estimator converged for this snapshot.. Valid values are `converged|not_converged|partial`',
    `snapshot_timestamp` TIMESTAMP COMMENT 'Date and time when the power flow solution was captured.',
    `snapshot_type` STRING COMMENT 'Indicates whether the snapshot is a full state estimation or a partial update.. Valid values are `full|partial|incremental`',
    `solution_status` STRING COMMENT 'Result of the power flow solution algorithm.. Valid values are `optimal|feasible|infeasible|error`',
    `solver_iteration_count` STRING COMMENT 'Number of iterations performed by the state estimator to reach convergence.',
    `system_load_mw` DECIMAL(18,2) COMMENT 'Total real power demand on the transmission system in megawatts.',
    `system_mvar` DECIMAL(18,2) COMMENT 'Total reactive power demand on the transmission system in megavars.',
    `total_generation_mw` DECIMAL(18,2) COMMENT 'Aggregate real power output from all generators in the snapshot.',
    `total_interchange_mw` DECIMAL(18,2) COMMENT 'Net scheduled power interchange with neighboring balancing authorities.',
    `transmission_losses_mw` DECIMAL(18,2) COMMENT 'Estimated real power losses across the transmission network.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the snapshot record.',
    `voltage_avg_kv` DECIMAL(18,2) COMMENT 'Mean bus voltage magnitude across all buses, kilovolts.',
    `voltage_max_kv` DECIMAL(18,2) COMMENT 'Highest bus voltage magnitude observed in the network, kilovolts.',
    `voltage_min_kv` DECIMAL(18,2) COMMENT 'Lowest bus voltage magnitude observed in the network, kilovolts.',
    CONSTRAINT pk_power_flow_snapshot PRIMARY KEY(`power_flow_snapshot_id`)
) COMMENT 'Time-stamped operational snapshot of power flow conditions across the transmission network captured from the EMS/SCADA state estimator. Each record represents a solved power flow case at a specific timestamp including system MW load, system MVAR, total generation dispatch, interchange schedules, transmission losses, and convergence status. Supports post-event analysis, NERC reliability assessments, and IRP planning inputs. Sourced from OSIsoft PI Historian via GE PowerOn EMS.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` (
    `interchange_schedule_id` BIGINT COMMENT 'Primary key for interchange_schedule',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Schedule originates at a source substation; add FK.',
    `contract_path` STRING COMMENT 'File system or URL location of the underlying interchange contract document.',
    `counterparty_control_area` STRING COMMENT 'Identifier of the control area or RTO/ISO of the counter‑party.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the system.',
    `direction` STRING COMMENT 'Indicates whether the schedule represents an import or export of energy.. Valid values are `import|export`',
    `e_tag_reference` STRING COMMENT 'Reference number linking to the electronic tag used for compliance reporting.',
    `energy_type` STRING COMMENT 'Specifies whether the scheduled energy is firm or non‑firm.. Valid values are `firm|non-firm`',
    `interchange_schedule_status` STRING COMMENT 'Current lifecycle state of the schedule.. Valid values are `draft|submitted|approved|active|cancelled|rejected`',
    `market` STRING COMMENT 'Market segment for which the schedule is filed (Day‑Ahead, Real‑Time, etc.).. Valid values are `DAM|RTM|OTH`',
    `notes` STRING COMMENT 'Free‑form text for additional information or remarks about the schedule.',
    `peak_scheduled_mw` DECIMAL(18,2) COMMENT 'Maximum megawatt value within the scheduled interval.',
    `schedule_end_timestamp` TIMESTAMP COMMENT 'Date‑time when the scheduled interchange period ends.',
    `schedule_number` STRING COMMENT 'External schedule number assigned by the utility or market operator for reference.',
    `schedule_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the scheduled interchange period begins.',
    `scheduled_mw` DECIMAL(18,2) COMMENT 'Average megawatt value scheduled for the interchange period.',
    `settlement_period` STRING COMMENT 'Year‑month period to which the schedule applies for settlement.. Valid values are `^d{4}-d{2}$`',
    `tariff_service_type` STRING COMMENT 'FERC tariff service classification for the interchange.. Valid values are `network|point-to-point|other`',
    `total_scheduled_mwh` DECIMAL(18,2) COMMENT 'Cumulative megawatt‑hour quantity scheduled for the entire period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the schedule record.',
    CONSTRAINT pk_interchange_schedule PRIMARY KEY(`interchange_schedule_id`)
) COMMENT 'Records of energy interchange transactions scheduled across the transmission system between control areas, RTO/ISO markets, and neighboring utilities. Captures schedule ID, counterparty control area, direction (import/export), scheduled MW profile by hour, energy type (firm/non-firm), FERC tariff service type (network, point-to-point), contract path, e-Tag reference number, market (DAM/RTM), and settlement period. Supports FERC tariff compliance and RTO/ISO scheduling coordination.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`service_request` (
    `service_request_id` BIGINT COMMENT 'Primary key for service_request',
    `business_entity_id` BIGINT COMMENT 'Identifier of the party (e.g., generator, utility, third‑party) that submitted the service request.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service requests are charged to a cost center; the Service Request Cost Allocation Report uses this FK.',
    `service_plan_id` BIGINT COMMENT 'Foreign key linking to product.service_plan. Business justification: Service Request Processing: a request for new transmission service references a service plan that defines applicable rates, terms, and eligibility, used in the Service Request Approval workflow.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Service requests often target a specific line; add FK.',
    `approval_decision` STRING COMMENT 'Final decision outcome after review of the service request.. Valid values are `approved|rejected|pending`',
    `approved_capacity_mw` DECIMAL(18,2) COMMENT 'Capacity approved by the transmission operator after study, in megawatts.',
    `contract_path` STRING COMMENT 'Reference to the contractual document or path governing the service request.',
    `counterparty_control_area` STRING COMMENT 'Control area of the counter‑party involved in the interchange.',
    `created_by_user` STRING COMMENT 'User identifier who created the service request record.',
    `delivery_substation_code` STRING COMMENT 'Code of the substation at the point of delivery.',
    `direction` STRING COMMENT 'Direction of power flow for the service request: import or export.. Valid values are `import|export`',
    `e_tag_number` STRING COMMENT 'Electronic tag reference used for settlement and tracking of the interchange.',
    `energy_type` STRING COMMENT 'Indicates whether the service is for firm or non‑firm energy.. Valid values are `firm|non_firm`',
    `ferc_queue_position` STRING COMMENT 'Position of the request in the FERC Open Access Transmission Tariff queue.',
    `last_updated_by_user` STRING COMMENT 'User identifier who last modified the service request record.',
    `line_rating_mw` DECIMAL(18,2) COMMENT 'Maximum continuous power rating of the transmission line(s) involved, in megawatts.',
    `market_type` STRING COMMENT 'Market in which the scheduled interchange will be settled.. Valid values are `DAM|RTM|DayAhead|RealTime`',
    `outage_impact_flag` BOOLEAN COMMENT 'Indicates whether the requested service could affect system reliability or cause outages.',
    `point_of_delivery` STRING COMMENT 'Named location where power is to be delivered (bus or substation).',
    `point_of_receipt` STRING COMMENT 'Named location where power is to be received (bus or substation).',
    `receipt_substation_code` STRING COMMENT 'Code of the substation at the point of receipt, per utility asset registry.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the data lake.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `request_number` STRING COMMENT 'External business identifier assigned to the service request, used in FERC filings and internal tracking.',
    `request_status` STRING COMMENT 'Current lifecycle status of the service request.. Valid values are `draft|submitted|under_review|approved|rejected|cancelled`',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the service request was initially filed.',
    `request_type` STRING COMMENT 'Category of transmission service being requested, aligned with OATT service classifications.. Valid values are `network_integration|point_to_point_firm|point_to_point_non_firm|capacity_expansion|reliability_service`',
    `requested_capacity_mw` DECIMAL(18,2) COMMENT 'Capacity requested by the party, in megawatts.',
    `requesting_entity_name` STRING COMMENT 'Human‑readable name of the requesting entity.',
    `scheduled_capacity_mw` DECIMAL(18,2) COMMENT 'Capacity scheduled for interchange in the market, in megawatts.',
    `settlement_period_end` DATE COMMENT 'Last day of the settlement period for the scheduled interchange.',
    `settlement_period_start` DATE COMMENT 'First day of the settlement period for the scheduled interchange.',
    `study_status` STRING COMMENT 'Current status of the engineering/economic study for the request.. Valid values are `not_started|in_progress|completed|failed`',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level of the requested transmission path, expressed in kilovolts.',
    CONSTRAINT pk_service_request PRIMARY KEY(`service_request_id`)
) COMMENT 'Records of transmission service requests filed under the FERC Open Access Transmission Tariff (OATT) and their full lifecycle from request through scheduled interchange. Captures request ID, requesting entity, service type (network integration, firm/non-firm point-to-point), points of receipt/delivery, requested capacity (MW), FERC queue position, study statuses, and approval decision. For approved requests, also captures scheduled interchange transactions including counterparty control area, direction (import/export), MW profile by hour, energy type (firm/non-firm), e-Tag reference number, market type (DAM/RTM), contract path, and settlement period. Supports FERC tariff compliance, RTO/ISO scheduling coordination, transmission service lifecycle tracking, and interchange accounting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`tariff` (
    `tariff_id` BIGINT COMMENT 'Primary key for tariff',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Tariffs are applied at the substation level; add FK.',
    `amendment_date` DATE COMMENT 'Date of the most recent amendment to the tariff.',
    `ancillary_service_charges` DECIMAL(18,2) COMMENT 'Additional charges for ancillary services bundled with the tariff.',
    `approval_status` STRING COMMENT 'Current approval state of the tariff with respect to FERC.. Valid values are `approved|pending|rejected|withdrawn`',
    `compliance_status` STRING COMMENT 'Indicates whether the tariff meets current regulatory compliance requirements.. Valid values are `compliant|non_compliant|under_review`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tariff record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts in the tariff.. Valid values are `^[A-Z]{3}$`',
    `demand_charge_unit` STRING COMMENT 'Unit of measure for demand charges (e.g., $/kW or $/MW).. Valid values are `$/kW|$/MW`',
    `effective_date` DATE COMMENT 'Date on which the tariff becomes legally effective.',
    `expiration_date` DATE COMMENT 'Date on which the tariff expires or is superseded.',
    `ferc_docket_number` STRING COMMENT 'Identifier of the FERC docket associated with the tariff filing.',
    `ferc_tariff_number` STRING COMMENT 'Official FERC-assigned number for the tariff schedule.',
    `filing_date` DATE COMMENT 'Date the tariff was filed with the applicable regulatory body.',
    `filing_status` STRING COMMENT 'Current status of the tariff filing process.. Valid values are `filed|not_filed|withdrawn`',
    `is_active` BOOLEAN COMMENT 'Indicates whether the tariff is currently active in the system.',
    `last_approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the tariff was last approved by the regulator.',
    `max_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum power transfer capacity allowed under the tariff, expressed in megawatts.',
    `min_capacity_mw` DECIMAL(18,2) COMMENT 'Minimum guaranteed capacity under the tariff, expressed in megawatts.',
    `notes` STRING COMMENT 'Additional free‑form comments or remarks about the tariff.',
    `off_peak_demand_charge` DECIMAL(18,2) COMMENT 'Charge applied for off‑peak demand usage as defined in the tariff.',
    `peak_demand_charge` DECIMAL(18,2) COMMENT 'Charge applied for peak demand usage as defined in the tariff.',
    `rate_description` STRING COMMENT 'Narrative description of how the transmission rate is calculated.',
    `rate_unit` STRING COMMENT 'Unit of measure for the transmission rate (e.g., $/kW-month or $/MWh).. Valid values are `$/kW-month|$/MWh`',
    `rate_zone` STRING COMMENT 'Geographic or market zone to which the tariff rates apply.',
    `regulatory_body` STRING COMMENT 'Primary regulatory authority governing the tariff.. Valid values are `FERC|NERC|PUC`',
    `revision_number` STRING COMMENT 'Sequential number indicating the revision of the tariff.',
    `service_category` STRING COMMENT 'Broad service classification (e.g., interconnection, transmission service).',
    `source_system` STRING COMMENT 'Name of the source application or system that supplied the tariff record.',
    `source_system_code` STRING COMMENT 'Identifier of the tariff record in the originating source system.',
    `tariff_category` STRING COMMENT 'High‑level classification of the tariff (e.g., transmission, distribution, generation).. Valid values are `transmission|distribution|generation`',
    `tariff_name` STRING COMMENT 'Descriptive name of the transmission tariff as used in business communications.',
    `tariff_type` STRING COMMENT 'Category of the tariff based on FERC approval type.. Valid values are `OATT|OASIS|WHEELING`',
    `transmission_rate` DECIMAL(18,2) COMMENT 'Base transmission charge expressed in the defined rate unit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the tariff record.',
    `version` STRING COMMENT 'Version identifier for the tariff (e.g., v1, v2).',
    CONSTRAINT pk_tariff PRIMARY KEY(`tariff_id`)
) COMMENT 'Master record for each FERC-approved transmission tariff schedule and rate on file. Captures tariff name, FERC tariff number, tariff type (OATT, OASIS, wheeling), service category, rate zone, transmission rate ($/kW-month or $/MWh), ancillary service charges, effective date, expiration date, FERC docket number, and approval status. Serves as the SSOT for transmission tariff rates used in billing, LMP settlement, and FERC compliance reporting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` (
    `interconnection_agreement_id` BIGINT COMMENT 'Primary key for interconnection_agreement',
    `business_entity_id` BIGINT COMMENT 'Foreign key linking to customer.business_entity. Business justification: Regulatory interconnection agreements must be linked to the customer business entity that owns the generation asset for compliance reporting.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Interconnection agreements are executed at a specific substation; replace string field with FK.',
    `agreement_execution_date` DATE COMMENT 'Date the interconnection agreement was signed by all parties.',
    `agreement_number` STRING COMMENT 'External reference number assigned to the interconnection agreement by the utility.',
    `commercial_operation_date` DATE COMMENT 'Date the interconnecting facility began commercial operation.',
    `cost_responsibility` STRING COMMENT 'Allocation of upgrade costs among the generator, utility, or shared.. Valid values are `generator|utility|shared`',
    `effective_from` DATE COMMENT 'Date the agreement becomes legally effective.',
    `effective_until` DATE COMMENT 'Date the agreement expires or is terminated (null if open‑ended).',
    `ferc_acceptance_date` DATE COMMENT 'Date FERC formally accepted the interconnection agreement.',
    `ferc_queue_number` STRING COMMENT 'Identifier assigned by FERC to track the interconnection request in the queue.',
    `interconnecting_party_name` STRING COMMENT 'Legal name of the generator, load, or other entity seeking interconnection.',
    `interconnecting_party_type` STRING COMMENT 'Classification of the interconnecting party (generator, load, or network upgrade).. Valid values are `generator|load|network_upgrade`',
    `interconnection_agreement_status` STRING COMMENT 'Current lifecycle status of the interconnection agreement.. Valid values are `draft|submitted|approved|active|suspended|terminated`',
    `interconnection_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum power transfer capacity approved for the interconnection, in megawatts.',
    `interconnection_type` STRING COMMENT 'Nature of the interconnection request (new, expansion, or upgrade).. Valid values are `new|expansion|upgrade`',
    `network_upgrades_required` STRING COMMENT 'Description of any transmission system upgrades required to accommodate the interconnection.',
    `point_of_interconnection_voltage_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level at the point of interconnection, expressed in kilovolts.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `regulatory_approval_date` DATE COMMENT 'Date regulatory approval was granted.',
    `regulatory_approval_status` STRING COMMENT 'Status of required regulatory approvals for the interconnection.. Valid values are `pending|approved|rejected`',
    `study_completion_date` DATE COMMENT 'Date the interconnection study was completed.',
    `study_status` STRING COMMENT 'Current status of the interconnection study.. Valid values are `pending|in_progress|completed|rejected`',
    `study_type` STRING COMMENT 'Type of engineering study performed for the interconnection request.. Valid values are `feasibility|impact|environmental|grid`',
    `upgrade_cost_actual` DECIMAL(18,2) COMMENT 'Actual cost incurred for network upgrades.',
    `upgrade_cost_estimate` DECIMAL(18,2) COMMENT 'Estimated cost of required network upgrades.',
    CONSTRAINT pk_interconnection_agreement PRIMARY KEY(`interconnection_agreement_id`)
) COMMENT 'Master record for each generator or large customer interconnection agreement executed under FERC interconnection procedures. Captures agreement ID, interconnecting party name, FERC queue number, interconnection type (generator, load, network upgrade), point of interconnection (substation and voltage), interconnection capacity (MW), network upgrades required, cost responsibility allocation, agreement execution date, FERC acceptance date, and commercial operation date. Distinct from energy trading PPAs owned by the trading domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`contingency` (
    `contingency_id` BIGINT COMMENT 'Unique system-generated identifier for the contingency scenario.',
    `associated_ems_case_reference` STRING COMMENT 'Identifier of the EMS case linked to this contingency analysis.',
    `compliance_status` STRING COMMENT 'Current compliance status of the contingency with NERC/ISO requirements.. Valid values are `compliant|non_compliant|pending`',
    `contingency_code` STRING COMMENT 'Business code used to reference the contingency in planning tools and reports.',
    `contingency_description` STRING COMMENT 'Detailed narrative describing the scenario, purpose, and any special considerations.',
    `contingency_name` STRING COMMENT 'Human‑readable name of the contingency scenario.',
    `contingency_status` STRING COMMENT 'Current lifecycle status of the contingency record.. Valid values are `active|inactive|retired|draft`',
    `contingency_type` STRING COMMENT 'Classification of the contingency as N‑1 (single), N‑2 (double) or common‑mode outage.. Valid values are `single|double|common_mode`',
    `corrective_action` STRING COMMENT 'Suggested operator action to mitigate the identified violation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the contingency record was first created.',
    `effective_date` DATE COMMENT 'Date when the contingency becomes valid for operational use.',
    `elements_removed` STRING COMMENT 'Comma‑separated list of transmission elements (lines, transformers, etc.) taken out of service in the scenario.',
    `expiration_date` DATE COMMENT 'Date when the contingency is no longer valid (null if indefinite).',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the contingency is classified as critical for system reliability.',
    `last_review_date` DATE COMMENT 'Date when the contingency was last reviewed for relevance and accuracy.',
    `last_study_date` DATE COMMENT 'Date of the most recent security assessment study for this contingency.',
    `line_rating_mw` DECIMAL(18,2) COMMENT 'Thermal rating of the affected transmission line(s) in megawatts.',
    `nerc_tpl_category` STRING COMMENT 'NERC TPL classification category for the contingency.. Valid values are `Category_A|Category_B|Category_C|Category_D|Category_E|Category_F`',
    `notes` STRING COMMENT 'Free‑form field for additional comments or observations.',
    `outage_impact_estimate_mwh` DECIMAL(18,2) COMMENT 'Estimated energy not delivered due to the contingency, expressed in megawatt‑hours.',
    `planning_horizon_end` DATE COMMENT 'Last date of the planning period for which the contingency is applicable.',
    `planning_horizon_start` DATE COMMENT 'First date of the planning period for which the contingency is applicable.',
    `post_contingency_loading_pct` DECIMAL(18,2) COMMENT 'Loading of the violated element after the contingency is applied.',
    `pre_contingency_loading_pct` DECIMAL(18,2) COMMENT 'Loading of the violated element before the contingency is applied.',
    `priority_level` STRING COMMENT 'Business priority assigned to the contingency for planning and response.. Valid values are `high|medium|low`',
    `region` STRING COMMENT 'Transmission planning region or interconnection area where the contingency applies.',
    `review_owner` STRING COMMENT 'Person or team responsible for the most recent review of the contingency.',
    `source_system` STRING COMMENT 'Originating system that supplied the contingency data (e.g., GE PowerOn DMS).',
    `stability_limit_flag` BOOLEAN COMMENT 'Indicates whether the contingency triggers a stability limit violation (true/false).',
    `study_version` STRING COMMENT 'Version identifier of the study model used for the last analysis.',
    `thermal_overload_limit_pct` DECIMAL(18,2) COMMENT 'Maximum permissible thermal loading (% of rating) for any element under the contingency.',
    `total_violations` STRING COMMENT 'Number of distinct violations identified in the most recent study.',
    `updated_by` STRING COMMENT 'User or system identifier that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the contingency record.',
    `violated_element` STRING COMMENT 'Identifier of the element (line, transformer, etc.) that experienced the worst violation.',
    `violation_threshold_pct` DECIMAL(18,2) COMMENT 'Maximum allowable percentage loading or voltage deviation before a violation is flagged.',
    `voltage_deviation_limit_pct` DECIMAL(18,2) COMMENT 'Maximum permissible voltage deviation (% of nominal) for any bus under the contingency.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level of the affected elements in kilovolts.',
    `created_by` STRING COMMENT 'User or system identifier that created the contingency record.',
    CONSTRAINT pk_contingency PRIMARY KEY(`contingency_id`)
) COMMENT 'Master record for each defined N-1 or N-2 contingency scenario used in transmission planning and real-time security assessment. Captures contingency name, type (single, double, common mode), elements removed, NERC TPL category, planning horizon, violation thresholds, and last study date. Includes violation detail records from analysis runs capturing thermal overloads, voltage deviations, or stability limit violations with violated element, pre/post-contingency loading (% of rating), violation severity, EMS case identifier, and recommended corrective action. Supports NERC TPL compliance documentation, real-time operator alerts, and corrective action plan tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` (
    `contingency_violation_id` BIGINT COMMENT 'Unique surrogate identifier for each contingency violation event.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator who reviewed or acted on the violation.',
    `technician_id` BIGINT COMMENT 'Identifier of the operator who reviewed or acted on the violation.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: A contingency violation is usually caused by a line overload; add FK.',
    `analysis_run_timestamp` TIMESTAMP COMMENT 'Date‑time when the contingency analysis was executed.',
    `contingency_analysis_mode` STRING COMMENT 'Indicates whether the analysis was performed in real‑time or study mode.. Valid values are `real_time|study`',
    `contingency_reference` STRING COMMENT 'Identifier of the contingency scenario (e.g., N-1 line outage) used in the analysis.',
    `contingency_violation_status` STRING COMMENT 'Current lifecycle status of the violation.. Valid values are `open|closed|mitigated`',
    `corrective_action` STRING COMMENT 'Recommended action to mitigate or resolve the violation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the violation record was first created in the data lake.',
    `ems_case_reference` BIGINT COMMENT 'Identifier of the Energy Management System case linked to this violation.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact time the violation was recorded in the system.',
    `limit_units` STRING COMMENT 'Units for the limit value (e.g., MW, %).',
    `limit_value` DECIMAL(18,2) COMMENT 'Threshold value that was exceeded (e.g., thermal limit in MW).',
    `post_contingency_loading_pct` DECIMAL(18,2) COMMENT 'Percent of the elements rating after the contingency was applied.',
    `pre_contingency_loading_pct` DECIMAL(18,2) COMMENT 'Percent of the elements rating before the contingency was applied.',
    `rating_mw` DECIMAL(18,2) COMMENT 'Thermal or voltage rating of the element expressed in megawatts.',
    `rating_units` STRING COMMENT 'Units for the element rating (e.g., MW, kV).',
    `region_code` STRING COMMENT 'Three‑letter code identifying the transmission planning region (e.g., ISO).',
    `resolved_timestamp` TIMESTAMP COMMENT 'Date‑time when the violation was resolved or closed.',
    `severity` STRING COMMENT 'Severity level assigned to the violation for compliance reporting.. Valid values are `critical|high|medium|low`',
    `source_system` STRING COMMENT 'System of record that generated the violation event.. Valid values are `GE PowerOn|OSIsoft PI|Custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the violation record.',
    `violated_element_name` STRING COMMENT 'Human‑readable name of the element that violated limits.',
    `violated_element_reference` BIGINT COMMENT 'Unique identifier of the transmission element (line, transformer, bus, generator) that exceeded its limit.',
    `violated_element_type` STRING COMMENT 'Category of the element that experienced the violation.. Valid values are `line|transformer|bus|generator`',
    `violation_description` STRING COMMENT 'Narrative description of the violation condition.',
    `violation_type` STRING COMMENT 'Classification of the violation (thermal overload, voltage deviation, or stability limit).. Valid values are `thermal|voltage|stability`',
    CONSTRAINT pk_contingency_violation PRIMARY KEY(`contingency_violation_id`)
) COMMENT 'Transactional record of each thermal, voltage, or stability violation identified during contingency analysis runs (real-time or study mode). Captures contingency reference, violated element, violation type (thermal overload, voltage deviation, stability limit), pre-contingency and post-contingency loading (% of rating), violation severity, analysis run timestamp, EMS case identifier, and recommended corrective action. Supports NERC TPL compliance documentation and real-time operator alerts.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` (
    `protection_relay_id` BIGINT COMMENT 'Unique system-generated identifier for each protective relay record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Protection relays are critical field assets; registry linkage supports lifecycle, testing, and compliance documentation.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Relay testing and maintenance procedures require a maintenance crew; crew_id records the responsible crew.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Physical protection relays are tracked as IT assets for lifecycle, warranty, and maintenance management.',
    `line_id` BIGINT COMMENT 'Identifier of the transmission circuit associated with the relay.',
    `transmission_substation_id` BIGINT COMMENT 'Identifier of the substation where the relay is installed.',
    `as_found_setting` DECIMAL(18,2) COMMENT 'Relay setting recorded before maintenance or test.',
    `as_left_setting` DECIMAL(18,2) COMMENT 'Relay setting restored after maintenance or test.',
    `asset_number` STRING COMMENT 'External asset number used in enterprise asset management systems to reference the relay.',
    `commissioning_date` DATE COMMENT 'Date the relay passed initial functional testing and entered service.',
    `condition_status` STRING COMMENT 'Current physical condition of the relay.. Valid values are `good|degraded|failed|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the relay record was first created in the data lake.',
    `current_rating_ka` DECIMAL(18,2) COMMENT 'Maximum fault current the relay can safely interrupt.',
    `data_source_system` STRING COMMENT 'Originating operational system (e.g., Maximo, GE PowerOn).',
    `decommission_date` DATE COMMENT 'Date the relay was removed from service, if applicable.',
    `firmware_version` STRING COMMENT 'Version of the relays embedded firmware.',
    `installation_date` DATE COMMENT 'Date the relay was installed on the transmission asset.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the relay is classified as a critical BES asset under NERC CIP.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity on the relay.',
    `last_test_date` DATE COMMENT 'Most recent date a test event was performed on the relay.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the relay location.',
    `lifecycle_status` STRING COMMENT 'Operational state of the relay within its service life.. Valid values are `active|inactive|retired|maintenance`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the relay location.',
    `maintenance_crew` STRING COMMENT 'Name or identifier of the crew that performed the last maintenance.',
    `maintenance_notes` STRING COMMENT 'Free‑form notes captured during maintenance or testing.',
    `manufacturer` STRING COMMENT 'Company that fabricated the protective relay.',
    `measured_operating_time_ms` BIGINT COMMENT 'Observed operating time of the relay during the test, in milliseconds.',
    `model_number` STRING COMMENT 'Manufacturer‑assigned model designation.',
    `nerc_cip_classification` STRING COMMENT 'Cyber‑security classification of the relay per NERC CIP‑007.',
    `next_test_date` DATE COMMENT 'Planned date for the next required test per maintenance interval.',
    `prc_005_interval_met` BOOLEAN COMMENT 'Indicates whether the NERC PRC‑005 maintenance interval requirement was satisfied.',
    `protected_element` STRING COMMENT 'Transmission asset (line, bus, transformer) that the relay protects.',
    `relay_type` STRING COMMENT 'Category of protective function performed by the relay.. Valid values are `distance|differential|overcurrent|pilot|reclosing`',
    `tag` STRING COMMENT 'Human‑readable tag or label assigned to the relay for field identification.',
    `test_interval_months` STRING COMMENT 'Number of months between required periodic tests.',
    `test_result` STRING COMMENT 'Outcome of the most recent test event.. Valid values are `pass|fail`',
    `test_type` STRING COMMENT 'Category of test performed on the relay.. Valid values are `periodic|post_trip|commissioning`',
    `trip_setting` DECIMAL(18,2) COMMENT 'Numeric setting that triggers a trip, expressed in appropriate units (e.g., amps or kV).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the relay record.',
    `voltage_rating_kv` DECIMAL(18,2) COMMENT 'Maximum system voltage the relay is rated for.',
    `zone_of_protection` STRING COMMENT 'Logical protection zone identifier (e.g., Z1, Z2).',
    CONSTRAINT pk_protection_relay PRIMARY KEY(`protection_relay_id`)
) COMMENT 'Master record for each protective relay device installed on transmission facilities including full test and maintenance history. Captures relay tag, type (distance, differential, overcurrent, pilot), manufacturer, model, firmware, protected element, zone of protection, trip settings, NERC CIP-007 BES cyber asset classification, and condition status. Includes test event records capturing periodic maintenance, post-trip, and commissioning tests with test date, technician crew, results (pass/fail per function), measured operating time (ms), as-found/as-left settings, NERC PRC-005 compliance interval met flag, and next scheduled test date. Supports NERC PRC-005 maintenance interval compliance and Maximo EAM maintenance workflows.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` (
    `relay_test_event_id` BIGINT COMMENT 'Unique identifier for the relay test event record.',
    `approval_user_employee_id` BIGINT COMMENT 'Identifier of the user who approved the test results.',
    `crew_id` BIGINT COMMENT 'Identifier of the crew that performed the test.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who approved the test results.',
    `line_id` BIGINT COMMENT 'Reference to the transmission line that the relay protects.',
    `protection_relay_id` BIGINT COMMENT 'Reference to the protection relay that was tested.',
    `technician_id` BIGINT COMMENT 'Identifier of the lead technician responsible for the test.',
    `technician_lead_technician_id` BIGINT COMMENT 'Identifier of the lead technician responsible for the test.',
    `transmission_substation_id` BIGINT COMMENT 'Reference to the substation where the relay is located.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the test results were approved.',
    `as_found_setting` DECIMAL(18,2) COMMENT 'Relay setting value recorded before the test (as‑found).',
    `as_found_setting_uom` STRING COMMENT 'Unit of measure for the as‑found setting.. Valid values are `pu|percent|amp|volts`',
    `as_left_setting` DECIMAL(18,2) COMMENT 'Relay setting value recorded after the test (as‑left).',
    `as_left_setting_uom` STRING COMMENT 'Unit of measure for the as‑left setting.. Valid values are `pu|percent|amp|volts`',
    `compliance_interval_met` BOOLEAN COMMENT 'Indicates whether the required NERC PRC‑005 maintenance interval was satisfied.',
    `compliance_reviewed_flag` BOOLEAN COMMENT 'Indicates whether the test results have been reviewed for regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the test event record was first created in the system.',
    `function1_result` STRING COMMENT 'Result of the first protection function test.. Valid values are `pass|fail|not_applicable`',
    `function2_result` STRING COMMENT 'Result of the second protection function test.. Valid values are `pass|fail|not_applicable`',
    `function3_result` STRING COMMENT 'Result of the third protection function test.. Valid values are `pass|fail|not_applicable`',
    `function4_result` STRING COMMENT 'Result of the fourth protection function test.. Valid values are `pass|fail|not_applicable`',
    `function5_result` STRING COMMENT 'Result of the fifth protection function test.. Valid values are `pass|fail|not_applicable`',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the relay location.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the relay location.',
    `measurement_source` STRING COMMENT 'System or method used to capture the test data.. Valid values are `scada|pi_historian|manual|other`',
    `next_scheduled_test_date` DATE COMMENT 'Planned date for the next required relay test.',
    `notes` STRING COMMENT 'Free‑form notes entered by the technician about the test.',
    `operating_time_ms` DECIMAL(18,2) COMMENT 'Measured operating time of the relay during the test, expressed in milliseconds.',
    `outage_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the outage caused by the test, in minutes.',
    `outage_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the outage ended, if applicable.',
    `outage_flag` BOOLEAN COMMENT 'Indicates whether the test caused a temporary outage.',
    `outage_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the outage began, if applicable.',
    `regulatory_compliance_code` STRING COMMENT 'Code representing the specific regulatory requirement satisfied by the test.',
    `safety_lockout_flag` BOOLEAN COMMENT 'Indicates whether safety lockout procedures were applied during the test.',
    `test_category` STRING COMMENT 'Broad category of the test activity.. Valid values are `protection|control|monitoring|other`',
    `test_duration_minutes` DECIMAL(18,2) COMMENT 'Total elapsed time of the test activity, in minutes.',
    `test_event_number` STRING COMMENT 'External reference number assigned to the test event for tracking and reporting.',
    `test_priority` STRING COMMENT 'Priority level assigned to the test for scheduling purposes.. Valid values are `high|medium|low`',
    `test_result_overall` STRING COMMENT 'Aggregated result of the relay test.. Valid values are `pass|fail|partial`',
    `test_status` STRING COMMENT 'Current lifecycle status of the test event.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `test_timestamp` TIMESTAMP COMMENT 'Date and time when the relay test was performed.',
    `test_type` STRING COMMENT 'Classification of the test based on its purpose.. Valid values are `periodic|post_trip|commissioning|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the test event record.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage rating of the relay or associated equipment, in kilovolts.',
    CONSTRAINT pk_relay_test_event PRIMARY KEY(`relay_test_event_id`)
) COMMENT 'Transactional record of each protection relay test or maintenance activity performed on a transmission protection relay. Captures test date, test type (periodic maintenance, post-trip, commissioning), technician crew reference, test results (pass/fail per function), measured operating time (ms), as-found and as-left settings, NERC PRC-005 compliance interval met flag, and next scheduled test date. Supports NERC PRC-005 maintenance interval compliance tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` (
    `right_of_way_id` BIGINT COMMENT 'Unique system-generated identifier for the transmission right-of-way corridor.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Vegetation management program assigns a specific crew to each right‑of‑way corridor for compliance inspections.',
    `acreage` DECIMAL(18,2) COMMENT 'Total land area covered by the corridor expressed in acres.',
    `corrective_work_order_reference` STRING COMMENT 'Reference identifier for the work order created to remediate vegetation issues.',
    `corridor_code` STRING COMMENT 'Business code used to uniquely reference the corridor in operational systems.',
    `corridor_name` STRING COMMENT 'Human‑readable name of the right‑of‑way corridor.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the right‑of‑way record was first created in the system.',
    `critical_grow_in_tree_count` STRING COMMENT 'Number of trees identified as high‑risk grow‑in during inspections.',
    `document_reference` STRING COMMENT 'Reference to the legal document that establishes the right‑of‑way.',
    `effective_end_date` DATE COMMENT 'Date when the right‑of‑way expires or is terminated; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the right‑of‑way became effective.',
    `elevation_meters` DECIMAL(18,2) COMMENT 'Average elevation of the corridor above mean sea level, expressed in meters.',
    `encroachment_status` STRING COMMENT 'Current status of vegetation encroachment within the corridor.. Valid values are `none|minor|major|critical`',
    `flash_over_risk_tree_count` STRING COMMENT 'Number of trees posing flash‑over fire risk identified during inspections.',
    `gis_polygon` STRING COMMENT 'Well‑Known Text (WKT) representation of the corridor polygon.',
    `grantor_name` STRING COMMENT 'Name of the entity that granted the right‑of‑way.',
    `grantor_type` STRING COMMENT 'Category of the grantor (e.g., government, utility, private).. Valid values are `government|utility|private|tribal|other`',
    `inspection_count` STRING COMMENT 'Total number of vegetation inspections performed on the corridor.',
    `land_ownership_type` STRING COMMENT 'Classification of land ownership for the corridor (e.g., private, public, leased, easement).. Valid values are `private|public|leased|easement`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent vegetation inspection.',
    `latitude_center` DECIMAL(18,2) COMMENT 'Latitude of the geographic centroid of the corridor.',
    `longitude_center` DECIMAL(18,2) COMMENT 'Longitude of the geographic centroid of the corridor.',
    `nerc_fac003_compliance_status` STRING COMMENT 'Compliance status with NERC FAC‑003 vegetation management requirements.. Valid values are `compliant|non_compliant|pending`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required vegetation inspection.',
    `region_code` STRING COMMENT 'Code representing the utility service region where the corridor resides.',
    `right_of_way_status` STRING COMMENT 'Current operational status of the corridor.. Valid values are `active|inactive|decommissioned|pending`',
    `transmission_line_ids` STRING COMMENT 'Comma‑separated list of transmission line identifiers that traverse the corridor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the right‑of‑way record.',
    `vegetation_zone_classification` STRING COMMENT 'Classification of vegetation management zone based on risk and density.. Valid values are `high|medium|low|critical`',
    `width_feet` DECIMAL(18,2) COMMENT 'Physical width of the right‑of‑way corridor measured in feet.',
    CONSTRAINT pk_right_of_way PRIMARY KEY(`right_of_way_id`)
) COMMENT 'Master record for each transmission right-of-way (ROW) corridor including full vegetation management inspection history. Captures ROW identifier, associated transmission line(s), width, acreage, land ownership type, grantor, recorded document reference, GIS polygon, vegetation management zone classification, and encroachment status. Includes inspection detail records for each vegetation survey (aerial, ground, LiDAR) with inspection date, inspector crew, encroachment findings count, critical grow-in and flash-over risk trees identified, NERC FAC-003 compliance status, corrective work order reference, and next inspection due date. Serves as the SSOT for land rights and NERC FAC-003 vegetation management compliance documentation.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` (
    `vegetation_inspection_id` BIGINT COMMENT 'Unique identifier for the vegetation inspection record.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order created to address findings.',
    `employee_id` BIGINT COMMENT 'Identifier of the inspector or crew conducting the inspection.',
    `right_of_way_id` BIGINT COMMENT 'Identifier of the transmission right-of-way segment inspected.',
    `technician_id` BIGINT COMMENT 'Identifier of the inspector or crew conducting the inspection.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the inspection meets internal compliance criteria.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was created in the system.',
    `crew_reference` STRING COMMENT 'Reference code for the inspection crew.',
    `critical_grow_in_trees` STRING COMMENT 'Number of trees identified with high grow-in risk.',
    `flash_over_risk_trees` STRING COMMENT 'Number of trees posing flash-over risk to transmission lines.',
    `gps_latitude` DOUBLE COMMENT 'Latitude coordinate of the inspection location.',
    `gps_longitude` DOUBLE COMMENT 'Longitude coordinate of the inspection location.',
    `inspection_date` TIMESTAMP COMMENT 'Date and time when the inspection was performed.',
    `inspection_duration_minutes` STRING COMMENT 'Total time spent on the inspection in minutes.',
    `inspection_method` STRING COMMENT 'Method used to conduct the inspection (aerial, ground, LiDAR).. Valid values are `aerial|ground|lidar`',
    `inspection_number` STRING COMMENT 'External reference number assigned to the inspection.',
    `lidar_data_available` BOOLEAN COMMENT 'Indicates if LiDAR data was captured for this inspection.',
    `nerc_fac003_compliance_status` STRING COMMENT 'Compliance status with NERC FAC-003 annual vegetation management requirement.. Valid values are `compliant|non_compliant|exempt`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required vegetation inspection.',
    `notes` STRING COMMENT 'Free-text notes entered by the inspector.',
    `number_of_encroachments` STRING COMMENT 'Count of vegetation encroachments found during inspection.',
    `photo_count` STRING COMMENT 'Number of photos captured during inspection.',
    `priority_level` STRING COMMENT 'Priority assigned for corrective actions based on risk assessment.. Valid values are `high|medium|low|none|unknown|unspecified`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates if this inspection must be reported to regulatory bodies.',
    `risk_score` DOUBLE COMMENT 'Calculated risk score for the inspected segment based on findings.',
    `temperature_c` DOUBLE COMMENT 'Ambient temperature recorded at inspection time.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection record.',
    `vegetation_inspection_status` STRING COMMENT 'Current lifecycle status of the inspection.',
    `vegetation_type` STRING COMMENT 'Primary type of vegetation observed (e.g., trees, shrubs, grass).',
    `weather_conditions` STRING COMMENT 'Weather description during inspection (e.g., clear, rainy, windy).',
    `wind_speed_mps` DOUBLE COMMENT 'Wind speed measured during inspection.',
    CONSTRAINT pk_vegetation_inspection PRIMARY KEY(`vegetation_inspection_id`)
) COMMENT 'Transactional record of each vegetation management inspection or clearance survey conducted along a transmission ROW. Captures inspection date, ROW segment inspected, inspection method (aerial, ground, LiDAR), inspector crew reference, number of encroachment findings, critical grow-in risk trees identified, flash-over risk trees identified, NERC FAC-003 compliance status, corrective work order reference, and next inspection due date. Supports NERC FAC-003 annual compliance documentation.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`planning_study` (
    `planning_study_id` BIGINT COMMENT 'Primary key for planning_study',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Planning studies focus on a particular substation; add FK.',
    `approval_status` STRING COMMENT 'Current approval workflow state of the study.. Valid values are `draft|submitted|approved|rejected|withdrawn`',
    `approved_by` STRING COMMENT 'Name of the individual or authority that approved the study.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the study was approved.',
    `cost_estimate_usd` DECIMAL(18,2) COMMENT 'Estimated cost of implementing study recommendations, in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the study record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date when the study assumptions expire or are superseded (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the study assumptions become effective.',
    `findings_summary` STRING COMMENT 'High‑level summary of study results and recommendations.',
    `generation_mix_percent` DECIMAL(18,2) COMMENT 'Proportion of generation resources by fuel type used in the study assumptions.',
    `interconnection_impact_flag` BOOLEAN COMMENT 'Indicates whether the study evaluates interconnection impacts (true/false).',
    `key_assumptions` STRING COMMENT 'Critical assumptions such as load forecast, generation mix, and policy inputs.',
    `load_forecast_mwh` DECIMAL(18,2) COMMENT 'Projected peak load used in the study, expressed in megawatt‑hours.',
    `nerc_tpl_category` STRING COMMENT 'NERC Transmission Planning Process category addressed by the study.. Valid values are `category_a|category_b|category_c|category_d`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information.',
    `planning_horizon_years` STRING COMMENT 'Number of future years the study evaluates.',
    `planning_study_status` STRING COMMENT 'Operational status of the study record.. Valid values are `active|inactive|archived`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the study meets all applicable regulatory requirements.',
    `risk_assessment_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating assigned to the study outcomes.',
    `software_tool` STRING COMMENT 'Primary simulation or analysis software used (e.g., PSS/E, PowerWorld).. Valid values are `pss_e|powerworld|other`',
    `study_description` STRING COMMENT 'Detailed textual description of the study purpose and scope.',
    `study_document_path` STRING COMMENT 'File system or repository path to the full study documentation.',
    `study_id_code` STRING COMMENT 'External or legacy identifier code for the study.',
    `study_name` STRING COMMENT 'Human‑readable name of the planning study.',
    `study_owner_contact` STRING COMMENT 'Contact information (e.g., email or phone) for the study owner.',
    `study_owner_department` STRING COMMENT 'Internal department responsible for the study.',
    `study_scope` STRING COMMENT 'Geographic or system scope of the study (regional, local, or Bulk Electric System).. Valid values are `regional|local|bes`',
    `study_type` STRING COMMENT 'Category of the planning study (e.g., NERC TPL, IRP, interconnection feasibility, system impact, facilities).. Valid values are `nerc_tpl|irp|interconnection_feasibility|system_impact|facilities`',
    `study_year` STRING COMMENT 'Calendar year in which the study was conducted.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time the study record was last modified.',
    `version_number` STRING COMMENT 'Incremental version of the study record.',
    CONSTRAINT pk_planning_study PRIMARY KEY(`planning_study_id`)
) COMMENT 'Master record for each transmission planning study conducted to assess system adequacy, reliability, or interconnection impacts. Captures study name, study type (NERC TPL, IRP, interconnection feasibility, system impact, facilities), study year, planning horizon (years), study scope (regional, local, BES), software tool used (PSS/E, PowerWorld), key assumptions (load forecast, generation mix), study findings summary, NERC TPL category addressed, and approval status. Supports IRP filings and FERC interconnection queue management.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` (
    `transmission_switching_order_id` BIGINT COMMENT 'System-generated unique identifier for the transmission switching order record.',
    `adjustment_id` BIGINT COMMENT 'Foreign key linking to billing.adjustment. Business justification: Switching Order Cost Adjustment: switching orders may incur cost adjustments; linking to the adjustment record enables financial tracking.',
    `change_request_id` BIGINT COMMENT 'Foreign key linking to technology.change_request. Business justification: Switching orders are processed as change requests in IT change management workflow; required for audit and approval tracking.',
    `control_center_id` BIGINT COMMENT 'Identifier of the control center (e.g., dispatch center) responsible for the order.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Switching orders are executed by a field crew; linking the order to the crew ensures accountability and scheduling.',
    `employee_id` BIGINT COMMENT 'Identifier of the control center operator who issued the switching order.',
    `facility_id` BIGINT COMMENT 'Identifier of the control center (e.g., dispatch center) responsible for the order.',
    `technician_id` BIGINT COMMENT 'Identifier of the control center operator who issued the switching order.',
    `transmission_outage_id` BIGINT COMMENT 'Reference to an outage event that prompted the switching order, if applicable.',
    `work_order_id` BIGINT COMMENT 'Identifier of the maintenance or work order linked to this switching order.',
    `completion_status` STRING COMMENT 'Result of the switching order execution.. Valid values are `success|partial_success|failed|not_started`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the switching order record was first created in the system.',
    `execution_duration_minutes` STRING COMMENT 'Total elapsed minutes between execution start and end timestamps.',
    `execution_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the switching order was completed or terminated.',
    `execution_start_timestamp` TIMESTAMP COMMENT 'Timestamp when field operators began executing the switching steps.',
    `expected_mw_change` DECIMAL(18,2) COMMENT 'Projected net change in megawatt load resulting from the switching actions.',
    `issued_timestamp` TIMESTAMP COMMENT 'Timestamp when the switching order was formally issued to field operators.',
    `last_step_executed` STRING COMMENT 'Sequence number of the most recent step successfully completed.',
    `nerc_cip_compliance_flag` BOOLEAN COMMENT 'Indicates compliance with NERC Critical Infrastructure Protection requirements.',
    `notes` STRING COMMENT 'Free‑form comments entered by operators or engineers regarding the order.',
    `order_number` STRING COMMENT 'Business identifier assigned to the switching order, used in control center workflows and regulatory reporting.',
    `order_status` STRING COMMENT 'Current lifecycle state of the switching order within the control center process.. Valid values are `draft|issued|in_progress|completed|cancelled|failed`',
    `order_type` STRING COMMENT 'Classification of the order based on its purpose and urgency.. Valid values are `planned|emergency|maintenance|recovery`',
    `post_topology_state` STRING COMMENT 'Serialized representation of the transmission network topology after execution.',
    `pre_topology_state` STRING COMMENT 'Serialized representation of the transmission network topology before execution.',
    `priority` STRING COMMENT 'Priority level assigned to the order based on operational impact.. Valid values are `low|medium|high|critical`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the switching order complies with applicable FERC regulations.',
    `safety_clearance_reference` STRING COMMENT 'Document or ticket number confirming safety clearance for the switching operation.',
    `safety_clearance_status` STRING COMMENT 'Current status of the safety clearance process for the order.. Valid values are `cleared|pending|denied`',
    `steps_sequence` STRING COMMENT 'Ordered list of device tags and actions (open/close) encoded as JSON or delimited string.',
    `total_steps` STRING COMMENT 'Count of individual switching actions defined in the order.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the switching order record.',
    CONSTRAINT pk_transmission_switching_order PRIMARY KEY(`transmission_switching_order_id`)
) COMMENT 'Transactional record of each switching order issued to field operators for reconfiguring the transmission network topology (opening/closing breakers, disconnects, or switches). Captures switching order number, issuing control center operator, associated outage or maintenance work order, sequence of switching steps, each steps device tag and action (open/close), safety clearance reference, pre-switching and post-switching topology state, execution start/end timestamp, and completion status. Sourced from GE PowerOn DMS/OMS.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`line_project_assignment` (
    `line_project_assignment_id` BIGINT COMMENT 'Primary key for the LineProjectAssignment association',
    `asset_capex_project_id` BIGINT COMMENT 'Foreign key linking to the capital expenditure project',
    `line_id` BIGINT COMMENT 'Foreign key linking to the transmission line',
    `allocated_budget_amount` DECIMAL(18,2) COMMENT 'Budget amount allocated to this line within the project',
    `project_end_date` DATE COMMENT 'Planned end/completion date for work on this line under the project',
    `project_start_date` DATE COMMENT 'Planned start date for work on this line under the project',
    CONSTRAINT pk_line_project_assignment PRIMARY KEY(`line_project_assignment_id`)
) COMMENT 'Represents the assignment of transmission line segments to capital expenditure projects, capturing the allocated budget and schedule for each line within a project.. Existence Justification: A capital expenditure project can involve multiple transmission line segments, and a single transmission line can be part of multiple projects over its lifecycle (e.g., upgrades, replacements). The utility actively creates, updates, and deletes these line‑project assignments, tracking budget and schedule per line within each project. This operational process makes the relationship a true many‑to‑many entity.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` (
    `right_of_way_agreement_id` BIGINT COMMENT 'Primary key for the right_of_way_agreement association',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to the land parcel',
    `line_id` BIGINT COMMENT 'Foreign key linking to the transmission line',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Compensation paid to the landowner for right‑of‑way use of the segment',
    `segment_length_miles` DECIMAL(18,2) COMMENT 'Length of the transmission line segment that lies within the parcel',
    CONSTRAINT pk_right_of_way_agreement PRIMARY KEY(`right_of_way_agreement_id`)
) COMMENT 'Represents the contractual relationship between a transmission line and a land parcel for right‑of‑way usage. Each record links one line to one parcel and stores the length of the line segment within the parcel and the compensation amount paid to the landowner.. Existence Justification: A transmission line can cross multiple land parcels, and a single parcel can contain sections of multiple transmission lines. The utility actively records each line‑parcel crossing to calculate compensation and track right‑of‑way usage, which is required for regulatory reporting and land‑owner settlements.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_right_of_way_id` FOREIGN KEY (`right_of_way_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`right_of_way`(`right_of_way_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ADD CONSTRAINT `fk_transmission_transmission_transformer_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ADD CONSTRAINT `fk_transmission_topology_bus_id` FOREIGN KEY (`bus_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`bus`(`bus_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ADD CONSTRAINT `fk_transmission_topology_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ADD CONSTRAINT `fk_transmission_topology_to_bus_id` FOREIGN KEY (`to_bus_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`bus`(`bus_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ADD CONSTRAINT `fk_transmission_topology_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ADD CONSTRAINT `fk_transmission_bus_transformer_associated_transmission_transformer_id` FOREIGN KEY (`transformer_associated_transmission_transformer_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_transformer`(`transmission_transformer_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ADD CONSTRAINT `fk_transmission_bus_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ADD CONSTRAINT `fk_transmission_bus_transmission_transformer_id` FOREIGN KEY (`transmission_transformer_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_transformer`(`transmission_transformer_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ADD CONSTRAINT `fk_transmission_line_rating_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ADD CONSTRAINT `fk_transmission_transmission_outage_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ADD CONSTRAINT `fk_transmission_power_flow_snapshot_contingency_id` FOREIGN KEY (`contingency_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`contingency`(`contingency_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ADD CONSTRAINT `fk_transmission_interchange_schedule_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ADD CONSTRAINT `fk_transmission_service_request_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ADD CONSTRAINT `fk_transmission_tariff_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ADD CONSTRAINT `fk_transmission_interconnection_agreement_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ADD CONSTRAINT `fk_transmission_contingency_violation_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ADD CONSTRAINT `fk_transmission_protection_relay_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ADD CONSTRAINT `fk_transmission_protection_relay_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ADD CONSTRAINT `fk_transmission_relay_test_event_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ADD CONSTRAINT `fk_transmission_relay_test_event_protection_relay_id` FOREIGN KEY (`protection_relay_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`protection_relay`(`protection_relay_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ADD CONSTRAINT `fk_transmission_relay_test_event_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ADD CONSTRAINT `fk_transmission_vegetation_inspection_right_of_way_id` FOREIGN KEY (`right_of_way_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`right_of_way`(`right_of_way_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ADD CONSTRAINT `fk_transmission_planning_study_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ADD CONSTRAINT `fk_transmission_transmission_switching_order_transmission_outage_id` FOREIGN KEY (`transmission_outage_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`transmission_outage`(`transmission_outage_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_project_assignment` ADD CONSTRAINT `fk_transmission_line_project_assignment_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` ADD CONSTRAINT `fk_transmission_right_of_way_agreement_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities_v2`.`transmission`.`line`(`line_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`transmission` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities_v2`.`transmission` SET TAGS ('dbx_domain' = 'transmission');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Line Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'From Transmission Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `right_of_way_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `telecom_circuit_id` SET TAGS ('dbx_business_glossary_term' = 'Telecom Circuit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `ampacity_amps` SET TAGS ('dbx_business_glossary_term' = 'Ampacity (A)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `asset_class` SET TAGS ('dbx_value_regex' = 'transmission|substation|switchgear');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Power Transfer Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `circuit_designation` SET TAGS ('dbx_business_glossary_term' = 'Circuit Designation');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `condition_code` SET TAGS ('dbx_business_glossary_term' = 'Condition Code');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `condition_code` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `conductor_size_mm2` SET TAGS ('dbx_business_glossary_term' = 'Conductor Cross‑Sectional Area (mm²)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `conductor_type` SET TAGS ('dbx_business_glossary_term' = 'Conductor Type (CT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `conductor_type` SET TAGS ('dbx_value_regex' = 'ACSR|AAAC|Aluminum|Copper|HTLS|XLP');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `depreciation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation End Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Start Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `environmental_sensitivity_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Sensitivity Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `ferc_jurisdiction_flag` SET TAGS ('dbx_business_glossary_term' = 'FERC Jurisdiction Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `gis_route_geometry` SET TAGS ('dbx_business_glossary_term' = 'GIS Route Geometry (WKT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In‑Service Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `length_miles` SET TAGS ('dbx_business_glossary_term' = 'Line Length (miles)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Code (TLC)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `line_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]+$');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Name (TLN)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Line Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'overhead|underground|submarine|cable|HVDC');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `nerc_bes_classification` SET TAGS ('dbx_business_glossary_term' = 'NERC BES Classification');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `nerc_bes_classification` SET TAGS ('dbx_value_regex' = 'BES|Non-BES');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|planned|decommissioned|maintenance');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `out_of_service_date` SET TAGS ('dbx_business_glossary_term' = 'Out‑of‑Service Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_value_regex' = 'distance|differential|pilot|relay|none');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `right_of_way_type` SET TAGS ('dbx_business_glossary_term' = 'Right‑of‑Way Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `right_of_way_type` SET TAGS ('dbx_value_regex' = 'public|private|easement|lease');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'RTO/ISO Region');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_value_regex' = 'CAISO|ERCOT|MISO|PJM|NYISO|ISO-NE');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `thermal_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Thermal Rating (MVA)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line` ALTER COLUMN `voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `disaster_recovery_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan ID (ERP_ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'FERC Facility Identifier (FACILITY_ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `finance_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Capex Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `gis_boundary_id` SET TAGS ('dbx_business_glossary_term' = 'GIS Polygon Identifier (GIS_POLYGON_ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `address` SET TAGS ('dbx_business_glossary_term' = 'Substation Address (ADDRESS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Substation Area (SQFT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `asset_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Classification Code (ASSET_CLASS_CODE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `asset_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Rating (COND_RATING)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `asset_condition_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Status (COND_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `asset_condition_status` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `asset_depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Asset Depreciation Method (DEPR_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `asset_depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `asset_depreciation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Asset Depreciation Start Date (DEPR_START_DT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `asset_lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Stage (LIFECYCLE_STAGE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `asset_lifecycle_stage` SET TAGS ('dbx_value_regex' = 'planning|construction|in_service|retired|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date (COMMISSION_DT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year (CONST_YEAR)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating (CRIT_RATING)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date (DECOMMISSION_DT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone (EMERG_PHONE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{1,3}[ -]?(?[0-9]{1,4})?[ -]?[0-9]{3,4}[ -]?[0-9]{3,4}$');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `gis_polygon_reference` SET TAGS ('dbx_business_glossary_term' = 'GIS Polygon Identifier (GIS_POLYGON_ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude (LAT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude (LON)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `high_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'High‑Side Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In‑Service Date (IN_SERVICE_DT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (LAST_INSP_DT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `low_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Low‑Side Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `maintenance_contract_expiry` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Expiry (MAINT_EXPIRY)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `maintenance_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Contract Status (MAINT_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `maintenance_contract_status` SET TAGS ('dbx_value_regex' = 'active|expired|none');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `nerc_cip_classification` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Classification (CIP_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `nerc_cip_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date (NEXT_INSP_DT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `number_of_bays` SET TAGS ('dbx_business_glossary_term' = 'Number of Bays (BAYS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|maintenance|outage|decommissioned|planned');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `operator_entity` SET TAGS ('dbx_business_glossary_term' = 'Operator Entity (OPERATOR)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `owner_entity` SET TAGS ('dbx_business_glossary_term' = 'Owner Entity (OWNER)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Substation Risk Score (RISK_SCORE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `rto_node_code` SET TAGS ('dbx_business_glossary_term' = 'RTO/ISO Node Identifier (RTO_NODE_ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type (SITE_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'indoor|outdoor|underground');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `substation_type` SET TAGS ('dbx_business_glossary_term' = 'Substation Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `substation_type` SET TAGS ('dbx_value_regex' = 'switching|transformer|converter|breaker|bus|other');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `transformer_capacity_mva` SET TAGS ('dbx_business_glossary_term' = 'Transformer Capacity (MVA)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `transmission_substation_name` SET TAGS ('dbx_business_glossary_term' = 'Substation Name (NAME)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_substation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `transmission_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Transformer Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Transformer Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `age_years` SET TAGS ('dbx_business_glossary_term' = 'Asset Age (Years)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type (ASSET_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'step_up|step_down|auto|regulating');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating (COND_RATING)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `cooling_type` SET TAGS ('dbx_business_glossary_term' = 'Cooling Type (COOLING)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `cooling_type` SET TAGS ('dbx_value_regex' = 'ONAN|ONAF|OFAF|OFWF');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `criticality` SET TAGS ('dbx_business_glossary_term' = 'Criticality Classification (CRIT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `criticality` SET TAGS ('dbx_value_regex' = 'critical|non_critical|unknown');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `design_type` SET TAGS ('dbx_business_glossary_term' = 'Design Type (DESIGN)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `design_type` SET TAGS ('dbx_value_regex' = 'standard|custom|prototype');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `has_bushing_inspection` SET TAGS ('dbx_business_glossary_term' = 'Bushing Inspection Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `impedance_percent` SET TAGS ('dbx_business_glossary_term' = 'Per‑Unit Impedance (%)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In‑Service Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `losses_watts` SET TAGS ('dbx_business_glossary_term' = 'Transformer Losses (W)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `maintenance_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval (Months)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Transformer Manufacturer (MANUFACTURER)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Transformer Model Number (MODEL)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `mva_rating_emergency` SET TAGS ('dbx_business_glossary_term' = 'Emergency MVA Rating (MVA_EMERGENCY)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `mva_rating_normal` SET TAGS ('dbx_business_glossary_term' = 'Normal MVA Rating (MVA_NORMAL)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `nerc_bes_flag` SET TAGS ('dbx_business_glossary_term' = 'NERC Bulk Electric System Flag (NERC_BES)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `nerc_bes_flag` SET TAGS ('dbx_value_regex' = 'yes|no');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `oil_volume_liters` SET TAGS ('dbx_business_glossary_term' = 'Oil Volume (L)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type (OWNERSHIP)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'internal|external');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `primary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Primary Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `rated_short_circuit_current_ka` SET TAGS ('dbx_business_glossary_term' = 'Rated Short‑Circuit Current (kA)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `secondary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Secondary Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SERIAL)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `tag_number` SET TAGS ('dbx_business_glossary_term' = 'Transformer Tag Number (TAG)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `tap_changer_type` SET TAGS ('dbx_business_glossary_term' = 'Tap Changer Type (TAP)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `tap_changer_type` SET TAGS ('dbx_value_regex' = 'step_up|step_down|auto|regulating');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `thermal_rating_c` SET TAGS ('dbx_business_glossary_term' = 'Thermal Rating (°C)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `transmission_transformer_status` SET TAGS ('dbx_business_glossary_term' = 'Transformer Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `transmission_transformer_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|retired|maintenance|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_transformer` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `topology_id` SET TAGS ('dbx_business_glossary_term' = 'Topology Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `control_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Control Zone Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `bus_id` SET TAGS ('dbx_business_glossary_term' = 'From Bus Identifier (FROM_BUS_ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Circuit Identifier (CIRCUIT_ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `to_bus_id` SET TAGS ('dbx_business_glossary_term' = 'To Bus Identifier (TO_BUS_ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Identifier (SUBSTATION_ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `branch_reference` SET TAGS ('dbx_business_glossary_term' = 'Branch Identifier (BRANCH_ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `branch_type` SET TAGS ('dbx_business_glossary_term' = 'Branch Type (BRANCH_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `branch_type` SET TAGS ('dbx_value_regex' = 'line|transformer');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `conductor_type` SET TAGS ('dbx_business_glossary_term' = 'Conductor Type (CONDUCTOR_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `conductor_type` SET TAGS ('dbx_value_regex' = 'copper|aluminum|composite');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `convergence_status` SET TAGS ('dbx_business_glossary_term' = 'Power Flow Convergence Status (CONVERGENCE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `convergence_status` SET TAGS ('dbx_value_regex' = 'converged|not_converged|partial');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag (DATA_QUALITY_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (GEOGRAPHIC_REGION)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `impedance_r_pu` SET TAGS ('dbx_business_glossary_term' = 'Resistance Impedance (R) per Unit');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `impedance_x_pu` SET TAGS ('dbx_business_glossary_term' = 'Reactance Impedance (X) per Unit');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `interchange_condition` SET TAGS ('dbx_business_glossary_term' = 'Interchange Condition (INTERCHANGE_CONDITION)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `interchange_condition` SET TAGS ('dbx_value_regex' = 'normal|contingency|emergency');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag (IS_CRITICAL_INFRASTRUCTURE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `last_outage_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Outage Timestamp (LAST_OUTAGE_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `length_mi` SET TAGS ('dbx_business_glossary_term' = 'Line Length (MILES)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `line_charging_mvar` SET TAGS ('dbx_business_glossary_term' = 'Line Charging (MVAR)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `losses_mw` SET TAGS ('dbx_business_glossary_term' = 'Branch Losses (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `power_flow_mvar` SET TAGS ('dbx_business_glossary_term' = 'Reactive Power Flow (MVAR)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `power_flow_mw` SET TAGS ('dbx_business_glossary_term' = 'Active Power Flow (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'GE_PowerOn|OSIsoft_PI');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `susceptance_b_pu` SET TAGS ('dbx_business_glossary_term' = 'Susceptance (B) per Unit');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `tap_ratio` SET TAGS ('dbx_business_glossary_term' = 'Transformer Tap Ratio (TAP_RATIO)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `thermal_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Thermal Rating (MVA)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `topology_status` SET TAGS ('dbx_business_glossary_term' = 'Branch Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `topology_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|planned|retired');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Topology Version ID (TOPOLOGY_VERSION_ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`topology` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (KV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `bus_id` SET TAGS ('dbx_business_glossary_term' = 'Bus Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `transformer_associated_transmission_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Transformer Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `transmission_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Transformer Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `area` SET TAGS ('dbx_business_glossary_term' = 'Operational Area');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `bus_description` SET TAGS ('dbx_business_glossary_term' = 'Bus Description');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `bus_name` SET TAGS ('dbx_business_glossary_term' = 'Bus Name');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `bus_number` SET TAGS ('dbx_business_glossary_term' = 'Bus Number (SCADA Identifier)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `bus_status` SET TAGS ('dbx_business_glossary_term' = 'Bus Operational Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `bus_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `bus_type` SET TAGS ('dbx_business_glossary_term' = 'Bus Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `bus_type` SET TAGS ('dbx_value_regex' = 'PQ|PV|slack');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `data_source_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Source System Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `grounding_type` SET TAGS ('dbx_business_glossary_term' = 'Grounding Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `grounding_type` SET TAGS ('dbx_value_regex' = 'solid|resistance|reactor');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `is_critical_bus` SET TAGS ('dbx_business_glossary_term' = 'Critical Bus Indicator');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `is_reserved` SET TAGS ('dbx_business_glossary_term' = 'Reserved Bus Indicator');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `is_slack` SET TAGS ('dbx_business_glossary_term' = 'Slack Bus Indicator');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `last_outage_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Outage Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `long_term_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Long‑Term Rating (MVA)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|none');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `maintenance_window_end` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window End');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `maintenance_window_start` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Window Start');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `max_continuous_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Maximum Continuous Rating (MVA)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `outage_flag` SET TAGS ('dbx_business_glossary_term' = 'Current Outage Indicator');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility|third_party|joint');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `regulatory_compliance_cip` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `rto_iso_node` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Identifier (PNODE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `short_term_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Short‑Term Rating (MVA)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `substation_name` SET TAGS ('dbx_business_glossary_term' = 'Substation Name');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Nominal Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`bus` ALTER COLUMN `zone` SET TAGS ('dbx_business_glossary_term' = 'Control Zone');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `line_rating_id` SET TAGS ('dbx_business_glossary_term' = 'Line Rating ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (°C)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `conductor_temperature_limit_c` SET TAGS ('dbx_business_glossary_term' = 'Conductor Temperature Limit (°C)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_value_regex' = 'internal|FERC|NERC|state_puc');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `line_rating_description` SET TAGS ('dbx_business_glossary_term' = 'Rating Description');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `line_rating_status` SET TAGS ('dbx_business_glossary_term' = 'Rating Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `line_rating_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rating Notes');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `rating_amps` SET TAGS ('dbx_business_glossary_term' = 'Current Rating (Amps)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `rating_category` SET TAGS ('dbx_business_glossary_term' = 'Rating Category');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `rating_category` SET TAGS ('dbx_value_regex' = 'thermal|voltage|ampacity');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `rating_code` SET TAGS ('dbx_business_glossary_term' = 'Rating Code');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `rating_label` SET TAGS ('dbx_business_glossary_term' = 'Rating Label');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_business_glossary_term' = 'Rating Methodology');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `rating_methodology` SET TAGS ('dbx_value_regex' = 'static|dynamic|dlr_sensor|dlr_model');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Thermal Rating (MVA)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `rating_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `rating_type` SET TAGS ('dbx_value_regex' = 'normal|long_term|short_term|emergency');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `rating_version` SET TAGS ('dbx_business_glossary_term' = 'Rating Version');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'winter|spring|summer|fall');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `solar_radiation_w_per_m2` SET TAGS ('dbx_business_glossary_term' = 'Solar Radiation (W/m²)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_rating` ALTER COLUMN `wind_speed_mps` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (m/s)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Outage ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `incident_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Ticket Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `special_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Special Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `actual_end` SET TAGS ('dbx_business_glossary_term' = 'Actual Outage End Timestamp (ACT_END_TS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `actual_start` SET TAGS ('dbx_business_glossary_term' = 'Actual Outage Start Timestamp (ACT_START_TS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `affected_market` SET TAGS ('dbx_business_glossary_term' = 'Affected Market (MARKET)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'Cause Code (CAUSE_CD)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Minutes) (DURATION_MIN)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `impact_mva` SET TAGS ('dbx_business_glossary_term' = 'Outage Impact (MVA) (OUTAGE_MVA)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `impact_mw` SET TAGS ('dbx_business_glossary_term' = 'Outage Impact (MW) (OUTAGE_MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `nerc_cause_category` SET TAGS ('dbx_business_glossary_term' = 'NERC Outage Cause Category (NERC_CAUSE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `nerc_cause_category` SET TAGS ('dbx_value_regex' = 'equipment_failure|weather|human_error|operational|other');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `outage_description` SET TAGS ('dbx_business_glossary_term' = 'Outage Description (OUTAGE_DESC)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `outage_number` SET TAGS ('dbx_business_glossary_term' = 'Outage Request Number (OUTAGE_NUM)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_business_glossary_term' = 'Outage Type (OUTAGE_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_value_regex' = 'planned|forced|emergency|unplanned');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'OE‑417 Reportable Flag (REPORTABLE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage Request Timestamp (REQ_TS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `restoration_details` SET TAGS ('dbx_business_glossary_term' = 'Restoration Details (RESTORE_DESC)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `scheduled_end` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage End Timestamp (SCH_END_TS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `scheduled_start` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Start Timestamp (SCH_START_TS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `transmission_outage_status` SET TAGS ('dbx_business_glossary_term' = 'Outage Lifecycle Status (OUTAGE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `transmission_outage_status` SET TAGS ('dbx_value_regex' = 'requested|approved|in_progress|completed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_outage` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `power_flow_snapshot_id` SET TAGS ('dbx_business_glossary_term' = 'Power Flow Snapshot Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `contingency_id` SET TAGS ('dbx_business_glossary_term' = 'Contingency Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `angle_avg_deg` SET TAGS ('dbx_business_glossary_term' = 'Average Voltage Angle (Degrees)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `angle_max_deg` SET TAGS ('dbx_business_glossary_term' = 'Maximum Voltage Angle (Degrees)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `angle_min_deg` SET TAGS ('dbx_business_glossary_term' = 'Minimum Voltage Angle (Degrees)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'OSIsoft_PI|GE_PowerOn');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'System Frequency (Hz)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `generation_forecast_mw` SET TAGS ('dbx_business_glossary_term' = 'Generation Forecast (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `interchange_schedule_mw` SET TAGS ('dbx_business_glossary_term' = 'Interchange Schedule (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Period Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `load_forecast_mw` SET TAGS ('dbx_business_glossary_term' = 'Load Forecast (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Notes');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Control Zone Code');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `snapshot_status` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Convergence Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `snapshot_status` SET TAGS ('dbx_value_regex' = 'converged|not_converged|partial');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `snapshot_type` SET TAGS ('dbx_business_glossary_term' = 'Snapshot Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `snapshot_type` SET TAGS ('dbx_value_regex' = 'full|partial|incremental');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `solution_status` SET TAGS ('dbx_business_glossary_term' = 'Solution Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `solution_status` SET TAGS ('dbx_value_regex' = 'optimal|feasible|infeasible|error');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `solver_iteration_count` SET TAGS ('dbx_business_glossary_term' = 'Solver Iteration Count');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `system_load_mw` SET TAGS ('dbx_business_glossary_term' = 'System Load (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `system_mvar` SET TAGS ('dbx_business_glossary_term' = 'System Reactive Power (MVAR)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `total_generation_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Generation Dispatch (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `total_interchange_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Interchange Schedule (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `transmission_losses_mw` SET TAGS ('dbx_business_glossary_term' = 'Transmission Losses (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `voltage_avg_kv` SET TAGS ('dbx_business_glossary_term' = 'Average Bus Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `voltage_max_kv` SET TAGS ('dbx_business_glossary_term' = 'Maximum Bus Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`power_flow_snapshot` ALTER COLUMN `voltage_min_kv` SET TAGS ('dbx_business_glossary_term' = 'Minimum Bus Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `interchange_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Schedule Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Source Transmission Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `contract_path` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Path');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `counterparty_control_area` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Control Area Code (CCA)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Interchange Direction (IMPORT/EXPORT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'import|export');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `e_tag_reference` SET TAGS ('dbx_business_glossary_term' = 'Electronic Tag Reference (E‑TAG)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `energy_type` SET TAGS ('dbx_business_glossary_term' = 'Energy Type (FIRM/NON_FIRM)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `energy_type` SET TAGS ('dbx_value_regex' = 'firm|non-firm');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `interchange_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status (SCH_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `interchange_schedule_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|cancelled|rejected');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Market Type (MARKET)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `market` SET TAGS ('dbx_value_regex' = 'DAM|RTM|OTH');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `peak_scheduled_mw` SET TAGS ('dbx_business_glossary_term' = 'Peak Scheduled Power (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `schedule_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Interchange Schedule Number (SCH_NUM)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `schedule_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `scheduled_mw` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Power (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `settlement_period` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period (YYYY‑MM)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `settlement_period` SET TAGS ('dbx_value_regex' = '^d{4}-d{2}$');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `tariff_service_type` SET TAGS ('dbx_business_glossary_term' = 'Tariff Service Type (TAR_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `tariff_service_type` SET TAGS ('dbx_value_regex' = 'network|point-to-point|other');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `total_scheduled_mwh` SET TAGS ('dbx_business_glossary_term' = 'Total Scheduled Energy (MWh)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interchange_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Entity ID (REQ_ENT_ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `service_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Service Plan Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `approval_decision` SET TAGS ('dbx_business_glossary_term' = 'Approval Decision (APPROVAL_DEC)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `approval_decision` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `approved_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Approved Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `contract_path` SET TAGS ('dbx_business_glossary_term' = 'Contract Path (CONTRACT_PATH)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `counterparty_control_area` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Control Area (CP_CA)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User (CREATED_BY)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `delivery_substation_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Substation Code (DEL_SUB_CODE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Direction (DIR)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'import|export');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `e_tag_number` SET TAGS ('dbx_business_glossary_term' = 'E‑Tag Number (ETAG)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `energy_type` SET TAGS ('dbx_business_glossary_term' = 'Energy Type (ENERGY_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `energy_type` SET TAGS ('dbx_value_regex' = 'firm|non_firm');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `ferc_queue_position` SET TAGS ('dbx_business_glossary_term' = 'FERC Queue Position (FERC_Q_POS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `last_updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Last Updated By User (UPDATED_BY)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `line_rating_mw` SET TAGS ('dbx_business_glossary_term' = 'Line Rating (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type (MKT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'DAM|RTM|DayAhead|RealTime');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `outage_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Impact Flag (OUTAGE_IMPACT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `point_of_delivery` SET TAGS ('dbx_business_glossary_term' = 'Point of Delivery (PO_D)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `point_of_receipt` SET TAGS ('dbx_business_glossary_term' = 'Point of Receipt (PO_R)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `receipt_substation_code` SET TAGS ('dbx_business_glossary_term' = 'Receipt Substation Code (REC_SUB_CODE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (REC_CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (REC_UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Request Number (REQ_NUM)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Request Status (REQ_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `request_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|cancelled');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Timestamp (REQ_TS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `request_type` SET TAGS ('dbx_business_glossary_term' = 'Request Type (REQ_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `request_type` SET TAGS ('dbx_value_regex' = 'network_integration|point_to_point_firm|point_to_point_non_firm|capacity_expansion|reliability_service');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `requested_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Requested Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `requesting_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Entity Name (REQ_ENT_NAME)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `scheduled_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `settlement_period_end` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End Date (SETTLE_END)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `settlement_period_start` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start Date (SETTLE_START)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status (STUDY_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`service_request` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (KV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` SET TAGS ('dbx_subdomain' = 'planning_engineering');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `ancillary_service_charges` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Charges');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `demand_charge_unit` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Unit');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `demand_charge_unit` SET TAGS ('dbx_value_regex' = '$/kW|$/MW');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `ferc_docket_number` SET TAGS ('dbx_business_glossary_term' = 'FERC Docket Number');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `ferc_tariff_number` SET TAGS ('dbx_business_glossary_term' = 'FERC Tariff Number');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'filed|not_filed|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `last_approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Approved Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `max_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `min_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Minimum Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `off_peak_demand_charge` SET TAGS ('dbx_business_glossary_term' = 'Off‑Peak Demand Charge');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `peak_demand_charge` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Charge');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `rate_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Description');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Rate Unit');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `rate_unit` SET TAGS ('dbx_value_regex' = '$/kW-month|$/MWh');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `rate_zone` SET TAGS ('dbx_business_glossary_term' = 'Rate Zone');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `tariff_category` SET TAGS ('dbx_business_glossary_term' = 'Tariff Category');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `tariff_category` SET TAGS ('dbx_value_regex' = 'transmission|distribution|generation');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `tariff_name` SET TAGS ('dbx_business_glossary_term' = 'Tariff Name');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `tariff_type` SET TAGS ('dbx_business_glossary_term' = 'Tariff Type (OATT, OASIS, Wheeling)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `tariff_type` SET TAGS ('dbx_value_regex' = 'OATT|OASIS|WHEELING');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `transmission_rate` SET TAGS ('dbx_business_glossary_term' = 'Transmission Rate');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`tariff` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Tariff Version');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` SET TAGS ('dbx_subdomain' = 'planning_engineering');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `interconnection_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Business Entity Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `agreement_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Execution Date (EXEC_DATE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Number (IA_NUM)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `commercial_operation_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Operation Date (COM_OP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `cost_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Cost Responsibility Allocation (COST_RESP)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `cost_responsibility` SET TAGS ('dbx_value_regex' = 'generator|utility|shared');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFFECTIVE_FROM)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFFECTIVE_UNTIL)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `ferc_acceptance_date` SET TAGS ('dbx_business_glossary_term' = 'FERC Acceptance Date (FERC_ACCEPT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `ferc_queue_number` SET TAGS ('dbx_business_glossary_term' = 'FERC Queue Number (FERC_Q_NUM)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `interconnecting_party_name` SET TAGS ('dbx_business_glossary_term' = 'Interconnecting Party Name (IP_NAME)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `interconnecting_party_type` SET TAGS ('dbx_business_glossary_term' = 'Interconnecting Party Type (IP_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `interconnecting_party_type` SET TAGS ('dbx_value_regex' = 'generator|load|network_upgrade');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `interconnection_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Lifecycle Status (AGREEMENT_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `interconnection_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|active|suspended|terminated');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `interconnection_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Capacity (MW) (INT_CAPACITY_MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `interconnection_type` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Type (INT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `interconnection_type` SET TAGS ('dbx_value_regex' = 'new|expansion|upgrade');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `network_upgrades_required` SET TAGS ('dbx_business_glossary_term' = 'Network Upgrades Required (UPGRADES_REQ)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `point_of_interconnection_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Point of Interconnection Voltage (kV) (POI_VOLTAGE_KV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (AUDIT_CREATED)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (AUDIT_UPDATED)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date (REG_APPROVAL_DATE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (REG_APPROVAL_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Study Completion Date (STUDY_COMPLETION_DATE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status (STUDY_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `study_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|rejected');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type (STUDY_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'feasibility|impact|environmental|grid');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `upgrade_cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Cost Actual (UPGRADE_COST_ACT)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`interconnection_agreement` ALTER COLUMN `upgrade_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Cost Estimate (UPGRADE_COST_EST)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `contingency_id` SET TAGS ('dbx_business_glossary_term' = 'Contingency Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `associated_ems_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Associated EMS Case Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `contingency_code` SET TAGS ('dbx_business_glossary_term' = 'Contingency Code');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `contingency_description` SET TAGS ('dbx_business_glossary_term' = 'Contingency Description');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `contingency_name` SET TAGS ('dbx_business_glossary_term' = 'Contingency Name');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `contingency_status` SET TAGS ('dbx_business_glossary_term' = 'Contingency Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `contingency_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `contingency_type` SET TAGS ('dbx_business_glossary_term' = 'Contingency Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `contingency_type` SET TAGS ('dbx_value_regex' = 'single|double|common_mode');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Recommendation');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Contingency Effective Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `elements_removed` SET TAGS ('dbx_business_glossary_term' = 'Elements Removed');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Contingency Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Contingency Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `last_study_date` SET TAGS ('dbx_business_glossary_term' = 'Last Study Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `line_rating_mw` SET TAGS ('dbx_business_glossary_term' = 'Line Rating (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `nerc_tpl_category` SET TAGS ('dbx_business_glossary_term' = 'NERC TPL Category');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `nerc_tpl_category` SET TAGS ('dbx_value_regex' = 'Category_A|Category_B|Category_C|Category_D|Category_E|Category_F');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contingency Notes');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `outage_impact_estimate_mwh` SET TAGS ('dbx_business_glossary_term' = 'Outage Impact Estimate (MWh)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `planning_horizon_end` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon End Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `planning_horizon_start` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon Start Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `post_contingency_loading_pct` SET TAGS ('dbx_business_glossary_term' = 'Post‑Contingency Loading Percentage');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `pre_contingency_loading_pct` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Contingency Loading Percentage');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Contingency Priority Level');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `review_owner` SET TAGS ('dbx_business_glossary_term' = 'Review Owner');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `stability_limit_flag` SET TAGS ('dbx_business_glossary_term' = 'Stability Limit Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `study_version` SET TAGS ('dbx_business_glossary_term' = 'Study Version Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `thermal_overload_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Thermal Overload Limit Percentage');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `total_violations` SET TAGS ('dbx_business_glossary_term' = 'Total Violation Count');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `violated_element` SET TAGS ('dbx_business_glossary_term' = 'Violating Element Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `violation_threshold_pct` SET TAGS ('dbx_business_glossary_term' = 'Violation Threshold Percentage');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `voltage_deviation_limit_pct` SET TAGS ('dbx_business_glossary_term' = 'Voltage Deviation Limit Percentage');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `contingency_violation_id` SET TAGS ('dbx_business_glossary_term' = 'Contingency Violation ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `analysis_run_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Analysis Run Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `contingency_analysis_mode` SET TAGS ('dbx_business_glossary_term' = 'Contingency Analysis Mode');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `contingency_analysis_mode` SET TAGS ('dbx_value_regex' = 'real_time|study');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `contingency_reference` SET TAGS ('dbx_business_glossary_term' = 'Contingency Reference (ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `contingency_violation_status` SET TAGS ('dbx_business_glossary_term' = 'Violation Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `contingency_violation_status` SET TAGS ('dbx_value_regex' = 'open|closed|mitigated');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `ems_case_reference` SET TAGS ('dbx_business_glossary_term' = 'EMS Case ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Violation Event Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `limit_units` SET TAGS ('dbx_business_glossary_term' = 'Limit Units');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `limit_value` SET TAGS ('dbx_business_glossary_term' = 'Limit Value');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `post_contingency_loading_pct` SET TAGS ('dbx_business_glossary_term' = 'Post‑Contingency Loading (%)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `pre_contingency_loading_pct` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Contingency Loading (%)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `rating_mw` SET TAGS ('dbx_business_glossary_term' = 'Element Rating (MW)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `rating_units` SET TAGS ('dbx_business_glossary_term' = 'Rating Units');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `resolved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Violation Severity');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'GE PowerOn|OSIsoft PI|Custom');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `violated_element_name` SET TAGS ('dbx_business_glossary_term' = 'Violating Element Name');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `violated_element_reference` SET TAGS ('dbx_business_glossary_term' = 'Violating Element ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `violated_element_type` SET TAGS ('dbx_business_glossary_term' = 'Violating Element Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `violated_element_type` SET TAGS ('dbx_value_regex' = 'line|transformer|bus|generator');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `violation_description` SET TAGS ('dbx_business_glossary_term' = 'Violation Description');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`contingency_violation` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'thermal|voltage|stability');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `protection_relay_id` SET TAGS ('dbx_business_glossary_term' = 'Protection Relay Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Circuit Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `as_found_setting` SET TAGS ('dbx_business_glossary_term' = 'As‑Found Setting');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `as_left_setting` SET TAGS ('dbx_business_glossary_term' = 'As‑Left Setting');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number (Asset ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `condition_status` SET TAGS ('dbx_business_glossary_term' = 'Condition Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `condition_status` SET TAGS ('dbx_value_regex' = 'good|degraded|failed|unknown');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `current_rating_ka` SET TAGS ('dbx_business_glossary_term' = 'Current Rating (kA)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Asset Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|maintenance');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `maintenance_crew` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Crew');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `maintenance_notes` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Notes');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Relay Manufacturer');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `measured_operating_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Measured Operating Time (ms)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Relay Model Number');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `nerc_cip_classification` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP‑007 Classification');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `next_test_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Test Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `prc_005_interval_met` SET TAGS ('dbx_business_glossary_term' = 'PRC‑005 Interval Met Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `protected_element` SET TAGS ('dbx_business_glossary_term' = 'Protected Element');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `relay_type` SET TAGS ('dbx_business_glossary_term' = 'Relay Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `relay_type` SET TAGS ('dbx_value_regex' = 'distance|differential|overcurrent|pilot|reclosing');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `tag` SET TAGS ('dbx_business_glossary_term' = 'Relay Tag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `test_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Test Interval (Months)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `test_result` SET TAGS ('dbx_business_glossary_term' = 'Test Result');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `test_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'periodic|post_trip|commissioning');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `trip_setting` SET TAGS ('dbx_business_glossary_term' = 'Trip Setting (Setting Value)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `voltage_rating_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Rating (kV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`protection_relay` ALTER COLUMN `zone_of_protection` SET TAGS ('dbx_business_glossary_term' = 'Zone of Protection');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `relay_test_event_id` SET TAGS ('dbx_business_glossary_term' = 'Relay Test Event ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `approval_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval User Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `approval_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `approval_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Crew Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval User Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `protection_relay_id` SET TAGS ('dbx_business_glossary_term' = 'Relay Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Technician Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `technician_lead_technician_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Technician Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `as_found_setting` SET TAGS ('dbx_business_glossary_term' = 'As-Found Setting Value');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `as_found_setting_uom` SET TAGS ('dbx_business_glossary_term' = 'As-Found Setting Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `as_found_setting_uom` SET TAGS ('dbx_value_regex' = 'pu|percent|amp|volts');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `as_left_setting` SET TAGS ('dbx_business_glossary_term' = 'As-Left Setting Value');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `as_left_setting_uom` SET TAGS ('dbx_business_glossary_term' = 'As-Left Setting Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `as_left_setting_uom` SET TAGS ('dbx_value_regex' = 'pu|percent|amp|volts');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `compliance_interval_met` SET TAGS ('dbx_business_glossary_term' = 'NERC PRC-005 Compliance Interval Met Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `compliance_reviewed_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Completed Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `function1_result` SET TAGS ('dbx_business_glossary_term' = 'Function 1 Test Result');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `function1_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `function2_result` SET TAGS ('dbx_business_glossary_term' = 'Function 2 Test Result');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `function2_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `function3_result` SET TAGS ('dbx_business_glossary_term' = 'Function 3 Test Result');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `function3_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `function4_result` SET TAGS ('dbx_business_glossary_term' = 'Function 4 Test Result');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `function4_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `function5_result` SET TAGS ('dbx_business_glossary_term' = 'Function 5 Test Result');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `function5_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source System');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `measurement_source` SET TAGS ('dbx_value_regex' = 'scada|pi_historian|manual|other');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `next_scheduled_test_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Test Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Test Notes');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `operating_time_ms` SET TAGS ('dbx_business_glossary_term' = 'Operating Time (Milliseconds)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `outage_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `outage_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `outage_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `regulatory_compliance_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Code');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `safety_lockout_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Lockout Applied Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_category` SET TAGS ('dbx_business_glossary_term' = 'Test Category');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_category` SET TAGS ('dbx_value_regex' = 'protection|control|monitoring|other');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_event_number` SET TAGS ('dbx_business_glossary_term' = 'Test Event Number');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_priority` SET TAGS ('dbx_business_glossary_term' = 'Test Priority');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_result_overall` SET TAGS ('dbx_business_glossary_term' = 'Overall Test Result (Pass/Fail/Partial)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_result_overall` SET TAGS ('dbx_value_regex' = 'pass|fail|partial');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status (Scheduled, In Progress, Completed, Cancelled, Failed)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type (Periodic, Post-Trip, Commissioning, Other)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'periodic|post_trip|commissioning|other');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`relay_test_event` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `right_of_way_id` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Way Identifier (ROW ID)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `acreage` SET TAGS ('dbx_business_glossary_term' = 'Corridor Area (Acres)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `corrective_work_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Corrective Work Order Reference (Work Order Ref)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `corridor_code` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Way Corridor Code (ROW Corridor Code)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `corridor_name` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Way Corridor Name (ROW Corridor Name)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created Timestamp)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `critical_grow_in_tree_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Grow‑In Tree Count (Critical Grow-In Tree Count)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Identifier (Doc Ref)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (Effective Until)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (Effective From)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `elevation_meters` SET TAGS ('dbx_business_glossary_term' = 'Elevation Meters (Elevation Meters)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `encroachment_status` SET TAGS ('dbx_business_glossary_term' = 'Encroachment Status (Encroachment Status)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `encroachment_status` SET TAGS ('dbx_value_regex' = 'none|minor|major|critical');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `flash_over_risk_tree_count` SET TAGS ('dbx_business_glossary_term' = 'Flash‑Over Risk Tree Count (Flash-Over Risk Tree Count)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `gis_polygon` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System Polygon (GIS Polygon)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `grantor_name` SET TAGS ('dbx_business_glossary_term' = 'Grantor Name (Grantor)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `grantor_type` SET TAGS ('dbx_business_glossary_term' = 'Grantor Type (Grantor Category)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `grantor_type` SET TAGS ('dbx_value_regex' = 'government|utility|private|tribal|other');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `inspection_count` SET TAGS ('dbx_business_glossary_term' = 'Inspection Count (Inspection Count)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `land_ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Land Ownership Type (Ownership Type)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `land_ownership_type` SET TAGS ('dbx_value_regex' = 'private|public|leased|easement');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (Last Inspection Date)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `latitude_center` SET TAGS ('dbx_business_glossary_term' = 'Latitude Center (Latitude Center)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `latitude_center` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `latitude_center` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `longitude_center` SET TAGS ('dbx_business_glossary_term' = 'Longitude Center (Longitude Center)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `longitude_center` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `longitude_center` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `nerc_fac003_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'NERC FAC-003 Compliance Status (NERC FAC-003 Status)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `nerc_fac003_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date (Next Inspection Due)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region Code (Region Code)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `right_of_way_status` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Way Status (ROW Status)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `right_of_way_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|pending');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `transmission_line_ids` SET TAGS ('dbx_business_glossary_term' = 'Associated Transmission Line Identifiers (Line IDs)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (Updated Timestamp)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `vegetation_zone_classification` SET TAGS ('dbx_business_glossary_term' = 'Vegetation Management Zone Classification (Veg Zone Class)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `vegetation_zone_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low|critical');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way` ALTER COLUMN `width_feet` SET TAGS ('dbx_business_glossary_term' = 'Corridor Width (Feet)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `vegetation_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Vegetation Inspection ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `right_of_way_id` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Way Segment ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `crew_reference` SET TAGS ('dbx_business_glossary_term' = 'Crew Reference');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `critical_grow_in_trees` SET TAGS ('dbx_business_glossary_term' = 'Critical Grow-In Risk Trees');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `flash_over_risk_trees` SET TAGS ('dbx_business_glossary_term' = 'Flash-Over Risk Trees');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date and Time');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `inspection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_value_regex' = 'aerial|ground|lidar');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `lidar_data_available` SET TAGS ('dbx_business_glossary_term' = 'LiDAR Data Available');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `nerc_fac003_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'NERC FAC-003 Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `nerc_fac003_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `number_of_encroachments` SET TAGS ('dbx_business_glossary_term' = 'Number of Encroachments');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `photo_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Count');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'high|medium|low|none|unknown|unspecified');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Temperature (Celsius)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `vegetation_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `vegetation_type` SET TAGS ('dbx_business_glossary_term' = 'Vegetation Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`vegetation_inspection` ALTER COLUMN `wind_speed_mps` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (m/s)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` SET TAGS ('dbx_subdomain' = 'planning_engineering');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `planning_study_id` SET TAGS ('dbx_business_glossary_term' = 'Planning Study Identifier');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `cost_estimate_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `generation_mix_percent` SET TAGS ('dbx_business_glossary_term' = 'Generation Mix Percentage');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `interconnection_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Impact Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `key_assumptions` SET TAGS ('dbx_business_glossary_term' = 'Key Assumptions');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `load_forecast_mwh` SET TAGS ('dbx_business_glossary_term' = 'Load Forecast (MWh)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `nerc_tpl_category` SET TAGS ('dbx_business_glossary_term' = 'NERC TPL Category');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `nerc_tpl_category` SET TAGS ('dbx_value_regex' = 'category_a|category_b|category_c|category_d');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `planning_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (Years)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `planning_study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `planning_study_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `software_tool` SET TAGS ('dbx_business_glossary_term' = 'Software Tool');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `software_tool` SET TAGS ('dbx_value_regex' = 'pss_e|powerworld|other');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `study_description` SET TAGS ('dbx_business_glossary_term' = 'Study Description');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `study_document_path` SET TAGS ('dbx_business_glossary_term' = 'Study Document Path');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `study_id_code` SET TAGS ('dbx_business_glossary_term' = 'Study Identifier Code');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `study_owner_contact` SET TAGS ('dbx_business_glossary_term' = 'Study Owner Contact');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `study_owner_department` SET TAGS ('dbx_business_glossary_term' = 'Study Owner Department');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `study_scope` SET TAGS ('dbx_business_glossary_term' = 'Study Scope');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `study_scope` SET TAGS ('dbx_value_regex' = 'regional|local|bes');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'nerc_tpl|irp|interconnection_feasibility|system_impact|facilities');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `study_year` SET TAGS ('dbx_business_glossary_term' = 'Study Year');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`planning_study` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` SET TAGS ('dbx_subdomain' = 'network_operations');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `transmission_switching_order_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Switching Order ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `control_center_id` SET TAGS ('dbx_business_glossary_term' = 'Control Center ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Control Center ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Outage ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'success|partial_success|failed|not_started');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `execution_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Execution Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `execution_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `execution_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Execution Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `expected_mw_change` SET TAGS ('dbx_business_glossary_term' = 'Expected MW Change');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `issued_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Issued Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `last_step_executed` SET TAGS ('dbx_business_glossary_term' = 'Last Step Executed Index');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `nerc_cip_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operator Notes');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Number');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|issued|in_progress|completed|cancelled|failed');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Type');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'planned|emergency|maintenance|recovery');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `post_topology_state` SET TAGS ('dbx_business_glossary_term' = 'Post‑Switching Topology State');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `pre_topology_state` SET TAGS ('dbx_business_glossary_term' = 'Pre‑Switching Topology State');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Priority');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `safety_clearance_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Clearance Reference');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `safety_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Clearance Status');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `safety_clearance_status` SET TAGS ('dbx_value_regex' = 'cleared|pending|denied');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `steps_sequence` SET TAGS ('dbx_business_glossary_term' = 'Switching Steps Sequence');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `total_steps` SET TAGS ('dbx_business_glossary_term' = 'Total Number of Steps');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`transmission_switching_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_project_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_project_assignment` SET TAGS ('dbx_subdomain' = 'planning_engineering');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_project_assignment` SET TAGS ('dbx_association_edges' = 'transmission.line,asset.asset_capex_project');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_project_assignment` ALTER COLUMN `line_project_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Lineprojectassignment - Line Project Assignment Id');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_project_assignment` ALTER COLUMN `asset_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Lineprojectassignment - Asset Capex Project Id');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_project_assignment` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Lineprojectassignment - Transmission Line Id');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_project_assignment` ALTER COLUMN `allocated_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Allocated Budget');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_project_assignment` ALTER COLUMN `project_end_date` SET TAGS ('dbx_business_glossary_term' = 'Line Project End Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`line_project_assignment` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Line Project Start Date');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` SET TAGS ('dbx_association_edges' = 'transmission.line,property.parcel');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` ALTER COLUMN `right_of_way_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Agreement - Right Of Way Agreement Id');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Agreement - Parcel Id');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Right Of Way Agreement - Transmission Line Id');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`transmission`.`right_of_way_agreement` ALTER COLUMN `segment_length_miles` SET TAGS ('dbx_business_glossary_term' = 'Segment Length');
