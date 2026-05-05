-- Schema for Domain: generation | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:16

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`generation` COMMENT 'Owns all data related to electric power generation assets and operations across fossil fuel plants, nuclear facilities, and renewable energy sources (solar, wind, hydro). Tracks generation capacity (MW), energy output (MWh), unit performance, fuel consumption, heat rates, emissions, capacity factors, and plant availability. Supports IRP, LCOE analysis, and REC tracking. Integrates with OSIsoft PI Historian for real-time telemetry.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`plant` (
    `plant_id` BIGINT COMMENT 'Primary key for plant',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Asset Management requires each generation plant to be linked to its asset record for depreciation, capital accounting, and maintenance planning.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Required for the Balancing Area Settlement Report that allocates each plants generation to its BA for LMP calculation and regulatory compliance (FERC, NERC).',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Needed for posting plant capital expenditures to the correct GL account in the Capital Projects financial statements.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for plant-level cost allocation in the Cost Center Allocation report, enabling O&M expense tracking per plant.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Plant Operations Management reports that identify the employee responsible for each plants compliance and performance.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Regulatory Asset Registry requires each plant’s land parcel for tax and compliance reporting; linking plant to parcel enables automated reporting to FERC and local authorities.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Wholesale Power Sales Rate Schedule Assignment links each plant to the rate schedule governing its electricity sales, required for settlement and FERC reporting.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Required for Plant Real‑Time Monitoring & Control; SCADA system ID needed for operational dashboards and NERC CIP compliance reporting.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Needed for Primary Interconnection Line assignment used in transmission capacity studies and NERC reporting.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Required for Interconnection Planning Report linking each plant to its substation for reliability and regulatory filings.',
    `actual_retirement_date` DATE COMMENT 'Actual date when the generation plant was permanently retired from service. Null if plant is still operational.',
    `balancing_authority` STRING COMMENT 'NERC-registered balancing authority responsible for integrating resource plans and maintaining load-interchange-generation balance within its area.',
    `book_value_usd` DECIMAL(18,2) COMMENT 'Current net book value of the plant asset in US dollars after accumulated depreciation.',
    `capacity_factor_percent` DECIMAL(18,2) COMMENT 'Average capacity factor as a percentage, representing the ratio of actual energy output to maximum possible output over a reporting period.',
    `city` STRING COMMENT 'City where the generation plant is located.',
    `cogeneration_flag` BOOLEAN COMMENT 'Indicates whether the plant is a combined heat and power (CHP) facility producing both electricity and useful thermal energy.',
    `commercial_operation_date` DATE COMMENT 'Date when the generation plant began commercial operation and started delivering power to the grid.',
    `construction_cost_usd` DECIMAL(18,2) COMMENT 'Total capital expenditure for plant construction in US dollars, used for depreciation and rate base calculations.',
    `cooling_system_type` STRING COMMENT 'Type of cooling system employed by the plant for thermal management.. Valid values are `once_through|recirculating|dry_cooling|hybrid|none`',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the generation plant is located.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or equivalent administrative division where the plant is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plant record was first created in the system.',
    `eia_plant_code` STRING COMMENT 'EIA-assigned unique plant identifier used for federal energy data reporting and statistical analysis.. Valid values are `^[0-9]{1,6}$`',
    `emergency_contact_number` STRING COMMENT '24/7 emergency contact telephone number for the plant used for outage coordination and emergency response.. Valid values are `^+?[0-9]{10,15}$`',
    `emissions_controlled_flag` BOOLEAN COMMENT 'Indicates whether the plant has emissions control equipment installed (e.g., scrubbers, selective catalytic reduction).',
    `environmental_permit_number` STRING COMMENT 'Primary environmental operating permit number issued by EPA or state environmental agency.',
    `ferc_license_number` STRING COMMENT 'FERC-issued license number for hydroelectric projects or other facilities requiring federal authorization.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `fuel_category` STRING COMMENT 'Primary fuel or energy source used by the generation plant for electricity production. [ENUM-REF-CANDIDATE: coal|natural_gas|oil|nuclear|solar|wind|hydro|biomass|geothermal|other — 10 candidates stripped; promote to reference product]',
    `heat_rate_btu_per_kwh` DECIMAL(18,2) COMMENT 'Average heat rate of the plant in BTU per kWh, measuring thermal efficiency of fuel-to-electricity conversion. Lower values indicate higher efficiency.',
    `installed_capacity_mw` DECIMAL(18,2) COMMENT 'Total nameplate generation capacity of the plant in megawatts, representing the maximum rated output under ideal conditions.',
    `interconnection_voltage_kv` DECIMAL(18,2) COMMENT 'Voltage level in kilovolts at which the plant interconnects to the transmission grid.',
    `iso_rto_market` STRING COMMENT 'Name of the ISO or RTO market where the plant is interconnected and participates in wholesale energy markets.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the plant record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the plant location in decimal degrees.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the plant location in decimal degrees.',
    `manager_name` STRING COMMENT 'Name of the individual responsible for day-to-day operations and management of the generation facility.',
    `nerc_plant_code` STRING COMMENT 'NERC-assigned unique identifier for the generation plant used for reliability reporting and compliance.. Valid values are `^[A-Z0-9]{1,10}$`',
    `net_capacity_mw` DECIMAL(18,2) COMMENT 'Net generation capacity in megawatts after accounting for auxiliary load and station service requirements.',
    `number_of_units` STRING COMMENT 'Total count of individual generation units or turbines within the plant facility.',
    `operational_status` STRING COMMENT 'Current operational state of the generation plant indicating its availability and readiness to generate power.. Valid values are `operational|standby|mothballed|retired|under_construction|planned`',
    `ownership_type` STRING COMMENT 'Classification of the utilitys ownership or contractual relationship with the generation plant.. Valid values are `wholly_owned|joint_venture|contracted|leased|ppa`',
    `phone_number` STRING COMMENT 'Primary contact telephone number for the generation plant facility.. Valid values are `^+?[0-9]{10,15}$`',
    `planned_retirement_date` DATE COMMENT 'Scheduled date for permanent retirement or decommissioning of the generation facility. Null if no retirement is planned.',
    `plant_code` STRING COMMENT 'Internal utility-assigned alphanumeric code for the generation plant used in operational systems.. Valid values are `^[A-Z0-9]{4,12}$`',
    `plant_name` STRING COMMENT 'Official name of the generation facility as registered with regulatory authorities.',
    `plant_type` STRING COMMENT 'Primary classification of the generation facility based on the dominant generation technology employed.. Valid values are `fossil_fuel|nuclear|renewable|hybrid`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the plant location.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `primary_technology` STRING COMMENT 'Specific generation technology employed by the plant (e.g., combined cycle, steam turbine, photovoltaic, wind turbine).',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory authority governing the plant operations, typically state Public Utility Commission (PUC) or Public Service Commission (PSC).',
    `renewable_energy_certificate_eligible_flag` BOOLEAN COMMENT 'Indicates whether the plant is eligible to generate Renewable Energy Certificates under applicable renewable portfolio standards.',
    `scada_system_tag` STRING COMMENT 'Primary SCADA system tag or identifier used to retrieve real-time operational data from OSIsoft PI Historian.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the generation plant is located.. Valid values are `^[A-Z]{2}$`',
    `street_address` STRING COMMENT 'Physical street address of the generation plant facility.',
    `transmission_owner` STRING COMMENT 'Entity that owns the transmission facilities to which the plant is interconnected.',
    `water_source` STRING COMMENT 'Primary water source used for cooling or steam generation at the plant (e.g., river, lake, ocean, cooling tower).',
    CONSTRAINT pk_plant PRIMARY KEY(`plant_id`)
) COMMENT 'Master record for each electric power generation facility operated by the utility, including fossil fuel (coal, natural gas, oil), nuclear, and renewable (solar, wind, hydro) plants. Captures plant name, NERC plant code, EIA plant ID, plant type, fuel category, installed capacity (MW), commercial operation date, retirement date, regulatory jurisdiction, ISO/RTO interconnection, geographic coordinates, FERC license number, and operational status. Serves as the SSOT for generation plant identity and is the anchor entity for all generation domain products.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`generating_unit` (
    `generating_unit_id` BIGINT COMMENT 'Unique identifier for the generating unit. Primary key for the generating unit master record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Unit‑level asset tracking is needed for condition assessments, work orders, and regulatory reporting; linking unit to asset registry provides that relationship.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Needed for Unit Dispatch and AGC process where each generating unit receives setpoints within a specific balancing area for real‑time dispatch and frequency regulation.',
    `bus_id` BIGINT COMMENT 'Foreign key linking to transmission.bus. Business justification: Dispatch and power‑flow models require each units bus mapping; reflected in Real‑Time Energy Management System.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Allows budgeting and expense tracking per generating unit, required for the Unit Cost Allocation process.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Supports unit-level depreciation and O&M expense posting, used in the Unit Depreciation Schedule report.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Links Unit’s IT servers to IT Asset inventory for cost allocation, lifecycle management, and cybersecurity compliance.',
    `ot_asset_id` BIGINT COMMENT 'Foreign key linking to technology.ot_asset. Business justification: Maps each Generating Unit to its OT control asset for outage management, dispatch instructions, and maintenance planning.',
    `plant_id` BIGINT COMMENT 'Reference to the parent generation plant or facility where this unit is located.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Maintenance scheduling uses this link to assign a specific crew to each generating unit for planned outages and inspections.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Maintenance Scheduling uses site location to assign crews and equipment to each generating unit; the link supports work order routing and safety compliance.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Unit‑level metering provides SCADA verification of each generating units output for dispatch and performance reporting.',
    `ancillary_services_qualified_flag` BOOLEAN COMMENT 'Indicates whether the unit is qualified to provide ancillary services such as frequency regulation, spinning reserves, or voltage support.',
    `asset_book_value_usd` DECIMAL(18,2) COMMENT 'Current book value of the generating unit asset on the company balance sheet, measured in US dollars.',
    `balancing_authority` STRING COMMENT 'NERC-registered balancing authority responsible for real-time balancing of generation and load in the area where the unit operates.',
    `capacity_factor_target_pct` DECIMAL(18,2) COMMENT 'Target or expected capacity factor for the unit, expressed as a percentage of nameplate capacity utilization over a period.',
    `capacity_market_participation_flag` BOOLEAN COMMENT 'Indicates whether the unit participates in organized capacity markets (e.g., PJM RPM, ISO-NE FCM).',
    `carbon_capture_equipped_flag` BOOLEAN COMMENT 'Indicates whether the unit is equipped with carbon capture and sequestration (CCS) technology.',
    `cooling_system_type` STRING COMMENT 'Type of cooling system used by the generating unit for thermal management.. Valid values are `once_through|recirculating|dry_cooling|hybrid|none`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this generating unit record was first created in the system.',
    `eia_unit_code` STRING COMMENT 'Official unit identifier assigned by the U.S. Energy Information Administration for regulatory reporting.',
    `emissions_control_equipment` STRING COMMENT 'Description of installed emissions control technologies (e.g., scrubbers, SCR, baghouse, ESP) for air quality compliance.',
    `energy_storage_capacity_mwh` DECIMAL(18,2) COMMENT 'Energy storage capacity associated with the unit, if applicable (e.g., battery storage co-located with solar or wind), measured in megawatt-hours.',
    `fuel_type_primary` STRING COMMENT 'Primary fuel source used by the generating unit for energy production. [ENUM-REF-CANDIDATE: coal|natural_gas|nuclear|hydro|wind|solar|oil|biomass|geothermal|other — 10 candidates stripped; promote to reference product]',
    `fuel_type_secondary` STRING COMMENT 'Secondary or backup fuel source that the unit can use, if applicable.',
    `heat_rate_btu_per_kwh` DECIMAL(18,2) COMMENT 'Thermal efficiency measure representing the amount of fuel energy (BTU) required to produce one kilowatt-hour of electricity. Lower values indicate higher efficiency.',
    `interconnection_voltage_kv` DECIMAL(18,2) COMMENT 'Voltage level at which the generating unit interconnects to the transmission or distribution grid, measured in kilovolts.',
    `last_major_overhaul_date` DATE COMMENT 'Date of the most recent major overhaul or refurbishment of the generating unit.',
    `manufacturer` STRING COMMENT 'Name of the original equipment manufacturer (OEM) of the primary generating equipment.',
    `minimum_load_mw` DECIMAL(18,2) COMMENT 'Minimum generation level at which the unit can operate stably without shutting down, measured in megawatts.',
    `model_number` STRING COMMENT 'Manufacturer model number or designation of the generating equipment.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this generating unit record was last updated or modified.',
    `must_run_designation_flag` BOOLEAN COMMENT 'Indicates whether the unit has been designated as a must-run or reliability-must-run (RMR) unit by the RTO/ISO for grid reliability.',
    `nameplate_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum rated output capacity of the generating unit under ideal conditions, measured in megawatts.',
    `nerc_unit_code` STRING COMMENT 'Unit identifier registered with NERC for reliability compliance and reporting purposes.',
    `next_scheduled_outage_date` DATE COMMENT 'Planned date for the next scheduled maintenance outage or planned downtime.',
    `pi_historian_tag_prefix` STRING COMMENT 'Tag prefix used in OSIsoft PI Historian system for real-time telemetry data points associated with this generating unit.',
    `planned_uprate_capacity_mw` DECIMAL(18,2) COMMENT 'Expected capacity increase in megawatts from a planned uprate project.',
    `planned_uprate_date` DATE COMMENT 'Scheduled date for a planned capacity increase or uprate project for the unit.',
    `prime_mover_type` STRING COMMENT 'Type of prime mover technology used by the generating unit. ST=Steam Turbine, GT=Gas Turbine, CC=Combined Cycle, HY=Hydraulic Turbine, PV=Photovoltaic, WT=Wind Turbine, NUC=Nuclear, IC=Internal Combustion, CA=Compressed Air, CT=Combustion Turbine, CS=Combined Cycle Steam, FC=Fuel Cell, OT=Other. [ENUM-REF-CANDIDATE: ST|GT|CC|HY|PV|WT|NUC|IC|CA|CT|CS|FC|OT — 13 candidates stripped; promote to reference product]',
    `ramp_rate_mw_per_min` DECIMAL(18,2) COMMENT 'Maximum rate at which the unit can increase or decrease output, measured in megawatts per minute.',
    `regulatory_asset_base_flag` BOOLEAN COMMENT 'Indicates whether the generating unit is included in the regulatory asset base for rate recovery purposes.',
    `renewable_energy_certificate_eligible_flag` BOOLEAN COMMENT 'Indicates whether the generating unit is eligible to generate Renewable Energy Certificates under applicable renewable portfolio standards.',
    `retirement_date` DATE COMMENT 'Date when the generating unit was or is planned to be retired from service.',
    `rto_iso_region` STRING COMMENT 'The RTO or ISO market region in which the generating unit participates (e.g., PJM, CAISO, ERCOT, MISO, NYISO, ISO-NE, SPP).',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether the unit is integrated with the SCADA system for real-time monitoring and control.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to the generating equipment.',
    `startup_time_hours` DECIMAL(18,2) COMMENT 'Typical time required to bring the unit from offline to full load operation, measured in hours.',
    `summer_capacity_mw` DECIMAL(18,2) COMMENT 'Net dependable capacity of the unit during summer peak conditions, accounting for ambient temperature and auxiliary load, measured in megawatts.',
    `synchronization_date` DATE COMMENT 'Date when the generating unit was first synchronized to the electrical grid and began commercial operation.',
    `technology_type` STRING COMMENT 'Detailed technology classification of the generating unit (e.g., Pulverized Coal, Combined Cycle Gas Turbine, Onshore Wind, Utility-Scale Solar PV).',
    `unit_code` STRING COMMENT 'Internal business code or identifier for the generating unit used in operational systems and reporting.',
    `unit_name` STRING COMMENT 'Human-readable name or designation of the generating unit (e.g., Unit 1, Turbine A, Solar Block 3).',
    `unit_status` STRING COMMENT 'Current operational status of the generating unit in its lifecycle.. Valid values are `operating|standby|mothballed|retired|under_construction|planned`',
    `water_source` STRING COMMENT 'Primary water source used for cooling or steam generation (e.g., river, lake, ocean, municipal, groundwater).',
    `winter_capacity_mw` DECIMAL(18,2) COMMENT 'Net dependable capacity of the unit during winter peak conditions, accounting for ambient temperature and auxiliary load, measured in megawatts.',
    CONSTRAINT pk_generating_unit PRIMARY KEY(`generating_unit_id`)
) COMMENT 'Master record for each individual generating unit (boiler-turbine set, reactor unit, wind turbine, solar inverter block, hydro turbine) within a plant. Tracks unit name, EIA unit code, NERC unit ID, prime mover type (ST, GT, CC, HY, PV, WT, NUC), nameplate capacity (MW), summer/winter capacity ratings, heat rate (BTU/kWh), fuel type, unit status (operating, mothballed, retired), synchronization date, and associated plant. Enables unit-level performance tracking, IRP modeling, and LCOE analysis.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`energy_output` (
    `energy_output_id` BIGINT COMMENT 'Unique identifier for the energy output record. Primary key for this table.',
    `bill_line_item_id` BIGINT COMMENT 'Foreign key linking to billing.bill_line_item. Business justification: Net‑metering credits customer bills per measured generation; linking energy_output to bill_line_item enables the net‑metering credit line‑item generation.',
    `ems_dispatch_instruction_id` BIGINT COMMENT 'Reference to the EMS dispatch instruction that commanded this generation output level. Links generation output to grid operations dispatch decisions.',
    `generating_unit_id` BIGINT COMMENT 'Reference to the specific generating unit (turbine, generator, or renewable asset) that produced this energy output.',
    `plant_id` BIGINT COMMENT 'Reference to the generation facility or plant where this energy was produced.',
    `rate_schedule_version_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule_version. Business justification: Energy output records reference the specific rate schedule version applied during settlement, needed for audit trails and regulatory filing.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Provides data provenance linking Energy Output records to the SCADA system that generated them for EIA reporting and audit trails.',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'Ambient air temperature at the generation site in degrees Celsius at the time of measurement. Impacts thermal plant efficiency and renewable output (solar, wind).',
    `auxiliary_consumption_mwh` DECIMAL(18,2) COMMENT 'Electrical energy consumed by station auxiliary equipment (pumps, fans, controls, lighting) during the generation process, measured in Megawatt-hours (MWh).',
    `capacity_factor_percent` DECIMAL(18,2) COMMENT 'Ratio of actual energy output to maximum possible output over the measurement interval, expressed as a percentage. Key performance indicator for generation asset utilization.',
    `curtailment_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this generation output was curtailed (reduced below available capacity) due to grid constraints, economic dispatch, or renewable integration limits.',
    `curtailment_reason` STRING COMMENT 'Reason code for generation curtailment if curtailment_flag is true. Indicates whether curtailment was due to transmission limits, economic dispatch, or other operational factors.. Valid values are `transmission_constraint|economic|renewable_integration|frequency_regulation|voltage_support|none`',
    `data_quality_flag` STRING COMMENT 'Quality indicator for this measurement record. Good indicates validated telemetry; suspect/bad indicate potential sensor or communication issues; estimated/manual indicate non-telemetry sources.. Valid values are `good|suspect|bad|estimated|manual|calculated`',
    `emissions_co2_tons` DECIMAL(18,2) COMMENT 'Estimated carbon dioxide (CO2) emissions in tons resulting from this energy generation. Calculated based on fuel consumption and emission factors. Used for environmental reporting and carbon accounting.',
    `frequency_hz` DECIMAL(18,2) COMMENT 'Electrical frequency of the generated power in Hertz (Hz). Standard grid frequency is 60 Hz in North America. Deviations indicate grid stability issues.',
    `fuel_type` STRING COMMENT 'Primary fuel or energy source used by the generating unit to produce this energy output. Critical for emissions tracking, cost allocation, and renewable energy certificate (REC) generation. [ENUM-REF-CANDIDATE: coal|natural_gas|nuclear|hydro|wind|solar|biomass|oil|diesel — 9 candidates stripped; promote to reference product]',
    `gross_generation_mwh` DECIMAL(18,2) COMMENT 'Total electrical energy generated by the unit before any station auxiliary consumption, measured in Megawatt-hours (MWh). This is the raw output at the generator terminals.',
    `interval_duration_minutes` STRING COMMENT 'The duration of the measurement interval in minutes. Common values include 5, 15, 60 for sub-hourly, quarter-hourly, and hourly intervals.',
    `interval_end_timestamp` TIMESTAMP COMMENT 'The ending timestamp of the measurement interval for this energy output record. Used for interval-based aggregation and settlement.',
    `interval_start_timestamp` TIMESTAMP COMMENT 'The beginning timestamp of the measurement interval for this energy output record. Used for interval-based aggregation and settlement.',
    `is_renewable` BOOLEAN COMMENT 'Boolean flag indicating whether this energy output qualifies as renewable energy under applicable regulatory definitions. Used for REC tracking and renewable portfolio standard (RPS) compliance.',
    `lmp_energy_price` DECIMAL(18,2) COMMENT 'Locational Marginal Price (LMP) energy component in dollars per MWh at the settlement point for this interval. Used for revenue calculation and market settlement.',
    `market_type` STRING COMMENT 'Type of energy market in which this generation was dispatched or settled. Day-ahead market (DAM) vs real-time market (RTM) vs bilateral contract vs self-scheduled.. Valid values are `day_ahead|real_time|bilateral|self_scheduled`',
    `measurement_timestamp` TIMESTAMP COMMENT 'The precise date and time when this energy output measurement was recorded by the telemetry system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX',
    `nameplate_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum rated continuous output capacity of the generating unit in Megawatts (MW) as specified by the manufacturer. Used for capacity factor and performance calculations.',
    `net_generation_mwh` DECIMAL(18,2) COMMENT 'Net electrical energy delivered to the grid after subtracting auxiliary consumption, measured in Megawatt-hours (MWh). This is the energy available for sale or transmission.',
    `output_variance_mw` DECIMAL(18,2) COMMENT 'Difference between actual net generation and scheduled output in Megawatts (MW). Positive values indicate over-generation; negative values indicate under-generation.',
    `pi_point_tag` STRING COMMENT 'Unique identifier for the PI point in the OSIsoft PI Historian system. Used for direct lookup and integration with real-time operational systems.',
    `pi_tag_name` STRING COMMENT 'The OSIsoft PI Historian tag name that is the source of this telemetry measurement. Used for traceability back to the real-time operational data system.',
    `power_factor` DECIMAL(18,2) COMMENT 'Ratio of real power (MW) to apparent power (MVA), indicating the efficiency of power delivery. Values range from 0 to 1, with higher values indicating more efficient power delivery.',
    `reactive_power_mvar` DECIMAL(18,2) COMMENT 'Reactive power output measured in Megavolt-Amperes Reactive (MVAr). Used for voltage support and grid stability, not sold as energy but critical for transmission operations.',
    `rec_eligible` BOOLEAN COMMENT 'Boolean flag indicating whether this energy output is eligible for Renewable Energy Certificate (REC) generation under applicable state or federal programs.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this energy output record was first created in the data management system. Used for data lineage and audit trail.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this energy output record was last modified in the data management system. Used for change tracking and data quality monitoring.',
    `rto_iso_code` STRING COMMENT 'Code identifying the RTO or ISO market in which this generation occurred. Used for settlement reconciliation and market reporting (e.g., PJM, CAISO, ERCOT, MISO, NYISO, ISO-NE, SPP).',
    `scheduled_output_mw` DECIMAL(18,2) COMMENT 'Scheduled or expected generation output in Megawatts (MW) for this interval based on day-ahead commitments or dispatch instructions. Used for variance analysis.',
    `settlement_point_name` STRING COMMENT 'Name of the settlement or pricing node where this generation is injected into the grid. Used for locational marginal price (LMP) matching and financial settlement.',
    `source_system` STRING COMMENT 'Name of the source system that provided this energy output record. Typically OSIsoft PI Historian, but may include EMS, SCADA, or manual entry systems.',
    `unit_status` STRING COMMENT 'Current operational status of the generating unit at the time of measurement. Indicates whether the unit is actively generating, offline, or in transition. [ENUM-REF-CANDIDATE: online|offline|startup|shutdown|standby|maintenance|forced_outage|planned_outage — 8 candidates stripped; promote to reference product]',
    `voltage_kv` DECIMAL(18,2) COMMENT 'Output voltage at the generator terminals measured in kilovolts (kV). Critical for monitoring equipment performance and grid interconnection compliance.',
    CONSTRAINT pk_energy_output PRIMARY KEY(`energy_output_id`)
) COMMENT 'Hourly and sub-hourly generation output records for each generating unit sourced from OSIsoft PI Historian telemetry. Captures gross generation (MWh), net generation (MWh), auxiliary consumption (MWh), reactive power (MVAr), power factor, frequency, timestamp, data quality flag, and PI tag reference. Supports periodic aggregation for capacity factor calculation, FERC EQR submissions, RTO/ISO settlement reconciliation, and all generation performance KPI derivation including heat rate when combined with fuel consumption records.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` (
    `fuel_consumption_id` BIGINT COMMENT 'Unique identifier for the fuel consumption transaction record.',
    `fuel_receipt_id` BIGINT COMMENT 'Reference to the fuel delivery receipt or shipment that supplied this consumed fuel.',
    `generating_unit_id` BIGINT COMMENT 'Reference to the specific generating unit that consumed the fuel.',
    `plant_id` BIGINT COMMENT 'Reference to the power generation plant where fuel was consumed.',
    `procurement_contract_id` BIGINT COMMENT 'Reference to the fuel supply contract under which this fuel was procured and consumed.',
    `supplier_vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor that provided the consumed fuel.',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or vendor that provided the consumed fuel.',
    `ash_content_percent` DECIMAL(18,2) COMMENT 'Percentage of ash content in the consumed fuel (primarily applicable to coal), used for operational efficiency and waste management.',
    `comments` STRING COMMENT 'Free-text field for operational notes, data quality issues, or explanations of unusual consumption patterns or adjustments.',
    `consumption_date` DATE COMMENT 'The date on which the fuel was consumed by the generating unit.',
    `consumption_status` STRING COMMENT 'Status indicating whether the fuel consumption record represents actual metered consumption, estimated consumption, adjusted values, or preliminary data pending final reconciliation.. Valid values are `actual|estimated|adjusted|preliminary`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel consumption record was first created in the system.',
    `data_source_system` STRING COMMENT 'Name of the source system from which this fuel consumption record originated (e.g., OSIsoft PI Historian, SAP MM, Maximo).',
    `eia_generator_code` STRING COMMENT 'The unique generator identification code assigned by the EIA for regulatory reporting purposes.',
    `eia_plant_code` STRING COMMENT 'The unique plant identification code assigned by the EIA for regulatory reporting purposes.',
    `eia_reporting_month` STRING COMMENT 'The month for which this fuel consumption is reported to the EIA on Form 923, in YYYY-MM format.',
    `emissions_co2_tons` DECIMAL(18,2) COMMENT 'Total carbon dioxide emissions resulting from the combustion of this fuel quantity, measured in tons. Calculated using EPA emission factors.',
    `emissions_nox_tons` DECIMAL(18,2) COMMENT 'Total nitrogen oxides emissions resulting from the combustion of this fuel quantity, measured in tons. Used for air quality compliance reporting.',
    `emissions_particulate_tons` DECIMAL(18,2) COMMENT 'Total particulate matter emissions resulting from the combustion of this fuel quantity, measured in tons. Used for air quality compliance.',
    `emissions_so2_tons` DECIMAL(18,2) COMMENT 'Total sulfur dioxide emissions resulting from the combustion of this fuel quantity, measured in tons. Used for acid rain program compliance.',
    `energy_output_mwh` DECIMAL(18,2) COMMENT 'Total electrical energy output generated by the unit during the period in which this fuel was consumed, measured in Megawatt-hours (MWh). Used for heat rate calculations.',
    `fuel_cost_per_mmbtu` DECIMAL(18,2) COMMENT 'Cost per million British Thermal Units of heat input, measured in USD per MMBtu. Used for LCOE analysis and fuel cost benchmarking.',
    `fuel_cost_per_unit` DECIMAL(18,2) COMMENT 'Cost per physical unit of fuel consumed, measured in USD per unit (e.g., USD per ton, USD per MCF, USD per gallon).',
    `fuel_origin_state` STRING COMMENT 'The U.S. state or country from which the consumed fuel originated or was extracted.',
    `fuel_subtype` STRING COMMENT 'Detailed subtype or grade of fuel consumed (e.g., bituminous coal, anthracite, pipeline natural gas, liquefied natural gas).',
    `fuel_type` STRING COMMENT 'Type of fuel consumed by the generating unit during the reporting period.. Valid values are `coal|natural_gas|nuclear|diesel|fuel_oil|biomass`',
    `heat_content_per_unit` DECIMAL(18,2) COMMENT 'Average heat content of the fuel per physical unit consumed, measured in BTU per unit (e.g., BTU per ton, BTU per MCF).',
    `heat_rate` DECIMAL(18,2) COMMENT 'Thermal efficiency of the generating unit, measured in BTU per kilowatt-hour (kWh). Calculated as total_heat_input_mmbtu divided by energy_output_mwh. Lower values indicate higher efficiency.',
    `inventory_adjustment_flag` BOOLEAN COMMENT 'Indicates whether this consumption record includes an adjustment for fuel inventory reconciliation (true) or represents direct consumption only (false).',
    `meter_reading_source` STRING COMMENT 'Source system or method used to capture the fuel consumption measurement (e.g., OSIsoft PI Historian, manual meter reading, fuel flow meter, inventory reconciliation).',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel consumption record was last modified or updated.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Percentage of moisture content in the consumed fuel, affecting combustion efficiency and heat rate calculations.',
    `nerc_region` STRING COMMENT 'The NERC regional entity in which the generating unit consuming this fuel is located (e.g., WECC, ERCOT, SERC, MRO, NPCC, RFC, SPP, TRE).',
    `operating_hours` DECIMAL(18,2) COMMENT 'Total number of hours the generating unit operated during the reporting period in which this fuel was consumed.',
    `quantity_consumed` DECIMAL(18,2) COMMENT 'Physical quantity of fuel consumed during the reporting period, measured in the unit specified by quantity_unit.',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity of fuel consumed (tons for coal, MCF for natural gas, gallons for oil, MMBtu for heat content).. Valid values are `tons|mcf|mmbtu|gallons|barrels|kg`',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period for which fuel consumption is aggregated.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period for which fuel consumption is aggregated.',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'Percentage of sulfur content in the consumed fuel, used for emissions calculations and environmental compliance reporting.',
    `total_fuel_cost` DECIMAL(18,2) COMMENT 'Total cost of fuel consumed during the reporting period, measured in USD. Calculated as quantity_consumed multiplied by fuel_cost_per_unit.',
    `total_heat_input_mmbtu` DECIMAL(18,2) COMMENT 'Total heat input from fuel consumed during the reporting period, measured in million British Thermal Units (MMBtu). Calculated as quantity_consumed multiplied by heat_content_per_unit.',
    `transportation_mode` STRING COMMENT 'Primary mode of transportation used to deliver the fuel to the generation plant.. Valid values are `rail|truck|pipeline|barge|ship`',
    CONSTRAINT pk_fuel_consumption PRIMARY KEY(`fuel_consumption_id`)
) COMMENT 'Transactional record of fuel consumed by each generating unit per operating period. Captures fuel type, quantity consumed (MCF, tons, MMBtu, gallons), heat content (BTU/unit), total heat input (MMBtu), fuel cost per unit, total fuel cost, delivery receipt reference, and reporting period. Supports EIA Form 923 fuel consumption reporting, heat rate calculations, LCOE analysis, and emissions inventory.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`unit_availability` (
    `unit_availability_id` BIGINT COMMENT 'Unique identifier for the unit availability record.',
    `generating_unit_id` BIGINT COMMENT 'Reference to the generating unit (fossil fuel, nuclear, renewable) for which availability is being tracked.',
    `plant_id` BIGINT COMMENT 'Reference to the power generation plant or facility where the unit is located.',
    `transmission_outage_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_outage. Business justification: Integrated Outage Management links unit availability records to the specific transmission outage causing constraints.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance or repair work order associated with the outage or derating event, if applicable.',
    `ambient_temperature_f` DECIMAL(18,2) COMMENT 'The ambient air temperature in Fahrenheit at the time of the availability record, relevant for temperature-dependent capacity deratings.',
    `availability_date` DATE COMMENT 'The calendar date for which this availability record applies.',
    `availability_hour` STRING COMMENT 'The hour of the day (0-23) for hourly availability tracking. Null for daily aggregated records.',
    `availability_status` STRING COMMENT 'Current operational availability status of the generating unit for the specified period.. Valid values are `available|unavailable|derated|reserve_shutdown|seasonal`',
    `available_capacity_mw` DECIMAL(18,2) COMMENT 'The generating capacity in megawatts that is available for dispatch during the period.',
    `capacity_factor_percent` DECIMAL(18,2) COMMENT 'The ratio of actual available capacity to nameplate capacity expressed as a percentage for the period.',
    `data_quality_flag` STRING COMMENT 'Indicator of the quality and reliability of the availability data (verified, estimated, suspect, missing).. Valid values are `verified|estimated|suspect|missing`',
    `data_source` STRING COMMENT 'The originating system or method by which this availability data was captured (SCADA telemetry, EMS dispatch, PI Historian, manual operator entry, calculated). [ENUM-REF-CANDIDATE: scada|ems|pi_historian|manual|dms|oms|calculated — 7 candidates stripped; promote to reference product]',
    `derated_capacity_mw` DECIMAL(18,2) COMMENT 'The reduction in generating capacity in megawatts due to partial equipment failure or operational constraints while the unit remains in service.',
    `derating_flag` BOOLEAN COMMENT 'Indicates whether the unit is operating at reduced capacity due to a derating event.',
    `environmental_constraint_flag` BOOLEAN COMMENT 'Indicates whether environmental permit limits (emissions, water discharge, noise) are constraining unit availability or capacity.',
    `equivalent_availability_factor_percent` DECIMAL(18,2) COMMENT 'NERC GADS metric representing the percentage of time the unit was available to generate at full capacity, accounting for partial outages and deratings.',
    `equivalent_forced_outage_rate_percent` DECIMAL(18,2) COMMENT 'NERC GADS metric representing the percentage of time the unit was unavailable due to forced outages, including partial forced outages.',
    `event_duration_hours` DECIMAL(18,2) COMMENT 'The total duration of the availability event in hours, calculated from start to end timestamp.',
    `event_end_timestamp` TIMESTAMP COMMENT 'The precise date and time when the availability event (outage or derating) ended and the unit returned to available status. Null for ongoing events.',
    `event_start_timestamp` TIMESTAMP COMMENT 'The precise date and time when the availability event (outage or derating) began.',
    `forced_outage_capacity_mw` DECIMAL(18,2) COMMENT 'The capacity in megawatts unavailable due to unplanned forced outages caused by equipment failure or emergency conditions.',
    `forced_outage_flag` BOOLEAN COMMENT 'Indicates whether the unavailability is due to an unplanned forced outage.',
    `fuel_availability_status` STRING COMMENT 'Status of fuel availability for the generating unit, which may impact operational availability (applicable to fossil fuel and biomass units).. Valid values are `adequate|limited|critical|unavailable`',
    `gads_event_code` STRING COMMENT 'NERC GADS standardized event code classifying the type of availability event (e.g., U1, U2, U3 for unplanned outages; PO for planned outages).',
    `maintenance_outage_capacity_mw` DECIMAL(18,2) COMMENT 'The capacity in megawatts unavailable due to maintenance outages that can be deferred beyond the end of the next weekend but require attention within six weeks.',
    `nameplate_capacity_mw` DECIMAL(18,2) COMMENT 'The maximum rated output of the generating unit in megawatts under ideal conditions as specified by the manufacturer.',
    `net_dependable_capacity_mw` DECIMAL(18,2) COMMENT 'The maximum net capacity in megawatts that the unit can sustain over a specified period under normal operating conditions, accounting for station service loads.',
    `operator_notes` STRING COMMENT 'Free-text notes entered by plant operators or control room staff providing additional context about the availability event.',
    `outage_cause_code` STRING COMMENT 'Standardized code identifying the root cause or component system responsible for the outage or derating event.',
    `outage_cause_description` STRING COMMENT 'Detailed narrative description of the cause of the outage or derating event, including affected equipment and failure mode.',
    `planned_outage_capacity_mw` DECIMAL(18,2) COMMENT 'The capacity in megawatts unavailable due to scheduled planned outages for maintenance or overhaul.',
    `planned_outage_flag` BOOLEAN COMMENT 'Indicates whether the unavailability is due to a planned outage scheduled in advance.',
    `record_created_by` STRING COMMENT 'The user ID or system process that created this availability record.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was first created in the system.',
    `record_updated_by` STRING COMMENT 'The user ID or system process that last updated this availability record.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this availability record was last modified or updated.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this availability record must be included in mandatory regulatory reporting to NERC, FERC, or state PUC.',
    `responsible_system` STRING COMMENT 'The source system responsible for capturing and reporting this availability data (EMS, SCADA, PI Historian, manual entry).. Valid values are `ems|scada|pi_historian|manual_entry|dms|oms`',
    `seasonal_derating_flag` BOOLEAN COMMENT 'Indicates whether the capacity reduction is due to seasonal environmental factors (e.g., high ambient temperature, low water availability).',
    `transmission_constraint_flag` BOOLEAN COMMENT 'Indicates whether transmission system constraints are limiting the units ability to deliver available capacity to the grid.',
    `unavailable_capacity_mw` DECIMAL(18,2) COMMENT 'The generating capacity in megawatts that is unavailable due to outages or deratings during the period.',
    CONSTRAINT pk_unit_availability PRIMARY KEY(`unit_availability_id`)
) COMMENT 'Daily and hourly availability status records for each generating unit tracking available capacity (MW), unavailable capacity (MW), planned outage capacity, forced outage capacity, maintenance outage capacity, and derating events. Captures NERC GADS event codes, outage cause codes, start/end timestamps, and responsible system (EMS/SCADA). Enables SAIDI/SAIFI-equivalent generation reliability metrics, NERC GADS reporting, and capacity planning.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`generation_outage` (
    `generation_outage_id` BIGINT COMMENT 'Unique identifier for the generation outage event record.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Supports Reliability Event Reporting that aggregates generation outages by balancing area for NERC reliability metrics and outage impact analysis.',
    `crew_id` BIGINT COMMENT 'Reference to the crew responsible for outage work and restoration.',
    `generating_unit_id` BIGINT COMMENT 'Reference to the generating unit experiencing the outage.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Outage work orders require recording the lead technician who directs field activities, needed for safety and regulatory reporting.',
    `plant_id` BIGINT COMMENT 'Reference to the generation plant where the outage occurred.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Outage Impact Mapping requires site identification to coordinate emergency response and public notifications; linking outage to site supports outage management dashboards.',
    `transmission_outage_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_outage. Business justification: Coordinated Generation‑Transmission outage reporting required for NERC event correlation.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order associated with this outage, if applicable.',
    `affected_capacity_mw` DECIMAL(18,2) COMMENT 'Amount of generation capacity in megawatts that was unavailable or derated during the outage event.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the outage record was reviewed and approved for reporting.',
    `approved_by` STRING COMMENT 'Name or identifier of the operations manager or authorized personnel who approved the outage record and classification.',
    `available_capacity_mw` DECIMAL(18,2) COMMENT 'Amount of generation capacity in megawatts that remained available during a partial outage or derating event.',
    `cause_category` STRING COMMENT 'High-level categorization of the outage cause (e.g., equipment failure, fuel supply issue, environmental constraint, regulatory requirement, economic dispatch).',
    `component_failed` STRING COMMENT 'Specific equipment component or system that failed or required maintenance, triggering the outage event.',
    `corrective_action` STRING COMMENT 'Description of the corrective actions, repairs, or maintenance activities performed to resolve the outage.',
    `data_source` STRING COMMENT 'Source system or interface from which the outage data was captured (e.g., OSIsoft PI Historian, Maximo EAM, manual entry, SCADA).',
    `derating_percentage` DECIMAL(18,2) COMMENT 'Percentage of nameplate capacity lost during a derating event, expressed as a decimal (e.g., 25.50 for 25.5%).',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the outage event measured in hours, calculated from start to end timestamp.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the generating unit outage ended or capacity was restored.',
    `energy_not_produced_mwh` DECIMAL(18,2) COMMENT 'Estimated amount of energy in megawatt-hours that was not generated due to the outage, calculated based on expected dispatch and outage duration.',
    `equivalent_availability_factor` DECIMAL(18,2) COMMENT 'Calculated metric representing the percentage of time the unit was available to generate at full capacity, accounting for both full and partial outages.',
    `estimated_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost of the outage in US dollars, including repair costs, replacement power costs, and lost revenue.',
    `event_number` STRING COMMENT 'Business identifier for the outage event, used for tracking and reporting.',
    `forced_outage_rate` DECIMAL(18,2) COMMENT 'Calculated metric representing the percentage of time the unit was unavailable due to forced outages, used for reliability assessment.',
    `is_derating_event` BOOLEAN COMMENT 'Flag indicating whether this outage represents a partial capacity loss (derating) rather than a full unit outage.',
    `is_reportable_to_nerc` BOOLEAN COMMENT 'Flag indicating whether this outage event meets NERC GADS reporting thresholds and must be included in regulatory submissions.',
    `nerc_cause_code` STRING COMMENT 'NERC GADS standardized cause code identifying the root cause category of the outage (e.g., boiler, turbine, generator, auxiliary equipment).',
    `nerc_event_code` STRING COMMENT 'NERC GADS standardized event code providing detailed classification of the outage event type.',
    `notification_timestamp` TIMESTAMP COMMENT 'Date and time when the outage was first reported or notified to grid operations and scheduling.',
    `outage_description` STRING COMMENT 'Detailed narrative description of the outage event, including symptoms, root cause findings, and corrective actions taken.',
    `outage_status` STRING COMMENT 'Current lifecycle status of the outage event.. Valid values are `active|completed|cancelled|pending`',
    `outage_type` STRING COMMENT 'Classification of the outage event: planned (scheduled in advance), forced (unplanned failure), maintenance (routine upkeep), or derating (partial capacity reduction).. Valid values are `planned|forced|maintenance|derating`',
    `planned_outage_factor` DECIMAL(18,2) COMMENT 'Calculated metric representing the percentage of time the unit was unavailable due to planned outages.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this outage record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this outage record was last modified or updated.',
    `replacement_power_cost_usd` DECIMAL(18,2) COMMENT 'Cost in US dollars of purchasing replacement power from the market or other sources to cover the unavailable generation capacity.',
    `reporting_period` STRING COMMENT 'The reporting period (e.g., monthly, quarterly, annual) to which this outage event is attributed for NERC GADS and internal reliability reporting.',
    `return_to_service_timestamp` TIMESTAMP COMMENT 'Date and time when the generating unit was officially returned to service and available for dispatch.',
    `scheduled_return_timestamp` TIMESTAMP COMMENT 'Originally scheduled or estimated date and time for the unit to return to service.',
    `service_factor` DECIMAL(18,2) COMMENT 'Calculated metric representing the percentage of time the unit was in active service during the reporting period.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the generating unit outage began or capacity became unavailable.',
    `unavailable_capacity_forced_mw` DECIMAL(18,2) COMMENT 'Amount of generation capacity in megawatts unavailable due to forced (unplanned) outage events.',
    `unavailable_capacity_maintenance_mw` DECIMAL(18,2) COMMENT 'Amount of generation capacity in megawatts unavailable due to maintenance outage activities.',
    `unavailable_capacity_planned_mw` DECIMAL(18,2) COMMENT 'Amount of generation capacity in megawatts unavailable due to planned outage activities.',
    CONSTRAINT pk_generation_outage PRIMARY KEY(`generation_outage_id`)
) COMMENT 'Single source of truth for all generating unit outages, deratings, and availability states. Captures planned, forced, and maintenance outages as well as daily/hourly availability status records including available capacity (MW), unavailable capacity by cause category (planned, forced, maintenance), and derating events with partial capacity loss. Records outage type, NERC GADS cause code and event code, affected capacity (MW), outage start/end timestamps, return-to-service time, responsible crew, and work order reference. Calculates equivalent availability factor (EAF), forced outage rate (FOR), planned outage factor (POF), and service factor. Serves as the single source of truth for NERC GADS reporting (IEEE 762), generation reliability metrics, capacity planning, and all unit availability tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`emissions_record` (
    `emissions_record_id` BIGINT COMMENT 'Unique identifier for the emissions record. Primary key for this transactional emissions data entity.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Enables Emissions Compliance Report summarizing emissions per balancing area to satisfy regional environmental regulations and market carbon accounting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Emissions compliance reports must attribute the responsible compliance officer employee for audit trails and regulator filings.',
    `generating_unit_id` BIGINT COMMENT 'Foreign key reference to the generating unit that produced these emissions. Links to the generation asset master data.',
    `permit_id` BIGINT COMMENT 'Identifier for the EPA or state air quality permit governing emissions limits for this generating unit. Links emissions data to regulatory compliance requirements.',
    `plant_id` BIGINT COMMENT 'Foreign key reference to the power generation plant where the emissions occurred. Links to the plant master data.',
    `cems_monitor_code` STRING COMMENT 'EPA-assigned identifier for the continuous emissions monitoring system that recorded this data. Required for EPA compliance reporting and data quality assurance.',
    `certification_date` DATE COMMENT 'The date when the emissions data was certified by a qualified professional for regulatory submission. Required for EPA compliance documentation.',
    `certification_status` STRING COMMENT 'Certification status of the emissions data by a qualified professional engineer or responsible official as required by EPA regulations.. Valid values are `certified|pending_certification|rejected|recertification_required`',
    `certified_by` STRING COMMENT 'Name of the qualified professional engineer or responsible official who certified the accuracy of this emissions data for regulatory submission.',
    `co2_emissions_tons` DECIMAL(18,2) COMMENT 'Total carbon dioxide emissions measured in tons for the reporting period. Required for EPA Greenhouse Gas Reporting Program and climate change reporting.',
    `co2_rate_per_mmbtu` DECIMAL(18,2) COMMENT 'Carbon dioxide emissions rate expressed as tons per million British thermal units of heat input. Alternative carbon intensity metric based on fuel consumption.',
    `co2_rate_per_mwh` DECIMAL(18,2) COMMENT 'Carbon dioxide emissions rate expressed as tons per megawatt-hour of gross generation. Used for carbon intensity benchmarking and climate reporting.',
    `co2e_emissions_tons` DECIMAL(18,2) COMMENT 'Total greenhouse gas emissions expressed as carbon dioxide equivalent in tons, accounting for global warming potential of all GHGs. Used for comprehensive climate impact reporting.',
    `comments` STRING COMMENT 'Free-text field for additional notes, explanations, or context regarding the emissions data, monitoring conditions, or compliance issues.',
    `compliance_status` STRING COMMENT 'Current compliance status of the emissions record against applicable EPA permits and state air quality standards. Indicates whether emissions are within permitted limits.. Valid values are `compliant|non_compliant|pending_review|exempt`',
    `control_equipment_status` STRING COMMENT 'Operational status of emissions control equipment (scrubbers, baghouses, SCR systems) during the reporting period. Impacts emissions levels and compliance.. Valid values are `operational|degraded|offline|maintenance`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this emissions record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_quality_indicator` STRING COMMENT 'Indicates the quality and reliability of the emissions data. Valid = measured data, substitute = backup monitoring, missing = data gap, estimated = calculated approximation.. Valid values are `valid|substitute|missing|estimated`',
    `emissions_record_number` STRING COMMENT 'Business identifier for the emissions record, typically used for external reporting and audit trail purposes.',
    `exceedance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether any emissions exceeded permit limits during the reporting period. True = exceedance occurred, False = within limits.',
    `exceedance_reason` STRING COMMENT 'Detailed explanation of the reason for any permit exceedance, including contributing factors and corrective actions taken. Required for EPA compliance reporting.',
    `fuel_type` STRING COMMENT 'Primary fuel type used by the generating unit during the reporting period. Determines applicable emissions standards and reporting requirements. [ENUM-REF-CANDIDATE: coal|natural_gas|oil|nuclear|hydro|wind|solar — 7 candidates stripped; promote to reference product]',
    `gross_generation_mwh` DECIMAL(18,2) COMMENT 'Total gross electrical energy generated measured in megawatt-hours for the reporting period. Used to calculate emissions rates per unit of energy produced.',
    `heat_input_mmbtu` DECIMAL(18,2) COMMENT 'Total heat input to the generating unit measured in million British thermal units for the reporting period. Used to calculate emissions rates and heat rate efficiency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this emissions record was last updated in the system. Used for audit trail and change tracking.',
    `measurement_timestamp` TIMESTAMP COMMENT 'The precise date and time when the emissions measurement was recorded. This is the principal business event timestamp for this transactional record.',
    `mercury_emissions_lbs` DECIMAL(18,2) COMMENT 'Total mercury emissions measured in pounds for the reporting period. Required for EPA Mercury and Air Toxics Standards (MATS) compliance.',
    `monitoring_method` STRING COMMENT 'The method used to measure or calculate emissions for this record. CEMS = Continuous Emissions Monitoring System, PEMS = Predictive Emissions Monitoring System.. Valid values are `CEMS|PEMS|fuel_sampling|mass_balance|engineering_calculation`',
    `nox_emissions_tons` DECIMAL(18,2) COMMENT 'Total nitrogen oxides emissions measured in tons for the reporting period. Required for EPA NOx Budget Trading Program and state air quality compliance.',
    `nox_rate_per_mmbtu` DECIMAL(18,2) COMMENT 'Nitrogen oxides emissions rate expressed as pounds per million British thermal units of heat input. Key compliance metric for EPA NOx emission standards.',
    `operating_hours` DECIMAL(18,2) COMMENT 'Total number of hours the generating unit operated during the reporting period. Used to calculate availability and emissions intensity metrics.',
    `particulate_matter_emissions_lbs` DECIMAL(18,2) COMMENT 'Total particulate matter emissions measured in pounds for the reporting period. Includes PM2.5 and PM10 for air quality compliance.',
    `permit_limit_nox_tons` DECIMAL(18,2) COMMENT 'Maximum allowable nitrogen oxides emissions in tons as specified in the air quality permit for the reporting period. Used to assess compliance status.',
    `permit_limit_so2_tons` DECIMAL(18,2) COMMENT 'Maximum allowable sulfur dioxide emissions in tons as specified in the air quality permit for the reporting period. Used to assess compliance status.',
    `reporting_jurisdiction` STRING COMMENT 'The regulatory jurisdiction (EPA region, state, or local air quality district) to which this emissions data must be reported. Determines applicable reporting requirements.',
    `reporting_period_end` TIMESTAMP COMMENT 'The end date and time of the emissions reporting period. Represents the conclusion of the measurement window for this emissions data.',
    `reporting_period_start` TIMESTAMP COMMENT 'The start date and time of the emissions reporting period. Represents the beginning of the measurement window for this emissions data.',
    `so2_emissions_tons` DECIMAL(18,2) COMMENT 'Total sulfur dioxide emissions measured in tons for the reporting period. Critical for EPA Clean Air Act compliance and acid rain program reporting.',
    `so2_rate_per_mmbtu` DECIMAL(18,2) COMMENT 'Sulfur dioxide emissions rate expressed as pounds per million British thermal units of heat input. Key compliance metric for EPA emission standards.',
    `source_system` STRING COMMENT 'The name of the operational system that originated this emissions record, typically OSIsoft PI Historian or EPA CEMS reporting system.',
    `submission_date` DATE COMMENT 'The date when this emissions record was submitted to the regulatory authority for compliance reporting. Used to track reporting timeliness.',
    CONSTRAINT pk_emissions_record PRIMARY KEY(`emissions_record_id`)
) COMMENT 'Transactional emissions data for each generating unit capturing SO2 (tons), NOx (tons), CO2 (tons), CO2e (tons), mercury (lbs), particulate matter (lbs), heat input (MMBtu), emissions rates per MMBtu and per MWh, EPA CEMS monitor ID, reporting period, and compliance status against applicable EPA permits and state air quality standards. Supports EPA Clean Air Act reporting, FERC EQR, and state PUC environmental compliance filings.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` (
    `rec_certificate_id` BIGINT COMMENT 'Unique identifier for the renewable energy certificate record. Primary key for the generation REC certificate product.',
    `bill_line_item_id` BIGINT COMMENT 'Foreign key linking to billing.bill_line_item. Business justification: REC transactions are billed as line items on customer invoices; the FK supports the REC billing report required for compliance and revenue tracking.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: REC allocation program assigns each generation certificate to a specific customer account for green‑power reporting and compliance.',
    `energy_output_id` BIGINT COMMENT 'Reference to the underlying generation output record in the generation domain that documents the MWh production for which this REC was issued.',
    `generating_unit_id` BIGINT COMMENT 'Reference to the specific generating unit (solar array, wind turbine, hydro facility, biomass plant) that produced the renewable energy for which this REC was issued.',
    `facility_id` BIGINT COMMENT 'Reference to the parent generation facility or plant where the renewable energy was produced.',
    `generation_record_energy_output_id` BIGINT COMMENT 'Reference to the underlying generation output record in the generation domain that documents the MWh production for which this REC was issued.',
    `meter_id` BIGINT COMMENT 'Identifier of the revenue-quality meter that measured the generation for which this REC was issued. Used for audit and verification purposes.',
    `plant_id` BIGINT COMMENT 'Reference to the parent generation facility or plant where the renewable energy was produced.',
    `ppa_contract_id` BIGINT COMMENT 'Reference to the PPA contract under which the renewable energy was procured, if applicable. Links REC to contractual obligations.',
    `certificate_status` STRING COMMENT 'Current lifecycle status of the REC. Issued: newly created; Active: available for trading; Retired: used for compliance or voluntary claim; Transferred: moved to another account; Expired: past eligibility window; Cancelled: invalidated.. Valid values are `issued|active|retired|transferred|expired|cancelled`',
    `compliance_jurisdiction` STRING COMMENT 'State or regulatory jurisdiction for which this REC is eligible for RPS compliance (e.g., California, Massachusetts, New York). Some RECs may be eligible in multiple jurisdictions.',
    `compliance_year` STRING COMMENT 'Year for which this REC was or will be used to meet RPS compliance obligations. May differ from vintage year due to banking provisions.',
    `counterparty_name` STRING COMMENT 'Name of the party with whom the REC was traded (buyer or seller). Used for transaction tracking and reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this REC certificate record was first created in the system.',
    `eligibility_flags` STRING COMMENT 'Comma-separated list of special eligibility designations for this REC (e.g., Tier 1, Tier 2, Solar Carve-Out, Offshore Wind, In-State, New Vintage). Used to determine which RPS requirements the REC can satisfy.',
    `energy_output_mwh` DECIMAL(18,2) COMMENT 'Quantity of renewable electricity generated in megawatt-hours (MWh) for which this REC was issued. Typically one REC represents one MWh of renewable generation.',
    `expiration_date` DATE COMMENT 'Date after which the REC is no longer eligible for use in compliance programs. Many RPS programs have vintage limits (e.g., RECs must be used within 3 years of generation).',
    `facility_capacity_mw` DECIMAL(18,2) COMMENT 'Nameplate generation capacity of the facility in megawatts. Some RPS programs have size limits or tiers based on facility capacity.',
    `facility_commissioning_date` DATE COMMENT 'Date when the generating facility first began commercial operation. Some RPS programs have vintage requirements based on facility age.',
    `facility_location_country` STRING COMMENT 'Country where the generating facility is located. Most U.S. RPS programs only accept RECs from facilities in the U.S. or specific Canadian provinces.. Valid values are `USA|CAN|MEX`',
    `facility_location_state` STRING COMMENT 'U.S. state or Canadian province where the generating facility is located. Geographic location affects RPS eligibility in many jurisdictions.',
    `fuel_source` STRING COMMENT 'Type of renewable energy source used to generate the electricity for which this REC was issued. Determines eligibility for various RPS compliance programs.. Valid values are `solar|wind|hydro|biomass|geothermal|landfill_gas`',
    `fuel_source_subcategory` STRING COMMENT 'More granular classification of the renewable fuel source (e.g., photovoltaic solar, concentrated solar, onshore wind, offshore wind, run-of-river hydro, pumped storage hydro, wood biomass, agricultural biomass).',
    `generation_end_date` DATE COMMENT 'End date of the generation period during which the renewable energy was produced.',
    `generation_month` STRING COMMENT 'Month (1-12) in which the renewable energy was generated. Used for reporting and compliance tracking.',
    `generation_start_date` DATE COMMENT 'Start date of the generation period during which the renewable energy was produced. RECs are typically issued for monthly or quarterly generation periods.',
    `generation_year` STRING COMMENT 'Calendar year in which the renewable energy was generated.',
    `issuance_date` DATE COMMENT 'Date on which the REC was officially issued by the tracking system registry after verification of generation data.',
    `market_value_usd` DECIMAL(18,2) COMMENT 'Estimated or actual market value of the REC in U.S. dollars at the time of issuance or transaction. Used for financial reporting and asset valuation.',
    `notes` STRING COMMENT 'Free-text field for additional information about the REC, such as special eligibility conditions, transaction details, or compliance notes.',
    `rec_quantity` DECIMAL(18,2) COMMENT 'Number of RECs represented by this certificate record. Typically 1 REC equals 1 MWh, but some jurisdictions may use different ratios or fractional RECs.',
    `rec_serial_number` STRING COMMENT 'Unique serial number assigned by the tracking system registry to identify this specific REC. This is the externally-recognized business identifier for the certificate.. Valid values are `^[A-Z0-9]{10,30}$`',
    `retirement_account` STRING COMMENT 'Tracking system account into which the REC was retired. Used to identify the beneficiary of the renewable energy claim.',
    `retirement_date` DATE COMMENT 'Date on which the REC was retired (permanently removed from circulation) for compliance or voluntary purposes. Null if not yet retired.',
    `retirement_purpose` STRING COMMENT 'Reason for which the REC was retired. RPS Compliance: used to meet state renewable portfolio standard requirements; Voluntary: used for voluntary green power programs or corporate sustainability claims.. Valid values are `rps_compliance|voluntary_green_power|carbon_offset|corporate_sustainability|utility_green_tariff|not_retired`',
    `tracking_system` STRING COMMENT 'Regional or state tracking system registry that issued and tracks this REC (e.g., WREGIS for Western states, NEPOOL GIS for New England, PJM GATS for Mid-Atlantic, M-RETS for Midwest). [ENUM-REF-CANDIDATE: WREGIS|NEPOOL_GIS|PJM_GATS|M_RETS|NAR|ERCOT|MIRECS — 7 candidates stripped; promote to reference product]',
    `tracking_system_account_number` STRING COMMENT 'Account identifier in the tracking system registry under which this REC is held or was issued.',
    `transaction_date` DATE COMMENT 'Date on which a sale or purchase transaction involving this REC was executed. Null if REC was not traded.',
    `transaction_price_usd` DECIMAL(18,2) COMMENT 'Actual price paid or received for the REC in a sale or purchase transaction, in U.S. dollars. Null if REC was not traded.',
    `transfer_date` DATE COMMENT 'Date on which the REC was transferred from one tracking system account to another. Null if never transferred.',
    `transfer_recipient_account` STRING COMMENT 'Tracking system account identifier of the party to whom the REC was transferred.',
    `updated_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this REC certificate record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this REC certificate record was last modified in the system.',
    `verification_date` DATE COMMENT 'Date on which the tracking system completed verification of the generation data and approved issuance of the REC.',
    `verification_status` STRING COMMENT 'Status of the tracking system verification process for the generation data underlying this REC. Verified RECs have passed all data quality and eligibility checks.. Valid values are `pending|verified|rejected|under_review`',
    `vintage_year` STRING COMMENT 'Year in which the renewable energy was generated, used for REC vintage classification. Some RPS programs require specific vintage years for compliance.',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this REC certificate record.',
    CONSTRAINT pk_rec_certificate PRIMARY KEY(`rec_certificate_id`)
) COMMENT 'Renewable Energy Certificate (REC) records tracking each MWh of renewable generation eligible for REC issuance. Captures REC serial number, generating unit, generation period, fuel source (solar, wind, hydro, biomass), vintage year, tracking system (WREGIS, NEPOOL GIS, PJM GATS), certificate status (issued, retired, transferred, expired), retirement purpose (RPS compliance, voluntary), and associated energy output record. Supports state RPS compliance and voluntary renewable energy programs.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` (
    `ppa_delivery_id` BIGINT COMMENT 'Unique identifier for each PPA delivery transaction record.',
    `balancing_area_id` BIGINT COMMENT 'Reference to the balancing authority area in which this delivery occurred, relevant for grid operations and settlement.',
    `balancing_authority_balancing_area_id` BIGINT COMMENT 'Reference to the balancing authority area in which this delivery occurred, relevant for grid operations and settlement.',
    `bill_id` BIGINT COMMENT 'Foreign key linking to billing.bill. Business justification: PPA settlement creates an invoice for the off‑taker; linking ppa_delivery to bill enables the PPA billing process required by contract terms.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: PPA delivery records must be tied to the customer account receiving the power, supporting invoicing, settlement, and compliance reporting.',
    `ems_dispatch_instruction_id` BIGINT COMMENT 'Reference to the Energy Management System (EMS) dispatch instruction that authorized or scheduled this delivery.',
    `generating_unit_id` BIGINT COMMENT 'Reference to the specific generation unit within the facility that produced the delivered energy.',
    `facility_id` BIGINT COMMENT 'Reference to the generation facility or plant that produced the energy delivered under this PPA transaction.',
    `meter_id` BIGINT COMMENT 'Identifier of the revenue-grade meter or SCADA point used to measure actual energy delivery for this transaction.',
    `plant_id` BIGINT COMMENT 'Reference to the generation facility or plant that produced the energy delivered under this PPA transaction.',
    `ppa_contract_id` BIGINT COMMENT 'Reference to the parent PPA contract under which this delivery occurred.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: PPA delivery points are physically tied to a transmission line; needed for settlement and congestion revenue calculations.',
    `actual_delivery_mwh` DECIMAL(18,2) COMMENT 'The actual amount of energy in megawatt-hours (MWh) that was delivered during this period, as measured by metering systems.',
    `ancillary_services_amount` DECIMAL(18,2) COMMENT 'The dollar amount charged for ancillary services such as frequency regulation, voltage support, and operating reserves associated with this delivery.',
    `capacity_payment_amount` DECIMAL(18,2) COMMENT 'The dollar amount paid for capacity availability during this delivery period, separate from energy payment, if the PPA includes capacity charges.',
    `contracted_price_per_mwh` DECIMAL(18,2) COMMENT 'The base price per megawatt-hour (MWh) specified in the PPA contract for this delivery period.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this delivery transaction record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this transaction. Power and Utilities operates exclusively in USD.. Valid values are `USD`',
    `curtailment_mwh` DECIMAL(18,2) COMMENT 'The amount of energy in megawatt-hours (MWh) that was curtailed or not delivered due to grid constraints, economic dispatch, or other operational reasons.',
    `curtailment_reason_code` STRING COMMENT 'Standardized code indicating the primary reason for any curtailment of scheduled delivery.. Valid values are `grid_congestion|economic_dispatch|forced_outage|planned_maintenance|renewable_variability|buyer_request`',
    `curtailment_reason_description` STRING COMMENT 'Detailed narrative explanation of the circumstances that led to curtailment of the scheduled delivery.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Calculated score (0-100) representing the completeness and accuracy of this delivery record based on validation rules.',
    `delivery_date` DATE COMMENT 'The calendar date on which the energy delivery occurred, used for daily aggregation and reporting.',
    `delivery_period_end` TIMESTAMP COMMENT 'The timestamp when the delivery period ended, representing the conclusion of energy flow under this transaction.',
    `delivery_period_start` TIMESTAMP COMMENT 'The timestamp when the delivery period began, representing the start of energy flow under this transaction.',
    `delivery_point_code` BIGINT COMMENT 'Reference to the physical or virtual delivery point where energy was transferred to the buyer under the PPA.',
    `delivery_status` STRING COMMENT 'Current lifecycle status of the delivery transaction in the settlement workflow.. Valid values are `scheduled|delivered|partially_delivered|curtailed|settled|disputed`',
    `delivery_transaction_number` STRING COMMENT 'Externally-known unique transaction identifier for this delivery event, used for settlement and reconciliation.. Valid values are `^[A-Z0-9]{8,20}$`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this delivery transaction is currently under dispute between buyer and seller regarding quantity, price, or other terms.',
    `dispute_reason` STRING COMMENT 'Narrative description of the reason for dispute if dispute_flag is True.',
    `energy_payment_amount` DECIMAL(18,2) COMMENT 'The dollar amount paid specifically for energy delivered (MWh), calculated as actual delivery multiplied by energy price component.',
    `force_majeure_flag` BOOLEAN COMMENT 'Indicates whether this delivery was affected by a force majeure event as defined in the PPA contract, which may excuse non-performance.',
    `invoice_number` STRING COMMENT 'The invoice number associated with billing for this delivery transaction, used for reconciliation with accounts receivable or payable.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this delivery transaction record was most recently updated.',
    `market_type` STRING COMMENT 'The energy market context in which this delivery was scheduled and settled.. Valid values are `day_ahead|real_time|bilateral|forward`',
    `meter_reading_source` STRING COMMENT 'Indicates the source system or method used to determine actual delivery MWh values.. Valid values are `scada|revenue_meter|estimated|settlement_system`',
    `notes` STRING COMMENT 'Free-form text field for additional comments, operational notes, or context regarding this delivery transaction.',
    `price_adjustment_amount` DECIMAL(18,2) COMMENT 'Total dollar amount of adjustments applied to the base contracted price, including penalties, bonuses, indexation, or other contractual modifications.',
    `rec_quantity` DECIMAL(18,2) COMMENT 'The number of Renewable Energy Certificates (RECs) associated with this delivery, typically equal to actual delivery MWh for renewable generation sources.',
    `rec_transfer_flag` BOOLEAN COMMENT 'Indicates whether RECs were transferred to the buyer as part of this delivery transaction (True) or retained by the seller (False).',
    `reconciliation_status` STRING COMMENT 'Status of the reconciliation process between scheduled and actual delivery, and between trading and billing systems.. Valid values are `pending|reconciled|variance_accepted|under_review`',
    `scheduled_delivery_mwh` DECIMAL(18,2) COMMENT 'The contracted or scheduled amount of energy in megawatt-hours (MWh) that was planned for delivery during this period.',
    `scheduling_coordinator` STRING COMMENT 'Name or identifier of the entity responsible for scheduling this delivery with the Independent System Operator (ISO) or Regional Transmission Organization (RTO).',
    `settlement_date` DATE COMMENT 'The date on which financial settlement for this delivery transaction was completed or is scheduled to be completed.',
    `settlement_price_per_mwh` DECIMAL(18,2) COMMENT 'The price per megawatt-hour (MWh) applied to this delivery for settlement purposes, which may differ from the contracted price due to adjustments, penalties, or market conditions.',
    `source_system` STRING COMMENT 'The operational system of record from which this delivery transaction data originated.. Valid values are `allegro_etrm|pi_historian|mdm|settlement_system`',
    `time_of_use_period` STRING COMMENT 'The time-of-use pricing period classification for this delivery, affecting settlement price and capacity value.. Valid values are `on_peak|off_peak|shoulder|super_peak`',
    `total_payment_amount` DECIMAL(18,2) COMMENT 'The total dollar amount payable for this delivery transaction, calculated as actual delivery multiplied by settlement price plus any adjustments.',
    `transmission_charge_amount` DECIMAL(18,2) COMMENT 'The dollar amount of transmission and delivery charges associated with moving the energy from generation point to delivery point.',
    `variance_mwh` DECIMAL(18,2) COMMENT 'The difference between scheduled and actual delivery in megawatt-hours (MWh), calculated as actual minus scheduled, used for performance monitoring and settlement adjustments.',
    CONSTRAINT pk_ppa_delivery PRIMARY KEY(`ppa_delivery_id`)
) COMMENT 'Transactional records of actual energy deliveries under each PPA contract on a daily or monthly basis. Captures scheduled delivery (MWh), actual delivery (MWh), curtailment (MWh), curtailment reason, settlement price, total payment amount, delivery period, and variance from contracted volume. Supports PPA performance monitoring, invoice reconciliation with trading/billing domains, and FERC EQR reporting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`forecast` (
    `forecast_id` BIGINT COMMENT 'Unique identifier for the generation forecast record. Primary key.',
    `generating_unit_id` BIGINT COMMENT 'Reference to the specific generation unit within the plant. Nullable if forecast applies to entire plant.',
    `plant_id` BIGINT COMMENT 'Reference to the generation plant or facility for which this forecast applies.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Weather‑adjusted generation forecasts require site‑specific meteorological data; linking forecast to site enables accurate market bidding and grid dispatch planning.',
    `ambient_temperature_f` DECIMAL(18,2) COMMENT 'Forecasted ambient air temperature in Fahrenheit used as input assumption. Impacts thermal plant efficiency and renewable output.',
    `approved_by` STRING COMMENT 'Username or identifier of the supervisor or system that approved this forecast for operational use. Null if not yet approved.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast was approved for operational use or market submission. Null if not yet approved.',
    `confidence_interval_lower_mwh` DECIMAL(18,2) COMMENT 'Lower bound of the statistical confidence interval for forecasted net generation, typically representing the 10th or 5th percentile outcome. Used for risk assessment and reserve planning.',
    `confidence_interval_upper_mwh` DECIMAL(18,2) COMMENT 'Upper bound of the statistical confidence interval for forecasted net generation, typically representing the 90th or 95th percentile outcome. Used for risk assessment and reserve planning.',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level associated with the forecast interval bounds, expressed as a percentage (e.g., 90%, 95%). Indicates the probability that actual generation will fall within the specified interval.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was initially created in the system. Audit trail for forecast generation timing.',
    `error_mwh` DECIMAL(18,2) COMMENT 'Calculated difference between forecasted and actual generation for historical records. Populated post-facto for model performance tracking and continuous improvement. Null for future forecasts.',
    `error_percent` DECIMAL(18,2) COMMENT 'Percentage error between forecasted and actual generation for historical records. Populated post-facto for model accuracy assessment. Null for future forecasts.',
    `forced_outage_probability` DECIMAL(18,2) COMMENT 'Estimated probability of an unplanned forced outage occurring during the forecast period, expressed as a decimal (0.0 to 1.0). Used for reliability planning.',
    `forecast_number` STRING COMMENT 'Business identifier for the generation forecast, used for external reference and tracking in Energy Management System (EMS) and Day-Ahead Market (DAM) submissions.. Valid values are `^GF-[0-9]{8}-[0-9]{4}$`',
    `forecast_status` STRING COMMENT 'Current lifecycle status of the generation forecast record.. Valid values are `draft|submitted|approved|superseded|cancelled|active`',
    `forecasted_capacity_factor_percent` DECIMAL(18,2) COMMENT 'Predicted ratio of actual generation output to maximum possible output over the forecast period, expressed as a percentage. Key metric for renewable energy sources and Integrated Resource Plan (IRP) analysis.',
    `forecasted_capacity_mw` DECIMAL(18,2) COMMENT 'Predicted instantaneous generation capacity available during the forecast period, measured in Megawatts (MW). Represents the maximum power output the unit or plant can deliver.',
    `forecasted_emissions_co2_tons` DECIMAL(18,2) COMMENT 'Predicted carbon dioxide emissions in tons for the forecast period. Used for environmental compliance and Renewable Energy Certificate (REC) tracking.',
    `forecasted_emissions_nox_lbs` DECIMAL(18,2) COMMENT 'Predicted nitrogen oxides emissions in pounds for the forecast period. Required for EPA air quality compliance reporting.',
    `forecasted_emissions_so2_lbs` DECIMAL(18,2) COMMENT 'Predicted sulfur dioxide emissions in pounds for the forecast period. Required for EPA air quality compliance reporting.',
    `forecasted_fuel_consumption` DECIMAL(18,2) COMMENT 'Predicted fuel consumption quantity for the forecast period. Unit of measure varies by fuel type (tons for coal, MCF for natural gas, gallons for oil).',
    `forecasted_gross_generation_mwh` DECIMAL(18,2) COMMENT 'Predicted total electrical energy output at the generator terminals before accounting for auxiliary load or station service, measured in Megawatt-Hours (MWh).',
    `forecasted_heat_rate_btu_per_kwh` DECIMAL(18,2) COMMENT 'Predicted thermal efficiency of the generation unit, measured as BTU of fuel input per kWh of electrical output. Lower values indicate higher efficiency. Key metric for fossil fuel and nuclear plants.',
    `forecasted_net_generation_mwh` DECIMAL(18,2) COMMENT 'Predicted electrical energy output available for delivery to the grid after subtracting auxiliary load and station service, measured in Megawatt-Hours (MWh). This is the energy available for sale or dispatch.',
    `fuel_consumption_unit` STRING COMMENT 'Unit of measure for forecasted fuel consumption. MCF = Thousand Cubic Feet (natural gas), MMBTU = Million British Thermal Units.. Valid values are `tons|mcf|gallons|mmbtu|kg`',
    `horizon_type` STRING COMMENT 'Classification of the forecast time horizon, indicating how far in advance the forecast is made relative to the operational period. Used for Day-Ahead Market (DAM) vs Real-Time Market (RTM) planning.. Valid values are `real-time|hour-ahead|day-ahead|week-ahead|month-ahead|annual`',
    `market_bid_flag` BOOLEAN COMMENT 'Indicates whether this forecast was used as the basis for a Day-Ahead Market (DAM) or Real-Time Market (RTM) bid submission to the Regional Transmission Organization (RTO) or Independent System Operator (ISO).',
    `model_type` STRING COMMENT 'Classification of the forecasting methodology used (statistical time series, machine learning, physical simulation, hybrid approach, or expert judgment).. Valid values are `statistical|machine-learning|physical|hybrid|expert-judgment`',
    `model_version` STRING COMMENT 'Identifier for the forecasting algorithm or model version used to generate this forecast. Enables traceability and model performance analysis.. Valid values are `^[A-Z0-9_-]{1,50}$`',
    `notes` STRING COMMENT 'Free-text field for additional context, assumptions, or special conditions affecting this forecast (e.g., unusual weather patterns, equipment limitations, regulatory constraints).',
    `period_end` TIMESTAMP COMMENT 'The ending timestamp of the period for which generation output is forecasted. Represents the real-world operational time window end.',
    `period_start` TIMESTAMP COMMENT 'The beginning timestamp of the period for which generation output is forecasted. Represents the real-world operational time window start.',
    `planned_outage_flag` BOOLEAN COMMENT 'Indicates whether a planned maintenance outage is scheduled during the forecast period, impacting available capacity.',
    `rto_iso_code` STRING COMMENT 'Code identifying the RTO or ISO market jurisdiction where this forecast applies and may be submitted for dispatch. [ENUM-REF-CANDIDATE: PJM|MISO|CAISO|ERCOT|NYISO|ISO-NE|SPP — 7 candidates stripped; promote to reference product]',
    `solar_irradiance_w_per_m2` DECIMAL(18,2) COMMENT 'Forecasted solar irradiance in watts per square meter, used for solar photovoltaic generation forecasting.',
    `submitted_by` STRING COMMENT 'Username or identifier of the analyst or system that created and submitted this forecast. Audit trail for accountability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this forecast record was last modified. Tracks revisions and superseding forecasts.',
    `weather_scenario_code` BIGINT COMMENT 'Reference to the weather input scenario or forecast used as input to the generation forecast model. Critical for renewable generation forecasting (solar, wind).',
    `wind_speed_mph` DECIMAL(18,2) COMMENT 'Forecasted wind speed in miles per hour at hub height, used for wind generation forecasting.',
    CONSTRAINT pk_forecast PRIMARY KEY(`forecast_id`)
) COMMENT 'Forward-looking generation output forecasts for each plant or unit across multiple time horizons (day-ahead, week-ahead, monthly, annual). Captures forecast period, forecast horizon type, forecasted gross generation (MWh), forecasted net generation (MWh), forecasted capacity factor, forecast model version, weather input assumptions, and confidence interval. Supports DAM bidding, load forecasting integration, and IRP planning. Distinct from analytics — these are operational planning records used in EMS dispatch.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` (
    `nuclear_fuel_cycle_id` BIGINT COMMENT 'Unique identifier for the nuclear fuel cycle record. Primary key for tracking fuel lifecycle from initial load through burnup to spent fuel storage.',
    `vendor_id` BIGINT COMMENT 'Reference to the nuclear fuel vendor who manufactured and supplied the fuel assemblies for this cycle.',
    `generating_unit_id` BIGINT COMMENT 'Reference to the specific nuclear reactor unit where this fuel cycle is deployed. Links to the generation asset master for the reactor.',
    `generation_outage_id` BIGINT COMMENT 'Reference to the planned refueling outage event during which this fuel cycle was loaded or unloaded. Links to maintenance and outage management systems.',
    `average_discharge_burnup_mwd_mtu` DECIMAL(18,2) COMMENT 'Average burnup of fuel assemblies discharged from the core at the end of this cycle. Key metric for fuel performance and economic optimization.',
    `burnup_level_mwd_mtu` DECIMAL(18,2) COMMENT 'Measure of fuel depletion representing the thermal energy extracted per unit mass of uranium. Higher burnup indicates more efficient fuel utilization. Typical discharge burnup is 40,000-60,000 MWd/MTU.',
    `capacity_factor_percent` DECIMAL(18,2) COMMENT 'Ratio of actual energy generated to maximum possible energy generation during the cycle, expressed as percentage. Industry-leading nuclear units achieve 90%+ capacity factors.',
    `core_thermal_power_mwt` DECIMAL(18,2) COMMENT 'Licensed thermal power rating of the reactor core. Represents the maximum heat generation rate from nuclear fission. Typical values range from 2,000 to 4,000 MWt.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel cycle record was first created in the system. Used for audit trail and data lineage tracking.',
    `cycle_end_date` DATE COMMENT 'Date when the reactor was shut down for refueling outage, ending this fuel cycle. Used to calculate cycle length and capacity factor.',
    `cycle_length_days` STRING COMMENT 'Duration of the fuel cycle from startup to shutdown, measured in days. Typical cycle lengths range from 18 to 24 months. Used for fuel planning and economic analysis.',
    `cycle_number` STRING COMMENT 'Sequential cycle number for the reactor unit. Increments with each refueling outage. Used for lifecycle tracking and performance trending.',
    `cycle_start_date` DATE COMMENT 'Date when the reactor achieved initial criticality and began power operations for this fuel cycle. Marks the beginning of the fuel burnup period.',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the fuel cycle. Planned=future cycle in IRP, Active=currently operating, Completed=cycle ended awaiting final data, Archived=historical record finalized.. Valid values are `planned|active|completed|archived`',
    `data_source_system` STRING COMMENT 'Identifier of the operational system of record that originated this fuel cycle data. Typically OSIsoft PI Historian, SAP PM, or nuclear fuel management system.. Valid values are `^[A-Z0-9_]{2,30}$`',
    `energy_generated_mwh` DECIMAL(18,2) COMMENT 'Total electrical energy generated during this fuel cycle, measured in megawatt-hours. Used for fuel cost allocation and performance analysis.',
    `enrichment_level_percent` DECIMAL(18,2) COMMENT 'Percentage of fissile uranium-235 isotope in the fuel assembly. Typical commercial reactor enrichment ranges from 3% to 5%. Critical for criticality safety and burnup calculations.',
    `fresh_fuel_assembly_count` STRING COMMENT 'Number of new (unirradiated) fuel assemblies loaded during the refueling outage. Typically one-third to one-half of the core is replaced each cycle.',
    `fuel_assembly_batch_number` STRING COMMENT 'Unique batch identifier assigned by the fuel vendor to the fuel assembly group. Used for tracking and regulatory reporting to NRC.. Valid values are `^[A-Z0-9]{6,20}$`',
    `fuel_assembly_count` STRING COMMENT 'Total number of fuel assemblies loaded in the reactor core for this cycle. Typical PWR cores contain 150-200 assemblies; BWR cores contain 600-800 assemblies.',
    `fuel_cost_per_mwh_usd` DECIMAL(18,2) COMMENT 'Unit fuel cost calculated as total fuel cost divided by energy generated during the cycle. Key metric for Levelized Cost of Energy (LCOE) analysis and rate case filings.',
    `fuel_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of nuclear fuel for this cycle including uranium procurement, conversion, enrichment, and fabrication. Capitalized and amortized under FASB ASC 980 for regulated utilities.',
    `fuel_design_code` STRING COMMENT 'Vendor-specific fuel assembly design designation. Examples include Westinghouse 17x17 PERFORMANCE+, GE GE14, or Framatome AFA-3G. Used for technical specifications and licensing.. Valid values are `^[A-Z0-9]{4,15}$`',
    `fuel_type` STRING COMMENT 'Type of nuclear fuel assembly design corresponding to reactor technology. PWR=Pressurized Water Reactor, BWR=Boiling Water Reactor, CANDU=Canadian Deuterium Uranium, AGR=Advanced Gas-cooled Reactor, VVER=Russian PWR variant.. Valid values are `PWR|BWR|CANDU|AGR|VVER`',
    `initial_uranium_load_mtu` DECIMAL(18,2) COMMENT 'Total mass of uranium loaded into the reactor core at the start of the fuel cycle, measured in metric tons of uranium. Used for fuel cost accounting and inventory management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this fuel cycle record. Used for change tracking and data quality monitoring.',
    `nrc_license_number` STRING COMMENT 'NRC operating license number authorizing operation of the reactor unit. Format is NPF (Nuclear Power Facility) or DPR (Demonstration Power Reactor) followed by numeric identifier.. Valid values are `^(NPF|DPR)-[0-9]{1,4}$`',
    `peak_rod_burnup_mwd_mtu` DECIMAL(18,2) COMMENT 'Maximum burnup achieved by any individual fuel rod in the core during this cycle. Must remain below regulatory limits to ensure fuel integrity.',
    `rec_generated_count` STRING COMMENT 'Number of Renewable Energy Certificates generated for this cycle. Some jurisdictions classify nuclear as eligible for REC programs or similar clean energy credits.',
    `regulatory_reporting_period` STRING COMMENT 'Reporting period for NRC and FERC filings associated with this fuel cycle. Format is YYYY-QN for quarterly or YYYY-MM for monthly reporting.. Valid values are `^[0-9]{4}-(Q[1-4]|[0-9]{2})$`',
    `spent_fuel_storage_location` STRING COMMENT 'Physical location identifier for spent fuel storage, either in spent fuel pool or dry cask storage. Format includes pool/cask identifier and position coordinates.. Valid values are `^[A-Z0-9-]{4,30}$`',
    `thermal_efficiency_percent` DECIMAL(18,2) COMMENT 'Ratio of electrical energy output to thermal energy input from nuclear fission, expressed as percentage. Typical nuclear plant thermal efficiency is 33-37%.',
    CONSTRAINT pk_nuclear_fuel_cycle PRIMARY KEY(`nuclear_fuel_cycle_id`)
) COMMENT 'Master records tracking the nuclear fuel lifecycle for each reactor unit including fuel assembly batch ID, enrichment level (% U-235), initial uranium load (MTU), burnup level (MWd/MTU), cycle start/end dates, refueling outage reference, spent fuel storage location, NRC license reference, and fuel vendor. Supports NRC regulatory reporting, nuclear fuel cost accounting under FASB ASC 980, and long-term fuel planning.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` (
    `renewable_resource_id` BIGINT COMMENT 'Unique identifier for the renewable generation resource. Primary key for the renewable resource master record.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Community‑solar or renewable subscription links a renewable resource record to the subscribing customer account for allocation and reporting.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Renewable resources are owned by a specific plant; linking provides plant-level aggregation and removes the siloed status of renewable_resource.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Renewable Incentive Program enrollment tracks each renewable resources participation in state RPS or incentive programs, needed for compliance reporting.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Renewable resource (e.g., solar farm) must be linked to a meter for REC tracking and net‑metering calculations.',
    `interconnection_agreement_id` BIGINT COMMENT 'Foreign key linking to transmission.interconnection_agreement. Business justification: Renewable projects must be linked to their Interconnection Agreement for compliance and market eligibility.',
    `capacity_factor_design_pct` DECIMAL(18,2) COMMENT 'Design or expected capacity factor as a percentage, representing the ratio of actual energy output to theoretical maximum output over a year. Used for Integrated Resource Plan (IRP) modeling and Levelized Cost of Energy (LCOE) analysis. Typical values: solar 15-25%, wind 30-45%, hydro 40-60%.',
    `commercial_operation_date` DATE COMMENT 'Date when the renewable resource achieved commercial operation and began delivering energy under commercial terms. May differ from interconnection date due to testing and commissioning periods. Critical for Power Purchase Agreement (PPA) milestone tracking and Renewable Energy Certificate (REC) eligibility.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this renewable resource record was first created in the system. Used for data lineage and audit trail.',
    `data_source_system` STRING COMMENT 'Name of the source system from which this renewable resource record originated (e.g., Maximo, GIS, PI Historian, Manual Entry). Used for data lineage and integration troubleshooting.',
    `derms_integration_flag` BOOLEAN COMMENT 'Indicates whether the renewable resource is integrated with the utilitys Distributed Energy Resource Management System for real-time monitoring, forecasting, and dispatch control. True if integrated, False otherwise. Supports Virtual Power Plant (VPP) operations and grid flexibility.',
    `eam_asset_number` STRING COMMENT 'Unique identifier linking this renewable resource to its asset record in the Enterprise Asset Management system (Maximo). Used for maintenance planning, work order management, and asset lifecycle tracking.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `estimated_useful_life_years` STRING COMMENT 'Expected operational lifespan of the renewable resource in years, used for depreciation calculations and long-term resource planning. Typical values: solar 25-30 years, wind 20-25 years, hydro 50-100 years.',
    `ferc_account_code` STRING COMMENT 'FERC Uniform System of Accounts code for capitalization and depreciation of this renewable generation asset. Typically 334 (Solar), 335 (Wind), 331-333 (Hydro) depending on resource type.. Valid values are `^[0-9]{3}(.[0-9]{1,2})?$`',
    `gis_asset_reference` STRING COMMENT 'Unique identifier linking this renewable resource to its representation in the utilitys GIS system (Esri ArcGIS). Enables spatial analysis, asset visualization, and integration with transmission and distribution network models.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `hub_height_m` DECIMAL(18,2) COMMENT 'Height of the wind turbine hub above ground level in meters. Critical parameter for wind resource assessment and energy yield modeling. Applicable to wind resources only. Null for solar and hydro.',
    `in_service_date` DATE COMMENT 'Date when the renewable resource was placed into service for accounting and depreciation purposes. May differ from commercial operation date due to accounting policy. Used for fixed asset management and regulatory rate base calculations.',
    `installed_capacity_mw_ac` DECIMAL(18,2) COMMENT 'Nameplate capacity of the renewable resource in megawatts AC (alternating current), representing the maximum continuous electrical output at the point of interconnection. For solar, this is the inverter-limited AC capacity.',
    `installed_capacity_mw_dc` DECIMAL(18,2) COMMENT 'For solar PV resources, the total DC capacity of the solar panels before inversion. Null for non-solar resources. Used to calculate DC-to-AC ratio for solar performance analysis.',
    `interconnection_date` DATE COMMENT 'Date when the renewable resource was first interconnected to the grid and authorized to deliver energy. Used for depreciation schedules, regulatory reporting, and capacity factor analysis.',
    `inverter_manufacturer` STRING COMMENT 'Manufacturer of the inverter equipment for solar PV resources (e.g., SMA, Fronius, SolarEdge). Applicable to solar PV only. Null for wind and hydro.',
    `inverter_model` STRING COMMENT 'Model designation of the inverter equipment for solar PV resources. Applicable to solar PV only. Null for wind and hydro.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the renewable resource location in decimal degrees. Used for GIS mapping, solar irradiance modeling, wind resource assessment, and transmission planning.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the renewable resource location in decimal degrees. Used for GIS mapping, solar irradiance modeling, wind resource assessment, and transmission planning.',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified this renewable resource record. Used for audit trail and data stewardship accountability.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this renewable resource record was last modified. Used for data lineage, change tracking, and audit trail.',
    `nem_eligible_flag` BOOLEAN COMMENT 'Indicates whether the renewable resource is eligible for Net Energy Metering programs, allowing bidirectional energy flow and credit for excess generation. True if eligible, False otherwise. Primarily applicable to distributed solar resources.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the renewable resource. In-service indicates active generation capability, standby indicates ready but not generating, out-of-service indicates temporary unavailability, under construction for assets not yet commissioned, retired for permanently decommissioned, mothballed for long-term suspension.. Valid values are `in_service|standby|out_of_service|under_construction|retired|mothballed`',
    `owner_operator_type` STRING COMMENT 'Classification of ownership and operational responsibility. Utility-owned indicates direct ownership and operation, third-party PPA indicates independent power producer with power purchase agreement, customer-owned NEM indicates behind-the-meter distributed generation, joint venture indicates shared ownership.. Valid values are `utility_owned|third_party_ppa|customer_owned_nem|joint_venture`',
    `panel_model` STRING COMMENT 'Manufacturer and model designation of solar panels installed (e.g., SunPower Maxeon 3-400W). Applicable to solar PV resources only. Null for wind and hydro.',
    `pi_historian_tag_prefix` STRING COMMENT 'Tag prefix used in OSIsoft PI Historian for real-time telemetry data streams from this renewable resource. Enables linkage between master data and operational time-series data for performance monitoring and analytics.. Valid values are `^[A-Z0-9_]{4,20}$`',
    `ppa_contract_number` STRING COMMENT 'Unique identifier for the Power Purchase Agreement governing the sale of energy and/or capacity from this renewable resource. References the contractual terms, pricing structure, and delivery obligations. Confidential business information.. Valid values are `^[A-Z0-9-]{8,20}$`',
    `rec_tracking_system_code` STRING COMMENT 'Unique identifier assigned by the regional REC tracking system (e.g., PJM-GATS, WREGIS, M-RETS) for tracking and trading renewable energy certificates generated by this resource. Used for renewable portfolio standard (RPS) compliance and REC monetization.. Valid values are `^[A-Z0-9-]{10,25}$`',
    `record_active_flag` BOOLEAN COMMENT 'Indicates whether this renewable resource record is currently active in the system. True for active records, False for logically deleted or archived records. Used for soft-delete pattern and historical record retention.',
    `reservoir_capacity_acre_feet` DECIMAL(18,2) COMMENT 'Total storage capacity of the hydro reservoir in acre-feet. Applicable to pumped storage and reservoir-based hydro. Null for run-of-river hydro, solar, and wind.',
    `resource_code` STRING COMMENT 'Externally-known unique business identifier for the renewable resource, used in operational systems and regulatory reporting. Typically follows utility naming convention for generation assets.. Valid values are `^[A-Z0-9]{6,12}$`',
    `resource_name` STRING COMMENT 'Human-readable name of the renewable generation resource (e.g., Sunrise Solar Farm Unit 1, Coastal Wind Turbine 12).',
    `resource_type` STRING COMMENT 'Classification of the renewable generation technology. Solar PV (photovoltaic), solar thermal (concentrating solar power), wind onshore, wind offshore, run-of-river hydro, or pumped storage hydro.. Valid values are `solar_pv|solar_thermal|wind_onshore|wind_offshore|hydro_run_of_river|hydro_pumped_storage`',
    `resource_zone` STRING COMMENT 'Geographic or operational zone designation for the renewable resource, used for resource planning and dispatch optimization. May align with ISO/RTO pricing zones or internal planning regions.',
    `retirement_date` DATE COMMENT 'Date when the renewable resource was permanently retired from service. Null for active resources. Used for asset lifecycle tracking and regulatory reporting.',
    `rotor_diameter_m` DECIMAL(18,2) COMMENT 'Diameter of the wind turbine rotor (blade tip to blade tip) in meters. Determines swept area and energy capture capability. Applicable to wind resources only. Null for solar and hydro.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether the renewable resource is integrated with the utilitys SCADA system for real-time telemetry, monitoring, and control. True if integrated, False otherwise. Supports grid operations and outage management.',
    `turbine_model` STRING COMMENT 'Manufacturer and model designation of wind turbine (e.g., GE 2.5-120, Vestas V150-4.2MW). Applicable to wind resources only. Null for solar and hydro.',
    `water_head_m` DECIMAL(18,2) COMMENT 'Vertical distance (head) between the upstream water level and the turbine in meters. Key parameter for hydro generation capacity and efficiency. Applicable to hydro resources only. Null for solar and wind.',
    CONSTRAINT pk_renewable_resource PRIMARY KEY(`renewable_resource_id`)
) COMMENT 'Master records for renewable generation resource characteristics specific to solar, wind, and hydro units. Captures resource type (solar PV, solar thermal, wind onshore, wind offshore, run-of-river hydro, pumped storage), panel/turbine model, installed capacity (MW-DC/MW-AC for solar), hub height (wind), rotor diameter (wind), water head (hydro), resource zone, interconnection agreement number, NEM eligibility flag, and DERMS integration flag. Supports IRP renewable portfolio planning and REC tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` (
    `capacity_resource_id` BIGINT COMMENT 'Unique identifier for the capacity resource registered in RTO/ISO capacity markets. Primary key.',
    `generating_unit_id` BIGINT COMMENT 'Reference to the physical generating unit that this capacity resource represents.',
    `plant_id` BIGINT COMMENT 'Reference to the generation plant where this capacity resource is located.',
    `accredited_capacity_mw_icap` DECIMAL(18,2) COMMENT 'The installed capacity (ICAP) value in megawatts (MW) accredited by the RTO/ISO, representing the maximum capacity the resource can provide under reference conditions.',
    `accredited_capacity_mw_ucap` DECIMAL(18,2) COMMENT 'The unforced capacity (UCAP) value in megawatts (MW), which is ICAP adjusted for the resources expected forced outage rate (EFORd), representing the expected available capacity.',
    `bonus_amount_usd` DECIMAL(18,2) COMMENT 'The bonus payment amount in USD earned by the resource for exceeding performance requirements during shortage events or peak periods.',
    `capacity_interconnection_rights` STRING COMMENT 'The type of interconnection rights held by this capacity resource: firm (full deliverability), non-firm (energy-only), or conditional (subject to transmission constraints).. Valid values are `firm|non_firm|conditional`',
    `capacity_obligation_mw` DECIMAL(18,2) COMMENT 'The capacity obligation in megawatts (MW) that this resource has committed to provide in the capacity market for the delivery period.',
    `capacity_product_type` STRING COMMENT 'The capacity product type offered by this resource: base capacity, annual capacity, extended summer capacity, or capacity performance (CP) product.. Valid values are `base|annual|extended_summer|cp`',
    `capacity_revenue_forecast_usd` DECIMAL(18,2) COMMENT 'The forecasted capacity revenue in USD for this resource for the current delivery year, used for financial planning and budgeting.',
    `capacity_transfer_rights` STRING COMMENT 'Indicates whether the capacity obligation can be transferred to another resource or market participant.. Valid values are `transferable|non_transferable|restricted`',
    `capacity_zone` STRING COMMENT 'The geographic capacity zone or locational deliverability area (LDA) where this resource is registered for capacity obligations.',
    `cleared_capacity_mw` DECIMAL(18,2) COMMENT 'The capacity in megawatts (MW) that cleared in the most recent capacity auction for this resource.',
    `cleared_capacity_price_usd_per_mw_day` DECIMAL(18,2) COMMENT 'The cleared capacity price in USD per MW-day that this resource received in the capacity auction.',
    `delivery_year` STRING COMMENT 'The delivery year (or planning year) for which this capacity resource is committed, typically in format YYYY/YYYY (e.g., 2024/2025).',
    `effective_date` DATE COMMENT 'The date when this capacity resource registration became effective in the RTO/ISO capacity market.',
    `effective_load_carrying_capability_mw` DECIMAL(18,2) COMMENT 'The effective load carrying capability (ELCC) in megawatts (MW) for renewable and intermittent resources, representing the equivalent firm capacity contribution based on probabilistic reliability analysis.',
    `fuel_type` STRING COMMENT 'The primary fuel type or energy source for this capacity resource. [ENUM-REF-CANDIDATE: coal|natural_gas|nuclear|hydro|wind|solar|oil|biomass|storage — 9 candidates stripped; promote to reference product]',
    `last_performance_assessment_date` DATE COMMENT 'The date of the most recent performance assessment conducted for this capacity resource.',
    `must_offer_obligation` BOOLEAN COMMENT 'Indicates whether this capacity resource has a must-offer obligation requiring it to offer its capacity into the energy market during the delivery period.',
    `net_performance_payment_usd` DECIMAL(18,2) COMMENT 'The net performance payment in USD for the assessment period, calculated as bonuses minus penalties.',
    `next_performance_assessment_date` DATE COMMENT 'The scheduled date for the next performance assessment of this capacity resource.',
    `notes` STRING COMMENT 'Additional notes, comments, or special conditions related to this capacity resource registration, qualification, or performance.',
    `penalty_amount_usd` DECIMAL(18,2) COMMENT 'The penalty amount in USD assessed against the resource for failing to meet capacity obligations during performance assessment intervals.',
    `performance_assessment_interval` STRING COMMENT 'The frequency at which this capacity resources performance is assessed against its capacity obligation.. Valid values are `monthly|quarterly|annual`',
    `performance_score` DECIMAL(18,2) COMMENT 'The performance score (typically 0-100) representing how well the resource met its capacity obligations during performance assessment periods.',
    `qualification_status` STRING COMMENT 'The current qualification status of the capacity resource in the RTO/ISO capacity market.. Valid values are `qualified|pending|disqualified|suspended|retired`',
    `qualification_test_date` DATE COMMENT 'The date when the capacity qualification test was performed to verify the resources capability.',
    `qualification_test_result_mw` DECIMAL(18,2) COMMENT 'The measured capacity output in megawatts (MW) achieved during the qualification test.',
    `qualification_test_status` STRING COMMENT 'The outcome status of the capacity qualification test.. Valid values are `passed|failed|pending|waived`',
    `rec_eligible` BOOLEAN COMMENT 'Indicates whether this capacity resource is eligible to generate Renewable Energy Certificates (RECs) based on its fuel type and certification.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this capacity resource record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this capacity resource record was last updated in the system.',
    `registration_status` STRING COMMENT 'The current registration status of the capacity resource in the RTO/ISO system.. Valid values are `active|inactive|pending|suspended|retired`',
    `resource_name` STRING COMMENT 'The business name or designation of the capacity resource as registered with the RTO/ISO.',
    `resource_type` STRING COMMENT 'The type of capacity resource: generation (traditional power plant), demand response (load reduction), energy efficiency, or storage (battery/pumped hydro).. Valid values are `generation|demand_response|energy_efficiency|storage`',
    `rto_iso_name` STRING COMMENT 'The name of the RTO or ISO where this capacity resource is registered. [ENUM-REF-CANDIDATE: PJM|MISO|NYISO|ISO-NE|CAISO|ERCOT|SPP — 7 candidates stripped; promote to reference product]',
    `rto_iso_registration_number` STRING COMMENT 'The unique registration identifier assigned by the RTO/ISO for this capacity resource in their capacity market system.',
    `seasonal_capacity_flag` BOOLEAN COMMENT 'Indicates whether this is a seasonal capacity resource with availability limited to specific seasons (e.g., summer-only peaking units).',
    `termination_date` DATE COMMENT 'The date when this capacity resource registration was or will be terminated, deactivated, or retired from the capacity market.',
    CONSTRAINT pk_capacity_resource PRIMARY KEY(`capacity_resource_id`)
) COMMENT 'Master records for generating units registered as capacity resources in RTO/ISO capacity markets (PJM RPM, MISO PRA, NYISO ICAP, ISO-NE FCA). Captures capacity zone, accredited capacity (MW-ICAP, MW-UCAP), capacity product type (base capacity, CP), qualification test results, effective load carrying capability (ELCC) for renewables, capacity obligation (MW), performance assessment intervals, bonus/penalty amounts, and associated RTO/ISO registration ID. Distinct from capacity market bidding (owned by trading domain) — this product tracks the physical units qualification and accreditation status only. Supports capacity revenue forecasting and FERC market compliance.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` (
    `startup_shutdown_event_id` BIGINT COMMENT 'Unique identifier for the startup or shutdown event record.',
    `ems_dispatch_instruction_id` BIGINT COMMENT 'Reference to the dispatch instruction associated with the event.',
    `generating_unit_id` BIGINT COMMENT 'Identifier of the generating unit that experienced the startup or shutdown.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Startup/shutdown logs capture the technician who initiated the event, essential for cost allocation and incident analysis.',
    `plant_id` BIGINT COMMENT 'Identifier of the plant where the generating unit is located.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Enables correlation of startup/shutdown events with SCADA logs for incident analysis and regulatory reporting.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Event Impact Analysis tracks environmental emissions and cost per site; the link allows aggregation of startup/shutdown metrics for regulatory reporting.',
    `preceding_startup_shutdown_event_id` BIGINT COMMENT 'Self-referencing FK on startup_shutdown_event (preceding_startup_shutdown_event_id)',
    `cost_center_code` STRING COMMENT 'Internal cost center responsible for the startup/shutdown expense.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|EUR|CAD|GBP|JPY|AUD`',
    `duration_minutes` STRING COMMENT 'Total duration of the event in minutes, calculated from start and end timestamps.',
    `emission_factor_code` STRING COMMENT 'Code of the emission factor methodology applied to calculate emissions for this event.',
    `emissions_co2_tons` DECIMAL(18,2) COMMENT 'Carbon dioxide emissions generated during the startup or shutdown event.',
    `emissions_nox_tons` DECIMAL(18,2) COMMENT 'Nitrogen oxides emissions generated during the event.',
    `emissions_so2_tons` DECIMAL(18,2) COMMENT 'Sulfur dioxide emissions generated during the event.',
    `end_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the unit completed the startup or shutdown process.',
    `event_reference_code` STRING COMMENT 'Business identifier code assigned to the event for external tracking and reporting.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary event occurrence (typically the start of the startup or shutdown).',
    `event_type` STRING COMMENT 'Classification of the event (e.g., hot start, cold start, normal shutdown, emergency trip).. Valid values are `hot_start|warm_start|cold_start|normal_shutdown|emergency_trip`',
    `fuel_consumed_mmbtu` DECIMAL(18,2) COMMENT 'Amount of fuel used during the startup, measured in million British thermal units.',
    `fuel_type` STRING COMMENT 'Primary fuel used during the startup (e.g., coal, natural gas, oil).',
    `initiating_cause` STRING COMMENT 'Primary cause that triggered the startup or shutdown.. Valid values are `operator|automatic|fault|weather|maintenance|other`',
    `is_emergency` BOOLEAN COMMENT 'Flag indicating whether the event was an emergency shutdown or startup.',
    `is_estimated` BOOLEAN COMMENT 'Indicates whether any numeric values (fuel, emissions, cost) are estimated rather than measured.',
    `is_reportable_to_ferc` BOOLEAN COMMENT 'Indicates if the event must be reported to the Federal Energy Regulatory Commission.',
    `net_startup_cost_usd` DECIMAL(18,2) COMMENT 'Net cost after adjustments, representing the final amount charged for the startup.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or observations about the event.',
    `ramp_rate_mw_per_min` DECIMAL(18,2) COMMENT 'Maximum ramp rate achieved during the startup, expressed in megawatts per minute.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was first created in the system.',
    `record_source_system` STRING COMMENT 'System of record that supplied the event data.. Valid values are `OSIsoft_PI|GE_PowerOn|SAP_ERP|Oracle_CC&B|Maximo|Allegro`',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the event record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Flag indicating inclusion of this event in regulatory reporting packages.',
    `reporting_period` DATE COMMENT 'Month (first day) for which the event is reported to regulators.',
    `start_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the unit began the startup or shutdown process.',
    `startup_cost_adjustment_usd` DECIMAL(18,2) COMMENT 'Any adjustments (credits or penalties) applied to the base startup cost.',
    `startup_cost_usd` DECIMAL(18,2) COMMENT 'Direct cost incurred for the unit startup, expressed in US dollars.',
    `startup_shutdown_event_status` STRING COMMENT 'Current lifecycle status of the startup/shutdown event.. Valid values are `planned|in_progress|completed|cancelled|failed`',
    `startup_time_hours` DECIMAL(18,2) COMMENT 'Total time taken for the unit to reach full load from start of startup.',
    `unit_status_after` STRING COMMENT 'Operational status of the unit immediately after the event.. Valid values are `offline|starting|online|shutting_down|maintenance|emergency`',
    `unit_status_before` STRING COMMENT 'Operational status of the unit immediately before the event.. Valid values are `offline|starting|online|shutting_down|maintenance|emergency`',
    CONSTRAINT pk_startup_shutdown_event PRIMARY KEY(`startup_shutdown_event_id`)
) COMMENT 'Transactional records for each generating unit startup and shutdown event capturing event type (hot start, warm start, cold start, normal shutdown, emergency trip), initiating cause, start/end timestamps, fuel consumed during startup (MMBtu), startup cost ($), ramp rate achieved (MW/min), emissions during startup, associated dispatch instruction reference, and unit status transitions. Supports startup cost allocation for LCOE, emissions reporting during non-steady-state operation, and unit commitment optimization. Critical for FERC Form 1 O&M cost allocation and EPA startup/shutdown exemption tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`allocation` (
    `allocation_id` BIGINT COMMENT 'Primary key for the generation_allocation association',
    `ppa_contract_id` BIGINT COMMENT 'Identifier of the contract governing the allocation',
    `metering_service_point_id` BIGINT COMMENT 'Foreign key linking to the metering service point',
    `plant_id` BIGINT COMMENT 'Foreign key linking to the generation plant',
    `end_date` DATE COMMENT 'Date when the allocation ends or is superseded',
    `percent` DECIMAL(18,2) COMMENT 'Percentage of the plants output allocated to the service point',
    `start_date` DATE COMMENT 'Date when the allocation becomes effective',
    CONSTRAINT pk_allocation PRIMARY KEY(`allocation_id`)
) COMMENT 'Represents the contractual allocation of electricity generation capacity from a plant to a metering service point. Each record captures the percentage of output allocated, the governing contract, and the effective start and end dates of the allocation.. Existence Justification: A generation plant can allocate portions of its output to multiple service points, and a service point can receive electricity from multiple plants. These allocations are managed through contracts that record allocation percentages, contract identifiers, and effective dates. The relationship is actively created, updated, and deleted by business users as part of the power distribution planning process.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`generation`.`audit_plant_assignment` (
    `audit_plant_assignment_id` BIGINT COMMENT 'Primary key for the audit_plant_assignment association',
    `plant_id` BIGINT COMMENT 'Foreign key linking to the generation plant',
    `safety_audit_id` BIGINT COMMENT 'Foreign key linking to the safety audit',
    CONSTRAINT pk_audit_plant_assignment PRIMARY KEY(`audit_plant_assignment_id`)
) COMMENT 'Represents the assignment of a safety audit to a generation plant. Each record links one plant to one safety audit and captures the audits timing, type, and status as they apply to that specific plant.. Existence Justification: Safety audits in the utility can be conducted across multiple generation plants, and each plant may be subject to many audits over its lifecycle. The audit process is managed as a distinct activity that references the plants it covers, and the relationship is actively created and maintained by safety teams.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ADD CONSTRAINT `fk_generation_energy_output_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ADD CONSTRAINT `fk_generation_energy_output_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ADD CONSTRAINT `fk_generation_unit_availability_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ADD CONSTRAINT `fk_generation_unit_availability_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ADD CONSTRAINT `fk_generation_generation_outage_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ADD CONSTRAINT `fk_generation_generation_outage_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ADD CONSTRAINT `fk_generation_emissions_record_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ADD CONSTRAINT `fk_generation_emissions_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ADD CONSTRAINT `fk_generation_rec_certificate_energy_output_id` FOREIGN KEY (`energy_output_id`) REFERENCES `power_and_utilities_v2`.`generation`.`energy_output`(`energy_output_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ADD CONSTRAINT `fk_generation_rec_certificate_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ADD CONSTRAINT `fk_generation_rec_certificate_generation_record_energy_output_id` FOREIGN KEY (`generation_record_energy_output_id`) REFERENCES `power_and_utilities_v2`.`generation`.`energy_output`(`energy_output_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ADD CONSTRAINT `fk_generation_rec_certificate_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ADD CONSTRAINT `fk_generation_ppa_delivery_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ADD CONSTRAINT `fk_generation_ppa_delivery_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ADD CONSTRAINT `fk_generation_forecast_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ADD CONSTRAINT `fk_generation_forecast_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ADD CONSTRAINT `fk_generation_nuclear_fuel_cycle_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ADD CONSTRAINT `fk_generation_nuclear_fuel_cycle_generation_outage_id` FOREIGN KEY (`generation_outage_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generation_outage`(`generation_outage_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ADD CONSTRAINT `fk_generation_renewable_resource_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ADD CONSTRAINT `fk_generation_capacity_resource_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ADD CONSTRAINT `fk_generation_capacity_resource_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ADD CONSTRAINT `fk_generation_startup_shutdown_event_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities_v2`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ADD CONSTRAINT `fk_generation_startup_shutdown_event_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ADD CONSTRAINT `fk_generation_startup_shutdown_event_preceding_startup_shutdown_event_id` FOREIGN KEY (`preceding_startup_shutdown_event_id`) REFERENCES `power_and_utilities_v2`.`generation`.`startup_shutdown_event`(`startup_shutdown_event_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` ADD CONSTRAINT `fk_generation_allocation_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities_v2`.`generation`.`audit_plant_assignment` ADD CONSTRAINT `fk_generation_audit_plant_assignment_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities_v2`.`generation`.`plant`(`plant_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`generation` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities_v2`.`generation` SET TAGS ('dbx_domain' = 'generation');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` SET TAGS ('dbx_subdomain' = 'plant_management');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Manager Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `actual_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Retirement Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `balancing_authority` SET TAGS ('dbx_business_glossary_term' = 'Balancing Authority');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `book_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Book Value United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `book_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor Percent');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `cogeneration_flag` SET TAGS ('dbx_business_glossary_term' = 'Cogeneration Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `commercial_operation_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Operation Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `construction_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Construction Cost United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `construction_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `cooling_system_type` SET TAGS ('dbx_business_glossary_term' = 'Cooling System Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `cooling_system_type` SET TAGS ('dbx_value_regex' = 'once_through|recirculating|dry_cooling|hybrid|none');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `eia_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Energy Information Administration (EIA) Plant Identifier');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `eia_plant_code` SET TAGS ('dbx_value_regex' = '^[0-9]{1,6}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `emergency_contact_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `emissions_controlled_flag` SET TAGS ('dbx_business_glossary_term' = 'Emissions Controlled Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `ferc_license_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) License Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `ferc_license_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `fuel_category` SET TAGS ('dbx_business_glossary_term' = 'Fuel Category');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `heat_rate_btu_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate British Thermal Units (BTU) per Kilowatt-Hour (kWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `installed_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Installed Capacity Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `interconnection_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Voltage Kilovolts (kV)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `iso_rto_market` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) or Regional Transmission Organization (RTO) Market');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Plant Manager Name');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `nerc_plant_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Plant Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `nerc_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `net_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Net Capacity Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `number_of_units` SET TAGS ('dbx_business_glossary_term' = 'Number of Generation Units');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|standby|mothballed|retired|under_construction|planned');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'wholly_owned|joint_venture|contracted|leased|ppa');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Plant Phone Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `planned_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Retirement Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `plant_name` SET TAGS ('dbx_business_glossary_term' = 'Plant Name');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_business_glossary_term' = 'Plant Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `plant_type` SET TAGS ('dbx_value_regex' = 'fossil_fuel|nuclear|renewable|hybrid');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `primary_technology` SET TAGS ('dbx_business_glossary_term' = 'Primary Generation Technology');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `renewable_energy_certificate_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `scada_system_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) System Tag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `transmission_owner` SET TAGS ('dbx_business_glossary_term' = 'Transmission Owner');
ALTER TABLE `power_and_utilities_v2`.`generation`.`plant` ALTER COLUMN `water_source` SET TAGS ('dbx_business_glossary_term' = 'Water Source');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` SET TAGS ('dbx_subdomain' = 'plant_management');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `bus_id` SET TAGS ('dbx_business_glossary_term' = 'Bus Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `ot_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ot Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `ancillary_services_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Qualified Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `asset_book_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Asset Book Value in United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `asset_book_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `balancing_authority` SET TAGS ('dbx_business_glossary_term' = 'Balancing Authority');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `capacity_factor_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Capacity Factor Percentage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `capacity_market_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Market Participation Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `carbon_capture_equipped_flag` SET TAGS ('dbx_business_glossary_term' = 'Carbon Capture Equipped Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `cooling_system_type` SET TAGS ('dbx_business_glossary_term' = 'Cooling System Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `cooling_system_type` SET TAGS ('dbx_value_regex' = 'once_through|recirculating|dry_cooling|hybrid|none');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `eia_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Energy Information Administration (EIA) Unit Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `emissions_control_equipment` SET TAGS ('dbx_business_glossary_term' = 'Emissions Control Equipment');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `energy_storage_capacity_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Storage Capacity in Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `fuel_type_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Fuel Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `fuel_type_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Fuel Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `heat_rate_btu_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate in British Thermal Units per Kilowatt-Hour (BTU/kWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `interconnection_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Voltage in Kilovolts (kV)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `last_major_overhaul_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Overhaul Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Equipment Manufacturer');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `minimum_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stable Load in Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `must_run_designation_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Run Designation Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `nameplate_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity in Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `nerc_unit_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Unit Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `next_scheduled_outage_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Outage Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `pi_historian_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'OSIsoft PI Historian Tag Prefix');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `planned_uprate_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Planned Uprate Capacity in Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `planned_uprate_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Capacity Uprate Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `prime_mover_type` SET TAGS ('dbx_business_glossary_term' = 'Prime Mover Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `ramp_rate_mw_per_min` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate in Megawatts per Minute (MW/min)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `regulatory_asset_base_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base (RAB) Inclusion Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `renewable_energy_certificate_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Unit Retirement Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) Region');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `startup_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Startup Time in Hours');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `summer_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Summer Net Capacity in Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `synchronization_date` SET TAGS ('dbx_business_glossary_term' = 'Grid Synchronization Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Generation Technology Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Name');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Operational Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_value_regex' = 'operating|standby|mothballed|retired|under_construction|planned');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `water_source` SET TAGS ('dbx_business_glossary_term' = 'Water Source');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generating_unit` ALTER COLUMN `winter_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Winter Net Capacity in Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` SET TAGS ('dbx_subdomain' = 'generation_operations');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `energy_output_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Output ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `bill_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Line Item Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `ems_dispatch_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Instruction ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `rate_schedule_version_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Version Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Celsius)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `auxiliary_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Consumption (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor (Percent)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `curtailment_flag` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `curtailment_reason` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Reason');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `curtailment_reason` SET TAGS ('dbx_value_regex' = 'transmission_constraint|economic|renewable_integration|frequency_regulation|voltage_support|none');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|suspect|bad|estimated|manual|calculated');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `emissions_co2_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Emissions (Tons)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Frequency (Hz)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `gross_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Gross Generation (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `interval_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `interval_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `is_renewable` SET TAGS ('dbx_business_glossary_term' = 'Is Renewable Energy');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `lmp_energy_price` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) - Energy Component');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|bilateral|self_scheduled');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `nameplate_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `net_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Net Generation (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `output_variance_mw` SET TAGS ('dbx_business_glossary_term' = 'Output Variance (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `pi_point_tag` SET TAGS ('dbx_business_glossary_term' = 'PI Point ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `pi_tag_name` SET TAGS ('dbx_business_glossary_term' = 'PI Tag Name');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `power_factor` SET TAGS ('dbx_business_glossary_term' = 'Power Factor');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `reactive_power_mvar` SET TAGS ('dbx_business_glossary_term' = 'Reactive Power (MVAr)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `rec_eligible` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Eligible');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `rto_iso_code` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `scheduled_output_mw` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Output (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `settlement_point_name` SET TAGS ('dbx_business_glossary_term' = 'Settlement Point Name');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Unit Operational Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`energy_output` ALTER COLUMN `voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` SET TAGS ('dbx_subdomain' = 'market_compliance');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Delivery ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `supplier_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Supplier ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Supplier ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `ash_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Ash Content Percentage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `consumption_date` SET TAGS ('dbx_business_glossary_term' = 'Consumption Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `consumption_status` SET TAGS ('dbx_business_glossary_term' = 'Consumption Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `consumption_status` SET TAGS ('dbx_value_regex' = 'actual|estimated|adjusted|preliminary');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `eia_generator_code` SET TAGS ('dbx_business_glossary_term' = 'Energy Information Administration (EIA) Generator ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `eia_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Energy Information Administration (EIA) Plant Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `eia_reporting_month` SET TAGS ('dbx_business_glossary_term' = 'Energy Information Administration (EIA) Reporting Month');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `emissions_co2_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Emissions (Tons)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `emissions_nox_tons` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Oxides (NOx) Emissions (Tons)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `emissions_particulate_tons` SET TAGS ('dbx_business_glossary_term' = 'Particulate Matter Emissions (Tons)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `emissions_so2_tons` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Dioxide (SO2) Emissions (Tons)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `energy_output_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Output (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_cost_per_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost Per MMBtu (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_cost_per_mmbtu` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost Per Unit (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_origin_state` SET TAGS ('dbx_business_glossary_term' = 'Fuel Origin State');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_subtype` SET TAGS ('dbx_business_glossary_term' = 'Fuel Subtype');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'coal|natural_gas|nuclear|diesel|fuel_oil|biomass');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `heat_content_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Heat Content Per Unit (BTU per Unit)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `heat_rate` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate (BTU per kWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `inventory_adjustment_flag` SET TAGS ('dbx_business_glossary_term' = 'Inventory Adjustment Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `meter_reading_source` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Source');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percentage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `nerc_region` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Region');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `quantity_consumed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Consumed');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'tons|mcf|mmbtu|gallons|barrels|kg');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `total_fuel_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Fuel Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `total_fuel_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `total_heat_input_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Total Heat Input (MMBtu)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `power_and_utilities_v2`.`generation`.`fuel_consumption` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'rail|truck|pipeline|barge|ship');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` SET TAGS ('dbx_subdomain' = 'generation_operations');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `unit_availability_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Availability ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Outage Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `ambient_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Fahrenheit)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `availability_date` SET TAGS ('dbx_business_glossary_term' = 'Availability Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `availability_hour` SET TAGS ('dbx_business_glossary_term' = 'Availability Hour');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|unavailable|derated|reserve_shutdown|seasonal');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `available_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity (MW - Megawatt)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor Percent');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'verified|estimated|suspect|missing');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `derated_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Derated Capacity (MW - Megawatt)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `derating_flag` SET TAGS ('dbx_business_glossary_term' = 'Derating Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `environmental_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Constraint Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `equivalent_availability_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Availability Factor (EAF) Percent');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `equivalent_forced_outage_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Forced Outage Rate (EFOR) Percent');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `event_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Event Duration Hours');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `forced_outage_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Forced Outage Capacity (MW - Megawatt)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `forced_outage_flag` SET TAGS ('dbx_business_glossary_term' = 'Forced Outage Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `fuel_availability_status` SET TAGS ('dbx_business_glossary_term' = 'Fuel Availability Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `fuel_availability_status` SET TAGS ('dbx_value_regex' = 'adequate|limited|critical|unavailable');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `gads_event_code` SET TAGS ('dbx_business_glossary_term' = 'GADS (Generating Availability Data System) Event Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `maintenance_outage_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Outage Capacity (MW - Megawatt)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `nameplate_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity (MW - Megawatt)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `net_dependable_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Net Dependable Capacity (MW - Megawatt)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `operator_notes` SET TAGS ('dbx_business_glossary_term' = 'Operator Notes');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `outage_cause_code` SET TAGS ('dbx_business_glossary_term' = 'Outage Cause Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `outage_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Outage Cause Description');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `planned_outage_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Capacity (MW - Megawatt)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `planned_outage_flag` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `record_created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `record_updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `responsible_system` SET TAGS ('dbx_business_glossary_term' = 'Responsible System');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `responsible_system` SET TAGS ('dbx_value_regex' = 'ems|scada|pi_historian|manual_entry|dms|oms');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `seasonal_derating_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Derating Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `transmission_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Transmission Constraint Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`unit_availability` ALTER COLUMN `unavailable_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Unavailable Capacity (MW - Megawatt)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` SET TAGS ('dbx_subdomain' = 'generation_operations');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `generation_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Outage ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Outage Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `affected_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Affected Capacity Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `available_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `cause_category` SET TAGS ('dbx_business_glossary_term' = 'Cause Category');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `component_failed` SET TAGS ('dbx_business_glossary_term' = 'Component Failed');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `corrective_action` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Data Source');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `derating_percentage` SET TAGS ('dbx_business_glossary_term' = 'Derating Percentage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration Hours');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `energy_not_produced_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Not Produced Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `equivalent_availability_factor` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Availability Factor (EAF)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `estimated_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `forced_outage_rate` SET TAGS ('dbx_business_glossary_term' = 'Forced Outage Rate (FOR)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `is_derating_event` SET TAGS ('dbx_business_glossary_term' = 'Is Derating Event');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `is_reportable_to_nerc` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable to North American Electric Reliability Corporation (NERC)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `nerc_cause_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Cause Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `nerc_event_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Event Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `outage_description` SET TAGS ('dbx_business_glossary_term' = 'Outage Description');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `outage_status` SET TAGS ('dbx_business_glossary_term' = 'Outage Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `outage_status` SET TAGS ('dbx_value_regex' = 'active|completed|cancelled|pending');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_business_glossary_term' = 'Outage Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_value_regex' = 'planned|forced|maintenance|derating');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `planned_outage_factor` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Factor (POF)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `replacement_power_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Replacement Power Cost United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `replacement_power_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `return_to_service_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return to Service Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `scheduled_return_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Return Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `service_factor` SET TAGS ('dbx_business_glossary_term' = 'Service Factor');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `unavailable_capacity_forced_mw` SET TAGS ('dbx_business_glossary_term' = 'Unavailable Capacity Forced Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `unavailable_capacity_maintenance_mw` SET TAGS ('dbx_business_glossary_term' = 'Unavailable Capacity Maintenance Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`generation_outage` ALTER COLUMN `unavailable_capacity_planned_mw` SET TAGS ('dbx_business_glossary_term' = 'Unavailable Capacity Planned Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` SET TAGS ('dbx_subdomain' = 'market_compliance');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `emissions_record_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Record ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Air Quality Permit ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `cems_monitor_code` SET TAGS ('dbx_business_glossary_term' = 'Continuous Emissions Monitoring System (CEMS) Monitor ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Data Certification Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `certification_status` SET TAGS ('dbx_business_glossary_term' = 'Data Certification Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `certification_status` SET TAGS ('dbx_value_regex' = 'certified|pending_certification|rejected|recertification_required');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `certified_by` SET TAGS ('dbx_business_glossary_term' = 'Certified By Name');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `co2_emissions_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Emissions in Tons');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `co2_rate_per_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Emissions Rate per MMBtu');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `co2_rate_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Emissions Rate per MWh');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `co2e_emissions_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide Equivalent (CO2e) Emissions in Tons');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Emissions Record Comments');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Emissions Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempt');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `control_equipment_status` SET TAGS ('dbx_business_glossary_term' = 'Emissions Control Equipment Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `control_equipment_status` SET TAGS ('dbx_value_regex' = 'operational|degraded|offline|maintenance');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Indicator');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `data_quality_indicator` SET TAGS ('dbx_value_regex' = 'valid|substitute|missing|estimated');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `emissions_record_number` SET TAGS ('dbx_business_glossary_term' = 'Emissions Record Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Exceedance Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `exceedance_reason` SET TAGS ('dbx_business_glossary_term' = 'Permit Exceedance Reason');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `gross_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Gross Generation in Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `heat_input_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Heat Input in Million British Thermal Units (MMBtu)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `mercury_emissions_lbs` SET TAGS ('dbx_business_glossary_term' = 'Mercury (Hg) Emissions in Pounds');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_business_glossary_term' = 'Emissions Monitoring Method');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `monitoring_method` SET TAGS ('dbx_value_regex' = 'CEMS|PEMS|fuel_sampling|mass_balance|engineering_calculation');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `nox_emissions_tons` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Oxides (NOx) Emissions in Tons');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `nox_rate_per_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Oxides (NOx) Emissions Rate per MMBtu');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `particulate_matter_emissions_lbs` SET TAGS ('dbx_business_glossary_term' = 'Particulate Matter (PM) Emissions in Pounds');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `permit_limit_nox_tons` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit for Nitrogen Oxides (NOx) in Tons');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `permit_limit_so2_tons` SET TAGS ('dbx_business_glossary_term' = 'Permit Limit for Sulfur Dioxide (SO2) in Tons');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `reporting_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Reporting Jurisdiction');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `so2_emissions_tons` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Dioxide (SO2) Emissions in Tons');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `so2_rate_per_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Dioxide (SO2) Emissions Rate per MMBtu');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `power_and_utilities_v2`.`generation`.`emissions_record` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Submission Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` SET TAGS ('dbx_subdomain' = 'market_compliance');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `rec_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Renewable Energy Certificate (REC) Certificate ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `bill_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Line Item Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `energy_output_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Record ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Facility ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `generation_record_energy_output_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Record ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Meter ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Facility ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Contract ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Certificate Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `certificate_status` SET TAGS ('dbx_value_regex' = 'issued|active|retired|transferred|expired|cancelled');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `compliance_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Compliance Jurisdiction');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Compliance Year');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Name');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `counterparty_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `eligibility_flags` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Eligibility Flags');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `energy_output_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Output Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `facility_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Facility Nameplate Capacity Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `facility_commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Facility Commissioning Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `facility_location_country` SET TAGS ('dbx_business_glossary_term' = 'Facility Location Country');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `facility_location_country` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `facility_location_state` SET TAGS ('dbx_business_glossary_term' = 'Facility Location State');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `fuel_source` SET TAGS ('dbx_business_glossary_term' = 'Renewable Fuel Source');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `fuel_source` SET TAGS ('dbx_value_regex' = 'solar|wind|hydro|biomass|geothermal|landfill_gas');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `fuel_source_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Renewable Fuel Source Subcategory');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `generation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Generation Period End Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `generation_month` SET TAGS ('dbx_business_glossary_term' = 'Generation Month');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `generation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Generation Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `generation_year` SET TAGS ('dbx_business_glossary_term' = 'Generation Year');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issuance Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `market_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Market Value United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `market_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Certificate Notes');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `rec_quantity` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Quantity');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `rec_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Serial Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `rec_serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,30}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `retirement_account` SET TAGS ('dbx_business_glossary_term' = 'Retirement Account');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `retirement_account` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Retirement Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `retirement_purpose` SET TAGS ('dbx_business_glossary_term' = 'Retirement Purpose');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `retirement_purpose` SET TAGS ('dbx_value_regex' = 'rps_compliance|voluntary_green_power|carbon_offset|corporate_sustainability|utility_green_tariff|not_retired');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `tracking_system` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Tracking System');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `tracking_system_account_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking System Account ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `tracking_system_account_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `transaction_price_usd` SET TAGS ('dbx_business_glossary_term' = 'Transaction Price United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `transaction_price_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `transfer_recipient_account` SET TAGS ('dbx_business_glossary_term' = 'Transfer Recipient Account');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `transfer_recipient_account` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By User');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|verified|rejected|under_review');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Vintage Year');
ALTER TABLE `power_and_utilities_v2`.`generation`.`rec_certificate` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` SET TAGS ('dbx_subdomain' = 'market_compliance');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `ppa_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Delivery ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Authority ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `balancing_authority_balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Authority ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `bill_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `ems_dispatch_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Instruction ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Unit ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Facility ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Facility ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Contract ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `actual_delivery_mwh` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `ancillary_services_amount` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Amount');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `ancillary_services_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `capacity_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Capacity Payment Amount');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `capacity_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `contracted_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Contracted Price per Megawatt-Hour (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `contracted_price_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `curtailment_mwh` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `curtailment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Reason Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `curtailment_reason_code` SET TAGS ('dbx_value_regex' = 'grid_congestion|economic_dispatch|forced_outage|planned_maintenance|renewable_variability|buyer_request');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `curtailment_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Reason Description');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `delivery_period_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `delivery_period_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `delivery_point_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'scheduled|delivered|partially_delivered|curtailed|settled|disputed');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `delivery_transaction_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Transaction Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `delivery_transaction_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `energy_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Energy Payment Amount');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `energy_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `force_majeure_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `invoice_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|bilateral|forward');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `meter_reading_source` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Source');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `meter_reading_source` SET TAGS ('dbx_value_regex' = 'scada|revenue_meter|estimated|settlement_system');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `price_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Adjustment Amount');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `price_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `rec_quantity` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Quantity');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `rec_transfer_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Transfer Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `reconciliation_status` SET TAGS ('dbx_value_regex' = 'pending|reconciled|variance_accepted|under_review');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `scheduled_delivery_mwh` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `scheduling_coordinator` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Coordinator');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `settlement_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Settlement Price per Megawatt-Hour (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `settlement_price_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'allegro_etrm|pi_historian|mdm|settlement_system');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `time_of_use_period` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Period');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `time_of_use_period` SET TAGS ('dbx_value_regex' = 'on_peak|off_peak|shoulder|super_peak');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `total_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Payment Amount');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `total_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `transmission_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Transmission Charge Amount');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `transmission_charge_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`ppa_delivery` ALTER COLUMN `variance_mwh` SET TAGS ('dbx_business_glossary_term' = 'Variance Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` SET TAGS ('dbx_subdomain' = 'generation_operations');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecast_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Forecast Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Unit Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `ambient_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature Fahrenheit');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approved By User');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Approved Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `confidence_interval_lower_mwh` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `confidence_interval_upper_mwh` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Confidence Level Percentage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `error_mwh` SET TAGS ('dbx_business_glossary_term' = 'Forecast Error Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `error_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecast Error Percentage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forced_outage_probability` SET TAGS ('dbx_business_glossary_term' = 'Forced Outage Probability');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_business_glossary_term' = 'Forecast Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecast_number` SET TAGS ('dbx_value_regex' = '^GF-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_business_glossary_term' = 'Forecast Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecast_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|superseded|cancelled|active');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecasted_capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Capacity Factor Percentage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecasted_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Capacity Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecasted_emissions_co2_tons` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Carbon Dioxide (CO2) Emissions Tons');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecasted_emissions_nox_lbs` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Nitrogen Oxides (NOx) Emissions Pounds');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecasted_emissions_so2_lbs` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Sulfur Dioxide (SO2) Emissions Pounds');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecasted_fuel_consumption` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Fuel Consumption');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecasted_gross_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Gross Generation Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecasted_heat_rate_btu_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Heat Rate British Thermal Units (BTU) Per Kilowatt-Hour (kWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `forecasted_net_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Forecasted Net Generation Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `fuel_consumption_unit` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `fuel_consumption_unit` SET TAGS ('dbx_value_regex' = 'tons|mcf|gallons|mmbtu|kg');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `horizon_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Horizon Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `horizon_type` SET TAGS ('dbx_value_regex' = 'real-time|hour-ahead|day-ahead|week-ahead|month-ahead|annual');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `market_bid_flag` SET TAGS ('dbx_business_glossary_term' = 'Market Bid Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'statistical|machine-learning|physical|hybrid|expert-judgment');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `model_version` SET TAGS ('dbx_business_glossary_term' = 'Forecast Model Version');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `model_version` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{1,50}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Forecast Notes');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Forecast Period Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `planned_outage_flag` SET TAGS ('dbx_business_glossary_term' = 'Planned Outage Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `rto_iso_code` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `solar_irradiance_w_per_m2` SET TAGS ('dbx_business_glossary_term' = 'Solar Irradiance Watts Per Square Meter');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `submitted_by` SET TAGS ('dbx_business_glossary_term' = 'Forecast Submitted By User');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Forecast Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `weather_scenario_code` SET TAGS ('dbx_business_glossary_term' = 'Weather Scenario Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`forecast` ALTER COLUMN `wind_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed Miles Per Hour (MPH)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` SET TAGS ('dbx_subdomain' = 'plant_management');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `nuclear_fuel_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Nuclear Fuel Cycle Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Vendor Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Reactor Unit Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `generation_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Refueling Outage Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `average_discharge_burnup_mwd_mtu` SET TAGS ('dbx_business_glossary_term' = 'Average Discharge Burnup in Megawatt-Days per Metric Ton Uranium (MWd/MTU)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `burnup_level_mwd_mtu` SET TAGS ('dbx_business_glossary_term' = 'Burnup Level in Megawatt-Days per Metric Ton Uranium (MWd/MTU)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor Percentage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `core_thermal_power_mwt` SET TAGS ('dbx_business_glossary_term' = 'Core Thermal Power in Megawatts Thermal (MWt)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `cycle_end_date` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cycle End Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `cycle_length_days` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cycle Length in Days');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `cycle_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cycle Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `cycle_start_date` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cycle Start Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cycle Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|archived');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,30}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `energy_generated_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Generated in Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `enrichment_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Uranium-235 (U-235) Enrichment Level Percentage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `fresh_fuel_assembly_count` SET TAGS ('dbx_business_glossary_term' = 'Fresh Fuel Assembly Count');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `fuel_assembly_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Assembly Batch Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `fuel_assembly_batch_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `fuel_assembly_count` SET TAGS ('dbx_business_glossary_term' = 'Fuel Assembly Count');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `fuel_cost_per_mwh_usd` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost per Megawatt-Hour (MWh) in United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `fuel_cost_per_mwh_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `fuel_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost in United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `fuel_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `fuel_design_code` SET TAGS ('dbx_business_glossary_term' = 'Fuel Design Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `fuel_design_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,15}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Nuclear Fuel Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'PWR|BWR|CANDU|AGR|VVER');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `initial_uranium_load_mtu` SET TAGS ('dbx_business_glossary_term' = 'Initial Uranium Load in Metric Tons Uranium (MTU)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `nrc_license_number` SET TAGS ('dbx_business_glossary_term' = 'Nuclear Regulatory Commission (NRC) License Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `nrc_license_number` SET TAGS ('dbx_value_regex' = '^(NPF|DPR)-[0-9]{1,4}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `peak_rod_burnup_mwd_mtu` SET TAGS ('dbx_business_glossary_term' = 'Peak Rod Burnup in Megawatt-Days per Metric Ton Uranium (MWd/MTU)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `rec_generated_count` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Generated Count');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `regulatory_reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Period');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `regulatory_reporting_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(Q[1-4]|[0-9]{2})$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `spent_fuel_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Spent Fuel Storage Location');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `spent_fuel_storage_location` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{4,30}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`nuclear_fuel_cycle` ALTER COLUMN `thermal_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Thermal Efficiency Percentage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` SET TAGS ('dbx_subdomain' = 'plant_management');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `renewable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Resource ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `interconnection_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Interconnection Agreement Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `capacity_factor_design_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor Design Percentage (pct)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `commercial_operation_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Operation Date (COD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `derms_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource Management System (DERMS) Integration Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `eam_asset_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Asset Management (EAM) Asset Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `eam_asset_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `estimated_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Estimated Useful Life Years');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Account Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3}(.[0-9]{1,2})?$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `gis_asset_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Asset ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `gis_asset_reference` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `hub_height_m` SET TAGS ('dbx_business_glossary_term' = 'Hub Height Meters (m)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `installed_capacity_mw_ac` SET TAGS ('dbx_business_glossary_term' = 'Installed Capacity Megawatt (MW) Alternating Current (AC)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `installed_capacity_mw_dc` SET TAGS ('dbx_business_glossary_term' = 'Installed Capacity Megawatt (MW) Direct Current (DC)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `interconnection_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `inverter_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Inverter Manufacturer');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `inverter_model` SET TAGS ('dbx_business_glossary_term' = 'Inverter Model');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `nem_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|standby|out_of_service|under_construction|retired|mothballed');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `owner_operator_type` SET TAGS ('dbx_business_glossary_term' = 'Owner Operator Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `owner_operator_type` SET TAGS ('dbx_value_regex' = 'utility_owned|third_party_ppa|customer_owned_nem|joint_venture');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `panel_model` SET TAGS ('dbx_business_glossary_term' = 'Solar Panel Model');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `pi_historian_tag_prefix` SET TAGS ('dbx_business_glossary_term' = 'PI Historian Tag Prefix');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `pi_historian_tag_prefix` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{4,20}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `ppa_contract_number` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Contract Number');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `ppa_contract_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{8,20}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `ppa_contract_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `rec_tracking_system_code` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Tracking System ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `rec_tracking_system_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,25}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `record_active_flag` SET TAGS ('dbx_business_glossary_term' = 'Record Active Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `reservoir_capacity_acre_feet` SET TAGS ('dbx_business_glossary_term' = 'Reservoir Capacity Acre-Feet');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `resource_code` SET TAGS ('dbx_business_glossary_term' = 'Resource Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `resource_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'Resource Name');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Renewable Resource Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'solar_pv|solar_thermal|wind_onshore|wind_offshore|hydro_run_of_river|hydro_pumped_storage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `resource_zone` SET TAGS ('dbx_business_glossary_term' = 'Resource Zone');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `rotor_diameter_m` SET TAGS ('dbx_business_glossary_term' = 'Rotor Diameter Meters (m)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `turbine_model` SET TAGS ('dbx_business_glossary_term' = 'Wind Turbine Model');
ALTER TABLE `power_and_utilities_v2`.`generation`.`renewable_resource` ALTER COLUMN `water_head_m` SET TAGS ('dbx_business_glossary_term' = 'Water Head Meters (m)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` SET TAGS ('dbx_subdomain' = 'plant_management');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `capacity_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Resource Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `accredited_capacity_mw_icap` SET TAGS ('dbx_business_glossary_term' = 'Accredited Capacity Megawatt (MW) Installed Capacity (ICAP)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `accredited_capacity_mw_ucap` SET TAGS ('dbx_business_glossary_term' = 'Accredited Capacity Megawatt (MW) Unforced Capacity (UCAP)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `bonus_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Bonus Amount United States Dollar (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `bonus_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `capacity_interconnection_rights` SET TAGS ('dbx_business_glossary_term' = 'Capacity Interconnection Rights');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `capacity_interconnection_rights` SET TAGS ('dbx_value_regex' = 'firm|non_firm|conditional');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `capacity_obligation_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity Obligation Megawatt (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `capacity_product_type` SET TAGS ('dbx_business_glossary_term' = 'Capacity Product (CP) Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `capacity_product_type` SET TAGS ('dbx_value_regex' = 'base|annual|extended_summer|cp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `capacity_revenue_forecast_usd` SET TAGS ('dbx_business_glossary_term' = 'Capacity Revenue Forecast United States Dollar (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `capacity_revenue_forecast_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `capacity_transfer_rights` SET TAGS ('dbx_business_glossary_term' = 'Capacity Transfer Rights');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `capacity_transfer_rights` SET TAGS ('dbx_value_regex' = 'transferable|non_transferable|restricted');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `capacity_zone` SET TAGS ('dbx_business_glossary_term' = 'Capacity Zone');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `cleared_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Cleared Capacity Megawatt (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `cleared_capacity_price_usd_per_mw_day` SET TAGS ('dbx_business_glossary_term' = 'Cleared Capacity Price United States Dollar (USD) per Megawatt (MW) Day');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `cleared_capacity_price_usd_per_mw_day` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `delivery_year` SET TAGS ('dbx_business_glossary_term' = 'Delivery Year');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `effective_load_carrying_capability_mw` SET TAGS ('dbx_business_glossary_term' = 'Effective Load Carrying Capability (ELCC) Megawatt (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `last_performance_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Assessment Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `must_offer_obligation` SET TAGS ('dbx_business_glossary_term' = 'Must Offer Obligation');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `net_performance_payment_usd` SET TAGS ('dbx_business_glossary_term' = 'Net Performance Payment United States Dollar (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `net_performance_payment_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `next_performance_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Next Performance Assessment Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `penalty_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount United States Dollar (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `penalty_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `performance_assessment_interval` SET TAGS ('dbx_business_glossary_term' = 'Performance Assessment Interval');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `performance_assessment_interval` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|disqualified|suspended|retired');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `qualification_test_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Test Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `qualification_test_result_mw` SET TAGS ('dbx_business_glossary_term' = 'Qualification Test Result Megawatt (MW)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `qualification_test_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Test Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `qualification_test_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|waived');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `rec_eligible` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Eligible');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|retired');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'Capacity Resource Name');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Capacity Resource Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `resource_type` SET TAGS ('dbx_value_regex' = 'generation|demand_response|energy_efficiency|storage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `rto_iso_name` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Name');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `rto_iso_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Registration Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `seasonal_capacity_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Capacity Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`capacity_resource` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` SET TAGS ('dbx_subdomain' = 'generation_operations');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `startup_shutdown_event_id` SET TAGS ('dbx_business_glossary_term' = 'Startup/Shutdown Event ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `ems_dispatch_instruction_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Instruction ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Initiating Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `preceding_startup_shutdown_event_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Event Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `emission_factor_code` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `emissions_co2_tons` SET TAGS ('dbx_business_glossary_term' = 'CO₂ Emissions (Tons)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `emissions_nox_tons` SET TAGS ('dbx_business_glossary_term' = 'NOx Emissions (Tons)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `emissions_so2_tons` SET TAGS ('dbx_business_glossary_term' = 'SO₂ Emissions (Tons)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `event_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Event Reference Code');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'hot_start|warm_start|cold_start|normal_shutdown|emergency_trip');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `fuel_consumed_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumed (MMBtu)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `initiating_cause` SET TAGS ('dbx_business_glossary_term' = 'Initiating Cause');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `initiating_cause` SET TAGS ('dbx_value_regex' = 'operator|automatic|fault|weather|maintenance|other');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Is Emergency Event');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `is_estimated` SET TAGS ('dbx_business_glossary_term' = 'Is Estimated');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `is_reportable_to_ferc` SET TAGS ('dbx_business_glossary_term' = 'Reportable to FERC');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `net_startup_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Net Startup Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `ramp_rate_mw_per_min` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate (MW/min)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `record_source_system` SET TAGS ('dbx_value_regex' = 'OSIsoft_PI|GE_PowerOn|SAP_ERP|Oracle_CC&B|Maximo|Allegro');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `startup_cost_adjustment_usd` SET TAGS ('dbx_business_glossary_term' = 'Startup Cost Adjustment (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `startup_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Startup Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `startup_shutdown_event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `startup_shutdown_event_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|failed');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `startup_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Startup Time (Hours)');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `unit_status_after` SET TAGS ('dbx_business_glossary_term' = 'Unit Status After Event');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `unit_status_after` SET TAGS ('dbx_value_regex' = 'offline|starting|online|shutting_down|maintenance|emergency');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `unit_status_before` SET TAGS ('dbx_business_glossary_term' = 'Unit Status Before Event');
ALTER TABLE `power_and_utilities_v2`.`generation`.`startup_shutdown_event` ALTER COLUMN `unit_status_before` SET TAGS ('dbx_value_regex' = 'offline|starting|online|shutting_down|maintenance|emergency');
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` SET TAGS ('dbx_subdomain' = 'market_compliance');
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` SET TAGS ('dbx_association_edges' = 'generation.plant,metering.metering_service_point');
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` ALTER COLUMN `allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Allocation - Allocation Id');
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Allocation Contract Identifier');
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` ALTER COLUMN `metering_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Allocation - Metering Service Point Id');
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Allocation - Plant Id');
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation End Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` ALTER COLUMN `percent` SET TAGS ('dbx_business_glossary_term' = 'Allocation Percentage');
ALTER TABLE `power_and_utilities_v2`.`generation`.`allocation` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Allocation Start Date');
ALTER TABLE `power_and_utilities_v2`.`generation`.`audit_plant_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`generation`.`audit_plant_assignment` SET TAGS ('dbx_subdomain' = 'market_compliance');
ALTER TABLE `power_and_utilities_v2`.`generation`.`audit_plant_assignment` SET TAGS ('dbx_association_edges' = 'generation.plant,safety.safety_audit');
ALTER TABLE `power_and_utilities_v2`.`generation`.`audit_plant_assignment` ALTER COLUMN `audit_plant_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Plant Assignment - Audit Plant Id');
ALTER TABLE `power_and_utilities_v2`.`generation`.`audit_plant_assignment` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Plant Assignment - Plant Id');
ALTER TABLE `power_and_utilities_v2`.`generation`.`audit_plant_assignment` ALTER COLUMN `safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Plant Assignment - Safety Audit Id');
