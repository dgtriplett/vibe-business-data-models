-- Schema for Domain: metering | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:17

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`metering` COMMENT 'Owns all meter asset records, AMI device configurations, interval read data, and meter data validation, estimation, and editing (VEE) workflows. Serves as the SSOT for meter-to-premise associations, register reads, interval energy data (kWh, MCF, Therms), meter events, and data quality. Managed through Oracle Utilities MDM. Supports TOU, RTP, and CPP rate structures and feeds billing with validated consumption.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`meter` (
    `meter_id` BIGINT COMMENT 'Primary key for meter',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Asset Management process requires linking each physical meter to its asset record for depreciation, work‑order assignment, and compliance reporting.',
    `distribution_service_point_id` BIGINT COMMENT 'Reference to the logical service delivery point representing the utility-customer interconnection. One service point may have multiple meters (e.g., generation and consumption). Used for billing aggregation and rate application.',
    `distribution_transformer_id` BIGINT COMMENT 'Reference to the distribution transformer serving this meter. Used for load balancing, outage analysis, and grid planning. Critical for AMI-based transformer load management and phase identification.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue recognition per meter posts sales to a specific GL account; required for monthly revenue statements.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Installation Process: records which technician installed the meter for warranty, compliance, and asset‑management reporting.',
    `it_asset_id` BIGINT COMMENT 'Unique identifier for the AMI communication endpoint or network interface card attached to or embedded in the meter. Used for network provisioning, firmware updates, and outage detection.',
    `location_id` BIGINT COMMENT 'Reference to the physical installation location of the meter. Links to asset location registry with GPS coordinates, address, and GIS spatial data. Used for field dispatch, outage correlation, and service territory mapping.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Needed for asset cost tracking and inventory reconciliation, linking each meter to its material master part number.',
    `pole_id` BIGINT COMMENT 'Foreign key linking to distribution.pole. Business justification: Required for field crew maintenance and outage response reports that map each meter to its mounting pole, enabling precise asset location and work order generation.',
    `premise_id` BIGINT COMMENT 'Reference to the service premise (property/building) where the meter is installed. Critical link between metering, billing, and customer systems. Supports multi-meter premises and meter-to-premise history.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: SCADA Integration process assigns each meter to a SCADA system for remote reading and regulatory data submission.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Required for warranty management and vendor performance reports that tie each installed meter to its supplying vendor.',
    `vpp_agreement_id` BIGINT COMMENT 'Foreign key linking to engagement.vpp_agreement. Business justification: VPP Participation Agreements list the meters enrolled for dispatch; regulatory filing mandates explicit meter identifiers.',
    `accuracy_class` STRING COMMENT 'ANSI accuracy classification indicating maximum allowable measurement error as a percentage of full scale. Lower numbers indicate higher precision. Determines testing frequency and revenue-grade certification requirements.. Valid values are `0.2|0.5|1.0|2.0`',
    `communication_protocol` STRING COMMENT 'Technical protocol standard used for meter-to-headend communication (e.g., ANSI C12.18, ANSI C12.19, DLMS/COSEM, Zigbee, cellular). Determines data format, security requirements, and system integration approach.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this meter record was first created in the MDM system. Used for data lineage, audit trails, and system integration reconciliation. Immutable after initial creation.',
    `ct_ratio` STRING COMMENT 'Current transformer ratio for instrument-rated meters (e.g., 200:5, 400:5). Used to calculate actual consumption from meter readings. Null for self-contained meters. Critical for accurate billing calculations.',
    `current_rating_amps` DECIMAL(18,2) COMMENT 'Maximum continuous current rating of the electric meter in amperes. Determines meter capacity and must align with service entrance equipment ratings. Used for load analysis and meter sizing validation.',
    `demand_metering_enabled` BOOLEAN COMMENT 'Indicates whether the meter measures and records peak demand (kW) in addition to energy consumption (kWh). Required for commercial/industrial rate structures with demand charges. Determines billing calculation logic.',
    `expected_life_years` STRING COMMENT 'Estimated useful life of the meter asset in years for depreciation and replacement planning. Typically 15-30 years depending on technology and service class. Used for capital planning and rate case filings.',
    `firmware_version` STRING COMMENT 'Current firmware version installed on the meter device. Critical for security patch management, feature enablement, and compatibility with MDM system. Format varies by manufacturer.',
    `form` STRING COMMENT 'ANSI standard form designation indicating meter socket configuration and wiring arrangement (e.g., Form 2S, Form 12S, Form 16S). Determines physical installation requirements and measurement capabilities.',
    `installation_date` DATE COMMENT 'Date the meter was physically installed at the current service location. Used for age analysis, warranty tracking, and lifecycle management. Distinct from manufacturing date.',
    `installation_status` STRING COMMENT 'Current physical deployment state of the meter asset. Installed indicates active field deployment. In_stock indicates warehouse inventory. In_shop indicates repair/testing. Retired indicates end-of-life but not yet disposed.. Valid values are `installed|removed|in_stock|in_shop|retired|scrapped`',
    `last_communication_timestamp` TIMESTAMP COMMENT 'Timestamp of most recent successful data exchange between the meter and the MDM headend system. Used for communication health monitoring, outage detection, and data quality assessment.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the meter device (e.g., Landis+Gyr, Itron, Sensus, Elster, Aclara). Used for warranty tracking, firmware compatibility, and vendor performance analysis.',
    `meter_class` STRING COMMENT 'Customer service class designation for the meter installation. Determines applicable tariffs, demand response eligibility, and regulatory rate class assignment.. Valid values are `residential|commercial|industrial`',
    `meter_number` STRING COMMENT 'Manufacturer-assigned serial number stamped on the physical meter device. Externally visible identifier used for field operations, inventory tracking, and regulatory reporting. Must be unique across the service territory.. Valid values are `^[A-Z0-9]{8,20}$`',
    `meter_type` STRING COMMENT 'Type of utility commodity measured by this meter device. Determines applicable rate structures, measurement units, and regulatory reporting requirements.. Valid values are `electric|gas|water|steam`',
    `model_number` STRING COMMENT 'Manufacturer model designation identifying the specific meter product line and configuration. Used to determine technical specifications, communication protocols, and compatible firmware versions.',
    `multiplier` DECIMAL(18,2) COMMENT 'Numeric multiplier applied to meter register readings to calculate actual consumption. Derived from CT/PT ratios and meter configuration. Essential for accurate billing and energy accounting.',
    `net_metering_enabled` BOOLEAN COMMENT 'Indicates whether the meter supports bidirectional energy measurement for customer-owned generation (solar, wind). True for NEM-eligible installations. Requires meter capable of measuring both delivered and received energy.',
    `next_test_due_date` DATE COMMENT 'Scheduled date for next required accuracy test or recertification. Calculated based on last test date and regulatory testing interval. Used for compliance tracking and preventive maintenance scheduling.',
    `number_of_dials` STRING COMMENT 'Count of mechanical register dials on the meter face for manual reading. Determines reading format and maximum register capacity. Typically 4-6 dials for residential, more for commercial/industrial.',
    `operational_status` STRING COMMENT 'Current operational state indicating whether the meter is actively measuring and reporting consumption. Active meters generate billable reads. Failed meters require replacement. Testing indicates commissioning or troubleshooting.. Valid values are `active|inactive|suspended|testing|failed`',
    `ownership_type` STRING COMMENT 'Legal ownership designation for the meter asset. Utility_owned meters are capitalized assets. Customer_owned meters are tracked for service but not depreciated. Third_party indicates DER or submetering arrangements.. Valid values are `utility_owned|customer_owned|third_party`',
    `pt_ratio` STRING COMMENT 'Potential transformer ratio for high-voltage metering installations (e.g., 7200:120). Used with CT ratio to calculate actual energy consumption. Null for low-voltage self-contained meters.',
    `purchase_cost` DECIMAL(18,2) COMMENT 'Original acquisition cost of the meter device in USD. Used for asset capitalization, depreciation calculations, and rate base reporting. Includes device cost only, not installation labor.',
    `purchase_date` DATE COMMENT 'Date the utility acquired the meter from the manufacturer or vendor. Used for warranty tracking, depreciation calculations, and procurement analytics. May differ from installation date.',
    `read_cycle` STRING COMMENT 'Billing cycle designation indicating when the meter is read each month (e.g., cycle 01 = 1st-5th of month). Used for billing schedule coordination and read validation. Typically 20-30 cycles per service territory.',
    `register_capacity_kwh` DECIMAL(18,2) COMMENT 'Maximum cumulative energy value the meter register can display before rolling over to zero. Used to detect and correct rollover events in consumption calculations. Measured in kilowatt-hours for electric meters.',
    `remote_disconnect_capable` BOOLEAN COMMENT 'Indicates whether the meter has an integrated service switch that can be remotely controlled to connect or disconnect service. Used for credit management, move-in/move-out automation, and emergency load shedding.',
    `removal_date` DATE COMMENT 'Date the meter was removed from service at a premise. Null for currently installed meters. Used for lifecycle tracking, final billing, and asset disposition workflows.',
    `route_code` STRING COMMENT 'Geographic route assignment for manual meter reading or field inspection. Used for workforce scheduling and route optimization. May be null for AMI meters with automated reading.',
    `seal_number` STRING COMMENT 'Unique identifier of the tamper-evident seal applied to the meter enclosure. Used to detect unauthorized access, meter tampering, and theft of service. Recorded during installation and verified during field inspections.',
    `test_date` DATE COMMENT 'Date of most recent accuracy test or calibration performed on the meter. Used to schedule periodic testing per regulatory requirements and manufacturer recommendations. Typically required every 5-15 years depending on jurisdiction.',
    `time_of_use_enabled` BOOLEAN COMMENT 'Indicates whether the meter is configured to collect interval data for time-differentiated rate structures. True for meters supporting TOU, CPP, or RTP rates. Requires AMI technology and MDM interval data processing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of most recent modification to any field in this meter record. Used for change data capture, downstream system synchronization, and data quality monitoring. Updated automatically on every record change.',
    `voltage_class` STRING COMMENT 'Nominal voltage rating for electric meters indicating the electrical service level. Used for safety compliance, meter selection, and grid operations. Primary voltage indicates high-voltage metering with instrument transformers.. Valid values are `120V|240V|277V|480V|primary`',
    `warranty_expiration_date` DATE COMMENT 'Date the manufacturer warranty coverage expires. Used to determine repair vs. replace decisions and vendor claim eligibility. Typically 5-10 years from purchase date.',
    CONSTRAINT pk_meter PRIMARY KEY(`meter_id`)
) COMMENT 'Master record for every physical meter device deployed across the service territory, covering both electric (AMI/AMR) and gas meters. Stores device identity, manufacturer, model, firmware version, communication module type, meter form factor, voltage class, CT/PT ratios, dial multiplier, number of dials, seal number, AMI endpoint ID, communication protocol (ANSI C12.18/C12.19), installation status, and lifecycle state. Sourced from Oracle Utilities MDM and Maximo EAM. SSOT for meter asset identity in the metering domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` (
    `meter_configuration_id` BIGINT COMMENT 'Unique surrogate key for each meter configuration record.',
    `meter_id` BIGINT COMMENT 'Identifier of the meter to which this configuration applies.',
    `rate_schedule_id` BIGINT COMMENT 'Reference to the Critical Peak Pricing rate plan associated with this configuration.',
    `tariff_schedule_id` BIGINT COMMENT 'Reference to the Real‑Time Pricing rate plan associated with this configuration.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Configuration Change Control: ties configuration updates to the authorizing technician, needed for audit trails and regulatory compliance.',
    `tou_schedule_id` BIGINT COMMENT 'Reference to the Time‑of‑Use schedule applied by this configuration.',
    `config_code` STRING COMMENT 'Business identifier code for the configuration profile.',
    `config_name` STRING COMMENT 'Human‑readable name for the configuration profile.',
    `config_type` STRING COMMENT 'Category of rate structure the configuration supports (e.g., Time‑of‑Use, Real‑Time Pricing, Critical Peak Pricing).. Valid values are `TOU|RTP|CPP|Standard|Custom`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the configuration record was initially created.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing overall data quality of the configurations measurements.',
    `demand_interval_length_minutes` STRING COMMENT 'Length of the demand measurement interval used for demand‑side analytics.',
    `effective_end_date` DATE COMMENT 'Date when the configuration ceases to be effective (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the configuration becomes effective for the meter.',
    `estimation_method` STRING COMMENT 'Method used to estimate missing or estimated interval data for this configuration.. Valid values are `manual|automated|none`',
    `firmware_version` STRING COMMENT 'Version of the meter firmware to which this configuration applies.',
    `interval_length_minutes` STRING COMMENT 'Length of the measurement interval for energy consumption reads (e.g., 15, 30, 60).',
    `last_push_timestamp` TIMESTAMP COMMENT 'Date‑time when the configuration was last pushed to the meter.',
    `load_profile_enabled` BOOLEAN COMMENT 'Indicates whether detailed load‑profile recording is enabled.',
    `meter_configuration_description` STRING COMMENT 'Free‑form text describing the purpose and details of the configuration.',
    `meter_configuration_status` STRING COMMENT 'Current lifecycle status of the configuration.. Valid values are `active|inactive|retired|pending`',
    `outage_detection_threshold` DECIMAL(18,2) COMMENT 'Power threshold (in kilowatts) used to detect a potential outage.',
    `remote_connect_enabled` BOOLEAN COMMENT 'Indicates whether the meter can be remotely connected (energized) via the configuration.',
    `remote_disconnect_enabled` BOOLEAN COMMENT 'Indicates whether the meter can be remotely disconnected (de‑energized) via the configuration.',
    `tamper_detection_enabled` BOOLEAN COMMENT 'Indicates whether tamper detection logic is active for the meter.',
    `updated_by` STRING COMMENT 'User identifier of the person who last updated the configuration record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the configuration record.',
    `validation_status` STRING COMMENT 'Result of the configuration validation workflow.. Valid values are `validated|pending|rejected`',
    `version_number` STRING COMMENT 'Sequential version number of the configuration profile.',
    `created_by` STRING COMMENT 'User identifier of the person who created the configuration record.',
    CONSTRAINT pk_meter_configuration PRIMARY KEY(`meter_configuration_id`)
) COMMENT 'AMI device configuration record defining the programmed settings for each meter, including measurement channels, register configuration, TOU schedule assignment, demand interval length (15/30/60 min), load profile recording settings, outage detection thresholds, tamper detection flags, remote connect/disconnect capability flag, firmware version deployed, and last configuration push timestamp. Tracks the active configuration profile applied to a meter at any point in time. Supports TOU, RTP, and CPP rate structure configurations.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`meter_premise` (
    `meter_premise_id` BIGINT COMMENT 'Unique surrogate key for each meter-premise association record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Premise‑level installation and service costs are charged to a cost center for expense tracking.',
    `meter_id` BIGINT COMMENT 'Identifier of the physical meter device assigned to the premise.',
    `premise_id` BIGINT COMMENT 'Identifier of the service point (premise) where the meter is installed.',
    `association_number` STRING COMMENT 'Business identifier for the meter‑premise relationship, used in operational and regulatory reporting.',
    `association_type` STRING COMMENT 'Classification of the relationship (e.g., primary service meter, secondary backup meter).. Valid values are `primary|secondary|backup`',
    `comments` STRING COMMENT 'Free‑form notes regarding the meter‑premise relationship, such as special installation conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the association record was first created in the system.',
    `effective_from` DATE COMMENT 'Date when the meter became officially associated with the premise.',
    `effective_until` DATE COMMENT 'Date when the association ends or is scheduled to end; null if open‑ended.',
    `installation_date` DATE COMMENT 'Date the meter was physically installed at the premise.',
    `last_validation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent data validation run for this association.',
    `measurement_unit` STRING COMMENT 'Unit of energy or volume measured by the meter (kilowatt‑hour, thousand cubic feet, therm).. Valid values are `kWh|MCF|Therm`',
    `meter_premise_status` STRING COMMENT 'Current lifecycle status of the meter‑premise association.. Valid values are `active|inactive|pending|terminated|suspended`',
    `meter_status` STRING COMMENT 'Current operational condition of the meter device.. Valid values are `in_service|out_of_service|maintenance|decommissioned`',
    `net_metering_flag` BOOLEAN COMMENT 'Indicates whether the premise participates in net metering (bidirectional flow).',
    `net_metering_register` STRING COMMENT 'Specifies which register(s) capture net‑metered energy.. Valid values are `import|export|both`',
    `rate_structure` STRING COMMENT 'Rate plan applied to the meter (Time‑of‑Use, Real‑Time Pricing, Critical Peak Pricing, or Flat).. Valid values are `TOU|RTP|CPP|Flat`',
    `register_type` STRING COMMENT 'Type of register captured (total consumption, peak demand, off‑peak, etc.).. Valid values are `total|peak|offpeak|demand`',
    `removal_date` DATE COMMENT 'Date the meter was removed or decommissioned; null if still active.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the association record.',
    `validation_status` STRING COMMENT 'Result of the latest validation process for the meter‑premise data.. Valid values are `validated|estimated|rejected|pending`',
    CONSTRAINT pk_meter_premise PRIMARY KEY(`meter_premise_id`)
) COMMENT 'Time-bounded association record establishing which meter is installed at which metering service point, including NEM bidirectional metering configuration flags and net metering register indicators for customers with on-site generation';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` (
    `metering_service_point_id` BIGINT COMMENT 'Primary key for service_point',
    `large_customer_contract_id` BIGINT COMMENT 'Unique system-generated identifier for the service point record.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Required for load forecasting and ISO reporting; each service point must be assigned to its balancing area to aggregate demand per market region.',
    `control_zone_id` BIGINT COMMENT 'Foreign key linking to gridops.control_zone. Business justification: Needed for voltage regulation and demand‑response coordination; control zones manage distribution assets and service points are mapped to them for operational decisions.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service‑point OPEX cost allocation to cost centers is used in distribution expense reporting.',
    `cycle_id` BIGINT COMMENT 'Identifier of the billing cycle applicable to the service point.',
    `distribution_transformer_id` BIGINT COMMENT 'Identifier of the primary distribution transformer serving the point.',
    `feeder_id` BIGINT COMMENT 'Identifier of the electric feeder line associated with the service point.',
    `meter_read_schedule_id` BIGINT COMMENT 'Foreign key linking to metering.meter_read_schedule. Business justification: A service point follows a reading schedule; linking service point to meter_read_schedule enables schedule lookup without duplication.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Required for Service Point to Parcel Mapping Report used in billing, regulatory compliance, and NEM eligibility calculations.',
    `meter_id` BIGINT COMMENT 'Identifier of the currently active meter serving the point.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Direct link to the applicable rate_schedule for the service point; needed for accurate charge calculation and rate schedule version tracking.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Supports mapping service points to the purchase order that supplied the primary meter for cost allocation and audit compliance.',
    `rate_season_calendar_id` BIGINT COMMENT 'Foreign key linking to product.rate_season_calendar. Business justification: Seasonal calendar determines seasonal rate applicability for a service point; required for seasonal pricing compliance and reporting.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Service‑point level SCADA mapping is required for outage management and compliance reporting, linking each point to its SCADA system.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Required for Substation‑Service Point Mapping report used in outage impact analysis and load forecasting (max 50 words).',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Capital project budgeting tracks upgrades to service points via WBS elements in the project hierarchy.',
    `address_line1` STRING COMMENT 'Primary street address of the service point.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `ami_communication_technology` STRING COMMENT 'Technology used for AMI data transmission.. Valid values are `cellular|rf|wifi|satellite|other`',
    `ami_endpoint_serial` STRING COMMENT 'Serial number of the AMI communication endpoint installed at the point.',
    `ami_signal_strength` STRING COMMENT 'Measured signal strength (dBm) of the AMI device at last contact.',
    `city` STRING COMMENT 'City where the service point is located.',
    `classification` STRING COMMENT 'Internal classification used for planning (e.g., high‑value residential, critical commercial).',
    `country_code` STRING COMMENT 'Three‑letter ISO country code where the service point resides.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service point record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Normalized score (0‑1) representing confidence in the meter data for this point.',
    `data_quality_status` STRING COMMENT 'Categorical assessment of data quality.. Valid values are `good|questionable|bad`',
    `decommission_date` DATE COMMENT 'Date the service point was retired or taken out of service, if applicable.',
    `estimated_annual_consumption_kwh` DECIMAL(18,2) COMMENT 'Projected yearly electricity usage based on historical data.',
    `estimated_annual_gas_mcf` DECIMAL(18,2) COMMENT 'Projected yearly natural‑gas usage in thousand cubic feet.',
    `gas_pressure_zone` STRING COMMENT 'Pressure zone designation for natural‑gas service points.',
    `installation_date` DATE COMMENT 'Date the service point was first energized or commissioned.',
    `is_critical_infrastructure` BOOLEAN COMMENT 'Indicates if the point is part of the Bulk Electric System (BES) or other critical assets.',
    `last_communication_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent successful AMI data exchange.',
    `last_meter_read_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent validated meter reading.',
    `last_meter_read_value` DECIMAL(18,2) COMMENT 'Most recent meter reading value in kilowatt‑hours.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the service point in decimal degrees.',
    `lifecycle_status` STRING COMMENT 'High‑level lifecycle stage of the service point.. Valid values are `active|inactive|decommissioned|planned|retired`',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the service point in decimal degrees.',
    `meter_count` STRING COMMENT 'Number of meters historically installed at this service point.',
    `metering_profile_type` STRING COMMENT 'Rate structure applied to the service point.. Valid values are `TOU|RTP|CPP|Flat|Other`',
    `metering_service_point_status` STRING COMMENT 'Current operational status of the service point.. Valid values are `active|inactive|suspended|pending|retired`',
    `nem_eligibility_flag` BOOLEAN COMMENT 'True if the service point qualifies for Net Energy Metering under state policy.',
    `phase_configuration` STRING COMMENT 'Phase arrangement of the service point (single‑phase, three‑phase, split‑phase).. Valid values are `single|three|split`',
    `postal_code` STRING COMMENT 'ZIP or postal code for the service point address.. Valid values are `^d{5}(-d{4})?$`',
    `premise_type` STRING COMMENT 'Category of the premises served by the point.. Valid values are `residential|commercial|industrial|government|other`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the service point meets all applicable regulatory data reporting requirements.',
    `service_point_code` STRING COMMENT 'External code used by operations and billing systems to reference the service point.',
    `service_point_name` STRING COMMENT 'Human‑readable name or label for the service point location.',
    `service_type` STRING COMMENT 'Indicates whether the point provides electric, gas, or both services.. Valid values are `electric|gas|dual`',
    `service_voltage_kv` DECIMAL(18,2) COMMENT 'Nominal service voltage level in kilovolts.',
    `state` STRING COMMENT 'Two‑letter state or province abbreviation.. Valid values are `^[A-Z]{2}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the service point record.',
    CONSTRAINT pk_metering_service_point PRIMARY KEY(`metering_service_point_id`)
) COMMENT 'Master record for each utility service delivery point representing the fixed physical location where energy measurement occurs. Stores service point identifier, service address, GPS coordinates, premise type (residential/commercial/industrial), service voltage level, phase configuration (single/three-phase), distribution transformer reference, feeder reference, gas pressure zone, service type (electric/gas), NEM eligibility flag, and AMI communication attributes (endpoint serial, comm technology, signal strength, last communication timestamp). Unlike meter_premise which tracks which meter is installed where over time, this entity represents the permanent location itself. The SSOT for service point identity and AMI connectivity status within the metering domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`register` (
    `register_id` BIGINT COMMENT 'System-generated unique identifier for the register.',
    `meter_event_id` BIGINT COMMENT 'Identifier of a related event (e.g., meter tamper, outage) linked to this register.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Register‑level revenue posting aligns each tariff register with its GL account for accurate revenue split.',
    `meter_id` BIGINT COMMENT 'Identifier of the meter to which this register belongs.',
    `calibration_date` DATE COMMENT 'Date the register (or its associated sensor) was last calibrated.',
    `calibration_factor` DECIMAL(18,2) COMMENT 'Factor applied during calibration to adjust raw readings.',
    `commodity_type` STRING COMMENT 'Type of commodity measured by the register.. Valid values are `electricity|gas|steam`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the register record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing overall quality of the registers data.',
    `data_source` STRING COMMENT 'Origin of the register data (e.g., AMI, SCADA, manual entry).. Valid values are `AMI|SCADA|Manual|Estimated`',
    `digit_count` STRING COMMENT 'Number of digits the register can display or store.',
    `effective_date` DATE COMMENT 'Date the register became active for measurement.',
    `emission_factor` DECIMAL(18,2) COMMENT 'Factor used to calculate emissions from the registers consumption (e.g., kg CO₂ per MCF).',
    `estimation_method` STRING COMMENT 'Method used when register values are estimated or imputed.. Valid values are `none|interpolation|extrapolation|statistical`',
    `is_bidirectional` BOOLEAN COMMENT 'Indicates if the register records both delivered and received energy.',
    `is_virtual` BOOLEAN COMMENT 'Flag indicating whether the register is a virtual/derived channel rather than a physical measurement.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the register record.',
    `last_validation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent data quality validation run for the register.',
    `load_profile_type` STRING COMMENT 'Classification of the load profile associated with the register.. Valid values are `baseline|actual|forecast`',
    `max_read_value` DECIMAL(18,2) COMMENT 'Maximum observed reading value for the register.',
    `measurement_multiplier` DECIMAL(18,2) COMMENT 'Factor applied to raw readings to convert to the unit of measure.',
    `measurement_precision` STRING COMMENT 'Number of decimal places stored for register readings.',
    `min_read_value` DECIMAL(18,2) COMMENT 'Minimum observed reading value for the register.',
    `rate_structure` STRING COMMENT 'Rate structure linked to the register (e.g., Time‑of‑Use, Real‑Time Pricing).. Valid values are `TOU|RTP|CPP|Flat`',
    `reading_sequence` STRING COMMENT 'Sequence number indicating the order of reads for this register.',
    `register_description` STRING COMMENT 'Free‑form description providing additional context about the register.',
    `register_name` STRING COMMENT 'Descriptive name for the register, often indicating its purpose or location on the meter.',
    `register_number` STRING COMMENT 'Human‑readable identifier assigned to the register (e.g., 1, 2, A).',
    `register_status` STRING COMMENT 'Current lifecycle status of the register.. Valid values are `active|inactive|retired|suspended|pending`',
    `register_type` STRING COMMENT 'Category of measurement the register provides (e.g., energy, demand, reactive power).. Valid values are `energy|demand|reactive|volume|temperature`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the register complies with applicable regulatory reporting requirements.',
    `retirement_date` DATE COMMENT 'Date the register was retired or de‑commissioned (null if still active).',
    `rollover_flag` BOOLEAN COMMENT 'Indicates whether the register is configured to rollover at its maximum value.',
    `rollover_value` DECIMAL(18,2) COMMENT 'Maximum value before the register rolls over to zero.',
    `source_system` STRING COMMENT 'Name of the source system that originally created the register record.',
    `tou_tier` STRING COMMENT 'TOU tier assignment for the register (e.g., peak, off‑peak).. Valid values are `peak|offpeak|midpeak`',
    `unit_of_measure` STRING COMMENT 'The measurement unit associated with the register values.. Valid values are `kWh|MCF|Therm|kW|kVAR`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the register record.',
    `validation_status` STRING COMMENT 'Result of the latest validation process for register data.. Valid values are `valid|invalid|pending|estimated`',
    CONSTRAINT pk_register PRIMARY KEY(`register_id`)
) COMMENT 'Master record for each physical or logical register within a meter, representing a specific measurement channel (e.g., kWh delivered, kWh received, kVAR, kW demand, MCF, Therms). Stores register number, unit of measure (kWh/MCF/Therm/kW/kVAR), register type (energy/demand/reactive), TOU tier assignment, multiplier, number of digits, rollover value, and read sequence. A single meter may have multiple registers for bi-directional or multi-commodity measurement.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`register_read` (
    `register_read_id` BIGINT COMMENT 'System-generated unique identifier for each register read event.',
    `load_profile_id` BIGINT COMMENT 'Identifier of the load profile associated with the read, if applicable.',
    `register_id` BIGINT COMMENT 'Foreign key linking to metering.register. Business justification: Each register_read belongs to a specific register; the register already references the meter, so meter_id is redundant in register_read.',
    `consumption_quantity` DECIMAL(18,2) COMMENT 'Calculated consumption for the interval (e.g., kWh, MCF, Therms).',
    `data_quality_flag` BOOLEAN COMMENT 'True if the read passed all quality checks; false otherwise.',
    `demand_unit` STRING COMMENT 'Unit of the demand measurement (kilowatt).. Valid values are `kw`',
    `demand_value` DECIMAL(18,2) COMMENT 'Peak demand recorded during the interval (e.g., kW for electric meters).',
    `edit_timestamp` TIMESTAMP COMMENT 'Date and time when a manual edit was applied to the read.',
    `edited_by` BIGINT COMMENT 'Identifier of the user who performed the manual edit.',
    `edited_flag` BOOLEAN COMMENT 'Indicates whether the read has been manually edited after initial capture.',
    `interval_end` TIMESTAMP COMMENT 'End time of the measurement interval for interval‑based reads.',
    `interval_start` TIMESTAMP COMMENT 'Start time of the measurement interval for interval‑based reads.',
    `multiplier` DECIMAL(18,2) COMMENT 'Factor applied to the raw reading to convert to billing units (e.g., meter constant).',
    `notes` STRING COMMENT 'Additional comments or observations entered by the technician or system.',
    `previous_read_value` DECIMAL(18,2) COMMENT 'The reading value from the immediately preceding interval, used for consumption calculation.',
    `raw_read_value` DECIMAL(18,2) COMMENT 'Unadjusted numeric value reported by the meter before any multipliers or estimations.',
    `read_quality_code` STRING COMMENT 'Code indicating the quality of the read (e.g., good, suspect, estimated). [ENUM-REF-CANDIDATE: good|suspect|estimated|invalid|manual|other — promote to reference product]',
    `read_reason` STRING COMMENT 'Free‑text explanation for why a particular read type or source was used (e.g., meter replacement, outage).',
    `read_source` STRING COMMENT 'Origin of the read data – field technician, AMI head‑end system, or IVR.. Valid values are `field_technician|ami_head_end|ivr`',
    `read_status` STRING COMMENT 'Current processing status of the read record.. Valid values are `validated|rejected|pending`',
    `read_timestamp` TIMESTAMP COMMENT 'Date and time when the register reading was captured.',
    `read_type` STRING COMMENT 'Classification of the read: actual, estimated, customer‑submitted, or remote AMI.. Valid values are `actual|estimated|customer_submitted|remote_ami`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the register read record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the register read record.',
    `source_system` STRING COMMENT 'Name of the source system that supplied the read (e.g., MDM, PI Historian).',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the consumption quantity (kilowatt‑hour, thousand cubic feet, or therm).. Valid values are `kwh|mcf|therm`',
    `validation_status` STRING COMMENT 'Result of automated validation rules applied to the read.. Valid values are `passed|failed|manual_review`',
    `version_number` STRING COMMENT 'Incremental version of the read record for audit and rollback purposes.',
    CONSTRAINT pk_register_read PRIMARY KEY(`register_read_id`)
) COMMENT 'Transactional record capturing each physical or remote register reading event, including read date, read time, raw reading value, previous reading value, consumption calculated, read type (actual/estimated/customer-submitted/remote AMI), read source (field technician/AMI head-end/IVR), read quality code, and multiplier applied. Feeds billing with validated consumption quantities. Supports both electric (kWh, kW demand) and gas (MCF, Therms) register reads. Sourced from Oracle Utilities MDM.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`interval_read` (
    `interval_read_id` BIGINT COMMENT 'System-generated unique identifier for each interval read record.',
    `location_id` BIGINT COMMENT 'Reference to the location entity where the meter is installed.',
    `metering_service_point_id` BIGINT COMMENT 'Identifier of the logical metering point (may aggregate multiple physical meters).',
    `register_id` BIGINT COMMENT 'Foreign key linking to metering.register. Business justification: Interval reads are captured per register; adding register_id creates the correct child‑to‑parent link and removes the redundant meter_id.',
    `channel_number` STRING COMMENT 'Channel on the meter that produced this reading (e.g., 1 for net kWh, 2 for reactive kVAR).',
    `consumption_direction` STRING COMMENT 'Specifies if the energy was delivered to the customer or received from the customer (e.g., net‑metering).. Valid values are `delivered|received`',
    `corrected_value` DECIMAL(18,2) COMMENT 'Adjusted value after VEE processing, if different from raw.',
    `correction_reason` STRING COMMENT 'Free‑text explanation for any adjustment applied to the raw reading.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the interval record was first persisted in the lakehouse.',
    `cumulative_reading` DECIMAL(18,2) COMMENT 'Running total of the measured quantity up to the end of this interval.',
    `data_quality_flag` BOOLEAN COMMENT 'True if the reading passed all quality checks after VEE.',
    `data_source` STRING COMMENT 'Origin of the interval data before ingestion.. Valid values are `AMI|Manual|SCADA`',
    `demand_kvar` DECIMAL(18,2) COMMENT 'Instantaneous reactive power demand for the interval, when applicable.',
    `demand_kw` DECIMAL(18,2) COMMENT 'Instantaneous active power demand for the interval, when applicable.',
    `device_serial` STRING COMMENT 'Manufacturer‑assigned serial number of the AMI device.',
    `duration_minutes` STRING COMMENT 'Length of the interval in whole minutes.',
    `estimation_method` STRING COMMENT 'Algorithm used when the reading is estimated.. Valid values are `linear|profile|statistical`',
    `event_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the interval measurement was recorded by the device.',
    `interval_end` TIMESTAMP COMMENT 'End of the measurement interval.',
    `interval_read_status` STRING COMMENT 'Current lifecycle state of the interval record.. Valid values are `active|inactive|archived`',
    `interval_sequence` STRING COMMENT 'Ordinal position of the interval within a day (e.g., 1‑96 for 15‑min intervals).',
    `interval_start` TIMESTAMP COMMENT 'Start of the measurement interval.',
    `is_estimated` BOOLEAN COMMENT 'True if the reading value is an estimate rather than a direct measurement.',
    `is_missing` BOOLEAN COMMENT 'True if no measurement was captured for the interval.',
    `load_profile_code` STRING COMMENT 'Code indicating the tariff profile applied to the reading (Time‑of‑Use, Real‑Time Pricing, Critical Peak Pricing).. Valid values are `TOU|RTP|CPP`',
    `measurement_type` STRING COMMENT 'Category of the measured quantity.. Valid values are `electricity|gas|reactive|demand`',
    `notes` STRING COMMENT 'Free‑form comments from data stewards or VEE operators.',
    `quality_code` STRING COMMENT 'Initial quality indicator assigned by the head‑end system before VEE processing.. Valid values are `good|suspect|bad|estimated|missing`',
    `read_type` STRING COMMENT 'Indicates whether the value is a direct measurement or an estimate.. Valid values are `actual|estimated|estimated_ve|estimated_vv`',
    `reading_sequence` BIGINT COMMENT 'Monotonically increasing sequence to preserve ordering of reads for a meter.',
    `reading_value` DECIMAL(18,2) COMMENT 'Unadjusted measurement value captured from the meter.',
    `source_system` STRING COMMENT 'System of record that supplied the raw interval data.. Valid values are `OSIsoft_PI|Oracle_MDM|Custom`',
    `tariff_code` STRING COMMENT 'Identifier of the rate schedule governing this interval.',
    `unit_of_measure` STRING COMMENT 'Standard unit for the reading value.. Valid values are `kWh|kVAR|kW|MCF|Therm`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the interval record.',
    `validation_status` STRING COMMENT 'Result of the VEE (validation, estimation, editing) process.. Valid values are `pending|validated|rejected`',
    `version_number` STRING COMMENT 'Version of the record reflecting successive VEE edits.',
    CONSTRAINT pk_interval_read PRIMARY KEY(`interval_read_id`)
) COMMENT 'High-frequency interval energy measurement record captured by AMI meters at configured intervals (typically 15, 30, or 60 minutes). Stores energy delivered (kWh), energy received (kWh for NEM/DER customers), reactive energy (kVAR), demand (kW), gas volume (MCF/Therms), interval start timestamp, interval end timestamp, interval duration, channel number, raw measured value, and initial quality code before VEE processing. This is the foundational time-series dataset for TOU, RTP, and CPP rate calculations, load research, and demand analytics. Sourced from AMI head-end systems via OSIsoft PI Historian and loaded into Oracle Utilities MDM. Each record represents one measurement interval for one channel on one meter.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`vee_result` (
    `vee_result_id` BIGINT COMMENT 'Unique surrogate key for each Validation, Estimation, and Editing (VEE) processing result record.',
    `employee_id` BIGINT COMMENT 'Identifier of the data quality analyst assigned to investigate the issue.',
    `meter_id` BIGINT COMMENT 'Unique identifier of the meter asset to which this VEE result applies.',
    `register_id` BIGINT COMMENT 'Identifier of the specific register (e.g., total, demand) on the meter that generated the reading.',
    `technician_id` BIGINT COMMENT 'Identifier of the data quality analyst assigned to investigate the issue.',
    `vee_rule_id` BIGINT COMMENT 'Foreign key linking to metering.vee_rule. Business justification: vee_result should reference the governing VEE rule via a foreign key; the existing string column is replaced with vee_rule_id.',
    `affected_interval_count` STRING COMMENT 'Number of consecutive intervals impacted by the issue.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this VEE result record was first created in the data lake.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing overall confidence in the processed value.',
    `escalation_level` STRING COMMENT 'Severity level used to determine if the issue requires escalation to higher‑level support.. Valid values are `low|medium|high`',
    `estimation_algorithm` STRING COMMENT 'Algorithm used when the outcome is estimated, describing the method applied.. Valid values are `weather_based|similar_day|linear_interpolation|statistical_model`',
    `interval_end` TIMESTAMP COMMENT 'End time of the measurement interval for which the raw reading was captured.',
    `interval_start` TIMESTAMP COMMENT 'Start time of the measurement interval for which the raw reading was captured.',
    `investigation_notes` STRING COMMENT 'Free‑form notes captured by the analyst during issue investigation.',
    `issue_end_timestamp` TIMESTAMP COMMENT 'Timestamp of the last interval affected by the identified issue.',
    `issue_start_timestamp` TIMESTAMP COMMENT 'Timestamp of the first interval affected by the identified issue.',
    `issue_type` STRING COMMENT 'Classification of the data quality problem detected for the interval.. Valid values are `spike|gap|negative|rollover|comm_failure|anomalous`',
    `outcome` STRING COMMENT 'Result of the VEE processing: pass, fail, estimated, or edited.. Valid values are `pass|fail|estimated|edited`',
    `override_reason_code` STRING COMMENT 'Code indicating why a manual override or edit was applied to the reading.',
    `processed_value` DECIMAL(18,2) COMMENT 'Final value after validation, estimation, or editing (may equal raw_value if outcome is pass).',
    `processing_timestamp` TIMESTAMP COMMENT 'Date and time when the VEE processing result was generated.',
    `raw_value` DECIMAL(18,2) COMMENT 'Original unprocessed value reported by the meter for the interval.',
    `resolution_action` STRING COMMENT 'Action taken to resolve the data quality issue (e.g., manual edit, algorithmic correction).',
    `resolution_status` STRING COMMENT 'Current status of the issue resolution workflow.. Valid values are `open|closed|in_progress|deferred`',
    `root_cause_classification` STRING COMMENT 'High‑level categorization of the underlying cause of the data quality issue.',
    `source_system` STRING COMMENT 'Name of the source system that produced the raw meter reading (e.g., MDM, PI Historian).',
    `unit_of_measure` STRING COMMENT 'Measurement unit associated with the raw and processed values (e.g., kilowatt‑hour, thousand cubic feet, therm).. Valid values are `kwh|mcf|therm`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this VEE result record.',
    CONSTRAINT pk_vee_result PRIMARY KEY(`vee_result_id`)
) COMMENT 'Validation, Estimation, and Editing (VEE) processing outcome record and the domains consolidated data quality management entity. Each record represents a VEE processing result for an interval or register read, storing: original raw value, VEE rule applied, validation outcome (pass/fail/estimated/edited), estimation algorithm used (weather-based/similar-day/linear interpolation), edited value, processing timestamp, and override reason code. Also serves as the SSOT for all data quality issue tracking within the metering domain: captures issue type (spike/gap/negative/rollover/communication failure/anomalous consumption/missing reads), affected date range, number of affected intervals, assigned analyst, investigation notes, resolution status, resolution action taken, root cause classification, and escalation history. Supports both automated VEE pipeline outcomes and manual data quality investigation workflows. Core to Oracle Utilities MDM VEE processing, regulatory reporting on estimated bill percentages, and SLA compliance for data completeness.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`vee_rule` (
    `vee_rule_id` BIGINT COMMENT 'System-generated unique identifier for the validation, estimation, or editing rule.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: VEE rule adjustments are recorded in a GL account for audit‑trail and financial impact reporting.',
    `applies_to_customer_segment` STRING COMMENT 'Customer segment for which the rule is relevant.. Valid values are `residential|commercial|industrial|government`',
    `applies_to_rate_plan` STRING COMMENT 'Identifier of the specific rate plan to which the rule applies.',
    `commodity` STRING COMMENT 'Utility commodity to which the rule applies (electricity or natural gas).. Valid values are `electric|gas`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created.',
    `effective_end_date` DATE COMMENT 'Date when the rule expires (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the rule becomes effective.',
    `estimation_method` STRING COMMENT 'Algorithm used when the rule performs estimation.. Valid values are `linear|average|median|interpolation|custom`',
    `execution_count` BIGINT COMMENT 'Total number of times the rule has been applied.',
    `is_exclusive` BOOLEAN COMMENT 'Indicates whether the rule is mutually exclusive with other rules of the same category.',
    `last_executed_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent execution of this rule in the data quality pipeline.',
    `max_allowed_deviation_percent` DECIMAL(18,2) COMMENT 'Maximum percentage deviation permitted before the rule flags a data point.',
    `max_allowed_value` DECIMAL(18,2) COMMENT 'Upper bound for acceptable meter reading values under this rule.',
    `min_allowed_value` DECIMAL(18,2) COMMENT 'Lower bound for acceptable meter reading values under this rule.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the rule.',
    `priority_order` STRING COMMENT 'Execution priority of the rule relative to other rules (lower number = higher priority).',
    `rate_class` STRING COMMENT 'Rate class (tariff) for which the rule is applicable.. Valid values are `residential|commercial|industrial|government`',
    `rule_category` STRING COMMENT 'Classification of the rule logic (e.g., spike detection, gap filling).. Valid values are `spike|gap|negative|rollover|sum_check|other`',
    `rule_type` STRING COMMENT 'Indicates whether the rule performs validation, estimation, or editing of meter data.. Valid values are `validation|estimation|editing`',
    `rule_version` STRING COMMENT 'Version number of the rule definition, incremented on changes.',
    `source_system` STRING COMMENT 'Originating system for the rule definition (e.g., Oracle Utilities MDM).',
    `threshold_unit` STRING COMMENT 'Unit of measure for the threshold value.. Valid values are `kwh|mcf|therm|percent`',
    `threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold used by the rule (e.g., maximum allowed spike magnitude).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rule record.',
    `vee_rule_code` STRING COMMENT 'Business code used to reference the rule in downstream systems.',
    `vee_rule_description` STRING COMMENT 'Detailed description of the rule purpose and logic.',
    `vee_rule_name` STRING COMMENT 'Human‑readable name of the VEE rule.',
    `vee_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|deprecated|pending`',
    CONSTRAINT pk_vee_rule PRIMARY KEY(`vee_rule_id`)
) COMMENT 'Reference master for VEE validation and estimation rules configured in Oracle Utilities MDM. Stores rule name, rule type (validation/estimation/editing), rule category (spike/gap/negative/rollover/sum-check), threshold parameters, estimation method, applicable commodity (electric/gas), applicable rate class, effective date range, priority order, and active status. Governs the automated data quality processing pipeline for all interval and register read data.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`meter_event` (
    `meter_event_id` BIGINT COMMENT 'Unique identifier for each meter event record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Outage and event handling costs are charged to the responsible cost center for event cost tracking.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Crew Response: records which crew responded to a meter event, essential for outage response dashboards and crew performance tracking.',
    `gridops_outage_event_id` BIGINT COMMENT 'Foreign key linking to gridops.gridops_outage_event. Business justification: Outage management links meter‑level loss events to outage records, providing traceability for regulatory reporting and restoration planning.',
    `meter_id` BIGINT COMMENT 'Unique identifier of the AMI meter associated with this event.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Event Investigation: links each meter event to the technician assigned to investigate, required for incident reports and root‑cause analysis.',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to regulatory.violation_notice. Business justification: When a meter event triggers a regulatory violation, the event must reference the violation notice for audit and enforcement.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Maintenance scheduling creates work orders for meter repairs; linking events to work orders enables traceability and regulatory reporting.',
    `battery_level_percent` STRING COMMENT 'Remaining battery charge expressed as a percentage.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the record was initially persisted.',
    `error_code` STRING COMMENT 'Standardized error identifier for processing failures.',
    `error_message` STRING COMMENT 'Descriptive text explaining the processing error.',
    `estimated_flag` BOOLEAN COMMENT 'True if the event value was derived by estimation algorithms.',
    `estimation_method` STRING COMMENT 'Algorithm or rule applied to generate an estimated value.',
    `event_category` STRING COMMENT 'Broad category used for analytics and reporting.. Valid values are `security|operational|maintenance|communication`',
    `event_description` STRING COMMENT 'Detailed narrative describing the event context and any relevant observations.',
    `event_severity` STRING COMMENT 'Severity of the event indicating impact on service or safety.. Valid values are `critical|high|medium|low|info`',
    `event_status` STRING COMMENT 'Lifecycle status of the event within the data pipeline.. Valid values are `new|processed|failed|ignored`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time the event was observed by the meter or head‑end system.',
    `event_type` STRING COMMENT 'Category of the meter event (e.g., tamper alert, outage, low battery, communication failure, remote connect, demand alarm).. Valid values are `tamper|outage|low_battery|comm_failure|remote_connect|demand_alarm`',
    `firmware_version` STRING COMMENT 'Software version identifier of the meters firmware.',
    `is_test_event` BOOLEAN COMMENT 'True if the event originates from a test or simulation; otherwise false.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate (WGS84) of the meter location.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate (WGS84) of the meter location.',
    `meter_state` STRING COMMENT 'Current lifecycle state of the meter.. Valid values are `installed|removed|in_service|retired|maintenance`',
    `processing_attempts` STRING COMMENT 'Count of processing retries due to failures or validation errors.',
    `processing_timestamp` TIMESTAMP COMMENT 'Date and time the event was ingested and processed.',
    `raw_payload` STRING COMMENT 'Unparsed JSON or binary string containing the original event data.',
    `resolution_outcome` STRING COMMENT 'Result of the event resolution process.. Valid values are `resolved|unresolved|false_alarm|pending`',
    `signal_strength_dbm` STRING COMMENT 'Measured radio signal strength of the meter at the time of the event.',
    `source_system` STRING COMMENT 'Source application or system that generated the event.. Valid values are `MDM|PI|OMS`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the record.',
    CONSTRAINT pk_meter_event PRIMARY KEY(`meter_event_id`)
) COMMENT 'Transactional record of operational events reported by AMI meters and head-end systems. Captures tamper alerts, power outage/restoration events, reverse energy flow detection, low battery alerts, communication failures, remote connect/disconnect commands and outcomes, meter state changes (installation/removal/in-service/retired), demand threshold alarms, and meter programming events. Stores event type code, event timestamp, event severity, meter ID, raw event payload, processing status, and resolution outcome. Serves as the consolidated event log for all meter-originated signals. Feeds OMS outage detection, CIP security monitoring, and meter lifecycle audit trail.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` (
    `meter_read_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the meter read schedule record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the lakehouse.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing the quality of the schedule data after validation.',
    `effective_from` DATE COMMENT 'Date when the schedule becomes effective for billing and operations.',
    `effective_until` DATE COMMENT 'Date when the schedule is retired or superseded (null if open‑ended).',
    `estimated_window_end` TIMESTAMP COMMENT 'End of the estimated time window for the read.',
    `estimated_window_start` TIMESTAMP COMMENT 'Start of the estimated time window during which the read should be completed.',
    `estimation_method` STRING COMMENT 'Method used to estimate consumption when a read is not physically captured (e.g., linear interpolation, statistical model).',
    `is_estimated` BOOLEAN COMMENT 'Flag indicating whether the scheduled read is expected to be estimated (true) or actual (false).',
    `last_actual_read_date` DATE COMMENT 'Date of the most recent successful manual or AMI read.',
    `last_actual_read_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent successful read.',
    `meter_count_in_route` STRING COMMENT 'Number of meters associated with this schedule on the route.',
    `meter_read_schedule_description` STRING COMMENT 'Free‑form text describing the purpose or special notes for the schedule.',
    `meter_read_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.. Valid values are `active|inactive|suspended|pending`',
    `notes` STRING COMMENT 'Additional operational comments or exceptions for the schedule.',
    `read_frequency_days` STRING COMMENT 'Number of days between scheduled reads for this schedule.',
    `read_method` STRING COMMENT 'Method used to obtain the meter reading.. Valid values are `ami_remote|field_walk|drive_by`',
    `read_sequence` STRING COMMENT 'Ordinal position of this schedule within the assigned route.',
    `route_code` STRING COMMENT 'Identifier for the field route to which this schedule is assigned.',
    `schedule_code` STRING COMMENT 'Business identifier code used in downstream systems to reference this schedule.',
    `schedule_name` STRING COMMENT 'Human‑readable name describing the read schedule (e.g., "Residential Monthly Cycle").',
    `schedule_type` STRING COMMENT 'Classification of the schedule frequency type (e.g., monthly, bi‑monthly, daily, AMI).. Valid values are `monthly|bimonthly|daily|ami`',
    `scheduled_read_date` DATE COMMENT 'Planned calendar date for the next meter read.',
    `scheduled_read_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the read is expected to occur (used for AMI polling).',
    `source_system` STRING COMMENT 'Name of the source system that originated the schedule record (e.g., Oracle MDM).',
    `territory_code` STRING COMMENT 'Geographic territory identifier for the schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    CONSTRAINT pk_meter_read_schedule PRIMARY KEY(`meter_read_schedule_id`)
) COMMENT 'Master record defining the scheduled meter reading cycle for each service point, including read cycle code, scheduled read date, read frequency (monthly/bi-monthly/daily AMI), read method (AMI remote/field walk/drive-by), route code and territory assignment, estimated read window, last actual read date, and route sequence for field operations. Governs both AMI polling schedules and manual field reading operations. Supports billing cycle alignment, read route optimization, and ClickSoftware WFM dispatch for remaining manual meter reading routes.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` (
    `tou_schedule_id` BIGINT COMMENT 'Unique surrogate key for the TOU schedule record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Time‑of‑Use tariff schedules map to GL accounts to post TOU revenue correctly.',
    `applicable_meter_type` STRING COMMENT 'Meter technology type that the schedule can be applied to.. Valid values are `AMI|Non-AMI|Smart|Legacy`',
    `cpp_event_eligible` BOOLEAN COMMENT 'Flag indicating whether the schedule can be used for Critical Peak Pricing events.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the system.',
    `day_type` STRING COMMENT 'Classification of the calendar day for the schedule.. Valid values are `weekday|weekend|holiday|special`',
    `effective_end_date` DATE COMMENT 'Date when the schedule ceases to be effective; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the schedule becomes effective for billing.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this schedule is the default for its rate class.',
    `notes` STRING COMMENT 'Additional free‑form remarks or operational notes.',
    `offpeak_window_end_time` TIMESTAMP COMMENT 'End time of the off‑peak window (HH:MM, 24‑hour).',
    `offpeak_window_start_time` TIMESTAMP COMMENT 'Start time of the off‑peak window (HH:MM, 24‑hour).',
    `peak_window_end_time` TIMESTAMP COMMENT 'End time of the on‑peak window (HH:MM, 24‑hour).',
    `peak_window_start_time` TIMESTAMP COMMENT 'Start time of the on‑peak window (HH:MM, 24‑hour).',
    `price_multiplier` DECIMAL(18,2) COMMENT 'Factor applied to the base rate for this schedule (e.g., 1.000 for standard, >1 for premium).',
    `rate_class` STRING COMMENT 'Customer rate class to which the schedule applies.. Valid values are `residential|commercial|industrial|government`',
    `rtp_interval_mapping` STRING COMMENT 'Length of real‑time pricing intervals that the schedule aligns with.. Valid values are `15min|30min|60min`',
    `schedule_code` STRING COMMENT 'Business identifier code used in billing and operational systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name of the TOU schedule.',
    `schedule_type` STRING COMMENT 'Category of the schedule indicating the pricing model.. Valid values are `TOU|RTP|CPP|Hybrid`',
    `season` STRING COMMENT 'Seasonal grouping that the schedule applies to.. Valid values are `summer|winter|shoulder|all_year`',
    `tier_definitions` STRING COMMENT 'JSON‑encoded definition of tier periods, start/end times and associated rates within the schedule.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the schedules time windows.',
    `tou_schedule_description` STRING COMMENT 'Free‑form text describing the purpose and characteristics of the schedule.',
    `tou_schedule_status` STRING COMMENT 'Current lifecycle status of the schedule.. Valid values are `active|inactive|pending|retired`',
    `updated_by` STRING COMMENT 'User identifier that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    `version_number` STRING COMMENT 'Incremental version of the schedule for change management.',
    `created_by` STRING COMMENT 'User identifier that created the schedule record.',
    CONSTRAINT pk_tou_schedule PRIMARY KEY(`tou_schedule_id`)
) COMMENT 'Reference master defining Time-of-Use (TOU) rate period schedules including season definitions (summer/winter/shoulder), day type classifications (weekday/weekend/holiday), on-peak and off-peak time windows, critical peak pricing (CPP) event eligibility windows, and real-time pricing (RTP) interval mappings. Stores schedule code, effective date range, applicable rate class, season start/end months, and tier period definitions. Governs how interval reads are bucketed into TOU tiers for billing determinant calculation.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`meter_test` (
    `meter_test_id` BIGINT COMMENT 'Unique system-generated identifier for each meter accuracy test record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Meter testing expenses are allocated to a cost center for compliance and budgeting reports.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Meter test results are submitted as regulatory filings for compliance verification; linking each test to its filing enables traceability.',
    `it_asset_id` BIGINT COMMENT 'Identifier of the test equipment used (e.g., power analyzer).',
    `meter_id` BIGINT COMMENT 'Identifier of the meter that was tested.',
    `site_id` BIGINT COMMENT 'Identifier of the physical site or substation where the test was performed.',
    `technician_id` BIGINT COMMENT 'Identifier of the field technician who executed the test.',
    `accuracy_full_load_percent` DECIMAL(18,2) COMMENT 'Measured accuracy percentage of the meter at full load conditions.',
    `accuracy_light_load_percent` DECIMAL(18,2) COMMENT 'Measured accuracy percentage of the meter at light load conditions.',
    `ambient_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity at the test site, expressed as a percentage.',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'Ambient temperature recorded at the test site, in degrees Celsius.',
    `ansi_standard` STRING COMMENT 'ANSI standard applied for the test (e.g., ANSI C12.1).',
    `comments` STRING COMMENT 'Free‑form notes entered by the technician or reviewer.',
    `compliance_status` STRING COMMENT 'Regulatory compliance outcome for the test.. Valid values are `compliant|non_compliant|exempt`',
    `corrective_action` STRING COMMENT 'Action taken to correct any identified meter inaccuracy.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the meter test record was first created in the system.',
    `equipment_calibration_date` DATE COMMENT 'Date when the test equipment was last calibrated.',
    `equipment_calibration_due_date` DATE COMMENT 'Next scheduled calibration date for the test equipment.',
    `equipment_serial_number` STRING COMMENT 'Serial number of the test equipment used.',
    `error_percentage` DECIMAL(18,2) COMMENT 'Overall error percentage observed during the test.',
    `power_factor` DECIMAL(18,2) COMMENT 'Power factor measured during the test.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the test meets applicable PUC/FERC accuracy requirements.',
    `test_conditions` STRING COMMENT 'Narrative description of test conditions (e.g., voltage, load profile).',
    `test_duration_minutes` STRING COMMENT 'Total duration of the test in minutes.',
    `test_method` STRING COMMENT 'Method used to conduct the test: field, laboratory, or simulation.. Valid values are `field|lab|simulation`',
    `test_number` STRING COMMENT 'Business identifier assigned to the test, often used in regulatory filings and work orders.',
    `test_result_summary` STRING COMMENT 'Concise textual summary of the test outcome and key metrics.',
    `test_status` STRING COMMENT 'Result of the test: pass, fail, or pending review.. Valid values are `pass|fail|pending`',
    `test_timestamp` TIMESTAMP COMMENT 'Date and time when the meter accuracy test was performed.',
    `test_type` STRING COMMENT 'Category of the accuracy test: in‑service (field), shop (lab), or complaint‑driven.. Valid values are `in_service|shop|complaint`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the meter test record.',
    CONSTRAINT pk_meter_test PRIMARY KEY(`meter_test_id`)
) COMMENT 'Transactional record capturing the results of meter accuracy testing performed in the field or at a meter shop, including test type (in-service/shop/complaint-driven), test date, test technician, test equipment used, accuracy percentage at full load, accuracy at light load, power factor test result, pass/fail determination, ANSI standard applied (ANSI C12.1), error percentage, and corrective action taken. Required for regulatory compliance with PUC meter accuracy standards and customer dispute resolution.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` (
    `meter_work_order_assignment_id` BIGINT COMMENT 'Primary key for the MeterWorkOrderAssignment association',
    `meter_id` BIGINT COMMENT 'Links to the meter being serviced by the work order.',
    `work_order_id` BIGINT COMMENT 'Links to the work order that includes the meter task.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual cost incurred for the meter task.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Labor hours actually spent on the meter task.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Planned cost (labor + material) for the meter task.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Planned labor hours for the meter task.',
    `priority` STRING COMMENT 'Priority level of the meter task within the work order.',
    `task_type` STRING COMMENT 'Category of the maintenance task performed on the meter (e.g., inspection, replacement).',
    CONSTRAINT pk_meter_work_order_assignment PRIMARY KEY(`meter_work_order_assignment_id`)
) COMMENT 'Represents the assignment of a work order to a specific meter. Each record captures task‑specific details (type, labor, cost, priority) that exist only in the context of this work order‑meter relationship.. Existence Justification: A work order can involve maintenance on multiple meters, and each meter can be serviced by many work orders over its lifecycle. The utility records each work order‑meter pairing with specific task details such as labor hours, cost, and task type. This many‑to‑many relationship is actively managed by field crews and dispatch planners.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`metering_enrollment` (
    `metering_enrollment_id` BIGINT COMMENT 'Primary key for the Enrollment association',
    `dsm_program_id` BIGINT COMMENT 'Foreign key linking to the DSM program',
    `meter_id` BIGINT COMMENT 'Foreign key linking to the meter',
    `enrollment_date` DATE COMMENT 'Date the meter was enrolled in the DSM program',
    `incentive_amount_usd` DECIMAL(18,2) COMMENT 'Monetary incentive awarded for the enrollment',
    `metering_enrollment_status` STRING COMMENT 'Current status of the enrollment (e.g., active, suspended, cancelled)',
    CONSTRAINT pk_metering_enrollment PRIMARY KEY(`metering_enrollment_id`)
) COMMENT 'This association product represents the enrollment relationship between a meter and a DSM program. It captures when a meter enrolls in a program, the incentive amount awarded, and the current enrollment status.. Existence Justification: Meters can be enrolled in multiple DSM programs and each DSM program can have many meters enrolled. The enrollment itself is managed as a distinct business entity with attributes such as enrollment date, incentive amount, and status.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`metering`.`load_profile` (
    `load_profile_id` BIGINT COMMENT 'Primary key for load_profile',
    `load_profile_code` STRING COMMENT 'Business code used to reference the load profile in external systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the load profile record was first created in the system.',
    `default_interval_unit` STRING COMMENT 'Unit of measure for the default interval value.',
    `default_interval_value` DECIMAL(18,2) COMMENT 'Typical energy quantity recorded per interval when no actual reading exists.',
    `load_profile_description` STRING COMMENT 'Detailed textual description of the profiles characteristics and intended use.',
    `effective_from` DATE COMMENT 'Date when the load profile becomes active for billing.',
    `effective_until` DATE COMMENT 'Date when the load profile is retired or superseded (null if open‑ended).',
    `estimation_method` STRING COMMENT 'Method used to estimate missing or estimated interval data for this profile.',
    `interval_length_minutes` STRING COMMENT 'Length of each consumption interval recorded for this profile.',
    `last_estimation_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent estimation run applied to this profile.',
    `load_profile_name` STRING COMMENT 'Human‑readable name of the load profile (e.g., Residential Summer TOU).',
    `peak_demand_limit` DECIMAL(18,2) COMMENT 'Maximum allowed demand for the profile during a billing period.',
    `peak_demand_unit` STRING COMMENT 'Unit of measure for the peak demand limit.',
    `profile_type` STRING COMMENT 'Category of customers or service area the profile applies to.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the load profile (e.g., Oracle Utilities MDM).',
    `load_profile_status` STRING COMMENT 'Current lifecycle status of the load profile.',
    `tariff_structure` STRING COMMENT 'Rate structure that the load profile follows (Time‑of‑Use, Real‑Time Pricing, etc.).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the load profile record.',
    `version_number` STRING COMMENT 'Incremental version of the load profile definition for change tracking.',
    `voltage_level` STRING COMMENT 'Nominal service voltage associated with the profile.',
    CONSTRAINT pk_load_profile PRIMARY KEY(`load_profile_id`)
) COMMENT 'Master reference table for load_profile. Referenced by load_profile_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ADD CONSTRAINT `fk_metering_meter_configuration_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ADD CONSTRAINT `fk_metering_meter_configuration_tou_schedule_id` FOREIGN KEY (`tou_schedule_id`) REFERENCES `power_and_utilities_v2`.`metering`.`tou_schedule`(`tou_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ADD CONSTRAINT `fk_metering_meter_premise_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_meter_read_schedule_id` FOREIGN KEY (`meter_read_schedule_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter_read_schedule`(`meter_read_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ADD CONSTRAINT `fk_metering_metering_service_point_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ADD CONSTRAINT `fk_metering_register_meter_event_id` FOREIGN KEY (`meter_event_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter_event`(`meter_event_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ADD CONSTRAINT `fk_metering_register_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ADD CONSTRAINT `fk_metering_register_read_load_profile_id` FOREIGN KEY (`load_profile_id`) REFERENCES `power_and_utilities_v2`.`metering`.`load_profile`(`load_profile_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ADD CONSTRAINT `fk_metering_register_read_register_id` FOREIGN KEY (`register_id`) REFERENCES `power_and_utilities_v2`.`metering`.`register`(`register_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ADD CONSTRAINT `fk_metering_interval_read_metering_service_point_id` FOREIGN KEY (`metering_service_point_id`) REFERENCES `power_and_utilities_v2`.`metering`.`metering_service_point`(`metering_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ADD CONSTRAINT `fk_metering_interval_read_register_id` FOREIGN KEY (`register_id`) REFERENCES `power_and_utilities_v2`.`metering`.`register`(`register_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ADD CONSTRAINT `fk_metering_vee_result_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ADD CONSTRAINT `fk_metering_vee_result_register_id` FOREIGN KEY (`register_id`) REFERENCES `power_and_utilities_v2`.`metering`.`register`(`register_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ADD CONSTRAINT `fk_metering_vee_result_vee_rule_id` FOREIGN KEY (`vee_rule_id`) REFERENCES `power_and_utilities_v2`.`metering`.`vee_rule`(`vee_rule_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ADD CONSTRAINT `fk_metering_meter_event_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ADD CONSTRAINT `fk_metering_meter_test_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` ADD CONSTRAINT `fk_metering_meter_work_order_assignment_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_enrollment` ADD CONSTRAINT `fk_metering_metering_enrollment_meter_id` FOREIGN KEY (`meter_id`) REFERENCES `power_and_utilities_v2`.`metering`.`meter`(`meter_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`metering` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities_v2`.`metering` SET TAGS ('dbx_domain' = 'metering');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` SET TAGS ('dbx_subdomain' = 'meter_asset');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `distribution_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Transformer Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Installer Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Module Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Physical Location Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `pole_id` SET TAGS ('dbx_business_glossary_term' = 'Pole Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Service Premise Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `vpp_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Meter Accuracy Class');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `accuracy_class` SET TAGS ('dbx_value_regex' = '0.2|0.5|1.0|2.0');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Meter Communication Protocol');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `ct_ratio` SET TAGS ('dbx_business_glossary_term' = 'Current Transformer (CT) Ratio');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `current_rating_amps` SET TAGS ('dbx_business_glossary_term' = 'Meter Current Rating in Amperes (Amps)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `demand_metering_enabled` SET TAGS ('dbx_business_glossary_term' = 'Demand Metering Enabled Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `expected_life_years` SET TAGS ('dbx_business_glossary_term' = 'Meter Expected Service Life in Years');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Meter Firmware Version');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `form` SET TAGS ('dbx_business_glossary_term' = 'Meter Form Factor Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `installation_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `installation_status` SET TAGS ('dbx_value_regex' = 'installed|removed|in_stock|in_shop|retired|scrapped');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `last_communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Successful Communication Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Meter Manufacturer Name');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `meter_class` SET TAGS ('dbx_business_glossary_term' = 'Meter Service Class');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `meter_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `meter_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Serial Number');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `meter_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Commodity Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'electric|gas|water|steam');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Model Number');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `multiplier` SET TAGS ('dbx_business_glossary_term' = 'Meter Dial Multiplier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `net_metering_enabled` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Enabled Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `next_test_due_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Next Test Due Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `number_of_dials` SET TAGS ('dbx_business_glossary_term' = 'Number of Meter Dials');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Operational Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|testing|failed');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Ownership Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|customer_owned|third_party');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `pt_ratio` SET TAGS ('dbx_business_glossary_term' = 'Potential Transformer (PT) Ratio');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `purchase_cost` SET TAGS ('dbx_business_glossary_term' = 'Meter Purchase Cost in United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `purchase_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `purchase_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Purchase Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `read_cycle` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Cycle Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `register_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Meter Register Capacity in Kilowatt-Hours (kWh)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `remote_disconnect_capable` SET TAGS ('dbx_business_glossary_term' = 'Remote Disconnect Capability Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Removal Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Route Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `seal_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Security Seal Number');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `test_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Last Test Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `time_of_use_enabled` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Rate Enabled Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `voltage_class` SET TAGS ('dbx_business_glossary_term' = 'Meter Voltage Class');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `voltage_class` SET TAGS ('dbx_value_regex' = '120V|240V|277V|480V|primary');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Warranty Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` SET TAGS ('dbx_subdomain' = 'meter_asset');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `meter_configuration_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Configuration ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'CPP Rate Plan ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'RTP Rate Plan ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `tou_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'TOU Schedule ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `config_code` SET TAGS ('dbx_business_glossary_term' = 'Configuration Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `config_name` SET TAGS ('dbx_business_glossary_term' = 'Configuration Name');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `config_type` SET TAGS ('dbx_business_glossary_term' = 'Configuration Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `config_type` SET TAGS ('dbx_value_regex' = 'TOU|RTP|CPP|Standard|Custom');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `demand_interval_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Demand Interval Length (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'manual|automated|none');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `interval_length_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Length (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `last_push_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Configuration Push Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `load_profile_enabled` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Enabled Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `meter_configuration_description` SET TAGS ('dbx_business_glossary_term' = 'Configuration Description');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `meter_configuration_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `meter_configuration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `outage_detection_threshold` SET TAGS ('dbx_business_glossary_term' = 'Outage Detection Threshold (kW)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `remote_connect_enabled` SET TAGS ('dbx_business_glossary_term' = 'Remote Connect Enabled Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `remote_disconnect_enabled` SET TAGS ('dbx_business_glossary_term' = 'Remote Disconnect Enabled Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `tamper_detection_enabled` SET TAGS ('dbx_business_glossary_term' = 'Tamper Detection Enabled Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Configuration Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Validation Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|pending|rejected');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Configuration Version Number');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_configuration` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` SET TAGS ('dbx_subdomain' = 'meter_asset');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `meter_premise_id` SET TAGS ('dbx_business_glossary_term' = 'Meter-Premise Association ID (MPA_ID)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID (METER_ID)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise (Service Point) ID (PREMISE_ID)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `association_number` SET TAGS ('dbx_business_glossary_term' = 'Association Number (ASSOC_NUM)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `association_type` SET TAGS ('dbx_business_glossary_term' = 'Association Type (ASSOC_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `association_type` SET TAGS ('dbx_value_regex' = 'primary|secondary|backup');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments or Notes (COMMENTS)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Date (INSTALLATION_DATE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `last_validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Validation Timestamp (LAST_VALIDATION_TS)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit (MEASUREMENT_UNIT)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'kWh|MCF|Therm');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `meter_premise_status` SET TAGS ('dbx_business_glossary_term' = 'Association Lifecycle Status (ASSOC_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `meter_premise_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `meter_status` SET TAGS ('dbx_business_glossary_term' = 'Meter Operational Status (METER_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `meter_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|maintenance|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `net_metering_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Metering Participation Flag (NET_METERING_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `net_metering_register` SET TAGS ('dbx_business_glossary_term' = 'Net Metering Register Indicator (NET_METERING_REGISTER)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `net_metering_register` SET TAGS ('dbx_value_regex' = 'import|export|both');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `rate_structure` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type (RATE_STRUCTURE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `rate_structure` SET TAGS ('dbx_value_regex' = 'TOU|RTP|CPP|Flat');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `register_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Register Type (REGISTER_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `register_type` SET TAGS ('dbx_value_regex' = 'total|peak|offpeak|demand');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `removal_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Removal Date (REMOVAL_DATE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status (VALIDATION_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_premise` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|estimated|rejected|pending');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` SET TAGS ('dbx_subdomain' = 'meter_asset');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `metering_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `large_customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Service Point ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `control_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Control Zone Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `distribution_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Transformer ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `meter_read_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Meter ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `rate_season_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Season Calendar Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `ami_communication_technology` SET TAGS ('dbx_business_glossary_term' = 'AMI Communication Technology');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `ami_communication_technology` SET TAGS ('dbx_value_regex' = 'cellular|rf|wifi|satellite|other');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `ami_endpoint_serial` SET TAGS ('dbx_business_glossary_term' = 'AMI Endpoint Serial');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `ami_endpoint_serial` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `ami_endpoint_serial` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `ami_signal_strength` SET TAGS ('dbx_business_glossary_term' = 'AMI Signal Strength');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Service Point Classification');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `data_quality_status` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `estimated_annual_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Consumption (kWh)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `estimated_annual_gas_mcf` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Gas Consumption (MCF)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `gas_pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Gas Pressure Zone');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `last_communication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Communication Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `last_meter_read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Meter Read Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `last_meter_read_value` SET TAGS ('dbx_business_glossary_term' = 'Last Meter Read Value (kWh)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|planned|retired');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `meter_count` SET TAGS ('dbx_business_glossary_term' = 'Meter Count');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `metering_profile_type` SET TAGS ('dbx_business_glossary_term' = 'Metering Profile Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `metering_profile_type` SET TAGS ('dbx_value_regex' = 'TOU|RTP|CPP|Flat|Other');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `metering_service_point_status` SET TAGS ('dbx_business_glossary_term' = 'Service Point Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `metering_service_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|retired');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `nem_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'NEM Eligibility Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_value_regex' = 'single|three|split');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `premise_type` SET TAGS ('dbx_business_glossary_term' = 'Premise Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `premise_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government|other');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `service_point_code` SET TAGS ('dbx_business_glossary_term' = 'Service Point Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `service_point_name` SET TAGS ('dbx_business_glossary_term' = 'Service Point Name');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'electric|gas|dual');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `service_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Service Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_service_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` SET TAGS ('dbx_subdomain' = 'meter_asset');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `meter_event_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Event ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `calibration_factor` SET TAGS ('dbx_business_glossary_term' = 'Calibration Factor');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'electricity|gas|steam');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'AMI|SCADA|Manual|Estimated');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `digit_count` SET TAGS ('dbx_business_glossary_term' = 'Digit Count');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'none|interpolation|extrapolation|statistical');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `is_bidirectional` SET TAGS ('dbx_business_glossary_term' = 'Is Bidirectional Register');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Is Virtual Register');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `last_validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Validation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `load_profile_type` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `load_profile_type` SET TAGS ('dbx_value_regex' = 'baseline|actual|forecast');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `max_read_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Read Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `measurement_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Measurement Multiplier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `measurement_precision` SET TAGS ('dbx_business_glossary_term' = 'Measurement Precision');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `min_read_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Read Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `rate_structure` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `rate_structure` SET TAGS ('dbx_value_regex' = 'TOU|RTP|CPP|Flat');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `reading_sequence` SET TAGS ('dbx_business_glossary_term' = 'Reading Sequence');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `register_description` SET TAGS ('dbx_business_glossary_term' = 'Register Description');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `register_name` SET TAGS ('dbx_business_glossary_term' = 'Register Name');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `register_number` SET TAGS ('dbx_business_glossary_term' = 'Register Number');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `register_status` SET TAGS ('dbx_business_glossary_term' = 'Register Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `register_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|suspended|pending');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `register_type` SET TAGS ('dbx_business_glossary_term' = 'Register Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `register_type` SET TAGS ('dbx_value_regex' = 'energy|demand|reactive|volume|temperature');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `rollover_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `rollover_value` SET TAGS ('dbx_business_glossary_term' = 'Rollover Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `tou_tier` SET TAGS ('dbx_business_glossary_term' = 'Time‑of‑Use Tier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `tou_tier` SET TAGS ('dbx_value_regex' = 'peak|offpeak|midpeak');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|MCF|Therm|kW|kVAR');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'valid|invalid|pending|estimated');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` SET TAGS ('dbx_subdomain' = 'data_collection');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `register_read_id` SET TAGS ('dbx_business_glossary_term' = 'Register Read ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `load_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Load Profile ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `consumption_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consumption Quantity');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `demand_unit` SET TAGS ('dbx_business_glossary_term' = 'Demand Unit');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `demand_unit` SET TAGS ('dbx_value_regex' = 'kw');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `demand_value` SET TAGS ('dbx_business_glossary_term' = 'Demand Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `edit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Edit Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `edited_by` SET TAGS ('dbx_business_glossary_term' = 'Edited By User ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `edited_flag` SET TAGS ('dbx_business_glossary_term' = 'Edited Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `interval_end` SET TAGS ('dbx_business_glossary_term' = 'Interval End');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `interval_start` SET TAGS ('dbx_business_glossary_term' = 'Interval Start');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `multiplier` SET TAGS ('dbx_business_glossary_term' = 'Read Multiplier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Read Notes');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `previous_read_value` SET TAGS ('dbx_business_glossary_term' = 'Previous Read Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `raw_read_value` SET TAGS ('dbx_business_glossary_term' = 'Raw Read Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `read_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Read Quality Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `read_reason` SET TAGS ('dbx_business_glossary_term' = 'Read Reason');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `read_source` SET TAGS ('dbx_business_glossary_term' = 'Read Source');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `read_source` SET TAGS ('dbx_value_regex' = 'field_technician|ami_head_end|ivr');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `read_status` SET TAGS ('dbx_business_glossary_term' = 'Read Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `read_status` SET TAGS ('dbx_value_regex' = 'validated|rejected|pending');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Read Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `read_type` SET TAGS ('dbx_business_glossary_term' = 'Read Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `read_type` SET TAGS ('dbx_value_regex' = 'actual|estimated|customer_submitted|remote_ami');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kwh|mcf|therm');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'passed|failed|manual_review');
ALTER TABLE `power_and_utilities_v2`.`metering`.`register_read` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` SET TAGS ('dbx_subdomain' = 'data_collection');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `interval_read_id` SET TAGS ('dbx_business_glossary_term' = 'Interval Read Identifier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location Identifier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `metering_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Point Identifier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `channel_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Channel Number');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `consumption_direction` SET TAGS ('dbx_business_glossary_term' = 'Consumption Direction');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `consumption_direction` SET TAGS ('dbx_value_regex' = 'delivered|received');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `corrected_value` SET TAGS ('dbx_business_glossary_term' = 'Corrected Reading Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `correction_reason` SET TAGS ('dbx_business_glossary_term' = 'Correction Reason');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `cumulative_reading` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Reading');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'AMI|Manual|SCADA');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `demand_kvar` SET TAGS ('dbx_business_glossary_term' = 'Demand (kVAR)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Demand (kW)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `device_serial` SET TAGS ('dbx_business_glossary_term' = 'Device Serial Number');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `device_serial` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `device_serial` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'linear|profile|statistical');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `interval_end` SET TAGS ('dbx_business_glossary_term' = 'Interval End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `interval_read_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `interval_read_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `interval_sequence` SET TAGS ('dbx_business_glossary_term' = 'Interval Sequence');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `interval_start` SET TAGS ('dbx_business_glossary_term' = 'Interval Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `is_missing` SET TAGS ('dbx_business_glossary_term' = 'Is Missing Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `load_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `load_profile_code` SET TAGS ('dbx_value_regex' = 'TOU|RTP|CPP');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `measurement_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `measurement_type` SET TAGS ('dbx_value_regex' = 'electricity|gas|reactive|demand');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `quality_code` SET TAGS ('dbx_business_glossary_term' = 'Quality Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `quality_code` SET TAGS ('dbx_value_regex' = 'good|suspect|bad|estimated|missing');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `read_type` SET TAGS ('dbx_business_glossary_term' = 'Read Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `read_type` SET TAGS ('dbx_value_regex' = 'actual|estimated|estimated_ve|estimated_vv');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `reading_sequence` SET TAGS ('dbx_business_glossary_term' = 'Reading Sequence Number');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `reading_value` SET TAGS ('dbx_business_glossary_term' = 'Raw Reading Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'OSIsoft_PI|Oracle_MDM|Custom');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Tariff Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|kVAR|kW|MCF|Therm');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected');
ALTER TABLE `power_and_utilities_v2`.`metering`.`interval_read` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` SET TAGS ('dbx_subdomain' = 'validation_rules');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `vee_result_id` SET TAGS ('dbx_business_glossary_term' = 'VEE Result Identifier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Identifier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `register_id` SET TAGS ('dbx_business_glossary_term' = 'Register Identifier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Identifier');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `vee_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Vee Rule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `affected_interval_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Interval Count');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `estimation_algorithm` SET TAGS ('dbx_business_glossary_term' = 'Estimation Algorithm');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `estimation_algorithm` SET TAGS ('dbx_value_regex' = 'weather_based|similar_day|linear_interpolation|statistical_model');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `interval_end` SET TAGS ('dbx_business_glossary_term' = 'Interval End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `interval_start` SET TAGS ('dbx_business_glossary_term' = 'Interval Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `issue_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `issue_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `issue_type` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Issue Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `issue_type` SET TAGS ('dbx_value_regex' = 'spike|gap|negative|rollover|comm_failure|anomalous');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'VEE Outcome');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'pass|fail|estimated|edited');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `override_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Override Reason Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `processed_value` SET TAGS ('dbx_business_glossary_term' = 'Processed Meter Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp (UTC)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `raw_value` SET TAGS ('dbx_business_glossary_term' = 'Raw Meter Reading Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|deferred');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `root_cause_classification` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Classification');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kwh|mcf|therm');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_result` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` SET TAGS ('dbx_subdomain' = 'validation_rules');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `vee_rule_id` SET TAGS ('dbx_business_glossary_term' = 'VEE Rule ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `applies_to_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Segment');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `applies_to_customer_segment` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `applies_to_rate_plan` SET TAGS ('dbx_business_glossary_term' = 'Applicable Rate Plan');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `commodity` SET TAGS ('dbx_value_regex' = 'electric|gas');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `estimation_method` SET TAGS ('dbx_value_regex' = 'linear|average|median|interpolation|custom');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `execution_count` SET TAGS ('dbx_business_glossary_term' = 'Execution Count');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Is Exclusive Rule');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `last_executed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Executed Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `max_allowed_deviation_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowed Deviation Percent');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `max_allowed_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowed Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `min_allowed_value` SET TAGS ('dbx_business_glossary_term' = 'Minimum Allowed Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `priority_order` SET TAGS ('dbx_business_glossary_term' = 'Priority Order');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'Rate Class');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `rate_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_business_glossary_term' = 'Rule Category');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `rule_category` SET TAGS ('dbx_value_regex' = 'spike|gap|negative|rollover|sum_check|other');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Rule Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'validation|estimation|editing');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `rule_version` SET TAGS ('dbx_business_glossary_term' = 'Rule Version');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Unit');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `threshold_unit` SET TAGS ('dbx_value_regex' = 'kwh|mcf|therm|percent');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Threshold Value');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `vee_rule_code` SET TAGS ('dbx_business_glossary_term' = 'Rule Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `vee_rule_description` SET TAGS ('dbx_business_glossary_term' = 'Rule Description');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `vee_rule_name` SET TAGS ('dbx_business_glossary_term' = 'Rule Name');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `vee_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Rule Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`vee_rule` ALTER COLUMN `vee_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` SET TAGS ('dbx_subdomain' = 'data_collection');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `meter_event_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Event ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `gridops_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `battery_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Battery Level Percent');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `error_code` SET TAGS ('dbx_business_glossary_term' = 'Error Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `error_message` SET TAGS ('dbx_business_glossary_term' = 'Error Message');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `estimated_flag` SET TAGS ('dbx_business_glossary_term' = 'Estimated Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `event_category` SET TAGS ('dbx_value_regex' = 'security|operational|maintenance|communication');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `event_description` SET TAGS ('dbx_business_glossary_term' = 'Event Description');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_business_glossary_term' = 'Event Severity');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `event_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|info');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'new|processed|failed|ignored');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'tamper|outage|low_battery|comm_failure|remote_connect|demand_alarm');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `is_test_event` SET TAGS ('dbx_business_glossary_term' = 'Test Event Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `meter_state` SET TAGS ('dbx_business_glossary_term' = 'Meter State');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `meter_state` SET TAGS ('dbx_value_regex' = 'installed|removed|in_service|retired|maintenance');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `processing_attempts` SET TAGS ('dbx_business_glossary_term' = 'Processing Attempts');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `processing_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Processing Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `raw_payload` SET TAGS ('dbx_business_glossary_term' = 'Raw Event Payload');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resolution Outcome');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|false_alarm|pending');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `signal_strength_dbm` SET TAGS ('dbx_business_glossary_term' = 'Signal Strength (dBm)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'MDM|PI|OMS');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` SET TAGS ('dbx_subdomain' = 'work_scheduling');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `meter_read_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Schedule ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `estimated_window_end` SET TAGS ('dbx_business_glossary_term' = 'Estimated Read Window End');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `estimated_window_start` SET TAGS ('dbx_business_glossary_term' = 'Estimated Read Window Start');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated Read');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `last_actual_read_date` SET TAGS ('dbx_business_glossary_term' = 'Last Actual Read Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `last_actual_read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Actual Read Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `meter_count_in_route` SET TAGS ('dbx_business_glossary_term' = 'Meter Count In Route');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `meter_read_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `meter_read_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `meter_read_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `read_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Read Frequency (Days)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `read_method` SET TAGS ('dbx_business_glossary_term' = 'Read Method');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `read_method` SET TAGS ('dbx_value_regex' = 'ami_remote|field_walk|drive_by');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `read_sequence` SET TAGS ('dbx_business_glossary_term' = 'Read Sequence');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `route_code` SET TAGS ('dbx_business_glossary_term' = 'Route Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'monthly|bimonthly|daily|ami');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `scheduled_read_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Read Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `scheduled_read_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Read Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_read_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` SET TAGS ('dbx_subdomain' = 'work_scheduling');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `tou_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use Schedule ID (TOU_SCHEDULE_ID)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `applicable_meter_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Meter Type (METER_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `applicable_meter_type` SET TAGS ('dbx_value_regex' = 'AMI|Non-AMI|Smart|Legacy');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `cpp_event_eligible` SET TAGS ('dbx_business_glossary_term' = 'CPP Event Eligible (CPP_ELIGIBLE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `day_type` SET TAGS ('dbx_business_glossary_term' = 'Day Type (DAY_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `day_type` SET TAGS ('dbx_value_regex' = 'weekday|weekend|holiday|special');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (END_DATE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (START_DATE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Is Default Schedule (DEFAULT_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `offpeak_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Off‑Peak Window End Time (OFFPEAK_END)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `offpeak_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Off‑Peak Window Start Time (OFFPEAK_START)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `peak_window_end_time` SET TAGS ('dbx_business_glossary_term' = 'Peak Window End Time (PEAK_END)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `peak_window_start_time` SET TAGS ('dbx_business_glossary_term' = 'Peak Window Start Time (PEAK_START)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `price_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Price Multiplier (MULTIPLIER)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'Rate Class (RATE_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `rate_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `rtp_interval_mapping` SET TAGS ('dbx_business_glossary_term' = 'RTP Interval Mapping (RTP_INTERVAL)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `rtp_interval_mapping` SET TAGS ('dbx_value_regex' = '15min|30min|60min');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Schedule Code (CODE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Schedule Name (NAME)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'TOU|RTP|CPP|Hybrid');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season (SEASON)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'summer|winter|shoulder|all_year');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `tier_definitions` SET TAGS ('dbx_business_glossary_term' = 'Tier Definitions (TIERS)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone (TIME_ZONE)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `tou_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Schedule Description (DESCRIPTION)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `tou_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `tou_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (UPDATED_BY)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`tou_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` SET TAGS ('dbx_subdomain' = 'validation_rules');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `meter_test_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Test ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Test Equipment ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `accuracy_full_load_percent` SET TAGS ('dbx_business_glossary_term' = 'Full‑Load Accuracy (%)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `accuracy_light_load_percent` SET TAGS ('dbx_business_glossary_term' = 'Light‑Load Accuracy (%)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `ambient_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Ambient Humidity (%)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (°C)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `ansi_standard` SET TAGS ('dbx_business_glossary_term' = 'ANSI Standard');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `equipment_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Calibration Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `equipment_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Calibration Due Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `error_percentage` SET TAGS ('dbx_business_glossary_term' = 'Error Percentage');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `power_factor` SET TAGS ('dbx_business_glossary_term' = 'Power Factor');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `test_conditions` SET TAGS ('dbx_business_glossary_term' = 'Test Conditions');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `test_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Test Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `test_method` SET TAGS ('dbx_business_glossary_term' = 'Test Method');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `test_method` SET TAGS ('dbx_value_regex' = 'field|lab|simulation');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `test_number` SET TAGS ('dbx_business_glossary_term' = 'Test Number');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `test_result_summary` SET TAGS ('dbx_business_glossary_term' = 'Test Result Summary');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `test_status` SET TAGS ('dbx_business_glossary_term' = 'Test Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `test_status` SET TAGS ('dbx_value_regex' = 'pass|fail|pending');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `test_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Test Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `test_type` SET TAGS ('dbx_business_glossary_term' = 'Test Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `test_type` SET TAGS ('dbx_value_regex' = 'in_service|shop|complaint');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_test` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` SET TAGS ('dbx_subdomain' = 'work_scheduling');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` SET TAGS ('dbx_association_edges' = 'asset.work_order,metering.meter');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` ALTER COLUMN `meter_work_order_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Meterworkorderassignment - Work Order Meter Id');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meterworkorderassignment - Meter Id');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Meterworkorderassignment - Work Order Id');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `power_and_utilities_v2`.`metering`.`meter_work_order_assignment` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_enrollment` SET TAGS ('dbx_subdomain' = 'work_scheduling');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_enrollment` SET TAGS ('dbx_association_edges' = 'metering.meter,engagement.dsm_program');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_enrollment` ALTER COLUMN `metering_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Enrollment Id');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_enrollment` ALTER COLUMN `dsm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Dsm Program Id');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_enrollment` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment - Meter Id');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_enrollment` ALTER COLUMN `incentive_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `power_and_utilities_v2`.`metering`.`metering_enrollment` ALTER COLUMN `metering_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `power_and_utilities_v2`.`metering`.`load_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`metering`.`load_profile` SET TAGS ('dbx_subdomain' = 'meter_asset');
ALTER TABLE `power_and_utilities_v2`.`metering`.`load_profile` ALTER COLUMN `load_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Identifier');
