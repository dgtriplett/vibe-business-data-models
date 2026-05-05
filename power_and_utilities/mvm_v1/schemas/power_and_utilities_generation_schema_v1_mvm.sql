-- Schema for Domain: generation | Business: Power and Utilities | Version: v1_mvm
-- Generated on: 2026-04-29 23:12:56

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities`.`generation` COMMENT 'Owns all data related to energy generation assets and operations — fossil fuel, nuclear, and renewable power plant operations including unit dispatch, fuel management, capacity planning, heat rate optimization, emissions monitoring, and generation output (MWh). Serves as the SSOT for generation facility master data, real-time EMS/SCADA telemetry, and plant performance metrics. Supports IRP, RPS compliance, and PPA tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities`.`generation`.`plant` (
    `plant_id` BIGINT COMMENT 'Unique identifier for the power generation facility. Primary key for the plant entity.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Generation plants are subject to specific compliance obligations (emissions limits, reliability standards, renewable portfolio standards) based on their fuel type, capacity, and jurisdiction. Linking ',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Plants are cost centers for O&M expense tracking, budget allocation, and FERC functional accounting. Required for monthly variance reporting, budget vs actual analysis, and regulatory cost allocation ',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Each generation plants legal authority to operate originates from a Certificate of Public Convenience and Necessity (CPCN) proceeding conducted through a regulatory docket. Tracking the authorizing d',
    `master_id` BIGINT COMMENT 'Foreign key linking to asset.asset_master. Business justification: Generation plants are physical capital assets that must be tracked in the enterprise asset management system. This FK enables lifecycle tracking, maintenance scheduling, and regulatory asset base calc',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Generation plants physically interconnect to transmission substations at specific voltage levels. Essential for real-time dispatch coordination, NERC compliance (MOD-001, TOP-002), outage coordination',
    `balancing_authority` STRING COMMENT 'The NERC-registered balancing authority responsible for real-time generation-load balance and frequency control in the area where the plant operates. Critical for SCADA integration and dispatch coordination.',
    `capacity_factor_percent` DECIMAL(18,2) COMMENT 'Ratio of actual energy output to maximum possible output over a reporting period, expressed as a percentage. Used for renewable energy performance tracking, asset utilization analysis, and Power Purchase Agreement (PPA) performance guarantees.',
    `commercial_operation_date` DATE COMMENT 'Date when the generation facility began commercial electricity production and became eligible for market participation and revenue generation. Used for depreciation calculations, Power Purchase Agreement (PPA) milestone tracking, and Renewable Energy Certificate (REC) eligibility.',
    `construction_year` STRING COMMENT 'Year when the generation facility was originally constructed or substantially completed. Used for depreciation calculations, asset age analysis, and capital planning.',
    `county` STRING COMMENT 'County or parish where the generation facility is located. Used for property tax assessment, local permitting, and environmental impact reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plant master record was first created in the system. Used for data lineage tracking and audit trail purposes.',
    `eia_plant_code` STRING COMMENT 'U.S. Department of Energy EIA-assigned unique identifier for the generation facility used in EIA-860 and EIA-923 reporting.. Valid values are `^[0-9]{1,6}$`',
    `emissions_controlled` BOOLEAN COMMENT 'Indicates whether the generation facility is equipped with emissions control technology (scrubbers, selective catalytic reduction, carbon capture). Used for EPA compliance reporting, Greenhouse Gas (GHG) inventory, and environmental cost allocation.',
    `ems_resource_reference` STRING COMMENT 'Unique identifier assigned to the generation facility within the utilitys Energy Management System (EMS) or SCADA platform. Used for real-time dispatch instructions, telemetry data correlation, and outage coordination.',
    `ferc_plant_code` STRING COMMENT 'FERC-assigned unique identifier for the generation facility used in FERC Form 1 reporting and rate case filings.. Valid values are `^[0-9]{1,10}$`',
    `fuel_type` STRING COMMENT 'Primary fuel source used by the generation facility for energy production. Critical for fuel management, emissions tracking, and Renewable Portfolio Standard (RPS) compliance. [ENUM-REF-CANDIDATE: natural_gas|coal|nuclear|solar|wind|hydro|oil|biomass|geothermal|dual_fuel — 10 candidates stripped; promote to reference product]',
    `heat_rate_btu_per_kwh` DECIMAL(18,2) COMMENT 'Thermal efficiency measure representing the amount of fuel energy (BTU) required to produce one kilowatt-hour (kWh) of electricity. Lower values indicate higher efficiency. Used for fuel cost forecasting, dispatch merit order, and performance benchmarking.',
    `interconnection_voltage_kv` DECIMAL(18,2) COMMENT 'Voltage level in kilovolts (kV) at which the generation facility connects to the transmission or distribution grid. Determines transmission access charges and Open Access Transmission Tariff (OATT) applicability.',
    `iso_rto_region` STRING COMMENT 'The ISO or RTO market region where the generation facility is interconnected and participates in wholesale electricity markets. Determines market rules, Locational Marginal Price (LMP) settlement, and transmission tariff obligations. [ENUM-REF-CANDIDATE: CAISO|ERCOT|ISONE|MISO|NYISO|PJM|SPP|non_iso — 8 candidates stripped; promote to reference product]',
    `last_major_upgrade_date` DATE COMMENT 'Date of the most recent major capital upgrade or refurbishment that extended the useful life or increased the capacity of the generation facility. Used for depreciation recalculation and Allowance for Funds Used During Construction (AFUDC) tracking.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the plant master record was most recently modified. Used for change tracking, data quality monitoring, and synchronization with downstream systems.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the generation facility in decimal degrees. Used for GIS mapping, weather correlation analysis, and transmission planning.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the generation facility in decimal degrees. Used for GIS mapping, solar irradiance modeling, and transmission line routing.',
    `minimum_load_mw` DECIMAL(18,2) COMMENT 'Minimum stable operating output level in megawatts (MW) below which the generation unit cannot operate reliably. Used for unit commitment decisions, ancillary service qualification, and dispatch constraint modeling.',
    `nameplate_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum rated electrical output capacity of the generation facility in megawatts (MW) under ideal operating conditions. Used for capacity market obligations, resource adequacy planning, and Integrated Resource Plan (IRP) modeling.',
    `nerc_plant_code` STRING COMMENT 'NERC-assigned unique identifier for the generation facility used in Bulk Electric System (BES) registration and compliance reporting.. Valid values are `^[A-Z0-9]{1,10}$`',
    `net_capacity_mw` DECIMAL(18,2) COMMENT 'Actual electrical output capacity available for delivery to the grid after accounting for auxiliary load and station service requirements. Used for dispatch scheduling and market settlement.',
    `operator_name` STRING COMMENT 'Name of the entity responsible for day-to-day operations and maintenance of the generation facility. May differ from the owner in cases of third-party operations and maintenance (O&M) contracts.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of the generation facility owned by the utility, expressed as a decimal (e.g., 100.00 for wholly-owned, 50.00 for joint venture). Used for capacity allocation, cost allocation, and FERC Form 1 reporting.',
    `plant_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the generation facility for operational and regulatory identification. Used in dispatch instructions, market bids, and regulatory filings.. Valid values are `^[A-Z0-9]{4,12}$`',
    `plant_name` STRING COMMENT 'Official name of the power generation facility as registered with regulatory authorities and used in operational communications.',
    `plant_status` STRING COMMENT 'Current operational lifecycle state of the generation facility. Determines availability for dispatch, capacity market participation, and regulatory reporting obligations.. Valid values are `operating|mothballed|retired|under_construction|planned|decommissioned`',
    `ppa_contract_flag` BOOLEAN COMMENT 'Indicates whether the generation facility operates under a Power Purchase Agreement (PPA) with the utility or third-party offtaker. Used for revenue forecasting, contract administration, and regulatory cost recovery filings.',
    `primary_use` STRING COMMENT 'Operational dispatch classification describing the typical role of the generation facility in meeting system load. Used for unit commitment optimization, capacity factor analysis, and Integrated Resource Plan (IRP) modeling.. Valid values are `baseload|intermediate|peaking|renewable_intermittent|energy_storage|backup`',
    `ramp_rate_mw_per_minute` DECIMAL(18,2) COMMENT 'Maximum rate at which the generation facility can increase or decrease output, measured in megawatts per minute. Critical for frequency regulation, load following, and renewable integration support.',
    `rec_eligible` BOOLEAN COMMENT 'Indicates whether the generation facility is eligible to generate Renewable Energy Certificates (RECs) for compliance with state RPS mandates or voluntary green power programs.',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory authority with rate-setting and operational oversight for the generation facility. Determines rate case filing requirements, prudency review processes, and cost recovery mechanisms.. Valid values are `ferc|state_puc|municipal|cooperative|federal_power_marketing`',
    `renewable_energy_flag` BOOLEAN COMMENT 'Indicates whether the generation facility qualifies as a renewable energy resource under state Renewable Portfolio Standard (RPS) programs and federal Production Tax Credit (PTC) or Investment Tax Credit (ITC) eligibility.',
    `retirement_date` DATE COMMENT 'Planned or actual date when the generation facility ceased or will cease commercial operations. Used for capacity planning, asset retirement obligation (ARO) accounting, and regulatory decommissioning filings.',
    `scada_integration_flag` BOOLEAN COMMENT 'Indicates whether the generation facility is integrated with the utilitys Energy Management System (EMS) or SCADA platform for real-time telemetry, dispatch control, and automatic generation control (AGC).',
    `startup_time_hours` DECIMAL(18,2) COMMENT 'Time required in hours to bring the generation unit from offline to minimum load under normal conditions. Used for day-ahead market bidding, unit commitment optimization, and reliability planning.',
    `state_code` STRING COMMENT 'Two-letter U.S. state abbreviation where the generation facility is physically located. Determines state Public Utility Commission (PUC) jurisdiction, Renewable Portfolio Standard (RPS) eligibility, and emissions regulations.. Valid values are `^[A-Z]{2}$`',
    `technology_type` STRING COMMENT 'Generation technology classification describing the conversion process from fuel to electricity. Used for heat rate analysis, dispatch optimization, and capacity planning. [ENUM-REF-CANDIDATE: combined_cycle|combustion_turbine|steam_turbine|photovoltaic|wind_turbine|hydroelectric|nuclear_reactor|battery_storage — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_plant PRIMARY KEY(`plant_id`)
) COMMENT 'Master record for each power generation facility operated by the utility — fossil fuel (CT, CC, coal), nuclear, and renewable (solar, wind, hydro). Captures plant name, NERC plant code, fuel type, technology type (combined cycle, combustion turbine, steam, photovoltaic, wind turbine, hydro), ISO/RTO interconnection region, nameplate capacity (MW), commercial operation date, retirement date, FERC plant ID, state/county location, GIS coordinates, regulatory jurisdiction (PUC, FERC), plant status (operating, mothballed, retired, under construction), and ownership percentage. Serves as the SSOT for generation facility master data and the anchor entity for all generation domain products. Sourced from ABB/GE Energy Management System and SAP S/4HANA asset registry.';

