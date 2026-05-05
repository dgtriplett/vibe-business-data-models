-- Schema for Domain: distribution | Business: Power and Utilities | Version: v1_mvm
-- Generated on: 2026-04-29 23:12:55

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities`.`distribution` COMMENT 'Manages last-mile electric and gas delivery infrastructure to end-use customers — distribution feeders, poles, service transformers, gas mains, service laterals, and associated GIS network topology. Serves as the SSOT for OMS/DMS outage events, SAIDI/SAIFI/CAIDI reliability indices, NEM interconnections, DER/DERMS integration, voltage regulation, and gas pipeline safety data under PHMSA.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`feeder` (
    `feeder_id` BIGINT COMMENT 'Unique system identifier for the electric distribution feeder circuit. Primary key.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Feeder construction, upgrades, and extensions are capital projects requiring project tracking for budget management, AFUDC calculation, and regulatory reporting. Essential for capital investment manag',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Feeders must meet vegetation management cycles, reliability standards, and inspection obligations. Direct compliance tracking: linking feeders to their primary regulatory obligations for scheduling an',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Feeders use standardized conductor materials tracked by type and size. Enables lifecycle replacement planning, material standardization programs, and accurate cost estimation for feeder reconductoring',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Feeders incur operational and maintenance expenses that must be allocated to cost centers for FERC functional accounting and regulatory reporting. Essential for O&M expense tracking and rate case cost',
    `distribution_substation_id` BIGINT COMMENT 'Reference to the distribution substation from which this feeder originates. Links to the substation master record.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Feeders are subject to regulatory proceedings for reliability standards, infrastructure investments, and rate recovery. Utilities must track which dockets authorize feeder upgrades and impose performa',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Feeders are capitalized plant assets tracked in the fixed asset register for depreciation, rate base calculation, and FERC Form 1 reporting. Essential for utility asset accounting.',
    `pricing_node_id` BIGINT COMMENT 'Foreign key linking to market.pricing_node. Business justification: ISO/RTO market operations require feeder-to-pricing-node mapping for distribution-level LMP analysis, DER hosting capacity valuation, and locational marginal value studies. Essential for integrated di',
    `caidi_annual` DECIMAL(18,2) COMMENT 'The annual Customer Average Interruption Duration Index for this feeder, measured in minutes. Represents the average outage duration per interruption event.',
    `capacitor_bank_count` STRING COMMENT 'The number of capacitor banks installed on the feeder for power factor correction and voltage support.',
    `circuit_configuration` STRING COMMENT 'The topology or architecture of the feeder circuit. Radial feeders have a single source path; loop feeders have alternate paths with normally-open points; networked feeders have multiple energized sources.. Valid values are `radial|loop|networked|spot_network|grid_network`',
    `conductor_size_kcmil` STRING COMMENT 'The cross-sectional area of the conductor in thousand circular mils, which determines current-carrying capacity and voltage drop characteristics.',
    `customer_count` STRING COMMENT 'The total number of end-use customers served by this feeder. Critical for calculating SAIFI and SAIDI reliability indices.',
    `der_capacity_mw` DECIMAL(18,2) COMMENT 'The total nameplate generation capacity of all DER interconnections on this feeder in megawatts. Critical for hosting capacity analysis and grid stability studies.',
    `der_interconnection_count` STRING COMMENT 'The total number of distributed energy resources (solar PV, wind, battery storage, etc.) interconnected to this feeder under IEEE 1547 or state interconnection standards.',
    `dms_circuit_code` STRING COMMENT 'The circuit identifier used in the Distribution Management System for real-time network analysis, switching operations, and voltage optimization.',
    `feeder_name` STRING COMMENT 'Human-readable name or designation for the feeder, often incorporating geographic or landmark references for operational clarity.',
    `feeder_number` STRING COMMENT 'Business identifier for the feeder circuit, typically assigned by the utility following internal naming conventions. Used in operational communications, OMS displays, and field work orders.',
    `gis_feature_code` STRING COMMENT 'The unique identifier for the feeder circuit in the utility GIS system, linking to spatial network topology, pole locations, and asset mapping.',
    `in_service_date` DATE COMMENT 'The date the feeder was first energized and placed into commercial operation. Used for asset age analysis and depreciation calculations.',
    `last_inspection_date` DATE COMMENT 'The date of the most recent comprehensive inspection of the feeder circuit, including poles, conductors, and equipment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this feeder record was last updated in the system, capturing configuration changes, status updates, or data corrections.',
    `length_miles` DECIMAL(18,2) COMMENT 'The total circuit length of the feeder from substation to the furthest endpoint, measured in miles. Used for voltage drop calculations, reliability metrics, and maintenance planning.',
    `nem_customer_count` STRING COMMENT 'The number of customers on this feeder enrolled in net energy metering programs, typically residential or commercial solar installations.',
    `next_inspection_date` DATE COMMENT 'The scheduled date for the next comprehensive feeder inspection, based on regulatory requirements and utility maintenance cycles.',
    `nominal_voltage_kv` DECIMAL(18,2) COMMENT 'The nominal operating voltage of the feeder circuit in kilovolts, typically ranging from 4 kV to 35 kV for distribution feeders.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special operating instructions, known issues, or other contextual information relevant to the feeder.',
    `oms_circuit_code` STRING COMMENT 'The circuit identifier used in the Outage Management System for tracking outage events, restoration activities, and customer impact analysis.',
    `operational_status` STRING COMMENT 'Current operational state of the feeder circuit. In-service feeders are energized and serving load; out-of-service feeders are temporarily de-energized for maintenance or emergency conditions.. Valid values are `in_service|out_of_service|under_construction|planned|decommissioned`',
    `peak_load_mw` DECIMAL(18,2) COMMENT 'The highest recorded real power demand on the feeder in megawatts, typically measured during system peak periods. Used for capacity planning and reliability analysis.',
    `phase_configuration` STRING COMMENT 'The number of electrical phases carried by the feeder. Most distribution feeders are three-phase; some rural or light-load circuits may be single-phase or two-phase.. Valid values are `three_phase|single_phase|two_phase`',
    `protection_scheme` STRING COMMENT 'The type of protective relay and coordination scheme applied to the feeder, such as overcurrent, distance, differential, or adaptive protection.',
    `rated_capacity_mva` DECIMAL(18,2) COMMENT 'The maximum continuous load capacity of the feeder in megavolt-amperes, determined by conductor thermal limits, protection settings, and substation transformer capacity allocation.',
    `recloser_count` STRING COMMENT 'The number of automatic reclosing devices installed on the feeder to isolate faults and minimize customer interruptions.',
    `saidi_annual` DECIMAL(18,2) COMMENT 'The annual System Average Interruption Duration Index for this feeder, measured in minutes. Represents the average total outage duration per customer served by the feeder.',
    `saifi_annual` DECIMAL(18,2) COMMENT 'The annual System Average Interruption Frequency Index for this feeder, representing the average number of sustained interruptions per customer.',
    `scada_point_code` STRING COMMENT 'The unique identifier for the SCADA monitoring point associated with this feeder, used to retrieve real-time telemetry data such as voltage, current, power flow, and breaker status.',
    `service_territory` STRING COMMENT 'The geographic service area or operating region served by this feeder, used for regulatory reporting and operational planning.',
    `source_bus_id` BIGINT COMMENT 'Reference to the specific bus or breaker position within the substation from which this feeder is energized.',
    `tree_trimming_cycle_months` STRING COMMENT 'The scheduled vegetation management cycle for this feeder in months. Critical for reliability improvement and wildfire risk mitigation.',
    `underground_percentage` DECIMAL(18,2) COMMENT 'The percentage of the feeder circuit length that is underground cable versus overhead conductor. Underground circuits typically have higher reliability but higher installation costs.',
    `voltage_regulator_count` STRING COMMENT 'The number of voltage regulation devices (line regulators or load tap changers) installed on the feeder to maintain voltage within acceptable limits per ANSI C84.1.',
    CONSTRAINT pk_feeder PRIMARY KEY(`feeder_id`)
) COMMENT 'Master record for electric distribution feeders — the primary medium-voltage circuits (typically 4kV–35kV) emanating from distribution substations to deliver electricity to end-use customers. Captures feeder identifier, nominal voltage, circuit configuration (radial/loop/networked), rated capacity (MVA), peak load, substation source bus, feeder length (miles), conductor type, phase configuration, GIS network topology reference, SCADA point ID, operational status, and service territory. SSOT for feeder-level reliability metrics (SAIDI, SAIFI, CAIDI) and OMS/DMS circuit topology. Sourced from ESRI ArcGIS and Schneider Electric AMS/GE PowerOn.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`service_transformer` (
    `service_transformer_id` BIGINT COMMENT 'Unique identifier for the distribution service transformer record. Primary key for the service transformer entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transformer maintenance and operational costs are allocated to cost centers for expense tracking and regulatory reporting. Required for FERC Form 1 functional cost allocation and rate case preparation',
    `distribution_substation_id` BIGINT COMMENT 'Identifier of the distribution substation that sources the feeder supplying this transformer. Used for hierarchical network topology and capacity planning.',
    `feeder_id` BIGINT COMMENT 'Identifier of the primary distribution feeder circuit that supplies this transformer. Critical for outage isolation, load flow analysis, and SCADA integration.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Transformers are capitalized distribution assets requiring fixed asset tracking for depreciation, rate base inclusion, and FERC plant accounting. Essential for regulatory asset management.',
    `master_id` BIGINT COMMENT 'Foreign key linking to asset.asset_master. Business justification: Service transformers are capital assets requiring lifecycle management, depreciation tracking (FERC/NARUC accounts), condition assessments, PM schedules, work orders, and regulatory asset base reporti',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Distribution transformers are procured materials with standardized part numbers tracked in material master. Enables warranty tracking, lifecycle cost analysis, and standardized procurement for transfo',
    `pole_id` BIGINT COMMENT 'Foreign key linking to distribution.pole. Business justification: Service transformers are physically mounted on poles (pole-mounted configuration). The service_transformer table currently has pole_number (STRING) as a denormalized reference. Adding pole_id FK enabl',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: Transformer investments are included in rate base and depreciation schedules in rate cases. Cost recovery tracking: linking transformers to the rate case that authorized their inclusion in rate base.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase and installation cost of the transformer in US dollars. Used for capitalization, depreciation, and rate base calculations under FERC Uniform System of Accounts.',
    `asset_condition_score` DECIMAL(18,2) COMMENT 'Composite health index (0-100 scale) derived from inspection findings, age, load history, and failure risk models. Guides capital investment prioritization and replacement planning.',
    `book_value` DECIMAL(18,2) COMMENT 'Current net book value after accumulated depreciation. Represents the assets carrying value on the utilitys balance sheet.',
    `city` STRING COMMENT 'City or municipality where the transformer is located. Used for jurisdictional reporting and regional analysis.',
    `connected_customer_count` STRING COMMENT 'Number of customer service points (meters) served by this transformer. Used for outage impact assessment and SAIDI/SAIFI/CAIDI reliability calculations.',
    `cooling_type` STRING COMMENT 'Insulation and cooling medium classification. Oil-immersed transformers require spill containment and environmental monitoring; dry-type are used indoors or where fire safety is critical.. Valid values are `oil_immersed|dry_type|pad_mounted_oil|sealed_tank`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service transformer record was first created in the system. Audit field for data lineage and governance.',
    `criticality_rating` STRING COMMENT 'Business criticality classification based on customer count, load served, and service area importance. Drives prioritization for emergency response and capital investment.. Valid values are `critical|high|medium|low`',
    `der_interconnection_flag` BOOLEAN COMMENT 'Indicates whether one or more Distributed Energy Resources (solar PV, battery storage, EV chargers) are interconnected to this transformer under Net Energy Metering (NEM) or other programs. Critical for DERMS integration and voltage management.',
    `impedance_percent` DECIMAL(18,2) COMMENT 'Nameplate impedance of the transformer expressed as a percentage. Critical for short-circuit analysis, protective device coordination, and voltage regulation studies.',
    `installation_date` DATE COMMENT 'Date the transformer was placed into service in the distribution network. Marks the start of the assets operational lifecycle and depreciation period.',
    `kva_rating` DECIMAL(18,2) COMMENT 'Nameplate capacity of the service transformer in kilovolt-amperes. Principal measurement for load balancing, capacity planning, and determining service adequacy for connected customers.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent field inspection or preventive maintenance activity. Used to schedule future inspections and assess compliance with maintenance programs.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service transformer record was most recently modified. Audit field for change tracking and data quality monitoring.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS84 decimal degrees) of the transformer installation. Enables GIS mapping, mobile workforce dispatch, and spatial analytics.',
    `load_factor_percent` DECIMAL(18,2) COMMENT 'Ratio of average load to peak load over a measurement period, expressed as a percentage. Indicates utilization efficiency and guides capacity planning.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS84 decimal degrees) of the transformer installation. Enables GIS mapping, mobile workforce dispatch, and spatial analytics.',
    `manufacture_year` STRING COMMENT 'Year the transformer was manufactured. Used for age-based risk assessment, depreciation calculations, and replacement prioritization.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next preventive maintenance inspection. Drives work order generation and compliance with regulatory maintenance standards.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the service transformer in the distribution network. Drives availability for load calculations, outage management, and asset planning.. Valid values are `in_service|out_of_service|standby|retired|under_construction|planned`',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the transformer asset. Determines maintenance responsibility, capital treatment, and regulatory rate base inclusion.. Valid values are `utility_owned|customer_owned|third_party|joint_ownership`',
    `peak_load_kva` DECIMAL(18,2) COMMENT 'Maximum observed load on the transformer in kilovolt-amperes. Used to assess overload risk and determine upgrade or replacement needs.',
    `phase_configuration` STRING COMMENT 'Electrical phase design of the transformer. Single-phase serves residential and small commercial; three-phase serves larger commercial and industrial loads.. Valid values are `single_phase|three_phase`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the transformer location. Used for geographic segmentation and service territory mapping.',
    `primary_voltage` DECIMAL(18,2) COMMENT 'Medium-voltage input from the distribution feeder in kilovolts. Typical values include 4.16kV, 12.47kV, 13.2kV, 13.8kV, 24.9kV, 34.5kV depending on utility standards.',
    `retirement_date` DATE COMMENT 'Date the transformer was permanently removed from service. Nullable for active assets. Marks the end of the assets operational lifecycle.',
    `scada_monitored_flag` BOOLEAN COMMENT 'Indicates whether the transformer is equipped with real-time monitoring via SCADA or Advanced Distribution Management System (ADMS). Enables proactive outage detection and load management.',
    `secondary_voltage` DECIMAL(18,2) COMMENT 'Utilization voltage output to end-use customers in volts. Typical residential values: 120/240V single-phase; typical commercial values: 208Y/120V or 480Y/277V three-phase.',
    `serial_number` STRING COMMENT 'Unique factory-assigned serial number for the individual transformer unit. Critical for warranty claims, recall tracking, and asset provenance.',
    `state_province` STRING COMMENT 'State or province where the transformer is located. Used for regulatory reporting to state Public Utility Commissions (PUCs).',
    `street_address` STRING COMMENT 'Physical street address or nearest address reference for the transformer location. Used for field crew navigation and customer service inquiries.',
    `tap_position` STRING COMMENT 'Current tap setting for voltage regulation (e.g., +2.5%, nominal, -5%). Adjusts secondary voltage to maintain service quality within ANSI C84.1 limits.',
    `transformer_number` STRING COMMENT 'Externally-known business identifier for the service transformer, used in field operations, work orders, and GIS mapping. Unique across the utilitys distribution network.. Valid values are `^[A-Z0-9]{6,20}$`',
    `transformer_type` STRING COMMENT 'Physical installation configuration of the service transformer. Determines accessibility, maintenance procedures, and safety protocols.. Valid values are `pad_mounted|pole_mounted|vault|underground|overhead|submersible`',
    `winding_configuration` STRING COMMENT 'Primary and secondary winding connection topology. Affects voltage transformation, grounding, and harmonic performance.. Valid values are `delta_delta|delta_wye|wye_delta|wye_wye|open_delta`',
    CONSTRAINT pk_service_transformer PRIMARY KEY(`service_transformer_id`)
) COMMENT 'Master record for distribution service transformers — pad-mounted, pole-mounted, or vault transformers that step down medium-voltage feeder voltage to utilization voltage (120/240V residential; 277/480V commercial) for last-mile delivery. Captures transformer ID, kVA rating, primary/secondary voltage, phase configuration (single/three-phase), installation type, GPS coordinates, feeder association, pole/structure number, manufacturer, model, serial number, installation date, oil/dry type, load factor, and operational status. Critical for load balancing, outage isolation, and asset lifecycle management. Sourced from ESRI ArcGIS and Oracle WAM/IBM Maximo.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`distribution_substation` (
    `distribution_substation_id` BIGINT COMMENT 'Unique surrogate identifier for the distribution substation record in the Silver Layer lakehouse. Primary key. Entity role: MASTER_RESOURCE — represents a physical facility owned and operated by the utility to step down transmission voltage for last-mile electric distribution.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Substation construction and major upgrades are capital projects requiring project tracking for budget management, AFUDC calculation, CWIP accounting, and regulatory approval. Critical for capital plan',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Substations are major operational cost centers for utilities, tracking all O&M expenses for regulatory reporting, budgeting, and rate case cost studies. Essential for FERC functional accounting.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Substations are major capital assets requiring CPCN approval and rate base treatment. Essential for tracking regulatory proceedings authorizing substation construction, upgrades, and cost recovery in ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Substations are major capitalized assets requiring fixed asset tracking for depreciation, rate base calculation, and FERC Form 1 plant accounting. Critical for regulatory financial reporting.',
    `master_id` BIGINT COMMENT 'Asset identifier for this substation facility in Oracle WAM or IBM Maximo Enterprise Asset Management system. Links to preventive and corrective maintenance work orders, inspection records, and asset lifecycle cost tracking.',
    `pricing_node_id` BIGINT COMMENT 'Foreign key linking to market.pricing_node. Business justification: Substations are primary wholesale delivery points; LMP settlement, transmission cost allocation, and network upgrade cost assignment require substation-to-pricing-node mapping. Critical for FERC Open ',
    `commissioning_date` DATE COMMENT 'Date on which the substation was first energized and placed into commercial service (yyyy-MM-dd). Used to calculate asset age, depreciation schedules (AFUDC capitalization cutoff), and maintenance interval triggers in Oracle WAM/IBM Maximo.',
    `construction_work_order` STRING COMMENT 'Work order number from Oracle WAM or IBM Maximo associated with the original construction or most recent major capital project at this substation. Links to CAPEX project records, WIP accounting, and AFUDC capitalization in SAP S/4HANA or Oracle ERP.',
    `county_name` STRING COMMENT 'Name of the county or parish in which the substation is located. Used for local franchise agreement compliance, county emergency management coordination, and property tax assessment records.',
    `customers_served_count` STRING COMMENT 'Total number of end-use customer accounts (residential and commercial) served by distribution feeders emanating from this substation. Used as the denominator for SAIDI/SAIFI/CAIDI reliability index calculations and outage impact reporting to the PUC.',
    `decommission_date` DATE COMMENT 'Date on which the substation was permanently retired from service (yyyy-MM-dd). Null if the substation is still active. Used for asset retirement accounting, rate base removal, and regulatory decommissioning filings with the PUC.',
    `der_hosting_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum additional Distributed Energy Resource (DER) generation capacity (in MW) that can be interconnected to feeders served by this substation without requiring infrastructure upgrades, per the utilitys hosting capacity analysis. Used for NEM interconnection screening and DERMS planning.',
    `division_code` STRING COMMENT 'Internal organizational division or district code responsible for operating and maintaining this substation. Maps to the utilitys organizational hierarchy in SAP S/4HANA or Oracle ERP for O&M cost allocation and workforce dispatch.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `ems_node_code` STRING COMMENT 'Node identifier for this substation within the ABB or GE Energy Management System (EMS) network model. Used for power flow analysis, state estimation, and real-time grid balancing. Distinct from the SCADA point ID which references the historian tag.',
    `feeder_count` STRING COMMENT 'Count of active distribution feeder circuits emanating from this substations distribution bus. Used for load balancing analysis, SAIDI/SAIFI reliability reporting, and outage impact assessment. Sourced from ESRI ArcGIS network topology and Schneider Electric AMS.',
    `gis_feature_code` STRING COMMENT 'Unique feature identifier assigned to this substation in the ESRI ArcGIS enterprise geodatabase. Serves as the cross-reference key for spatial joins, network tracing, and GIS-to-OMS/DMS integration. Distinct from the surrogate primary key.',
    `installed_capacity_mva` DECIMAL(18,2) COMMENT 'Sum of the nameplate ratings of all power transformers installed at the substation, expressed in Megavolt-Amperes (MVA). Represents the maximum apparent power the substation can deliver to distribution feeders under normal operating conditions. Used for capacity planning, IRP, and FERC Form 1 reporting. Satisfies MASTER_RESOURCE MEASUREMENT_OR_VALUE category.',
    `is_automated_switching` BOOLEAN COMMENT 'Indicates whether the substation is equipped with automated switching devices (e.g., automated reclosers, sectionalizers, or FLISR-capable switches) that enable self-healing grid restoration without manual crew dispatch (True/False). Key metric for AMI/DERMS integration and reliability improvement programs.',
    `is_normally_open_tie` BOOLEAN COMMENT 'Indicates whether this substation serves as a normally-open tie point between two distribution circuits or substations (True) or operates as a radial/normally-closed facility (False). Critical for OMS/DMS switching order generation and restoration planning.',
    `is_scada_monitored` BOOLEAN COMMENT 'Indicates whether this substation has real-time SCADA telemetry integrated into the OSIsoft PI historian or ABB/GE EMS (True) or relies on manual reads and field inspection (False). Affects outage detection latency and SAIDI/SAIFI calculation methodology.',
    `land_parcel_number` STRING COMMENT 'County assessor parcel number (APN) or land parcel identifier for the property on which the substation is sited. Used for property tax filings, easement management, and real estate records in SAP S/4HANA or Oracle ERP.',
    `last_major_upgrade_date` DATE COMMENT 'Date of the most recent major capital upgrade or refurbishment of the substation (e.g., transformer replacement, bus reconfiguration, protection system modernization). Used for CAPEX project tracking, asset condition assessment, and IRP planning.',
    `latitude` DECIMAL(18,2) COMMENT 'WGS 84 geographic latitude of the substation site centroid in decimal degrees. Sourced from ESRI ArcGIS GIS feature class. Used for spatial analysis, storm outage correlation, mutual aid dispatch, and PHMSA/FERC geographic reporting.',
    `load_factor_pct` DECIMAL(18,2) COMMENT 'Ratio of average load to peak load at this substation over the most recent 12-month period, expressed as a percentage. Indicates utilization efficiency; a higher load factor means more uniform loading. Used in rate case cost studies and capacity planning.',
    `longitude` DECIMAL(18,2) COMMENT 'WGS 84 geographic longitude of the substation site centroid in decimal degrees. Sourced from ESRI ArcGIS GIS feature class. Used in conjunction with latitude for spatial analysis, outage mapping, and regulatory geographic reporting.',
    `nem_interconnection_count` STRING COMMENT 'Number of active Net Energy Metering (NEM) customer interconnections (e.g., rooftop solar, small wind) on feeders served by this substation. Used to assess reverse power flow risk, hosting capacity consumption, and DERMS dispatch requirements.',
    `nerc_bes_applicable` BOOLEAN COMMENT 'Indicates whether this substation meets the NERC Bulk Electric System (BES) definition thresholds (e.g., connected at 100 kV or above, or meeting generation/load criteria) and is therefore subject to NERC reliability standards (True/False). Drives CIP cybersecurity and FAC compliance obligations.',
    `nerc_cip_classification` STRING COMMENT 'NERC CIP cyber security impact classification for this substations Electronic Security Perimeter (ESP) and associated BES Cyber Systems. high, medium, or low impact per NERC CIP-002-5.1a; not_applicable if BES threshold not met. Governs physical and cyber security control requirements.. Valid values are `high|medium|low|not_applicable`',
    `oms_facility_code` STRING COMMENT 'Facility identifier for this substation in the Schneider Electric AMS or GE PowerOn Outage Management System / Distribution Management System (OMS/DMS). Used to associate outage events, switching orders, and restoration activities with this substation.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the distribution substation. in_service = energized and serving load; out_of_service = de-energized for maintenance or fault; under_construction = not yet commissioned; decommissioned = permanently retired; mothballed = temporarily idled. Drives OMS/DMS outage eligibility and asset management workflows. Satisfies MASTER_RESOURCE LIFECYCLE_STATUS category.. Valid values are `in_service|out_of_service|under_construction|decommissioned|mothballed`',
    `ownership_type` STRING COMMENT 'Indicates the ownership arrangement for the substation facility and equipment. utility_owned = fully owned by the utility; jointly_owned = shared ownership with another entity (e.g., another utility or municipality); customer_owned = owned by a large industrial customer; leased = utility operates but does not own the facility. Affects CAPEX/OPEX accounting, CIAC treatment, and rate base inclusion.. Valid values are `utility_owned|jointly_owned|customer_owned|leased`',
    `peak_load_mw` DECIMAL(18,2) COMMENT 'Maximum recorded real power demand (in Megawatts) observed at this substation during the most recent annual peak period. Used for capacity planning, demand response (DR) program sizing, and IRP load forecasting. Sourced from OSIsoft PI historian interval data.',
    `primary_voltage_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level on the high-voltage (transmission) side of the substation transformer, expressed in kilovolts (kV). Typical values for distribution substations include 69 kV, 115 kV, 138 kV, or 230 kV. Used for interconnection studies, OATT compliance, and NERC BES applicability determination.',
    `protection_scheme` STRING COMMENT 'Type of protective relay scheme deployed at the substation for fault detection and isolation. Drives maintenance inspection intervals, NERC PRC compliance tracking, and equipment procurement for relay upgrades.. Valid values are `overcurrent|differential|distance|pilot_wire|digital_relay|hybrid`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this distribution substation record was first created in the Silver Layer lakehouse (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for data lineage, audit trail, and ETL reconciliation. Satisfies MASTER_RESOURCE RECORD_AUDIT_CREATED category.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this distribution substation record in the Silver Layer lakehouse (yyyy-MM-ddTHH:mm:ss.SSSXXX). Used for change data capture (CDC), incremental ETL processing, and audit trail compliance.',
    `saidi_contribution_min` DECIMAL(18,2) COMMENT 'This substations contribution to the utilitys annual System Average Interruption Duration Index (SAIDI), expressed in customer-minutes per customer. Calculated from outage events originating at or upstream of this substation. Used for PUC reliability benchmarking and Performance-Based Ratemaking (PBR) incentive calculations.',
    `scada_point_code` STRING COMMENT 'Identifier of the SCADA integration point (RTU/IED address or OSIsoft PI tag prefix) associated with this substation in the OSIsoft PI or GE Proficy historian and the ABB/GE Energy Management System. Enables real-time telemetry linkage for voltage, load, and breaker status monitoring.',
    `secondary_voltage_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level on the low-voltage (distribution) side of the substation transformer, expressed in kilovolts (kV). Typical values include 4.16 kV, 12.47 kV, 13.2 kV, 13.8 kV, 25 kV, or 34.5 kV. Determines feeder voltage class and equipment ratings for downstream distribution assets.',
    `service_territory_code` STRING COMMENT 'Code identifying the utilitys certificated service territory zone or district in which this substation is located. Used for PUC jurisdictional reporting, rate zone assignment, and load forecasting segmentation. Aligns with the utilitys CPCN boundary definitions.. Valid values are `^[A-Z0-9_-]{2,30}$`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this substation record was sourced. Supports data lineage tracking and conflict resolution when multiple systems contribute attributes. [ENUM-REF-CANDIDATE: arcgis|schneider_ams|ge_poweron|maximo|oracle_wam|pi_historian|manual — promote to reference product]',
    `state_code` STRING COMMENT 'Two-letter US state abbreviation (USPS standard) for the state in which the substation is located. Used for jurisdictional regulatory reporting to state PUCs and for multi-state utility operational segmentation.. Valid values are `^[A-Z]{2}$`',
    `street_address` STRING COMMENT 'Physical street address of the substation facility (street number, street name, city, state, ZIP). Used for field crew dispatch, emergency response coordination, and permit filings. Classified confidential as organizational location data.',
    `substation_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the substation, as assigned by the utilitys GIS and OMS/DMS systems (e.g., ESRI ArcGIS feature ID or Schneider Electric AMS station code). Used in SCADA tags, outage tickets, and regulatory filings. Satisfies MASTER_RESOURCE BUSINESS_IDENTIFIER category.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `substation_name` STRING COMMENT 'Human-readable name of the distribution substation (e.g., Riverside Distribution Substation). Used in customer-facing outage communications, regulatory filings, and operational dashboards. Satisfies MASTER_RESOURCE IDENTITY_LABEL category.',
    `substation_type` STRING COMMENT 'Categorical classification of the substation by function within the distribution network. distribution = standard step-down facility; switching = bus-tie/sectionalizing point; network = secondary network vault; customer_owned = customer-sited facility interconnected to the utility grid. Satisfies MASTER_RESOURCE CLASSIFICATION_OR_TYPE category.. Valid values are `distribution|switching|network|customer_owned`',
    `transformer_count` STRING COMMENT 'Total count of power transformers (including main bank and spare/standby units) installed at the substation. Relevant for N-1 contingency analysis, maintenance scheduling in Oracle WAM/IBM Maximo, and capacity redundancy assessment.',
    `voltage_regulation_scheme` STRING COMMENT 'Primary voltage regulation technology deployed at the substation. ltc = Load Tap Changer on main transformer; svr = Step Voltage Regulator on feeder; capacitor_bank = switched capacitor bank; statcom = Static Synchronous Compensator; none = no active regulation. Relevant for DER/DERMS integration and power quality compliance.. Valid values are `ltc|svr|capacitor_bank|statcom|none`',
    CONSTRAINT pk_distribution_substation PRIMARY KEY(`distribution_substation_id`)
) COMMENT 'Master record for distribution substations — facilities that receive bulk power from the transmission system and step down voltage for distribution feeder circuits. Captures substation ID, name, location (GPS/GIS), service territory, nominal primary voltage (transmission side), secondary voltage (distribution side), total installed transformer capacity (MVA), number of distribution feeders served, SCADA integration point, ownership type, commissioning date, and operational status. Distinct from transmission substations (owned by the transmission domain). Sourced from ESRI ArcGIS and Schneider Electric AMS/GE PowerOn.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`service_point` (
    `service_point_id` BIGINT COMMENT 'Unique surrogate identifier for the service point record in the distribution domain. Primary key for the master record of a physical utility service delivery location. Role: MASTER_RESOURCE.',
    `account_id` BIGINT COMMENT 'Reference to the customer account currently associated with this service point. Links the physical delivery location to the billing and customer relationship record in the CIS.',
    `feeder_id` BIGINT COMMENT 'Reference to the electric distribution feeder circuit that supplies power to this service point. Used for outage management, SAIDI/SAIFI/CAIDI reliability reporting, and load flow analysis.',
    `gas_main_id` BIGINT COMMENT 'Reference to the gas distribution main pipeline segment supplying this service point. Applicable only for gas or dual-service service points. Used for PHMSA pipeline safety reporting and gas network topology.',
    `meter_id` BIGINT COMMENT 'Reference to the metering device currently installed at this service point. Links the service delivery location to the AMI/AMR meter asset record in the MDMS and EAM.',
    `premise_id` BIGINT COMMENT 'Reference to the physical premise (property/parcel) at which this service point is located. A single premise may have multiple service points (e.g., separate electric and gas service points for a dual-service premise).',
    `pricing_node_id` BIGINT COMMENT 'Foreign key linking to market.pricing_node. Business justification: Retail choice markets require service point to pricing node mapping for LMP-based customer billing and settlement. Load-serving entities need this link for retail rate calculation and wholesale cost a',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Service points have standardized service equipment (meter sockets, service entrance cables, disconnects) tracked as materials. Enables new service installation cost estimation, AMI deployment material',
    `service_transformer_id` BIGINT COMMENT 'Foreign key linking to distribution.service_transformer. Business justification: Service points (customer delivery points) are served by distribution service transformers. This is a fundamental distribution network relationship essential for outage management, service restoration,',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Each service point is billed under a specific approved tariff schedule. Fundamental billing relationship: tariff determines rates, charges, and terms of service. Replaces denormalized rate_schedule_co',
    `ami_enabled_flag` BOOLEAN COMMENT 'Indicates whether this service point is equipped with an Advanced Metering Infrastructure (AMI) smart meter capable of two-way communication and interval data collection. Distinguishes AMI from legacy AMR or manual-read meters.',
    `city` STRING COMMENT 'City or municipality of the service delivery location. Used for geographic reporting, franchise territory validation, and regulatory jurisdiction determination.',
    `connect_date` DATE COMMENT 'Date on which utility service was first connected and activated at this service point. Used for service tenure analysis, asset age tracking, and move-in/move-out processing.',
    `contract_demand_kw` DECIMAL(18,2) COMMENT 'Contracted maximum demand in kilowatts (kW) for this service point as agreed in the service agreement or tariff schedule. Used for demand charge billing, transformer sizing, and capacity planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service point record was first created in the source system of record. Used for data lineage, audit trail, and record lifecycle management. Satisfies MASTER_RESOURCE RECORD_AUDIT_CREATED category.',
    `der_capacity_kw` DECIMAL(18,2) COMMENT 'Nameplate installed capacity in kilowatts (kW) of the Distributed Energy Resource (DER) interconnected at this service point. Populated only when der_interconnect_flag is true. Used for hosting capacity analysis and DERMS dispatch.',
    `der_interconnect_flag` BOOLEAN COMMENT 'Indicates whether a Distributed Energy Resource (DER) — such as rooftop solar PV, battery storage, or small wind — is interconnected at this service point. Used by DERMS for grid visibility, voltage regulation, and DER dispatch coordination.',
    `disconnect_date` DATE COMMENT 'Date on which utility service was permanently disconnected at this service point. Null for active service points. Used for move-out processing, final billing, and service point lifecycle management.',
    `dr_program_enrolled_flag` BOOLEAN COMMENT 'Indicates whether this service point is currently enrolled in a Demand Response (DR) or load management program. Used for peak shaving event dispatch, DSM program tracking, and regulatory DR reporting.',
    `ev_charger_flag` BOOLEAN COMMENT 'Indicates whether an Electric Vehicle (EV) charging station is installed at this service point. Used for load forecasting, grid impact analysis, and EV-specific rate program eligibility (e.g., TOU-EV rates).',
    `gas_meter_set_code` STRING COMMENT 'Identifier for the gas meter set assembly (regulator, meter, and associated fittings) at this service point. Used for gas asset management, safety inspection scheduling, and PHMSA compliance tracking.',
    `gas_pressure_class` STRING COMMENT 'Operating pressure classification of the gas service lateral at this service point (low, medium, or high pressure). Applicable only for gas or dual-service service points. Required for PHMSA pipeline safety management and gas distribution system design.. Valid values are `low_pressure|medium_pressure|high_pressure`',
    `gis_last_updated_date` DATE COMMENT 'Date on which the GIS spatial record for this service point was last updated in ESRI ArcGIS. Used for GIS data quality monitoring and network model synchronization with OMS/DMS.',
    `gis_parcel_code` STRING COMMENT 'County assessor parcel identification number (APN) or GIS parcel reference linking the service point to the land parcel record in the ESRI ArcGIS system. Used for property-level spatial analysis and CIAC/AFUDC cost allocation.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection performed at this service point. Used for inspection scheduling, regulatory compliance tracking (PHMSA, OSHA), and asset maintenance planning.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the service point in decimal degrees (WGS84 datum). Used for GIS network topology, field crew navigation, and spatial analytics.',
    `load_class_code` STRING COMMENT 'Utility-defined load classification code assigned to the service point for rate design, load forecasting, and demand-side management program targeting (e.g., RES-1, COM-2, IND-3). Sourced from Oracle CC&B / SAP IS-U rate class assignment.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the service point in decimal degrees (WGS84 datum). Used for GIS network topology, field crew navigation, and spatial analytics.',
    `meter_read_cycle` STRING COMMENT 'Billing cycle code or route identifier that determines the scheduled meter reading frequency and sequence for this service point (e.g., monthly cycle 01, bi-monthly cycle 02). Used for meter reading route optimization and billing cycle management.',
    `meter_socket_code` STRING COMMENT 'Physical identifier of the meter socket or meter base at the service point. Distinguishes the physical installation point from the meter device itself, enabling meter change-out tracking without losing service point continuity.',
    `nem_eligible_flag` BOOLEAN COMMENT 'Indicates whether this service point is eligible for Net Energy Metering (NEM) — the billing arrangement allowing customers with on-site generation (e.g., rooftop solar) to receive credit for excess energy exported to the grid. Drives NEM tariff application and bidirectional metering requirements.',
    `postal_code` STRING COMMENT 'US ZIP or ZIP+4 postal code for the service delivery location. Used for geographic analysis, franchise territory mapping, and demographic segmentation.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `premise_type` STRING COMMENT 'Classification of the customer premise by end-use category. Drives tariff schedule assignment, load classification, and regulatory reporting segmentation (e.g., residential vs. commercial/industrial rate classes). [ENUM-REF-CANDIDATE: residential|commercial|industrial|agricultural|lighting|other — promote to reference product if additional classes are needed]. Valid values are `residential|commercial|industrial|agricultural|lighting`',
    `service_address_line1` STRING COMMENT 'Primary street address line of the physical service delivery location. Used for field crew dispatch, GIS geocoding, and customer correspondence. Satisfies MASTER_RESOURCE IDENTITY_LABEL category.',
    `service_address_line2` STRING COMMENT 'Secondary address line for the service delivery location (e.g., apartment, suite, unit number). Supplements the primary address for multi-unit premises.',
    `service_lateral_length_ft` DECIMAL(18,2) COMMENT 'Length in feet of the service lateral — the conductor or pipe segment connecting the distribution main or transformer to the customers meter. Used for CIAC cost estimation, line loss calculations, and asset inventory.',
    `service_lateral_material` STRING COMMENT 'Material type of the service lateral conductor (electric) or pipe (gas). Used for asset condition assessment, replacement prioritization, and PHMSA gas pipeline safety reporting. [ENUM-REF-CANDIDATE: overhead_aluminum|overhead_copper|underground_xlpe|underground_pvc|steel_pipe|polyethylene_pipe|other — promote to reference product]. Valid values are `overhead_aluminum|overhead_copper|underground_xlpe|underground_pvc|steel_pipe|polyethylene_pipe`',
    `service_phase` STRING COMMENT 'Electrical phase configuration of the service delivery: single_phase (residential/small commercial) or three_phase (large commercial/industrial). Drives transformer sizing, load analysis, and rate eligibility.. Valid values are `single_phase|three_phase`',
    `service_point_status` STRING COMMENT 'Current lifecycle status of the service point indicating whether utility service is being actively delivered. Drives field work orders, billing eligibility, and OMS outage event correlation. Satisfies MASTER_RESOURCE LIFECYCLE_STATUS category. [ENUM-REF-CANDIDATE: active|inactive|pending_connect|pending_disconnect|disconnected|abandoned — promote to reference product]. Valid values are `active|inactive|pending_connect|pending_disconnect|disconnected`',
    `service_type` STRING COMMENT 'Indicates the commodity type delivered at this service point: electric (electricity only), gas (natural gas only), or dual (both electric and gas). Drives rate application, metering configuration, and regulatory reporting segmentation. Satisfies MASTER_RESOURCE CLASSIFICATION_OR_TYPE category.. Valid values are `electric|gas|dual`',
    `service_voltage_v` DECIMAL(18,2) COMMENT 'Nominal utilization voltage delivered at the service point in volts (e.g., 120, 240, 480). Used for voltage regulation analysis, equipment compatibility verification, and DMS load flow studies. Satisfies MASTER_RESOURCE MEASUREMENT_OR_VALUE category.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this service point record was sourced (e.g., CCB for Oracle CC&B, SAP_ISU for SAP IS-U, ARCGIS for ESRI ArcGIS). Used for data lineage and master data management reconciliation.. Valid values are `CCB|SAP_ISU|ARCGIS|MDMS`',
    `sp_external_code` STRING COMMENT 'Externally-known alphanumeric identifier for the service point as assigned by the source system of record (Oracle CC&B or SAP IS-U / ESRI ArcGIS). Used for cross-system reconciliation between the CIS, GIS, and MDMS. Satisfies MASTER_RESOURCE BUSINESS_IDENTIFIER category.',
    `state_code` STRING COMMENT 'Two-letter US state abbreviation for the service delivery location. Used for regulatory jurisdiction assignment (PUC, FERC) and geographic segmentation.. Valid values are `^[A-Z]{2}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this service point record was last modified in the source system of record. Used for incremental data pipeline processing, change detection, and audit trail.',
    CONSTRAINT pk_service_point PRIMARY KEY(`service_point_id`)
) COMMENT 'Master record for electric and gas service delivery points — the physical location where utility service is delivered to an end-use customer premise. Captures service point ID, service address, GPS coordinates, GIS parcel reference, service type (electric/gas/dual), premise type (residential/commercial/industrial), meter socket ID, feeder or gas main association, transformer association, service lateral details, load classification, NEM eligibility flag, DER interconnection flag, and active/inactive status. Serves as the geographic and physical SSOT linking the distribution network topology to customer accounts and metering infrastructure. Each service point represents one service delivery of a given type at a premise — a dual-service premise has separate electric and gas service points. Sourced from ESRI ArcGIS and Oracle CC&B/SAP IS-U.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`gas_main` (
    `gas_main_id` BIGINT COMMENT 'Unique surrogate identifier for a gas distribution main segment record in the Silver Layer lakehouse. Primary key for this entity. Entity role: MASTER_RESOURCE — represents a physical pipeline asset owned and operated by the utility.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Gas main installations and replacements are capital projects requiring project tracking for budget management, AFUDC calculation, and regulatory reporting. Essential for pipeline investment management',
    `city_gate_station_id` BIGINT COMMENT 'Reference to the city gate or gate station that feeds the pressure zone containing this gas main segment. Used for supply traceability, pressure management, and gas quality tracking.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Gas main maintenance, leak surveys, and operational costs are allocated to cost centers for FERC gas utility accounting and regulatory reporting. Required for rate case cost allocation.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Gas main replacements and upgrades are subject to rate cases and CPCN proceedings for cost recovery. Business need: tracking which dockets authorize gas infrastructure investments and allow rate base ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Gas mains are capitalized pipeline assets tracked in fixed asset register for depreciation, rate base inclusion, and FERC gas plant accounting. Essential for regulatory asset management.',
    `gas_network_node_id` BIGINT COMMENT 'GIS network node identifier at the upstream (supply) end of the gas main segment. Used for network topology traversal, hydraulic modeling, and outage/isolation analysis.',
    `master_id` BIGINT COMMENT 'Foreign key linking to asset.asset_master. Business justification: Gas mains are major capital assets requiring depreciation, FERC accounting, DIMP compliance, condition monitoring, integrity management programs, and regulatory asset base tracking. Critical for pipel',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Gas mains are procured pipe materials tracked by specification, diameter, and grade. Critical for PHMSA material traceability requirements, DIMP threat assessment, and pipeline integrity management. E',
    `cathodic_protection_flag` BOOLEAN COMMENT 'Indicates whether the gas main segment is covered by an active cathodic protection (CP) system. True = CP system in place and active; False = no cathodic protection. Required for PHMSA corrosion control compliance on steel mains per 49 CFR Part 192 Subpart I.',
    `cathodic_protection_type` STRING COMMENT 'Type of cathodic protection system applied to the gas main segment. Impressed-current systems use rectifiers; sacrificial-anode systems use zinc or magnesium anodes. Used in corrosion control program documentation and PHMSA compliance records.. Valid values are `impressed-current|sacrificial-anode|none|unknown`',
    `coating_type` STRING COMMENT 'External corrosion protection coating applied to the pipe. Relevant primarily for steel mains. Used in corrosion control program management and PHMSA integrity management. Values: fusion-bonded-epoxy, coal-tar, polyethylene-tape, bare (no coating), other, unknown.. Valid values are `fusion-bonded-epoxy|coal-tar|polyethylene-tape|bare|other|unknown`',
    `county` STRING COMMENT 'County in which the gas main segment is located. Used for PHMSA annual mileage reporting by county, permit coordination, and emergency response jurisdiction mapping.',
    `crossing_type` STRING COMMENT 'Type of infrastructure crossing associated with this gas main segment, if applicable. Used for permit tracking, inspection scheduling, and PHMSA high-consequence area (HCA) assessments. Values: road, railroad, water, aerial, none.. Valid values are `road|railroad|water|aerial|none`',
    `dimp_threat_rank` STRING COMMENT 'Risk/threat ranking assigned to this gas main segment under the utilitys Distribution Integrity Management Program (DIMP) as required by PHMSA 49 CFR Part 192 Subpart P. Drives prioritization of inspection, repair, and replacement activities.. Valid values are `high|medium|low|not-assessed`',
    `district_code` STRING COMMENT 'Code identifying the gas distribution operating district or service territory subdivision responsible for this main segment. Used for O&M cost allocation, workforce dispatch, and regulatory reporting by district.',
    `encased_flag` BOOLEAN COMMENT 'Indicates whether the gas main segment is installed within a casing pipe (e.g., at road crossings, railroad crossings, or water crossings). True = encased; False = direct burial. Relevant for PHMSA integrity management and maintenance access planning.',
    `gis_feature_code` STRING COMMENT 'Native feature identifier assigned by ESRI ArcGIS to this gas main segment in the geospatial network dataset. Used for cross-system traceability between the lakehouse Silver Layer and the authoritative GIS source system.',
    `installation_date` DATE COMMENT 'Date the gas main segment was physically installed and placed in service. Used for asset age calculations, replacement prioritization, depreciation schedules, and PHMSA pipeline records. Maps to installation year in legacy GIS records where only year is known.',
    `installation_year` STRING COMMENT 'Year the gas main segment was installed, retained as a separate field for legacy records where only the year (not full date) is known from historical GIS or paper records. Used in PHMSA annual mileage reporting by decade of installation.',
    `installed_by` STRING COMMENT 'Name of the contractor or utility crew that installed the gas main segment. Used for construction quality traceability and warranty/liability tracking.',
    `joint_type` STRING COMMENT 'Type of pipe joint used in the gas main segment construction. Relevant for integrity assessment and leak history analysis. [ENUM-REF-CANDIDATE: butt-fusion|electrofusion|mechanical|threaded|welded|bell-spigot|other — promote to reference product]',
    `leak_survey_date` DATE COMMENT 'Date of the most recent leak survey conducted on this gas main segment. Used to track compliance with PHMSA-mandated leak survey frequency requirements, which vary by pipe material, pressure tier, and class location.',
    `leak_survey_method` STRING COMMENT 'Method used in the most recent leak survey of this gas main segment. Values: bar-hole (soil probe), walking (combustible gas indicator on foot), mobile (vehicle-mounted methane detector), aerial (helicopter/drone), other.. Valid values are `bar-hole|walking|mobile|aerial|other`',
    `main_code` STRING COMMENT 'Externally-known alphanumeric identifier for the gas main segment as assigned in the GIS (ESRI ArcGIS) and referenced in PHMSA pipeline safety records, work orders, and field documentation. Serves as the BUSINESS_IDENTIFIER / natural key for cross-system traceability.',
    `main_name` STRING COMMENT 'Human-readable descriptive name or label for the gas main segment (e.g., Oak Street 4-inch PE Main). Serves as the IDENTITY_LABEL for operational reference and field crew communication.',
    `maop_psig` DECIMAL(18,2) COMMENT 'Maximum Allowable Operating Pressure in pounds per square inch gauge (PSIG) as established per PHMSA 49 CFR Part 192. The regulatory ceiling for operating pressure on this segment. Critical for pipeline safety compliance and integrity management programs.',
    `municipality` STRING COMMENT 'Name of the city, town, or municipality in which the gas main segment is located. Used for regulatory reporting, permit management, and service territory mapping.',
    `nominal_diameter_in` DECIMAL(18,2) COMMENT 'Nominal pipe diameter in inches (e.g., 2, 4, 6, 8, 12). MEASUREMENT_OR_VALUE for this pipeline asset. Used for capacity calculations, flow modeling, and replacement cost estimation. Standard nominal sizes per ASME B36.10M.',
    `operating_pressure_psig` DECIMAL(18,2) COMMENT 'Normal operating pressure of the gas main in pounds per square inch gauge (PSIG). Used for pressure zone management, DMS/SCADA monitoring, and PHMSA compliance. Must not exceed MAOP.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the gas main segment. Drives PHMSA reporting scope, maintenance scheduling, and GIS network topology. LIFECYCLE_STATUS for this MASTER_RESOURCE. Values: in-service (active, pressurized), out-of-service (isolated, not pressurized), abandoned (physically in place but permanently decommissioned), proposed (planned, not yet installed), under-construction (installation in progress).. Valid values are `in-service|out-of-service|abandoned|proposed|under-construction`',
    `phmsa_class_location` STRING COMMENT 'Pipeline class location (1 through 4) as defined by PHMSA 49 CFR Part 192 §192.5, based on population density within a sliding-mile corridor along the pipeline. Class 1 = rural/low density; Class 4 = high-density urban. Determines design factor, testing requirements, and integrity management obligations.. Valid values are `1|2|3|4`',
    `pipe_depth_in` DECIMAL(18,2) COMMENT 'Depth of cover over the gas main in inches, measured from ground surface to top of pipe. Used to verify compliance with minimum cover requirements per PHMSA 49 CFR Part 192 §192.327 and to assess third-party damage risk.',
    `pipe_grade` STRING COMMENT 'Material grade or specification of the pipe (e.g., ASTM D2513 for PE, API 5L Grade B for steel). Used in integrity management calculations, MAOP determination, and PHMSA compliance documentation.',
    `pipe_material` STRING COMMENT 'Material composition of the gas main pipe. Critical for PHMSA pipeline integrity management, leak survey frequency determination, and replacement prioritization. Common values: PE (polyethylene — modern standard), steel (bare or coated), cast-iron (legacy, high leak risk), wrought-iron (legacy), copper, PVC, other. [ENUM-REF-CANDIDATE: PE|steel|cast-iron|wrought-iron|copper|PVC|other — promote to reference product]',
    `pressure_tier` STRING COMMENT 'Pressure classification tier of the gas main segment. Drives operational procedures, regulator station requirements, and customer service pressure expectations. Values: high (typically >60 PSIG), medium (typically 0.5–60 PSIG), low (typically <0.5 PSIG), very-low (inches of water column).. Valid values are `high|medium|low|very-low`',
    `pressure_zone_code` STRING COMMENT 'Code identifying the gas distribution pressure zone or district regulator area to which this main segment belongs. Used for hydraulic network modeling, pressure management, and operational dispatch. Sourced from ESRI ArcGIS network topology.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gas main record was first created in the source GIS system or the lakehouse Silver Layer. Used for data lineage, audit trail, and RECORD_AUDIT_CREATED tracking per MASTER_RESOURCE canonical requirements.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this gas main record in the lakehouse Silver Layer. Used for change tracking, incremental ETL processing, and data quality monitoring.',
    `retirement_date` DATE COMMENT 'Date the gas main segment was retired, abandoned, or permanently taken out of service. Null for active segments. Used for asset lifecycle management, PHMSA abandoned pipeline records, and depreciation accounting.',
    `route_geometry_wkt` STRING COMMENT 'GIS route geometry of the gas main segment encoded as Well-Known Text (WKT) LINESTRING in WGS84 coordinate reference system. Enables spatial analysis, proximity queries, and map visualization in the lakehouse without requiring a live GIS connection.',
    `seam_type` STRING COMMENT 'Longitudinal seam type for steel pipe mains (e.g., seamless, ERW — Electric Resistance Welded, DSAW — Double Submerged Arc Welded). Used in integrity management threat identification per PHMSA Distribution Integrity Management Program (DIMP) requirements.. Valid values are `seamless|ERW|DSAW|flash-welded|unknown`',
    `segment_length_ft` DECIMAL(18,2) COMMENT 'Physical length of the gas main segment in feet as measured in the GIS network. Used for leak survey scheduling, replacement cost estimation, PHMSA mileage reporting, and O&M planning.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record from which this gas main record was sourced. Supports data lineage and master data management. Values: GIS (ESRI ArcGIS), EAM (Oracle WAM / IBM Maximo), SCADA (OSIsoft PI / GE Proficy), MANUAL (manual entry).. Valid values are `GIS|EAM|SCADA|MANUAL`',
    `state_code` STRING COMMENT 'Two-letter US state abbreviation (e.g., CA, TX, NY) where the gas main segment is located. Used for PHMSA state pipeline safety program reporting and state PUC regulatory filings.. Valid values are `^[A-Z]{2}$`',
    `street_address` STRING COMMENT 'Street name and address range along which the gas main is routed (e.g., 100-400 Oak Street). Used for field crew dispatch, permit coordination, and customer impact assessment during maintenance or emergency events.',
    `to_node_code` STRING COMMENT 'GIS network node identifier at the downstream (delivery) end of the gas main segment. Used for network topology traversal, hydraulic modeling, and isolation analysis.',
    `wall_thickness_in` DECIMAL(18,2) COMMENT 'Nominal pipe wall thickness in inches. Used in MAOP calculations per PHMSA 49 CFR Part 192 hoop stress formula and in integrity management assessments.',
    CONSTRAINT pk_gas_main PRIMARY KEY(`gas_main_id`)
) COMMENT 'Master record for gas distribution mains — the pressurized pipeline segments that transport natural gas from city gate stations through the distribution network to service laterals and end-use customers. Captures main ID, pipe material (steel/PE/cast iron), nominal diameter (inches), operating pressure (PSIG), MAOP (Maximum Allowable Operating Pressure), installation year, coating type, cathodic protection status, GIS route geometry, district/pressure zone, leak survey date, PHMSA class location, and operational status. SSOT for PHMSA pipeline safety compliance and gas distribution network topology. Sourced from ESRI ArcGIS.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` (
    `distribution_outage_event_id` BIGINT COMMENT 'Unique surrogate identifier for the outage event record in the distribution domain Silver layer. Primary key for this entity.',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_event. Business justification: Outages violating reliability standards generate compliance events with potential penalties. Core regulatory reporting: linking outages to compliance violations for SAIDI/SAIFI standard enforcement an',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Outage restoration costs (labor, materials, equipment) are allocated to cost centers for expense tracking, budgeting, and regulatory reporting. Essential for storm cost recovery and rate case preparat',
    `distribution_substation_id` BIGINT COMMENT 'Identifier of the distribution substation from which the affected feeder originates. Links to the substation master record. Used for substation-level outage aggregation and reliability performance reporting.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Major outages trigger regulatory investigations, penalty proceedings, and reliability improvement orders. Direct business need: linking outage events to resulting regulatory dockets for penalty tracki',
    `feeder_id` BIGINT COMMENT 'Identifier of the distribution feeder (circuit) on which the outage event originated or had the greatest impact. Links to the distribution feeder master record in the GIS/network model. Used for feeder-level reliability performance analysis and SAIDI/SAIFI disaggregation.',
    `opex_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.opex_transaction. Business justification: Outage restoration costs generate O&M expense transactions for labor, materials, and equipment. Essential for storm cost tracking, regulatory reporting, and potential cost recovery filings.',
    `protective_device_id` BIGINT COMMENT 'Asset identifier of the protective device (recloser, fuse, breaker, sectionalizer) that operated during this outage event, as recorded in the GIS or EAM system. Used to track device operation history and support asset reliability analysis.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Outages trigger corrective maintenance work orders for equipment repair, replacement, or investigation. Links operational reliability events to asset maintenance execution, enabling outage cost tracki',
    `actual_customers_affected` STRING COMMENT 'Verified count of customer service points that experienced an interruption during this outage event, confirmed after restoration. This is the authoritative figure used in SAIDI and SAIFI index calculations reported to the PUC. Distinct from estimated_customers_affected which is the initial OMS estimate.',
    `caidi_minutes` DECIMAL(18,2) COMMENT 'Customer Average Interruption Duration Index (CAIDI) for this event, representing the average restoration time experienced by affected customers. Calculated as outage_duration_minutes / 1 (per-event basis) or as SAIDI contribution / SAIFI contribution at the event level. Used in PUC reliability performance benchmarking.',
    `cause_code` STRING COMMENT 'Standardized cause code identifying the primary reason for the outage, sourced from the OMS cause code library. Common values include: weather, equipment_failure, animal, vegetation, vehicle, human_error, unknown, scheduled_maintenance, third_party. [ENUM-REF-CANDIDATE: weather|equipment_failure|animal|vegetation|vehicle|human_error|unknown|scheduled_maintenance|third_party|overload — promote to reference product]',
    `cause_description` STRING COMMENT 'Free-text narrative description of the outage cause as entered by the field crew or OMS operator, providing additional context beyond the standardized cause code. Used for post-event analysis and regulatory reporting narratives.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this outage event record was first created in the OMS or ingested into the Silver layer data product. Used for data lineage, audit trail, and SLA measurement of event creation-to-restoration cycle times.',
    `crew_arrival_timestamp` TIMESTAMP COMMENT 'Date and time when the first field crew arrived at the fault location. Used to calculate crew response time (crew_arrival_timestamp minus outage_start_timestamp) for operational performance monitoring and PUC reporting on emergency response.',
    `crew_dispatch_id` BIGINT COMMENT 'Identifier of the crew dispatch or work order record associated with this outage event, linking to the workforce/work management system (Oracle WAM or IBM Maximo). Used to correlate outage events with crew response times, labor costs, and O&M reporting.',
    `crew_dispatch_timestamp` TIMESTAMP COMMENT 'Date and time when the field crew was dispatched from the OMS/dispatch center to respond to this outage event. Used to measure dispatch response time and crew mobilization performance.',
    `customers_restored_partial` STRING COMMENT 'Number of customers restored through partial restoration switching actions before the final full restoration of the outage event. Populated only when partial_restoration_flag is True. Used for accurate CAIDI calculation when restoration occurs in stages.',
    `estimated_customers_affected` STRING COMMENT 'Initial estimate of the number of customer service points interrupted by this outage event, as determined by the OMS at the time of event creation based on network topology and affected equipment. Used for early situational awareness and crew dispatch prioritization.',
    `event_number` STRING COMMENT 'Externally-known alphanumeric identifier assigned by the Outage Management System (OMS) — e.g., Schneider Electric AMS or GE PowerOn — used for cross-system reference, crew dispatch tickets, and regulatory reporting. This is the business-facing event number communicated to field crews and regulators.',
    `event_status` STRING COMMENT 'Current lifecycle state of the outage event as tracked in the OMS. open = outage confirmed but crew not yet dispatched; in_progress = crew dispatched and working restoration; restored = power restored to all affected customers; closed = event fully documented and closed; cancelled = event determined to be a false alarm or duplicate.. Valid values are `open|in_progress|restored|closed|cancelled`',
    `fault_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees, WGS84) of the confirmed fault location, as captured by field crew GPS or GIS snap. Used for spatial analysis of outage patterns, vegetation management targeting, and storm damage assessment.',
    `fault_location_description` STRING COMMENT 'Free-text description of the physical location where the fault or outage cause was identified (e.g., pole number, street address, GPS coordinates, landmark). Captured by field crew upon arrival and entered into the OMS. Supports post-event analysis and asset failure pattern identification.',
    `fault_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees, WGS84) of the confirmed fault location, as captured by field crew GPS or GIS snap. Used in conjunction with fault_latitude for spatial outage analysis and GIS-based reliability reporting.',
    `ieee1366_exclusion_flag` BOOLEAN COMMENT 'Indicates whether this outage event is excluded from SAIDI/SAIFI/CAIDI index calculations per IEEE 1366-2012 major event day (MED) criteria or other exclusion rules (e.g., planned outages, momentary events). True = excluded from reliability indices; False = included in reliability index calculations.',
    `ieee1366_exclusion_reason` STRING COMMENT 'Reason code explaining why this outage event is excluded from IEEE 1366 reliability index calculations. Populated only when ieee1366_exclusion_flag is True. major_event_day = event occurred on a day classified as a Major Event Day per IEEE 1366 beta method; planned_outage = scheduled interruption; momentary = duration under 5 minutes; loss_of_supply = bulk transmission supply failure.. Valid values are `major_event_day|planned_outage|momentary|loss_of_supply|scheduled_maintenance|other`',
    `major_event_day_flag` BOOLEAN COMMENT 'Indicates whether this outage event occurred on a day classified as a Major Event Day (MED) per the IEEE 1366 beta method. True = MED day; events on MED days are typically excluded from normalized SAIDI/SAIFI calculations. Directly drives the ieee1366_exclusion_flag for weather-related exclusions.',
    `momentary_interruption_count` STRING COMMENT 'Number of momentary interruptions (each less than 5 minutes) associated with this outage event, typically caused by recloser operations before a sustained outage is declared. Used to calculate the Momentary Average Interruption Frequency Index (MAIFI) per IEEE 1366.',
    `mutual_aid_flag` BOOLEAN COMMENT 'Indicates whether mutual aid crews from another utility were requested or utilized to restore this outage event. True = mutual aid activated; False = restored with own crews. Relevant for storm restoration cost tracking, mutual aid agreement compliance, and FEMA reimbursement documentation.',
    `nerc_reportable_flag` BOOLEAN COMMENT 'Indicates whether this outage event meets NERC reporting thresholds and must be submitted as a disturbance report (OE-417 or equivalent). True = NERC reportable event; False = below NERC reporting threshold. Supports compliance with NERC reliability standards.',
    `oms_event_code` STRING COMMENT 'Native event identifier from the source Outage Management System (Schneider Electric AMS or GE PowerOn OMS). Preserved for lineage traceability and cross-system reconciliation between the Silver layer and the operational OMS. Distinct from the surrogate outage_event_id.',
    `outage_duration_minutes` STRING COMMENT 'Total duration of the outage event in minutes, calculated as the difference between restoration_timestamp and outage_start_timestamp. Stored as a business attribute to support SAIDI/SAIFI/CAIDI index calculations and regulatory reporting without requiring real-time computation. Null if restoration has not yet occurred.',
    `outage_start_timestamp` TIMESTAMP COMMENT 'Date and time (ISO 8601 with timezone offset) when the outage event began — i.e., when the interruption to customer electric service was first confirmed by the OMS. This is the principal real-world event time used as the basis for outage duration calculations and SAIDI/SAIFI index reporting.',
    `outage_type` STRING COMMENT 'Classification of the outage event by its nature. unplanned = sustained interruption caused by an unexpected fault or failure; planned = scheduled interruption for maintenance or construction (excluded from SAIDI/SAIFI per IEEE 1366); momentary = interruption lasting less than 5 minutes (excluded from sustained SAIDI/SAIFI but tracked for MAIFI).. Valid values are `unplanned|planned|momentary`',
    `partial_restoration_flag` BOOLEAN COMMENT 'Indicates whether a partial restoration was performed during this outage event — i.e., some customers were restored via switching before the full fault repair was completed. True = partial restoration occurred; False = all customers restored simultaneously. Relevant for multi-step restoration tracking and CAIDI accuracy.',
    `partial_restoration_timestamp` TIMESTAMP COMMENT 'Date and time when the first partial restoration of customers was achieved through switching, prior to full fault repair. Populated only when partial_restoration_flag is True. Used in multi-step CAIDI calculations.',
    `protective_device_type` STRING COMMENT 'Type of protective device that operated to isolate the fault and initiate the outage event. Used for equipment failure analysis, recloser operation tracking, and momentary vs. sustained interruption classification.. Valid values are `recloser|fuse|breaker|sectionalizer|other`',
    `puc_reportable_flag` BOOLEAN COMMENT 'Indicates whether this outage event meets the threshold for mandatory reporting to the State Public Utility Commission (PUC) — e.g., events affecting more than a defined number of customers or exceeding a duration threshold. True = must be included in PUC reliability report; False = below reporting threshold.',
    `reporting_period` STRING COMMENT 'The regulatory reporting period (e.g., 2024-Q1, 2024-Annual) to which this outage event is attributed for SAIDI/SAIFI/CAIDI index reporting to the State PUC. Supports period-based reliability index aggregation and regulatory filing preparation.',
    `restoration_method` STRING COMMENT 'Method used to restore power to affected customers. crew_repair = physical repair of damaged equipment by field crew; switching = manual switching to alternate supply path; auto_recloser = automatic recloser operation restored supply; fuse_replacement = blown fuse replaced; remote_switching = SCADA/DMS-initiated remote switching; temporary_bypass = temporary cable or jumper installed pending permanent repair.. Valid values are `crew_repair|switching|auto_recloser|fuse_replacement|remote_switching|temporary_bypass`',
    `restoration_timestamp` TIMESTAMP COMMENT 'Date and time (ISO 8601 with timezone offset) when power was fully restored to all customers affected by this outage event. Null if the event is still open or in progress. Used with outage_start_timestamp to compute outage duration and CAIDI.',
    `saidi_contribution_minutes` DECIMAL(18,2) COMMENT 'This events contribution to the System Average Interruption Duration Index (SAIDI), calculated as (actual_customers_affected × outage_duration_minutes) / total_customers_served. Stored per event to enable period-level SAIDI aggregation for PUC reliability reporting. Zero for IEEE 1366 excluded events.',
    `saifi_contribution` DECIMAL(18,2) COMMENT 'This events contribution to the System Average Interruption Frequency Index (SAIFI), calculated as actual_customers_affected / total_customers_served. Stored per event to enable period-level SAIFI aggregation for PUC reliability reporting. Zero for IEEE 1366 excluded events.',
    `service_territory_code` STRING COMMENT 'Code identifying the utilitys service territory or operating division in which the outage event occurred. Used for geographic disaggregation of reliability indices across service areas and for multi-territory PUC reporting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this outage event record was most recently modified in the Silver layer, reflecting updates from the OMS such as cause code revisions, customer count corrections, or restoration confirmation. Used for incremental data pipeline processing and audit trail.',
    `weather_condition` STRING COMMENT 'Prevailing weather condition at the time and location of the outage event, as recorded by the OMS operator or derived from weather service data. Used for weather-normalized reliability analysis and major event day (MED) classification under IEEE 1366. [ENUM-REF-CANDIDATE: normal|wind|ice|snow|lightning|flood|heat|hurricane|tornado|other — promote to reference product if expanded]',
    CONSTRAINT pk_distribution_outage_event PRIMARY KEY(`distribution_outage_event_id`)
) COMMENT 'Transactional record for electric distribution outage events — unplanned or planned interruptions to customer electric service tracked through the OMS/DMS. Captures outage event ID, outage type (unplanned/planned/momentary), cause code (weather/equipment failure/animal/vegetation/etc.), affected feeder, affected transformer, estimated customers affected, actual customers affected, outage start timestamp, restoration timestamp, outage duration (minutes), crew dispatch reference, SAIDI contribution (minutes), SAIFI contribution (count), CAIDI calculation, IEEE 1366 exclusion flag, and restoration method. Primary source for SAIDI/SAIFI/CAIDI reliability index calculations reported to PUCs. Sourced from Schneider Electric AMS/GE PowerOn OMS.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`reliability_index` (
    `reliability_index_id` BIGINT COMMENT 'Unique surrogate identifier for each reliability index record. Primary key for the reliability_index data product in the distribution domain Silver layer.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Utilities must meet SAIDI/SAIFI targets defined in regulatory obligations. Direct linkage needed for compliance tracking: which reliability indices fulfill which regulatory performance obligations and',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Reliability metrics (SAIDI/SAIFI) are reported by cost center for performance-based regulation, management reporting, and linking reliability performance to O&M spending. Essential for PBR mechanisms.',
    `distribution_substation_id` BIGINT COMMENT 'Reference to the distribution substation for which this reliability index record is computed. Nullable — populated only when reporting_level is substation. Null for feeder-level and system-level records.',
    `feeder_id` BIGINT COMMENT 'Reference to the distribution feeder for which this reliability index record is computed. Nullable — populated only when reporting_level is feeder. Null for substation-level and system-level records.',
    `caidi_minutes` DECIMAL(18,2) COMMENT 'Customer Average Interruption Duration Index expressed in minutes per interruption. Computed as SAIDI divided by SAIFI (total customer-minutes interrupted divided by total customer interruptions). Measures average restoration time experienced by affected customers per IEEE 1366.',
    `circuit_miles` DECIMAL(18,2) COMMENT 'Total circuit miles of distribution line within the reporting scope (feeder or substation service territory) as of the end of the reporting period. Used for reliability normalization and infrastructure density analysis in PUC benchmarking.',
    `computation_method` STRING COMMENT 'Methodology standard applied to compute the reliability indices in this record. ieee_1366 = standard IEEE 1366 method; puc_specific = state PUC-mandated variant methodology; nerc_standard = NERC-prescribed computation. Ensures traceability of index values to their governing standard.. Valid values are `ieee_1366|puc_specific|nerc_standard`',
    `computed_timestamp` TIMESTAMP COMMENT 'Date and time when the reliability index values (SAIDI, SAIFI, CAIDI, MAIFI) were computed or last recomputed from source outage event data. Serves as the principal business event timestamp for this record. Supports audit trail for regulatory restatements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this reliability index record was first created in the Silver layer data product. Audit timestamp for data lineage and governance tracking.',
    `data_source_system` STRING COMMENT 'Operational system of record from which outage event data was sourced for index computation. oms = Outage Management System (Schneider Electric AMS or GE PowerOn); dms = Distribution Management System; mdms = Meter Data Management System (AMI-derived); manual = manually entered data.. Valid values are `oms|dms|mdms|manual`',
    `index_version` STRING COMMENT 'Sequential version number for this reliability index record, incremented each time the record is revised or amended (e.g., due to outage data corrections or MED reclassification). Version 1 = initial computation. Supports audit trail for regulatory restatements.',
    `interruption_cause_category` STRING COMMENT 'Dominant cause category for interruptions contributing to this reliability index record, per IEEE 1366 cause code taxonomy. Examples: weather, equipment failure, tree contact, animal contact, vehicle accident, planned/scheduled, unknown. [ENUM-REF-CANDIDATE: weather|equipment_failure|tree_contact|animal_contact|vehicle_accident|planned|unknown|other — promote to reference product]',
    `maifi_count` DECIMAL(18,2) COMMENT 'Momentary Average Interruption Frequency Index expressed as average number of momentary interruptions (less than 5 minutes) per customer per reporting period. Tracks recloser and auto-sectionalizer operations per IEEE 1366. Reported separately from sustained interruption indices.',
    `med_event_count` STRING COMMENT 'Number of calendar days during the reporting period that qualified as Major Event Days under the IEEE 1366 beta method threshold. Null when med_exclusion_flag is False. Used in PUC regulatory filings to document the basis for MED exclusions.',
    `med_excluded_saidi_minutes` DECIMAL(18,2) COMMENT 'SAIDI contribution attributable to Major Event Days that has been excluded from the normalized saidi_minutes value per IEEE 1366 beta method. Null when med_exclusion_flag is False. Enables regulators to reconcile normalized vs. total SAIDI in PUC filings.',
    `med_exclusion_flag` BOOLEAN COMMENT 'Indicates whether one or more Major Event Days (MEDs) as defined by IEEE 1366 beta method have been identified and excluded from the reported SAIDI/SAIFI/CAIDI values for this period. True = MED exclusion applied; False = no MED exclusion. Critical for normalized PUC regulatory reporting.',
    `nerc_reportable_flag` BOOLEAN COMMENT 'Indicates whether this reliability index record is subject to NERC reliability reporting requirements (e.g., NERC EOP standards, NERC GADS/TADS reporting). True = NERC reportable; False = state PUC reporting only.',
    `notes` STRING COMMENT 'Free-text field for regulatory analyst annotations, data quality caveats, MED event descriptions, or PUC correspondence notes associated with this reliability index record. Used to document material circumstances affecting index values for regulatory transparency.',
    `overhead_circuit_miles` DECIMAL(18,2) COMMENT 'Circuit miles of overhead distribution line within the reporting scope. Subset of circuit_miles. Overhead lines have higher weather-related interruption exposure. Used for overhead vs. underground reliability segmentation in PUC filings.',
    `prior_year_saidi_minutes` DECIMAL(18,2) COMMENT 'SAIDI value in minutes for the equivalent reporting period in the prior year. Stored on the record to support year-over-year variance analysis in PUC regulatory filings without requiring a self-join. Null for the first year of data.',
    `prior_year_saifi_count` DECIMAL(18,2) COMMENT 'SAIFI value for the equivalent reporting period in the prior year. Stored on the record to support year-over-year variance analysis in PUC regulatory filings without requiring a self-join. Null for the first year of data.',
    `puc_docket_number` STRING COMMENT 'Official docket or case number assigned by the state Public Utility Commission to the regulatory filing in which this reliability index record is included. Enables cross-reference to the regulatory.docket product. Null until assigned by the PUC.',
    `puc_reporting_status` STRING COMMENT 'Current workflow status of this reliability index record in the PUC regulatory reporting lifecycle. draft = in preparation; pending_review = internal review; submitted = filed with state PUC; accepted = PUC acknowledged; rejected = PUC returned for correction; amended = resubmitted after correction.. Valid values are `draft|pending_review|submitted|accepted|rejected|amended`',
    `puc_submission_date` DATE COMMENT 'Calendar date on which this reliability index record was formally submitted to the state Public Utility Commission. Null until puc_reporting_status reaches submitted. Used for regulatory deadline compliance tracking.',
    `reporting_frequency` STRING COMMENT 'Frequency of the regulatory reporting cycle for this index record. monthly for monthly PUC filings, annual for annual NERC/PUC submissions, quarterly for quarterly state commission reports.. Valid values are `monthly|annual|quarterly`',
    `reporting_level` STRING COMMENT 'Discriminator indicating the aggregation level at which reliability indices are computed. system = utility-wide aggregate; substation = substation-level rollup; feeder = individual distribution feeder. Governs nullability of feeder_id and substation_id FK references.. Valid values are `system|substation|feeder`',
    `reporting_period_end` DATE COMMENT 'Last calendar date of the regulatory reporting period covered by this reliability index record (e.g., 2024-01-31 for January 2024 monthly report or 2024-12-31 for annual 2024 report). Aligns with PUC and NERC reporting cycle boundaries.',
    `reporting_period_month` STRING COMMENT 'Calendar month (1–12) of the regulatory reporting period. Null for annual reporting frequency records. Used for monthly PUC reliability filings and intra-year trend analysis.',
    `reporting_period_start` DATE COMMENT 'First calendar date of the regulatory reporting period covered by this reliability index record (e.g., 2024-01-01 for January 2024 monthly report or 2024-01-01 for annual 2024 report). Aligns with PUC and NERC reporting cycle boundaries.',
    `reporting_period_year` STRING COMMENT 'Calendar year of the regulatory reporting period (e.g., 2024). Used as a primary filter dimension for annual PUC filings and year-over-year trend analysis.',
    `saidi_minutes` DECIMAL(18,2) COMMENT 'System Average Interruption Duration Index expressed in minutes per customer. Computed as total customer-minutes interrupted divided by total customers served for the reporting period. Primary reliability metric reported to state PUCs and benchmarked against NERC standards per IEEE 1366.',
    `saidi_with_med_minutes` DECIMAL(18,2) COMMENT 'Total SAIDI value in minutes including all Major Event Day contributions, prior to any MED exclusion. Reported alongside normalized saidi_minutes to provide full transparency in PUC regulatory submissions. Equals saidi_minutes when med_exclusion_flag is False.',
    `saifi_count` DECIMAL(18,2) COMMENT 'System Average Interruption Frequency Index expressed as average number of interruptions per customer per reporting period. Computed as total customer interruptions divided by total customers served. Core IEEE 1366 metric for PUC regulatory reporting.',
    `saifi_with_med_count` DECIMAL(18,2) COMMENT 'Total SAIFI value including all Major Event Day contributions, prior to any MED exclusion. Reported alongside normalized saifi_count for full PUC regulatory transparency. Equals saifi_count when med_exclusion_flag is False.',
    `service_territory_state` STRING COMMENT 'Two-letter US state abbreviation (e.g., CA, TX, NY) identifying the state regulatory jurisdiction under which this reliability index record is reported. Determines the applicable PUC and state-specific reliability reporting requirements.',
    `total_customer_interruptions` BIGINT COMMENT 'Total count of customer interruptions (sustained, greater than or equal to 5 minutes) during the reporting period at the applicable reporting level. Numerator component used in SAIFI calculation. Aggregated from OMS/DMS outage event records.',
    `total_customer_minutes_interrupted` DECIMAL(18,2) COMMENT 'Sum of all customer-minutes interrupted during the reporting period at the applicable reporting level. Numerator component used in SAIDI calculation. Expressed in customer-minutes. Source data aggregated from OMS/DMS outage event records.',
    `total_customers_served` BIGINT COMMENT 'Total number of customers served within the reporting scope (system, substation, or feeder) during the reporting period. Denominator component used in SAIDI and SAIFI calculations. Sourced from CIS/Oracle CC&B or SAP IS-U active service point counts.',
    `underground_circuit_miles` DECIMAL(18,2) COMMENT 'Circuit miles of underground distribution cable within the reporting scope. Subset of circuit_miles. Underground infrastructure typically exhibits lower frequency but longer duration interruptions. Used for overhead vs. underground reliability segmentation.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this reliability index record was most recently modified (e.g., due to outage data correction, MED reclassification, or PUC amendment). Supports change tracking and regulatory restatement audit trail.',
    `utility_identifier` STRING COMMENT 'U.S. Energy Information Administration (EIA) utility entity identifier assigned to the reporting utility. Used as the externally-known business identifier in NERC and EIA reliability data submissions. Aligns with EIA Form 861 and NERC reporting.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal operating voltage in kilovolts (kV) of the feeder or substation bus associated with this reliability index record. Applicable for feeder-level and substation-level records. Null for system-level records. Used for voltage-class segmentation in reliability benchmarking.',
    CONSTRAINT pk_reliability_index PRIMARY KEY(`reliability_index_id`)
) COMMENT 'Periodic transactional record capturing computed SAIDI, SAIFI, and CAIDI reliability indices at the feeder, substation, and system level for regulatory reporting periods (monthly, annual). Captures index record ID, reporting period (month/year), reporting level (system/substation/feeder), associated feeder or substation reference (nullable based on reporting level), SAIDI value (minutes), SAIFI value (interruptions per customer), CAIDI value (minutes per interruption), MAIFI (momentary average interruption frequency), total customer-minutes interrupted, total customers served, IEEE 1366 major event day exclusion flag, excluded SAIDI, and PUC reporting status. SSOT for regulatory reliability performance reporting to state PUCs and NERC. Distinct from raw outage_event records — this is the aggregated index record. FK references to feeder or distribution_substation are nullable depending on reporting_level discriminator (system-level records have no parent entity FK).';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`der_interconnection` (
    `der_interconnection_id` BIGINT COMMENT 'Unique surrogate identifier for each DER interconnection record on the distribution network. Primary key for this entity. Entity role: MASTER_AGREEMENT — represents a binding interconnection agreement and registration between a customer-sited DER and the utility distribution grid.',
    `account_id` BIGINT COMMENT 'Reference to the customer account associated with this DER interconnection. Required for NEM billing, tariff application, and customer program enrollment. Sourced from Oracle CC&B/SAP IS-U account master.',
    `cpcn_application_id` BIGINT COMMENT 'Foreign key linking to regulatory.cpcn_application. Business justification: Large DER projects (utility-scale solar, storage) require CPCN approval before interconnection. Business process: tracking regulatory approval status for significant DER installations that need certif',
    `feeder_id` BIGINT COMMENT 'Reference to the distribution feeder circuit to which this DER is electrically connected. Used for hosting capacity analysis, feeder-level DER aggregation in DERMS, and voltage impact studies. Sourced from ESRI ArcGIS distribution network model.',
    `master_id` BIGINT COMMENT 'Foreign key linking to asset.asset_master. Business justification: DER installations (solar arrays, inverters, battery storage) are utility-tracked or utility-owned assets requiring asset management, warranty tracking, depreciation (for utility-owned), condition moni',
    `participant_registration_id` BIGINT COMMENT 'Foreign key linking to market.participant_registration. Business justification: DERs participating in wholesale markets (via aggregation or direct participation under FERC Order 2222) require market registration tracking for settlement reconciliation, telemetry requirements, and ',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to market.ppa_contract. Business justification: Distributed generation projects often operate under power purchase agreements; tracking PPA terms (pricing, RECs, curtailment rights) for DER interconnections is standard utility practice for contract',
    `service_point_id` BIGINT COMMENT 'Reference to the utility service point (meter location) at which the DER is interconnected. Links the DER to the customer premise, meter, and distribution network topology. Sourced from Oracle CC&B/SAP IS-U service point master.',
    `service_transformer_id` BIGINT COMMENT 'Foreign key linking to distribution.service_transformer. Business justification: DER interconnections connect to the distribution network at service points, which are served by service transformers. The service transformer is the primary hosting point for distributed generation an',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Each DER interconnection operates under a specific tariff schedule (NEM rates, export compensation, standby charges). Essential for billing, rate application, and revenue calculation. Direct business ',
    `transformer_id` BIGINT COMMENT 'Reference to the distribution service transformer through which the DER connects to the grid. Used for transformer loading analysis, hosting capacity calculations, and protection coordination studies.',
    `advanced_inverter_functions_enabled` BOOLEAN COMMENT 'Indicates whether IEEE 1547-2018 advanced inverter functions (volt-VAR optimization, volt-watt, frequency-watt, ride-through) are enabled and configured on this DER. Advanced inverter functions are required for DERMS grid services participation and may be mandated by state PUC rules.',
    `anti_islanding_protection_type` STRING COMMENT 'Type of anti-islanding protection scheme implemented on the DER interconnection to prevent unintentional islanding during grid outages. Passive: frequency/voltage relay-based; Active: active frequency drift or impedance measurement; Hybrid: combination; Transfer Trip: utility-initiated trip signal. Required by IEEE 1547 and NERC reliability standards.. Valid values are `passive|active|hybrid|transfer_trip`',
    `application_date` DATE COMMENT 'Date on which the customer or installer submitted the interconnection application to the utility. Used to track application processing timelines, regulatory queue position, and PUC-mandated processing deadlines.',
    `approval_date` DATE COMMENT 'Date on which the utility approved the interconnection application following technical review. Marks the transition from pending to approved status. Used for processing time reporting to state PUCs.',
    `commissioning_date` DATE COMMENT 'Date on which the DER installation passed final inspection and was energized and commissioned for operation. Marks the start of NEM billing eligibility and DERMS operational status. Sourced from utility field inspection records.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this DER interconnection record was first created in the system. Audit field used for data lineage, regulatory record retention, and Silver layer ingestion tracking. Sourced from Oracle CC&B/SAP IS-U or DERMS platform.',
    `customer_segment` STRING COMMENT 'Customer segment classification for the DER interconnection site. Residential: single-family or multi-family dwelling; Commercial: small to medium business; Industrial: large commercial or industrial customer. Drives applicable interconnection rules, NEM tariff eligibility, and program offerings.. Valid values are `residential|commercial|industrial`',
    `der_type` STRING COMMENT 'Classification of the DER technology installed at the customer premise. Drives NEM eligibility, DERMS dispatch logic, and IEEE 1547 compliance requirements. Values: solar_pv (rooftop/ground-mount photovoltaic), battery_storage (standalone or paired), wind (small wind turbine), chp (Combined Heat and Power), ev_charger (bidirectional EV charging station), fuel_cell.. Valid values are `solar_pv|battery_storage|wind|chp|ev_charger|fuel_cell`',
    `derms_device_code` STRING COMMENT 'External device identifier assigned by the DERMS platform for real-time communication and dispatch of this DER. Used to correlate DERMS telemetry with the interconnection master record. Null if derms_integrated is False.',
    `derms_integrated` BOOLEAN COMMENT 'Indicates whether this DER is registered and actively integrated with the utility DERMS platform for real-time monitoring, dispatch, and grid services. DERMS-integrated DERs are eligible for demand response, voltage support, and frequency regulation programs.',
    `export_capacity_kw` DECIMAL(18,2) COMMENT 'Maximum permitted export capacity to the grid in kilowatts (kW) as specified in the interconnection agreement. May be less than installed AC capacity due to feeder hosting capacity constraints or export limitation agreements. Critical for DERMS dispatch and NEM credit calculations.',
    `export_limitation_flag` BOOLEAN COMMENT 'Indicates whether this DER interconnection is subject to an export limitation agreement restricting the maximum power exported to the grid below the installed AC capacity. Export-limited DERs require DERMS monitoring or smart inverter export control settings.',
    `ieee1547_compliance_status` STRING COMMENT 'Compliance status of the DER installation with IEEE Standard 1547-2018 for interconnection and interoperability of distributed energy resources. Compliant installations may be eligible for advanced inverter functions and DERMS integration. Required for regulatory reporting to state PUCs.. Valid values are `compliant|non_compliant|pending_verification|exempt`',
    `installed_capacity_kw_ac` DECIMAL(18,2) COMMENT 'Nameplate AC inverter output capacity of the DER installation in kilowatts (kW-AC). The AC capacity is the binding limit for grid export and interconnection agreement terms. Used for hosting capacity analysis and DERMS dispatch limits.',
    `installed_capacity_kw_dc` DECIMAL(18,2) COMMENT 'Nameplate DC generating capacity of the DER installation in kilowatts (kW-DC). Applicable primarily to solar PV systems. Used for NEM program sizing, interconnection study thresholds, and RPS tracking. Sourced from interconnection application.',
    `installer_license_number` STRING COMMENT 'State-issued electrical contractor license number for the DER installer. Required for interconnection application validation and regulatory compliance verification.',
    `installer_name` STRING COMMENT 'Name of the licensed electrical contractor or solar installer who performed the DER installation. Used for contractor performance tracking, permit verification, and warranty claim processing.',
    `interconnection_agreement_date` DATE COMMENT 'Date on which the interconnection agreement was fully executed between the customer/installer and the utility. Marks the start of the binding contractual relationship. Used for regulatory reporting and program enrollment tracking.',
    `interconnection_agreement_type` STRING COMMENT 'Type of interconnection agreement executed with the customer. Standard: full interconnection agreement for larger systems; Simplified: streamlined agreement for small systems meeting fast-track criteria; Full Study: agreement following full interconnection study; Expedited: fast-track agreement. Determines contractual terms and cost responsibility.. Valid values are `standard|simplified|full_study|expedited`',
    `interconnection_level` STRING COMMENT 'Interconnection application review level as defined by state PUC fast-track and full study processes. Level 1: simplified/fast-track for small systems below hosting capacity threshold; Level 2: expedited review; Level 3: full interconnection study required. Determines processing timeline and cost responsibility.. Valid values are `level_1|level_2|level_3`',
    `interconnection_number` STRING COMMENT 'Externally-known, human-readable identifier assigned to the interconnection application and agreement (e.g., DER-2024-00412). Used in customer correspondence, regulatory filings, and DERMS integration. Sourced from Oracle CC&B/SAP IS-U interconnection module.',
    `interconnection_point_gis_code` STRING COMMENT 'ESRI ArcGIS feature identifier for the point of interconnection on the distribution network. Enables spatial analysis of DER hosting capacity, feeder penetration mapping, and grid impact visualization. Sourced from ESRI ArcGIS distribution network model.',
    `interconnection_status` STRING COMMENT 'Current lifecycle state of the DER interconnection agreement. Drives operational eligibility for NEM billing, DERMS dispatch, and export permissions. Pending: application submitted; Approved: agreement executed; Commissioned: DER energized and operational; Suspended: temporarily de-energized; Terminated: permanently disconnected; Withdrawn: application cancelled.. Valid values are `pending|approved|commissioned|suspended|terminated|withdrawn`',
    `inverter_manufacturer` STRING COMMENT 'Name of the inverter equipment manufacturer (e.g., Enphase, SolarEdge, SMA, Fronius). Used for equipment compatibility assessment, firmware update tracking, and advanced inverter function certification verification.',
    `inverter_model` STRING COMMENT 'Model designation of the inverter equipment. Used in conjunction with inverter_manufacturer to verify California Energy Commission (CEC) or equivalent certification and IEEE 1547 compliance level.',
    `inverter_type` STRING COMMENT 'Type of inverter technology used in the DER installation. Determines IEEE 1547 advanced inverter function capabilities (volt-VAR, volt-watt, frequency-watt), anti-islanding method, and DERMS controllability. None applies to non-inverter-based DER types such as synchronous CHP generators.. Valid values are `string|microinverter|central|hybrid|none`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this DER interconnection record was most recently modified. Used for change data capture (CDC) in the Databricks Silver layer ETL pipeline and audit trail maintenance.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (WGS84 decimal degrees) of the DER installation site. Used for GIS-based hosting capacity mapping, solar irradiance modeling, and distribution planning.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (WGS84 decimal degrees) of the DER installation site. Used for GIS-based hosting capacity mapping, solar irradiance modeling, and distribution planning.',
    `nem_enrolled` BOOLEAN COMMENT 'Indicates whether this DER interconnection is enrolled in a Net Energy Metering (NEM) program, entitling the customer to bill credits for excess generation exported to the grid. Drives NEM billing logic in Oracle CC&B/SAP IS-U.',
    `nem_tariff_type` STRING COMMENT 'Specific NEM tariff schedule under which the customer receives bill credits for exported generation. NEM 1: legacy retail rate credit; NEM 2: time-of-use with non-bypassable charges; NEM 3 (NEM-Successor): avoided-cost-based export rate; NEM Virtual: community solar; NEM Aggregated: multi-meter aggregation; None: not enrolled in NEM. Sourced from Oracle CC&B/SAP IS-U rate schedule.. Valid values are `nem_1|nem_2|nem_3|nem_virtual|nem_aggregated|none`',
    `permit_number` STRING COMMENT 'Local authority having jurisdiction (AHJ) building or electrical permit number issued for the DER installation. Required for interconnection approval and final commissioning sign-off.',
    `phase_configuration` STRING COMMENT 'Electrical phase configuration of the DER interconnection. Single-phase installations are typical for residential rooftop solar; three-phase for commercial/industrial DER and larger battery storage systems. Affects protection coordination and power quality analysis.. Valid values are `single_phase|three_phase`',
    `rec_eligible` BOOLEAN COMMENT 'Indicates whether the DER installation is eligible to generate Renewable Energy Certificates (RECs) under the applicable state Renewable Portfolio Standard (RPS). Eligible DERs must be registered with the relevant REC tracking system (e.g., WREGIS, PJM-GATS).',
    `storage_capacity_kwh` DECIMAL(18,2) COMMENT 'Usable energy storage capacity in kilowatt-hours (kWh) for battery storage DER types. Null for non-storage DER types. Used for demand response program enrollment, DERMS dispatch scheduling, and grid services valuation.',
    `termination_date` DATE COMMENT 'Date on which the interconnection agreement was terminated or the DER was permanently disconnected from the grid. Null for active interconnections. Used for NEM billing cessation and DERMS deregistration.',
    `utility_program_enrollment` STRING COMMENT 'Utility-sponsored program in which this DER is enrolled beyond NEM. Demand Response: dispatchable load curtailment/generation; Virtual Power Plant: aggregated dispatch program; Grid Services: ancillary service provision; Storage Incentive: battery storage incentive program; None: no additional program enrollment. [ENUM-REF-CANDIDATE: none|demand_response|virtual_power_plant|grid_services|storage_incentive|self_generation_incentive — promote to reference product]. Valid values are `none|demand_response|virtual_power_plant|grid_services|storage_incentive`',
    `voltage_level` STRING COMMENT 'Nominal voltage level at the point of interconnection between the DER and the utility distribution system. Determines protection relay settings, transformer requirements, and IEEE 1547 voltage ride-through parameters.. Valid values are `120v|240v|208v|480v|other`',
    `wregis_code` STRING COMMENT 'Generator registration identifier assigned by WREGIS (or equivalent REC tracking registry) for this DER. Required for REC issuance, RPS compliance reporting, and green tariff program participation. Null if rec_eligible is False.',
    CONSTRAINT pk_der_interconnection PRIMARY KEY(`der_interconnection_id`)
) COMMENT 'Master record for Distributed Energy Resource (DER) interconnections on the distribution network — rooftop solar, battery storage, small wind, CHP, and EV charging installations that connect to the distribution grid at the customer premise. Captures interconnection ID, DER type (solar PV/battery/wind/CHP/EV charger), installed capacity (kW-DC/kW-AC), inverter type, IEEE 1547 compliance status, NEM enrollment flag, NEM tariff type, service point reference, feeder association, transformer association, interconnection agreement date, commissioning date, anti-islanding protection type, export capability (kW), DERMS integration flag, and operational status. SSOT for NEM/DER program management and DERMS integration. Sourced from Oracle CC&B/SAP IS-U and DERMS platform.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` (
    `voltage_regulation_device_id` BIGINT COMMENT 'Unique surrogate identifier for a voltage regulation device record in the distribution domain. Serves as the primary key for this master resource entity.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Voltage regulation device installations are capital projects requiring project tracking for budget management, AFUDC calculation, and CWIP-to-plant transfers. Essential for capital project accounting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Voltage regulation device maintenance and operational costs are allocated to cost centers for O&M expense tracking and regulatory reporting. Required for FERC functional accounting.',
    `distribution_substation_id` BIGINT COMMENT 'Reference to the distribution substation from which the host feeder originates. Used for substation-level voltage regulation coordination, load flow analysis, and regulatory reliability reporting (SAIDI/SAIFI/CAIDI).',
    `feeder_id` BIGINT COMMENT 'Reference to the distribution feeder (circuit) on which this voltage regulation device is installed. Links to the feeder master record in the GIS network topology for circuit-level voltage profile analysis and VOLT/VAR optimization (VVO) program execution.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Voltage regulation devices are capitalized distribution assets requiring fixed asset tracking for depreciation, rate base calculation, and FERC plant accounting. Essential for asset management.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Voltage regulation equipment (capacitor banks, voltage regulators) are procured assets with standardized part numbers. Enables warranty tracking, spare parts inventory management, and standardized pro',
    `bandwidth_v` DECIMAL(18,2) COMMENT 'Voltage bandwidth or deadband setting in volts (V) around the voltage setpoint within which the regulator will not initiate a tap change. A wider bandwidth reduces tap operation count and extends equipment life; a narrower bandwidth improves voltage precision. Expressed on the 120-V base for voltage regulators. Critical parameter for tap wear analysis and CVR program tuning.',
    `circuit_mile_marker` DECIMAL(18,2) COMMENT 'Distance in miles from the substation bus to the point on the feeder where this device is installed, measured along the circuit centerline. Used for voltage drop calculations, protection coordination, and feeder sectionalizing analysis. Aligns with GIS linear referencing.',
    `communication_protocol` STRING COMMENT 'Communication protocol used by the device controller to interface with the SCADA/DMS system for telemetry and remote control. dnp3 — DNP3 (Distributed Network Protocol 3), most common for distribution automation; iec61850 — IEC 61850 substation automation standard; modbus — legacy Modbus RTU/TCP; iccp — Inter-Control Center Communications Protocol; none — no remote communication (manual-only device).. Valid values are `dnp3|iec61850|modbus|iccp|none`',
    `control_mode` STRING COMMENT 'Operating control mode of the voltage regulation device. automatic — device self-regulates based on local voltage sensing and programmed setpoints; manual — field crew or operator manually positions taps or switches; scada — remote control via SCADA system (OSIsoft PI / GE Proficy or Schneider AMS/GE PowerOn DMS); volt_var_optimization — device is under centralized VOLT/VAR optimization (VVO) / DERMS control; disabled — control logic is inactive.. Valid values are `automatic|manual|scada|volt_var_optimization|disabled`',
    `cumulative_tap_operations` BIGINT COMMENT 'Total number of tap change operations recorded on the voltage regulator since installation or last counter reset. A key maintenance trigger metric — most voltage regulators are rated for a finite number of tap operations (e.g., 500,000) before contact replacement is required. Sourced from SCADA historian or field inspection. Used in predictive maintenance scheduling in Oracle WAM / IBM Maximo.',
    `cvr_enrolled` BOOLEAN COMMENT 'Indicates whether this device participates in the utilitys Conservation Voltage Reduction (CVR) program, which intentionally lowers distribution voltage within ANSI C84.1 Range A limits to reduce customer energy consumption and peak demand. CVR-enrolled devices have their voltage setpoints managed to the lower end of the acceptable voltage range during CVR events.',
    `der_hosting_zone` BOOLEAN COMMENT 'Indicates whether this voltage regulation device is located on a feeder segment with high penetration of distributed energy resources (DER) such as rooftop solar (NEM interconnections). When True, the device plays a critical role in managing reverse power flow and voltage rise caused by DER generation, and is subject to enhanced monitoring and DERMS coordination.',
    `device_code` STRING COMMENT 'Externally-known alphanumeric asset tag or utility-assigned device code used to identify this voltage regulation device across operational systems (Oracle WAM/Maximo, GIS, SCADA). Serves as the business-facing identifier referenced in field work orders, GIS records, and SCADA point configurations.. Valid values are `^[A-Z0-9_-]{3,30}$`',
    `device_name` STRING COMMENT 'Human-readable descriptive name or label assigned to the voltage regulation device, typically incorporating feeder name, circuit mile marker, or substation bay designation (e.g., Feeder 12 Reg Bank 1 at Mile 3.2). Used in OMS/DMS displays and field crew communications.',
    `device_subtype` STRING COMMENT 'Further classification of the device configuration. Indicates whether the device is single-phase or three-phase, and for capacitor banks whether it is gang-operated (all phases switched together) or individually switched per phase. Drives field maintenance procedures and SCADA control logic.. Valid values are `single_phase|three_phase|gang_operated|individually_switched`',
    `device_type` STRING COMMENT 'Classification of the voltage regulation device by its primary function on the distribution feeder. voltage_regulator — step-voltage regulator that adjusts tap position to maintain voltage; capacitor_bank — switched or fixed capacitor bank providing reactive power (kVAR) compensation; line_reactor — series or shunt reactor used to absorb excess reactive power or limit fault current.. Valid values are `voltage_regulator|capacitor_bank|line_reactor`',
    `ferc_account_number` STRING COMMENT 'Federal Energy Regulatory Commission (FERC) Uniform System of Accounts (USofA) account number under which this voltage regulation device is capitalized for regulatory rate base reporting. Distribution voltage regulation equipment is typically classified under FERC Account 362 (Station Equipment) or 364 (Poles, Towers, and Fixtures) depending on mounting configuration. Required for FERC Form 1 and state PUC rate case filings.. Valid values are `^[0-9]{3}(.[0-9]{1,3})?$`',
    `gis_object_code` STRING COMMENT 'Unique object identifier assigned to this device in the ESRI ArcGIS geospatial information system, used for network topology linkage, spatial analysis, and field crew navigation. Enables cross-system reconciliation between the asset management system (Oracle WAM/Maximo) and the GIS network model.',
    `in_service_date` DATE COMMENT 'Date on which the voltage regulation device was formally placed into revenue service and began regulating voltage on the feeder. May differ from installation_date if commissioning testing or regulatory approval caused a delay. Used as the AFUDC (Allowance for Funds Used During Construction) capitalization trigger and for FERC rate base reporting.',
    `installation_date` DATE COMMENT 'Calendar date on which the voltage regulation device was physically installed and energized on the distribution feeder. Used to calculate asset age, depreciation schedules (GAAP/FERC Uniform System of Accounts), warranty tracking, and remaining useful life estimates in Oracle WAM / IBM Maximo.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recently completed preventive or corrective maintenance activity performed on this voltage regulation device, as recorded in Oracle WAM / IBM Maximo work management system. Used to calculate maintenance intervals, schedule next PM work orders, and support NERC FAC and state PUC reliability reporting.',
    `last_tap_position` STRING COMMENT 'Most recently recorded tap position of the step-voltage regulator, as reported by the SCADA system (OSIsoft PI / GE Proficy) or field inspection. Negative values indicate buck (voltage reduction) positions; positive values indicate boost (voltage raise) positions; zero is neutral. Used for voltage profile analysis, CVR performance monitoring, and detecting stuck-tap conditions.',
    `last_tap_position_timestamp` TIMESTAMP COMMENT 'Date and time (ISO 8601 with timezone offset) when the last_tap_position reading was recorded or updated from SCADA or field inspection. Used to assess data freshness and detect communication failures with the device controller.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the device installation location in decimal degrees, referenced to the WGS84 datum. Used for GIS mapping, field crew dispatch, storm damage assessment, and spatial analysis of voltage regulation coverage on the distribution network.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the device installation location in decimal degrees, referenced to the WGS84 datum. Used in conjunction with latitude for GIS mapping, spatial proximity analysis, and field operations.',
    `maximo_asset_code` STRING COMMENT 'Asset record identifier assigned in the Enterprise Asset Management system (Oracle WAM or IBM Maximo). Used to cross-reference this voltage regulation device master record with work orders, preventive maintenance plans, failure history, and cost tracking in the EAM system. Serves as the integration key between the distribution data product and the asset management system of record.',
    `mounting_type` STRING COMMENT 'Physical installation configuration of the voltage regulation device on the distribution system. Determines maintenance access requirements, environmental exposure ratings, and applicable construction standards. pole_mounted — overhead distribution pole; pad_mounted — ground-level pad enclosure; substation_installed — within a distribution substation; underground_vault — below-grade vault installation.. Valid values are `pole_mounted|pad_mounted|substation_installed|underground_vault`',
    `nerc_cip_applicable` BOOLEAN COMMENT 'Indicates whether this voltage regulation device is classified as a cyber asset subject to NERC CIP (Critical Infrastructure Protection) standards due to its role in the Bulk Electric System (BES) or its connectivity to BES cyber systems. When True, the device and its communication infrastructure must comply with NERC CIP-002 through CIP-013 requirements.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next scheduled preventive maintenance activity on this voltage regulation device, as generated by the Oracle WAM / IBM Maximo preventive maintenance (PM) scheduling engine. Used for workforce planning, material staging, and outage coordination with the OMS/DMS.',
    `operational_status` STRING COMMENT 'Current lifecycle and operational state of the voltage regulation device on the distribution feeder. in_service — energized and actively regulating voltage; out_of_service — de-energized or bypassed; maintenance — temporarily removed from service for scheduled or corrective maintenance; retired — permanently decommissioned; standby — installed but not actively controlling.. Valid values are `in_service|out_of_service|maintenance|retired|standby`',
    `phase_configuration` STRING COMMENT 'Electrical phase(s) served by this voltage regulation device. Single-phase regulators are assigned to a specific phase (A, B, or C); three-phase devices serve all phases simultaneously. Used for unbalanced load flow analysis, phase-level voltage profiling, and single-phase DER interconnection studies. [ENUM-REF-CANDIDATE: phase_a|phase_b|phase_c|three_phase|phase_ab|phase_bc|phase_ac — promote to reference product]',
    `rated_kva` DECIMAL(18,2) COMMENT 'Nameplate kVA rating of the voltage regulator or line reactor, representing the maximum apparent power the device is designed to handle continuously. Applicable primarily to voltage regulators and line reactors. Null for capacitor banks where rated_kvar is the principal rating. Used in loading analysis and equipment sizing studies.',
    `rated_kvar` DECIMAL(18,2) COMMENT 'Nameplate reactive power rating in kVAR for capacitor banks and reactors. Represents the reactive compensation capacity the device provides or absorbs at rated voltage. Used in VOLT/VAR optimization (VVO), power factor correction studies, and DER integration planning on feeders with high rooftop solar penetration.',
    `rated_voltage_kv` DECIMAL(18,2) COMMENT 'Nameplate system voltage rating of the device in kilovolts (kV), corresponding to the distribution circuit voltage class (e.g., 4.16 kV, 12.47 kV, 25 kV, 34.5 kV). Used to verify compatibility with the host feeder voltage class and for protection relay coordination.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time (ISO 8601 with timezone offset) when this voltage regulation device master record was first created in the distribution data product. Used for data lineage, audit trail, and Silver layer ingestion tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time (ISO 8601 with timezone offset) when this voltage regulation device master record was most recently modified. Used for change data capture (CDC) in the Databricks Lakehouse Silver layer ETL pipeline and for detecting stale records requiring field verification.',
    `retirement_date` DATE COMMENT 'Date on which the voltage regulation device was permanently retired and removed from service. Null for active devices. Used to close the asset record in Oracle WAM / IBM Maximo, trigger final depreciation entries, and remove the device from the active GIS network model.',
    `scada_point_code` STRING COMMENT 'Unique point identifier used in the SCADA/DMS system (Schneider Electric AMS, GE PowerOn, OSIsoft PI, or GE Proficy) to address this voltage regulation device for telemetry, remote control, and alarm monitoring. Maps to the real-time data historian tag for voltage, current, tap position, and switching status. Essential for SCADA integration and real-time grid operations.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number uniquely identifying this specific physical unit. Used for warranty tracking, recall management, and cross-referencing with manufacturer service bulletins. Stored in Oracle WAM / IBM Maximo as the equipment serial number field.',
    `tap_range_max` STRING COMMENT 'Maximum allowable tap position for a step-voltage regulator, representing the maximum voltage boost limit in the raise direction. Typically expressed as a positive integer (e.g., +16 for a ±10% regulator with 32 steps). Used in tap position monitoring and equipment limit enforcement.',
    `tap_range_min` STRING COMMENT 'Minimum allowable tap position for a step-voltage regulator, representing the maximum voltage boost or buck limit in the lower direction. Typically expressed as a negative integer (e.g., -16 for a ±10% regulator with 32 steps). Used in tap position monitoring and equipment limit enforcement.',
    `time_delay_seconds` DECIMAL(18,2) COMMENT 'Intentional time delay in seconds programmed into the voltage regulator or capacitor bank controller before initiating a tap change or switching operation after a voltage deviation is detected. Prevents unnecessary operations due to transient voltage fluctuations (e.g., motor starts, DER intermittency). Coordinated with upstream and downstream devices to avoid hunting.',
    `voltage_setpoint_v` DECIMAL(18,2) COMMENT 'Target regulated voltage in volts (V) that the device controller attempts to maintain at the regulation point. For voltage regulators, this is the output voltage setpoint on the 120-V base. Compared against ANSI C84.1 Range A service voltage limits (114–126 V on 120-V base) for compliance monitoring and conservation voltage reduction (CVR) programs.',
    `vvo_enrolled` BOOLEAN COMMENT 'Indicates whether this voltage regulation device is enrolled in and actively controlled by the utilitys VOLT/VAR optimization (VVO) program, typically managed through the DERMS or DMS platform. When True, the device setpoints and switching schedules may be dynamically adjusted by the VVO algorithm to minimize losses, support CVR, and manage DER-induced voltage fluctuations.',
    CONSTRAINT pk_voltage_regulation_device PRIMARY KEY(`voltage_regulation_device_id`)
) COMMENT 'Master record for voltage regulation equipment deployed on distribution feeders — voltage regulators, capacitor banks, and line reactors used to maintain voltage within ANSI C84.1 service voltage standards along distribution circuits. Captures device ID, device type (voltage regulator/capacitor bank/reactor), feeder location (circuit mile marker), rated kVAR or kVA, control mode (automatic/manual/SCADA), voltage setpoint, bandwidth setting, time delay, installation date, GIS coordinates, SCADA point ID, last tap position, VOLT/VAR optimization (VVO) program enrollment, and operational status. Essential for voltage profile management, power quality, conservation voltage reduction (CVR), and DER integration on feeders with high penetration of rooftop solar.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`switching_operation` (
    `switching_operation_id` BIGINT COMMENT 'Unique identifier for the distribution switching operation record. Primary key for the switching operation transaction.',
    `distribution_outage_event_id` BIGINT COMMENT 'Identifier of the outage event that triggered or is associated with this switching operation. Links to the Outage Management System (OMS) for outage cause, duration, and customer impact tracking. Null for planned switching operations not associated with an outage.',
    `distribution_substation_id` BIGINT COMMENT 'Identifier of the distribution substation associated with the feeder or device operated. Provides geographic and operational context for the switching operation.',
    `feeder_id` BIGINT COMMENT 'Identifier of the distribution feeder circuit affected by the switching operation. Links to the distribution feeder master data for circuit topology, voltage level, and customer count.',
    `authorized_timestamp` TIMESTAMP COMMENT 'Date and time when the switching order was authorized by the control center or authorized supervisor. Establishes the official approval to proceed with the switching operation.',
    `authorizing_supervisor_employee_number` BIGINT COMMENT 'Identifier of the control center operator or field supervisor who authorized the switching order. Establishes accountability for the switching decision.',
    `completed_timestamp` TIMESTAMP COMMENT 'Date and time when the switching operation was marked as completed and all post-switching verification steps were finalized. May differ from operation_timestamp if verification and documentation steps follow the physical switching action.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the switching operation record was first created in the source system. Represents the initial capture of the switching order or operation request.',
    `customers_affected_count` STRING COMMENT 'Number of customer accounts impacted by the switching operation, either through service interruption or restoration. Used for SAIDI/SAIFI/CAIDI reliability index calculations and customer notification requirements.',
    `device_identifier` STRING COMMENT 'Unique identifier or asset tag of the specific distribution device that was operated. Links to the asset management system (EAM) and Geographic Information System (GIS) for device location, specifications, and maintenance history.. Valid values are `^[A-Z0-9-]{6,20}$`',
    `device_operated` STRING COMMENT 'Type of distribution network device that was operated during this switching action. Switches and disconnects provide isolation; reclosers provide automatic fault interruption and restoration; sectionalizers coordinate with reclosers; breakers provide overcurrent protection; fuses provide single-operation protection. [ENUM-REF-CANDIDATE: switch|recloser|sectionalizer|breaker|fuse|disconnect|load_break_switch — 7 candidates stripped; promote to reference product]',
    `dms_system_source` STRING COMMENT 'Name or identifier of the Distribution Management System (DMS) or Outage Management System (OMS) that originated the switching operation record. Examples include Schneider Electric AMS, GE PowerOn, ABB Network Manager. Used for data lineage and system integration tracking.',
    `gis_location_reference` STRING COMMENT 'Geographic Information System (GIS) feature identifier or coordinate reference for the physical location of the device operated. Links to ESRI ArcGIS or equivalent GIS platform for spatial analysis, mapping, and network topology visualization.',
    `interruption_duration_minutes` DECIMAL(18,2) COMMENT 'Duration in minutes that customers experienced service interruption as a result of the switching operation. Used for SAIDI (System Average Interruption Duration Index) calculations and regulatory reporting. Zero for switching operations that did not interrupt service.',
    `load_transferred_kw` DECIMAL(18,2) COMMENT 'Amount of electrical load in kilowatts (kW) transferred from one feeder or circuit segment to another as a result of the switching operation. Used for load balancing analysis and circuit capacity management. Null if the operation did not involve load transfer.',
    `major_event_day_flag` BOOLEAN COMMENT 'Indicates whether the switching operation occurred on a day classified as a Major Event Day (MED) per IEEE 1366 standards. MED events (typically severe weather) are excluded from SAIDI/SAIFI reliability index calculations reported to regulators. True if the operation occurred on a MED; False otherwise.',
    `nerc_reportable_flag` BOOLEAN COMMENT 'Indicates whether the switching operation is associated with an event that meets NERC reporting thresholds for bulk electric system disturbances or reliability events. True if NERC reporting is required; False otherwise.',
    `operation_status` STRING COMMENT 'Current lifecycle status of the switching operation. Tracks progression from authorization through execution to completion or cancellation. Failed status indicates unsuccessful execution; rolled back indicates reversal to prior configuration. [ENUM-REF-CANDIDATE: pending|authorized|in_progress|completed|cancelled|failed|rolled_back — 7 candidates stripped; promote to reference product]',
    `operation_timestamp` TIMESTAMP COMMENT 'Date and time when the switching operation was physically executed in the field. Represents the actual moment the device state changed. Distinct from authorization or completion timestamps. Critical for outage duration calculations and SAIDI/SAIFI/CAIDI reliability index computation.',
    `operation_type` STRING COMMENT 'Classification of the switching operation based on its purpose and planning status. Planned operations are scheduled in advance; emergency operations respond to unplanned events; restoration operations return circuits to normal configuration; maintenance operations support asset work; reconfiguration operations optimize load distribution; fault isolation operations isolate faulted sections.. Valid values are `planned|emergency|restoration|maintenance|reconfiguration|fault_isolation`',
    `operator_employee_number` BIGINT COMMENT 'Identifier of the field technician or operator who physically executed the switching operation. Links to workforce management system for operator qualifications, certifications, and training records. Critical for OSHA lockout/tagout compliance and safety audit trails.',
    `post_switch_configuration` STRING COMMENT 'State of the device after the switching operation was completed. Represents the new configuration achieved by the switching action.. Valid values are `open|closed|grounded|isolated`',
    `pre_switch_configuration` STRING COMMENT 'State of the device immediately before the switching operation was executed. Open indicates no current flow; closed indicates energized and conducting; grounded indicates connected to ground; isolated indicates disconnected from all sources.. Valid values are `open|closed|grounded|isolated`',
    `rollback_flag` BOOLEAN COMMENT 'Indicates whether the switching operation was subsequently reversed or rolled back to the original configuration due to operational issues, equipment problems, or changed conditions. True if the operation was rolled back; False if the new configuration was maintained.',
    `rollback_reason` STRING COMMENT 'Free-text explanation of why the switching operation was rolled back to the original configuration. Null if rollback_flag is False.',
    `safety_clearance_number` STRING COMMENT 'Reference number for the safety clearance or work permit authorizing personnel to work on or near the device. Links to the safety management system for clearance scope, authorized personnel, and expiration. Required for all switching operations involving worker access to energized or de-energized equipment.. Valid values are `^SC-[0-9]{6,10}$`',
    `scada_command_issued_flag` BOOLEAN COMMENT 'Indicates whether the switching operation was executed via remote SCADA command from the control center (True) or manually in the field (False). Remote SCADA operations enable faster response and reduce field crew dispatch requirements.',
    `scada_verification_flag` BOOLEAN COMMENT 'Indicates whether the post-switching device state was verified via SCADA telemetry (True) or required manual field verification (False). SCADA verification provides real-time confirmation of device state.',
    `scheduled_timestamp` TIMESTAMP COMMENT 'Planned date and time for the switching operation to be executed. Applicable to planned and maintenance operations. Null for emergency and unplanned operations.',
    `service_territory_state` STRING COMMENT 'Two-letter US state code where the switching operation occurred. Used for regulatory reporting to state Public Utility Commissions (PUCs) and geographic analysis of switching activity.. Valid values are `^[A-Z]{2}$`',
    `switching_order_number` STRING COMMENT 'Externally-known switching order number issued by the Distribution Management System (DMS) or Outage Management System (OMS) authorizing the switching operation. Serves as the business identifier for tracking and audit purposes.. Valid values are `^SO-[0-9]{8,12}$`',
    `switching_reason_code` STRING COMMENT 'Categorized reason for the switching operation. Fault isolation responds to detected faults; load transfer balances circuit loading; voltage regulation addresses voltage issues; maintenance support enables asset work; storm restoration recovers from weather events; planned outage supports scheduled work; equipment failure responds to device malfunction; customer request fulfills service requests. [ENUM-REF-CANDIDATE: fault_isolation|load_transfer|voltage_regulation|maintenance_support|storm_restoration|planned_outage|equipment_failure|customer_request — 8 candidates stripped; promote to reference product]',
    `switching_reason_description` STRING COMMENT 'Free-text narrative describing the specific business or operational reason for the switching operation. Provides context beyond the categorized reason code, including details of the fault, maintenance activity, or operational need.',
    `tag_lockout_status` STRING COMMENT 'OSHA lockout/tagout (LOTO) status of the device during the switching operation. Tagged indicates warning tag applied; locked out indicates physical lock preventing operation; tagged and locked indicates both controls applied; cleared indicates LOTO removed and device returned to service. Critical for worker safety compliance.. Valid values are `none|tagged|locked_out|tagged_and_locked|cleared`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when the switching operation record was last modified in the source system. Tracks changes to status, completion, or other operational details as the switching operation progresses through its lifecycle.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level in kilovolts (kV) of the circuit or equipment operated. Typical distribution voltage levels include 4.16 kV, 12.47 kV, 13.2 kV, 13.8 kV, 23 kV, 34.5 kV. Voltage level determines safety clearances, equipment ratings, and operational procedures.',
    `weather_condition` STRING COMMENT 'Weather condition at the time of the switching operation. Weather context is critical for understanding emergency switching operations, storm restoration activities, and equipment failure root causes. Used for major event day (MED) exclusion analysis in reliability reporting. [ENUM-REF-CANDIDATE: clear|rain|snow|ice|wind|storm|lightning|fog|extreme_heat|extreme_cold — 10 candidates stripped; promote to reference product]',
    `work_order_number` STRING COMMENT 'Work order number from the Enterprise Asset Management (EAM) or Work Management System (WMS) associated with the switching operation. Links to Oracle WAM, IBM Maximo, or equivalent system for maintenance activity tracking, labor costs, and asset history. Applicable when switching supports planned maintenance or capital work.. Valid values are `^WO-[0-9]{8,12}$`',
    CONSTRAINT pk_switching_operation PRIMARY KEY(`switching_operation_id`)
) COMMENT 'Transactional record for distribution switching operations — planned or emergency switching actions performed on distribution network devices (reclosers, sectionalizers, switches, breakers) to isolate faults, restore service, reconfigure circuits, or enable planned maintenance. Captures switching operation ID, operation type (planned/emergency/restoration), switching order number, device operated (switch/recloser/sectionalizer/breaker), feeder affected, operation timestamp, operator ID, authorization reference, pre-switch configuration, post-switch configuration, customers affected, outage event association, tag/lockout status, safety clearance reference, and completion status. Sourced from Schneider Electric AMS/GE PowerOn DMS and SCADA. Supports OSHA lockout/tagout compliance and switching safety audit trails.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` (
    `gas_leak_survey_id` BIGINT COMMENT 'Unique identifier for the gas leak survey record. Primary key for the gas leak survey transaction.',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_event. Business justification: Detected leaks violating safety standards become compliance events with repair deadlines and potential penalties. Core safety regulatory process: linking leak findings to compliance violations for PHM',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Leak surveys fulfill PHMSA pipeline safety obligations and state-mandated inspection frequencies. Direct regulatory compliance: linking surveys to the specific obligations they satisfy for audit and p',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Leak survey program costs are allocated to cost centers for O&M expense tracking, PHMSA compliance reporting, and regulatory cost recovery. Essential for gas safety program accounting.',
    `gas_main_id` BIGINT COMMENT 'Foreign key reference to the gas distribution main or service lateral segment that was surveyed. Links to the GIS network topology for the pipeline segment.',
    `opex_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.opex_transaction. Business justification: Leak survey activities generate O&M expense transactions for labor and equipment costs. Required for PHMSA compliance cost tracking and regulatory reporting.',
    `repair_work_order_id` BIGINT COMMENT 'Foreign key reference to the work order created for leak repair. Links to EAM system (Oracle WAM, IBM Maximo) for repair tracking and completion verification. Null if no repair required.',
    `work_order_id` BIGINT COMMENT 'Foreign key reference to the employee or contractor who performed the leak survey. Links to workforce management system for qualification tracking and audit trail.',
    `ambient_temperature_f` DECIMAL(18,2) COMMENT 'Ambient air temperature in degrees Fahrenheit at the time of survey. Temperature affects gas dispersion and detector sensitivity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gas leak survey record was first created in the system. Used for audit trail and data lineage tracking.',
    `data_source_system` STRING COMMENT 'Name of the operational system from which this survey record originated (e.g., Oracle WAM, IBM Maximo, ESRI ArcGIS mobile survey app). Used for data lineage and reconciliation.',
    `gas_concentration_ppm` STRING COMMENT 'Measured natural gas concentration in parts per million (PPM) at the leak location. Used for leak grade classification and hazard assessment. Null if no leak detected.',
    `leak_detected_flag` BOOLEAN COMMENT 'Boolean indicator of whether a gas leak was detected during this survey. True if leak found; False if no leak detected.',
    `leak_grade` STRING COMMENT 'AGA and PHMSA leak classification. Grade 1 is hazardous requiring immediate repair; Grade 2 is non-hazardous requiring scheduled repair within one year; Grade 3 is non-hazardous monitored annually.. Valid values are `Grade 1|Grade 2|Grade 3|no leak`',
    `leak_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate of the detected leak location in decimal degrees. Used for GIS mapping and spatial analysis of leak patterns.',
    `leak_location_description` STRING COMMENT 'Textual description of the precise leak location on the pipeline segment (e.g., valve body, joint, service tee, main-to-lateral connection). Used for repair crew dispatch and work order generation.',
    `leak_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate of the detected leak location in decimal degrees. Used for GIS mapping and spatial analysis of leak patterns.',
    `leak_size_estimate_mcf_per_day` DECIMAL(18,2) COMMENT 'Estimated volumetric leak rate in thousand cubic feet (MCF) of natural gas per day. Used for emissions reporting and repair prioritization. Null if no leak detected.',
    `operating_pressure_psig` DECIMAL(18,2) COMMENT 'Operating pressure of the gas distribution system at the survey location in pounds per square inch gauge (PSIG). Used for leak grade classification and hazard assessment.',
    `phmsa_incident_number` STRING COMMENT 'PHMSA-assigned incident tracking number for reportable gas leaks. Used for federal regulatory compliance and incident investigation tracking. Null if not PHMSA-reportable.',
    `phmsa_reportable_flag` BOOLEAN COMMENT 'Boolean indicator of whether this leak meets PHMSA federal reporting thresholds (e.g., incident causing injury, death, or significant property damage). True if reportable to PHMSA; False otherwise.',
    `pipeline_diameter_inches` DECIMAL(18,2) COMMENT 'Nominal diameter of the surveyed pipeline segment in inches. Used for leak size estimation and repair planning.',
    `pipeline_material` STRING COMMENT 'Material composition of the surveyed pipeline segment. PE is polyethylene; HDPE is high-density polyethylene. Material type affects leak risk and survey frequency requirements. [ENUM-REF-CANDIDATE: steel|cast iron|plastic|PE|HDPE|copper|bare steel|coated steel — 8 candidates stripped; promote to reference product]',
    `pipeline_segment_type` STRING COMMENT 'Classification of the pipeline infrastructure component surveyed. Main is distribution backbone; service lateral is customer connection; riser is vertical pipe to meter.. Valid values are `main|service lateral|riser|meter set|valve|regulator station`',
    `prior_survey_date` DATE COMMENT 'Date of the most recent previous leak survey performed on this pipeline segment. Used to verify compliance with PHMSA survey frequency requirements.',
    `puc_reporting_status` STRING COMMENT 'Status of regulatory reporting submission to the state Public Utility Commission. Grade 1 and Grade 2 leaks typically require PUC notification.. Valid values are `not required|pending|submitted|accepted|rejected`',
    `puc_submission_date` DATE COMMENT 'Date on which the leak survey record was submitted to the state Public Utility Commission for regulatory compliance reporting. Null if not yet submitted or not required.',
    `repair_completion_date` DATE COMMENT 'Actual date on which the leak repair was completed and verified. Used for regulatory compliance reporting and SAIDI/SAIFI reliability metrics. Null if repair not yet completed.',
    `repair_due_date` DATE COMMENT 'Regulatory deadline by which the detected leak must be repaired. Grade 1 leaks require immediate action; Grade 2 leaks must be repaired within 12 months per PHMSA. Null if no repair required.',
    `repair_priority` STRING COMMENT 'Work order priority classification for leak repair. Immediate for Grade 1 hazardous leaks; scheduled for Grade 2; monitor for Grade 3.. Valid values are `immediate|urgent|scheduled|monitor|no repair required`',
    `service_territory_state` STRING COMMENT 'Two-letter state code where the survey was performed. Used for state PUC regulatory reporting and jurisdictional compliance tracking.',
    `survey_crew_size` STRING COMMENT 'Number of personnel assigned to the survey crew. Used for workforce planning and cost allocation.',
    `survey_date` DATE COMMENT 'The date on which the leak survey or investigation was performed in the field. Principal business event timestamp for the survey transaction.',
    `survey_duration_hours` DECIMAL(18,2) COMMENT 'Total time in hours spent performing the leak survey. Used for labor cost tracking and productivity analysis.',
    `survey_external_code` STRING COMMENT 'External business identifier for the survey as recorded in the source system (e.g., Oracle WAM, IBM Maximo work order number or survey ticket number). Used for cross-system reconciliation and audit trail.',
    `survey_frequency_months` STRING COMMENT 'Regulatory-mandated survey frequency in months for this pipeline segment. PHMSA requires annual surveys for business districts, multi-year for less critical areas. Used for compliance scheduling.',
    `survey_method` STRING COMMENT 'The leak detection method or technology used during the survey. CGI is Combustible Gas Indicator; bar-hole is physical probe method; flame ionization is laboratory-grade detector.. Valid values are `bar-hole|CGI|flame ionization|infrared camera|soap bubble|electronic detector`',
    `survey_notes` STRING COMMENT 'Free-text field for surveyor observations, special conditions, access issues, or other contextual information relevant to the survey. Used for audit trail and follow-up investigation.',
    `survey_status` STRING COMMENT 'Current lifecycle status of the survey record. Tracks progression from scheduling through completion and regulatory approval.. Valid values are `scheduled|in progress|completed|cancelled|pending review|approved`',
    `survey_type` STRING COMMENT 'Classification of the survey activity. Leak survey is routine PHMSA-mandated inspection; leak investigation is response to reported leak; follow-up survey is re-inspection of previously identified leak.. Valid values are `leak survey|leak investigation|follow-up survey|routine patrol|special survey|damage assessment`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this gas leak survey record was last modified. Used for audit trail and change tracking.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of survey (e.g., clear, rain, snow, wind). Weather can affect leak detection equipment performance and survey accuracy.',
    CONSTRAINT pk_gas_leak_survey PRIMARY KEY(`gas_leak_survey_id`)
) COMMENT 'Transactional record for PHMSA-mandated gas leak surveys and leak investigations on gas distribution mains, service laterals, and associated facilities. Captures survey ID, survey type (leak survey/leak investigation/follow-up), survey date, surveyor ID, pipeline segment surveyed (gas main reference), survey method (bar-hole/CGI/flame ionization), leak grade (Grade 1 hazardous/Grade 2 non-hazardous/Grade 3 non-hazardous), leak location (GPS), leak size estimate (MCF/day), repair priority, repair due date, repair completion date, and regulatory reporting status. SSOT for PHMSA 49 CFR Part 192 pipeline safety compliance and AGA leak survey reporting.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`load_profile` (
    `load_profile_id` BIGINT COMMENT 'Unique identifier for the load profile measurement record. Primary key for the load profile data product.',
    `distribution_substation_id` BIGINT COMMENT 'Reference to the substation where load measurements were captured. Links to the substation asset in the distribution network.',
    `feeder_id` BIGINT COMMENT 'Reference to the distribution feeder where load measurements were captured. Links to the distribution feeder asset in the GIS network topology.',
    `pricing_node_id` BIGINT COMMENT 'Foreign key linking to market.pricing_node. Business justification: Load profiles at pricing nodes drive day-ahead and real-time market bid preparation for load-serving entities. Essential for wholesale energy procurement, load forecasting for market operations, and s',
    `service_transformer_id` BIGINT COMMENT 'Foreign key linking to distribution.service_transformer. Business justification: Load profiles are measured at various points in the distribution network, including service transformers. The load_profile table has measurement_point_type (STRING) which can indicate transformer le',
    `transformer_id` BIGINT COMMENT 'Reference to the service transformer where load measurements were captured. Links to the transformer asset in the distribution network.',
    `ambient_temperature_f` DECIMAL(18,2) COMMENT 'Ambient air temperature in degrees Fahrenheit at the measurement location during the interval. Used for temperature-load correlation analysis and weather normalization.',
    `apparent_power_kva` DECIMAL(18,2) COMMENT 'Average apparent power in kilovolt-amperes during the measurement interval. Represents the total power flow including both real and reactive components.',
    `average_voltage_v` DECIMAL(18,2) COMMENT 'Average voltage in volts measured during the interval. Used for voltage regulation analysis and power quality monitoring.',
    `circuit_miles` DECIMAL(18,2) COMMENT 'Total circuit miles of distribution infrastructure served by the measurement point. Used for load density calculations and capacity planning.',
    `computation_method` STRING COMMENT 'Algorithm or method used to compute aggregated load values from raw telemetry or AMI interval data. Describes the aggregation logic applied by the historian or MDMS system.',
    `computed_timestamp` TIMESTAMP COMMENT 'Date and time when the load profile record was computed or aggregated by the source system. Distinct from the measurement timestamp, represents the processing time.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this load profile record was first created in the lakehouse silver layer. Audit timestamp for data lineage and traceability.',
    `current_amperes` DECIMAL(18,2) COMMENT 'Average current flow in amperes during the measurement interval. Used for thermal loading analysis and conductor capacity assessment.',
    `customer_count` STRING COMMENT 'Number of customers served by the measurement point during the interval. Used for per-customer load analysis and reliability index calculations.',
    `data_quality_flag` STRING COMMENT 'Quality indicator for the load measurement data. Flags data that has been estimated, is suspect, missing, or manually overridden for operational or analytical purposes.. Valid values are `valid|estimated|suspect|missing|manual_override`',
    `data_source_system` STRING COMMENT 'Source system that provided the load measurement data. Indicates whether data originated from SCADA telemetry, aggregated AMI meter reads, DMS, EMS, or historian platform.. Valid values are `scada|ami_aggregation|dms|ems|historian|manual`',
    `demand_response_event_flag` BOOLEAN COMMENT 'Indicates whether a demand response event was active during the measurement interval. True when load curtailment or demand-side management programs were in effect.',
    `der_penetration_percent` DECIMAL(18,2) COMMENT 'Percentage of total load served by Distributed Energy Resources at the measurement point during the interval. Used for DER impact analysis and hosting capacity studies.',
    `energy_delivered_kwh` DECIMAL(18,2) COMMENT 'Total energy delivered in kilowatt-hours during the measurement interval. Represents the integrated real power over the interval duration.',
    `estimation_method` STRING COMMENT 'Method used to estimate or interpolate missing or suspect load data. Describes the algorithm or business rule applied when actual measurements were unavailable.',
    `gis_feature_code` STRING COMMENT 'External identifier linking the load profile to the corresponding feature in the ESRI ArcGIS network topology. Enables spatial analysis and map visualization.',
    `hosting_capacity_analysis_flag` BOOLEAN COMMENT 'Indicates whether this load profile record is used for Distributed Energy Resource (DER) hosting capacity analysis. True when the data supports feeder-level solar or storage impact modeling.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the measurement point in decimal degrees. Used for spatial analysis, weather correlation, and GIS integration.',
    `load_factor` DECIMAL(18,2) COMMENT 'Ratio of average load to peak load during the measurement interval. Indicates the consistency of load demand. Values range from 0 to 1, with higher values indicating more consistent load.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the measurement point in decimal degrees. Used for spatial analysis, weather correlation, and GIS integration.',
    `measurement_interval_minutes` STRING COMMENT 'Duration of the measurement interval in minutes. Common values are 15, 30, or 60 minutes for distribution load profiling and capacity analysis.',
    `measurement_point_name` STRING COMMENT 'Human-readable name or designation of the measurement point in the distribution network. Used for operational identification and reporting.',
    `measurement_point_type` STRING COMMENT 'Type of distribution network measurement point where load data was captured. Indicates the level of aggregation in the distribution hierarchy.. Valid values are `feeder|substation|transformer|circuit|capacitor_bank|voltage_regulator`',
    `measurement_timestamp` TIMESTAMP COMMENT 'Date and time when the load measurement interval ended. Represents the real-world event time for the aggregated load reading from SCADA or AMI systems.',
    `peak_demand_kw` DECIMAL(18,2) COMMENT 'Maximum instantaneous real power demand in kilowatts observed during the measurement interval. Used for capacity planning and hosting capacity studies.',
    `planning_area_code` STRING COMMENT 'Distribution planning area or zone code where the measurement point is located. Used for capacity planning, load forecasting, and capital investment prioritization.',
    `power_factor` DECIMAL(18,2) COMMENT 'Ratio of real power to apparent power during the measurement interval. Indicates the efficiency of power utilization at the measurement point. Values range from 0 to 1.',
    `reactive_power_kvar` DECIMAL(18,2) COMMENT 'Average reactive power in kilovolt-amperes reactive during the measurement interval. Used for voltage regulation and power factor analysis.',
    `real_power_kw` DECIMAL(18,2) COMMENT 'Average real power demand in kilowatts during the measurement interval. Represents the actual power consumed or delivered at the measurement point.',
    `scada_point_code` STRING COMMENT 'External identifier for the SCADA telemetry point in the OSIsoft PI or GE Proficy historian system. Links to the source SCADA tag for traceability.',
    `service_territory_state` STRING COMMENT 'Two-letter state code for the service territory where the measurement point is located. Used for regulatory reporting and jurisdictional analysis.',
    `temperature_adjusted_demand_kw` DECIMAL(18,2) COMMENT 'Real power demand normalized for ambient temperature variations. Used for weather-normalized load forecasting and capacity planning to remove seasonal temperature effects.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this load profile record was last modified in the lakehouse silver layer. Audit timestamp for change tracking and data quality monitoring.',
    `utility_identifier` STRING COMMENT 'Unique identifier for the utility company operating the measurement point. Used for multi-utility environments and regulatory reporting to FERC and state PUCs.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level in kilovolts at the measurement point. Indicates the distribution voltage class for the load profile data.',
    CONSTRAINT pk_load_profile PRIMARY KEY(`load_profile_id`)
) COMMENT 'Transactional record capturing aggregated interval-level load measurements and demand readings at the feeder, substation, and service transformer level for distribution planning, capacity analysis, hosting capacity studies, and demand response program management. Captures load profile ID, measurement point (feeder/substation/transformer), measurement interval (15-min/30-min/60-min), timestamp, real power (kW), reactive power (kVAR), apparent power (kVA), power factor, peak demand (kW), load factor, temperature-adjusted demand, data source (SCADA/AMI aggregation), and data quality flag. Supports DER hosting capacity analysis by providing baseline load data for feeder-level solar/storage impact modeling. Represents aggregated network-level load data for distribution operations — distinct from raw SCADA telemetry points and AMI meter interval reads (owned by metering domain). Granularity is one record per measurement point per interval. Sourced from OSIsoft PI/GE Proficy SCADA historian.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`demand_response_event` (
    `demand_response_event_id` BIGINT COMMENT 'Unique identifier for the demand response event record. Primary key for the demand response event entity.',
    `feeder_id` BIGINT COMMENT 'Identifier of the distribution feeder or circuit targeted by this demand response event, linking to the distribution network topology.',
    `opex_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.opex_transaction. Business justification: Demand response events generate incentive payment transactions to participating customers. Essential for DR program cost tracking, regulatory reporting, and cost recovery mechanisms.',
    `actual_load_reduction_kw` DECIMAL(18,2) COMMENT 'Measured load reduction in kilowatts achieved during the demand response event, calculated from baseline load comparison using Advanced Metering Infrastructure (AMI) or Meter Data Management System (MDMS) interval data.',
    `ambient_temperature_f` DECIMAL(18,2) COMMENT 'Ambient air temperature in degrees Fahrenheit at the time of the demand response event, captured from weather station data to correlate load reduction performance with thermal conditions.',
    `baseline_load_kw` DECIMAL(18,2) COMMENT 'Calculated baseline load in kilowatts representing the expected load absent the demand response event, used as the reference for measuring actual load reduction. Typically calculated using customer baseline load (CBL) methodologies per NAESB standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this demand response event record was first created in the source system, used for data lineage and audit trail purposes.',
    `curtailment_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of notified customers who responded to the demand response event, calculated as (customers_responding_count / customers_notified_count) * 100, used to measure program engagement and effectiveness.',
    `customers_notified_count` STRING COMMENT 'Total number of customers or service points notified of the demand response event through automated messaging, mobile app alerts, or direct load control signals.',
    `customers_responding_count` STRING COMMENT 'Number of customers or service points that actively participated in the demand response event by reducing load, either through voluntary curtailment or direct load control device activation.',
    `data_source_system` STRING COMMENT 'Name of the operational system that originated this demand response event record, typically Distributed Energy Resource Management System (DERMS), Customer Information System (CIS) DR module, or Meter Data Management System (MDMS).',
    `derms_integrated_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this demand response event was dispatched and managed through the utilitys Distributed Energy Resource Management System (DERMS) platform, enabling automated control and telemetry.',
    `dispatch_source` STRING COMMENT 'System or mechanism that initiated the demand response event dispatch: Distributed Energy Resource Management System (DERMS), Distribution Management System (DMS), Outage Management System (OMS), manual operator dispatch, automated schedule, or market signal from Regional Transmission Organization (RTO) or Independent System Operator (ISO).. Valid values are `derms|dms|oms|manual|automated_schedule|market_signal`',
    `event_duration_minutes` STRING COMMENT 'Total duration of the demand response event in minutes, calculated from event start to event end timestamp.',
    `event_end_timestamp` TIMESTAMP COMMENT 'Date and time when the demand response event curtailment period concluded, marking the end of load reduction dispatch and return to normal operations.',
    `event_number` STRING COMMENT 'Business-facing unique identifier or reference number for the demand response event, used for external communication and reporting.',
    `event_outcome_status` STRING COMMENT 'Assessment of the demand response event outcome relative to target objectives: target met (achieved 90-110% of target), target exceeded (>110% of target), target missed (<90% of target), partial success (50-90% of target), or no response (minimal or no measurable load reduction).. Valid values are `target_met|target_exceeded|target_missed|partial_success|no_response`',
    `event_start_timestamp` TIMESTAMP COMMENT 'Date and time when the demand response event curtailment period began, marking the start of load reduction dispatch.',
    `event_status` STRING COMMENT 'Current lifecycle status of the demand response event: scheduled (pending activation), active (currently dispatched), completed (event concluded successfully), cancelled (event aborted before or during execution), or failed (event did not achieve operational objectives).. Valid values are `scheduled|active|completed|cancelled|failed`',
    `event_type` STRING COMMENT 'Classification of the demand response event by operational mechanism: peak shaving (load reduction during system peak), direct load control (utility-controlled device curtailment), voluntary curtailment (customer opt-in reduction), Critical Peak Pricing (CPP) activation (price-signal driven), emergency DR (grid emergency response), or economic DR (market-driven dispatch).. Valid values are `peak_shaving|direct_load_control|voluntary_curtailment|cpp_activation|emergency_dr|economic_dr`',
    `incentive_payment_amount` DECIMAL(18,2) COMMENT 'Total incentive payment amount in US dollars to be paid to participating customers for this demand response event, calculated based on program tariff rates and measured load reduction.',
    `lmp_price_per_mwh` DECIMAL(18,2) COMMENT 'Locational Marginal Price in dollars per megawatt-hour at the distribution zone or pricing node during the demand response event, used for economic DR event valuation and settlement.',
    `load_reduction_percentage` DECIMAL(18,2) COMMENT 'Percentage of target load reduction achieved, calculated as (actual_load_reduction_kw / target_load_reduction_kw) * 100, used to assess event performance.',
    `nerc_reportable_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this demand response event meets North American Electric Reliability Corporation (NERC) reporting thresholds for Demand Response Availability Data System (DADS) or other reliability reporting requirements.',
    `notification_lead_time_minutes` STRING COMMENT 'Number of minutes between customer notification and event start timestamp, representing the advance notice provided to participants.',
    `notification_method` STRING COMMENT 'Primary communication channel used to notify customers of the demand response event: Short Message Service (SMS), email, mobile application push notification, Interactive Voice Response (IVR) call, direct control signal to smart devices, or web portal alert.. Valid values are `sms|email|mobile_app|ivr|direct_control_signal|web_portal`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Penalty amount in US dollars assessed for non-compliance or failure to meet contracted demand response obligations, applicable to capacity-based or firm DR programs.',
    `program_name` STRING COMMENT 'Name of the demand response or demand-side management program under which this event was dispatched, linking to the utilitys portfolio of DR offerings.',
    `puc_reporting_status` STRING COMMENT 'Status of regulatory reporting submission to the state Public Utility Commission (PUC) for this demand response event, used for demand-side management program compliance and cost recovery filings.. Valid values are `pending|submitted|approved|rejected`',
    `puc_submission_date` DATE COMMENT 'Date when demand response event data was submitted to the state Public Utility Commission (PUC) as part of demand-side management program reporting or rate case cost recovery documentation.',
    `rto_iso_event_code` STRING COMMENT 'External event identifier from the Regional Transmission Organization (RTO) or Independent System Operator (ISO) if this demand response event was dispatched in coordination with wholesale market operations or grid emergency procedures.',
    `system_peak_load_mw` DECIMAL(18,2) COMMENT 'Total system peak load in megawatts at the time of the demand response event, providing context for the events contribution to peak shaving and grid reliability.',
    `target_load_reduction_kw` DECIMAL(18,2) COMMENT 'Planned or target load reduction in kilowatts that the demand response event was designed to achieve, representing the dispatch instruction to the distribution network.',
    `target_zone_code` STRING COMMENT 'Geographic or operational zone code identifying the distribution area or load zone targeted for curtailment, used when event scope is broader than a single feeder.',
    `triggering_condition` STRING COMMENT 'The operational or market condition that initiated the demand response event: system peak (forecasted or actual peak load), grid emergency (reliability threat), price signal (high Locational Marginal Price or CPP threshold), capacity shortage (insufficient generation reserves), voltage deviation (distribution voltage issue), or scheduled test (program validation exercise).. Valid values are `system_peak|grid_emergency|price_signal|capacity_shortage|voltage_deviation|scheduled_test`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this demand response event record was last modified in the source system, used for change tracking and data synchronization.',
    `weather_condition` STRING COMMENT 'Description of prevailing weather conditions during the demand response event (e.g., extreme heat, cold snap, high humidity), used for event performance analysis and forecasting model refinement.',
    CONSTRAINT pk_demand_response_event PRIMARY KEY(`demand_response_event_id`)
) COMMENT 'Transactional record for demand response (DR) and load management curtailment events dispatched through the distribution network — peak shaving, direct load control, and DSM program activations targeting distribution-connected load. Captures DR event ID, event type (peak shaving/direct load control/voluntary curtailment/CPP activation), program name, triggering condition (system peak/grid emergency/price signal), event start timestamp, event end timestamp, target feeder or zone, target load reduction (kW), actual load reduction achieved (kW), number of customers notified, number of customers responding, curtailment compliance rate, and event outcome status. Scoped to the distribution-network dispatch and measurement perspective — DR program enrollment and customer participation records are owned by the customer domain; wholesale market DR bidding is owned by the market domain. Sourced from DERMS and Oracle CC&B/SAP IS-U DR program modules.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`pole` (
    `pole_id` BIGINT COMMENT 'Unique identifier for the distribution pole or structure. Primary key for the pole master record.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Poles subject to joint-use agreements, FCC attachment compliance, and inspection cycle obligations. Direct compliance need: tracking which regulatory obligations govern pole inspection, maintenance, a',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Pole inspection, maintenance, and replacement costs are allocated to cost centers for O&M expense tracking and regulatory reporting. Required for FERC functional accounting.',
    `distribution_substation_id` BIGINT COMMENT 'Reference to the distribution substation that serves the feeder associated with this pole. Enables substation-level asset aggregation and planning.',
    `feeder_id` BIGINT COMMENT 'Reference to the distribution feeder circuit that this pole supports. Critical for outage management, reliability analysis, and circuit loading studies.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Poles are capitalized distribution assets requiring fixed asset tracking for depreciation, rate base calculation, and FERC plant accounting. Essential for utility asset accounting.',
    `master_id` BIGINT COMMENT 'Unique asset identifier in the Oracle WAM or IBM Maximo Enterprise Asset Management system. Links pole record to work orders, maintenance history, and financial asset records.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Poles are standardized procured materials tracked by class rating and material type. Essential for storm restoration material staging, inventory planning, and joint-use attachment cost allocation. Ena',
    `replaced_pole_id` BIGINT COMMENT 'Self-referencing FK on pole (replaced_pole_id)',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original purchase and installation cost of the pole structure in USD. Used for capital expenditure tracking, depreciation calculations, and rate base reporting.',
    `book_value` DECIMAL(18,2) COMMENT 'Current net book value of the pole asset after accumulated depreciation. Used for financial reporting, rate case preparation, and asset valuation.',
    `city` STRING COMMENT 'City or municipality where the pole is located. Used for regulatory reporting, service territory analysis, and municipal coordination.',
    `class_rating` STRING COMMENT 'ANSI class designation indicating the poles structural strength and load-bearing capacity (e.g., Class 1, Class 2, Class H1). Determines maximum allowable loading for conductors, transformers, and attachments.',
    `county_name` STRING COMMENT 'County or regional jurisdiction where the pole is located. Used for storm damage assessment, mutual aid coordination, and local regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this pole record was first created in the lakehouse silver layer. Used for data lineage and audit trail.',
    `criticality_rating` STRING COMMENT 'Business criticality classification based on the number of customers served, presence of critical facilities (hospitals, emergency services), and impact of failure on system reliability.. Valid values are `critical|high|medium|low`',
    `data_source_system` STRING COMMENT 'Name of the source system that provided this pole record (e.g., ESRI ArcGIS, Oracle WAM, IBM Maximo). Used for data lineage tracking and reconciliation.',
    `fcc_pole_attachment_compliance_status` STRING COMMENT 'Compliance status with FCC pole attachment regulations governing third-party access, rental rates, and safety clearances for telecommunications and cable TV attachments.. Valid values are `compliant|non_compliant|pending_review|not_applicable`',
    `gis_structure_number` STRING COMMENT 'Unique structure identifier assigned by the ESRI ArcGIS system for network topology modeling and spatial analysis. Links pole record to GIS feature layer.',
    `ground_line_condition` STRING COMMENT 'Structural condition assessment at the ground line where the pole enters the soil. This is the most critical inspection point for wood poles as decay typically begins at ground level.. Valid values are `good|fair|poor|critical|not_assessed`',
    `height_ft` DECIMAL(18,2) COMMENT 'Total height of the pole structure measured in feet from ground level to the top. Used for clearance calculations, loading analysis, and vegetation management planning.',
    `inspection_date` DATE COMMENT 'Date of the most recent pole inspection conducted by utility field crews or third-party contractors. Used to track inspection compliance and schedule next inspection cycle.',
    `inspection_result` STRING COMMENT 'Outcome of the most recent pole inspection indicating structural condition and any required corrective actions. Priority levels indicate urgency of remediation work.. Valid values are `pass|fail|remediate|priority_1|priority_2|priority_3`',
    `installation_date` DATE COMMENT 'Date when the pole was originally installed in the distribution or transmission network. Used for age-based maintenance scheduling and asset lifecycle planning.',
    `installation_year` STRING COMMENT 'Year the pole was installed. Provides simplified age tracking for reporting and analytics when exact installation date is unavailable.',
    `joint_use_attachment_count` STRING COMMENT 'Total number of third-party attachments on the pole including cable TV, telecommunications, and broadband providers. Critical for FCC pole attachment compliance and loading analysis.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent maintenance activity performed on the pole including treatment, repair, or reinforcement work.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the pole location in decimal degrees. Enables GIS mapping, outage management, storm damage assessment, and field crew dispatch.',
    `loading_percentage` DECIMAL(18,2) COMMENT 'Current loading as a percentage of the poles rated capacity based on NESC calculations. Includes weight and wind loading from conductors, transformers, and attachments. Values exceeding 100% indicate overloading requiring remediation.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the pole location in decimal degrees. Enables GIS mapping, outage management, storm damage assessment, and field crew dispatch.',
    `material_type` STRING COMMENT 'Primary construction material of the pole structure. Critical for pole loading analysis, inspection protocols, treatment requirements, and lifecycle management.. Valid values are `wood|steel|concrete|composite|fiberglass|aluminum`',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required pole inspection based on utility inspection cycle policies and regulatory requirements.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the pole structure indicating its availability for service and operational readiness.. Valid values are `in_service|out_of_service|retired|planned|under_construction|damaged`',
    `ownership_type` STRING COMMENT 'Legal ownership classification of the pole structure. Determines maintenance responsibility, cost allocation for joint-use attachments, and regulatory compliance obligations.. Valid values are `utility_owned|joint_use|third_party|municipal|private`',
    `pole_number` STRING COMMENT 'Externally-known utility-assigned pole number or tag identifier used for field operations, maintenance work orders, and joint-use attachment management. This is the business identifier displayed on the physical pole structure.',
    `pole_type` STRING COMMENT 'Classification of the pole based on its primary utility function within the electric or communication infrastructure.. Valid values are `distribution|transmission|joint_use|street_light|communication`',
    `retirement_date` DATE COMMENT 'Date when the pole was removed from service and retired from the distribution network. Used for asset lifecycle tracking and depreciation calculations.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer. Used for warranty claims, quality tracking, and individual asset traceability.',
    `service_territory_code` STRING COMMENT 'Utility-defined service territory or operating division code. Used for asset aggregation, cost allocation, and operational reporting.',
    `state_code` STRING COMMENT 'Two-letter state or province code where the pole is located. Critical for PUC reporting, regulatory compliance, and service territory segmentation.',
    `storm_hardening_flag` BOOLEAN COMMENT 'Indicates whether the pole has been upgraded with storm hardening measures such as stronger materials, deeper embedment, or guy wire reinforcement to improve resilience against extreme weather events.',
    `street_address` STRING COMMENT 'Nearest street address or location description for the pole. Used for field crew dispatch, work order management, and customer outage communication.',
    `treatment_type` STRING COMMENT 'Chemical preservative treatment applied to wood poles to prevent decay and extend service life. CCA (Chromated Copper Arsenate) and pentachlorophenol are common treatments. Relevant only for wood poles.. Valid values are `CCA|pentachlorophenol|creosote|none|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this pole record was last modified in the lakehouse silver layer. Used for change tracking and data freshness monitoring.',
    `vegetation_clearance_zone_ft` DECIMAL(18,2) COMMENT 'Required radial clearance distance in feet from the pole and conductors for vegetation management. Based on voltage level and NERC FAC-003 standards.',
    CONSTRAINT pk_pole PRIMARY KEY(`pole_id`)
) COMMENT 'Master record for distribution poles and structures — wood, steel, concrete, or composite vertical structures that support overhead electric distribution conductors, transformers, switches, and communication attachments. Captures pole ID, material type (wood/steel/concrete/composite), height (feet), class rating, installation year, GPS coordinates, GIS structure number, feeder association, joint-use attachment count, pole loading percentage, inspection date, inspection result (pass/fail/remediate), treatment type (CCA/penta), ground-line condition, ownership type (utility-owned/joint-use/third-party), FCC pole attachment compliance status, and operational status. Critical for pole loading analysis, joint-use attachment management, storm damage assessment, and vegetation management targeting. Sourced from ESRI ArcGIS and Oracle WAM/IBM Maximo.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` (
    `gas_service_lateral_id` BIGINT COMMENT 'Unique identifier for the gas service lateral record. Primary key for the gas service lateral entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service lateral maintenance and leak repair costs are allocated to cost centers for FERC gas utility accounting and regulatory reporting. Essential for rate case cost allocation.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Service laterals are capitalized gas distribution assets tracked in fixed asset register for depreciation, rate base inclusion, and FERC gas plant accounting. Required for regulatory reporting.',
    `gas_main_id` BIGINT COMMENT 'Reference to the gas distribution main from which this service lateral originates. Links the lateral to its upstream distribution infrastructure.',
    `master_id` BIGINT COMMENT 'Asset identifier in the utilitys Enterprise Asset Management system. Links the service lateral to work orders, maintenance history, and asset lifecycle records in Oracle WAM or IBM Maximo.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Gas service laterals are procured pipe materials tracked by specification and diameter. Critical for PHMSA material traceability, excess flow valve program material planning, and service line replacem',
    `service_point_id` BIGINT COMMENT 'Reference to the service point where this lateral terminates at the customer meter location. Establishes the connection between distribution infrastructure and customer delivery point.',
    `upstream_gas_service_lateral_id` BIGINT COMMENT 'Self-referencing FK on gas_service_lateral (upstream_gas_service_lateral_id)',
    `cathodic_protection_flag` BOOLEAN COMMENT 'Indicates whether the service lateral is protected by a cathodic protection system to prevent corrosion of metallic pipe. Required for steel and other metallic laterals under PHMSA corrosion control regulations.',
    `cathodic_protection_type` STRING COMMENT 'Type of cathodic protection system applied to the service lateral. Specifies the corrosion control method used for metallic pipe segments.. Valid values are `impressed_current|galvanic_anode|none|not_applicable`',
    `city` STRING COMMENT 'City or municipality where the service lateral is located. Used for geographic segmentation, regulatory reporting, and service territory management.',
    `coating_type` STRING COMMENT 'Type of external coating or wrapping applied to the service lateral pipe for corrosion protection. Examples include fusion-bonded epoxy, polyethylene tape, or coal tar enamel.',
    `county` STRING COMMENT 'County where the service lateral is located. Used for regulatory reporting, franchise agreement tracking, and geographic analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service lateral record was first created in the system. Used for data lineage, audit trails, and record lifecycle tracking.',
    `dimp_threat_rank` STRING COMMENT 'Risk ranking assigned to the service lateral under the utilitys Distribution Integrity Management Program. Reflects the assessed threat level from corrosion, third-party damage, material failure, and other DIMP threat categories.',
    `district_code` STRING COMMENT 'Operational district or region code where the service lateral is located. Used for field operations management, crew assignment, and performance tracking.',
    `efv_installation_date` DATE COMMENT 'Date when the excess flow valve was installed on the service lateral. Tracks compliance with PHMSA EFV installation requirements and supports maintenance scheduling.',
    `excess_flow_valve_flag` BOOLEAN COMMENT 'Indicates whether an excess flow valve is installed on the service lateral. EFVs are safety devices that automatically restrict gas flow in the event of a line break or excessive flow condition, required under PHMSA regulations for certain installations.',
    `gis_feature_code` STRING COMMENT 'Unique feature identifier assigned to the service lateral in the utilitys GIS system. Links the asset record to its spatial representation in ESRI ArcGIS for mapping and spatial analysis.',
    `installation_date` DATE COMMENT 'Date when the gas service lateral was originally installed and placed into service. Used for age-based risk assessment and replacement planning.',
    `installation_year` STRING COMMENT 'Year when the gas service lateral was installed. Provides simplified temporal reference for vintage analysis and replacement program prioritization.',
    `installed_by` STRING COMMENT 'Name of the contractor, crew, or organization that installed the service lateral. Used for construction quality tracking and warranty management.',
    `joint_type` STRING COMMENT 'Method used to join pipe segments in the service lateral. Examples include heat fusion, mechanical coupling, threaded, or welded joints. Critical for integrity assessment and leak risk evaluation.',
    `last_leak_survey_date` DATE COMMENT 'Date of the most recent leak survey conducted on the service lateral. PHMSA requires periodic leak surveys based on class location and pressure tier to detect and repair gas leaks.',
    `lateral_code` STRING COMMENT 'Business identifier or code assigned to the gas service lateral for operational reference and tracking within the utilitys asset management system.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the service lateral connection point or representative location in decimal degrees. Used for GIS mapping, spatial analysis, and field crew dispatch.',
    `leak_survey_method` STRING COMMENT 'Method or technology used for the most recent leak survey. Examples include flame ionization detector, infrared camera, soap bubble test, or mobile methane detection.',
    `length_ft` DECIMAL(18,2) COMMENT 'Total length of the service lateral from the gas main connection point to the customer meter location, measured in feet. Used for material inventory, replacement cost estimation, and pressure drop calculations.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the service lateral connection point or representative location in decimal degrees. Used for GIS mapping, spatial analysis, and field crew dispatch.',
    `maop_psig` DECIMAL(18,2) COMMENT 'Maximum allowable operating pressure for the service lateral as determined by design, material strength, and regulatory requirements. Critical safety parameter under PHMSA 49 CFR Part 192.',
    `next_leak_survey_due_date` DATE COMMENT 'Scheduled date for the next required leak survey based on PHMSA regulatory frequency requirements and the utilitys integrity management program.',
    `nominal_diameter_in` DECIMAL(18,2) COMMENT 'Nominal inside diameter of the service lateral pipe measured in inches. Determines flow capacity and pressure drop characteristics for gas delivery to the customer.',
    `operating_pressure_psig` DECIMAL(18,2) COMMENT 'Normal operating pressure of the gas service lateral measured in pounds per square inch gauge. Used for pressure tier classification and safety compliance under PHMSA regulations.',
    `operational_status` STRING COMMENT 'Current operational state of the gas service lateral in the distribution network. Indicates whether the lateral is actively delivering gas, out of service, or decommissioned.. Valid values are `active|inactive|abandoned|retired|under_construction|temporarily_out_of_service`',
    `phmsa_class_location` STRING COMMENT 'PHMSA class location designation based on population density and building proximity. Determines design, construction, testing, and operating requirements under 49 CFR Part 192. Class 1 is low density, Class 4 is high density urban areas.. Valid values are `class_1|class_2|class_3|class_4`',
    `pipe_material` STRING COMMENT 'Material composition of the service lateral pipe. Critical for integrity management, leak survey planning, and replacement prioritization under PHMSA Distribution Integrity Management Program (DIMP).. Valid values are `steel|polyethylene|copper|cast_iron|plastic|PVC`',
    `pressure_tier` STRING COMMENT 'Pressure classification tier of the service lateral based on operating pressure ranges. Used for regulatory compliance, inspection frequency determination, and operational planning.. Valid values are `low|medium|high|transmission`',
    `retirement_date` DATE COMMENT 'Date when the service lateral was retired, abandoned, or removed from service. Used for asset lifecycle tracking and historical analysis.',
    `route_geometry_wkt` STRING COMMENT 'Geographic route geometry of the service lateral represented in Well-Known Text format. Captures the spatial path from the gas main to the service point for GIS mapping, spatial analysis, and field operations.',
    `service_territory_code` STRING COMMENT 'Code identifying the utility service territory or operating division responsible for this service lateral. Used for operational planning, cost allocation, and regulatory reporting.',
    `state_code` STRING COMMENT 'Two-letter state or province code where the service lateral is located. Used for regulatory reporting to state Public Utility Commissions and geographic segmentation.',
    `street_address` STRING COMMENT 'Street address or location description where the service lateral is installed. Used for field crew dispatch, customer service inquiries, and asset location reference.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the service lateral record was last modified. Used for change tracking, data quality monitoring, and audit compliance.',
    CONSTRAINT pk_gas_service_lateral PRIMARY KEY(`gas_service_lateral_id`)
) COMMENT 'Master record for gas service laterals — the pipeline segments connecting gas distribution mains to individual customer meters at the service point. Captures lateral ID, associated gas main reference, service point reference, pipe material (steel/PE/copper), nominal diameter (inches), operating pressure (PSIG), installation year, length (feet), excess flow valve (EFV) presence, cathodic protection status, GPS route geometry, PHMSA class location, last leak survey date, and operational status. Distinct from gas mains — laterals are individually regulated assets under PHMSA 49 CFR Part 192 with their own inspection, leak survey, and replacement schedules. SSOT for gas service lateral integrity management and PHMSA compliance. Sourced from ESRI ArcGIS.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`der_dispatch` (
    `der_dispatch_id` BIGINT COMMENT 'Unique surrogate identifier for each DER dispatch record. Primary key for the association.',
    `demand_response_event_id` BIGINT COMMENT 'Foreign key linking to the demand response event for which this DER asset was dispatched',
    `der_interconnection_id` BIGINT COMMENT 'Foreign key linking to the DER interconnection asset being dispatched for this demand response event',
    `baseline_kw` DECIMAL(18,2) COMMENT 'Calculated baseline load for this specific DER asset during the demand response event window, representing expected load absent the DR event. Used to calculate actual load reduction achieved. Explicitly identified in detection phase relationship data.',
    `communication_status` STRING COMMENT 'Status of the communication attempt to dispatch this DER asset for this event. Tracks whether the DERMS successfully communicated with the DER inverter or controller.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this DER asset met its contractual or program-defined response obligation for this demand response event. Drives incentive payment and penalty assessment. Explicitly identified in detection phase relationship data.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this DER dispatch record was created in the DERMS or DR management system.',
    `dispatch_instruction` STRING COMMENT 'Operational instruction sent to this DER asset for this event (e.g., curtail to 50% capacity, discharge battery at 5kW, disable EV charging). Captures asset-specific dispatch commands from DERMS.',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Date and time when the dispatch instruction was sent to this specific DER asset for this demand response event. May differ from event start time due to staggered dispatch or asset-specific lead times. Explicitly identified in detection phase relationship data.',
    `incentive_earned` DECIMAL(18,2) COMMENT 'Financial incentive amount in US dollars earned by this DER asset for participation in this specific demand response event. Calculated based on response_kw, compliance_flag, and program tariff rates. Used for DR program settlement. Explicitly identified in detection phase relationship data.',
    `opt_out_flag` BOOLEAN COMMENT 'Boolean indicator of whether the customer or DER asset operator exercised an opt-out right for this specific demand response event. Affects compliance assessment and incentive calculation. Explicitly identified in detection phase relationship data.',
    `participation_status` STRING COMMENT 'Current status of this DER assets participation in the demand response event. Tracks lifecycle from dispatch through completion and compliance assessment. Explicitly identified in detection phase relationship data.',
    `response_duration_minutes` STRING COMMENT 'Actual duration in minutes that this DER asset actively responded to the demand response event. May differ from overall event duration if the asset was dispatched late, released early, or experienced operational issues. Explicitly identified in detection phase relationship data.',
    `response_kw` DECIMAL(18,2) COMMENT 'Actual load reduction or curtailment capacity delivered by this DER asset during the demand response event, measured in kilowatts. This is the measured performance specific to this DER-event combination. Explicitly identified in detection phase relationship data.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when this DER dispatch record was last updated, typically after performance measurement and compliance assessment.',
    CONSTRAINT pk_der_dispatch PRIMARY KEY(`der_dispatch_id`)
) COMMENT 'This association product represents the operational dispatch of Distributed Energy Resources (DER) in response to demand response events. It captures the participation of individual DER interconnections in specific DR events, including dispatch instructions, actual response performance, compliance measurement, and incentive settlement. Each record links one DER interconnection to one demand response event with attributes that exist only in the context of this dispatch relationship — response capacity committed, actual load reduction delivered, baseline calculation, compliance status, and financial settlement. This is the SSOT for DERMS dispatch operations and DR program settlement.. Existence Justification: In utility DERMS operations, a single DER interconnection (rooftop solar, battery storage, EV charger) participates in multiple demand response events over time — each summer peak event, grid emergency, or price-responsive curtailment dispatches the same DER asset. Conversely, a single demand response event dispatches hundreds or thousands of DER assets simultaneously across a feeder or zone. The business actively manages each dispatch as an operational transaction with performance measurement, compliance tracking, and financial settlement.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` (
    `service_point_dr_participation_id` BIGINT COMMENT 'Unique surrogate identifier for this service point demand response participation record. Primary key for the association.',
    `demand_response_event_id` BIGINT COMMENT 'Foreign key linking to the demand response event in which this service point participated. Identifies the specific DR dispatch event.',
    `service_point_id` BIGINT COMMENT 'Foreign key linking to the service point that participated in the demand response event. Identifies the physical service delivery location whose load was curtailed.',
    `actual_load_kw` DECIMAL(18,2) COMMENT 'Measured actual load in kilowatts consumed by this service point during the DR event window. Used with baseline_kw to calculate response_kw.',
    `baseline_kw` DECIMAL(18,2) COMMENT 'Calculated baseline load in kilowatts for this specific service point during the event window, representing expected load absent the DR event. Used to measure curtailment performance. Sourced from detection phase relationship_data.',
    `compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this service point met the contractual curtailment obligation for this event. Determines incentive payment eligibility and potential penalties. Sourced from detection phase relationship_data.',
    `curtailment_percentage` DECIMAL(18,2) COMMENT 'Percentage of baseline load curtailed by this service point, calculated as (response_kw / baseline_kw) * 100. Performance metric for program evaluation.',
    `enrollment_status` STRING COMMENT 'Status of the service points enrollment in the DR program at the time of this event. Determines eligibility for dispatch and incentive payment. Sourced from detection phase relationship_data.',
    `incentive_earned` DECIMAL(18,2) COMMENT 'Incentive payment amount in US dollars earned by this service point for participation in this specific DR event. Calculated based on response_kw, program rates, and compliance_flag. Used for customer settlement. Sourced from detection phase relationship_data.',
    `notification_method` STRING COMMENT 'Communication channel used to notify this specific service point (customer) of the DR event. May vary by customer preference or program type. Sourced from detection phase relationship_data.',
    `notification_sent_timestamp` TIMESTAMP COMMENT 'Date and time when the DR event notification was sent to this specific service point (customer). Used to calculate lead time and validate compliance with notification requirements. Sourced from detection phase relationship_data.',
    `opt_out_flag` BOOLEAN COMMENT 'Boolean indicator of whether the customer at this service point exercised their opt-out right for this specific event (if program allows per-event opt-out). Affects compliance assessment and incentive calculation. Sourced from detection phase relationship_data.',
    `participation_status` STRING COMMENT 'Outcome status of this service points participation in this DR event. Distinguishes between active response, non-response, opt-out, and technical issues (e.g., AMI communication failure).',
    `response_kw` DECIMAL(18,2) COMMENT 'Actual load reduction in kilowatts achieved by this specific service point during the DR event, calculated as baseline minus actual load. Core performance metric for settlement. Sourced from detection phase relationship_data.',
    CONSTRAINT pk_service_point_dr_participation PRIMARY KEY(`service_point_dr_participation_id`)
) COMMENT 'This association product represents the operational participation record between a service point and a demand response event. It captures the enrollment status, notification delivery, customer response behavior, load curtailment performance, and incentive settlement for each service points participation in each DR event. Each record links one service point to one demand response event with attributes that exist only in the context of this specific participation instance — including notification timestamps, baseline load calculations, actual curtailment achieved, compliance status, and earned incentives. This is the operational SSOT for DR program dispatch, customer response measurement, and settlement processing.. Existence Justification: In utility demand response operations, a service point (customer premise) can participate in multiple DR events over time, and each DR event dispatches to multiple service points simultaneously. The business actively manages each participation instance as an operational record — tracking notification delivery, measuring load curtailment performance against baseline, assessing compliance, and calculating incentive payments. This is not an analytical correlation; it is the operational transaction record for DR dispatch and settlement.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`bus` (
    `bus_id` BIGINT COMMENT 'Primary key for bus',
    `feeder_id` BIGINT COMMENT 'Reference to the distribution feeder circuit that this bus belongs to. Essential for outage management, load balancing, and reliability index calculations.',
    `distribution_substation_id` BIGINT COMMENT 'Reference to the substation where this bus is physically located. Links bus to its parent substation facility for asset management and outage coordination.',
    `zone_id` BIGINT COMMENT 'Reference to the operational or planning zone that this bus belongs to. Used for load forecasting, capacity planning, and regional reliability analysis.',
    `source_bus_id` BIGINT COMMENT 'Self-referencing FK on bus (source_bus_id)',
    `active_power_mw` DECIMAL(18,2) COMMENT 'Net active power injection or withdrawal at the bus in megawatts. Positive values indicate generation; negative values indicate load consumption.',
    `base_voltage_kv` DECIMAL(18,2) COMMENT 'Base voltage used for per-unit calculations in power flow and short circuit analysis. Typically matches the nominal voltage level but may differ for analytical purposes.',
    `bus_name` STRING COMMENT 'Human-readable name or designation of the bus, typically reflecting its location, substation, or functional role in the distribution network.',
    `bus_number` STRING COMMENT 'Externally-known unique identifier for the bus used in operational systems, network diagrams, and engineering documentation. Serves as the business key for cross-system reference.',
    `bus_type` STRING COMMENT 'Classification of the bus based on its electrical function in the power system. Slack bus maintains system voltage and frequency reference; generator bus has active power generation; load bus serves consumption; isolated bus is disconnected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bus record was first created in the system. Supports data lineage and audit trail requirements.',
    `criticality_rating` STRING COMMENT 'Business criticality classification of the bus based on number of customers served, load importance, and system redundancy. Drives prioritization for maintenance and restoration.',
    `der_interconnection_flag` BOOLEAN COMMENT 'Indicates whether distributed energy resources such as solar photovoltaic, wind, or battery storage are interconnected at this bus. Critical for DER management and grid stability analysis.',
    `bus_description` STRING COMMENT 'Free-text description providing additional context about the bus, including special operating conditions, historical notes, or engineering remarks.',
    `energized_flag` BOOLEAN COMMENT 'Indicates whether the bus is currently energized with voltage. True means the bus has voltage applied; false means it is de-energized for maintenance or due to outage.',
    `grounding_type` STRING COMMENT 'Method of neutral grounding at the bus. Critical for fault current calculations, protective relay coordination, and personnel safety.',
    `installation_date` DATE COMMENT 'Date when the bus was originally installed and commissioned in the distribution network. Used for asset age analysis and replacement planning.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical or electrical inspection of the bus. Critical for compliance with maintenance schedules and safety regulations.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the bus location in decimal degrees. Enables GIS mapping, spatial analysis, and proximity-based outage correlation.',
    `load_serving_flag` BOOLEAN COMMENT 'Indicates whether this bus directly serves customer load. True for buses with connected customers; false for transmission or interconnection buses.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the bus location in decimal degrees. Enables GIS mapping, spatial analysis, and proximity-based outage correlation.',
    `max_voltage_limit_pu` DECIMAL(18,2) COMMENT 'Upper voltage limit for the bus in per-unit. Violations trigger voltage regulation actions or alarms in distribution management systems.',
    `min_voltage_limit_pu` DECIMAL(18,2) COMMENT 'Lower voltage limit for the bus in per-unit. Violations trigger voltage regulation actions or alarms in distribution management systems.',
    `next_maintenance_date` DATE COMMENT 'Planned date for the next preventive maintenance activity on the bus. Supports work order scheduling and asset lifecycle management.',
    `operational_status` STRING COMMENT 'Current lifecycle status of the bus in the distribution network. Determines whether the bus is actively participating in power flow calculations and operational dispatch.',
    `ownership_type` STRING COMMENT 'Classification of bus ownership. Determines maintenance responsibility, cost allocation, and regulatory jurisdiction.',
    `phase_configuration` STRING COMMENT 'Electrical phase configuration of the bus. Determines load balancing requirements and equipment compatibility.',
    `reactive_power_mvar` DECIMAL(18,2) COMMENT 'Net reactive power injection or withdrawal at the bus in megavolt-amperes reactive. Critical for voltage control and power factor management.',
    `scada_monitored_flag` BOOLEAN COMMENT 'Indicates whether this bus is monitored by the SCADA system for real-time voltage, power flow, and status telemetry. Essential for distribution management system operations.',
    `short_circuit_mva` DECIMAL(18,2) COMMENT 'Three-phase short circuit capacity at the bus in megavolt-amperes. Critical for protective device coordination, equipment ratings, and safety analysis.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this bus record was last modified. Enables change tracking and data synchronization across systems.',
    `voltage_angle_degrees` DECIMAL(18,2) COMMENT 'Phase angle of the bus voltage relative to the system reference bus, expressed in degrees. Critical for power flow calculations and system stability analysis.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal operating voltage level of the bus expressed in kilovolts. Critical for equipment compatibility, safety clearances, and network topology analysis.',
    `voltage_magnitude_pu` DECIMAL(18,2) COMMENT 'Current voltage magnitude at the bus expressed in per-unit of base voltage. Used for voltage regulation monitoring and power flow analysis. Typically ranges from 0.95 to 1.05 pu under normal conditions.',
    `x_r_ratio` DECIMAL(18,2) COMMENT 'Ratio of reactance to resistance at the bus, used for short circuit analysis and protective relay settings. Higher ratios indicate more inductive systems.',
    CONSTRAINT pk_bus PRIMARY KEY(`bus_id`)
) COMMENT 'Master reference table for bus. Referenced by source_bus_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`city_gate_station` (
    `city_gate_station_id` BIGINT COMMENT 'Primary key for city_gate_station',
    `operator_id` BIGINT COMMENT 'PHMSA-assigned operator identification number for regulatory reporting and compliance tracking.',
    `upstream_city_gate_station_id` BIGINT COMMENT 'Self-referencing FK on city_gate_station (upstream_city_gate_station_id)',
    `asset_criticality_rating` STRING COMMENT 'Risk-based criticality classification of the city gate station based on its importance to system reliability and customer impact.',
    `backup_supply_available` BOOLEAN COMMENT 'Indicates whether an alternate or backup gas supply source is available to serve the territory if this city gate station is unavailable.',
    `city` STRING COMMENT 'City or municipality where the city gate station is located.',
    `construction_material` STRING COMMENT 'Primary material used in the construction of piping and pressure vessels at the city gate station.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the city gate station is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this city gate station record was first created in the system.',
    `design_capacity_mcfd` DECIMAL(18,2) COMMENT 'Maximum designed throughput capacity of the city gate station measured in million cubic feet per day under standard operating conditions.',
    `emergency_shutdown_capable` BOOLEAN COMMENT 'Indicates whether the city gate station is equipped with automated emergency shutdown systems for safety protection.',
    `facility_size_classification` STRING COMMENT 'Size classification of the city gate station based on throughput capacity and infrastructure footprint.',
    `inlet_pressure_psig` DECIMAL(18,2) COMMENT 'Typical or design inlet gas pressure at the city gate station measured in pounds per square inch gauge from the upstream transmission system.',
    `installation_date` DATE COMMENT 'Date when the city gate station was originally installed and commissioned for service.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or operational inspection performed on the city gate station.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this city gate station record was last updated in the system.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the city gate station location in decimal degrees for GIS mapping and spatial analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the city gate station location in decimal degrees for GIS mapping and spatial analysis.',
    `meter_count` STRING COMMENT 'Number of gas metering devices installed at the city gate station for flow measurement and custody transfer.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection of the city gate station per regulatory or maintenance requirements.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special instructions, or historical information about the city gate station.',
    `odorization_required` BOOLEAN COMMENT 'Indicates whether odorant injection is required at this city gate station to meet safety regulations for natural gas distribution.',
    `operational_status` STRING COMMENT 'Current operational state of the city gate station in its lifecycle.',
    `outlet_pressure_psig` DECIMAL(18,2) COMMENT 'Regulated outlet gas pressure at the city gate station measured in pounds per square inch gauge delivered to the distribution system.',
    `owner_operator` STRING COMMENT 'Legal entity or business unit that owns and operates the city gate station.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the city gate station location.',
    `regulator_count` STRING COMMENT 'Number of pressure regulating devices installed at the city gate station to control downstream pressure.',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory authority or jurisdiction that governs the operation and safety compliance of this city gate station.',
    `scada_monitored` BOOLEAN COMMENT 'Indicates whether the city gate station is connected to and monitored by the SCADA system for real-time operational visibility.',
    `service_territory_code` BIGINT COMMENT 'Reference to the service territory that this city gate station serves within the distribution network.',
    `state_province` STRING COMMENT 'State or province code where the city gate station is located.',
    `station_code` STRING COMMENT 'Unique alphanumeric code assigned to the city gate station for operational tracking and system integration.',
    `station_name` STRING COMMENT 'Official name or designation of the city gate station used for identification and operational reference.',
    `station_type` STRING COMMENT 'Classification of the city gate station based on its operational function and pressure regulation role in the gas distribution network.',
    `street_address` STRING COMMENT 'Physical street address of the city gate station facility including street number and name.',
    `telemetry_enabled` BOOLEAN COMMENT 'Indicates whether remote telemetry data transmission is enabled for operational parameters at this city gate station.',
    `upstream_pipeline_name` STRING COMMENT 'Name or identifier of the upstream transmission pipeline connected to this city gate station.',
    `upstream_pipeline_operator` STRING COMMENT 'Name of the interstate or transmission pipeline operator that delivers gas to this city gate station.',
    CONSTRAINT pk_city_gate_station PRIMARY KEY(`city_gate_station_id`)
) COMMENT 'Master reference table for city_gate_station. Referenced by city_gate_station_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`gas_network_node` (
    `gas_network_node_id` BIGINT COMMENT 'Primary key for gas_network_node',
    `district_id` BIGINT COMMENT 'Reference to the operational district responsible for maintenance and operations of this node.',
    `network_model_id` BIGINT COMMENT 'Identifier used in hydraulic network modeling and simulation systems for gas flow analysis.',
    `service_area_id` BIGINT COMMENT 'Reference to the service area or district that this gas network node serves.',
    `from_gas_network_node_id` BIGINT COMMENT 'Self-referencing FK on gas_network_node (from_gas_network_node_id)',
    `city` STRING COMMENT 'City or municipality where the gas network node is located.',
    `commissioned_date` DATE COMMENT 'Date when the gas network node was officially commissioned for operational use.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the gas network node is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this gas network node record was first created in the system.',
    `criticality_rating` STRING COMMENT 'Risk-based criticality assessment of the node based on consequence of failure, customer impact, and system reliability importance.',
    `customer_count` STRING COMMENT 'Number of customers directly or indirectly served by this gas network node, used for outage impact analysis.',
    `decommissioned_date` DATE COMMENT 'Date when the gas network node was taken out of service and decommissioned, if applicable.',
    `gas_network_node_description` STRING COMMENT 'Detailed textual description of the gas network node, including special characteristics, operational notes, or configuration details.',
    `design_pressure_psig` DECIMAL(18,2) COMMENT 'Design pressure rating for the gas network node infrastructure, establishing the engineering basis for safe operation.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation of the gas network node above sea level in feet, relevant for pressure calculations and hydraulic modeling.',
    `gis_feature_code` STRING COMMENT 'Unique identifier linking this node to the corresponding feature in the enterprise GIS system.',
    `installation_date` DATE COMMENT 'Date when the gas network node was originally installed and placed into service.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection performed on the gas network node for safety and compliance verification.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this gas network node record was last updated or modified.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the gas network node in decimal degrees, used for GIS mapping and spatial analysis.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the gas network node in decimal degrees, used for GIS mapping and spatial analysis.',
    `maximum_allowable_operating_pressure_psig` DECIMAL(18,2) COMMENT 'Maximum allowable operating pressure at the node as defined by PHMSA regulations for pipeline safety.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection of the gas network node.',
    `node_name` STRING COMMENT 'Human-readable name or designation of the gas network node, typically reflecting geographic location or functional purpose.',
    `node_number` STRING COMMENT 'Externally-known unique business identifier for the gas network node, used in operational systems and field documentation.',
    `node_status` STRING COMMENT 'Current operational lifecycle status of the gas network node.',
    `node_type` STRING COMMENT 'Classification of the gas network node based on its functional role in the distribution network topology.',
    `notes` STRING COMMENT 'Free-form operational notes or comments about the gas network node for field personnel and operations staff.',
    `operating_pressure_psig` DECIMAL(18,2) COMMENT 'Normal operating pressure at the gas network node measured in pounds per square inch gauge, critical for hydraulic modeling and safety compliance.',
    `owner_type` STRING COMMENT 'Classification indicating the ownership of the gas network node infrastructure.',
    `postal_code` STRING COMMENT 'Postal code of the gas network node location.',
    `pressure_class` STRING COMMENT 'Classification of the node based on operating pressure range, determining regulatory requirements and safety protocols.',
    `scada_monitored_flag` BOOLEAN COMMENT 'Indicates whether the gas network node is monitored by the SCADA system for real-time operational visibility.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the gas network node is located.',
    `street_address` STRING COMMENT 'Physical street address of the gas network node location for field operations and emergency response.',
    `telemetry_device_code` STRING COMMENT 'Identifier of the telemetry or remote monitoring device installed at the node, if applicable.',
    CONSTRAINT pk_gas_network_node PRIMARY KEY(`gas_network_node_id`)
) COMMENT 'Master reference table for gas_network_node. Referenced by from_node_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`crew_dispatch` (
    `crew_dispatch_id` BIGINT COMMENT 'Primary key for crew_dispatch',
    `crew_id` BIGINT COMMENT 'Reference to the crew assigned to this dispatch. Links to the crew master table.',
    `account_id` BIGINT COMMENT 'Reference to the customer account associated with this dispatch. Null for infrastructure-only work not tied to a specific customer.',
    `feeder_id` BIGINT COMMENT 'Reference to the electric distribution feeder associated with this dispatch. Null for gas-only dispatches.',
    `distribution_outage_event_id` BIGINT COMMENT 'Reference to the outage event record if this dispatch is responding to a service interruption. Null for non-outage work.',
    `service_territory_id` BIGINT COMMENT 'Reference to the utility service territory where this dispatch is located. Used for jurisdictional and operational boundaries.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order that triggered this crew dispatch.',
    `reassigned_crew_dispatch_id` BIGINT COMMENT 'Self-referencing FK on crew_dispatch (reassigned_crew_dispatch_id)',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Actual time in hours spent by the crew to complete the dispatch work. Calculated from start and completion timestamps.',
    `after_hours_flag` BOOLEAN COMMENT 'Indicates whether this dispatch occurred outside of normal business hours, triggering premium labor rates.',
    `cancellation_reason` STRING COMMENT 'Explanation for why the dispatch was cancelled. Null if dispatch was not cancelled.',
    `completion_notes` STRING COMMENT 'Crew notes documenting work performed, findings, materials used, and any follow-up actions required.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this dispatch record was first created in the system.',
    `crew_count` STRING COMMENT 'Number of crew members assigned to this dispatch.',
    `customer_contact_name` STRING COMMENT 'Name of the customer contact person for this dispatch. Used for on-site access and communication.',
    `customer_contact_phone` STRING COMMENT 'Phone number for the customer contact. Used for crew communication and arrival notification.',
    `customer_present_required` BOOLEAN COMMENT 'Indicates whether customer presence is required on-site for the crew to perform the work.',
    `dispatch_arrival_timestamp` TIMESTAMP COMMENT 'Date and time when the crew arrived on-site at the dispatch location.',
    `dispatch_assigned_timestamp` TIMESTAMP COMMENT 'Date and time when the crew was assigned to this dispatch.',
    `dispatch_cancelled_timestamp` TIMESTAMP COMMENT 'Date and time when the dispatch was cancelled. Null if dispatch was not cancelled.',
    `dispatch_completed_timestamp` TIMESTAMP COMMENT 'Date and time when the crew completed all work and closed the dispatch assignment.',
    `dispatch_description` STRING COMMENT 'Detailed description of the dispatch work scope, problem reported, or work to be performed.',
    `dispatch_en_route_timestamp` TIMESTAMP COMMENT 'Date and time when the crew departed their current location and began traveling to the dispatch site.',
    `dispatch_location_address` STRING COMMENT 'Street address of the dispatch work location. May include customer premises or infrastructure location.',
    `dispatch_location_city` STRING COMMENT 'City where the dispatch work is located.',
    `dispatch_location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the dispatch work site. Used for crew routing and GIS integration.',
    `dispatch_location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the dispatch work site. Used for crew routing and GIS integration.',
    `dispatch_location_postal_code` STRING COMMENT 'ZIP code of the dispatch work location.',
    `dispatch_location_state` STRING COMMENT 'Two-letter state code where the dispatch work is located.',
    `dispatch_number` STRING COMMENT 'Externally-known unique business identifier for the crew dispatch assignment. Used for tracking and reference across operational systems.',
    `dispatch_priority` STRING COMMENT 'Priority level assigned to the dispatch based on safety, customer impact, and operational criticality. Emergency dispatches receive immediate response.',
    `dispatch_requested_timestamp` TIMESTAMP COMMENT 'Date and time when the dispatch was initially requested or created in the system. Represents the business event time for dispatch initiation.',
    `dispatch_start_work_timestamp` TIMESTAMP COMMENT 'Date and time when the crew began active work on the dispatch assignment.',
    `dispatch_status` STRING COMMENT 'Current lifecycle status of the crew dispatch assignment. Tracks progression from assignment through completion.',
    `dispatch_type` STRING COMMENT 'Classification of the dispatch work activity. Determines crew skill requirements, equipment needs, and response protocols. [ENUM-REF-CANDIDATE: outage_restoration|emergency_response|planned_maintenance|inspection|meter_service|new_connection|disconnection|tree_trimming|leak_repair|damage_assessment|vegetation_management|storm_response — promote to reference product]',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated time in hours required to complete the dispatch work. Used for crew scheduling and resource planning.',
    `hazard_flag` BOOLEAN COMMENT 'Indicates whether hazardous conditions are present at the dispatch location requiring special safety protocols.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this dispatch record was last updated in the system.',
    `scheduled_arrival_date` DATE COMMENT 'Planned date for crew arrival at the dispatch location. Used for scheduled maintenance and non-emergency work.',
    `scheduled_arrival_time_window_end` TIMESTAMP COMMENT 'End of the scheduled time window for crew arrival. Used for customer appointment scheduling.',
    `scheduled_arrival_time_window_start` TIMESTAMP COMMENT 'Beginning of the scheduled time window for crew arrival. Used for customer appointment scheduling.',
    `service_type` STRING COMMENT 'Type of utility service this dispatch addresses. Determines crew specialization and safety protocols.',
    `vehicle_count` STRING COMMENT 'Number of vehicles deployed for this dispatch.',
    CONSTRAINT pk_crew_dispatch PRIMARY KEY(`crew_dispatch_id`)
) COMMENT 'Master reference table for crew_dispatch. Referenced by crew_dispatch_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`protective_device` (
    `protective_device_id` BIGINT COMMENT 'Primary key for protective_device',
    `feeder_id` BIGINT COMMENT 'Reference to the distribution feeder circuit on which this protective device is installed.',
    `distribution_substation_id` BIGINT COMMENT 'Reference to the substation where this protective device is located or to which it is associated.',
    `coordinating_protective_device_id` BIGINT COMMENT 'Self-referencing FK on protective_device (coordinating_protective_device_id)',
    `communication_protocol` STRING COMMENT 'Network communication protocol used by the device for data exchange with control systems (e.g., DNP3, Modbus, IEC 61850).',
    `control_type` STRING COMMENT 'Method by which the protective device is operated or controlled in the distribution network.',
    `coordination_group` STRING COMMENT 'Protection coordination group identifier used to ensure proper sequence of device operations during fault conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this protective device record was first created in the system.',
    `criticality_rating` STRING COMMENT 'Business criticality classification of the protective device based on its impact on system reliability and customer service.',
    `current_state` STRING COMMENT 'Real-time operational state of the protective device as reported by monitoring systems.',
    `customers_affected` STRING COMMENT 'Number of customer accounts downstream of this protective device that would be impacted by its operation or failure.',
    `der_interconnection_flag` BOOLEAN COMMENT 'Indicates whether this protective device is associated with a DER interconnection point or serves a circuit with DER assets.',
    `device_function_code` STRING COMMENT 'IEEE standard function number identifying the specific protection or control function (e.g., 50 for instantaneous overcurrent, 51 for time overcurrent, 27 for undervoltage).',
    `device_name` STRING COMMENT 'Human-readable name or designation of the protective device for operational reference.',
    `device_number` STRING COMMENT 'Externally-known unique identifier or asset tag for the protective device, used in field operations and work orders.',
    `device_type` STRING COMMENT 'Classification of the protective device by its primary protection function in the distribution network.',
    `environmental_rating` STRING COMMENT 'Environmental protection classification indicating the devices suitability for different installation environments.',
    `gas_insulated` BOOLEAN COMMENT 'Indicates whether the protective device uses gas insulation technology (e.g., SF6) rather than air or oil insulation.',
    `installation_date` DATE COMMENT 'Date when the protective device was installed and commissioned in the distribution network.',
    `interrupting_capacity_ka` DECIMAL(18,2) COMMENT 'Maximum fault current in kiloamperes that the device can safely interrupt without damage.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled or corrective maintenance performed on the device.',
    `last_trip_date` TIMESTAMP COMMENT 'Timestamp of the most recent trip or operation event of the protective device.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the protective device location in decimal degrees.',
    `location_description` STRING COMMENT 'Textual description of the physical location or landmark where the protective device is installed.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the protective device location in decimal degrees.',
    `manufacturer` STRING COMMENT 'Name of the company that manufactured the protective device.',
    `model_number` STRING COMMENT 'Manufacturers model or catalog number for the protective device.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next planned maintenance activity on the protective device.',
    `normal_state` STRING COMMENT 'Default or normal operating position of the protective device under standard network conditions.',
    `notes` STRING COMMENT 'Additional operational notes, special instructions, or historical information about the protective device.',
    `operational_status` STRING COMMENT 'Current operational state of the protective device in the distribution network lifecycle.',
    `ownership_type` STRING COMMENT 'Entity that owns the protective device asset.',
    `phase_configuration` STRING COMMENT 'Electrical phase configuration of the circuit protected by this device.',
    `protection_zone` STRING COMMENT 'Designated protection zone or segment of the distribution network covered by this device.',
    `rated_current_amperes` DECIMAL(18,2) COMMENT 'Continuous current rating of the protective device in amperes under normal operating conditions.',
    `rated_voltage_kv` DECIMAL(18,2) COMMENT 'Maximum voltage rating of the protective device in kilovolts, representing the voltage class for which it is designed.',
    `replacement_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost in US dollars to replace the protective device with an equivalent unit, including equipment and installation.',
    `scada_enabled` BOOLEAN COMMENT 'Indicates whether the protective device is integrated with the SCADA system for remote monitoring and control.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific device unit.',
    `trip_count` STRING COMMENT 'Cumulative number of times the protective device has operated or tripped due to fault conditions since installation or last reset.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this protective device record was last modified in the system.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturers warranty coverage for the protective device expires.',
    CONSTRAINT pk_protective_device PRIMARY KEY(`protective_device_id`)
) COMMENT 'Master reference table for protective_device. Referenced by protective_device_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`zone` (
    `zone_id` BIGINT COMMENT 'Primary key for zone',
    `parent_zone_id` BIGINT COMMENT 'Self-referencing FK on zone (parent_zone_id)',
    `caidi_minutes` DECIMAL(18,2) COMMENT 'Average outage duration for customers who experienced an interruption in this zone measured in minutes.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the geographic centroid of the zone for mapping and spatial reference.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the geographic centroid of the zone for mapping and spatial reference.',
    `circuit_miles` DECIMAL(18,2) COMMENT 'Total length of distribution circuits within the zone measured in miles, used for maintenance planning and reliability analysis.',
    `commercial_customer_count` STRING COMMENT 'Number of commercial customers served within this zone.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this zone record was first created in the system.',
    `customer_count` STRING COMMENT 'Total number of active customers served within this distribution zone.',
    `der_capacity_mw` DECIMAL(18,2) COMMENT 'Total installed capacity of distributed energy resources (solar, wind, storage) within this zone measured in megawatts.',
    `zone_description` STRING COMMENT 'Detailed textual description of the zone including geographic landmarks, service characteristics, and operational notes.',
    `effective_date` DATE COMMENT 'Date when this zone configuration became or will become effective in the distribution network.',
    `expiration_date` DATE COMMENT 'Date when this zone configuration expires or is scheduled for decommissioning. Null for active zones with no planned end date.',
    `feeder_id` BIGINT COMMENT 'Reference to the primary distribution feeder serving this zone.',
    `gas_main_miles` DECIMAL(18,2) COMMENT 'Total length of gas distribution mains within the zone measured in miles, applicable for gas or dual-service zones.',
    `gas_service_lateral_count` STRING COMMENT 'Number of gas service laterals (customer connections) within this zone.',
    `gis_boundary_wkt` STRING COMMENT 'Geographic boundary of the zone represented in Well-Known Text format for GIS integration and spatial analysis.',
    `industrial_customer_count` STRING COMMENT 'Number of industrial customers served within this zone.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this zone record was last updated in the system.',
    `nem_interconnection_count` STRING COMMENT 'Number of net energy metering interconnections (typically rooftop solar) within this zone.',
    `notes` STRING COMMENT 'Additional operational notes, special considerations, or historical context for this zone.',
    `operating_pressure_psig` DECIMAL(18,2) COMMENT 'Normal operating pressure for gas distribution system in this zone measured in pounds per square inch gauge (psig).',
    `peak_demand_mw` DECIMAL(18,2) COMMENT 'Maximum electrical demand recorded for this zone measured in megawatts, used for capacity planning and load management.',
    `pole_count` STRING COMMENT 'Total number of utility poles within this zone used for overhead distribution infrastructure.',
    `residential_customer_count` STRING COMMENT 'Number of residential customers served within this zone.',
    `saidi_minutes` DECIMAL(18,2) COMMENT 'Average outage duration per customer in this zone measured in minutes, a key reliability metric.',
    `saifi_count` DECIMAL(18,2) COMMENT 'Average number of interruptions per customer in this zone, a key reliability metric.',
    `service_territory_id` BIGINT COMMENT 'Reference to the parent service territory that contains this zone.',
    `zone_status` STRING COMMENT 'Current operational status of the zone in the distribution network lifecycle.',
    `substation_id` BIGINT COMMENT 'Reference to the primary substation serving this distribution zone.',
    `transformer_count` STRING COMMENT 'Total number of distribution transformers installed within this zone.',
    `underground_percentage` DECIMAL(18,2) COMMENT 'Percentage of distribution infrastructure that is underground versus overhead in this zone.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Primary distribution voltage level for this zone measured in kilovolts.',
    `zone_classification` STRING COMMENT 'Geographic and demographic classification of the zone based on customer density and land use patterns.',
    `zone_code` STRING COMMENT 'Business identifier code for the zone used in operational systems and external reporting.',
    `zone_name` STRING COMMENT 'Human-readable name of the distribution zone for identification and reporting purposes.',
    `zone_type` STRING COMMENT 'Classification of the zone by service type: electric-only, gas-only, or dual-service (both electric and gas).',
    CONSTRAINT pk_zone PRIMARY KEY(`zone_id`)
) COMMENT 'Master reference table for zone. Referenced by zone_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`service_area` (
    `service_area_id` BIGINT COMMENT 'Primary key for service_area',
    `parent_service_area_id` BIGINT COMMENT 'Self-referencing FK on service_area (parent_service_area_id)',
    `annual_energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total annual electric energy consumption for this service area measured in megawatt-hours.',
    `annual_gas_throughput_mcf` DECIMAL(18,2) COMMENT 'Total annual natural gas throughput for this service area measured in thousand cubic feet.',
    `area_square_miles` DECIMAL(18,2) COMMENT 'Total geographic area covered by this service area measured in square miles.',
    `caidi_minutes` DECIMAL(18,2) COMMENT 'Average outage duration per interrupted customer for this service area measured in minutes.',
    `centroid_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the service area geographic centroid in decimal degrees.',
    `centroid_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the service area geographic centroid in decimal degrees.',
    `commercial_customer_count` STRING COMMENT 'Number of commercial customers served within this service area.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service area record was first created in the system.',
    `customer_count` STRING COMMENT 'Total number of active customers served within this service area.',
    `der_capacity_mw` DECIMAL(18,2) COMMENT 'Total installed capacity of distributed energy resources within this service area measured in megawatts.',
    `der_interconnection_count` STRING COMMENT 'Number of distributed energy resource interconnections (solar, wind, storage) within this service area.',
    `service_area_description` STRING COMMENT 'Detailed textual description of the service area including notable landmarks, boundaries, and operational characteristics.',
    `distribution_feeder_count` STRING COMMENT 'Number of electric distribution feeders operating within this service area.',
    `distribution_substation_count` STRING COMMENT 'Number of distribution substations serving this service area.',
    `effective_date` DATE COMMENT 'Date when this service area became operational and began serving customers.',
    `electric_overhead_line_miles` DECIMAL(18,2) COMMENT 'Total length of overhead electric distribution lines within this service area measured in miles.',
    `electric_underground_line_miles` DECIMAL(18,2) COMMENT 'Total length of underground electric distribution lines within this service area measured in miles.',
    `expiration_date` DATE COMMENT 'Date when this service area is scheduled to be decommissioned or transferred, if applicable.',
    `franchise_agreement_id` BIGINT COMMENT 'Reference to the franchise agreement governing utility operations in this service area.',
    `gas_main_miles` DECIMAL(18,2) COMMENT 'Total length of gas distribution mains within this service area measured in miles.',
    `geographic_boundary` STRING COMMENT 'Well-Known Text (WKT) representation of the service area polygon boundary for Geographic Information System (GIS) integration.',
    `industrial_customer_count` STRING COMMENT 'Number of industrial customers served within this service area.',
    `last_boundary_update_date` DATE COMMENT 'Date when the geographic boundary of this service area was last modified in the Geographic Information System (GIS).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service area record was last updated in the system.',
    `service_area_name` STRING COMMENT 'Human-readable name of the service area (e.g., Downtown District, North Region).',
    `nem_customer_count` STRING COMMENT 'Number of customers participating in net energy metering programs within this service area.',
    `operating_district_id` BIGINT COMMENT 'Reference to the operating district responsible for maintenance and operations in this service area.',
    `peak_demand_mw` DECIMAL(18,2) COMMENT 'Maximum electric demand recorded in this service area measured in megawatts.',
    `regulatory_jurisdiction` STRING COMMENT 'State or federal regulatory body with jurisdiction over this service area.',
    `residential_customer_count` STRING COMMENT 'Number of residential customers served within this service area.',
    `saidi_minutes` DECIMAL(18,2) COMMENT 'Average outage duration per customer for this service area measured in minutes, excluding major events.',
    `saifi_count` DECIMAL(18,2) COMMENT 'Average number of interruptions per customer for this service area, excluding major events.',
    `service_area_code` STRING COMMENT 'Business identifier code for the service area used in operational systems and customer communications.',
    `service_area_type` STRING COMMENT 'Classification of the service area based on customer density and land use characteristics.',
    `service_territory_id` BIGINT COMMENT 'Reference to the parent service territory that contains this service area.',
    `service_transformer_count` STRING COMMENT 'Number of service transformers installed within this service area.',
    `service_area_status` STRING COMMENT 'Current operational status of the service area in the utility network.',
    `utility_type` STRING COMMENT 'Type of utility service provided in this area: electric only, gas only, or dual service.',
    `voltage_class_primary_kv` DECIMAL(18,2) COMMENT 'Primary distribution voltage level serving this service area measured in kilovolts.',
    CONSTRAINT pk_service_area PRIMARY KEY(`service_area_id`)
) COMMENT 'Master reference table for service_area. Referenced by service_area_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`district` (
    `district_id` BIGINT COMMENT 'Primary key for district',
    `parent_district_id` BIGINT COMMENT 'Self-referencing FK on district (parent_district_id)',
    `annual_energy_delivered_mwh` DECIMAL(18,2) COMMENT 'Total electric energy delivered to customers in the district annually, measured in megawatt-hours.',
    `annual_gas_delivered_mcf` DECIMAL(18,2) COMMENT 'Total natural gas delivered to customers in the district annually, measured in thousand cubic feet (MCF).',
    `caidi_index` DECIMAL(18,2) COMMENT 'Average outage duration per interrupted customer in minutes for the district. Calculated as SAIDI/SAIFI.',
    `commercial_customer_count` STRING COMMENT 'Number of commercial and industrial customers served in the district.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this district record was first created in the system.',
    `customer_count` STRING COMMENT 'Total number of active customers served within the district boundaries.',
    `der_interconnection_count` STRING COMMENT 'Number of distributed energy resource interconnections (solar, wind, battery storage) within the district.',
    `district_description` STRING COMMENT 'Detailed textual description of the district including geographic boundaries, key landmarks, and operational characteristics.',
    `district_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the district for operational reference and reporting.',
    `district_manager_name` STRING COMMENT 'Name of the manager responsible for operations within this district.',
    `district_office_address` STRING COMMENT 'Physical address of the district operations office.',
    `district_office_phone` STRING COMMENT 'Primary contact phone number for the district operations office.',
    `district_type` STRING COMMENT 'Classification of the district by service type: electric-only, gas-only, or dual-service (both electric and gas).',
    `dms_district_code` STRING COMMENT 'District identifier used in the Distribution Management System for real-time network monitoring and control.',
    `effective_date` DATE COMMENT 'Date when the district became operational or when the current configuration became effective.',
    `electric_circuit_miles` DECIMAL(18,2) COMMENT 'Total length of electric distribution circuits in miles within the district.',
    `emergency_contact_phone` STRING COMMENT '24/7 emergency contact phone number for outage and safety incidents in the district.',
    `end_date` DATE COMMENT 'Date when the district was decommissioned or reorganized. Null for active districts.',
    `feeder_count` STRING COMMENT 'Total number of distribution feeders operating within the district for electric service delivery.',
    `gas_main_miles` DECIMAL(18,2) COMMENT 'Total length of gas distribution mains in miles within the district.',
    `gis_district_code` STRING COMMENT 'District identifier used in the GIS for spatial network topology and asset mapping.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this district record was last modified.',
    `district_name` STRING COMMENT 'Human-readable name of the distribution district (e.g., North Metro District, Downtown Service Area).',
    `nem_customer_count` STRING COMMENT 'Number of customers with net energy metering agreements in the district.',
    `oms_district_code` STRING COMMENT 'District identifier used in the Outage Management System for outage event tracking and dispatch.',
    `peak_demand_mw` DECIMAL(18,2) COMMENT 'Historical peak electric demand in megawatts recorded for the district.',
    `pole_count` STRING COMMENT 'Total number of utility poles installed within the district for overhead distribution infrastructure.',
    `region_id` BIGINT COMMENT 'Reference to the operational region that this district is part of for organizational hierarchy.',
    `residential_customer_count` STRING COMMENT 'Number of residential customers served in the district.',
    `saidi_index` DECIMAL(18,2) COMMENT 'Average outage duration per customer in minutes for the district, excluding major events. Key reliability metric.',
    `saifi_index` DECIMAL(18,2) COMMENT 'Average number of interruptions per customer for the district, excluding major events. Key reliability metric.',
    `service_area_square_miles` DECIMAL(18,2) COMMENT 'Geographic area covered by the district measured in square miles.',
    `service_territory_id` BIGINT COMMENT 'Reference to the parent service territory that this district belongs to.',
    `district_status` STRING COMMENT 'Current operational status of the district in its lifecycle.',
    `substation_count` STRING COMMENT 'Number of distribution substations located within or serving the district.',
    `transformer_count` STRING COMMENT 'Total number of service transformers deployed in the district for voltage step-down to customer premises.',
    `voltage_class` STRING COMMENT 'Primary distribution voltage class served by the district (e.g., 12.47kV, 13.2kV, 34.5kV).',
    CONSTRAINT pk_district PRIMARY KEY(`district_id`)
) COMMENT 'Master reference table for district. Referenced by district_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`network_model` (
    `network_model_id` BIGINT COMMENT 'Primary key for network_model',
    `superseded_network_model_id` BIGINT COMMENT 'Self-referencing FK on network_model (superseded_network_model_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this network model record was first created in the system.',
    `customer_count` STRING COMMENT 'Total number of customers served by the network infrastructure represented in this model.',
    `der_capacity_mw` DECIMAL(18,2) COMMENT 'Total installed capacity of distributed energy resources in megawatts connected to the network model.',
    `der_integration_enabled` BOOLEAN COMMENT 'Indicates whether the network model supports integration of distributed energy resources such as solar, wind, and battery storage systems.',
    `effective_date` DATE COMMENT 'Date from which this network model version became effective and operational for use in planning, operations, and analysis.',
    `expiration_date` DATE COMMENT 'Date when this network model version is scheduled to be retired or replaced, marking the end of its operational validity.',
    `feeder_count` STRING COMMENT 'Total number of distribution feeders included in this network model configuration.',
    `gas_pipeline_safety_compliant` BOOLEAN COMMENT 'Indicates whether the network model for gas distribution infrastructure complies with Pipeline and Hazardous Materials Safety Administration (PHMSA) safety regulations.',
    `gis_layer_reference` STRING COMMENT 'Reference identifier to the GIS layer or spatial dataset that contains the geographic representation of this network model.',
    `last_validation_date` DATE COMMENT 'Date when the network model was last validated for accuracy, completeness, and alignment with physical infrastructure.',
    `model_description` STRING COMMENT 'Detailed textual description of the network model, including its purpose, scope, coverage area, and key characteristics.',
    `model_name` STRING COMMENT 'Human-readable name or designation of the network model used for identification and reference purposes.',
    `model_source_system` STRING COMMENT 'Name or identifier of the source system from which the network model data originates, such as GIS, OMS, DMS, or ADMS.',
    `model_status` STRING COMMENT 'Current lifecycle status of the network model, indicating whether it is active for operational use, in draft, archived, or deprecated.',
    `model_type` STRING COMMENT 'Classification of the network model by infrastructure type, indicating whether it represents electric distribution, gas distribution, transmission, or integrated systems.',
    `model_version` STRING COMMENT 'Version identifier of the network model, tracking iterations and updates to the model configuration.',
    `node_count` STRING COMMENT 'Total number of nodes (connection points, junctions, or vertices) represented in the network model topology.',
    `peak_load_mw` DECIMAL(18,2) COMMENT 'Maximum electrical load in megawatts that the network model is designed to serve under peak demand conditions.',
    `reliability_index_caidi` DECIMAL(18,2) COMMENT 'Customer Average Interruption Duration Index calculated for the network model, measuring average outage duration per customer interruption in minutes.',
    `reliability_index_saidi` DECIMAL(18,2) COMMENT 'System Average Interruption Duration Index calculated for the network model, measuring average outage duration per customer in minutes per year.',
    `reliability_index_saifi` DECIMAL(18,2) COMMENT 'System Average Interruption Frequency Index calculated for the network model, measuring average number of interruptions per customer per year.',
    `scada_enabled` BOOLEAN COMMENT 'Indicates whether the network model is monitored and controlled through SCADA systems for real-time operational visibility.',
    `segment_count` STRING COMMENT 'Total number of line segments or edges connecting nodes in the network model.',
    `service_territory_code` STRING COMMENT 'Geographic service territory identifier that this network model serves, aligning with utility service area boundaries.',
    `substation_id` BIGINT COMMENT 'Reference to the primary substation that serves as the source or hub for this network model.',
    `topology_type` STRING COMMENT 'Physical topology configuration of the network model, describing the structural arrangement of feeders, nodes, and interconnections.',
    `total_circuit_miles` DECIMAL(18,2) COMMENT 'Total length of all circuits in the network model measured in miles, representing the cumulative distance of distribution infrastructure.',
    `updated_by` STRING COMMENT 'Identifier of the user or system that last updated this network model record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this network model record was last modified or updated.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Primary operating voltage level of the network model in kilovolts, representing the nominal voltage at which the network operates.',
    `created_by` STRING COMMENT 'Identifier of the user or system that created this network model record.',
    CONSTRAINT pk_network_model PRIMARY KEY(`network_model_id`)
) COMMENT 'Master reference table for network_model. Referenced by network_model_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`distribution`.`service_territory` (
    `service_territory_id` BIGINT COMMENT 'Primary key for service_territory',
    `parent_service_territory_id` BIGINT COMMENT 'Self-referencing FK on service_territory (parent_service_territory_id)',
    `annual_energy_sales_mwh` DECIMAL(18,2) COMMENT 'Total electric energy sold annually within the service territory measured in megawatt-hours.',
    `boundary_description` STRING COMMENT 'Textual description of the geographic boundaries defining the service territory, including landmarks and jurisdictional limits.',
    `boundary_geojson` STRING COMMENT 'GeoJSON representation of the service territory polygon for GIS mapping and spatial analysis.',
    `caidi_minutes` DECIMAL(18,2) COMMENT 'Average outage duration per interrupted customer in the service territory measured in minutes.',
    `climate_zone` STRING COMMENT 'Climate classification of the service territory used for load forecasting and infrastructure planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service territory record was first created in the system.',
    `customer_count` BIGINT COMMENT 'Total number of active customer accounts within the service territory.',
    `der_capacity_mw` DECIMAL(18,2) COMMENT 'Total installed capacity of distributed energy resources within the service territory measured in megawatts.',
    `effective_date` DATE COMMENT 'Date on which the service territory definition became operationally effective.',
    `electric_circuit_miles` DECIMAL(18,2) COMMENT 'Total length of electric distribution circuits within the service territory measured in circuit miles.',
    `franchise_agreement_number` STRING COMMENT 'Identifier for the municipal or county franchise agreement authorizing utility service in the territory.',
    `franchise_expiration_date` DATE COMMENT 'Date on which the current franchise agreement expires and requires renewal or renegotiation.',
    `gas_pipeline_miles` DECIMAL(18,2) COMMENT 'Total length of natural gas distribution pipeline infrastructure within the service territory measured in miles.',
    `gas_throughput_mcf` DECIMAL(18,2) COMMENT 'Total natural gas volume delivered annually within the service territory measured in thousand cubic feet.',
    `jurisdiction_type` STRING COMMENT 'Classification of the regulatory oversight model governing the service territory.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the service territory record was last updated in the system.',
    `nem_interconnection_count` STRING COMMENT 'Total number of net energy metering interconnections approved and active within the service territory.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, boundary clarifications, or special considerations for the service territory.',
    `operating_company_id` BIGINT COMMENT 'Reference to the legal operating entity responsible for utility service delivery within this territory.',
    `peak_demand_mw` DECIMAL(18,2) COMMENT 'Historical maximum electric demand recorded in the service territory measured in megawatts.',
    `population_served` BIGINT COMMENT 'Estimated total population residing within the service territory boundaries.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary operational contact for the service territory.',
    `primary_contact_name` STRING COMMENT 'Name of the primary operational contact or territory manager responsible for this service territory.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary operational contact for the service territory.',
    `region_id` BIGINT COMMENT 'Reference to the parent operational region or division to which this service territory belongs.',
    `regulatory_jurisdiction` STRING COMMENT 'Name of the state or federal regulatory body with oversight authority over this service territory.',
    `saidi_minutes` DECIMAL(18,2) COMMENT 'Average outage duration per customer in the service territory measured in minutes, excluding major events.',
    `saifi_count` DECIMAL(18,2) COMMENT 'Average number of sustained interruptions per customer in the service territory, excluding major events.',
    `service_area_square_miles` DECIMAL(18,2) COMMENT 'Total geographic area covered by the service territory measured in square miles.',
    `service_territory_status` STRING COMMENT 'Current lifecycle status of the service territory indicating operational availability.',
    `substation_count` STRING COMMENT 'Total number of electric substations serving the service territory.',
    `termination_date` DATE COMMENT 'Date on which the service territory was retired or merged into another territory, if applicable.',
    `territory_code` STRING COMMENT 'Externally-known unique alphanumeric code identifying the service territory for regulatory reporting and operational reference.',
    `territory_name` STRING COMMENT 'Human-readable name of the service territory, typically reflecting geographic or administrative boundaries.',
    `territory_type` STRING COMMENT 'Classification of the service territory by utility service type provided within the geographic area.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the primary time zone of the service territory used for operational scheduling and reporting.',
    `urban_rural_classification` STRING COMMENT 'Demographic classification of the service territory based on population density and development patterns.',
    CONSTRAINT pk_service_territory PRIMARY KEY(`service_territory_id`)
) COMMENT 'Master reference table for service_territory. Referenced by service_territory_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ADD CONSTRAINT `fk_distribution_service_transformer_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ADD CONSTRAINT `fk_distribution_service_transformer_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ADD CONSTRAINT `fk_distribution_service_transformer_pole_id` FOREIGN KEY (`pole_id`) REFERENCES `power_and_utilities`.`distribution`.`pole`(`pole_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ADD CONSTRAINT `fk_distribution_service_point_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ADD CONSTRAINT `fk_distribution_service_point_gas_main_id` FOREIGN KEY (`gas_main_id`) REFERENCES `power_and_utilities`.`distribution`.`gas_main`(`gas_main_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ADD CONSTRAINT `fk_distribution_service_point_service_transformer_id` FOREIGN KEY (`service_transformer_id`) REFERENCES `power_and_utilities`.`distribution`.`service_transformer`(`service_transformer_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_city_gate_station_id` FOREIGN KEY (`city_gate_station_id`) REFERENCES `power_and_utilities`.`distribution`.`city_gate_station`(`city_gate_station_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_gas_network_node_id` FOREIGN KEY (`gas_network_node_id`) REFERENCES `power_and_utilities`.`distribution`.`gas_network_node`(`gas_network_node_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_protective_device_id` FOREIGN KEY (`protective_device_id`) REFERENCES `power_and_utilities`.`distribution`.`protective_device`(`protective_device_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ADD CONSTRAINT `fk_distribution_reliability_index_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ADD CONSTRAINT `fk_distribution_reliability_index_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ADD CONSTRAINT `fk_distribution_der_interconnection_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ADD CONSTRAINT `fk_distribution_der_interconnection_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ADD CONSTRAINT `fk_distribution_der_interconnection_service_transformer_id` FOREIGN KEY (`service_transformer_id`) REFERENCES `power_and_utilities`.`distribution`.`service_transformer`(`service_transformer_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ADD CONSTRAINT `fk_distribution_voltage_regulation_device_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ADD CONSTRAINT `fk_distribution_voltage_regulation_device_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ADD CONSTRAINT `fk_distribution_switching_operation_distribution_outage_event_id` FOREIGN KEY (`distribution_outage_event_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_outage_event`(`distribution_outage_event_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ADD CONSTRAINT `fk_distribution_switching_operation_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ADD CONSTRAINT `fk_distribution_switching_operation_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ADD CONSTRAINT `fk_distribution_gas_leak_survey_gas_main_id` FOREIGN KEY (`gas_main_id`) REFERENCES `power_and_utilities`.`distribution`.`gas_main`(`gas_main_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ADD CONSTRAINT `fk_distribution_load_profile_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ADD CONSTRAINT `fk_distribution_load_profile_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ADD CONSTRAINT `fk_distribution_load_profile_service_transformer_id` FOREIGN KEY (`service_transformer_id`) REFERENCES `power_and_utilities`.`distribution`.`service_transformer`(`service_transformer_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ADD CONSTRAINT `fk_distribution_demand_response_event_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_replaced_pole_id` FOREIGN KEY (`replaced_pole_id`) REFERENCES `power_and_utilities`.`distribution`.`pole`(`pole_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ADD CONSTRAINT `fk_distribution_gas_service_lateral_gas_main_id` FOREIGN KEY (`gas_main_id`) REFERENCES `power_and_utilities`.`distribution`.`gas_main`(`gas_main_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ADD CONSTRAINT `fk_distribution_gas_service_lateral_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ADD CONSTRAINT `fk_distribution_gas_service_lateral_upstream_gas_service_lateral_id` FOREIGN KEY (`upstream_gas_service_lateral_id`) REFERENCES `power_and_utilities`.`distribution`.`gas_service_lateral`(`gas_service_lateral_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ADD CONSTRAINT `fk_distribution_der_dispatch_demand_response_event_id` FOREIGN KEY (`demand_response_event_id`) REFERENCES `power_and_utilities`.`distribution`.`demand_response_event`(`demand_response_event_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ADD CONSTRAINT `fk_distribution_der_dispatch_der_interconnection_id` FOREIGN KEY (`der_interconnection_id`) REFERENCES `power_and_utilities`.`distribution`.`der_interconnection`(`der_interconnection_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ADD CONSTRAINT `fk_distribution_service_point_dr_participation_demand_response_event_id` FOREIGN KEY (`demand_response_event_id`) REFERENCES `power_and_utilities`.`distribution`.`demand_response_event`(`demand_response_event_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ADD CONSTRAINT `fk_distribution_service_point_dr_participation_service_point_id` FOREIGN KEY (`service_point_id`) REFERENCES `power_and_utilities`.`distribution`.`service_point`(`service_point_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`bus` ADD CONSTRAINT `fk_distribution_bus_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`bus` ADD CONSTRAINT `fk_distribution_bus_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`bus` ADD CONSTRAINT `fk_distribution_bus_zone_id` FOREIGN KEY (`zone_id`) REFERENCES `power_and_utilities`.`distribution`.`zone`(`zone_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`bus` ADD CONSTRAINT `fk_distribution_bus_source_bus_id` FOREIGN KEY (`source_bus_id`) REFERENCES `power_and_utilities`.`distribution`.`bus`(`bus_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`city_gate_station` ADD CONSTRAINT `fk_distribution_city_gate_station_upstream_city_gate_station_id` FOREIGN KEY (`upstream_city_gate_station_id`) REFERENCES `power_and_utilities`.`distribution`.`city_gate_station`(`city_gate_station_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_network_node` ADD CONSTRAINT `fk_distribution_gas_network_node_district_id` FOREIGN KEY (`district_id`) REFERENCES `power_and_utilities`.`distribution`.`district`(`district_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_network_node` ADD CONSTRAINT `fk_distribution_gas_network_node_network_model_id` FOREIGN KEY (`network_model_id`) REFERENCES `power_and_utilities`.`distribution`.`network_model`(`network_model_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_network_node` ADD CONSTRAINT `fk_distribution_gas_network_node_service_area_id` FOREIGN KEY (`service_area_id`) REFERENCES `power_and_utilities`.`distribution`.`service_area`(`service_area_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`gas_network_node` ADD CONSTRAINT `fk_distribution_gas_network_node_from_gas_network_node_id` FOREIGN KEY (`from_gas_network_node_id`) REFERENCES `power_and_utilities`.`distribution`.`gas_network_node`(`gas_network_node_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ADD CONSTRAINT `fk_distribution_crew_dispatch_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ADD CONSTRAINT `fk_distribution_crew_dispatch_distribution_outage_event_id` FOREIGN KEY (`distribution_outage_event_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_outage_event`(`distribution_outage_event_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ADD CONSTRAINT `fk_distribution_crew_dispatch_service_territory_id` FOREIGN KEY (`service_territory_id`) REFERENCES `power_and_utilities`.`distribution`.`service_territory`(`service_territory_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ADD CONSTRAINT `fk_distribution_crew_dispatch_reassigned_crew_dispatch_id` FOREIGN KEY (`reassigned_crew_dispatch_id`) REFERENCES `power_and_utilities`.`distribution`.`crew_dispatch`(`crew_dispatch_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`protective_device` ADD CONSTRAINT `fk_distribution_protective_device_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`protective_device` ADD CONSTRAINT `fk_distribution_protective_device_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`protective_device` ADD CONSTRAINT `fk_distribution_protective_device_coordinating_protective_device_id` FOREIGN KEY (`coordinating_protective_device_id`) REFERENCES `power_and_utilities`.`distribution`.`protective_device`(`protective_device_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`zone` ADD CONSTRAINT `fk_distribution_zone_parent_zone_id` FOREIGN KEY (`parent_zone_id`) REFERENCES `power_and_utilities`.`distribution`.`zone`(`zone_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_area` ADD CONSTRAINT `fk_distribution_service_area_parent_service_area_id` FOREIGN KEY (`parent_service_area_id`) REFERENCES `power_and_utilities`.`distribution`.`service_area`(`service_area_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`district` ADD CONSTRAINT `fk_distribution_district_parent_district_id` FOREIGN KEY (`parent_district_id`) REFERENCES `power_and_utilities`.`distribution`.`district`(`district_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`network_model` ADD CONSTRAINT `fk_distribution_network_model_superseded_network_model_id` FOREIGN KEY (`superseded_network_model_id`) REFERENCES `power_and_utilities`.`distribution`.`network_model`(`network_model_id`);
ALTER TABLE `power_and_utilities`.`distribution`.`service_territory` ADD CONSTRAINT `fk_distribution_service_territory_parent_service_territory_id` FOREIGN KEY (`parent_service_territory_id`) REFERENCES `power_and_utilities`.`distribution`.`service_territory`(`service_territory_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Conductor Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `caidi_annual` SET TAGS ('dbx_business_glossary_term' = 'CAIDI (Customer Average Interruption Duration Index) Annual');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `capacitor_bank_count` SET TAGS ('dbx_business_glossary_term' = 'Capacitor Bank Count');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `circuit_configuration` SET TAGS ('dbx_business_glossary_term' = 'Circuit Configuration Type');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `circuit_configuration` SET TAGS ('dbx_value_regex' = 'radial|loop|networked|spot_network|grid_network');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `conductor_size_kcmil` SET TAGS ('dbx_business_glossary_term' = 'Conductor Size (kcmil - Thousand Circular Mils)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `customer_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Count');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `der_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'DER (Distributed Energy Resource) Capacity (MW - Megawatt)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `der_interconnection_count` SET TAGS ('dbx_business_glossary_term' = 'DER (Distributed Energy Resource) Interconnection Count');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `dms_circuit_code` SET TAGS ('dbx_business_glossary_term' = 'DMS (Distribution Management System) Circuit Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `feeder_name` SET TAGS ('dbx_business_glossary_term' = 'Feeder Circuit Name');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `feeder_number` SET TAGS ('dbx_business_glossary_term' = 'Feeder Circuit Number');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'GIS (Geographic Information System) Feature Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `length_miles` SET TAGS ('dbx_business_glossary_term' = 'Feeder Length (Miles)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `nem_customer_count` SET TAGS ('dbx_business_glossary_term' = 'NEM (Net Energy Metering) Customer Count');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `nominal_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Nominal Voltage (kV - Kilovolt)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Operational Notes');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `oms_circuit_code` SET TAGS ('dbx_business_glossary_term' = 'OMS (Outage Management System) Circuit Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|under_construction|planned|decommissioned');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `peak_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Peak Load (MW - Megawatt)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_value_regex' = 'three_phase|single_phase|two_phase');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `rated_capacity_mva` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity (MVA - Megavolt-Ampere)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `recloser_count` SET TAGS ('dbx_business_glossary_term' = 'Recloser Count');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `saidi_annual` SET TAGS ('dbx_business_glossary_term' = 'SAIDI (System Average Interruption Duration Index) Annual');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `saifi_annual` SET TAGS ('dbx_business_glossary_term' = 'SAIFI (System Average Interruption Frequency Index) Annual');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `scada_point_code` SET TAGS ('dbx_business_glossary_term' = 'SCADA (Supervisory Control and Data Acquisition) Point Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `service_territory` SET TAGS ('dbx_business_glossary_term' = 'Service Territory');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `source_bus_id` SET TAGS ('dbx_business_glossary_term' = 'Source Bus Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `tree_trimming_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Tree Trimming Cycle (Months)');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `underground_percentage` SET TAGS ('dbx_business_glossary_term' = 'Underground Percentage');
ALTER TABLE `power_and_utilities`.`distribution`.`feeder` ALTER COLUMN `voltage_regulator_count` SET TAGS ('dbx_business_glossary_term' = 'Voltage Regulator Count');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `service_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Service Transformer ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Substation ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Feeder ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `pole_id` SET TAGS ('dbx_business_glossary_term' = 'Pole Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost (USD)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `asset_condition_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Score');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `book_value` SET TAGS ('dbx_business_glossary_term' = 'Book Value (USD)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `connected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Connected Customer Count');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `cooling_type` SET TAGS ('dbx_business_glossary_term' = 'Cooling Type');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `cooling_type` SET TAGS ('dbx_value_regex' = 'oil_immersed|dry_type|pad_mounted_oil|sealed_tank');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `der_interconnection_flag` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Interconnection Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `impedance_percent` SET TAGS ('dbx_business_glossary_term' = 'Impedance Percentage');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `kva_rating` SET TAGS ('dbx_business_glossary_term' = 'Kilovolt-Ampere (kVA) Rating');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `load_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Load Factor Percentage');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `manufacture_year` SET TAGS ('dbx_business_glossary_term' = 'Manufacture Year');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|standby|retired|under_construction|planned');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|customer_owned|third_party|joint_ownership');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `peak_load_kva` SET TAGS ('dbx_business_glossary_term' = 'Peak Load (kVA)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `primary_voltage` SET TAGS ('dbx_business_glossary_term' = 'Primary Voltage (kV)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `scada_monitored_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Monitored Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `secondary_voltage` SET TAGS ('dbx_business_glossary_term' = 'Secondary Voltage (V)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `tap_position` SET TAGS ('dbx_business_glossary_term' = 'Tap Position');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `transformer_number` SET TAGS ('dbx_business_glossary_term' = 'Transformer Number');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `transformer_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `transformer_type` SET TAGS ('dbx_business_glossary_term' = 'Transformer Installation Type');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `transformer_type` SET TAGS ('dbx_value_regex' = 'pad_mounted|pole_mounted|vault|underground|overhead|submersible');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `winding_configuration` SET TAGS ('dbx_business_glossary_term' = 'Winding Configuration');
ALTER TABLE `power_and_utilities`.`distribution`.`service_transformer` ALTER COLUMN `winding_configuration` SET TAGS ('dbx_value_regex' = 'delta_delta|delta_wye|wye_delta|wye_wye|open_delta');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Substation ID');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Asset Management (EAM) Asset ID');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `construction_work_order` SET TAGS ('dbx_business_glossary_term' = 'Construction Work Order Number');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `customers_served_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Served Count');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `der_hosting_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Hosting Capacity (MW)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `division_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Division Code');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `division_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `ems_node_code` SET TAGS ('dbx_business_glossary_term' = 'Energy Management System (EMS) Node ID');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `feeder_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Distribution Feeders Served');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature ID');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `installed_capacity_mva` SET TAGS ('dbx_business_glossary_term' = 'Total Installed Transformer Capacity (MVA)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `is_automated_switching` SET TAGS ('dbx_business_glossary_term' = 'Automated Switching Indicator');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `is_normally_open_tie` SET TAGS ('dbx_business_glossary_term' = 'Normally Open Tie Substation Indicator');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `is_scada_monitored` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Monitored Indicator');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `land_parcel_number` SET TAGS ('dbx_business_glossary_term' = 'Land Parcel ID (Assessor Parcel Number)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `last_major_upgrade_date` SET TAGS ('dbx_business_glossary_term' = 'Last Major Upgrade Date');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `load_factor_pct` SET TAGS ('dbx_business_glossary_term' = 'Load Factor Percentage (%)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `nem_interconnection_count` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Interconnection Count');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `nerc_bes_applicable` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Bulk Electric System (BES) Applicable Indicator');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `nerc_cip_classification` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Critical Infrastructure Protection (CIP) Classification');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `nerc_cip_classification` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_applicable');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `oms_facility_code` SET TAGS ('dbx_business_glossary_term' = 'Outage Management System (OMS) Facility ID');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|under_construction|decommissioned|mothballed');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|jointly_owned|customer_owned|leased');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `peak_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Peak Load (MW)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `primary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Primary (Transmission-Side) Voltage (kV)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme Type');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_value_regex' = 'overcurrent|differential|distance|pilot_wire|digital_relay|hybrid');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `saidi_contribution_min` SET TAGS ('dbx_business_glossary_term' = 'System Average Interruption Duration Index (SAIDI) Contribution (Minutes)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `scada_point_code` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Point ID');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `secondary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Secondary (Distribution-Side) Voltage (kV)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,30}$');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Substation Street Address');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `substation_code` SET TAGS ('dbx_business_glossary_term' = 'Distribution Substation Code');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `substation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `substation_name` SET TAGS ('dbx_business_glossary_term' = 'Distribution Substation Name');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `substation_type` SET TAGS ('dbx_business_glossary_term' = 'Distribution Substation Type');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `substation_type` SET TAGS ('dbx_value_regex' = 'distribution|switching|network|customer_owned');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `transformer_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Power Transformers');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `voltage_regulation_scheme` SET TAGS ('dbx_business_glossary_term' = 'Voltage Regulation Scheme');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_substation` ALTER COLUMN `voltage_regulation_scheme` SET TAGS ('dbx_value_regex' = 'ltc|svr|capacitor_bank|statcom|none');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Feeder ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `gas_main_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Main ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Service Equipment Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Service Transformer Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `ami_enabled_flag` SET TAGS ('dbx_business_glossary_term' = 'Advanced Metering Infrastructure (AMI) Enabled Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `connect_date` SET TAGS ('dbx_business_glossary_term' = 'Service Connect Date');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `contract_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Contract Demand (kW)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `der_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'DER Installed Capacity (kW)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `der_interconnect_flag` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Interconnection Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `disconnect_date` SET TAGS ('dbx_business_glossary_term' = 'Service Disconnect Date');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `dr_program_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Program Enrolled Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `ev_charger_flag` SET TAGS ('dbx_business_glossary_term' = 'Electric Vehicle (EV) Charger Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `gas_meter_set_code` SET TAGS ('dbx_business_glossary_term' = 'Gas Meter Set ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `gas_pressure_class` SET TAGS ('dbx_business_glossary_term' = 'Gas Service Pressure Class');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `gas_pressure_class` SET TAGS ('dbx_value_regex' = 'low_pressure|medium_pressure|high_pressure');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `gis_last_updated_date` SET TAGS ('dbx_business_glossary_term' = 'GIS Last Updated Date');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `gis_parcel_code` SET TAGS ('dbx_business_glossary_term' = 'GIS Parcel ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Latitude');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `load_class_code` SET TAGS ('dbx_business_glossary_term' = 'Load Classification Code');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'GPS Longitude');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `meter_read_cycle` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Cycle');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `meter_socket_code` SET TAGS ('dbx_business_glossary_term' = 'Meter Socket ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `nem_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Eligible Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP Code)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `premise_type` SET TAGS ('dbx_business_glossary_term' = 'Premise Type');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `premise_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|lighting');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_lateral_length_ft` SET TAGS ('dbx_business_glossary_term' = 'Service Lateral Length (Feet)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_lateral_material` SET TAGS ('dbx_business_glossary_term' = 'Service Lateral Material');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_lateral_material` SET TAGS ('dbx_value_regex' = 'overhead_aluminum|overhead_copper|underground_xlpe|underground_pvc|steel_pipe|polyethylene_pipe');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_phase` SET TAGS ('dbx_business_glossary_term' = 'Service Phase Configuration');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_phase` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_point_status` SET TAGS ('dbx_business_glossary_term' = 'Service Point Status');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_point_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending_connect|pending_disconnect|disconnected');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'electric|gas|dual');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `service_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Service Voltage (Volts)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'CCB|SAP_ISU|ARCGIS|MDMS');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `sp_external_code` SET TAGS ('dbx_business_glossary_term' = 'Service Point External ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `gas_main_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Main ID');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `city_gate_station_id` SET TAGS ('dbx_business_glossary_term' = 'City Gate Station ID');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `gas_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'From Node ID');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `cathodic_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Cathodic Protection Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `cathodic_protection_type` SET TAGS ('dbx_business_glossary_term' = 'Cathodic Protection Type');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `cathodic_protection_type` SET TAGS ('dbx_value_regex' = 'impressed-current|sacrificial-anode|none|unknown');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `coating_type` SET TAGS ('dbx_business_glossary_term' = 'Coating Type');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `coating_type` SET TAGS ('dbx_value_regex' = 'fusion-bonded-epoxy|coal-tar|polyethylene-tape|bare|other|unknown');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `crossing_type` SET TAGS ('dbx_business_glossary_term' = 'Crossing Type');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `crossing_type` SET TAGS ('dbx_value_regex' = 'road|railroad|water|aerial|none');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `dimp_threat_rank` SET TAGS ('dbx_business_glossary_term' = 'Distribution Integrity Management Program (DIMP) Threat Rank');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `dimp_threat_rank` SET TAGS ('dbx_value_regex' = 'high|medium|low|not-assessed');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `district_code` SET TAGS ('dbx_business_glossary_term' = 'Gas Distribution District Code');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `encased_flag` SET TAGS ('dbx_business_glossary_term' = 'Encased Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature ID');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `installed_by` SET TAGS ('dbx_business_glossary_term' = 'Installed By');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `joint_type` SET TAGS ('dbx_business_glossary_term' = 'Joint Type');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `leak_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Leak Survey Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `leak_survey_method` SET TAGS ('dbx_business_glossary_term' = 'Leak Survey Method');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `leak_survey_method` SET TAGS ('dbx_value_regex' = 'bar-hole|walking|mobile|aerial|other');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `main_code` SET TAGS ('dbx_business_glossary_term' = 'Gas Main Code');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `main_name` SET TAGS ('dbx_business_glossary_term' = 'Gas Main Name');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `maop_psig` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Operating Pressure (MAOP) (PSIG)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `municipality` SET TAGS ('dbx_business_glossary_term' = 'Municipality');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `nominal_diameter_in` SET TAGS ('dbx_business_glossary_term' = 'Nominal Diameter (Inches)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `operating_pressure_psig` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure (PSIG)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in-service|out-of-service|abandoned|proposed|under-construction');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `phmsa_class_location` SET TAGS ('dbx_business_glossary_term' = 'PHMSA Class Location');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `phmsa_class_location` SET TAGS ('dbx_value_regex' = '1|2|3|4');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `pipe_depth_in` SET TAGS ('dbx_business_glossary_term' = 'Pipe Depth (Inches)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `pipe_grade` SET TAGS ('dbx_business_glossary_term' = 'Pipe Grade');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Pipe Material');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `pressure_tier` SET TAGS ('dbx_business_glossary_term' = 'Pressure Tier');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `pressure_tier` SET TAGS ('dbx_value_regex' = 'high|medium|low|very-low');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `pressure_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Pressure Zone Code');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `route_geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Route Geometry (WKT)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `seam_type` SET TAGS ('dbx_business_glossary_term' = 'Seam Type');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `seam_type` SET TAGS ('dbx_value_regex' = 'seamless|ERW|DSAW|flash-welded|unknown');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `segment_length_ft` SET TAGS ('dbx_business_glossary_term' = 'Segment Length (Feet)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'GIS|EAM|SCADA|MANUAL');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `street_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `to_node_code` SET TAGS ('dbx_business_glossary_term' = 'To Node ID');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_main` ALTER COLUMN `wall_thickness_in` SET TAGS ('dbx_business_glossary_term' = 'Wall Thickness (Inches)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `distribution_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event ID');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation ID');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Feeder ID');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `opex_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Opex Transaction Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `protective_device_id` SET TAGS ('dbx_business_glossary_term' = 'Protective Device Asset ID');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `protective_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `protective_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `actual_customers_affected` SET TAGS ('dbx_business_glossary_term' = 'Actual Customers Affected');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `caidi_minutes` SET TAGS ('dbx_business_glossary_term' = 'Customer Average Interruption Duration Index (CAIDI) (Minutes)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'Outage Cause Code');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Outage Cause Description');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `crew_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Crew Arrival Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `crew_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Dispatch ID');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `crew_dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Crew Dispatch Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `customers_restored_partial` SET TAGS ('dbx_business_glossary_term' = 'Customers Restored via Partial Restoration');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `estimated_customers_affected` SET TAGS ('dbx_business_glossary_term' = 'Estimated Customers Affected');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Number');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Status');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|restored|closed|cancelled');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `fault_latitude` SET TAGS ('dbx_business_glossary_term' = 'Fault Location Latitude');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `fault_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `fault_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `fault_location_description` SET TAGS ('dbx_business_glossary_term' = 'Fault Location Description');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `fault_longitude` SET TAGS ('dbx_business_glossary_term' = 'Fault Location Longitude');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `fault_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `fault_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `ieee1366_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'IEEE 1366 Exclusion Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `ieee1366_exclusion_reason` SET TAGS ('dbx_business_glossary_term' = 'IEEE 1366 Exclusion Reason');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `ieee1366_exclusion_reason` SET TAGS ('dbx_value_regex' = 'major_event_day|planned_outage|momentary|loss_of_supply|scheduled_maintenance|other');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `major_event_day_flag` SET TAGS ('dbx_business_glossary_term' = 'Major Event Day (MED) Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `momentary_interruption_count` SET TAGS ('dbx_business_glossary_term' = 'Momentary Interruption Count');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `mutual_aid_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `nerc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reportable Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `oms_event_code` SET TAGS ('dbx_business_glossary_term' = 'Outage Management System (OMS) Event ID');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Minutes)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `outage_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage Start Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `outage_type` SET TAGS ('dbx_business_glossary_term' = 'Outage Type');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `outage_type` SET TAGS ('dbx_value_regex' = 'unplanned|planned|momentary');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `partial_restoration_flag` SET TAGS ('dbx_business_glossary_term' = 'Partial Restoration Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `partial_restoration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Partial Restoration Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `protective_device_type` SET TAGS ('dbx_business_glossary_term' = 'Protective Device Type');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `protective_device_type` SET TAGS ('dbx_value_regex' = 'recloser|fuse|breaker|sectionalizer|other');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `puc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Reportable Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Period');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `restoration_method` SET TAGS ('dbx_business_glossary_term' = 'Restoration Method');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `restoration_method` SET TAGS ('dbx_value_regex' = 'crew_repair|switching|auto_recloser|fuse_replacement|remote_switching|temporary_bypass');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `restoration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Restoration Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `saidi_contribution_minutes` SET TAGS ('dbx_business_glossary_term' = 'System Average Interruption Duration Index (SAIDI) Contribution (Minutes)');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `saifi_contribution` SET TAGS ('dbx_business_glossary_term' = 'System Average Interruption Frequency Index (SAIFI) Contribution');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`distribution_outage_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition at Time of Outage');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `reliability_index_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Index Record ID');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Substation ID');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Feeder ID');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `caidi_minutes` SET TAGS ('dbx_business_glossary_term' = 'Customer Average Interruption Duration Index (CAIDI) Minutes');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `circuit_miles` SET TAGS ('dbx_business_glossary_term' = 'Circuit Miles');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `computation_method` SET TAGS ('dbx_business_glossary_term' = 'Index Computation Method');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `computation_method` SET TAGS ('dbx_value_regex' = 'ieee_1366|puc_specific|nerc_standard');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `computed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Index Computation Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'oms|dms|mdms|manual');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `index_version` SET TAGS ('dbx_business_glossary_term' = 'Index Record Version Number');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `interruption_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Interruption Cause Category');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `maifi_count` SET TAGS ('dbx_business_glossary_term' = 'Momentary Average Interruption Frequency Index (MAIFI) Count');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `med_event_count` SET TAGS ('dbx_business_glossary_term' = 'Major Event Day (MED) Count');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `med_excluded_saidi_minutes` SET TAGS ('dbx_business_glossary_term' = 'Major Event Day (MED) Excluded SAIDI Minutes');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `med_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'IEEE 1366 Major Event Day (MED) Exclusion Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `nerc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reportable Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Reliability Index Notes');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `overhead_circuit_miles` SET TAGS ('dbx_business_glossary_term' = 'Overhead Circuit Miles');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `prior_year_saidi_minutes` SET TAGS ('dbx_business_glossary_term' = 'Prior Year SAIDI Minutes');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `prior_year_saifi_count` SET TAGS ('dbx_business_glossary_term' = 'Prior Year SAIFI Count');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `puc_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Docket Number');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `puc_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Reporting Status');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `puc_reporting_status` SET TAGS ('dbx_value_regex' = 'draft|pending_review|submitted|accepted|rejected|amended');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `puc_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Submission Date');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|annual|quarterly');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `reporting_level` SET TAGS ('dbx_business_glossary_term' = 'Reporting Level');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `reporting_level` SET TAGS ('dbx_value_regex' = 'system|substation|feeder');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `reporting_period_month` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Month');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `reporting_period_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Year');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `saidi_minutes` SET TAGS ('dbx_business_glossary_term' = 'System Average Interruption Duration Index (SAIDI) Minutes');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `saidi_with_med_minutes` SET TAGS ('dbx_business_glossary_term' = 'SAIDI Including Major Event Days (MED) Minutes');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `saifi_count` SET TAGS ('dbx_business_glossary_term' = 'System Average Interruption Frequency Index (SAIFI) Count');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `saifi_with_med_count` SET TAGS ('dbx_business_glossary_term' = 'SAIFI Including Major Event Days (MED) Count');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `service_territory_state` SET TAGS ('dbx_business_glossary_term' = 'Service Territory State Code');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `total_customer_interruptions` SET TAGS ('dbx_business_glossary_term' = 'Total Customer Interruptions');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `total_customer_minutes_interrupted` SET TAGS ('dbx_business_glossary_term' = 'Total Customer-Minutes Interrupted (CMI)');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `total_customers_served` SET TAGS ('dbx_business_glossary_term' = 'Total Customers Served');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `underground_circuit_miles` SET TAGS ('dbx_business_glossary_term' = 'Underground Circuit Miles');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `utility_identifier` SET TAGS ('dbx_business_glossary_term' = 'Utility Identifier (EIA Entity ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`reliability_index` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `der_interconnection_id` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Interconnection ID');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `cpcn_application_id` SET TAGS ('dbx_business_glossary_term' = 'Cpcn Application Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Feeder ID');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `participant_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Registration Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `service_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Service Transformer Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Service Transformer ID');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `advanced_inverter_functions_enabled` SET TAGS ('dbx_business_glossary_term' = 'Advanced Inverter Functions Enabled Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `anti_islanding_protection_type` SET TAGS ('dbx_business_glossary_term' = 'Anti-Islanding Protection Type');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `anti_islanding_protection_type` SET TAGS ('dbx_value_regex' = 'passive|active|hybrid|transfer_trip');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Application Date');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Approval Date');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'DER Commissioning Date');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `der_type` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Type');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `der_type` SET TAGS ('dbx_value_regex' = 'solar_pv|battery_storage|wind|chp|ev_charger|fuel_cell');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `derms_device_code` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource Management System (DERMS) Device ID');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `derms_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `derms_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `derms_integrated` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource Management System (DERMS) Integration Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `export_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Export Capacity Kilowatt (kW)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `export_limitation_flag` SET TAGS ('dbx_business_glossary_term' = 'Export Limitation Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `ieee1547_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Institute of Electrical and Electronics Engineers (IEEE) 1547 Compliance Status');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `ieee1547_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_verification|exempt');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `installed_capacity_kw_ac` SET TAGS ('dbx_business_glossary_term' = 'Installed Capacity Kilowatt Alternating Current (kW-AC)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `installed_capacity_kw_dc` SET TAGS ('dbx_business_glossary_term' = 'Installed Capacity Kilowatt Direct Current (kW-DC)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `installer_license_number` SET TAGS ('dbx_business_glossary_term' = 'Installer License Number');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `installer_name` SET TAGS ('dbx_business_glossary_term' = 'DER Installer / Contractor Name');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `interconnection_agreement_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Execution Date');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `interconnection_agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Type');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `interconnection_agreement_type` SET TAGS ('dbx_value_regex' = 'standard|simplified|full_study|expedited');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `interconnection_level` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Review Level');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `interconnection_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `interconnection_number` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Number');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `interconnection_point_gis_code` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Point Geographic Information System (GIS) ID');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `interconnection_status` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Status');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `interconnection_status` SET TAGS ('dbx_value_regex' = 'pending|approved|commissioned|suspended|terminated|withdrawn');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `inverter_manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Inverter Manufacturer');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `inverter_model` SET TAGS ('dbx_business_glossary_term' = 'Inverter Model');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `inverter_type` SET TAGS ('dbx_business_glossary_term' = 'Inverter Type');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `inverter_type` SET TAGS ('dbx_value_regex' = 'string|microinverter|central|hybrid|none');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Site Latitude');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Site Longitude');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `nem_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Enrolled Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `nem_tariff_type` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Tariff Type');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `nem_tariff_type` SET TAGS ('dbx_value_regex' = 'nem_1|nem_2|nem_3|nem_virtual|nem_aggregated|none');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Building / Electrical Permit Number');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `rec_eligible` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Eligible Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `storage_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Battery Storage Capacity Kilowatt-Hour (kWh)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Termination Date');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `utility_program_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Utility DER Program Enrollment');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `utility_program_enrollment` SET TAGS ('dbx_value_regex' = 'none|demand_response|virtual_power_plant|grid_services|storage_incentive');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Voltage Level');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `voltage_level` SET TAGS ('dbx_value_regex' = '120v|240v|208v|480v|other');
ALTER TABLE `power_and_utilities`.`distribution`.`der_interconnection` ALTER COLUMN `wregis_code` SET TAGS ('dbx_business_glossary_term' = 'Western Renewable Energy Generation Information System (WREGIS) Generator ID');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `voltage_regulation_device_id` SET TAGS ('dbx_business_glossary_term' = 'Voltage Regulation Device ID');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `voltage_regulation_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `voltage_regulation_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Substation ID');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Feeder ID');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `bandwidth_v` SET TAGS ('dbx_business_glossary_term' = 'Voltage Bandwidth (Volts)');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `circuit_mile_marker` SET TAGS ('dbx_business_glossary_term' = 'Circuit Mile Marker');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'dnp3|iec61850|modbus|iccp|none');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `control_mode` SET TAGS ('dbx_business_glossary_term' = 'Control Mode');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `control_mode` SET TAGS ('dbx_value_regex' = 'automatic|manual|scada|volt_var_optimization|disabled');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `cumulative_tap_operations` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Tap Operations Count');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `cvr_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Conservation Voltage Reduction (CVR) Enrollment Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `der_hosting_zone` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Hosting Zone Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Voltage Regulation Device Code');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `device_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{3,30}$');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `device_name` SET TAGS ('dbx_business_glossary_term' = 'Voltage Regulation Device Name');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `device_subtype` SET TAGS ('dbx_business_glossary_term' = 'Voltage Regulation Device Subtype');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `device_subtype` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase|gang_operated|individually_switched');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Voltage Regulation Device Type');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'voltage_regulator|capacitor_bank|line_reactor');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `ferc_account_number` SET TAGS ('dbx_business_glossary_term' = 'FERC Uniform System of Accounts Number');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `ferc_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}(.[0-9]{1,3})?$');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `ferc_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `ferc_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `gis_object_code` SET TAGS ('dbx_business_glossary_term' = 'GIS Object ID');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `last_tap_position` SET TAGS ('dbx_business_glossary_term' = 'Last Known Tap Position');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `last_tap_position_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Tap Position Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude (WGS84)');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude (WGS84)');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `maximo_asset_code` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Asset Management (EAM) Asset ID');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `mounting_type` SET TAGS ('dbx_business_glossary_term' = 'Mounting Type');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `mounting_type` SET TAGS ('dbx_value_regex' = 'pole_mounted|pad_mounted|substation_installed|underground_vault');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `nerc_cip_applicable` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Applicability Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|maintenance|retired|standby');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `rated_kva` SET TAGS ('dbx_business_glossary_term' = 'Rated Kilovolt-Ampere (kVA) Capacity');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `rated_kvar` SET TAGS ('dbx_business_glossary_term' = 'Rated Kilovolt-Ampere Reactive (kVAR) Capacity');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `rated_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Rated Voltage (kV)');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `scada_point_code` SET TAGS ('dbx_business_glossary_term' = 'SCADA Point ID');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Serial Number');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `tap_range_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Tap Position');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `tap_range_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tap Position');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `time_delay_seconds` SET TAGS ('dbx_business_glossary_term' = 'Time Delay (Seconds)');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `voltage_setpoint_v` SET TAGS ('dbx_business_glossary_term' = 'Voltage Setpoint (Volts)');
ALTER TABLE `power_and_utilities`.`distribution`.`voltage_regulation_device` ALTER COLUMN `vvo_enrolled` SET TAGS ('dbx_business_glossary_term' = 'VOLT/VAR Optimization (VVO) Enrollment Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `switching_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Switching Operation ID');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `distribution_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event ID');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation ID');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder ID');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `authorized_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorized Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `authorizing_supervisor_employee_number` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Supervisor ID');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Completed Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `customers_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Affected Count');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `device_identifier` SET TAGS ('dbx_business_glossary_term' = 'Device Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `device_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{6,20}$');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `device_operated` SET TAGS ('dbx_business_glossary_term' = 'Device Operated');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `dms_system_source` SET TAGS ('dbx_business_glossary_term' = 'Distribution Management System (DMS) Source');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `gis_location_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Location Reference');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `interruption_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interruption Duration (Minutes)');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `load_transferred_kw` SET TAGS ('dbx_business_glossary_term' = 'Load Transferred (kW)');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `major_event_day_flag` SET TAGS ('dbx_business_glossary_term' = 'Major Event Day (MED) Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `nerc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reportable Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `operation_status` SET TAGS ('dbx_business_glossary_term' = 'Operation Status');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `operation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Operation Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `operation_type` SET TAGS ('dbx_business_glossary_term' = 'Operation Type');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `operation_type` SET TAGS ('dbx_value_regex' = 'planned|emergency|restoration|maintenance|reconfiguration|fault_isolation');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `operator_employee_number` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `post_switch_configuration` SET TAGS ('dbx_business_glossary_term' = 'Post-Switch Configuration');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `post_switch_configuration` SET TAGS ('dbx_value_regex' = 'open|closed|grounded|isolated');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `pre_switch_configuration` SET TAGS ('dbx_business_glossary_term' = 'Pre-Switch Configuration');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `pre_switch_configuration` SET TAGS ('dbx_value_regex' = 'open|closed|grounded|isolated');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `rollback_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollback Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `rollback_reason` SET TAGS ('dbx_business_glossary_term' = 'Rollback Reason');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `safety_clearance_number` SET TAGS ('dbx_business_glossary_term' = 'Safety Clearance Number');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `safety_clearance_number` SET TAGS ('dbx_value_regex' = '^SC-[0-9]{6,10}$');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `scada_command_issued_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Command Issued Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `scada_verification_flag` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Verification Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `scheduled_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `service_territory_state` SET TAGS ('dbx_business_glossary_term' = 'Service Territory State');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `service_territory_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `switching_order_number` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Number');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `switching_order_number` SET TAGS ('dbx_value_regex' = '^SO-[0-9]{8,12}$');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `switching_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Switching Reason Code');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `switching_reason_description` SET TAGS ('dbx_business_glossary_term' = 'Switching Reason Description');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `tag_lockout_status` SET TAGS ('dbx_business_glossary_term' = 'Tag Lockout Status');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `tag_lockout_status` SET TAGS ('dbx_value_regex' = 'none|tagged|locked_out|tagged_and_locked|cleared');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV)');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `power_and_utilities`.`distribution`.`switching_operation` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8,12}$');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `gas_leak_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Leak Survey ID');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `gas_main_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Main ID');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `opex_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Opex Transaction Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `repair_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Repair Work Order ID');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Surveyor ID');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `ambient_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Fahrenheit)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `gas_concentration_ppm` SET TAGS ('dbx_business_glossary_term' = 'Gas Concentration (PPM)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_detected_flag` SET TAGS ('dbx_business_glossary_term' = 'Leak Detected Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_grade` SET TAGS ('dbx_business_glossary_term' = 'Leak Grade Classification');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_grade` SET TAGS ('dbx_value_regex' = 'Grade 1|Grade 2|Grade 3|no leak');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_latitude` SET TAGS ('dbx_business_glossary_term' = 'Leak Latitude');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_location_description` SET TAGS ('dbx_business_glossary_term' = 'Leak Location Description');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_longitude` SET TAGS ('dbx_business_glossary_term' = 'Leak Longitude');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_size_estimate_mcf_per_day` SET TAGS ('dbx_business_glossary_term' = 'Leak Size Estimate (MCF per Day)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `operating_pressure_psig` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure (PSIG)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `phmsa_incident_number` SET TAGS ('dbx_business_glossary_term' = 'Pipeline and Hazardous Materials Safety Administration (PHMSA) Incident Number');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `phmsa_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Pipeline and Hazardous Materials Safety Administration (PHMSA) Reportable Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `pipeline_diameter_inches` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Diameter (Inches)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `pipeline_material` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Material');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `pipeline_segment_type` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment Type');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `pipeline_segment_type` SET TAGS ('dbx_value_regex' = 'main|service lateral|riser|meter set|valve|regulator station');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `prior_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Prior Survey Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `puc_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Reporting Status');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `puc_reporting_status` SET TAGS ('dbx_value_regex' = 'not required|pending|submitted|accepted|rejected');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `puc_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Submission Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `repair_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Repair Completion Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `repair_due_date` SET TAGS ('dbx_business_glossary_term' = 'Repair Due Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `repair_priority` SET TAGS ('dbx_business_glossary_term' = 'Repair Priority');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `repair_priority` SET TAGS ('dbx_value_regex' = 'immediate|urgent|scheduled|monitor|no repair required');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `service_territory_state` SET TAGS ('dbx_business_glossary_term' = 'Service Territory State');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Survey Crew Size');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Survey Duration (Hours)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_external_code` SET TAGS ('dbx_business_glossary_term' = 'Survey External Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Survey Frequency (Months)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'bar-hole|CGI|flame ionization|infrared camera|soap bubble|electronic detector');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'scheduled|in progress|completed|cancelled|pending review|approved');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'leak survey|leak investigation|follow-up survey|routine patrol|special survey|damage assessment');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_leak_survey` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `load_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Feeder Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `service_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Service Transformer Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Service Transformer Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `ambient_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (°F - Degrees Fahrenheit)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `apparent_power_kva` SET TAGS ('dbx_business_glossary_term' = 'Apparent Power (kVA - Kilovolt-Ampere)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `average_voltage_v` SET TAGS ('dbx_business_glossary_term' = 'Average Voltage (V - Volts)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `circuit_miles` SET TAGS ('dbx_business_glossary_term' = 'Circuit Miles');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `computation_method` SET TAGS ('dbx_business_glossary_term' = 'Computation Method');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `computed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Computed Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `current_amperes` SET TAGS ('dbx_business_glossary_term' = 'Current (A - Amperes)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `customer_count` SET TAGS ('dbx_business_glossary_term' = 'Customer Count');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|estimated|suspect|missing|manual_override');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `data_source_system` SET TAGS ('dbx_value_regex' = 'scada|ami_aggregation|dms|ems|historian|manual');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `demand_response_event_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `der_penetration_percent` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Penetration Percentage');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `energy_delivered_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Delivered (kWh - Kilowatt-Hour)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `estimation_method` SET TAGS ('dbx_business_glossary_term' = 'Estimation Method');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `hosting_capacity_analysis_flag` SET TAGS ('dbx_business_glossary_term' = 'Hosting Capacity Analysis Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `load_factor` SET TAGS ('dbx_business_glossary_term' = 'Load Factor');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `measurement_interval_minutes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Interval (Minutes)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `measurement_point_name` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Name');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `measurement_point_type` SET TAGS ('dbx_business_glossary_term' = 'Measurement Point Type');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `measurement_point_type` SET TAGS ('dbx_value_regex' = 'feeder|substation|transformer|circuit|capacitor_bank|voltage_regulator');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `peak_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand (kW - Kilowatt)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `planning_area_code` SET TAGS ('dbx_business_glossary_term' = 'Planning Area Code');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `power_factor` SET TAGS ('dbx_business_glossary_term' = 'Power Factor');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `reactive_power_kvar` SET TAGS ('dbx_business_glossary_term' = 'Reactive Power (kVAR - Kilovolt-Ampere Reactive)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `real_power_kw` SET TAGS ('dbx_business_glossary_term' = 'Real Power (kW - Kilowatt)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `scada_point_code` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Point Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `service_territory_state` SET TAGS ('dbx_business_glossary_term' = 'Service Territory State Code');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `temperature_adjusted_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Temperature-Adjusted Demand (kW - Kilowatt)');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `utility_identifier` SET TAGS ('dbx_business_glossary_term' = 'Utility Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`load_profile` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV - Kilovolt)');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `demand_response_event_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event ID');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Feeder ID');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `opex_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Opex Transaction Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `actual_load_reduction_kw` SET TAGS ('dbx_business_glossary_term' = 'Actual Load Reduction (kW)');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `ambient_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Fahrenheit)');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `baseline_load_kw` SET TAGS ('dbx_business_glossary_term' = 'Baseline Load (kW)');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `curtailment_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Compliance Rate');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `customers_notified_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Notified Count');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `customers_responding_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Responding Count');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `derms_integrated_flag` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource Management System (DERMS) Integrated Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `dispatch_source` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Source System');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `dispatch_source` SET TAGS ('dbx_value_regex' = 'derms|dms|oms|manual|automated_schedule|market_signal');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `event_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event Duration (Minutes)');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event End Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `event_number` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event Number');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `event_outcome_status` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event Outcome Status');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `event_outcome_status` SET TAGS ('dbx_value_regex' = 'target_met|target_exceeded|target_missed|partial_success|no_response');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event Start Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event Status');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'scheduled|active|completed|cancelled|failed');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event Type');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'peak_shaving|direct_load_control|voluntary_curtailment|cpp_activation|emergency_dr|economic_dr');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `incentive_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Payment Amount (USD)');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `incentive_payment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `lmp_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) per MWh');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `load_reduction_percentage` SET TAGS ('dbx_business_glossary_term' = 'Load Reduction Percentage');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `nerc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reportable Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `notification_lead_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Time (Minutes)');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Method');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'sms|email|mobile_app|ivr|direct_control_signal|web_portal');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (USD)');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Program Name');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `puc_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Reporting Status');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `puc_reporting_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|approved|rejected');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `puc_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Submission Date');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `rto_iso_event_code` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) Event ID');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `system_peak_load_mw` SET TAGS ('dbx_business_glossary_term' = 'System Peak Load (MW)');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `target_load_reduction_kw` SET TAGS ('dbx_business_glossary_term' = 'Target Load Reduction (kW)');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `target_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Target Zone Code');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `triggering_condition` SET TAGS ('dbx_business_glossary_term' = 'Demand Response (DR) Event Triggering Condition');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `triggering_condition` SET TAGS ('dbx_value_regex' = 'system_peak|grid_emergency|price_signal|capacity_shortage|voltage_deviation|scheduled_test');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`demand_response_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition Description');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `pole_id` SET TAGS ('dbx_business_glossary_term' = 'Pole Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Asset Management (EAM) Asset Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `replaced_pole_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `book_value` SET TAGS ('dbx_business_glossary_term' = 'Book Value');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `class_rating` SET TAGS ('dbx_business_glossary_term' = 'Pole Class Rating');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `county_name` SET TAGS ('dbx_business_glossary_term' = 'County Name');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `fcc_pole_attachment_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Federal Communications Commission (FCC) Pole Attachment Compliance Status');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `fcc_pole_attachment_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|not_applicable');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `gis_structure_number` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Structure Number');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `ground_line_condition` SET TAGS ('dbx_business_glossary_term' = 'Ground Line Condition');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `ground_line_condition` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical|not_assessed');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `height_ft` SET TAGS ('dbx_business_glossary_term' = 'Pole Height (Feet)');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|remediate|priority_1|priority_2|priority_3');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `joint_use_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Joint Use Attachment Count');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `loading_percentage` SET TAGS ('dbx_business_glossary_term' = 'Pole Loading Percentage');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'wood|steel|concrete|composite|fiberglass|aluminum');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|retired|planned|under_construction|damaged');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|joint_use|third_party|municipal|private');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `pole_number` SET TAGS ('dbx_business_glossary_term' = 'Pole Number');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `pole_type` SET TAGS ('dbx_business_glossary_term' = 'Pole Type');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `pole_type` SET TAGS ('dbx_value_regex' = 'distribution|transmission|joint_use|street_light|communication');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `storm_hardening_flag` SET TAGS ('dbx_business_glossary_term' = 'Storm Hardening Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `street_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `treatment_type` SET TAGS ('dbx_business_glossary_term' = 'Wood Treatment Type');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `treatment_type` SET TAGS ('dbx_value_regex' = 'CCA|pentachlorophenol|creosote|none|other');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`pole` ALTER COLUMN `vegetation_clearance_zone_ft` SET TAGS ('dbx_business_glossary_term' = 'Vegetation Clearance Zone (Feet)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `gas_service_lateral_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Service Lateral Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `gas_main_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Main Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Asset Management (EAM) Asset Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `upstream_gas_service_lateral_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `cathodic_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Cathodic Protection (CP) Status Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `cathodic_protection_type` SET TAGS ('dbx_business_glossary_term' = 'Cathodic Protection (CP) Type');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `cathodic_protection_type` SET TAGS ('dbx_value_regex' = 'impressed_current|galvanic_anode|none|not_applicable');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `coating_type` SET TAGS ('dbx_business_glossary_term' = 'Coating Type');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `dimp_threat_rank` SET TAGS ('dbx_business_glossary_term' = 'Distribution Integrity Management Program (DIMP) Threat Rank');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `district_code` SET TAGS ('dbx_business_glossary_term' = 'District Code');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `efv_installation_date` SET TAGS ('dbx_business_glossary_term' = 'Excess Flow Valve (EFV) Installation Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `excess_flow_valve_flag` SET TAGS ('dbx_business_glossary_term' = 'Excess Flow Valve (EFV) Presence Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Identifier (ID)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `installed_by` SET TAGS ('dbx_business_glossary_term' = 'Installed By');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `joint_type` SET TAGS ('dbx_business_glossary_term' = 'Joint Type');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `last_leak_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Leak Survey Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `lateral_code` SET TAGS ('dbx_business_glossary_term' = 'Lateral Code');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `leak_survey_method` SET TAGS ('dbx_business_glossary_term' = 'Leak Survey Method');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `length_ft` SET TAGS ('dbx_business_glossary_term' = 'Length (Feet)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `maop_psig` SET TAGS ('dbx_business_glossary_term' = 'Maximum Allowable Operating Pressure (MAOP) (Pounds per Square Inch Gauge - PSIG)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `next_leak_survey_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Leak Survey Due Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `nominal_diameter_in` SET TAGS ('dbx_business_glossary_term' = 'Nominal Diameter (Inches)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `operating_pressure_psig` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure (Pounds per Square Inch Gauge - PSIG)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|abandoned|retired|under_construction|temporarily_out_of_service');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `phmsa_class_location` SET TAGS ('dbx_business_glossary_term' = 'Pipeline and Hazardous Materials Safety Administration (PHMSA) Class Location');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `phmsa_class_location` SET TAGS ('dbx_value_regex' = 'class_1|class_2|class_3|class_4');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `pipe_material` SET TAGS ('dbx_business_glossary_term' = 'Pipe Material');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `pipe_material` SET TAGS ('dbx_value_regex' = 'steel|polyethylene|copper|cast_iron|plastic|PVC');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `pressure_tier` SET TAGS ('dbx_business_glossary_term' = 'Pressure Tier');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `pressure_tier` SET TAGS ('dbx_value_regex' = 'low|medium|high|transmission');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `route_geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Route Geometry Well-Known Text (WKT)');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `street_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_service_lateral` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` SET TAGS ('dbx_association_edges' = 'distribution.der_interconnection,distribution.demand_response_event');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `der_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'DER Dispatch ID');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `demand_response_event_id` SET TAGS ('dbx_business_glossary_term' = 'Der Dispatch - Demand Response Event Id');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `der_interconnection_id` SET TAGS ('dbx_business_glossary_term' = 'Der Dispatch - Der Interconnection Id');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `baseline_kw` SET TAGS ('dbx_business_glossary_term' = 'Baseline Load (kW)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `communication_status` SET TAGS ('dbx_business_glossary_term' = 'Communication Status');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `dispatch_instruction` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Instruction');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `incentive_earned` SET TAGS ('dbx_business_glossary_term' = 'Incentive Earned');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `response_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Duration (Minutes)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `response_kw` SET TAGS ('dbx_business_glossary_term' = 'Response Capacity (kW)');
ALTER TABLE `power_and_utilities`.`distribution`.`der_dispatch` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` SET TAGS ('dbx_association_edges' = 'distribution.service_point,distribution.demand_response_event');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `service_point_dr_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point DR Participation ID');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `demand_response_event_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Dr Participation - Demand Response Event Id');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Dr Participation - Service Point Id');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `actual_load_kw` SET TAGS ('dbx_business_glossary_term' = 'Actual Load During Event (kW)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `baseline_kw` SET TAGS ('dbx_business_glossary_term' = 'Baseline Load (kW)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `curtailment_percentage` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Percentage');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `incentive_earned` SET TAGS ('dbx_business_glossary_term' = 'Incentive Earned (USD)');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Notification Method');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `notification_sent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Timestamp');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `opt_out_flag` SET TAGS ('dbx_business_glossary_term' = 'Opt-Out Flag');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `participation_status` SET TAGS ('dbx_business_glossary_term' = 'Participation Status');
ALTER TABLE `power_and_utilities`.`distribution`.`service_point_dr_participation` ALTER COLUMN `response_kw` SET TAGS ('dbx_business_glossary_term' = 'Response Load Reduction (kW)');
ALTER TABLE `power_and_utilities`.`distribution`.`bus` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`bus` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`bus` ALTER COLUMN `bus_id` SET TAGS ('dbx_business_glossary_term' = 'Bus Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`bus` ALTER COLUMN `source_bus_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`city_gate_station` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`city_gate_station` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`city_gate_station` ALTER COLUMN `city_gate_station_id` SET TAGS ('dbx_business_glossary_term' = 'City Gate Station Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`city_gate_station` ALTER COLUMN `upstream_city_gate_station_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`city_gate_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`city_gate_station` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`city_gate_station` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`city_gate_station` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_network_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_network_node` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_network_node` ALTER COLUMN `gas_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Network Node Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_network_node` ALTER COLUMN `from_gas_network_node_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_network_node` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_network_node` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`gas_network_node` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` SET TAGS ('dbx_subdomain' = 'operational_events');
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ALTER COLUMN `crew_dispatch_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Dispatch Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ALTER COLUMN `reassigned_crew_dispatch_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ALTER COLUMN `dispatch_location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`crew_dispatch` ALTER COLUMN `dispatch_location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`protective_device` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`protective_device` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`protective_device` ALTER COLUMN `protective_device_id` SET TAGS ('dbx_business_glossary_term' = 'Protective Device Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`protective_device` ALTER COLUMN `coordinating_protective_device_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`protective_device` ALTER COLUMN `replacement_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`zone` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`zone` ALTER COLUMN `zone_id` SET TAGS ('dbx_business_glossary_term' = 'Zone Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`zone` ALTER COLUMN `parent_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`service_area` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`service_area` ALTER COLUMN `service_area_id` SET TAGS ('dbx_business_glossary_term' = 'Service Area Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`service_area` ALTER COLUMN `parent_service_area_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`district` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`district` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`district` ALTER COLUMN `district_id` SET TAGS ('dbx_business_glossary_term' = 'District Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`district` ALTER COLUMN `parent_district_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`district` ALTER COLUMN `district_office_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`district` ALTER COLUMN `district_office_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`district` ALTER COLUMN `district_office_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`district` ALTER COLUMN `district_office_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`district` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`district` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`network_model` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`network_model` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`network_model` ALTER COLUMN `network_model_id` SET TAGS ('dbx_business_glossary_term' = 'Network Model Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`network_model` ALTER COLUMN `superseded_network_model_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_territory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`distribution`.`service_territory` SET TAGS ('dbx_subdomain' = 'network_infrastructure');
ALTER TABLE `power_and_utilities`.`distribution`.`service_territory` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier');
ALTER TABLE `power_and_utilities`.`distribution`.`service_territory` ALTER COLUMN `parent_service_territory_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_territory` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_territory` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_territory` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_territory` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`distribution`.`service_territory` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