CREATE OR REPLACE TABLE `power_and_utilities`.`generation`.`generating_unit` (
    `generating_unit_id` BIGINT COMMENT 'Unique identifier for the generating unit. Primary key for the generating unit entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Individual generating units track O&M costs separately for unit-level performance analysis, heat rate economics, and regulatory cost allocation. Essential for unit profitability analysis and FERC Form',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Individual generating units often require separate CPCN approval, especially for capacity additions or repowering projects. Linking units to their authorizing dockets supports cost recovery filings, p',
    `master_id` BIGINT COMMENT 'Foreign key linking to asset.asset_master. Business justification: Generating units (turbines, generators, boilers) are major capital assets requiring comprehensive asset management. This FK enables work order tracking, failure analysis, and depreciation calculations',
    `plant_id` BIGINT COMMENT 'Identifier of the parent generation plant or facility where this unit is located.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Individual generating units interconnect at specific substations for unit-level dispatch instructions and protection coordination. Required for security-constrained unit commitment, real-time AGC sign',
    `ancillary_services_capable` STRING COMMENT 'Comma-separated list of ancillary services the generating unit is technically capable of providing (e.g., regulation, spinning reserve, non-spinning reserve, voltage support, black start).',
    `balancing_authority` STRING COMMENT 'NERC-registered Balancing Authority responsible for integrating resource plans, maintaining load-interchange-generation balance, and supporting interconnection frequency in real time for the area where this unit operates.',
    `black_start_capable` BOOLEAN COMMENT 'Indicates whether the generating unit has black start capability, meaning it can start without external electrical supply and help restore the grid after a blackout. True if capable, False otherwise.',
    `capacity_factor_target_pct` DECIMAL(18,2) COMMENT 'Target or expected capacity factor for the generating unit, expressed as a percentage. Capacity factor is the ratio of actual output over a period to the maximum possible output if the unit operated at full capacity continuously.',
    `carbon_capture_enabled` BOOLEAN COMMENT 'Indicates whether the generating unit is equipped with carbon capture and storage (CCS) or carbon capture and utilization (CCU) technology. True if equipped, False otherwise.',
    `commercial_operation_date` DATE COMMENT 'Date when the generating unit first entered commercial service and began producing electricity for sale or delivery to the grid.',
    `cooling_system_type` STRING COMMENT 'Type of cooling system used by the generating unit for thermal plants. Once Through=direct water cooling, Recirculating=cooling tower with water reuse, Dry Cooling=air-cooled condenser, Hybrid=combination system, None=not applicable for non-thermal units.. Valid values are `once_through|recirculating|dry_cooling|hybrid|none`',
    `dispatch_priority` STRING COMMENT 'Numeric priority ranking used by the Energy Management System (EMS) for economic dispatch and unit commitment decisions. Lower numbers indicate higher priority.',
    `eia_generator_code` STRING COMMENT 'Energy Information Administration (EIA) unique identifier for the generator, used in EIA-860 and EIA-923 regulatory reporting.',
    `emissions_control_equipment` STRING COMMENT 'Description of installed emissions control technologies (e.g., Selective Catalytic Reduction for NOx, Flue Gas Desulfurization for SO2, Electrostatic Precipitator for particulates, Carbon Capture and Storage).',
    `fuel_primary` STRING COMMENT 'Primary fuel type consumed by the generating unit (e.g., natural gas, coal, uranium, wind, solar, water). Aligns with EIA fuel type codes.',
    `fuel_secondary` STRING COMMENT 'Secondary or backup fuel type that the unit can consume, if applicable. Null for units with single fuel capability.',
    `heat_rate_btu_per_kwh` DECIMAL(18,2) COMMENT 'Measure of generating unit thermal efficiency, expressed as British Thermal Units (BTU) of fuel energy input required to produce one kilowatt-hour (kWh) of electrical output. Lower values indicate higher efficiency.',
    `interconnection_voltage_kv` DECIMAL(18,2) COMMENT 'Voltage level in kilovolts (kV) at which the generating unit interconnects to the transmission or distribution grid.',
    `last_major_overhaul_date` DATE COMMENT 'Date of the most recent major overhaul, refurbishment, or life-extension project performed on the generating unit.',
    `manufacturer` STRING COMMENT 'Name of the manufacturer or original equipment manufacturer (OEM) of the primary generating equipment (turbine, generator, or inverter).',
    `minimum_stable_load_mw` DECIMAL(18,2) COMMENT 'Minimum output level at which the generating unit can operate continuously in a stable manner without shutting down, measured in Megawatts (MW).',
    `model_number` STRING COMMENT 'Manufacturer model number or designation of the generating equipment.',
    `must_run_designation` BOOLEAN COMMENT 'Indicates whether the generating unit has been designated as a must-run or reliability-must-run (RMR) unit by the RTO/ISO or Balancing Authority for grid reliability purposes. True if designated, False otherwise.',
    `nameplate_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum rated output of the generator under ideal conditions as specified by the manufacturer, measured in Megawatts (MW).',
    `nerc_unit_code` STRING COMMENT 'North American Electric Reliability Corporation (NERC) unique identifier for the generating unit, used in NERC GADS reporting and reliability coordination.',
    `net_summer_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum net output the unit can sustain over a specified period under summer ambient conditions, accounting for station service loads, measured in Megawatts (MW).',
    `net_winter_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum net output the unit can sustain over a specified period under winter ambient conditions, accounting for station service loads, measured in Megawatts (MW).',
    `next_scheduled_outage_date` DATE COMMENT 'Date of the next planned maintenance outage for the generating unit. Used for outage coordination and resource adequacy planning.',
    `ownership_type` STRING COMMENT 'Legal ownership or contractual arrangement for the generating unit. Owned=utility-owned asset, Leased=leased from third party, PPA=Power Purchase Agreement with independent producer, Tolling=fuel conversion service agreement, Joint Ownership=shared ownership with other utilities.. Valid values are `owned|leased|ppa|tolling|joint_ownership`',
    `planned_retirement_date` DATE COMMENT 'Anticipated date for permanent retirement of the generating unit, if known. Used for long-term resource planning and Integrated Resource Plan (IRP) development.',
    `prime_mover_code` STRING COMMENT 'EIA-860 standard code identifying the type of prime mover (engine or turbine) that drives the generator. ST=Steam Turbine, GT=Gas Turbine, IC=Internal Combustion, CA=Combined Cycle Steam, CT=Combustion Turbine, CS=Combined Cycle Single Shaft, CC=Combined Cycle, CE=Compressed Air Energy Storage, HY=Hydraulic Turbine, PS=Pumped Storage, PV=Photovoltaic, WT=Wind Turbine, WS=Wind Turbine Offshore, FC=Fuel Cell, ES=Energy Storage, OT=Other. [ENUM-REF-CANDIDATE: ST|GT|IC|CA|CT|CS|CC|CE|HY|PS|PV|WT|WS|FC|ES|OT — 16 candidates stripped; promote to reference product]',
    `ramp_rate_mw_per_min` DECIMAL(18,2) COMMENT 'Maximum rate at which the generating unit can increase or decrease its output, measured in Megawatts per minute (MW/min). Critical for dispatch flexibility and grid balancing.',
    `renewable_energy_credit_eligible` BOOLEAN COMMENT 'Indicates whether the generating unit is eligible to generate Renewable Energy Credits (RECs) under applicable Renewable Portfolio Standard (RPS) programs. True if eligible, False otherwise.',
    `retirement_date` DATE COMMENT 'Date when the generating unit was permanently retired from service. Null for active units.',
    `rto_iso_region` STRING COMMENT 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) market region in which the generating unit participates (e.g., PJM, CAISO, ERCOT, MISO, NYISO, ISO-NE, SPP).',
    `scada_point_reference` STRING COMMENT 'Supervisory Control and Data Acquisition (SCADA) system identifier or tag name for real-time telemetry data from this generating unit.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to the generating equipment unit.',
    `synchronization_date` DATE COMMENT 'Date when the generating unit was first synchronized to the electrical grid for testing or initial operation.',
    `technology_type` STRING COMMENT 'Detailed technology classification of the generating unit (e.g., supercritical coal, combined cycle gas turbine, pressurized water reactor, onshore wind, utility-scale solar PV, pumped hydro storage).',
    `unit_code` STRING COMMENT 'Externally-known alphanumeric code or designation for the generating unit, used in operational systems and regulatory filings.',
    `unit_name` STRING COMMENT 'Human-readable name or designation of the generating unit (e.g., Boiler 1, Turbine A, Wind Turbine 42, Solar Inverter Block 3).',
    `unit_status` STRING COMMENT 'Current operational status of the generating unit in its lifecycle. Available=ready for dispatch, Operating=currently generating, Forced Outage=unplanned unavailability, Planned Outage=scheduled maintenance, Derated=operating below full capacity, Standby=ready but not dispatched, Retired=permanently out of service, Mothballed=temporarily preserved for potential future use. [ENUM-REF-CANDIDATE: available|operating|forced_outage|planned_outage|derated|standby|retired|mothballed — 8 candidates stripped; promote to reference product]',
    `unit_type` STRING COMMENT 'High-level classification of the generating unit by energy source or technology type. [ENUM-REF-CANDIDATE: fossil|nuclear|hydro|wind|solar|geothermal|biomass|storage|other — 9 candidates stripped; promote to reference product]',
    `water_source` STRING COMMENT 'Primary water source used for cooling or other plant operations (e.g., river, lake, ocean, groundwater, municipal supply). Applicable to thermal and hydro units.',
    CONSTRAINT pk_generating_unit PRIMARY KEY(`generating_unit_id`)
) COMMENT 'Individual generating unit (boiler-turbine set, nuclear reactor unit, wind turbine, solar inverter block, hydro unit) within a plant. Tracks unit name, unit type, prime mover code (ST, GT, IC, HY, PV, WT per EIA-860), fuel primary/secondary, installed capacity (MW), net summer capacity (MW), net winter capacity (MW), heat rate (BTU/kWh), minimum stable load (MW), ramp rate (MW/min), unit status (available, forced outage, planned outage, derated, retired), synchronization date, and NERC unit ID. Enables unit-level dispatch, heat rate optimization, and capacity reporting. Sourced from ABB/GE EMS and NERC GADS submissions.';

CREATE OR REPLACE TABLE `power_and_utilities`.`generation`.`dispatch_schedule` (
    `dispatch_schedule_id` BIGINT COMMENT 'Primary key for dispatch_schedule',
    `generating_unit_id` BIGINT COMMENT 'Reference to the specific generating unit (power plant unit) for which this dispatch schedule applies. Links to the generating unit master data.',
    `grid_topology_id` BIGINT COMMENT 'Foreign key linking to transmission.grid_topology. Business justification: Dispatch schedules are calculated against specific network topology models for security-constrained economic dispatch. Critical for day-ahead and real-time market clearing, congestion management, and ',
    `ppa_contract_id` BIGINT COMMENT 'Reference to the Power Purchase Agreement (PPA) contract if this generation is procured under a PPA rather than owned generation. Used for contract settlement and cost allocation.',
    `pricing_node_id` BIGINT COMMENT 'Reference to the Locational Marginal Price (LMP) pricing node associated with this generating unit. Used for settlement and revenue calculation in wholesale energy markets.',
    `ancillary_service_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the unit is scheduled to provide ancillary services (regulation, spinning reserve, non-spinning reserve, voltage support) during this operating hour.',
    `commitment_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the unit commitment decision has been finalized for this schedule. True indicates the unit is committed to operate; False indicates the schedule is preliminary or advisory.',
    `control_area` STRING COMMENT 'The RTO/ISO control area or balancing authority area in which the generating unit operates. Examples include PJM, CAISO, ERCOT, MISO, NYISO, ISO-NE, SPP.',
    `dispatch_instruction_timestamp` TIMESTAMP COMMENT 'The date and time when the dispatch instruction was issued by the Energy Management System (EMS) or RTO/ISO. Represents the business event time for the dispatch decision.',
    `dispatch_status` STRING COMMENT 'Current lifecycle status of the dispatch schedule. Scheduled indicates initial plan; committed means unit commitment decision made; dispatched means unit is operating per schedule; cancelled or revised indicate changes.. Valid values are `scheduled|committed|dispatched|cancelled|revised`',
    `dispatch_type` STRING COMMENT 'Classification of the dispatch instruction based on the operational driver. Economic dispatch follows least-cost optimization; reliability dispatch addresses grid constraints; emergency dispatch responds to system contingencies; regulation and load-following provide ancillary services.. Valid values are `economic|reliability|emergency|regulation|load_following|must_run`',
    `economic_dispatch_mw` DECIMAL(18,2) COMMENT 'The economically optimal generation output in megawatts based on marginal cost optimization and Locational Marginal Price (LMP) signals. May differ from scheduled MW if reliability or must-run constraints apply.',
    `emissions_rate_lbs_per_mwh` DECIMAL(18,2) COMMENT 'The forecasted emissions rate in pounds per megawatt-hour for the scheduled generation. Typically represents CO2, NOx, or SO2 emissions depending on regulatory reporting requirements.',
    `forecast_load_mw` DECIMAL(18,2) COMMENT 'The forecasted system load in megawatts for the control area during the scheduled operating hour. Provides context for the dispatch decision and unit commitment optimization.',
    `fuel_burn_forecast_mmbtu` DECIMAL(18,2) COMMENT 'Forecasted fuel consumption in million British Thermal Units (MMBTU) required to produce the scheduled generation output. Used for fuel procurement planning and cost forecasting.',
    `fuel_type` STRING COMMENT 'The primary fuel source used by the generating unit. Used for fuel procurement planning, emissions tracking, and Renewable Portfolio Standard (RPS) compliance. [ENUM-REF-CANDIDATE: natural_gas|coal|nuclear|hydro|wind|solar|oil|biomass — 8 candidates stripped; promote to reference product]',
    `heat_rate_btu_per_kwh` DECIMAL(18,2) COMMENT 'The expected heat rate in BTU per kWh for the unit at the scheduled output level. Represents the thermal efficiency of the generating unit. Lower heat rates indicate higher efficiency.',
    `marginal_cost_usd_per_mwh` DECIMAL(18,2) COMMENT 'The incremental cost in US dollars per megawatt-hour to produce the next unit of energy at the scheduled output level. Used in economic dispatch optimization and bid cost recovery calculations.',
    `maximum_generation_mw` DECIMAL(18,2) COMMENT 'The maximum generation capacity in megawatts available from the unit during the operating hour. Represents the upper operating limit considering unit capability and any derates.',
    `minimum_down_time_hours` STRING COMMENT 'The minimum number of consecutive hours the unit must remain offline once shut down. Operational constraint based on cooling requirements and thermal stress limits.',
    `minimum_generation_mw` DECIMAL(18,2) COMMENT 'The minimum stable generation level in megawatts that the unit can sustain during the operating hour. Represents the lower operating limit for the unit.',
    `minimum_up_time_hours` STRING COMMENT 'The minimum number of consecutive hours the unit must remain online once started. Operational constraint based on unit design and thermal stress limits.',
    `must_run_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the unit is designated as must-run for reliability purposes. Must-run units are committed regardless of economic merit to maintain grid stability, voltage support, or local reliability.',
    `operating_hour` STRING COMMENT 'The hour of the day (0-23) for which this dispatch schedule applies. Represents the hour-ending convention used in energy markets.',
    `ramp_rate_mw_per_min` DECIMAL(18,2) COMMENT 'The maximum rate at which the generating unit can increase or decrease output, measured in megawatts per minute. Critical for load-following and frequency regulation services.',
    `regulation_reserve_mw` DECIMAL(18,2) COMMENT 'The amount of generation capacity in megawatts reserved for automatic generation control (AGC) regulation service. This capacity is held back from energy dispatch to provide frequency regulation.',
    `schedule_created_timestamp` TIMESTAMP COMMENT 'The date and time when this dispatch schedule record was first created in the system. Audit timestamp for record creation.',
    `schedule_date` DATE COMMENT 'The calendar date for which this dispatch schedule is effective. Used for day-ahead and real-time dispatch planning.',
    `schedule_notes` STRING COMMENT 'Free-text field for operational notes, comments, or special instructions related to the dispatch schedule. May include reasons for out-of-merit dispatch, coordination notes, or operator remarks.',
    `schedule_source_system` STRING COMMENT 'The name of the source system that generated this dispatch schedule. Typically the ABB or GE Energy Management System (EMS) dispatch engine, or the RTO/ISO market system.',
    `schedule_type` STRING COMMENT 'Classification of the dispatch schedule based on market timing and purpose. Day-ahead schedules are produced 24 hours in advance; real-time schedules are produced hourly; reliability and emergency schedules address grid stability needs.. Valid values are `day_ahead|real_time|intra_day|reliability|emergency`',
    `schedule_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this dispatch schedule record was last modified. Audit timestamp for record updates, capturing schedule revisions.',
    `schedule_version` STRING COMMENT 'Version number of the dispatch schedule. Increments when schedules are revised due to updated forecasts, unit availability changes, or market conditions. Version 1 is typically the day-ahead schedule.',
    `scheduled_mw_output` DECIMAL(18,2) COMMENT 'The planned generation output in megawatts (MW) for the generating unit during the specified operating hour. This is the target output level determined by the Energy Management System (EMS) dispatch optimization.',
    `settlement_interval` STRING COMMENT 'The sub-hourly settlement interval (typically 5, 10, or 15 minutes) within the operating hour for which this schedule applies. Used in real-time markets with sub-hourly dispatch and settlement.',
    `spinning_reserve_mw` DECIMAL(18,2) COMMENT 'The amount of synchronized generation capacity in megawatts held in reserve to respond to sudden generation or transmission outages within 10 minutes.',
    `startup_cost_usd` DECIMAL(18,2) COMMENT 'The estimated cost in US dollars to start the generating unit from an offline state. Includes fuel, labor, and wear-and-tear costs. Used in unit commitment optimization.',
    `startup_type` STRING COMMENT 'Classification of the unit startup condition if the unit is being committed from an offline state. Hot startup occurs within 8 hours of shutdown; warm startup within 8-48 hours; cold startup after 48+ hours. Affects startup time and costs.. Valid values are `hot|warm|cold`',
    `transmission_constraint_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether transmission system constraints influenced the dispatch schedule. True indicates the unit was dispatched out-of-economic-merit to address transmission congestion or voltage issues.',
    CONSTRAINT pk_dispatch_schedule PRIMARY KEY(`dispatch_schedule_id`)
) COMMENT 'Day-ahead and real-time generation dispatch schedule for each generating unit, produced by the ABB/GE Energy Management System (EMS) in coordination with the RTO/ISO. Records schedule date, operating hour, scheduled MW output, economic dispatch MW, must-run flag, dispatch type (economic, reliability, emergency), fuel burn forecast (MMBTU), associated LMP node, RTO/ISO control area, and schedule version. Supports unit commitment optimization, fuel procurement planning, and RTO settlement reconciliation. Distinct from unit_output which captures actual generation — this product captures the planned/scheduled generation that drives commitment decisions. Sourced from ABB/GE EMS dispatch engine.';

CREATE OR REPLACE TABLE `power_and_utilities`.`generation`.`unit_output` (
    `unit_output_id` BIGINT COMMENT 'Unique identifier for each unit output telemetry record. Primary key for the unit output data product.',
    `generating_unit_id` BIGINT COMMENT 'Foreign key reference to the generating unit (power plant unit) that produced this output measurement. Links to the generation unit master data.',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key reference to the Power Purchase Agreement (PPA) contract under which this generation output was produced and sold. Null for merchant generation or utility-owned generation not under a PPA.',
    `ambient_temperature_f` DECIMAL(18,2) COMMENT 'Ambient air temperature at the plant site during the interval, measured in degrees Fahrenheit. Affects unit performance, especially for combustion turbines and air-cooled condensers. Used for temperature-corrected performance analysis.',
    `auxiliary_load_mwh` DECIMAL(18,2) COMMENT 'Electrical energy consumed by the power plants own auxiliary equipment (pumps, fans, controls, lighting) during the interval, measured in megawatt-hours (MWh). Deducted from gross generation to calculate net generation.',
    `barometric_pressure_inhg` DECIMAL(18,2) COMMENT 'Barometric pressure at the plant site during the interval, measured in inches of mercury (inHg). Affects combustion turbine performance and is used for altitude and weather corrections in performance calculations.',
    `capacity_factor_percent` DECIMAL(18,2) COMMENT 'Ratio of actual net generation to maximum possible generation (nameplate capacity) during the interval, expressed as a percentage. Key performance indicator for unit utilization and efficiency.',
    `co2_emissions_tons` DECIMAL(18,2) COMMENT 'Carbon dioxide emissions produced during the interval, measured in short tons. Calculated from fuel consumption and emission factors or measured via continuous emissions monitoring system (CEMS). Required for greenhouse gas (GHG) reporting and carbon compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this unit output record was first created in the MDMS or data warehouse. Used for data lineage and audit trail purposes.',
    `data_quality_flag` STRING COMMENT 'Indicates the quality and reliability of the telemetry data for this interval. Valid data passed all validation checks; estimated data was calculated due to sensor failure; missing data was not received; suspect data failed range checks; manual data was operator-entered; failed_validation data did not meet NERC or EPA quality standards.. Valid values are `valid|estimated|missing|suspect|manual|failed_validation`',
    `dispatch_mode` STRING COMMENT 'The operational dispatch mode of the unit during the interval. Indicates how the unit was being operated: baseload (continuous), cycling (load-following), peaking (on-demand), must-run (reliability), economic (market-driven), or manual (operator-controlled).. Valid values are `baseload|cycling|peaking|must_run|economic|manual`',
    `frequency_hz` DECIMAL(18,2) COMMENT 'Average electrical frequency at the generator terminals during the interval, measured in hertz (Hz). Standard grid frequency is 60 Hz in North America. Deviations indicate grid imbalance.',
    `fuel_consumption_mmbtu` DECIMAL(18,2) COMMENT 'Total fuel energy consumed during the interval, measured in millions of British Thermal Units (MMBtu). Calculated from fuel flow meters and fuel heating value. Used for fuel cost allocation and emissions calculation.',
    `gross_generation_mwh` DECIMAL(18,2) COMMENT 'Total electrical energy generated by the unit during the interval, measured in megawatt-hours (MWh), before deducting station auxiliary load. Represents the total output at the generator terminals.',
    `heat_rate_btu_per_kwh` DECIMAL(18,2) COMMENT 'Actual thermal efficiency of the generating unit during the interval, measured in British Thermal Units (BTU) of fuel energy input per kilowatt-hour (kWh) of electrical energy output. Lower values indicate higher efficiency. Critical for fuel cost optimization and performance benchmarking.',
    `interval_duration_minutes` STRING COMMENT 'The duration of the measurement interval in minutes. Common values are 5, 15, or 60 minutes. Used to normalize interval data to hourly or daily totals.',
    `interval_timestamp` TIMESTAMP COMMENT 'The precise date and time when this generation output measurement was recorded by the SCADA historian system. Represents the end of the measurement interval. Typically recorded at 5-minute or 15-minute intervals depending on unit type and regulatory requirements.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this unit output record was last modified or updated. Used for change tracking and data quality auditing.',
    `net_generation_mwh` DECIMAL(18,2) COMMENT 'Net electrical energy delivered to the grid during the interval, measured in megawatt-hours (MWh). Calculated as gross generation minus auxiliary load. This is the sellable energy used for RTO settlement and revenue calculation.',
    `nox_emissions_lbs` DECIMAL(18,2) COMMENT 'Nitrogen oxides emissions produced during the interval, measured in pounds. Monitored via CEMS for air quality compliance. Subject to EPA and state air quality regulations.',
    `reactive_power_mvar` DECIMAL(18,2) COMMENT 'Reactive power output during the interval, measured in megavolt-amperes reactive (MVAR). Used for voltage support and grid stability. May be positive (generation) or negative (consumption).',
    `rec_quantity` DECIMAL(18,2) COMMENT 'Number of Renewable Energy Certificates (RECs) generated during this interval. Typically one REC equals one MWh of renewable generation. Used for RPS compliance tracking and REC trading.',
    `relative_humidity_percent` DECIMAL(18,2) COMMENT 'Relative humidity at the plant site during the interval, expressed as a percentage. Affects combustion turbine performance and cooling tower efficiency. Used for environmental correction factors.',
    `rps_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the generation output during this interval is eligible for Renewable Portfolio Standard (RPS) compliance credit. True for renewable energy generation that meets state RPS criteria; false for fossil fuel or non-qualifying generation.',
    `rto_settlement_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this intervals generation output has been submitted to the RTO/ISO for energy market settlement. True means the data has been used for settlement; false means it has not yet been submitted or was excluded.',
    `scada_source_tag` STRING COMMENT 'The SCADA historian tag name or point identifier from which this telemetry data was sourced. Typically an OSIsoft PI tag or GE Proficy tag. Used for data lineage and troubleshooting.',
    `so2_emissions_lbs` DECIMAL(18,2) COMMENT 'Sulfur dioxide emissions produced during the interval, measured in pounds. Monitored via CEMS for acid rain program compliance and air quality regulations.',
    `steam_flow_klb_per_hr` DECIMAL(18,2) COMMENT 'Steam flow rate through the turbine during the interval, measured in thousands of pounds per hour (klb/hr). Applicable to steam turbine units (fossil, nuclear, combined cycle). Used for thermodynamic performance analysis.',
    `unit_status` STRING COMMENT 'Operational status of the generating unit during the interval. Indicates whether the unit was actively generating, offline, or in a transitional state. Used for availability analysis and outage tracking.. Valid values are `online|offline|startup|shutdown|standby|maintenance`',
    `voltage_kv` DECIMAL(18,2) COMMENT 'Average voltage at the generator terminals during the interval, measured in kilovolts (kV). Varies by unit design and step-up transformer configuration.',
    CONSTRAINT pk_unit_output PRIMARY KEY(`unit_output_id`)
) COMMENT 'Actual real-time and interval generation output telemetry for each generating unit, collected via OSIsoft PI / GE Proficy SCADA historian at sub-hourly intervals (typically 5-minute or 15-minute). Captures interval timestamp, gross generation (MWh), net generation (MWh), auxiliary load (MWh), reactive power (MVAR), frequency, voltage, capacity factor (%), heat rate actual (BTU/kWh), steam flow, and data quality flag. Serves as the SSOT for actual MWh production used in RTO settlement, RPS compliance, and plant performance benchmarking. Sourced from OSIsoft PI historian.';

CREATE OR REPLACE TABLE `power_and_utilities`.`generation`.`generation_outage_event` (
    `generation_outage_event_id` BIGINT COMMENT 'Unique identifier for the generation outage event record. Primary key for this entity.',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_event. Business justification: Forced outages trigger compliance events such as NERC GADS reporting, availability violations, or penalty assessments. Linking outages to compliance events enables tracking of regulatory consequences,',
    `generating_unit_id` BIGINT COMMENT 'Foreign key reference to the generating unit (power plant unit) that experienced the outage. Links to the generation asset master data.',
    `affected_system` STRING COMMENT 'Primary system or component of the generating unit that was affected by the outage (e.g., boiler, turbine, generator, condenser, cooling system, fuel handling, emissions control, electrical auxiliary).',
    `available_capacity_mw` DECIMAL(18,2) COMMENT 'Remaining generating capacity (in megawatts) available during a partial outage. Zero for full outages. Used to calculate net capacity impact and dispatch availability.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this outage event record was first created in the system. Used for audit trail and data lineage tracking.',
    `derated_capacity_mw` DECIMAL(18,2) COMMENT 'Amount of generating capacity (in megawatts) that was unavailable during the outage. For full outages, this equals the units nameplate capacity. For partial outages, this is the reduction in available capacity.',
    `efor_contribution_hours` DECIMAL(18,2) COMMENT 'Equivalent forced outage hours contributed by this event to the units Equivalent Forced Outage Rate (EFOR) calculation. Accounts for both full and partial forced outages weighted by capacity impact.',
    `environmental_incident_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the outage was associated with an environmental incident (e.g., emissions exceedance, spill, discharge violation). True if EPA or state environmental reporting is required.',
    `estimated_revenue_impact_usd` DECIMAL(18,2) COMMENT 'Estimated financial impact of the outage in US dollars, calculated based on lost generation and applicable market prices (LMP, PPA rates, or avoided cost). Used for financial reporting and outage cost-benefit analysis.',
    `extension_reason` STRING COMMENT 'Explanation for why a planned outage was extended beyond its scheduled duration (e.g., additional repairs discovered, parts delay, weather, contractor availability). Null if no extension occurred.',
    `fuel_type` STRING COMMENT 'Type of fuel or energy source used by the generating unit that experienced the outage. Used for fuel-specific reliability analysis and RPS compliance tracking. [ENUM-REF-CANDIDATE: coal|natural_gas|nuclear|hydro|wind|solar|oil|biomass|geothermal — 9 candidates stripped; promote to reference product]',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this outage event record was most recently modified. Used for audit trail and change tracking.',
    `lost_generation_mwh` DECIMAL(18,2) COMMENT 'Total energy generation lost due to the outage, measured in megawatt-hours. Calculated as derated capacity multiplied by outage duration. Used for revenue impact analysis and capacity factor calculations.',
    `maintenance_cost_usd` DECIMAL(18,2) COMMENT 'Total cost of maintenance or repair work performed during the outage in US dollars, including labor, materials, and contractor expenses. Sourced from work order cost actuals in Oracle WAM or IBM Maximo.',
    `nerc_gads_reportable_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this outage event must be reported to NERC under the Generating Availability Data System (GADS) reporting requirements. True for events meeting NERC reporting thresholds.',
    `nerc_gads_submission_date` DATE COMMENT 'Date when the outage event data was submitted to NERC GADS for regulatory compliance reporting. Null if not yet submitted or not reportable.',
    `outage_approval_date` DATE COMMENT 'Date when the planned outage was approved by management, operations, or the RTO/ISO outage coordination process. Null for forced outages.',
    `outage_cause_code` STRING COMMENT 'Standardized NERC GADS cause code identifying the root cause of the outage (e.g., boiler tube leak, turbine blade failure, transformer fault, fuel supply interruption). Required for NERC GADS submissions and reliability analysis.',
    `outage_cause_description` STRING COMMENT 'Detailed narrative description of the root cause and circumstances of the outage event. Provides context beyond the standardized cause code for engineering analysis and lessons learned.',
    `outage_coordinator` STRING COMMENT 'Name or identifier of the individual responsible for coordinating the outage event, including scheduling, RTO/ISO notification, work order management, and return-to-service activities.',
    `outage_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the outage event in hours, calculated as the difference between outage_start_timestamp and outage_end_timestamp. Used for SAIDI-equivalent generation reliability metrics and maintenance planning.',
    `outage_end_timestamp` TIMESTAMP COMMENT 'Date and time when the generating unit returned to service at full or partial capacity. Null if the outage is still ongoing. Used to calculate outage duration and availability metrics.',
    `outage_extension_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether a planned outage was extended beyond its originally scheduled end date. True if actual duration exceeded scheduled duration.',
    `outage_number` STRING COMMENT 'Business identifier for the outage event, typically assigned by the work management system (Oracle WAM or IBM Maximo) or EMS. Used for tracking and reporting purposes.',
    `outage_start_timestamp` TIMESTAMP COMMENT 'Date and time when the generating unit became unavailable or derated. Represents the moment the unit went offline or capacity was reduced. Critical for EFOR and availability calculations.',
    `outage_status` STRING COMMENT 'Current lifecycle status of the outage event. Active indicates the unit is currently offline. Completed means the unit has returned to service. Extended indicates a planned outage that exceeded its scheduled duration. Cancelled applies to planned outages that were aborted before execution.. Valid values are `active|completed|extended|cancelled`',
    `outage_type` STRING COMMENT 'Classification of the outage event. Planned outages are scheduled in advance for maintenance or upgrades. Forced outages are unplanned events due to equipment failure or external factors. Maintenance outages are routine preventive work. Extension indicates a planned outage that ran longer than scheduled. Startup failure occurs when a unit fails to start. Shutdown captures events where a unit is taken offline.. Valid values are `planned|forced|maintenance|extension|startup_failure|shutdown`',
    `puc_reportable_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this outage event must be reported to the state Public Utility Commission under state regulatory requirements. True for events meeting state reporting thresholds.',
    `replacement_power_cost_usd` DECIMAL(18,2) COMMENT 'Cost of purchasing replacement power from the wholesale market or other sources to cover the capacity shortfall during the outage. Used for total outage cost analysis.',
    `responsible_crew` STRING COMMENT 'Name or identifier of the maintenance crew, operations team, or contractor responsible for managing the outage and performing repair or maintenance work.',
    `return_to_service_timestamp` TIMESTAMP COMMENT 'Date and time when the unit was officially declared available for dispatch by the RTO/ISO or grid operator. May differ from outage_end_timestamp if testing or ramp-up is required.',
    `rto_iso_notification_method` STRING COMMENT 'Method used to notify the RTO/ISO of the outage event (phone call, email, EMS system integration, web portal submission, or automated system notification).. Valid values are `phone|email|ems_system|web_portal|automated`',
    `rto_iso_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the Regional Transmission Organization or Independent System Operator was notified of the outage. Required for compliance with RTO/ISO operating procedures and market rules.',
    `safety_incident_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the outage was associated with a safety incident (injury, near-miss, OSHA recordable event). True if OSHA reporting is required.',
    `scheduled_duration_hours` DECIMAL(18,2) COMMENT 'Originally planned duration of the outage in hours for planned or maintenance outages. Used to calculate schedule variance and extension impact. Null for forced outages.',
    `scheduled_end_date` DATE COMMENT 'Originally planned end date for planned or maintenance outages. Used to identify outage extensions and schedule variance. Null for forced outages.',
    `scheduled_start_date` DATE COMMENT 'Originally planned start date for planned or maintenance outages. Used to track schedule adherence and compare planned versus actual outage timing. Null for forced outages.',
    `source_system` STRING COMMENT 'Identifier of the operational system that originated this outage event record (Oracle WAM, IBM Maximo, ABB EMS, GE EMS, or manual entry). Used for data lineage and reconciliation.. Valid values are `oracle_wam|ibm_maximo|abb_ems|ge_ems|manual_entry`',
    `weather_related_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the outage was caused by or significantly influenced by weather conditions (e.g., extreme heat, cold, wind, lightning, ice). Used for climate resilience analysis.',
    `work_order_number` STRING COMMENT 'Work order identifier from the Enterprise Asset Management system (Oracle WAM or IBM Maximo) associated with the outage maintenance or repair activities. Links outage events to work management records.',
    CONSTRAINT pk_generation_outage_event PRIMARY KEY(`generation_outage_event_id`)
) COMMENT 'Planned and forced outage records for generating units, aligned with NERC GADS (Generating Availability Data System) reporting requirements. Captures outage type (planned, forced, maintenance, extension, startup failure, shutdown), outage cause code (NERC GADS cause code), outage start timestamp, return-to-service timestamp, derated capacity (MW), equivalent forced outage rate (EFOR) contribution, responsible crew, outage notification to RTO/ISO, and regulatory reporting flag. Also covers unit startup and shutdown events that result in capacity unavailability. Supports NERC GADS submissions, generation reliability metrics (EFOR, EAF, capacity factor impact), and maintenance planning. Sourced from Oracle WAM / IBM Maximo work management and ABB/GE EMS.';

CREATE OR REPLACE TABLE `power_and_utilities`.`generation`.`fuel_inventory` (
    `fuel_inventory_id` BIGINT COMMENT 'Unique identifier for the fuel inventory record. Primary key for the fuel inventory product.',
    `fuel_contract_id` BIGINT COMMENT 'Foreign key linking to generation.fuel_contract. Business justification: Fuel inventory records should be traceable to the fuel supply contract under which the fuel was delivered. This is essential for: (1) Cost reconciliation - matching inventory costs to contract pricing',
    `plant_id` BIGINT COMMENT 'Identifier of the generation facility (power plant) where the fuel is stored. Links to the generation facility master data.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Fuel storage at generation plants uses centralized warehouse management for inventory tracking, safety stock monitoring, and physical count reconciliation. Monthly fuel inventory reconciliation proces',
    `ash_content_percent` DECIMAL(18,2) COMMENT 'Percentage of ash by weight in the fuel (primarily applicable to coal and biomass). Affects combustion efficiency and waste disposal requirements.',
    `average_daily_consumption_rate` DECIMAL(18,2) COMMENT 'Average daily fuel consumption rate at the facility, measured in the same unit as quantity_on_hand. Used to calculate days of burn remaining and forecast fuel needs.',
    `batch_number` STRING COMMENT 'Batch or lot number assigned to the fuel shipment for traceability and quality control. Enables tracking of fuel quality issues back to specific deliveries.',
    `btu_content` DECIMAL(18,2) COMMENT 'Heat content of the fuel measured in BTU per unit (e.g., BTU per pound for coal, BTU per cubic foot for gas). Critical for heat rate calculations and energy output forecasting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fuel inventory record was first created in the system. Used for audit trail and data lineage tracking.',
    `days_of_burn_remaining` DECIMAL(18,2) COMMENT 'Estimated number of days the current fuel inventory will last at the current consumption rate. Calculated metric used for fuel procurement planning and supply chain risk management.',
    `economic_order_quantity` DECIMAL(18,2) COMMENT 'Optimal order quantity that minimizes total inventory holding costs and ordering costs. Used for fuel procurement optimization and cost management.',
    `enrichment_level_percent` DECIMAL(18,2) COMMENT 'Percentage of fissile isotope U-235 in nuclear fuel assemblies. Applicable only to nuclear fuel inventory. Critical for reactor physics and fuel cycle planning.',
    `environmental_permit_number` STRING COMMENT 'Permit number issued by EPA or state environmental agency authorizing the storage and use of the fuel type. Required for compliance with Clean Air Act and state environmental regulations.',
    `fac_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the fuel costs are eligible for recovery through the Fuel Adjustment Clause mechanism in customer rates. True indicates FAC-eligible, False indicates costs must be absorbed or recovered through base rates.',
    `fuel_grade` STRING COMMENT 'Grade or quality classification of the fuel (e.g., bituminous coal, sub-bituminous coal, pipeline-quality natural gas, enriched uranium U-235). Indicates fuel specification and quality tier.',
    `fuel_type` STRING COMMENT 'Type of fuel stored in inventory. Categorizes fuel by primary energy source used for thermal or nuclear generation.. Valid values are `coal|natural_gas|nuclear|oil|biomass|diesel`',
    `ghg_emissions_factor` DECIMAL(18,2) COMMENT 'Greenhouse gas emissions factor for the fuel type, measured in metric tons of CO2 equivalent per unit of fuel consumed. Used for GHG emissions reporting and carbon accounting under EPA regulations.',
    `inventory_date` DATE COMMENT 'Date when the inventory quantity was measured or recorded. Represents the as-of date for the inventory snapshot.',
    `inventory_status` STRING COMMENT 'Current status of the fuel inventory. Available indicates fuel ready for consumption, reserved indicates fuel allocated to specific generation schedule, in_transit indicates fuel en route to storage, quarantined indicates fuel held for quality testing, depleted indicates storage location is empty.. Valid values are `available|reserved|in_transit|quarantined|depleted`',
    `last_physical_count_date` DATE COMMENT 'Date when the last physical inventory count was performed at the storage location. Used for inventory reconciliation and audit compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the fuel inventory record was last modified. Used for change tracking and data freshness monitoring.',
    `maximum_storage_capacity` DECIMAL(18,2) COMMENT 'Maximum fuel quantity that can be physically stored at the location. Represents the storage facility design capacity in the same unit as quantity_on_hand.',
    `minimum_operating_reserve` DECIMAL(18,2) COMMENT 'Minimum fuel quantity that must be maintained to ensure continuous plant operations and meet reliability requirements. Measured in the same unit as quantity_on_hand.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Percentage of moisture by weight in the fuel. Impacts combustion efficiency, heat rate, and fuel handling characteristics.',
    `nitrogen_content_percent` DECIMAL(18,2) COMMENT 'Percentage of nitrogen by weight in the fuel. Relevant for NOx emissions calculations and environmental compliance.',
    `quality_certification_number` STRING COMMENT 'Certification or test report number from the laboratory that performed fuel quality analysis. Provides traceability to quality assurance documentation.',
    `quality_test_date` DATE COMMENT 'Date when the most recent fuel quality test was performed. Quality parameters such as BTU content, sulfur content, and ash content are validated through periodic testing.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current quantity of fuel in inventory at the storage location. Measured in the unit specified in unit_of_measure field.',
    `receipt_date` DATE COMMENT 'Date when the fuel was received at the storage location. Used for inventory aging analysis and FIFO/LIFO accounting methods.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level at which a new fuel order should be triggered to maintain adequate supply. Used for automated procurement planning and supply chain optimization.',
    `storage_pressure` DECIMAL(18,2) COMMENT 'Current pressure in the fuel storage container, measured in pounds per square inch (PSI). Applicable to natural gas storage holders and pressurized fuel systems.',
    `storage_temperature` DECIMAL(18,2) COMMENT 'Current temperature of the fuel storage location, measured in degrees Fahrenheit. Relevant for liquid fuels (oil, diesel) and nuclear fuel pool cooling monitoring.',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'Percentage of sulfur by weight in the fuel. Critical for SO2 emissions compliance and environmental permitting under Clean Air Act regulations.',
    `total_inventory_value` DECIMAL(18,2) COMMENT 'Total monetary value of the fuel inventory at the storage location, calculated as quantity_on_hand multiplied by unit_cost. Reported in USD for financial accounting and regulatory rate case filings.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of fuel in inventory, measured in USD per unit of measure. Used for inventory valuation and Fuel Adjustment Clause (FAC) cost tracking.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the fuel quantity. Tons for coal/biomass, MCF (Thousand Cubic Feet) or BCF (Billion Cubic Feet) for natural gas, barrels for oil, assemblies for nuclear fuel, MMBTU (Million British Thermal Units) for energy content.. Valid values are `tons|mcf|bcf|barrels|assemblies|mmbtu`',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between book inventory and physical count from the last inventory reconciliation. Positive values indicate overage, negative values indicate shortage. Measured in the same unit as quantity_on_hand.',
    CONSTRAINT pk_fuel_inventory PRIMARY KEY(`fuel_inventory_id`)
) COMMENT 'Fuel stock inventory records for thermal and nuclear generation facilities — coal tonnage, natural gas in storage (MCF/BCF), nuclear fuel assemblies (uranium enrichment batches), oil (barrels), and biomass. Tracks fuel type, storage location (coal pile, tank farm, gas holder), quantity on hand, unit of measure, inventory date, minimum operating reserve level, maximum storage capacity, fuel quality parameters (BTU content, sulfur content, ash content, moisture content), days of burn remaining at current consumption rate, and supplier contract reference. Supports fuel procurement planning, FAC (Fuel Adjustment Clause) cost tracking, burn forecast modeling, and environmental compliance (GHG, SO2, NOx). Sourced from SAP S/4HANA materials management and plant fuel management systems.';

CREATE OR REPLACE TABLE `power_and_utilities`.`generation`.`fuel_consumption` (
    `fuel_consumption_id` BIGINT COMMENT 'Unique identifier for each fuel consumption record. Primary key for the fuel consumption data product.',
    `fuel_contract_id` BIGINT COMMENT 'Foreign key reference to the fuel supply contract under which the fuel was purchased. Links to contract master data for cost allocation and contract performance tracking.',
    `generating_unit_id` BIGINT COMMENT 'Foreign key reference to the generating unit that consumed the fuel. Links to the generation asset master data.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Fuel costs must post to specific GL accounts (FERC account 501 for steam, 547 for gas) for financial statement preparation, monthly fuel expense accrual, and regulatory reporting. Direct posting relat',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Each fuel consumption event must trace to the goods receipt that brought that fuel batch into inventory for audit trail and quality tracking. Fuel quality issue root cause analysis requires tracing co',
    `plant_id` BIGINT COMMENT 'Foreign key reference to the power plant facility where fuel was consumed. Links to generation facility master data.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Fuel deliveries under long-term contracts require associated POs for invoice reconciliation and payment processing. Three-way match process (delivery ticket, PO, vendor invoice) is mandatory for fuel ',
    `vendor_id` BIGINT COMMENT 'Foreign key reference to the fuel supplier or vendor who delivered the fuel. Links to supply chain vendor master data for procurement tracking and contract management.',
    `ambient_temperature_f` DECIMAL(18,2) COMMENT 'The ambient air temperature at the power plant during the fuel consumption period, measured in degrees Fahrenheit. Affects unit efficiency and heat rate, particularly for combustion turbines and combined cycle units.',
    `cems_reconciliation_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this fuel consumption record has been reconciled with EPA CEMS (Continuous Emissions Monitoring System) emissions data. True indicates reconciliation is complete; False indicates pending reconciliation.',
    `ch4_emissions_factor` DECIMAL(18,2) COMMENT 'The methane emissions factor applied to the fuel type, expressed in pounds of CH4 per MMBTU of fuel consumed. Used to calculate total CH4 emissions for EPA GHG reporting and climate disclosure.',
    `co2_emissions_factor` DECIMAL(18,2) COMMENT 'The carbon dioxide emissions factor applied to the fuel type, expressed in pounds of CO2 per MMBTU of fuel consumed. Used to calculate total CO2 emissions for EPA GHG reporting and RPS compliance.',
    `comments` STRING COMMENT 'Free-text field for operational notes, exceptions, or explanations related to the fuel consumption record (e.g., unit startup, fuel quality issues, meter calibration, data corrections). Used for audit trail and operational analysis.',
    `consumption_date` DATE COMMENT 'The calendar date on which the fuel was consumed by the generating unit. Used for daily fuel tracking and reconciliation.',
    `consumption_timestamp` TIMESTAMP COMMENT 'Precise timestamp when the fuel consumption measurement was recorded, typically from SCADA or DCS systems. Supports real-time fuel monitoring and interval-level analysis.',
    `data_quality_code` STRING COMMENT 'Code indicating the quality and validation status of the fuel consumption record. Verified indicates the data has passed all validation checks; Estimated indicates the data was calculated or interpolated; Provisional indicates preliminary data subject to revision; Suspect indicates data that failed quality checks.. Valid values are `verified|estimated|provisional|suspect`',
    `data_source` STRING COMMENT 'The source system or method from which the fuel consumption data was captured (e.g., SCADA, DCS, manual entry, EMS, PI Historian). Used for data quality assessment and audit trail.. Valid values are `scada|dcs|manual_entry|ems|pi_historian`',
    `delivery_method` STRING COMMENT 'The transportation method used to deliver the fuel to the power plant (e.g., pipeline for natural gas, rail for coal, truck for oil). Used for logistics planning and transportation cost allocation.. Valid values are `pipeline|rail|truck|barge|ship|on_site`',
    `eia_reporting_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this fuel consumption record has been included in EIA Form 923 monthly fuel consumption reporting. True indicates the record has been reported; False indicates it has not yet been reported.',
    `fac_recovery_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the fuel costs associated with this consumption record are eligible for recovery through the Fuel Adjustment Clause (FAC) mechanism. True indicates eligible; False indicates not eligible (e.g., due to imprudence findings or contract limitations).',
    `fuel_cost_per_unit` DECIMAL(18,2) COMMENT 'The delivered cost of fuel per unit of measure (e.g., dollars per ton, dollars per MCF, dollars per barrel). Includes transportation and handling costs. Used for fuel cost allocation and FAC (Fuel Adjustment Clause) calculations.',
    `fuel_subtype` STRING COMMENT 'Detailed subclassification of fuel type (e.g., bituminous coal, sub-bituminous coal, anthracite, pipeline natural gas, LNG, No. 2 fuel oil, No. 6 fuel oil). Used for precise heat content and emissions factor application.',
    `fuel_type` STRING COMMENT 'The type of fuel consumed by the generating unit. Primary classification for fuel inventory management, cost allocation, and emissions reporting.. Valid values are `coal|natural_gas|nuclear|fuel_oil|diesel|biomass`',
    `generation_output_mwh` DECIMAL(18,2) COMMENT 'The gross electrical energy output produced by the generating unit during the fuel consumption period, measured in Megawatt-Hours (MWh). Used as the denominator in heat rate calculation.',
    `heat_content_per_unit` DECIMAL(18,2) COMMENT 'The average heat content (energy value) of the fuel per unit of measure, expressed in BTU per unit (e.g., BTU per ton, BTU per MCF, BTU per barrel). Used to convert physical fuel quantity to energy equivalent.',
    `heat_rate_btu_per_kwh` DECIMAL(18,2) COMMENT 'The thermal efficiency of the generating unit, calculated as total_heat_content_mmbtu × 1,000,000 ÷ (generation_output_mwh × 1,000). Expressed in BTU per kilowatt-hour. Lower heat rate indicates higher efficiency. Key performance metric for generation operations and IRP modeling.',
    `nox_emissions_factor` DECIMAL(18,2) COMMENT 'The nitrogen oxides emissions factor applied to the fuel type, expressed in pounds of NOx per MMBTU of fuel consumed. Used to calculate total NOx emissions for EPA Clean Air Act compliance and ozone transport region reporting.',
    `operating_mode` STRING COMMENT 'The operating mode of the generating unit during the fuel consumption period. Affects fuel efficiency and heat rate. Used for operational analysis and dispatch optimization.. Valid values are `baseload|cycling|peaking|startup|shutdown`',
    `quantity_consumed` DECIMAL(18,2) COMMENT 'The physical quantity of fuel consumed during the operating period, measured in the native unit of measure (tons for coal, MCF for gas, barrels for oil, pounds for nuclear fuel).',
    `quantity_unit` STRING COMMENT 'The unit of measure for the quantity consumed field. Varies by fuel type: tons for coal, MCF (thousand cubic feet) for natural gas, barrels for oil, pounds for nuclear fuel.. Valid values are `tons|mcf|barrels|pounds|gallons|mmbtu`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this fuel consumption record was first created in the system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this fuel consumption record was last modified in the system. Used for audit trail and change tracking.',
    `so2_emissions_factor` DECIMAL(18,2) COMMENT 'The sulfur dioxide emissions factor applied to the fuel type, expressed in pounds of SO2 per MMBTU of fuel consumed. Used to calculate total SO2 emissions for EPA Clean Air Act compliance and acid rain program reporting.',
    `total_co2_emissions_tons` DECIMAL(18,2) COMMENT 'The total carbon dioxide emissions produced from the fuel consumed, calculated as (total_heat_content_mmbtu × co2_emissions_factor) ÷ 2000. Expressed in short tons. Primary metric for EPA GHG reporting and carbon accounting.',
    `total_fuel_cost_usd` DECIMAL(18,2) COMMENT 'The total cost of fuel consumed during the operating period, expressed in US dollars. Calculated as quantity_consumed × fuel_cost_per_unit. Used for FAC cost recovery, rate case preparation, and financial reporting.',
    `total_heat_content_mmbtu` DECIMAL(18,2) COMMENT 'The total energy content of the fuel consumed, expressed in Million British Thermal Units (MMBTU). Calculated as quantity_consumed × heat_content_per_unit. Primary metric for heat rate calculation and fuel cost recovery.',
    `total_nox_emissions_tons` DECIMAL(18,2) COMMENT 'The total nitrogen oxides emissions produced from the fuel consumed, calculated as (total_heat_content_mmbtu × nox_emissions_factor) ÷ 2000. Expressed in short tons. Used for EPA Clean Air Act compliance and ozone transport region reporting.',
    `total_so2_emissions_tons` DECIMAL(18,2) COMMENT 'The total sulfur dioxide emissions produced from the fuel consumed, calculated as (total_heat_content_mmbtu × so2_emissions_factor) ÷ 2000. Expressed in short tons. Used for EPA Clean Air Act compliance and acid rain program reporting.',
    CONSTRAINT pk_fuel_consumption PRIMARY KEY(`fuel_consumption_id`)
) COMMENT 'Actual fuel consumed per generating unit per operating period, used for heat rate calculation, FAC cost recovery, and EPA emissions reporting. Records consumption date, fuel type, quantity consumed (MMBTU, MCF, tons, barrels), heat content (BTU/unit), cost per unit, total fuel cost ($), associated generation output (MWh), calculated heat rate (BTU/kWh), and emissions factors applied (CO2, SO2, NOx, CH4 lbs/MMBTU). Supports EIA Form 923 monthly fuel consumption reporting, EPA CEMS reconciliation, and IRP fuel cost modeling. Sourced from plant DCS/SCADA and SAP S/4HANA.';

CREATE OR REPLACE TABLE `power_and_utilities`.`generation`.`emissions_record` (
    `emissions_record_id` BIGINT COMMENT 'Primary key for emissions_record',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Emissions compliance costs (allowance purchases, penalties, monitoring equipment) are allocated to plant cost centers for environmental cost tracking and regulatory cost recovery in rate cases. Requir',
    `generating_unit_id` BIGINT COMMENT 'Foreign key reference to the generating unit that produced these emissions. Links to the generation asset master data.',
    `plant_id` BIGINT COMMENT 'Foreign key reference to the power generation facility where the emissions occurred. Links to the facility master data.',
    `allowance_account_number` STRING COMMENT 'The EPA allowance tracking system account number from which allowances were retired to cover these emissions. Used for compliance reconciliation.',
    `allowance_consumption` DECIMAL(18,2) COMMENT 'The number of emissions allowances consumed or required for this emissions record under cap-and-trade programs such as the EPA Acid Rain Program or state-level programs. One allowance typically equals one ton of SO2 or NOx.',
    `ambient_temperature_f` DECIMAL(18,2) COMMENT 'The ambient air temperature during the reporting period in degrees Fahrenheit. Affects unit efficiency and emissions characteristics.',
    `carbon_content_percent` DECIMAL(18,2) COMMENT 'The carbon content of the fuel as a percentage by weight. Used in mass balance calculations for CO2 emissions when CEMS is unavailable.',
    `carbon_cost_total` DECIMAL(18,2) COMMENT 'The total carbon cost for this emissions record, calculated as emission quantity multiplied by carbon price. Used for financial reporting and cost allocation.',
    `carbon_price_per_ton` DECIMAL(18,2) COMMENT 'The carbon price applied to CO2 emissions for this record, expressed in dollars per ton. Used for carbon accounting, internal carbon pricing, and compliance with carbon pricing programs.',
    `cems_monitor_status` STRING COMMENT 'The operational status of the CEMS monitor during the reporting period. Operational indicates normal functioning. Out of service, calibration, maintenance, and failed QA indicate periods when direct measurement was unavailable and substitute data may have been used.. Valid values are `operational|out_of_service|calibration|maintenance|failed_qa`',
    `comments` STRING COMMENT 'Free-text field for additional notes, explanations, or context regarding this emissions record. May include information about unusual operating conditions, equipment issues, or data quality concerns.',
    `control_efficiency_percent` DECIMAL(18,2) COMMENT 'The removal efficiency of emissions control equipment during the reporting period, expressed as a percentage. For example, a scrubber with 95% efficiency removes 95% of SO2 from flue gas.',
    `control_equipment_status` STRING COMMENT 'The operational status of emissions control equipment (scrubbers, SCR, baghouses, etc.) during the reporting period. Bypassed or out-of-service status may result in higher emissions.. Valid values are `operational|bypassed|out_of_service|maintenance`',
    `data_quality_score` DECIMAL(18,2) COMMENT 'A calculated score representing the overall quality and reliability of this emissions record, typically ranging from 0 to 100. Factors include measurement method, CEMS status, QA test results, and data completeness.',
    `data_source_system` STRING COMMENT 'The source system from which this emissions record was extracted. Typically OSIsoft PI historian for CEMS data or plant DCS (Distributed Control System) for calculated emissions.',
    `data_substitution_flag` BOOLEAN COMMENT 'Boolean flag indicating whether substitute data was used for this emissions record due to CEMS monitor unavailability. True indicates substitute data was used; False indicates actual measured or calculated data.',
    `ecmps_submission_date` DATE COMMENT 'The date this emissions record was submitted to EPA ECMPS for regulatory compliance reporting. Quarterly submissions are typically required within 30 days of quarter end.',
    `ecmps_submission_status` STRING COMMENT 'The status of this emissions record in the EPA ECMPS reporting system. Tracks the lifecycle from pending submission through acceptance or rejection by EPA.. Valid values are `pending|submitted|accepted|rejected|resubmitted`',
    `ecmps_tracking_number` STRING COMMENT 'The unique tracking number assigned by EPA ECMPS upon submission. Used to track the status and history of the regulatory filing.',
    `emission_quantity_tons` DECIMAL(18,2) COMMENT 'The total quantity of pollutant emitted during the reporting period, measured in short tons. This is the primary emissions metric reported to EPA ECMPS.',
    `emission_rate_lbs_per_mmbtu` DECIMAL(18,2) COMMENT 'The emission rate expressed as pounds of pollutant per million British Thermal Units (MMBTU) of heat input. This normalized rate allows comparison across units of different sizes and fuel types.',
    `fuel_consumption_quantity` DECIMAL(18,2) COMMENT 'The quantity of fuel consumed during the reporting period. Units vary by fuel type: tons for coal, MCF (Thousand Cubic Feet) for natural gas, barrels for oil.',
    `fuel_consumption_unit` STRING COMMENT 'The unit of measure for fuel consumption quantity. Common units include tons (coal), MCF or Thousand Cubic Feet (natural gas), barrels (oil), or MMBTU (heat content).. Valid values are `tons|mcf|barrels|mmbtu`',
    `fuel_type` STRING COMMENT 'The primary fuel type consumed by the generating unit during this reporting period. Fuel type significantly impacts emission factors and pollutant profiles. [ENUM-REF-CANDIDATE: coal|natural_gas|oil|biomass|nuclear|hydro|wind|solar — 8 candidates stripped; promote to reference product]',
    `ghg_inventory_category` STRING COMMENT 'The GHG inventory category for this emissions record under EPA GHG reporting and corporate carbon accounting frameworks. Stationary combustion is the primary category for power generation.. Valid values are `stationary_combustion|process_emissions|fugitive_emissions`',
    `gross_generation_mwh` DECIMAL(18,2) COMMENT 'The total gross electrical energy generated by the unit during the reporting period, measured in Megawatt-Hours (MWh). Used to calculate emission intensity per unit of generation.',
    `heat_input_mmbtu` DECIMAL(18,2) COMMENT 'The total heat input to the generating unit during the reporting period, measured in Million British Thermal Units (MMBTU). Used to calculate emission rates and heat rate efficiency.',
    `measurement_method` STRING COMMENT 'The method used to determine emissions quantity. CEMS indicates Continuous Emissions Monitoring System direct measurement. Fuel factor uses fuel consumption and emission factors. Mass balance calculates emissions from material inputs and outputs. Engineering estimate and default factor are used when direct measurement is unavailable. Substitute indicates data substitution during monitor downtime.. Valid values are `CEMS|fuel_factor|mass_balance|engineering_estimate|default_factor|substitute`',
    `operating_hours` DECIMAL(18,2) COMMENT 'The number of hours the generating unit was in operation during the reporting period. Used for availability calculations and emissions rate normalization.',
    `pollutant_concentration_ppm` DECIMAL(18,2) COMMENT 'The concentration of the pollutant in the flue gas as measured by CEMS, expressed in parts per million (ppm) or parts per billion (ppb) for mercury. Combined with stack flow rate to calculate mass emissions.',
    `pollutant_type` STRING COMMENT 'The type of pollutant emitted. Standard pollutants tracked include Carbon Dioxide (CO2), Sulfur Dioxide (SO2), Nitrogen Oxides (NOx), Mercury (Hg), Particulate Matter 2.5 microns (PM2.5), and Methane (CH4).. Valid values are `CO2|SO2|NOx|Hg|PM2.5|CH4`',
    `qa_certification_date` DATE COMMENT 'The date of the most recent CEMS quality assurance certification test. EPA requires periodic QA testing to ensure monitor accuracy.',
    `qa_test_result` STRING COMMENT 'The result of the most recent CEMS quality assurance test. Passed indicates the monitor meets EPA accuracy requirements. Failed or conditional results may require corrective action and data substitution.. Valid values are `passed|failed|conditional`',
    `rec_eligible_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the generation associated with this emissions record is eligible to generate Renewable Energy Certificates (RECs). Typically true for renewable generation with zero emissions.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this emissions record was first created in the data management system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this emissions record was last updated in the data management system. Used for audit trail and change tracking.',
    `reporting_period_end` TIMESTAMP COMMENT 'The end date and time of the emissions reporting period. Defines the boundary of the measurement interval.',
    `reporting_period_start` TIMESTAMP COMMENT 'The start date and time of the emissions reporting period. Typically hourly for CEMS data, but may be daily or monthly for aggregated reporting.',
    `rps_compliance_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this generation and its associated emissions are eligible for Renewable Portfolio Standard (RPS) compliance credit. True for renewable generation with zero or low emissions.',
    `stack_flow_rate_scfh` DECIMAL(18,2) COMMENT 'The volumetric flow rate of flue gas through the stack during the reporting period, measured in Standard Cubic Feet per Hour (SCFH). Used in CEMS calculations to convert pollutant concentration to mass emissions.',
    `substitution_method` STRING COMMENT 'The specific method used to substitute emissions data when CEMS was unavailable. Methods include maximum potential emissions, fuel-specific default factors, load-based estimation, or EPA-approved missing data procedures.. Valid values are `maximum_potential|fuel_specific_default|load_based|missing_data_procedure`',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'The sulfur content of the fuel as a percentage by weight. Used to estimate SO2 emissions when CEMS is unavailable and to verify CEMS accuracy.',
    CONSTRAINT pk_emissions_record PRIMARY KEY(`emissions_record_id`)
) COMMENT 'Continuous emissions monitoring (CEMS) and calculated emissions data per generating unit per reporting period, required for EPA compliance under Clean Air Act Title IV and Title V. Captures pollutant type (CO2, SO2, NOx, Hg, PM2.5, CH4), measurement method (CEMS, fuel-factor, mass balance), hourly/daily/monthly emission quantity (tons), emission rate (lbs/MMBTU), allowance consumption, CEMS monitor status, data substitution flag, and EPA ECMPS submission status. Supports EPA ECMPS reporting, GHG inventory, RPS compliance, and carbon accounting. Sourced from plant CEMS and OSIsoft PI.';

CREATE OR REPLACE TABLE `power_and_utilities`.`generation`.`capacity_resource` (
    `capacity_resource_id` BIGINT COMMENT 'Unique identifier for the capacity resource registration record in the RTO/ISO capacity market.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Capacity market participation and resource accreditation often require state regulatory approval through dockets, particularly for cost recovery of capacity revenues or obligations. Tracking the appro',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Capacity market participation often requires capital upgrades (performance improvements, winterization) tracked as projects for rate base inclusion and cost recovery. Links capacity revenue to enablin',
    `generating_unit_id` BIGINT COMMENT 'Reference to the physical generating unit or aggregated resource participating in the capacity market.',
    `ppa_contract_id` BIGINT COMMENT 'Reference to the associated power purchase agreement (PPA) contract if the capacity resource is tied to a bilateral capacity contract.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Capacity resources must specify delivery points for capacity market participation and deliverability studies. Required for PJM/NYISO/ISO-NE capacity auctions, FERC Form 1 reporting, and resource adequ',
    `accreditation_period_end_date` DATE COMMENT 'The end date of the accreditation period during which the resource is qualified to provide capacity.',
    `accreditation_period_start_date` DATE COMMENT 'The start date of the accreditation period during which the resource is qualified to provide capacity.',
    `accredited_capacity_mw` DECIMAL(18,2) COMMENT 'The accredited capacity value in megawatts (MW) that the resource is qualified to provide based on RTO/ISO testing and performance criteria.',
    `auction_clearing_price_per_mw_day` DECIMAL(18,2) COMMENT 'The capacity auction clearing price in dollars per megawatt-day ($/MW-day) at which this resource cleared in the capacity market auction.',
    `bonus_payment_eligible_flag` BOOLEAN COMMENT 'Indicates whether the resource is eligible for bonus payments for over-performance during capacity performance events (True/False).',
    `capacity_commitment_period_end_date` DATE COMMENT 'The end date of the capacity commitment period during which the resource must be available to deliver committed capacity.',
    `capacity_commitment_period_start_date` DATE COMMENT 'The start date of the capacity commitment period during which the resource must be available to deliver committed capacity.',
    `capacity_interconnection_rights_flag` BOOLEAN COMMENT 'Indicates whether the resource has secured capacity interconnection rights (CIR) or capacity network resource interconnection service (CNRIS) (True/False).',
    `capacity_market_product_type` STRING COMMENT 'Type of capacity product offered in the RTO/ISO market (e.g., base capacity, capacity performance, must-offer obligation).. Valid values are `base_capacity|capacity_performance|must_offer|seasonal_capacity|annual_capacity|flexible_capacity`',
    `capacity_revenue_amount` DECIMAL(18,2) COMMENT 'The total capacity market revenue amount in dollars earned by this resource for the planning year based on cleared capacity and auction price.',
    `capacity_transfer_rights_flag` BOOLEAN COMMENT 'Indicates whether the resource has capacity transfer rights allowing capacity to be sold or transferred to other zones (True/False).',
    `capacity_zone` STRING COMMENT 'The RTO/ISO capacity zone or locational deliverability area (LDA) where the resource is located and registered.',
    `demand_response_resource_flag` BOOLEAN COMMENT 'Indicates whether the capacity resource is a demand response (DR) resource rather than a generation asset (True/False).',
    `energy_storage_resource_flag` BOOLEAN COMMENT 'Indicates whether the capacity resource is an energy storage system (e.g., battery, pumped hydro) participating in the capacity market (True/False).',
    `equivalent_forced_outage_rate_eford` DECIMAL(18,2) COMMENT 'The equivalent forced outage rate on demand (EFORd) expressed as a decimal, used to calculate UCAP from ICAP.',
    `installed_capacity_icap_mw` DECIMAL(18,2) COMMENT 'The installed capacity (ICAP) rating in megawatts representing the maximum nameplate capacity of the resource.',
    `last_accreditation_test_date` DATE COMMENT 'The date of the most recent accreditation test or performance verification conducted by the RTO/ISO to validate the resources capacity rating.',
    `must_offer_obligation_flag` BOOLEAN COMMENT 'Indicates whether the resource has a must-offer obligation requiring it to bid into energy and ancillary service markets (True/False).',
    `next_accreditation_test_date` DATE COMMENT 'The scheduled date for the next accreditation test or performance verification required by the RTO/ISO.',
    `non_performance_charge_rate` DECIMAL(18,2) COMMENT 'The penalty charge rate in dollars per megawatt-hour ($/MWh) applied when the resource fails to deliver committed capacity during performance assessment intervals.',
    `performance_obligation_mw` DECIMAL(18,2) COMMENT 'The committed capacity performance obligation in megawatts that the resource must deliver during capacity performance events or face penalties.',
    `planning_year` STRING COMMENT 'The capacity market planning year or delivery year for which this resource is registered (e.g., 2024/2025).',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when this capacity resource record was first created in the data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this capacity resource record was last updated in the data platform.',
    `registration_date` DATE COMMENT 'The date when the capacity resource was initially registered with the RTO/ISO for capacity market participation.',
    `registration_status` STRING COMMENT 'Current lifecycle status of the capacity resource registration with the RTO/ISO.. Valid values are `active|pending|suspended|withdrawn|expired|terminated`',
    `renewable_resource_flag` BOOLEAN COMMENT 'Indicates whether the capacity resource is a renewable energy resource (wind, solar, hydro, biomass) (True/False).',
    `resource_adequacy_status` STRING COMMENT 'The resource adequacy qualification status indicating whether the resource meets RTO/ISO reliability and performance standards.. Valid values are `qualified|conditionally_qualified|not_qualified|under_review`',
    `resource_registration_number` STRING COMMENT 'External registration identifier assigned by the RTO/ISO for this capacity resource (e.g., PJM resource ID, MISO planning resource ID).',
    `rto_iso_name` STRING COMMENT 'The name of the RTO or ISO administering the capacity market in which this resource participates. [ENUM-REF-CANDIDATE: PJM|MISO|SPP|CAISO|NYISO|ISO_NE|ERCOT — 7 candidates stripped; promote to reference product]',
    `seasonal_capacity_flag` BOOLEAN COMMENT 'Indicates whether the resource is registered as a seasonal capacity resource with different capacity values for summer and winter periods (True/False).',
    `source_system` STRING COMMENT 'The operational system of record from which this capacity resource registration data was sourced (e.g., ABB EMS, GE EMS, RTO market portal).',
    `unforced_capacity_ucap_mw` DECIMAL(18,2) COMMENT 'The unforced capacity (UCAP) value in megawatts, calculated as ICAP adjusted for the resources equivalent forced outage rate (EFORd).',
    CONSTRAINT pk_capacity_resource PRIMARY KEY(`capacity_resource_id`)
) COMMENT 'Capacity resource registration and accreditation records for each generating unit participating in RTO/ISO capacity markets (e.g., PJM Capacity Performance, MISO Planning Resource Auction, SPP, CAISO RA). Captures resource ID, accredited capacity (MW), unforced capacity (UCAP), installed capacity (ICAP), capacity zone, performance obligation (MW), capacity market product type (base capacity, capacity performance, must-offer), accreditation period (planning year), RTO/ISO registration status, capacity auction clearing price ($/MW-day), non-performance charge rate, and bonus payment eligibility. Supports IRP capacity planning, RTO capacity market revenue tracking, capacity performance penalty/bonus accounting, and FERC Order 841 compliance. Sourced from ABB/GE EMS and RTO market portals.';

CREATE OR REPLACE TABLE `power_and_utilities`.`generation`.`fuel_contract` (
    `fuel_contract_id` BIGINT COMMENT 'Unique identifier for the fuel supply contract record. Primary key for the fuel contract entity.',
    `plant_id` BIGINT COMMENT 'Identifier of the generation facility where fuel is to be delivered. Plant-specific delivery terms are critical for transportation cost allocation and logistics planning.',
    `vendor_id` BIGINT COMMENT 'Identifier for the fuel supplier party providing coal, natural gas, nuclear fuel, or oil under this contract.',
    `prudency_review_id` BIGINT COMMENT 'Foreign key linking to regulatory.prudency_review. Business justification: Fuel procurement contracts are subject to prudency review to determine if costs are reasonable and recoverable through rates. Linking contracts to their prudency reviews supports fuel adjustment claus',
    `wholesale_counterparty_id` BIGINT COMMENT 'Foreign key linking to market.wholesale_counterparty. Business justification: Fuel contracts with wholesale market participants require tracking counterparty credit ratings, FERC market-based rate authorizations, master agreements, and collateral requirements for bilateral trad',
    `ash_content_limit_percent` DECIMAL(18,2) COMMENT 'Maximum allowable ash content as a percentage of fuel weight. High ash content reduces combustion efficiency and increases disposal costs. Primarily applicable to coal contracts.',
    `base_price` DECIMAL(18,2) COMMENT 'Base price per unit of fuel under this contract. For fixed-price contracts, this is the contract price. For index or escalation contracts, this is the starting reference price. Currency is USD unless otherwise specified.',
    `btu_content_specification` DECIMAL(18,2) COMMENT 'Contractually specified heat content of the fuel in British Thermal Units per unit (e.g., BTU per pound for coal, BTU per cubic foot for gas). Critical for heat rate calculations and fuel quality compliance.',
    `contract_amendment_count` STRING COMMENT 'Number of formal amendments made to the original contract. Tracks contract change history for audit and compliance purposes.',
    `contract_name` STRING COMMENT 'Descriptive name of the fuel supply contract for business reference and reporting purposes.',
    `contract_number` STRING COMMENT 'Externally-known business identifier for the fuel supply contract. Used in procurement documentation, regulatory filings, and supplier communications.',
    `contract_owner_employee_code` BIGINT COMMENT 'Identifier of the utility employee responsible for managing this fuel supply contract. Typically a fuel procurement manager or supply chain analyst.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the fuel supply contract. Active contracts are in force; expired contracts have passed their end date; terminated contracts were ended early.. Valid values are `draft|active|suspended|expired|terminated|amended`',
    `contract_type` STRING COMMENT 'Classification of the fuel supply agreement based on delivery commitment and flexibility. Firm contracts guarantee supply; interruptible contracts allow curtailment; spot contracts are short-term market purchases.. Valid values are `firm|interruptible|spot|swing|baseload|peaking`',
    `contract_value_total` DECIMAL(18,2) COMMENT 'Total estimated monetary value of the fuel contract over its full term, calculated as contracted volume multiplied by base price. Used for CAPEX/OPEX planning and regulatory rate case cost studies. Currency is USD.',
    `contracted_volume` DECIMAL(18,2) COMMENT 'Total quantity of fuel committed under this contract for the specified period. Units vary by fuel type: tons for coal, MCF or MMBTU for natural gas, assemblies for nuclear fuel, barrels for oil.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel contract record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contract pricing and payments. Predominantly USD for U.S. utilities.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `delivery_period` STRING COMMENT 'Frequency or time period over which the contracted volume is to be delivered. Supports burn forecast modeling and inventory planning.. Valid values are `daily|monthly|quarterly|annual|as_needed`',
    `delivery_point_description` STRING COMMENT 'Textual description of the fuel delivery location, including plant name, receiving facility, or pipeline interconnection point.',
    `effective_end_date` DATE COMMENT 'Date when the fuel supply contract expires or terminates. Nullable for evergreen contracts. Critical for supply chain risk management and contract renewal planning.',
    `effective_start_date` DATE COMMENT 'Date when the fuel supply contract becomes binding and deliveries may commence. Used for contract lifecycle management and fuel procurement planning.',
    `force_majeure_provision_flag` BOOLEAN COMMENT 'Indicates whether the contract includes force majeure clauses allowing suspension of obligations due to unforeseeable circumstances (natural disasters, strikes, regulatory changes).',
    `fuel_type` STRING COMMENT 'Type of fuel covered by this supply contract. Determines applicable quality specifications, transportation modes, and regulatory compliance requirements.. Valid values are `coal|natural_gas|nuclear_fuel|oil|biomass|other`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment. Null if no amendments have been made.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this fuel contract record was most recently modified. Used for change tracking and audit purposes.',
    `minimum_take_obligation` DECIMAL(18,2) COMMENT 'Minimum quantity of fuel the utility is obligated to purchase during the contract period, regardless of actual need. Used for supply commitment analysis and FAC cost recovery.',
    `minimum_take_unit_of_measure` STRING COMMENT 'Unit of measure for the minimum take obligation quantity.. Valid values are `tons|mcf|mmbtu|barrels|assemblies`',
    `moisture_content_limit_percent` DECIMAL(18,2) COMMENT 'Maximum allowable moisture content as a percentage of fuel weight. Excess moisture reduces heat content and combustion efficiency. Primarily applicable to coal and biomass contracts.',
    `payment_terms_days` STRING COMMENT 'Number of days from invoice date within which payment is due to the supplier. Standard terms are Net 30, Net 60, etc.',
    `price_index_reference` STRING COMMENT 'Name of the published market index used for index-based pricing (e.g., Henry Hub, NYMEX, Platts Coal Index). Null for fixed-price contracts.',
    `price_unit_of_measure` STRING COMMENT 'Unit of measure for the fuel price. Must align with volume unit of measure for cost calculations.. Valid values are `usd_per_ton|usd_per_mcf|usd_per_mmbtu|usd_per_barrel|usd_per_assembly`',
    `pricing_mechanism` STRING COMMENT 'Method by which fuel price is determined. Fixed = constant price; index = tied to published market index (e.g., Henry Hub for gas); cost-plus = supplier cost plus markup; escalation = base price with periodic adjustments.. Valid values are `fixed|index|cost_plus|market_based|escalation`',
    `regulatory_approval_date` DATE COMMENT 'Date when the contract received regulatory approval from the PUC or FERC. Null if approval is not required or not yet granted.',
    `regulatory_approval_required_flag` BOOLEAN COMMENT 'Indicates whether this fuel contract requires Public Utility Commission (PUC) or FERC approval before execution. Large or long-term contracts often require regulatory review.',
    `renewable_fuel_flag` BOOLEAN COMMENT 'Indicates whether the fuel qualifies as renewable under state Renewable Portfolio Standard (RPS) regulations. Applicable to biomass, biogas, and renewable natural gas contracts.',
    `rps_eligible_flag` BOOLEAN COMMENT 'Indicates whether fuel deliveries under this contract are eligible for Renewable Portfolio Standard (RPS) compliance credit. Supports RPS tracking and Renewable Energy Certificate (REC) generation.',
    `sulfur_content_limit_percent` DECIMAL(18,2) COMMENT 'Maximum allowable sulfur content as a percentage of fuel weight. Enforced to meet EPA emissions standards and state air quality regulations. Primarily applicable to coal and oil contracts.',
    `transportation_arrangement` STRING COMMENT 'Mode and responsibility for transporting fuel from supplier to delivery point. Pipeline (natural gas), rail/barge/truck (coal, oil). Supplier-arranged = supplier bears transportation cost and risk; utility-arranged = utility contracts transportation separately.. Valid values are `pipeline|rail|barge|truck|supplier_arranged|utility_arranged`',
    `transportation_cost_responsibility` STRING COMMENT 'Party responsible for bearing fuel transportation costs. Impacts delivered fuel cost and FAC cost recovery calculations.. Valid values are `supplier|utility|shared`',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for the contracted fuel volume. MCF = Thousand Cubic Feet (gas), MMBTU = Million British Thermal Units (energy content), assemblies (nuclear fuel). [ENUM-REF-CANDIDATE: tons|mcf|mmbtu|barrels|assemblies|kg|mwh_thermal — 7 candidates stripped; promote to reference product]',
    CONSTRAINT pk_fuel_contract PRIMARY KEY(`fuel_contract_id`)
) COMMENT 'Fuel supply contract master records for coal, natural gas, nuclear fuel, and oil procurement agreements with fuel suppliers. Captures supplier name, fuel type, contract type (firm, interruptible, spot), contracted volume (tons/MCF/MMBTU per period), delivery point (plant-specific), pricing mechanism (fixed, index, cost-plus), contract start/end date, minimum take obligation, force majeure provisions, fuel quality specifications (BTU content, sulfur limit, ash limit), transportation arrangement (pipeline, rail, barge), and contract status. This product is the generation domains SSOT for fuel procurement terms — distinct from the supply domains general vendor contracts, which cover non-fuel materials and services. Supports FAC fuel cost recovery filings, fuel procurement planning, burn forecast modeling, and supply chain risk management. Sourced from SAP S/4HANA contract management.';

CREATE OR REPLACE TABLE `power_and_utilities`.`generation`.`environmental_permit` (
    `environmental_permit_id` BIGINT COMMENT 'Unique identifier for the environmental permit record. Primary key for the environmental permit entity.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Environmental compliance projects (scrubbers, SCR/SNCR, wastewater treatment) are major capital investments requiring project tracking for CWIP, AFUDC calculation, and rate base inclusion. Essential f',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Environmental permits are issued, modified, or renewed through regulatory dockets. Permit approval orders reference specific docket numbers. Utilities must track which docket authorized each permit fo',
    `generating_unit_id` BIGINT COMMENT 'Reference to the generating unit covered by this environmental permit. Links permit to specific generation asset.',
    `plant_id` BIGINT COMMENT 'Reference to the generation facility holding this environmental permit. Links permit to facility-level compliance tracking.',
    `renewed_environmental_permit_id` BIGINT COMMENT 'Self-referencing FK on environmental_permit (renewed_environmental_permit_id)',
    `compliance_status` STRING COMMENT 'Current compliance status of the facility with respect to this environmental permit. Indicates whether the facility is operating within permitted limits and conditions.. Valid values are `compliant|non_compliant|conditional_compliance|under_investigation`',
    `contact_email` STRING COMMENT 'Primary email address for permit-related communications with the regulatory authority. Business contact information for the facility environmental compliance office.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for permit-related communications with the regulatory authority. Business contact information for the facility environmental compliance office.',
    `control_efficiency_required_percent` DECIMAL(18,2) COMMENT 'Minimum required control efficiency percentage for pollution control equipment as specified in the permit. Represents the percentage reduction in pollutant concentration that must be achieved.',
    `control_equipment_required` STRING COMMENT 'Description of pollution control equipment or technologies required by the permit to achieve compliance with emission or discharge limits. May include scrubbers, baghouses, electrostatic precipitators, cooling towers, or wastewater treatment systems.',
    `cooling_water_intake_limit_mgd` DECIMAL(18,2) COMMENT 'Maximum allowable cooling water intake flow rate in million gallons per day as specified under Clean Water Act Section 316(b) requirements. Regulates intake structure impacts on aquatic organisms.',
    `data_source_system` STRING COMMENT 'Name of the source system from which this permit record was extracted. May include state DEQ permit databases, EPA ECHO database, or internal environmental compliance management systems.',
    `effective_date` DATE COMMENT 'Date on which the environmental permit becomes legally binding and enforceable. May differ from issuance date if permit includes a delayed effective date.',
    `emission_limit_tons_per_year` DECIMAL(18,2) COMMENT 'Maximum allowable emission quantity in tons per year for the regulated pollutant as specified in the air permit. Applies to Title V and PSD air permits.',
    `emission_rate_limit_lbs_per_mmbtu` DECIMAL(18,2) COMMENT 'Maximum allowable emission rate in pounds per million BTU of heat input for the regulated pollutant. Common metric for fossil fuel combustion sources.',
    `enforcement_action_flag` BOOLEAN COMMENT 'Indicates whether this permit is currently subject to regulatory enforcement action such as notice of violation, consent decree, or administrative order.',
    `expiration_date` DATE COMMENT 'Date on which the environmental permit authorization expires and renewal is required. Critical for compliance tracking and renewal planning.',
    `hazardous_waste_quantity_limit_tons_per_month` DECIMAL(18,2) COMMENT 'Maximum allowable quantity of hazardous waste that may be generated or stored per month under the RCRA permit. Applies to facilities with hazardous waste generation or treatment operations.',
    `issuance_date` DATE COMMENT 'Date on which the environmental permit was officially issued by the regulatory authority. Marks the beginning of the permit authorization period.',
    `issuing_agency` STRING COMMENT 'Name of the regulatory authority that issued the environmental permit. May be EPA, state Department of Environmental Quality (DEQ), or other environmental regulatory body with jurisdiction over the facility.',
    `issuing_agency_code` STRING COMMENT 'Standardized code identifying the regulatory agency that issued the permit. Enables consistent tracking across multiple jurisdictions.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory inspection conducted by the issuing agency to verify permit compliance. Supports audit readiness and compliance tracking.',
    `last_inspection_result` STRING COMMENT 'Outcome of the most recent regulatory inspection. Indicates whether the facility was found in compliance or if violations were identified.. Valid values are `compliant|non_compliant|minor_violation|major_violation|no_findings`',
    `last_violation_date` DATE COMMENT 'Date of the most recent permit violation or non-compliance event. Critical for tracking compliance history and enforcement actions.',
    `monitoring_frequency` STRING COMMENT 'Required frequency of compliance monitoring and reporting as specified in the permit. Determines how often emissions, discharges, or waste parameters must be measured and reported. [ENUM-REF-CANDIDATE: continuous|hourly|daily|weekly|monthly|quarterly|annual — 7 candidates stripped; promote to reference product]',
    `penalty_amount_usd` DECIMAL(18,2) COMMENT 'Total monetary penalties assessed for permit violations in US dollars. Includes civil penalties, fines, and settlement amounts related to this permit.',
    `permit_conditions` STRING COMMENT 'Detailed text of special conditions, operational restrictions, monitoring requirements, and compliance stipulations imposed by the regulatory authority as part of the permit authorization.',
    `permit_fee_amount_usd` DECIMAL(18,2) COMMENT 'Annual or one-time permit fee paid to the regulatory authority in US dollars. Title V permits typically require annual fees based on actual emissions.',
    `permit_name` STRING COMMENT 'Descriptive name or title of the environmental permit as documented in the permit authorization.',
    `permit_number` STRING COMMENT 'Official permit number assigned by the issuing regulatory agency. Serves as the externally-recognized identifier for this authorization.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the environmental permit. Indicates whether the permit is active and in compliance, expired and requiring renewal, pending regulatory review, suspended due to violations, or revoked by the issuing authority.. Valid values are `active|expired|pending_renewal|suspended|revoked|under_review`',
    `permit_type` STRING COMMENT 'Classification of the environmental permit by regulatory program. Categorizes the permit into major environmental compliance frameworks such as Title V air operating permits, NPDES water discharge permits, PSD construction permits, state air quality permits, hazardous waste permits, or 316(b) cooling water intake structure permits.. Valid values are `title_v_air_operating|npdes_water_discharge|psd_air_construction|state_air_quality|hazardous_waste|cooling_water_intake_316b`',
    `pollutant_type` STRING COMMENT 'Primary pollutant or environmental parameter regulated by this permit. May include air pollutants (NOx, SO2, CO2, PM), water discharge parameters (temperature, pH, chemical concentrations), or waste categories.',
    `public_notice_date` DATE COMMENT 'Date on which public notice of the permit application or renewal was published. Marks the beginning of the public comment period.',
    `public_notice_required_flag` BOOLEAN COMMENT 'Indicates whether public notice and comment period is required for permit issuance or renewal under applicable regulations. Typically required for major source permits.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was first created in the data management system. Supports data lineage and audit trail requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this permit record was last updated in the data management system. Tracks the currency of permit information for compliance reporting.',
    `renewal_application_deadline` DATE COMMENT 'Deadline by which the permit renewal application must be submitted to the regulatory authority. Typically 180 days before expiration for Title V permits.',
    `renewal_date` DATE COMMENT 'Date on which the permit was last renewed or is scheduled for renewal. Supports proactive permit renewal management and compliance planning.',
    `reporting_frequency` STRING COMMENT 'Required frequency of compliance reports to be submitted to the regulatory authority. Specifies how often the facility must file monitoring data and compliance certifications.. Valid values are `continuous|daily|monthly|quarterly|semi_annual|annual`',
    `responsible_party_name` STRING COMMENT 'Name of the individual or organization legally responsible for permit compliance. Typically the facility operator or designated responsible official.',
    `responsible_party_title` STRING COMMENT 'Job title or position of the responsible party. Common titles include Environmental Manager, Plant Manager, or Compliance Officer.',
    `violation_count` STRING COMMENT 'Total number of permit violations recorded for this permit during the current permit term. Supports compliance performance tracking and enforcement risk assessment.',
    `water_discharge_limit_mgd` DECIMAL(18,2) COMMENT 'Maximum allowable water discharge flow rate in million gallons per day as specified in the NPDES permit. Applies to cooling water discharge and wastewater effluent.',
    `water_temperature_limit_f` DECIMAL(18,2) COMMENT 'Maximum allowable temperature in degrees Fahrenheit for water discharged under the NPDES permit. Critical for thermal pollution control at steam electric generating facilities.',
    CONSTRAINT pk_environmental_permit PRIMARY KEY(`environmental_permit_id`)
) COMMENT 'Master record for environmental permits and compliance authorizations held by each generation facility — Title V air operating permits, NPDES water discharge permits (including 316(b) cooling water intake structure requirements), state air quality construction permits, PSD (Prevention of Significant Deterioration) permits, and hazardous waste permits. Captures permit type, issuing agency (EPA, state DEQ), permit number, issuance date, expiration date, renewal date, permitted emission limits (tons/year by pollutant), permitted water discharge limits (temperature, flow, chemical concentrations), cooling water intake flow limits (316(b)), compliance status, permit conditions/stipulations, and associated generating units. Supports environmental compliance tracking, permit renewal management, and regulatory audit readiness. Distinct from emissions_record which captures actual measured emissions — this product captures the permitted limits and regulatory authorizations. Sourced from state DEQ permit databases and internal environmental compliance systems.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ADD CONSTRAINT `fk_generation_generating_unit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ADD CONSTRAINT `fk_generation_dispatch_schedule_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ADD CONSTRAINT `fk_generation_unit_output_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ADD CONSTRAINT `fk_generation_generation_outage_event_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ADD CONSTRAINT `fk_generation_fuel_inventory_fuel_contract_id` FOREIGN KEY (`fuel_contract_id`) REFERENCES `power_and_utilities`.`generation`.`fuel_contract`(`fuel_contract_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ADD CONSTRAINT `fk_generation_fuel_inventory_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_fuel_contract_id` FOREIGN KEY (`fuel_contract_id`) REFERENCES `power_and_utilities`.`generation`.`fuel_contract`(`fuel_contract_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ADD CONSTRAINT `fk_generation_fuel_consumption_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ADD CONSTRAINT `fk_generation_emissions_record_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ADD CONSTRAINT `fk_generation_emissions_record_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ADD CONSTRAINT `fk_generation_capacity_resource_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ADD CONSTRAINT `fk_generation_fuel_contract_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ADD CONSTRAINT `fk_generation_environmental_permit_generating_unit_id` FOREIGN KEY (`generating_unit_id`) REFERENCES `power_and_utilities`.`generation`.`generating_unit`(`generating_unit_id`);
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ADD CONSTRAINT `fk_generation_environmental_permit_plant_id` FOREIGN KEY (`plant_id`) REFERENCES `power_and_utilities`.`generation`.`plant`(`plant_id`);
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ADD CONSTRAINT `fk_generation_environmental_permit_renewed_environmental_permit_id` FOREIGN KEY (`renewed_environmental_permit_id`) REFERENCES `power_and_utilities`.`generation`.`environmental_permit`(`environmental_permit_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities`.`generation` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities`.`generation` SET TAGS ('dbx_domain' = 'generation');
ALTER TABLE `power_and_utilities`.`generation`.`plant` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`generation`.`plant` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Cpcn Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `balancing_authority` SET TAGS ('dbx_business_glossary_term' = 'Balancing Authority');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor (Percent)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `commercial_operation_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Operation Date');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `eia_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Energy Information Administration (EIA) Plant Code');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `eia_plant_code` SET TAGS ('dbx_value_regex' = '^[0-9]{1,6}$');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `emissions_controlled` SET TAGS ('dbx_business_glossary_term' = 'Emissions Controlled Flag');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `ems_resource_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Management System (EMS) Resource Identifier');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `ferc_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Plant Identifier');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `ferc_plant_code` SET TAGS ('dbx_value_regex' = '^[0-9]{1,10}$');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `heat_rate_btu_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate (British Thermal Units per Kilowatt-Hour)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `interconnection_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Voltage (Kilovolts)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `iso_rto_region` SET TAGS ('dbx_business_glossary_term' = 'Independent System Operator (ISO) / Regional Transmission Organization (RTO) Region');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `last_major_upgrade_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Upgrade Date');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `minimum_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Minimum Load (Megawatts)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `nameplate_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity (Megawatts)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `nerc_plant_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Plant Code');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `nerc_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,10}$');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `net_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Net Capacity (Megawatts)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `operator_name` SET TAGS ('dbx_business_glossary_term' = 'Operator Name');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `operator_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `operator_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `plant_name` SET TAGS ('dbx_business_glossary_term' = 'Plant Name');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `plant_status` SET TAGS ('dbx_business_glossary_term' = 'Plant Operational Status');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `plant_status` SET TAGS ('dbx_value_regex' = 'operating|mothballed|retired|under_construction|planned|decommissioned');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `ppa_contract_flag` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Contract Flag');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `primary_use` SET TAGS ('dbx_business_glossary_term' = 'Primary Use Classification');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `primary_use` SET TAGS ('dbx_value_regex' = 'baseload|intermediate|peaking|renewable_intermittent|energy_storage|backup');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `ramp_rate_mw_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate (Megawatts per Minute)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `rec_eligible` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Eligible Flag');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = 'ferc|state_puc|municipal|cooperative|federal_power_marketing');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `renewable_energy_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Flag');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `scada_integration_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Integration Flag');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `startup_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Startup Time (Hours)');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities`.`generation`.`plant` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Cpcn Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `ancillary_services_capable` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Capable');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `balancing_authority` SET TAGS ('dbx_business_glossary_term' = 'Balancing Authority');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `black_start_capable` SET TAGS ('dbx_business_glossary_term' = 'Black Start Capable');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `capacity_factor_target_pct` SET TAGS ('dbx_business_glossary_term' = 'Target Capacity Factor (Percent)');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `carbon_capture_enabled` SET TAGS ('dbx_business_glossary_term' = 'Carbon Capture Enabled');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `commercial_operation_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Operation Date');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `cooling_system_type` SET TAGS ('dbx_business_glossary_term' = 'Cooling System Type');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `cooling_system_type` SET TAGS ('dbx_value_regex' = 'once_through|recirculating|dry_cooling|hybrid|none');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `dispatch_priority` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Priority');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `eia_generator_code` SET TAGS ('dbx_business_glossary_term' = 'EIA Generator ID');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `emissions_control_equipment` SET TAGS ('dbx_business_glossary_term' = 'Emissions Control Equipment');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `fuel_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Fuel Type');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `fuel_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Fuel Type');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `heat_rate_btu_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate (BTU per kWh)');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `interconnection_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Voltage (kV)');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `last_major_overhaul_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Overhaul Date');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Equipment Manufacturer');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `minimum_stable_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Minimum Stable Load (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Model Number');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `must_run_designation` SET TAGS ('dbx_business_glossary_term' = 'Must-Run Designation');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `nameplate_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `nerc_unit_code` SET TAGS ('dbx_business_glossary_term' = 'NERC Unit ID');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `net_summer_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Net Summer Capacity (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `net_winter_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Net Winter Capacity (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `next_scheduled_outage_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Outage Date');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|ppa|tolling|joint_ownership');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `planned_retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Retirement Date');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `prime_mover_code` SET TAGS ('dbx_business_glossary_term' = 'Prime Mover Code');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `ramp_rate_mw_per_min` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate (MW per Minute)');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `renewable_energy_credit_eligible` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Credit (REC) Eligible');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'RTO/ISO Region');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `scada_point_reference` SET TAGS ('dbx_business_glossary_term' = 'SCADA Point ID');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `synchronization_date` SET TAGS ('dbx_business_glossary_term' = 'Grid Synchronization Date');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Technology Type');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `unit_code` SET TAGS ('dbx_business_glossary_term' = 'Unit Code');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `unit_name` SET TAGS ('dbx_business_glossary_term' = 'Unit Name');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Unit Operational Status');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `unit_type` SET TAGS ('dbx_business_glossary_term' = 'Unit Type');
ALTER TABLE `power_and_utilities`.`generation`.`generating_unit` ALTER COLUMN `water_source` SET TAGS ('dbx_business_glossary_term' = 'Water Source');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `dispatch_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Schedule Identifier');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `grid_topology_id` SET TAGS ('dbx_business_glossary_term' = 'Grid Topology Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Contract ID');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Node ID');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `ancillary_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Flag');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `commitment_flag` SET TAGS ('dbx_business_glossary_term' = 'Commitment Flag');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `control_area` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Control Area');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `dispatch_instruction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Instruction Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Status');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `dispatch_status` SET TAGS ('dbx_value_regex' = 'scheduled|committed|dispatched|cancelled|revised');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `dispatch_type` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Type');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `dispatch_type` SET TAGS ('dbx_value_regex' = 'economic|reliability|emergency|regulation|load_following|must_run');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `economic_dispatch_mw` SET TAGS ('dbx_business_glossary_term' = 'Economic Dispatch Megawatt (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `emissions_rate_lbs_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Emissions Rate Pounds (lbs) per Megawatt-Hour (MWh)');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `forecast_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Forecast Load Megawatt (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `fuel_burn_forecast_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Fuel Burn Forecast Million British Thermal Units (MMBTU)');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `heat_rate_btu_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate British Thermal Units (BTU) per Kilowatt-Hour (kWh)');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `marginal_cost_usd_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Marginal Cost United States Dollars (USD) per Megawatt-Hour (MWh)');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `marginal_cost_usd_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `maximum_generation_mw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Generation Megawatt (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `minimum_down_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Down Time Hours');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `minimum_generation_mw` SET TAGS ('dbx_business_glossary_term' = 'Minimum Generation Megawatt (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `minimum_up_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Up Time Hours');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `must_run_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Run Flag');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `operating_hour` SET TAGS ('dbx_business_glossary_term' = 'Operating Hour');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `ramp_rate_mw_per_min` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate Megawatt (MW) per Minute');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `regulation_reserve_mw` SET TAGS ('dbx_business_glossary_term' = 'Regulation Reserve Megawatt (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `schedule_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Created Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `schedule_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Date');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `schedule_notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `schedule_source_system` SET TAGS ('dbx_business_glossary_term' = 'Schedule Source System');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|intra_day|reliability|emergency');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `schedule_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Schedule Updated Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `scheduled_mw_output` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Megawatt (MW) Output');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `settlement_interval` SET TAGS ('dbx_business_glossary_term' = 'Settlement Interval');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `spinning_reserve_mw` SET TAGS ('dbx_business_glossary_term' = 'Spinning Reserve Megawatt (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `startup_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Startup Cost United States Dollars (USD)');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `startup_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `startup_type` SET TAGS ('dbx_business_glossary_term' = 'Startup Type');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `startup_type` SET TAGS ('dbx_value_regex' = 'hot|warm|cold');
ALTER TABLE `power_and_utilities`.`generation`.`dispatch_schedule` ALTER COLUMN `transmission_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Transmission Constraint Flag');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `unit_output_id` SET TAGS ('dbx_business_glossary_term' = 'Unit Output ID');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Contract ID');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `ambient_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (°F)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `auxiliary_load_mwh` SET TAGS ('dbx_business_glossary_term' = 'Auxiliary Load (MWh)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `barometric_pressure_inhg` SET TAGS ('dbx_business_glossary_term' = 'Barometric Pressure (inHg)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `capacity_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor (%)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `co2_emissions_tons` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Emissions (Tons)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|estimated|missing|suspect|manual|failed_validation');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `dispatch_mode` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Mode');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `dispatch_mode` SET TAGS ('dbx_value_regex' = 'baseload|cycling|peaking|must_run|economic|manual');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Frequency (Hz)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `fuel_consumption_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption (MMBtu)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `gross_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Gross Generation (MWh)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `heat_rate_btu_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate (BTU/kWh)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration (Minutes)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `interval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interval Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `net_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Net Generation (MWh)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `nox_emissions_lbs` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Oxides (NOx) Emissions (lbs)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `reactive_power_mvar` SET TAGS ('dbx_business_glossary_term' = 'Reactive Power (MVAR)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `rec_quantity` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Quantity');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `relative_humidity_percent` SET TAGS ('dbx_business_glossary_term' = 'Relative Humidity (%)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `rps_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Eligible Flag');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `rto_settlement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) Settlement Flag');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `scada_source_tag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Source Tag');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `so2_emissions_lbs` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Dioxide (SO2) Emissions (lbs)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `steam_flow_klb_per_hr` SET TAGS ('dbx_business_glossary_term' = 'Steam Flow (klb/hr)');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `unit_status` SET TAGS ('dbx_business_glossary_term' = 'Unit Status');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `unit_status` SET TAGS ('dbx_value_regex' = 'online|offline|startup|shutdown|standby|maintenance');
ALTER TABLE `power_and_utilities`.`generation`.`unit_output` ALTER COLUMN `voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage (kV)');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` SET TAGS ('dbx_subdomain' = 'asset_operations');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `generation_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Outage Event ID');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `affected_system` SET TAGS ('dbx_business_glossary_term' = 'Affected System');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `available_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Capacity (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `derated_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Derated Capacity (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `efor_contribution_hours` SET TAGS ('dbx_business_glossary_term' = 'EFOR Contribution Hours');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `environmental_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Incident Flag');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `estimated_revenue_impact_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Impact (USD)');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `estimated_revenue_impact_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `extension_reason` SET TAGS ('dbx_business_glossary_term' = 'Extension Reason');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `lost_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Lost Generation (MWh)');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `maintenance_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cost (USD)');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `maintenance_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `nerc_gads_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'NERC GADS Reportable Flag');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `nerc_gads_submission_date` SET TAGS ('dbx_business_glossary_term' = 'NERC GADS Submission Date');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Outage Approval Date');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_cause_code` SET TAGS ('dbx_business_glossary_term' = 'NERC GADS Outage Cause Code');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Outage Cause Description');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_coordinator` SET TAGS ('dbx_business_glossary_term' = 'Outage Coordinator');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration Hours');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage End Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_extension_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Extension Flag');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_number` SET TAGS ('dbx_business_glossary_term' = 'Outage Number');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage Start Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_status` SET TAGS ('dbx_business_glossary_term' = 'Outage Status');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_status` SET TAGS ('dbx_value_regex' = 'active|completed|extended|cancelled');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_type` SET TAGS ('dbx_business_glossary_term' = 'Outage Type');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `outage_type` SET TAGS ('dbx_value_regex' = 'planned|forced|maintenance|extension|startup_failure|shutdown');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `puc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'PUC Reportable Flag');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `replacement_power_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Replacement Power Cost (USD)');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `replacement_power_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `responsible_crew` SET TAGS ('dbx_business_glossary_term' = 'Responsible Crew');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `return_to_service_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Return to Service Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `rto_iso_notification_method` SET TAGS ('dbx_business_glossary_term' = 'RTO/ISO Notification Method');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `rto_iso_notification_method` SET TAGS ('dbx_value_regex' = 'phone|email|ems_system|web_portal|automated');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `rto_iso_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RTO/ISO Notification Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `scheduled_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Duration Hours');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'oracle_wam|ibm_maximo|abb_ems|ge_ems|manual_entry');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `weather_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Related Flag');
ALTER TABLE `power_and_utilities`.`generation`.`generation_outage_event` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` SET TAGS ('dbx_subdomain' = 'fuel_management');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `fuel_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Inventory ID');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `fuel_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Facility ID');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `ash_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Ash Content Percent');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `average_daily_consumption_rate` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Consumption Rate');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `btu_content` SET TAGS ('dbx_business_glossary_term' = 'British Thermal Unit (BTU) Content');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `days_of_burn_remaining` SET TAGS ('dbx_business_glossary_term' = 'Days of Burn Remaining');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `economic_order_quantity` SET TAGS ('dbx_business_glossary_term' = 'Economic Order Quantity (EOQ)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `enrichment_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Enrichment Level Percent');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `fac_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Adjustment Clause (FAC) Eligible Flag');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `fuel_grade` SET TAGS ('dbx_business_glossary_term' = 'Fuel Grade');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'coal|natural_gas|nuclear|oil|biomass|diesel');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `ghg_emissions_factor` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Emissions Factor');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `inventory_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Date');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `inventory_status` SET TAGS ('dbx_value_regex' = 'available|reserved|in_transit|quarantined|depleted');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `maximum_storage_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Storage Capacity');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `minimum_operating_reserve` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Reserve');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percent');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `nitrogen_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Content Percent');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `quality_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certification Number');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `quality_test_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Test Date');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity on Hand');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Date');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `storage_pressure` SET TAGS ('dbx_business_glossary_term' = 'Storage Pressure');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `storage_temperature` SET TAGS ('dbx_business_glossary_term' = 'Storage Temperature');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percent');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Value');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `total_inventory_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'tons|mcf|bcf|barrels|assemblies|mmbtu');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_inventory` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` SET TAGS ('dbx_subdomain' = 'fuel_management');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_consumption_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption ID');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract ID');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Power Plant ID');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Supplier ID');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `ambient_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Fahrenheit)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `cems_reconciliation_flag` SET TAGS ('dbx_business_glossary_term' = 'Continuous Emissions Monitoring System (CEMS) Reconciliation Flag');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `ch4_emissions_factor` SET TAGS ('dbx_business_glossary_term' = 'Methane (CH4) Emissions Factor (lbs per MMBTU)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `co2_emissions_factor` SET TAGS ('dbx_business_glossary_term' = 'Carbon Dioxide (CO2) Emissions Factor (lbs per MMBTU)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Comments');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `consumption_date` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Date');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `consumption_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `data_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Code');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `data_quality_code` SET TAGS ('dbx_value_regex' = 'verified|estimated|provisional|suspect');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `data_source` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Data Source');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `data_source` SET TAGS ('dbx_value_regex' = 'scada|dcs|manual_entry|ems|pi_historian');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Fuel Delivery Method');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'pipeline|rail|truck|barge|ship|on_site');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `eia_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Energy Information Administration (EIA) Reporting Flag');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `fac_recovery_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Fuel Adjustment Clause (FAC) Recovery Eligible Flag');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Fuel Cost Per Unit (USD)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_subtype` SET TAGS ('dbx_business_glossary_term' = 'Fuel Subtype');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'coal|natural_gas|nuclear|fuel_oil|diesel|biomass');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `generation_output_mwh` SET TAGS ('dbx_business_glossary_term' = 'Generation Output (MWh)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `heat_content_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Heat Content Per Unit (BTU per Unit)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `heat_rate_btu_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate (BTU per kWh)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `nox_emissions_factor` SET TAGS ('dbx_business_glossary_term' = 'Nitrogen Oxides (NOx) Emissions Factor (lbs per MMBTU)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `operating_mode` SET TAGS ('dbx_business_glossary_term' = 'Unit Operating Mode');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `operating_mode` SET TAGS ('dbx_value_regex' = 'baseload|cycling|peaking|startup|shutdown');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `quantity_consumed` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity Consumed');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity Unit of Measure');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'tons|mcf|barrels|pounds|gallons|mmbtu');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `so2_emissions_factor` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Dioxide (SO2) Emissions Factor (lbs per MMBTU)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `total_co2_emissions_tons` SET TAGS ('dbx_business_glossary_term' = 'Total Carbon Dioxide (CO2) Emissions (tons)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `total_fuel_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Fuel Cost (USD)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `total_fuel_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `total_heat_content_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Total Heat Content (MMBTU)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `total_nox_emissions_tons` SET TAGS ('dbx_business_glossary_term' = 'Total Nitrogen Oxides (NOx) Emissions (tons)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_consumption` ALTER COLUMN `total_so2_emissions_tons` SET TAGS ('dbx_business_glossary_term' = 'Total Sulfur Dioxide (SO2) Emissions (tons)');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `emissions_record_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Record Identifier');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit ID');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `allowance_account_number` SET TAGS ('dbx_business_glossary_term' = 'Allowance Account Number');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `allowance_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `allowance_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `allowance_consumption` SET TAGS ('dbx_business_glossary_term' = 'Allowance Consumption');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `ambient_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Fahrenheit)');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `carbon_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Carbon Content Percentage');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `carbon_cost_total` SET TAGS ('dbx_business_glossary_term' = 'Total Carbon Cost');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `carbon_price_per_ton` SET TAGS ('dbx_business_glossary_term' = 'Carbon Price per Ton');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `cems_monitor_status` SET TAGS ('dbx_business_glossary_term' = 'Continuous Emissions Monitoring System (CEMS) Monitor Status');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `cems_monitor_status` SET TAGS ('dbx_value_regex' = 'operational|out_of_service|calibration|maintenance|failed_qa');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Emissions Record Comments');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `control_efficiency_percent` SET TAGS ('dbx_business_glossary_term' = 'Control Equipment Efficiency Percentage');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `control_equipment_status` SET TAGS ('dbx_business_glossary_term' = 'Emissions Control Equipment Status');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `control_equipment_status` SET TAGS ('dbx_value_regex' = 'operational|bypassed|out_of_service|maintenance');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `data_substitution_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Substitution Flag');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `ecmps_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Emissions Collection and Monitoring Plan System (ECMPS) Submission Date');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `ecmps_submission_status` SET TAGS ('dbx_business_glossary_term' = 'Emissions Collection and Monitoring Plan System (ECMPS) Submission Status');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `ecmps_submission_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|accepted|rejected|resubmitted');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `ecmps_tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Emissions Collection and Monitoring Plan System (ECMPS) Tracking Number');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `emission_quantity_tons` SET TAGS ('dbx_business_glossary_term' = 'Emission Quantity (Tons)');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `emission_rate_lbs_per_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Emission Rate (Pounds per Million British Thermal Units)');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `fuel_consumption_quantity` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Quantity');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `fuel_consumption_unit` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption Unit of Measure');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `fuel_consumption_unit` SET TAGS ('dbx_value_regex' = 'tons|mcf|barrels|mmbtu');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `ghg_inventory_category` SET TAGS ('dbx_business_glossary_term' = 'Greenhouse Gas (GHG) Inventory Category');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `ghg_inventory_category` SET TAGS ('dbx_value_regex' = 'stationary_combustion|process_emissions|fugitive_emissions');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `gross_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Gross Generation (Megawatt-Hours)');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `heat_input_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Heat Input (Million British Thermal Units)');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'CEMS|fuel_factor|mass_balance|engineering_estimate|default_factor|substitute');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `pollutant_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Pollutant Concentration (Parts Per Million)');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `pollutant_type` SET TAGS ('dbx_business_glossary_term' = 'Pollutant Type');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `pollutant_type` SET TAGS ('dbx_value_regex' = 'CO2|SO2|NOx|Hg|PM2.5|CH4');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `qa_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Certification Date');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `qa_test_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Assurance (QA) Test Result');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `qa_test_result` SET TAGS ('dbx_value_regex' = 'passed|failed|conditional');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `rec_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Eligible Flag');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `rps_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Compliance Flag');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `stack_flow_rate_scfh` SET TAGS ('dbx_business_glossary_term' = 'Stack Flow Rate (Standard Cubic Feet per Hour)');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `substitution_method` SET TAGS ('dbx_business_glossary_term' = 'Substitution Method');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `substitution_method` SET TAGS ('dbx_value_regex' = 'maximum_potential|fuel_specific_default|load_based|missing_data_procedure');
ALTER TABLE `power_and_utilities`.`generation`.`emissions_record` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `capacity_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Capacity Resource Identifier (ID)');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Approval Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Identifier (ID)');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Contract Identifier (ID)');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `accreditation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Period End Date');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `accreditation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Accreditation Period Start Date');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `accredited_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Accredited Capacity (Megawatts)');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `auction_clearing_price_per_mw_day` SET TAGS ('dbx_business_glossary_term' = 'Auction Clearing Price per Megawatt-Day ($/MW-day)');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `bonus_payment_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Bonus Payment Eligible Flag');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `capacity_commitment_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Capacity Commitment Period End Date');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `capacity_commitment_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Capacity Commitment Period Start Date');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `capacity_interconnection_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Interconnection Rights Flag');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `capacity_market_product_type` SET TAGS ('dbx_business_glossary_term' = 'Capacity Market Product Type');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `capacity_market_product_type` SET TAGS ('dbx_value_regex' = 'base_capacity|capacity_performance|must_offer|seasonal_capacity|annual_capacity|flexible_capacity');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `capacity_revenue_amount` SET TAGS ('dbx_business_glossary_term' = 'Capacity Revenue Amount');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `capacity_transfer_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Capacity Transfer Rights Flag');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `capacity_zone` SET TAGS ('dbx_business_glossary_term' = 'Capacity Zone');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `demand_response_resource_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Resource Flag');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `energy_storage_resource_flag` SET TAGS ('dbx_business_glossary_term' = 'Energy Storage Resource Flag');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `equivalent_forced_outage_rate_eford` SET TAGS ('dbx_business_glossary_term' = 'Equivalent Forced Outage Rate on Demand (EFORd)');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `installed_capacity_icap_mw` SET TAGS ('dbx_business_glossary_term' = 'Installed Capacity (ICAP) Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `last_accreditation_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Accreditation Test Date');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `must_offer_obligation_flag` SET TAGS ('dbx_business_glossary_term' = 'Must-Offer Obligation Flag');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `next_accreditation_test_date` SET TAGS ('dbx_business_glossary_term' = 'Next Accreditation Test Date');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `non_performance_charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Non-Performance Charge Rate');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `performance_obligation_mw` SET TAGS ('dbx_business_glossary_term' = 'Performance Obligation (Megawatts)');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `planning_year` SET TAGS ('dbx_business_glossary_term' = 'Planning Year');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `registration_status` SET TAGS ('dbx_business_glossary_term' = 'Registration Status');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `registration_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|withdrawn|expired|terminated');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `renewable_resource_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Resource Flag');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `resource_adequacy_status` SET TAGS ('dbx_business_glossary_term' = 'Resource Adequacy (RA) Status');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `resource_adequacy_status` SET TAGS ('dbx_value_regex' = 'qualified|conditionally_qualified|not_qualified|under_review');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `resource_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Resource Registration Number');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `rto_iso_name` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Name');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `seasonal_capacity_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Capacity Flag');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities`.`generation`.`capacity_resource` ALTER COLUMN `unforced_capacity_ucap_mw` SET TAGS ('dbx_business_glossary_term' = 'Unforced Capacity (UCAP) Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` SET TAGS ('dbx_subdomain' = 'fuel_management');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `fuel_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract ID');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Plant ID');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Supplier ID');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `prudency_review_id` SET TAGS ('dbx_business_glossary_term' = 'Prudency Review Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `wholesale_counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Wholesale Counterparty Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `ash_content_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Ash Content Limit Percent');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Fuel Base Price');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `base_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `btu_content_specification` SET TAGS ('dbx_business_glossary_term' = 'BTU Content Specification');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contract_amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Count');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract Name');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract Number');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contract_owner_employee_code` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee ID');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contract_owner_employee_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contract_owner_employee_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract Status');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|active|suspended|expired|terminated|amended');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract Type');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'firm|interruptible|spot|swing|baseload|peaking');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contract_value_total` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contract_value_total` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `contracted_volume` SET TAGS ('dbx_business_glossary_term' = 'Contracted Fuel Volume');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `delivery_period` SET TAGS ('dbx_business_glossary_term' = 'Fuel Delivery Period');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `delivery_period` SET TAGS ('dbx_value_regex' = 'daily|monthly|quarterly|annual|as_needed');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `delivery_point_description` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Description');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `force_majeure_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Provision Flag');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'coal|natural_gas|nuclear_fuel|oil|biomass|other');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `minimum_take_obligation` SET TAGS ('dbx_business_glossary_term' = 'Minimum Take Obligation');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `minimum_take_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Minimum Take Unit of Measure');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `minimum_take_unit_of_measure` SET TAGS ('dbx_value_regex' = 'tons|mcf|mmbtu|barrels|assemblies');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `moisture_content_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Limit Percent');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Fuel Price Index Reference');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_value_regex' = 'usd_per_ton|usd_per_mcf|usd_per_mmbtu|usd_per_barrel|usd_per_assembly');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_business_glossary_term' = 'Fuel Pricing Mechanism');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `pricing_mechanism` SET TAGS ('dbx_value_regex' = 'fixed|index|cost_plus|market_based|escalation');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `regulatory_approval_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Required Flag');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `renewable_fuel_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Fuel Flag');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `rps_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'RPS Eligible Flag');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `sulfur_content_limit_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Limit Percent');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `transportation_arrangement` SET TAGS ('dbx_business_glossary_term' = 'Fuel Transportation Arrangement');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `transportation_arrangement` SET TAGS ('dbx_value_regex' = 'pipeline|rail|barge|truck|supplier_arranged|utility_arranged');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `transportation_cost_responsibility` SET TAGS ('dbx_business_glossary_term' = 'Transportation Cost Responsibility');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `transportation_cost_responsibility` SET TAGS ('dbx_value_regex' = 'supplier|utility|shared');
ALTER TABLE `power_and_utilities`.`generation`.`fuel_contract` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Identifier (ID)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Identifier (ID)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Identifier (ID)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `renewed_environmental_permit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Compliance Status');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional_compliance|under_investigation');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `control_efficiency_required_percent` SET TAGS ('dbx_business_glossary_term' = 'Required Control Efficiency (Percent)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `control_equipment_required` SET TAGS ('dbx_business_glossary_term' = 'Required Pollution Control Equipment');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `cooling_water_intake_limit_mgd` SET TAGS ('dbx_business_glossary_term' = 'Cooling Water Intake Flow Limit (Million Gallons per Day)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Effective Date');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `emission_limit_tons_per_year` SET TAGS ('dbx_business_glossary_term' = 'Permitted Emission Limit (Tons per Year)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `emission_rate_limit_lbs_per_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Permitted Emission Rate Limit (Pounds per Million British Thermal Units)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `enforcement_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Enforcement Action Flag');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Expiration Date');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `hazardous_waste_quantity_limit_tons_per_month` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Quantity Limit (Tons per Month)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Issuance Date');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Agency');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `issuing_agency_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency Code');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Inspection Date');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Result');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|minor_violation|major_violation|no_findings');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `last_violation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Violation Date');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Compliance Monitoring Frequency');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `penalty_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (United States Dollars)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `penalty_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `permit_conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions and Stipulations');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `permit_fee_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Amount (United States Dollars)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `permit_fee_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `permit_name` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Name');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Status');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|expired|pending_renewal|suspended|revoked|under_review');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Type');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'title_v_air_operating|npdes_water_discharge|psd_air_construction|state_air_quality|hazardous_waste|cooling_water_intake_316b');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `pollutant_type` SET TAGS ('dbx_business_glossary_term' = 'Regulated Pollutant Type');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `public_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Date');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `public_notice_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Notice Required Flag');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `renewal_application_deadline` SET TAGS ('dbx_business_glossary_term' = 'Renewal Application Deadline Date');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Renewal Date');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Frequency');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'continuous|daily|monthly|quarterly|semi_annual|annual');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `responsible_party_title` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Title');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Permit Violation Count');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `water_discharge_limit_mgd` SET TAGS ('dbx_business_glossary_term' = 'Permitted Water Discharge Limit (Million Gallons per Day)');
ALTER TABLE `power_and_utilities`.`generation`.`environmental_permit` ALTER COLUMN `water_temperature_limit_f` SET TAGS ('dbx_business_glossary_term' = 'Permitted Water Temperature Limit (Fahrenheit)');
