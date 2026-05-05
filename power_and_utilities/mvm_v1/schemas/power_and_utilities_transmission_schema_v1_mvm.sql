-- Schema for Domain: transmission | Business: Power and Utilities | Version: v1_mvm
-- Generated on: 2026-04-29 23:12:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities`.`transmission` COMMENT 'Governs high-voltage bulk electric system (BES) infrastructure for power transport across the grid — transmission lines, substations, transformers, and switching equipment. Manages grid topology, OATT compliance, RTO/ISO interchange scheduling, LMP data, transmission capacity, congestion, and interconnection requests. Critical for NERC CIP compliance and FERC jurisdictional reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`line` (
    `line_id` BIGINT COMMENT 'Primary key for line',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Links completed transmission lines to their originating capital projects for CWIP-to-plant transfer tracking, AFUDC capitalization verification, project closeout reconciliation, and audit trail from a',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Transmission lines are constructed from specific conductor materials (ACSR, ACCR, etc.). Material master enables procurement planning for line construction/rebuild projects, standardization of conduct',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Transmission lines are subject to CPCN proceedings for siting/construction, rate base inclusion in rate cases, and FERC jurisdictional oversight. Business process: FERC Form 1 reporting, prudency revi',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Transmission lines are capitalized plant assets with book values, accumulated depreciation, and rate base treatment tracked in fixed_asset. Required for FERC Form 1 reporting, depreciation studies, an',
    `bus_id` BIGINT COMMENT 'Foreign key linking to transmission.bus. Business justification: Transmission lines connect two buses (electrical connection points). The from_bus_id FK establishes the origin bus. This is a critical topological relationship for power flow modeling and grid analysi',
    `master_id` BIGINT COMMENT 'Foreign key linking to asset.asset_master. Business justification: Transmission lines are major capital assets requiring comprehensive lifecycle management, maintenance scheduling, and regulatory compliance tracking. Other transmission products (substation, transform',
    `to_transmission_substation_id` BIGINT COMMENT 'FK to transmission.transmission_substation',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Transmission lines connect two substations. The from_substation_code (STRING) should be replaced with a proper FK from_substation_id → transmission_substation.transmission_substation_id. This allows j',
    `available_transfer_capability_mw` DECIMAL(18,2) COMMENT 'Available Transfer Capability of the transmission line in Megawatts (MW), representing the remaining transfer capacity available for additional transactions after accounting for existing commitments and reliability margins. Published on OASIS per FERC OATT requirements.',
    `bes_classified` BOOLEAN COMMENT 'Indicates whether this transmission line is classified as part of the NERC Bulk Electric System (BES). BES-classified lines are subject to NERC Reliability Standards (CIP, FAC, TPL, etc.) and FERC jurisdiction. True = BES; False = non-BES (sub-transmission or distribution).',
    `circuit_configuration` STRING COMMENT 'Physical circuit arrangement of the transmission line structure. Single circuit carries one three-phase circuit; double circuit carries two three-phase circuits on the same tower structure, affecting redundancy and contingency analysis.. Valid values are `single_circuit|double_circuit|multi_circuit`',
    `co_owner_name` STRING COMMENT 'Name of the joint owner(s) of the transmission line when ownership_percentage is less than 100%. Relevant for joint-use agreements, cost-sharing arrangements, and FERC Form 1 disclosure of jointly-owned plant.',
    `commissioning_cost_usd` DECIMAL(18,2) COMMENT 'Total capital cost incurred to construct and commission the transmission line, expressed in US dollars. Represents the gross plant-in-service value for FERC rate base inclusion, depreciation base, and CAPEX tracking. Classified confidential as it contains sensitive financial data.',
    `depreciation_rate_pct` DECIMAL(18,2) COMMENT 'Annual straight-line depreciation rate applied to the transmission line as a percentage of original cost. Established through PUC-approved depreciation studies and used for regulatory accounting, rate case filings, and FERC Form 1 reporting.',
    `emergency_rating_mva` DECIMAL(18,2) COMMENT 'Short-term emergency thermal rating of the transmission line in Megavolt-Amperes (MVA). Represents the maximum allowable power flow for a limited duration (typically 15–30 minutes) during contingency conditions. Used in N-1 and N-2 contingency analysis.',
    `ems_element_reference` STRING COMMENT 'Identifier for this transmission line element within the ABB or GE Energy Management System (EMS) / SCADA platform. Used for real-time monitoring, state estimation, and contingency analysis in the EMS network model.',
    `ferc_jurisdictional` BOOLEAN COMMENT 'Indicates whether this transmission line is subject to FERC jurisdiction under the Federal Power Act. FERC-jurisdictional lines must comply with OATT requirements, transmission pricing rules, and FERC Form 1 reporting obligations.',
    `gis_feature_reference` STRING COMMENT 'Reference identifier for the transmission line feature in the ESRI ArcGIS geospatial network model. Enables spatial joins, route tracing, and GIS-based outage analysis.',
    `in_service_date` DATE COMMENT 'Date the transmission line was placed into commercial service and energized. Used for depreciation calculations, AFUDC capitalization cutoff, FERC rate base inclusion, and asset age tracking.',
    `insulation_type` STRING COMMENT 'Type of insulation used on the transmission line conductors or cable. For overhead lines: ceramic, glass, or polymer insulators. For underground/submarine cables: XLPE or oil-paper. Affects dielectric performance, maintenance intervals, and failure mode analysis.. Valid values are `ceramic|glass|polymer|XLPE|oil_paper`',
    `interconnection_type` STRING COMMENT 'Classification of the transmission line based on the entities it interconnects. Intra-utility lines connect points within the same utility system; inter-utility lines connect different utilities; interstate lines cross state boundaries; international lines cross national borders.. Valid values are `intra_utility|inter_utility|interstate|international`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the transmission line (aerial patrol, ground patrol, or detailed inspection). Used to track compliance with NERC FAC-003 vegetation management and internal maintenance standards.',
    `length_miles` DECIMAL(18,2) COMMENT 'Total route length of the transmission line in miles, as measured along the physical corridor. Used for impedance calculations, O&M cost allocation, FERC Form 1 reporting, and rate base determination.',
    `line_code` STRING COMMENT 'Externally-known alphanumeric code or tag uniquely identifying the transmission line across operational systems (GIS, EMS, SCADA, WAM). Serves as the business key for cross-system integration.',
    `line_name` STRING COMMENT 'Human-readable name or designation assigned to the transmission line (e.g., Northgate–Riverside 345kV). Used in operational communications, SCADA displays, and regulatory filings.',
    `line_type` STRING COMMENT 'Physical construction type of the transmission line. Overhead lines use towers/poles with air insulation; underground lines use buried cable; submarine lines cross bodies of water. Affects maintenance practices, outage risk, and capital cost classification.. Valid values are `overhead|underground|submarine`',
    `multi_state_flag` BOOLEAN COMMENT 'Indicates whether the transmission line crosses state boundaries. Multi-state lines may be subject to multiple PUC jurisdictions and require coordinated regulatory reporting. True = crosses state lines; False = single-state.',
    `nerc_cip_applicable` BOOLEAN COMMENT 'Indicates whether this transmission line is within scope of NERC CIP cybersecurity standards as a Critical Cyber Asset or associated Physical Security Perimeter. Drives cybersecurity and physical security compliance obligations.',
    `next_inspection_date` DATE COMMENT 'Date on which the next scheduled inspection of the transmission line is due. Drives preventive maintenance work order generation in the EAM system and ensures compliance with inspection frequency requirements.',
    `number_of_structures` STRING COMMENT 'Total count of towers, poles, or support structures along the transmission line route. Used for asset inventory, maintenance planning, and storm restoration resource estimation.',
    `operating_status` STRING COMMENT 'Current operational lifecycle status of the transmission line. Drives inclusion in power flow models, maintenance scheduling, NERC compliance scope, and FERC rate base eligibility. [ENUM-REF-CANDIDATE: in_service|out_of_service|mothballed|retired|under_construction|planned — promote to reference product]. Valid values are `in_service|out_of_service|mothballed|retired|under_construction|planned`',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of the transmission line owned by this utility (0.00–100.00). Lines may be jointly owned with other utilities or transmission companies. Drives rate base allocation, O&M cost sharing, and FERC Form 1 reporting of owned vs. leased plant.',
    `protection_scheme` STRING COMMENT 'Description of the primary relay protection scheme applied to the transmission line (e.g., distance relay, differential relay, pilot protection, directional overcurrent). Critical for NERC PRC (Protection and Control) compliance and fault clearing time analysis.',
    `rated_capacity_mva` DECIMAL(18,2) COMMENT 'Normal (continuous) thermal rating of the transmission line expressed in Megavolt-Amperes (MVA). Represents the maximum power flow the line can carry under normal operating conditions without exceeding conductor temperature limits. Used in power flow studies, congestion management, and OATT ATC calculations.',
    `reactance_ohms_per_mile` DECIMAL(18,2) COMMENT 'Positive-sequence inductive reactance of the conductor in ohms per mile. Essential parameter for power flow, stability, and short-circuit analysis in the transmission network model.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission line master record was first created in the Silver Layer data product. Supports data lineage, audit trail, and record lifecycle management.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this transmission line master record in the Silver Layer. Used for change data capture, incremental ETL processing, and audit trail maintenance.',
    `resistance_ohms_per_mile` DECIMAL(18,2) COMMENT 'Positive-sequence AC resistance of the conductor in ohms per mile at operating temperature. Core electrical parameter used in power flow models, load flow studies, and loss calculations.',
    `retirement_date` DATE COMMENT 'Date the transmission line was permanently retired from service. Triggers removal from rate base, cessation of depreciation, and decommissioning obligations. Null if the line is still active.',
    `right_of_way_width_ft` DECIMAL(18,2) COMMENT 'Width of the transmission line right-of-way corridor in feet. Used for vegetation management compliance (NERC FAC-003), land use planning, encroachment management, and environmental permitting.',
    `rto_iso_region` STRING COMMENT 'Name or code of the RTO or ISO within whose footprint this transmission line operates (e.g., PJM, MISO, CAISO, SPP, ERCOT, NYISO, ISO-NE). Determines market rules, LMP pricing nodes, and interchange scheduling protocols.',
    `scada_monitored` BOOLEAN COMMENT 'Indicates whether this transmission line is monitored and controllable via the SCADA/EMS system. SCADA-monitored lines provide real-time telemetry (MW flow, MVAr, voltage, breaker status) to the Energy Management System for grid operations.',
    `state_code` STRING COMMENT 'Two-letter US state code (USPS abbreviation) for the primary state in which the transmission line is located. For multi-state lines, represents the state of the majority of the route length. Used for PUC jurisdictional determination and state regulatory reporting.. Valid values are `^[A-Z]{2}$`',
    `structure_type` STRING COMMENT 'Type of tower or pole structure supporting the overhead transmission line. Affects structural loading calculations, maintenance practices, and asset replacement planning.. Valid values are `lattice_steel|monopole_steel|wood_pole|concrete_pole|H_frame`',
    `total_transfer_capability_mw` DECIMAL(18,2) COMMENT 'Total Transfer Capability of the transmission line in Megawatts (MW), representing the maximum amount of electric power that can be transferred reliably over the line under specified system conditions. Basis for ATC calculations published on OASIS.',
    `voltage_class_kv` DECIMAL(18,2) COMMENT 'Nominal operating voltage class of the transmission line expressed in kilovolts (kV). Common BES voltage classes include 69 kV, 115 kV, 138 kV, 230 kV, 345 kV, 500 kV, and 765 kV. Determines NERC BES applicability threshold (≥100 kV) and FERC jurisdictional classification.',
    `wam_asset_reference` STRING COMMENT 'Asset identifier assigned by the Enterprise Asset Management system (Oracle WAM or IBM Maximo) for maintenance scheduling, work order management, and asset lifecycle tracking.',
    `year_constructed` STRING COMMENT 'Calendar year in which the transmission line was originally constructed. Distinct from in_service_date; used for asset age analysis, infrastructure investment planning, and IRP long-range capital forecasting.',
    CONSTRAINT pk_line PRIMARY KEY(`line_id`)
) COMMENT 'Master record for high-voltage bulk electric system (BES) transmission lines owned and operated by the utility. Captures line identifier, voltage class (kV), circuit configuration (single/double), conductor type, rated thermal capacity (MVA), line length (miles), in-service date, NERC BES classification, FERC jurisdiction flag, RTO/ISO region, GIS route reference, operating status, and ownership percentage. Serves as the SSOT for transmission line infrastructure identity and physical characteristics. Source system: ESRI ArcGIS and Oracle WAM/IBM Maximo.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`transmission_substation` (
    `transmission_substation_id` BIGINT COMMENT 'Unique surrogate identifier for the transmission substation record in the Databricks Silver Layer. Primary key for this master resource entity.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Substations are constructed via capital projects; link enables CWIP accounting, project cost rollup to FERC plant accounts, regulatory cost recovery documentation, and variance analysis between author',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to transmission.control_area. Business justification: Transmission substations operate within control areas. The transmission_substation table has control_area STRING. Normalizing to FK to control_area. Removes control_area string.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Substations require CPCN approval for construction, are included in rate base for cost recovery, and are subject to environmental/siting proceedings. Business process: capital project approval filings',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Substations are major capital assets requiring financial tracking of original cost, depreciation, and net book value for regulatory reporting, rate base calculations, and asset retirement obligation a',
    `master_id` BIGINT COMMENT 'Asset identifier for this substation in Oracle WAM or IBM Maximo Enterprise Asset Management system. Used to link to preventive and corrective maintenance work orders, inspection records, and asset health scores.',
    `operator_id` BIGINT COMMENT 'FK to transmission.operator',
    `bes_flag` BOOLEAN COMMENT 'Indicates whether this substation is classified as part of the Bulk Electric System (BES) per the NERC BES definition. BES classification triggers NERC reliability standard applicability including CIP, FAC, TPL, and PRC standards.',
    `bus_configuration` STRING COMMENT 'Electrical bus arrangement scheme of the substation switchyard. Determines switching flexibility, reliability, and maintenance capability. Used in protection coordination studies and reliability modeling. [ENUM-REF-CANDIDATE: single_bus|double_bus|ring_bus|breaker_and_half|main_and_transfer|double_bus_double_breaker — promote to reference product]. Valid values are `single_bus|double_bus|ring_bus|breaker_and_half|main_and_transfer|double_bus_double_breaker`',
    `commissioning_date` DATE COMMENT 'Date the substation completed commissioning testing and was accepted as ready for service, prior to the official in-service date. Distinct from in_service_date; used for warranty tracking and construction project closeout in SAP S/4HANA.',
    `communications_type` STRING COMMENT 'Primary telecommunications medium used for SCADA telemetry and protection signaling at this substation. Relevant for NERC CIP-005 Electronic Security Perimeter and CIP-006 Physical Security compliance assessments.. Valid values are `fiber_optic|microwave|power_line_carrier|leased_line|satellite|cellular`',
    `county` STRING COMMENT 'County or parish in which the substation is located. Used for property tax jurisdiction, permitting authority determination, and state PUC service territory reporting.',
    `decommission_date` DATE COMMENT 'Date the substation was or is planned to be permanently removed from service and decommissioned. Nullable for active substations. Used for asset retirement accounting, regulatory notification to FERC under FPA Section 203, and IRP planning.',
    `elevation_m` DECIMAL(18,2) COMMENT 'Elevation of the substation site above mean sea level in meters. Used for equipment insulation coordination (altitude derating), flood risk assessment, and GIS spatial modeling.',
    `ems_node_reference` STRING COMMENT 'Node or bus identifier within the ABB or GE Energy Management System (EMS) network topology model corresponding to this substation. Used for state estimation, contingency analysis, and generation dispatch coordination.',
    `ferc_account_number` STRING COMMENT 'FERC Uniform System of Accounts (USofA) account number under which the substation assets are recorded (e.g., Account 352 for Structures and Improvements, Account 353 for Station Equipment). Used for FERC Form 1 plant-in-service reporting and rate base determination.',
    `ferc_jurisdiction_flag` BOOLEAN COMMENT 'Indicates whether this substation is subject to FERC jurisdictional oversight under the Federal Power Act (FPA). True for interstate transmission facilities; False for state-jurisdictional or non-jurisdictional assets. Drives FERC Form 1 inclusion and OATT applicability.',
    `gis_feature_reference` STRING COMMENT 'Unique feature identifier for this substation in the ESRI ArcGIS geospatial network model. Used to link the substation record to its spatial geometry, network connectivity, and GIS-based asset layers.',
    `in_service_date` DATE COMMENT 'Date the substation was officially placed into commercial or operational service on the bulk electric system. Used for asset age calculations, depreciation schedules in SAP S/4HANA, FERC Form 1 plant-in-service reporting, and AFUDC capitalization cutoff.',
    `installed_capacity_mva` DECIMAL(18,2) COMMENT 'Total installed transformer capacity at the substation in Megavolt-Amperes (MVA), summing all transformer banks. The principal quantitative measure of the substations power handling capability. Used for capacity planning, congestion analysis, and FERC Form 1 reporting.',
    `land_ownership_type` STRING COMMENT 'Classification of the land tenure arrangement for the substation site. Affects property accounting treatment under GAAP, FERC Uniform System of Accounts land account classification, and site access rights for maintenance.. Valid values are `owned|leased|easement|right_of_way|licensed`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent formal inspection or condition assessment of the substation. Used to track compliance with NERC FAC-003 vegetation management, NERC CIP-006 physical security inspections, and internal O&M maintenance schedules.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the substation site in decimal degrees (WGS84 datum). Used for GIS mapping, emergency response routing, and spatial analysis of grid topology.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the substation site in decimal degrees (WGS84 datum). Used for GIS mapping, emergency response routing, and spatial analysis of grid topology.',
    `nerc_cip_classification` STRING COMMENT 'NERC CIP impact classification of the substation per NERC CIP-002 BES Cyber System Categorization. Determines the cybersecurity control requirements applicable to associated BES Cyber Systems. Classified as confidential due to critical infrastructure sensitivity.. Valid values are `high_impact|medium_impact|low_impact|not_applicable`',
    `nerc_node_code` STRING COMMENT 'NERC-assigned unique node identifier for this substation within the bulk electric system (BES) topology model. Used for NERC compliance reporting, reliability assessments, and RTO/ISO power flow models.',
    `next_maintenance_date` DATE COMMENT 'Date of the next planned preventive maintenance activity for the substation as scheduled in Oracle WAM or IBM Maximo. Used for maintenance planning, outage coordination, and NERC maintenance interval compliance tracking.',
    `num_transformer_banks` STRING COMMENT 'Count of transformer banks installed at the substation. Used for capacity planning, N-1 contingency analysis, and maintenance scheduling in Oracle WAM/IBM Maximo.',
    `num_transmission_lines` STRING COMMENT 'Count of transmission line circuits terminating at this substation. Indicates the substations connectivity degree in the network topology. Used for contingency analysis and switching studies.',
    `operating_status` STRING COMMENT 'Current lifecycle and operational state of the substation. Drives asset management workflows in Oracle WAM/IBM Maximo, outage management in Schneider AMS/GE PowerOn, and regulatory asset reporting to FERC and state PUCs.. Valid values are `in_service|out_of_service|under_construction|mothballed|decommissioned`',
    `original_cost_usd` DECIMAL(18,2) COMMENT 'Original installed cost of the substation in US dollars as recorded in the FERC Uniform System of Accounts. Used for rate base calculation, depreciation studies, and FERC Form 1 electric plant-in-service reporting. Classified as confidential due to financial sensitivity.',
    `owner_name` STRING COMMENT 'Legal name of the entity that owns the substation assets. May differ from the operating entity in jointly-owned or leased facilities. Required for FERC Form 1 plant ownership reporting and CIAC accounting.',
    `physical_address` STRING COMMENT 'Street address or location description of the substation site. Used for emergency response, field crew dispatch, permitting, and property tax records. Classified as confidential due to critical infrastructure location sensitivity.',
    `protection_scheme` STRING COMMENT 'Primary relay protection scheme employed at the substation for fault detection and isolation. Determines relay settings, coordination studies, and NERC PRC standard compliance requirements. [ENUM-REF-CANDIDATE: differential|distance|overcurrent|pilot|directional_comparison|line_current_differential — promote to reference product]. Valid values are `differential|distance|overcurrent|pilot|directional_comparison|line_current_differential`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this substation master record was first created in the source system (ESRI ArcGIS or EMS). Used for data lineage, audit trail, and Silver Layer ingestion tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this substation master record in the source system. Used for change data capture (CDC), Silver Layer incremental loads, and audit trail maintenance.',
    `rto_iso_region` STRING COMMENT 'Name or code of the RTO or ISO within whose footprint this substation operates (e.g., PJM, MISO, CAISO, SPP, ERCOT, NYISO, ISO-NE). Determines applicable OATT tariff, LMP pricing node assignment, and market participation rules.',
    `scada_point_reference` STRING COMMENT 'SCADA system point tag or reference identifier used in OSIsoft PI or GE Proficy Historian to link real-time telemetry data streams to this substation. Enables operational monitoring, alarm management, and historian data retrieval.',
    `state_code` STRING COMMENT 'Two-letter US state abbreviation (USPS standard) where the substation is located. Used for state PUC jurisdictional reporting, rate case filings, and multi-state utility regulatory compliance.. Valid values are `^[A-Z]{2}$`',
    `substation_code` STRING COMMENT 'Externally-known alphanumeric short code or abbreviation for the substation used in SCADA point naming, EMS topology models, and RTO/ISO interchange scheduling messages. Serves as the business identifier across operational systems.. Valid values are `^[A-Z0-9_-]{2,20}$`',
    `substation_name` STRING COMMENT 'Official human-readable name of the transmission substation as registered in ESRI ArcGIS and the ABB/GE Energy Management System (EMS). Used as the primary identity label across SCADA displays, GIS maps, and regulatory filings.',
    `substation_type` STRING COMMENT 'Functional classification of the substation indicating its primary role in the transmission network. Switching substations route power without voltage transformation; step-down substations reduce high-voltage transmission to sub-transmission or distribution levels; step-up substations raise generation voltage for transmission; converter substations perform AC/DC conversion. [ENUM-REF-CANDIDATE: switching|step_down|step_up|converter|autotransformer|distribution_substation — promote to reference product]. Valid values are `switching|step_down|step_up|converter|autotransformer|distribution_substation`',
    `transmission_zone` STRING COMMENT 'Tariff or rate zone designation within the utilitys transmission system or RTO/ISO footprint. Used for OATT transmission service rate calculation, congestion revenue rights (CRR) allocation, and zonal LMP settlement.',
    `voltage_high_kv` DECIMAL(18,2) COMMENT 'Nominal high-side (primary) voltage level of the substation in kilovolts (kV). Represents the incoming bulk transmission voltage. Critical for BES classification, NERC CIP applicability determination, and OATT tariff rate zone assignment.',
    `voltage_low_kv` DECIMAL(18,2) COMMENT 'Nominal low-side (secondary) voltage level of the substation in kilovolts (kV). Represents the outgoing sub-transmission or distribution voltage after transformation. Used in network topology modeling and load flow analysis.',
    CONSTRAINT pk_transmission_substation PRIMARY KEY(`transmission_substation_id`)
) COMMENT 'Master record for transmission substations including switching stations and transformer banks at the bulk electric system level. Captures substation name, NERC node ID, voltage levels served (kV high/low), substation type (switching, step-down, converter), installed transformer capacity (MVA), bus configuration, SCADA point reference, GIS coordinates, NERC CIP classification (high/medium/low impact), in-service date, and operating status. SSOT for substation identity across the transmission network. Source system: ESRI ArcGIS, OSIsoft PI/GE Proficy, ABB/GE EMS.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`transformer` (
    `transformer_id` BIGINT COMMENT 'Unique surrogate identifier for the bulk transmission power transformer record in the Databricks Silver Layer. Primary key for this master resource entity.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Major transformer installations have dedicated capital project codes for tracking expenditures, AFUDC eligibility determination, and financial closeout. Required for capital budget tracking and regula',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Major transformer investments require regulatory approval and prudency review for rate recovery. Business process: capital expenditure justification in rate cases, asset replacement program approval, ',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Transformers are individually capitalized assets with specific FERC plant account classifications, depreciation schedules, and book values. Essential for asset accounting, depreciation expense allocat',
    `master_id` BIGINT COMMENT 'Reference to the parent asset record in the Enterprise Asset Management (EAM) system (Oracle WAM / IBM Maximo) that governs maintenance work orders, inspection history, and asset lifecycle for this transformer.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Transformers are procured equipment with specific material specifications and manufacturer part numbers. Material master link enables procurement of replacement transformers, standardization across fl',
    `bus_id` BIGINT COMMENT 'Foreign key linking to transmission.bus. Business justification: Transformers connect to buses on the primary (high-voltage) side. This FK establishes the primary bus connection point, essential for power flow analysis and transformer topology modeling.',
    `transmission_substation_id` BIGINT COMMENT 'Reference to the bulk electric system (BES) substation where this transformer is physically installed. Used to associate transformer records with substation topology.',
    `cooling_class` STRING COMMENT 'IEEE/IEC cooling class designation indicating the cooling medium and circulation method (e.g., ONAN = Oil Natural Air Natural, ONAF = Oil Natural Air Forced, OFAF = Oil Forced Air Forced). Determines the MVA rating steps and informs maintenance procedures for cooling equipment.. Valid values are `ONAN|ONAF|OFAN|OFAF|ODAF|ODAN`',
    `dga_baseline_date` DATE COMMENT 'Date of the initial dissolved gas analysis (DGA) oil sample that established the baseline gas concentration profile for this transformer. Used as the reference point for trending fault gas evolution and detecting incipient faults per IEEE C57.104.',
    `dga_condition_code` STRING COMMENT 'Current DGA health condition code derived from the most recent oil sample analysis per IEEE C57.104 Duval Triangle or Rogers Ratio method. Drives maintenance prioritization and outage risk assessment. Updated each time a new DGA sample is analyzed.. Valid values are `normal|caution|warning|critical`',
    `ferc_account_code` STRING COMMENT 'FERC Uniform System of Accounts (USofA) account number under which this transformer is capitalized (typically Account 353 — Station Equipment for transmission substations). Required for FERC Form 1 reporting and rate base calculations.',
    `frequency_hz` DECIMAL(18,2) COMMENT 'Nameplate rated operating frequency in Hertz (Hz). Standard North American grid frequency is 60 Hz. Relevant for transformers that may be used in cross-border or special-purpose applications.',
    `gis_latitude` DECIMAL(18,2) COMMENT 'WGS84 decimal-degree latitude coordinate of the transformers physical installation location, sourced from ESRI ArcGIS. Used for outage management, emergency response routing, and transmission network topology mapping.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'WGS84 decimal-degree longitude coordinate of the transformers physical installation location, sourced from ESRI ArcGIS. Used in conjunction with gis_latitude for spatial analysis and GIS network modeling.',
    `hv_kv_rating` DECIMAL(18,2) COMMENT 'Nameplate rated voltage in kilovolts (kV) for the high-voltage winding. Determines the transmission voltage class (e.g., 345 kV, 500 kV, 765 kV) and is used in grid topology modeling and OATT filings.',
    `impedance_pct` DECIMAL(18,2) COMMENT 'Positive-sequence leakage impedance expressed as a percentage of the transformers base MVA and kV ratings, as stated on the nameplate. Critical input for short-circuit fault current calculations, protection coordination, and power flow studies.',
    `in_service_date` DATE COMMENT 'Date the transformer was formally placed into commercial/operational service on the bulk electric system. May differ from installation_date if commissioning testing extended beyond physical installation. Used for AFUDC capitalization cutoff and FERC rate base reporting.',
    `installation_date` DATE COMMENT 'Date the transformer was physically installed and energized at the substation. Marks the start of the in-service lifecycle for depreciation (GAAP/AFUDC), warranty tracking, and preventive maintenance scheduling.',
    `is_bes_asset` BOOLEAN COMMENT 'Indicates whether this transformer is classified as a Bulk Electric System (BES) asset under NERC BES Definition. BES assets are subject to NERC reliability standards and FERC jurisdictional oversight. True = BES asset; False = non-BES (e.g., station service transformer).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent formal maintenance inspection or condition assessment performed on this transformer, as recorded in Oracle WAM / IBM Maximo. Used to track compliance with preventive maintenance intervals and NERC PRC-005 protection system maintenance requirements.',
    `lv_kv_rating` DECIMAL(18,2) COMMENT 'Nameplate rated voltage in kilovolts (kV) for the low-voltage winding. Used in substation design, protection relay settings, and interconnection studies.',
    `manufacture_year` STRING COMMENT 'Calendar year in which the transformer was manufactured, as stated on the nameplate. Used to calculate asset age, assess end-of-life risk, and prioritize capital replacement programs (CAPEX planning).',
    `maximo_asset_num` STRING COMMENT 'The externally-known asset number assigned by Oracle WAM or IBM Maximo — the operational system of record for this transformer. Used for cross-system reconciliation and work order linkage.',
    `mva_rating_nameplate` DECIMAL(18,2) COMMENT 'Manufacturer nameplate continuous MVA rating of the transformer at its base cooling class (e.g., ONAN). This is the principal quantitative capacity fact for the asset and is used in transmission planning, OATT capacity filings, and NERC reliability assessments.',
    `mva_rating_ultimate` DECIMAL(18,2) COMMENT 'Maximum MVA rating achievable at the highest cooling class (e.g., OFAF) as stated on the nameplate. Used in emergency loading assessments and contingency analysis to determine maximum permissible loading.',
    `nerc_cip_asset_class` STRING COMMENT 'NERC CIP-002 impact classification for this transformer as a bulk electric system (BES) cyber asset or associated physical asset. Determines the applicable NERC CIP security controls, physical security perimeter requirements, and regulatory audit scope.. Valid values are `high|medium|low|not_applicable`',
    `next_inspection_date` DATE COMMENT 'Date of the next scheduled preventive maintenance inspection for this transformer, as planned in Oracle WAM / IBM Maximo. Drives maintenance work order generation and outage scheduling coordination.',
    `num_phases` STRING COMMENT 'Number of electrical phases (1 or 3) for this transformer unit. Bulk transmission transformers are typically three-phase; single-phase units may be used in spare bank configurations. Affects protection design and spare equipment strategy.',
    `oil_type` STRING COMMENT 'Type of dielectric insulating fluid used in the transformer tank. Mineral oil is conventional; FR3 natural ester is fire-resistant and biodegradable; silicone is used in fire-sensitive locations; askarel (PCB-based) is legacy and subject to EPA TSCA regulations. Drives environmental compliance and DGA interpretation.. Valid values are `mineral_oil|FR3_natural_ester|silicone|askarel`',
    `oil_volume_gallons` DECIMAL(18,2) COMMENT 'Total volume of insulating oil contained in the transformer tank, expressed in US gallons. Required for EPA Spill Prevention, Control, and Countermeasure (SPCC) plan compliance and environmental risk assessment.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the transformer on the bulk electric system (BES). Drives NERC reliability reporting, maintenance scheduling, and capacity planning. in_service indicates energized and carrying load; spare indicates available but not energized.. Valid values are `in_service|out_of_service|spare|retired|under_maintenance|commissioning`',
    `protection_zone` STRING COMMENT 'Identifier for the protection relay zone (e.g., Zone T1-A) within which this transformer is protected. Used by protection engineers for relay coordination studies and NERC PRC compliance documentation.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transformer master record was first created in the source system (Oracle WAM / IBM Maximo) and ingested into the Databricks Silver Layer. Used for data lineage, audit trail, and record lifecycle tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this transformer master record in the source system. Used for incremental ETL processing, change data capture, and audit compliance under SOX Section 404.',
    `retirement_date` DATE COMMENT 'Date the transformer was permanently removed from service and retired from the asset base. Triggers removal from FERC rate base, final depreciation entry, and NERC asset deregistration. Nullable for active assets.',
    `serial_number` STRING COMMENT 'Manufacturer-assigned serial number stamped on the transformer nameplate. Uniquely identifies the physical unit for warranty tracking, recall management, and DGA correlation.',
    `tap_changer_type` STRING COMMENT 'Type of voltage regulation mechanism: LTC (Load Tap Changer) allows on-load voltage adjustment; fixed tap has no regulation capability; DETC (De-Energized Tap Changer) requires de-energization for adjustment. Drives voltage control strategy and SCADA integration requirements.. Valid values are `LTC|fixed|DETC`',
    `tap_position_max` STRING COMMENT 'Maximum allowable tap position for the tap changer, defining the upper bound of the voltage regulation range. Used in voltage control studies and protection relay settings.',
    `tap_position_min` STRING COMMENT 'Minimum allowable tap position for the tap changer, defining the lower bound of the voltage regulation range. Used in voltage control studies and protection relay settings.',
    `tap_position_nominal` STRING COMMENT 'The nominal (design) tap position number for the transformers tap changer, as specified on the nameplate. Used as the baseline reference for voltage regulation studies and SCADA setpoint configuration.',
    `transformer_name` STRING COMMENT 'Human-readable designation for the transformer, typically combining substation name and bank identifier (e.g., RIVERSIDE-T1). Used in operational displays, SCADA, and outage management systems.',
    `transformer_type` STRING COMMENT 'Classification of the transformer by design topology. Power transformers have electrically isolated windings; autotransformers share a common winding; phase-shifting transformers control power flow angle; grounding transformers establish a neutral point.. Valid values are `power_transformer|autotransformer|phase_shifting_transformer|grounding_transformer`',
    `tv_kv_rating` DECIMAL(18,2) COMMENT 'Nameplate rated voltage in kilovolts (kV) for the tertiary winding, if present (three-winding transformer). Nullable for two-winding units. Used in reactive power compensation and station service supply modeling.',
    `voltage_class` STRING COMMENT 'Nominal transmission voltage class of the transformers high-voltage winding, expressed as a standard IEEE voltage class designation. Used for grid topology segmentation, OATT capacity reporting, and transmission planning studies. [ENUM-REF-CANDIDATE: 69kV|115kV|138kV|230kV|345kV|500kV|765kV — promote to reference product]',
    `weight_lbs` DECIMAL(18,2) COMMENT 'Total shipping/installed weight of the transformer in pounds, including oil. Critical for transportation logistics planning, foundation structural design, and spare transformer procurement and mobilization planning.',
    `winding_configuration` STRING COMMENT 'Electrical winding connection configuration of the transformer (e.g., delta-wye grounded, wye-wye). Determines zero-sequence impedance characteristics, ground fault current paths, and protection relay settings.. Valid values are `delta_wye|wye_wye|delta_delta|wye_delta|auto`',
    CONSTRAINT pk_transformer PRIMARY KEY(`transformer_id`)
) COMMENT 'Master record for bulk transmission power transformers and autotransformers installed at BES substations. Captures transformer nameplate data (MVA rating, HV/LV/TV kV, impedance %), manufacturer, serial number, installation date, cooling class (ONAN/ONAF/OFAF), tap changer type (LTC/fixed), dissolved gas analysis (DGA) baseline, NERC CIP asset classification, and current operational status. Distinct from distribution transformers owned by the distribution domain. Source system: Oracle WAM/IBM Maximo.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`grid_topology` (
    `grid_topology_id` BIGINT COMMENT 'Unique surrogate identifier for each versioned grid topology snapshot record in the bulk electric system (BES) logical network model.',
    `contingency_scenario_id` BIGINT COMMENT 'Reference identifier for the contingency scenario (N-1, N-2, or N-k) that this topology represents, if applicable. Null for base case topologies. Links to the contingency analysis study that generated this scenario. Used in transmission planning and reliability studies per NERC TPL standards.',
    `control_area_id` BIGINT COMMENT 'Identifier for the Balancing Authority (BA) or Control Area within which this topology model is operative. Aligns with NERC Balancing Authority Area definitions and is used for interchange scheduling, ACE calculations, and reliability coordination.',
    `previous_version_grid_topology_id` BIGINT COMMENT 'Self-referencing identifier pointing to the immediately preceding topology version that this record supersedes. Enables reconstruction of the topology version chain for historical analysis, model rollback, and change audit. Null for the initial topology version.',
    `approved_by` STRING COMMENT 'Name or employee identifier of the transmission planning engineer or system operator who approved this topology version for use in operations or studies. Required for model governance and NERC audit trail.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when this topology version was formally approved for operational or study use. Part of the model governance lifecycle. Required for NERC compliance audit trails and change management documentation.',
    `branch_count` STRING COMMENT 'Total number of branches (transmission lines, transformers, series capacitors/reactors) in this topology model. Together with bus_count, characterizes the size and complexity of the network model. Used for model validation and change tracking.',
    `bus_count` STRING COMMENT 'Total number of electrical buses (nodes) in this topology model. A bus represents an electrical connection point in the network. Used to characterize model size, validate model completeness, and track network growth over topology versions.',
    `change_description` STRING COMMENT 'Free-text narrative describing the specific change that caused this topology version to be created (e.g., Opened breaker 52-A at Substation XYZ for planned maintenance on 138kV line L-101). Provides operational context for model change audits and post-event analysis.',
    `contingency_type` STRING COMMENT 'Classification of the contingency level this topology models. N-0 = normal (base case); N-1 = single element outage; N-2 = double element outage; N-k = multiple element outage; extreme_event = beyond design basis event per NERC TPL-007. Null for base case records.. Valid values are `N-0|N-1|N-2|N-k|extreme_event`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this topology version record was first created in the data platform. Audit field for data lineage and Silver layer ingestion tracking.',
    `effective_end_timestamp` TIMESTAMP COMMENT 'Date and time (ISO 8601 with timezone) at which this topology version was superseded or retired. Null indicates the currently active topology. Together with effective_start_timestamp, defines the validity window for this snapshot.',
    `effective_start_timestamp` TIMESTAMP COMMENT 'Date and time (ISO 8601 with timezone) from which this topology version became the operative electrical connectivity model of the BES. Marks the beginning of the validity window for this snapshot.',
    `ems_model_reference` STRING COMMENT 'The native model identifier assigned by the ABB or GE Energy Management System to this topology configuration. Used for cross-referencing between the Silver layer data product and the operational EMS/SCADA platform for model reconciliation and audit.',
    `ems_model_sync_status` STRING COMMENT 'Indicates whether this topology version is synchronized with the real-time EMS/SCADA network model (ABB or GE EMS). synchronized = topology matches current EMS model; out_of_sync = discrepancy detected; pending_sync = synchronization in progress; sync_failed = synchronization attempt failed. Critical for ensuring real-time grid operations use the correct model.. Valid values are `synchronized|out_of_sync|pending_sync|sync_failed`',
    `generator_count` STRING COMMENT 'Total number of generating units (including conventional, nuclear, and renewable) represented in this topology model. Used to validate model completeness against the known generation fleet and to support capacity adequacy assessments.',
    `is_base_case` BOOLEAN COMMENT 'Indicates whether this topology version represents the base case (pre-contingency, normal operating configuration) of the network model. True = base case; False = contingency or modified scenario. Base cases are the reference point for N-1 and N-k contingency analysis.',
    `is_cip_applicable` BOOLEAN COMMENT 'Indicates whether this topology model includes Critical Infrastructure Protection (CIP) applicable assets (High or Medium impact BES Cyber Systems). True = CIP standards apply; False = no CIP-applicable assets in scope. Drives cybersecurity and access control requirements for model handling.',
    `is_nerc_bes` BOOLEAN COMMENT 'Indicates whether the elements represented in this topology model are classified as part of the NERC Bulk Electric System (BES). True = BES-applicable elements subject to NERC reliability standards and FERC jurisdiction; False = non-BES distribution elements. Drives NERC CIP compliance applicability.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this topology version record was last modified in the data platform. Used for incremental load detection and audit trail maintenance.',
    `load_count` STRING COMMENT 'Total number of load buses or load injection points represented in this topology model. Used for model validation and to ensure all significant load centers are represented in power flow and contingency studies.',
    `model_change_reason` STRING COMMENT 'Business reason that triggered the creation of this new topology version. Captures the operational event or administrative action that altered the electrical connectivity of the BES. [ENUM-REF-CANDIDATE: switching_operation|new_construction|seasonal_reconfiguration|maintenance_outage|emergency_reconfiguration|model_correction|interconnection_addition — promote to reference product]',
    `model_type` STRING COMMENT 'Specifies the electrical network representation paradigm used in this topology model. bus_branch is the simplified model used for power flow studies (PSS/E, PSLF); node_breaker is the detailed model used in real-time EMS/SCADA state estimation reflecting individual breaker and switch positions.. Valid values are `bus_branch|node_breaker`',
    `model_version_notes` STRING COMMENT 'Free-text field for additional notes, caveats, or known limitations associated with this topology version (e.g., Pending interconnection queue additions not yet reflected, Temporary configuration during substation expansion). Supports model management and peer review processes.',
    `nerc_reliability_region` STRING COMMENT 'The NERC Regional Entity (RE) jurisdiction applicable to this topology model. Determines which regional reliability standards and compliance obligations apply to the BES elements represented in this topology.. Valid values are `MRO|NPCC|RF|SERC|Texas RE|WECC`',
    `network_island_code` STRING COMMENT 'Identifier for the electrically isolated network island (synchronous zone) to which this topology belongs. A network island is a set of buses electrically connected and operating synchronously. Multiple islands may exist during islanding events or planned separations. Sourced from EMS state estimator island detection.',
    `peak_load_mw` DECIMAL(18,2) COMMENT 'Total peak system load in megawatts (MW) represented in this topology model snapshot. Used for transmission adequacy assessments, N-1 contingency analysis, and seasonal planning studies. Sourced from EMS load flow solution.',
    `power_flow_solution_status` STRING COMMENT 'Result status of the power flow (load flow) solution for this topology model. converged indicates a valid AC power flow solution was obtained; diverged indicates the power flow failed to converge; not_run indicates no power flow was executed; infeasible indicates no feasible solution exists under the modeled conditions. Distinct from state_estimator_status which applies to real-time EMS.. Valid values are `converged|diverged|not_run|infeasible`',
    `rto_iso_region` STRING COMMENT 'The RTO or ISO control area within which this topology model applies (e.g., PJM, MISO, CAISO, SPP, ERCOT, NYISO, ISO-NE). Determines applicable OATT, LMP pricing nodes, and interchange scheduling rules. Required for FERC jurisdictional reporting.',
    `seasonal_period` STRING COMMENT 'The seasonal operating period this topology model represents. Seasonal configurations may differ due to line ratings, transformer tap positions, and generation dispatch patterns. Used for seasonal transmission planning studies and NERC TPL compliance assessments.. Valid values are `summer_peak|winter_peak|spring_light_load|fall_light_load|annual`',
    `snapshot_timestamp` TIMESTAMP COMMENT 'The precise real-world date and time at which this topology snapshot was captured from the EMS/SCADA system (ABB or GE EMS). Represents the actual grid state at that moment, distinct from the effective validity window. Critical for real-time state estimation and post-event analysis.',
    `source_system` STRING COMMENT 'Identifies the originating system from which this topology model was extracted or generated. ABB_EMS or GE_EMS for real-time operational models; PSSE or PSLF for planning study models; manual for manually constructed models. Supports data lineage and model provenance tracking.. Valid values are `ABB_EMS|GE_EMS|PSSE|PSLF|manual`',
    `state_estimator_status` STRING COMMENT 'Result status of the EMS state estimator solution for this topology snapshot. converged indicates a valid, solved network state; diverged indicates the state estimator failed to find a solution (unreliable topology); not_run indicates state estimation was not executed; flat_start indicates initialization from flat voltage profile; initializing indicates solution in progress.. Valid values are `converged|diverged|not_run|flat_start|initializing`',
    `study_model_file_reference` STRING COMMENT 'File path or object storage reference to the PSS/E (.raw/.sav) or PSLF (.epc) study model file corresponding to this topology version. Enables traceability between the data product record and the physical power flow model file used in transmission planning studies.',
    `study_year` STRING COMMENT 'The planning horizon year this topology model represents (e.g., 2024, 2025, 2030). For future-year planning models, this may differ from the snapshot_timestamp year. Used to organize transmission planning study portfolios and IRP model sets.',
    `topology_name` STRING COMMENT 'Human-readable descriptive name for this topology version (e.g., Summer Peak Base Case 2024, Post-Switching N-1 Contingency Model). Used for identification in power flow studies and EMS model management.',
    `topology_status` STRING COMMENT 'Current lifecycle state of this topology version. active indicates the current operative model; archived indicates a historical snapshot retained for audit; draft indicates a model under construction; superseded indicates replaced by a newer version; under_review indicates pending validation.. Valid values are `active|archived|draft|superseded|under_review`',
    `topology_version_number` STRING COMMENT 'Externally-known version identifier for this topology snapshot (e.g., BES-2024-001, BASECASE-Q3-2024). Used by EMS/SCADA, PSS/E, and PSLF study models to reference a specific network configuration. Serves as the business-facing identifier for this topology record.. Valid values are `^[A-Z0-9_-.]{1,50}$`',
    `total_installed_capacity_mw` DECIMAL(18,2) COMMENT 'Aggregate installed generation capacity in megawatts (MW) represented in this topology model. Represents the principal quantitative measure of the generation resources modeled. Used for capacity adequacy analysis, IRP studies, and FERC Form 715 reporting.',
    `total_line_length_miles` DECIMAL(18,2) COMMENT 'Aggregate circuit miles of transmission lines represented in this topology model. Used for asset inventory reconciliation, rate base calculations, and FERC Form 1 reporting. Expressed in miles per U.S. utility convention.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'The nominal system voltage level in kilovolts (kV) that this topology model primarily represents (e.g., 765, 500, 345, 230, 138, 115 kV). For multi-voltage topologies, represents the highest voltage level. Used for BES classification and NERC CIP applicability determination.',
    CONSTRAINT pk_grid_topology PRIMARY KEY(`grid_topology_id`)
) COMMENT 'Represents versioned snapshots of the logical network topology model of the bulk electric system — the bus-branch or node-breaker connectivity model that defines how transmission elements (lines, transformers, buses, breakers, switches) are electrically interconnected. Each record captures a single topology model version with effective date/time, network island identifier, base case flag, contingency scenario reference (N-1/N-2/N-k), EMS/SCADA model synchronization status, state estimator solution status (converged/diverged), and model change reason (switching operation, new construction, seasonal configuration). Topology versions are created when switching operations, construction activities, or seasonal reconfigurations alter the electrical connectivity. Used for real-time state estimation, power flow studies, contingency analysis, and outage coordination. SSOT for the logical electrical connectivity model of the transmission network. Source system: ABB/GE Energy Management System (EMS), PSS/E or PSLF study models.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`transfer_capability` (
    `transfer_capability_id` BIGINT COMMENT 'Primary key for transfer_capability',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to transmission.control_area. Business justification: Transfer capability is calculated between control areas. The transfer_capability table has from_area STRING. Normalizing to FK to control_area. Removes from_area string.',
    `grid_topology_id` BIGINT COMMENT 'Foreign key linking to transmission.grid_topology. Business justification: Available Transfer Capability (ATC) calculations are performed against specific grid topology models (base cases). The base_case_name (STRING) should be replaced with a proper FK base_case_topology_id',
    `superseded_by_transfer_capability_id` BIGINT COMMENT 'Reference to the transmission_capacity_id of the newer ATC calculation record that supersedes this one, when atc_status = SUPERSEDED. Enables lineage tracking of ATC revisions for audit and regulatory review.',
    `atc_mw` DECIMAL(18,2) COMMENT 'Available Transfer Capability in megawatts (MW) — the measure of the transfer capability remaining in the physical transmission network for further commercial activity over and above already committed uses. Calculated as: ATC = TTC - TRM - CBM - Existing Commitments - Pending Commitments. This is the principal QUANTITATIVE_RESULT posted to OASIS for market participants.',
    `atc_status` STRING COMMENT 'Current lifecycle status of this ATC calculation record. POSTED: active and visible on OASIS; REVISED: updated due to recalculation trigger; SUPERSEDED: replaced by a newer calculation for the same path/direction/horizon; WITHDRAWN: removed from OASIS posting; PENDING: calculated but not yet posted. This is the LIFECYCLE_STATUS for the ATC record.. Valid values are `POSTED|REVISED|SUPERSEDED|WITHDRAWN|PENDING`',
    `binding_constraint_type` STRING COMMENT 'The type of physical constraint that is binding (limiting) the TTC and therefore ATC for this path or flowgate. THERMAL: current/thermal rating; VOLTAGE: voltage stability; STABILITY: transient/dynamic stability; LOOP_FLOW: unscheduled loop flow; OTHER: other constraint type. Informs congestion management and grid planning decisions.. Valid values are `THERMAL|VOLTAGE|STABILITY|LOOP_FLOW|OTHER`',
    `calculation_engine` STRING COMMENT 'Identifier or name of the system or software engine that performed the ATC calculation (e.g., ABB EMS ATC Module, GE EMS, Internal ATC Engine v2.1). Supports auditability and traceability of calculation results to the source system.',
    `cbm_mw` DECIMAL(18,2) COMMENT 'Capacity Benefit Margin in megawatts (MW) — the amount of transmission transfer capability reserved by load-serving entities to ensure access to generation from interconnected systems to meet generation reliability requirements. Deducted from TTC in the ATC calculation per NERC MOD-030.',
    `comments` STRING COMMENT 'Free-text field for analyst notes, special conditions, or explanatory remarks associated with this ATC calculation (e.g., reason for manual override, description of unusual topology condition, or coordination notes with neighboring utilities).',
    `contingency_set` STRING COMMENT 'Name or identifier of the contingency set (N-1, N-1-1, or N-2 criteria) applied during the ATC calculation to ensure reliability under credible outage scenarios. Reflects the reliability criteria used per NERC TPL standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this ATC calculation record was first created in the system. Serves as the RECORD_AUDIT_CREATED timestamp for data lineage and audit trail purposes in the Silver Layer lakehouse.',
    `direction` STRING COMMENT 'Direction of power flow for which ATC is calculated on the path or flowgate. FORWARD indicates the defined positive flow direction; REVERSE indicates the opposite direction. Both directions must be posted per NERC MOD and FERC OATT requirements.. Valid values are `FORWARD|REVERSE`',
    `existing_commitments_mw` DECIMAL(18,2) COMMENT 'Total megawatts (MW) of transmission capacity already committed under existing confirmed transmission service agreements (firm and non-firm) at the time of this ATC calculation. Deducted from TTC along with TRM and CBM to derive ATC.',
    `horizon_end_timestamp` TIMESTAMP COMMENT 'End date and time of the study horizon period for which this ATC calculation is valid. Defines the closing boundary of the interval covered by this record.',
    `horizon_start_timestamp` TIMESTAMP COMMENT 'Start date and time of the study horizon period for which this ATC calculation is valid. Represents the beginning of the interval (hourly, daily, weekly, or monthly) covered by this record. This is the principal BUSINESS_EVENT_TIMESTAMP for the ATC calculation.',
    `is_coordinated_path` BOOLEAN COMMENT 'Indicates whether this transmission path requires coordinated ATC calculation with neighboring Transmission Providers or Balancing Authorities (True) or is calculated independently (False). Coordinated paths require inter-utility data exchange per NERC MOD-028.',
    `is_firm_service` BOOLEAN COMMENT 'Indicates whether the ATC calculation applies to firm transmission service (True) or non-firm transmission service (False). Firm service has higher priority and cannot be curtailed except under emergency conditions; non-firm service may be curtailed to accommodate firm service.',
    `loop_flow_adjustment_mw` DECIMAL(18,2) COMMENT 'Adjustment in megawatts (MW) applied to the ATC calculation to account for unscheduled loop flows (parallel path flows) that reduce the effective transfer capability of the path. Loop flow adjustments are required when parallel paths carry unscheduled power flows that consume capacity.',
    `nerc_cip_applicable` BOOLEAN COMMENT 'Indicates whether the transmission path or flowgate involves BES facilities subject to NERC CIP (Critical Infrastructure Protection) cybersecurity standards (True) or not (False). Relevant for data handling, access control, and security classification of associated operational data.',
    `nerc_mod_methodology` STRING COMMENT 'The specific NERC MOD reliability standard methodology applied for this ATC calculation. MOD-028: Available Transfer Capability Methodology; MOD-029: Rated System Path Methodology; MOD-030: Flowgate Methodology. Identifies the approved calculation approach for regulatory audit purposes.. Valid values are `MOD-028|MOD-029|MOD-030`',
    `oasis_posting_reference` STRING COMMENT 'Unique reference number or transaction identifier assigned by the OASIS portal for this ATC posting. Used to cross-reference the internal ATC record with the publicly posted OASIS entry for audit and regulatory compliance under 18 CFR §37.',
    `oatt_tariff_rate_schedule` STRING COMMENT 'The FERC-approved OATT rate schedule under which this transmission paths ATC is calculated and posted (e.g., Schedule 1 - Network Integration, Schedule 7 - Point-to-Point). Links the ATC record to the applicable tariff provisions.',
    `path_flowgate_code` STRING COMMENT 'Externally-known identifier for the transmission path or flowgate for which ATC is being calculated and posted. Corresponds to the path/flowgate designation used in OASIS postings and NERC MOD studies (e.g., PATH-NW-01, FG-345-EAST). This is the BUSINESS_IDENTIFIER for the ATC record.',
    `path_flowgate_name` STRING COMMENT 'Human-readable name or description of the transmission path or flowgate (e.g., Northwest Import Path, Eastern 345kV Flowgate). Used for display in OASIS postings and regulatory reports.',
    `pending_commitments_mw` DECIMAL(18,2) COMMENT 'Total megawatts (MW) of transmission capacity reserved for pending (queued but not yet confirmed) transmission service requests at the time of this ATC calculation. Included in the ATC deduction per NERC MOD-028 to reflect capacity under evaluation.',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when this ATC calculation was posted to the OASIS (Open Access Same-Time Information System) portal, making it publicly available to transmission customers and market participants. Required for FERC 18 CFR §37 compliance.',
    `recalculation_trigger` STRING COMMENT 'The event or condition that triggered this ATC recalculation. TOPOLOGY_CHANGE: network topology modification (line switching, outage); SCHEDULE_UPDATE: change in transmission schedules; TLR_EVENT: Transmission Loading Relief event; PERIODIC: routine scheduled recalculation; MANUAL: operator-initiated recalculation; OUTAGE_UPDATE: planned or forced outage affecting the path. [ENUM-REF-CANDIDATE: TOPOLOGY_CHANGE|SCHEDULE_UPDATE|TLR_EVENT|PERIODIC|MANUAL|OUTAGE_UPDATE — promote to reference product]. Valid values are `TOPOLOGY_CHANGE|SCHEDULE_UPDATE|TLR_EVENT|PERIODIC|MANUAL|OUTAGE_UPDATE`',
    `rto_iso_region` STRING COMMENT 'The RTO or ISO region within which this transmission path or flowgate is located or coordinated (e.g., PJM, MISO, WECC, SPP, CAISO). Used for regional coordination, market settlement, and FERC jurisdictional reporting.',
    `source_system` STRING COMMENT 'Identifies the operational source system from which this ATC record originated. ABB_EMS or GE_EMS: Energy Management System ATC module; OASIS_PORTAL: imported from OASIS posting; ATC_ENGINE: internal ATC calculation engine; MANUAL: manually entered by analyst. Supports data lineage in the Silver Layer.. Valid values are `ABB_EMS|GE_EMS|OASIS_PORTAL|ATC_ENGINE|MANUAL`',
    `stability_limit_mw` DECIMAL(18,2) COMMENT 'The transient or dynamic stability limit in megawatts (MW) for the transmission path, representing the maximum power transfer before loss of synchronism. May be the binding constraint on TTC when stability governs over thermal or voltage limits.',
    `study_analyst` STRING COMMENT 'Name or identifier of the transmission planning or operations analyst responsible for reviewing and approving this ATC calculation before OASIS posting. Supports accountability and audit trail for regulatory compliance.',
    `study_horizon` STRING COMMENT 'Time horizon for which the ATC calculation applies. Determines the granularity of the posting: HOURLY (real-time/intraday), DAILY (next-day), WEEKLY, or MONTHLY. Required for OASIS posting categorization under 18 CFR §37.. Valid values are `HOURLY|DAILY|WEEKLY|MONTHLY`',
    `thermal_limit_mw` DECIMAL(18,2) COMMENT 'The thermal (current-carrying) rating limit in megawatts (MW) for the transmission path or flowgate, representing the maximum continuous power flow before equipment damage risk. Used as a constraint in TTC and ATC calculations.',
    `tlr_level` STRING COMMENT 'The Transmission Loading Relief (TLR) level (1–6) in effect on this path at the time of the ATC calculation, if applicable. TLR is a NERC procedure to alleviate transmission overloads. A non-zero value indicates congestion-driven recalculation was triggered.',
    `to_area` STRING COMMENT 'Name or identifier of the receiving (sink) control area or Balancing Authority Area for the transmission path. Defines the destination end of the transfer path for directional ATC calculations and OASIS postings.',
    `transmission_provider` STRING COMMENT 'Name of the Transmission Provider (TP) responsible for calculating and posting this ATC value. Identifies the utility or entity with FERC OATT obligations for this path. This is the PARTY_REFERENCE for the ATC record (the responsible transmission owner/operator).',
    `trm_mw` DECIMAL(18,2) COMMENT 'Transmission Reliability Margin in megawatts (MW) — the amount of transmission transfer capability reserved to ensure that the interconnected transmission network is secure under a reasonable range of uncertainties in system conditions. Deducted from TTC in the ATC calculation per NERC MOD-029.',
    `ttc_mw` DECIMAL(18,2) COMMENT 'Total Transfer Capability in megawatts (MW) — the maximum amount of electric power that can be transferred reliably over the interconnected transmission network in a reliable manner while meeting all applicable reliability criteria. Calculated per NERC MOD-028 methodology. TTC is the starting point for ATC derivation: ATC = TTC - TRM - CBM - existing commitments - pending commitments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this ATC calculation record was last modified in the system. Serves as the RECORD_AUDIT_UPDATED timestamp for change tracking and data lineage in the Silver Layer lakehouse.',
    `voltage_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level in kilovolts (kV) of the transmission path or flowgate (e.g., 115, 230, 345, 500, 765 kV). Identifies the BES voltage class of the facility, relevant for NERC CIP applicability and reliability standard compliance.',
    `voltage_limit_mw` DECIMAL(18,2) COMMENT 'The voltage stability limit in megawatts (MW) for the transmission path, representing the maximum power transfer before voltage collapse risk. May be the binding constraint on TTC when voltage stability governs over thermal limits.',
    CONSTRAINT pk_transfer_capability PRIMARY KEY(`transfer_capability_id`)
) COMMENT 'Tracks available transfer capability (ATC), total transfer capability (TTC), transmission reliability margin (TRM), and capacity benefit margin (CBM) for transmission paths and flowgates on the BES. Each record represents a single ATC calculation for a specific path/flowgate, direction, and time horizon. Captures path/flowgate identifier, direction (forward/reverse), TTC (MW), TRM (MW), CBM (MW), ATC (MW) calculated per NERC MOD-028/029/030 methodology, posted date/time, study horizon (hourly/daily/weekly/monthly), OATT OASIS posting reference, and recalculation trigger (topology change/schedule update/TLR event). ATC = TTC - TRM - CBM - existing commitments - pending commitments. Required for FERC OATT compliance, OASIS posting obligations under 18 CFR §37, and NERC MOD standard compliance. Source system: ABB/GE EMS, OASIS portal, internal ATC calculation engine.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`interchange_schedule` (
    `interchange_schedule_id` BIGINT COMMENT 'Unique surrogate identifier for each interchange schedule record in the Databricks Silver Layer. Primary key for this entity. Entity role: TRANSACTION_HEADER — represents a discrete scheduled energy interchange event with a full lifecycle (draft/confirmed/curtailed/settled).',
    `balancing_authority_id` BIGINT COMMENT 'Reference to the counterparty balancing authority entity involved in this interchange schedule. Represents the neighboring BA or RTO/ISO with which energy is being exchanged. Satisfies TRANSACTION_HEADER PARTY_REFERENCE category.',
    `ppa_contract_id` BIGINT COMMENT 'Reference to the Power Purchase Agreement (PPA) or bilateral contract under which this interchange schedule is executed. Null for spot market or RTO/ISO market-cleared transactions. Links to the market ppa_contract product.',
    `pricing_node_id` BIGINT COMMENT 'Reference to the pricing node (pnode) at which the Locational Marginal Price (LMP) applies for settlement of this interchange schedule. Links to the market pricing node master for LMP-based financial settlement of RTO/ISO transactions.',
    `rto_iso_id` BIGINT COMMENT 'FK to market.rto_iso',
    `transmission_right_id` BIGINT COMMENT 'Reference to the transmission service right or firm transmission reservation (FTR/TCC) under which this interchange is scheduled. Links to the market transmission_right product for OATT compliance and capacity entitlement tracking.',
    `actual_mw` DECIMAL(18,2) COMMENT 'The actual metered interchange amount in MW for this interval, as recorded by the EMS/SCADA historian (OSIsoft PI or GE Proficy). Compared against scheduled_mw to compute inadvertent interchange for NERC BAL-006 compliance reporting.',
    `checkout_status` STRING COMMENT 'Current approval/checkout status of the interchange schedule as returned by the counterparty BA or RTO/ISO scheduling portal: confirmed (approved by all parties), denied (rejected), or pending (awaiting confirmation). Satisfies TRANSACTION_HEADER LIFECYCLE_STATUS category.. Valid values are `confirmed|denied|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'The datetime when this interchange schedule record was first created in the Silver Layer data product. Satisfies TRANSACTION_HEADER RECORD_AUDIT_CREATED category. Used for data lineage and audit trail.',
    `curtailed_mw` DECIMAL(18,2) COMMENT 'The amount of the scheduled interchange (in MW) that was curtailed and not delivered. Populated when curtailment_flag is True. Used for inadvertent interchange accounting under NERC BAL-006 and for settlement dispute resolution.',
    `curtailment_flag` BOOLEAN COMMENT 'Indicates whether this interchange schedule has been curtailed (True) or is operating at full scheduled capacity (False). Curtailment may be initiated by the transmission provider, RTO/ISO, or counterparty BA due to congestion, reliability events, or emergency conditions.',
    `curtailment_priority` STRING COMMENT 'Numeric priority ranking assigned to this interchange schedule for curtailment sequencing. Lower numbers indicate higher priority (curtailed last). Determined by the transmission service agreement and OATT curtailment provisions. Used by EMS during congestion management.',
    `energy_mwh` DECIMAL(18,2) COMMENT 'The scheduled energy quantity in megawatt-hours (MWh) for this interval, derived from scheduled_mw and interval_duration_min. Stored as a business field for direct use in settlement calculations and FERC EQR energy quantity reporting without requiring runtime computation.',
    `etag_reference_number` STRING COMMENT 'The e-Tag reference number assigned by the NERC e-Tag system (OATI webTrans) for this interchange transaction. Used to track the energy transaction across all involved balancing authorities, transmission providers, and generation/load entities. Required for NERC INT compliance.',
    `ferc_eqr_reportable` BOOLEAN COMMENT 'Indicates whether this interchange schedule must be reported in the FERC Electric Quarterly Report (EQR) (True) or is exempt (False). Bilateral transactions above FERC threshold quantities are reportable. Drives automated EQR filing population.',
    `inadvertent_mw` DECIMAL(18,2) COMMENT 'The difference between actual_mw and scheduled_mw for this interval, representing inadvertent interchange. Positive values indicate over-delivery; negative values indicate under-delivery. Directly used in NERC BAL-006 (Inadvertent Interchange) compliance calculations and regulatory reporting.',
    `interval_duration_min` STRING COMMENT 'Duration of the scheduled interchange interval in minutes (e.g., 60 for hourly, 15 for sub-hourly quarter-hour intervals, 5 for five-minute real-time intervals). Determines the granularity of the schedule and aligns with RTO/ISO market interval definitions.',
    `interval_end_datetime` TIMESTAMP COMMENT 'The end datetime of the scheduled interchange interval. Combined with interval_start_datetime defines the precise scheduling window for this energy transfer. Required for NERC INT compliance and inadvertent interchange accounting.',
    `interval_start_datetime` TIMESTAMP COMMENT 'The start datetime of the scheduled interchange interval (hourly or sub-hourly). Represents the principal real-world business event time for this schedule. Stored in ISO 8601 format with timezone offset. Satisfies TRANSACTION_HEADER BUSINESS_EVENT_TIMESTAMP category.',
    `is_dynamic_transfer` BOOLEAN COMMENT 'Indicates whether this interchange schedule involves a dynamic transfer (True), where generation control is transferred in real time between BAs, as opposed to a static scheduled interchange (False). Dynamic transfers require special EMS coordination and NERC INT-004 dynamic schedule provisions.',
    `market_type` STRING COMMENT 'Indicates whether this interchange schedule was submitted through the Day-Ahead Market (DAM), Real-Time Market (RTM), or as a bilateral transaction outside of RTO/ISO market clearing. Drives settlement pathway and FERC EQR categorization.. Valid values are `DAM|RTM|bilateral`',
    `nerc_bal006_reportable` BOOLEAN COMMENT 'Indicates whether this interchange schedule contributes to the utilitys NERC BAL-006 (Inadvertent Interchange) compliance reporting obligation (True) or is excluded (e.g., dynamic transfers handled separately). Drives automated inclusion in regulatory compliance extracts.',
    `nerc_etag_number` STRING COMMENT 'The unique NERC-assigned e-Tag identifier for this interchange transaction, distinct from the internal reference number. Serves as the authoritative cross-BA identifier for the scheduled energy transfer and is required for NERC INT-004 and FERC EQR reporting.',
    `notes` STRING COMMENT 'Free-text field for scheduling desk annotations, curtailment reason descriptions, dispute notes, or other operational commentary associated with this interchange schedule. Not used for structured data; intended for human-readable context.',
    `operating_date` DATE COMMENT 'The calendar date on which this interchange schedule is operative. Used as the primary date partition key for the Silver Layer table and for day-ahead vs. real-time market reconciliation. Aligns with the RTO/ISO operating day definition.',
    `operating_hour` STRING COMMENT 'The hour-ending (HE) designation for this interchange schedule (1–24), following NERC and RTO/ISO convention for hourly scheduling. Used in conjunction with operating_date for schedule identification and inadvertent interchange accounting.',
    `ramp_rate_mw_per_min` DECIMAL(18,2) COMMENT 'The rate at which the scheduled interchange is ramped up or down, expressed in megawatts per minute (MW/min). Used by the EMS for automatic generation control (AGC) and grid stability management. Required field in NERC e-Tag submissions.',
    `schedule_confirmed_datetime` TIMESTAMP COMMENT 'The datetime when the interchange schedule received confirmed checkout status from all required parties (counterparty BA, transmission provider, RTO/ISO). Null if checkout_status is pending or denied. Used for NERC INT-006 compliance timing analysis.',
    `schedule_number` STRING COMMENT 'Externally-known alphanumeric identifier for this interchange schedule, as assigned by the EMS or RTO/ISO scheduling portal (e.g., ABB/GE EMS schedule reference). Used for cross-system reconciliation and NERC e-Tag correlation. Satisfies TRANSACTION_HEADER BUSINESS_IDENTIFIER category.',
    `schedule_submitted_datetime` TIMESTAMP COMMENT 'The datetime when this interchange schedule was submitted to the RTO/ISO scheduling portal or counterparty BA via OATI webTrans or EMS. Used for deadline compliance tracking under NERC INT-004 (schedule submission timing requirements).',
    `schedule_type` STRING COMMENT 'Classification of the interchange schedule indicating the direction and nature of the energy transfer: import (energy received into the utility BA), export (energy sent out of the utility BA), wheel_through (energy transiting the BA without being consumed), or dynamic_transfer (real-time transfer of generation control). Satisfies TRANSACTION_HEADER CLASSIFICATION_OR_TYPE category.. Valid values are `import|export|wheel_through|dynamic_transfer`',
    `schedule_version` STRING COMMENT 'Version number of this interchange schedule, incremented each time the schedule is revised or re-submitted. Version 1 is the original submission; subsequent versions reflect amendments. Used to track schedule revisions and identify the latest active version for a given schedule_number.',
    `scheduled_mw` DECIMAL(18,2) COMMENT 'The scheduled energy interchange amount in megawatts (MW) for this interval. Positive values indicate export from the utility BA; negative values indicate import. This is the primary quantitative fact for the interchange schedule. Satisfies TRANSACTION_HEADER QUANTITATIVE_RESULT category.',
    `scheduling_entity_code` STRING COMMENT 'The NERC-registered code of the entity responsible for submitting this interchange schedule (typically the utilitys transmission scheduling desk or a third-party scheduling coordinator). Required for NERC INT-009 compliance and e-Tag accountability.',
    `settlement_status` STRING COMMENT 'Financial settlement lifecycle status of this interchange schedule: unsettled (not yet financially cleared), settled (financially cleared and posted), disputed (under dispute with counterparty or RTO/ISO), or adjusted (settlement amount revised post-initial clearing). Supports FERC EQR and revenue management reporting.. Valid values are `unsettled|settled|disputed|adjusted`',
    `sink_ba_code` STRING COMMENT 'NERC-assigned code for the balancing authority area where the energy is delivered (sink BA). For import schedules, this is the utilitys own BA code. For export schedules, this is the counterparty BA code. Required field in NERC e-Tag and INT standard reporting.',
    `source_ba_code` STRING COMMENT 'NERC-assigned code for the balancing authority area where the energy originates (source BA). For export schedules, this is the utilitys own BA code. For import schedules, this is the counterparty BA code. Required field in NERC e-Tag and INT standard reporting.',
    `source_system` STRING COMMENT 'Identifies the originating operational system that generated or submitted this interchange schedule record: ABB_EMS or GE_EMS (Energy Management System), OATI_webTrans (NERC e-Tag platform), RTO_portal (direct RTO/ISO scheduling interface), or manual (manually entered by scheduling desk).. Valid values are `ABB_EMS|GE_EMS|OATI_webTrans|RTO_portal|manual`',
    `transmission_path` STRING COMMENT 'The designated transmission path or flowgate identifier over which this interchange is scheduled (e.g., PJM-MISO Interface, Seams path designation). Used for transmission capacity reservation tracking and OATT compliance. May reference an ATC/TTC path.',
    `updated_timestamp` TIMESTAMP COMMENT 'The datetime when this interchange schedule record was last modified in the Silver Layer data product. Satisfies TRANSACTION_HEADER RECORD_AUDIT_UPDATED category. Used for change tracking, incremental ETL processing, and audit trail.',
    CONSTRAINT pk_interchange_schedule PRIMARY KEY(`interchange_schedule_id`)
) COMMENT 'Records energy interchange schedules between the utilitys balancing authority area and RTO/ISO markets or neighboring balancing authorities. Each record represents a single scheduled interchange for a specific hourly or sub-hourly time interval. Captures schedule ID, counterparty BA identifier, RTO/ISO name, schedule type (import/export/wheel-through/dynamic transfer), energy amount (MW), ramp rate (MW/min), start/end datetime, e-Tag reference number, NERC e-Tag ID, curtailment flag, curtailment priority, checkout status (confirmed/denied/pending), and settlement status. Supports day-ahead market (DAM), real-time market (RTM), and bilateral transaction scheduling. Critical for NERC BAL-006 (Inadvertent Interchange) compliance, NERC INT standards (INT-004, INT-006, INT-009, INT-010), and FERC EQR (Electric Quarterly Report) reporting. Source system: ABB/GE EMS, NERC e-Tag system (OATI webTrans), RTO scheduling portals.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`service_request` (
    `service_request_id` BIGINT COMMENT 'Primary key for service_request',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Transmission service administration costs are allocated to cost centers by service type and region for FERC functional cost allocation, rate design cost studies, and tracking of OATT service provision',
    `interconnection_request_id` BIGINT COMMENT 'Foreign key linking to transmission.interconnection_request. Business justification: Service requests can be for interconnection service. The service_request table has interconnection_request_flag BOOLEAN. When true, there should be a FK to the actual interconnection_request. Removes ',
    `party_id` BIGINT COMMENT 'Reference to the eligible customer or third-party entity (e.g., load-serving entity, generator, marketer) submitting the transmission service request under the OATT. Links to the wholesale counterparty or market participant registry.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: OATT service requests specify point of receipt (where power enters the transmission system). The current point_of_receipt is a STRING. Normalizing to FK to transmission_substation. Removes point_of_re',
    `approved_capacity_mw` DECIMAL(18,2) COMMENT 'The amount of transmission capacity approved by the transmission provider following study completion, expressed in Megawatts (MW). May differ from requested capacity due to system constraints or congestion. Null until approval decision is made.',
    `atc_available_mw` DECIMAL(18,2) COMMENT 'The Available Transfer Capability (ATC) in Megawatts on the relevant transmission path at the time the service request was submitted. Captured as a snapshot to document the grid conditions that informed the feasibility assessment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission service request record was first captured in the data platform. Used for audit and data lineage tracking.',
    `curtailment_priority` STRING COMMENT 'Numeric priority assigned to this transmission service request for curtailment ordering during periods of transmission congestion or system emergencies. Lower numbers indicate higher priority (curtailed last). Firm service receives higher priority than non-firm.',
    `denial_reason` STRING COMMENT 'Explanation of the reason for denial or conditional approval of the transmission service request, such as insufficient ATC, reliability violations, or failure to execute a service agreement. Null for approved or pending requests. Required for FERC OATT non-discrimination compliance.',
    `deposit_amount_usd` DECIMAL(18,2) COMMENT 'The deposit amount in US Dollars collected from the requesting entity to fund the feasibility, system impact, and facilities studies. Refundable or credited against final upgrade costs per OATT provisions.',
    `deposit_received_date` DATE COMMENT 'Date on which the study deposit was received from the requesting entity. Receipt of deposit typically triggers the start of the study process under OATT timelines.',
    `estimated_upgrade_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost in US Dollars of transmission network upgrades required to accommodate the requested service, as determined by the Facilities Study. Used for cost allocation, Contribution in Aid of Construction (CIAC) determination, and rate case support.',
    `facilities_study_completion_date` DATE COMMENT 'Date on which the Facilities Study was completed and results were communicated to the requesting entity. Triggers the service agreement negotiation phase.',
    `facilities_study_status` STRING COMMENT 'Current status of the Facilities Study identifying the specific transmission upgrades or new facilities required to accommodate the requested service. Third and final study phase under FERC Order 2003.. Valid values are `not_required|pending|in_progress|complete|waived`',
    `feasibility_study_completion_date` DATE COMMENT 'Date on which the feasibility study was completed and results were communicated to the requesting entity. Used for FERC-mandated study timeline compliance tracking.',
    `feasibility_study_status` STRING COMMENT 'Current status of the feasibility study conducted to assess whether the requested transmission service can be accommodated on the existing grid without violating reliability criteria. First study phase under FERC Order 2003 interconnection process.. Valid values are `not_required|pending|in_progress|complete|waived`',
    `ferc_filing_reference` STRING COMMENT 'FERC docket number or filing reference associated with this transmission service request, if the request or resulting agreement requires a FERC filing (e.g., for long-term firm service agreements). Links to regulatory docket tracking.',
    `firmness_indicator` STRING COMMENT 'Indicates whether the requested transmission service is firm (reserved, curtailed last) or non-firm (interruptible, curtailed first during congestion). Drives curtailment priority and pricing under the OATT.. Valid values are `firm|non_firm`',
    `nerc_path_designation` STRING COMMENT 'The NERC-designated transmission path or flowgate associated with this service request. Used for reliability assessments, Available Transfer Capability (ATC) calculations, and congestion management.',
    `oasis_queue_number` STRING COMMENT 'The externally-known queue number assigned by the OASIS portal when the transmission service request is submitted. Used for FERC OATT compliance tracking and public disclosure of transmission queue position.',
    `point_of_delivery` STRING COMMENT 'The designated point on the transmission providers system where energy exits the grid for delivery to the requesting entity. Defined per OATT and corresponds to a specific substation or load node. Industry-standard term: POD.',
    `request_notes` STRING COMMENT 'Free-text field for transmission planners and OATT administrators to record supplemental information, special conditions, study assumptions, or coordination notes related to the service request. Not used for structured data.',
    `request_status` STRING COMMENT 'Current lifecycle state of the transmission service request, tracking progression from initial submission through feasibility, system impact, and facilities studies to final disposition. [ENUM-REF-CANDIDATE: pending|under_study|conditionally_approved|approved|denied|withdrawn|superseded — promote to reference product]',
    `requested_capacity_mw` DECIMAL(18,2) COMMENT 'The amount of transmission capacity requested by the eligible customer, expressed in Megawatts (MW). This is the principal quantitative fact of the service request and drives feasibility and system impact study scope.',
    `requested_end_date` DATE COMMENT 'The date on which the requesting entity desires transmission service to terminate. Null for open-ended or long-term service requests. Used for capacity planning and OATT compliance.',
    `requested_start_date` DATE COMMENT 'The date on which the requesting entity desires transmission service to commence. Used for scheduling, capacity reservation, and OATT compliance tracking.',
    `requesting_entity_duns` STRING COMMENT 'Nine-digit DUNS number uniquely identifying the requesting entity for FERC regulatory reporting and OASIS registration. Required for FERC Form 1 and OATT compliance filings.. Valid values are `^[0-9]{9}$`',
    `requesting_entity_name` STRING COMMENT 'Legal name of the entity requesting transmission service under the OATT. May be a load-serving entity, independent power producer, energy marketer, or other eligible customer. Retained for reporting without requiring a join.',
    `rto_iso_region` STRING COMMENT 'The RTO or ISO region in which the transmission service request is filed. Determines applicable tariff, market rules, and regulatory jurisdiction for the service. [ENUM-REF-CANDIDATE: MISO|PJM|CAISO|SPP|ERCOT|NYISO|ISO_NE|SERC|non_rto — promote to reference product]',
    `service_agreement_number` STRING COMMENT 'Reference number of the executed Transmission Service Agreement (TSA) resulting from an approved service request. Links the request to the binding contractual instrument filed with FERC. Null until agreement is executed.',
    `service_term_type` STRING COMMENT 'Classification of the duration of the requested transmission service. Long-term firm service (one year or more) has different OATT rights and study requirements than short-term service. Drives tariff rate application.. Valid values are `short_term|long_term|monthly|annual|multi_year`',
    `service_type` STRING COMMENT 'Classification of the transmission service being requested under the OATT. Firm Point-to-Point (PTP) provides reserved capacity with curtailment priority; Non-Firm PTP is interruptible; Network Integration Transmission Service (NITS) serves network load. [ENUM-REF-CANDIDATE: firm_ptp|non_firm_ptp|nits|secondary_network|other — promote to reference product]. Valid values are `firm_ptp|non_firm_ptp|nits|secondary_network|other`',
    `sink_load_name` STRING COMMENT 'Name or identifier of the load or sink associated with the transmission service request at the point of delivery. Used for network modeling and system impact study analysis.',
    `source_resource_name` STRING COMMENT 'Name or identifier of the generation resource or energy source associated with the transmission service request at the point of receipt. Used for interconnection queue coordination and system impact studies.',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time the transmission service request was formally submitted to the transmission provider via the OASIS portal. This is the principal business event timestamp establishing queue priority.',
    `system_impact_study_completion_date` DATE COMMENT 'Date on which the System Impact Study was completed and results were communicated to the requesting entity. FERC mandates specific timelines for study completion under the OATT.',
    `system_impact_study_status` STRING COMMENT 'Current status of the System Impact Study (SIS) evaluating the effect of the requested transmission service on the reliability and security of the bulk electric system. Second study phase under FERC Order 2003.. Valid values are `not_required|pending|in_progress|complete|waived`',
    `tariff_rate_schedule` STRING COMMENT 'The specific OATT rate schedule applicable to this transmission service request (e.g., Schedule 7 for firm PTP, Schedule 8 for non-firm PTP). Determines the transmission rate and ancillary service charges applied.',
    `transmission_provider_code` STRING COMMENT 'NERC-assigned or FERC-registered code identifying the transmission provider (utility) responsible for processing this service request. Required for OASIS filings and FERC Form 1 reporting.',
    `transmission_rate_mw_per_year` DECIMAL(18,2) COMMENT 'The applicable transmission rate in US Dollars per Megawatt per year as specified in the OATT rate schedule for this service request. Used for revenue requirement calculation and billing.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission service request record was last modified in the data platform. Used for change tracking and incremental data processing.',
    `withdrawal_date` DATE COMMENT 'Date on which the requesting entity formally withdrew the transmission service request from the queue. Null for active or completed requests. Used for queue management and capacity release tracking.',
    CONSTRAINT pk_service_request PRIMARY KEY(`service_request_id`)
) COMMENT 'Tracks requests for transmission service under the OATT — including point-to-point (PTP) and network integration transmission service (NITS) requests from eligible customers and third parties. Captures request ID, service type (firm/non-firm, PTP/NITS), requesting entity, point of receipt, point of delivery, requested capacity (MW), requested start/end date, OASIS queue number, feasibility study status, system impact study status, facilities study status, and service agreement reference. Required for FERC OATT compliance. Source system: OASIS portal, internal transmission planning systems.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`interconnection_request` (
    `interconnection_request_id` BIGINT COMMENT 'Unique system identifier for the interconnection request record. Primary key for the interconnection request entity.',
    `capex_project_id` BIGINT COMMENT 'Foreign key linking to finance.capex_project. Business justification: Approved interconnection requests trigger network upgrade capital projects. Link tracks cost responsibility allocation, CIAC vs. utility-funded determination, reimbursement accounting, and financial s',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Interconnection processes must comply with FERC Order 2023, state interconnection standards, and RTO tariff study timeline obligations. Business process: queue management compliance, study milestone t',
    `participant_registration_id` BIGINT COMMENT 'Foreign key linking to market.participant_registration. Business justification: Interconnection requests are submitted by registered market participants (generators/developers). RTO queue management, study coordination, cost allocation, and capacity market qualification all requi',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Tracks lifecycle from interconnection request to operational plant after commercial operation date. Essential for project development tracking, queue management, FERC Form 556 reporting, and reconcili',
    `bus_id` BIGINT COMMENT 'Foreign key linking to transmission.bus. Business justification: Interconnection requests specify a point of interconnection (POI), which is a specific bus in the transmission system. This FK links the request to the actual bus. Removes poi_voltage_kv as redundant ',
    `regulatory_asset_entry_id` BIGINT COMMENT 'Foreign key linking to finance.regulatory_asset_entry. Business justification: Network upgrade costs funded by utility and recovered over time are recorded as regulatory assets per FERC Order 2003. Link tracks cost recovery, amortization, and carrying charges for interconnection',
    `rto_iso_id` BIGINT COMMENT 'FK to market.rto_iso',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Interconnection requests specify a point of interconnection (POI) at a transmission substation. The poi_substation_name (STRING) should be replaced with a proper FK poi_substation_id → transmission_su',
    `actual_cod` DATE COMMENT 'Actual date when the project achieved commercial operation. Populated only after the project is energized and operational.',
    `applicant_contact_email` STRING COMMENT 'Primary email address for the applicant or their authorized representative for interconnection request communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `applicant_contact_phone` STRING COMMENT 'Primary telephone number for the applicant or their authorized representative.',
    `applicant_name` STRING COMMENT 'Legal name of the entity or individual submitting the interconnection request. May be a generation developer, industrial customer, or distributed energy resource owner.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this interconnection request record was first created in the system. Used for audit and data lineage tracking.',
    `environmental_permit_status` STRING COMMENT 'Status of required environmental permits (e.g., EPA air quality permits, state environmental permits, wetlands permits) for the generation project.. Valid values are `not_required|pending|approved|denied`',
    `estimated_interconnection_facility_cost` DECIMAL(18,2) COMMENT 'Estimated cost in USD for the direct interconnection facilities (e.g., generator lead line, metering equipment, protective relays) required to connect the project to the point of interconnection.',
    `estimated_network_upgrade_cost` DECIMAL(18,2) COMMENT 'Estimated total cost in USD for transmission network upgrades required to accommodate the interconnection. Includes substation modifications, line upgrades, and protection system enhancements. Based on facilities study results.',
    `facilities_study_completion_date` DATE COMMENT 'Date when the facilities study was completed and results delivered to the applicant.',
    `facilities_study_start_date` DATE COMMENT 'Date when the facilities study phase commenced. Facilities study provides detailed engineering design and final cost estimates for required upgrades.',
    `feasibility_study_completion_date` DATE COMMENT 'Date when the feasibility study was completed and results delivered to the applicant.',
    `feasibility_study_start_date` DATE COMMENT 'Date when the feasibility study phase commenced. Feasibility study evaluates high-level technical viability and preliminary cost estimates.',
    `interconnection_agreement_executed_date` DATE COMMENT 'Date when the formal interconnection agreement (IA) or generator interconnection agreement (GIA) was executed between the applicant and the transmission provider.',
    `is_energy_only` BOOLEAN COMMENT 'Boolean flag indicating whether the applicant requested Energy Resource Interconnection Service (ERIS), which allows energy-only delivery without firm capacity rights.',
    `is_network_resource` BOOLEAN COMMENT 'Boolean flag indicating whether the applicant requested Network Resource Interconnection Service (NRIS), which allows the generator to be designated as a network resource for capacity and energy delivery.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this interconnection request record was last updated. Used for audit and data lineage tracking.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special conditions, or clarifications related to the interconnection request. Used for internal coordination and regulatory reporting context.',
    `poi_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the proposed point of interconnection in decimal degrees. Used for GIS mapping and transmission planning analysis.',
    `poi_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the proposed point of interconnection in decimal degrees. Used for GIS mapping and transmission planning analysis.',
    `project_name` STRING COMMENT 'Business name or title of the generation or load project seeking interconnection. Used for public queue reporting and regulatory filings.',
    `project_type` STRING COMMENT 'Classification of the interconnection request by project category: generation (new power plant), load (large industrial customer), or storage (battery/pumped hydro).. Valid values are `generation|load|storage`',
    `queue_position` STRING COMMENT 'Numeric position of this request in the interconnection queue, determining study and construction priority. Lower numbers indicate earlier queue entry.',
    `request_number` STRING COMMENT 'Externally-known business identifier for the interconnection request, typically assigned by the transmission provider or RTO/ISO. Used in regulatory filings and customer communications.. Valid values are `^[A-Z0-9]{6,20}$`',
    `request_status` STRING COMMENT 'Current lifecycle status of the interconnection request in the queue management process. Tracks progression through FERC-mandated study phases. [ENUM-REF-CANDIDATE: submitted|under_review|feasibility_study|system_impact_study|facilities_study|approved|withdrawn|suspended|rejected|completed — 10 candidates stripped; promote to reference product]',
    `requested_capacity_mw` DECIMAL(18,2) COMMENT 'Total generating or load capacity in megawatts (MW) requested for interconnection. Determines study scope and network upgrade requirements.',
    `requires_nerc_registration` BOOLEAN COMMENT 'Boolean flag indicating whether the project will require NERC registration as a Generator Owner (GO) or Generator Operator (GOP) based on capacity and voltage thresholds.',
    `study_phase` STRING COMMENT 'Current phase of the FERC-mandated interconnection study process. Progresses from feasibility study through system impact study to facilities study.. Valid values are `pre_application|feasibility|system_impact|facilities|completed`',
    `submission_date` DATE COMMENT 'Date when the interconnection request was formally submitted to the transmission provider or RTO/ISO. Establishes queue position priority.',
    `system_impact_study_completion_date` DATE COMMENT 'Date when the system impact study was completed and results delivered to the applicant.',
    `system_impact_study_start_date` DATE COMMENT 'Date when the system impact study phase commenced. System impact study analyzes detailed grid impacts and required network upgrades.',
    `target_cod` DATE COMMENT 'Applicants proposed date for the project to achieve commercial operation and begin delivering energy or capacity to the grid. Critical for transmission planning and resource adequacy forecasting.',
    `technology_type` STRING COMMENT 'Primary technology or fuel type for the generation or storage project. Critical for renewable portfolio standard (RPS) tracking and integrated resource planning (IRP). [ENUM-REF-CANDIDATE: solar|wind|natural_gas|coal|nuclear|hydro|battery_storage|pumped_storage|biomass|geothermal|other — 11 candidates stripped; promote to reference product]',
    `transmission_owner_name` STRING COMMENT 'Legal name of the transmission owner responsible for the facilities at the point of interconnection. May differ from the RTO/ISO in organized markets.',
    `withdrawal_date` DATE COMMENT 'Date when the applicant formally withdrew the interconnection request from the queue. Populated only if request_status is withdrawn.',
    `withdrawal_reason` STRING COMMENT 'Business reason provided by the applicant for withdrawing the interconnection request (e.g., project financing failed, site permitting issues, cost prohibitive).',
    CONSTRAINT pk_interconnection_request PRIMARY KEY(`interconnection_request_id`)
) COMMENT 'Manages generator and large-load interconnection requests submitted under FERC Order 2003/2006 (LGIP/SGIP) processes. Captures request ID, applicant entity, project type (generation/load), technology type (thermal/wind/solar/storage), requested capacity (MW), proposed point of interconnection (POI), queue position, study phase (feasibility/system impact/facilities), estimated upgrade cost ($), commercial operation date (COD) target, and request status. SSOT for interconnection queue management. Source system: Transmission planning and interconnection management systems.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`congestion_event` (
    `congestion_event_id` BIGINT COMMENT 'Unique identifier for the transmission congestion event record. Primary key for the congestion event entity.',
    `constrained_element_id` BIGINT COMMENT 'Reference to the transmission asset (line, transformer, flowgate, or monitored element) that experienced the binding or near-binding constraint during this congestion event.',
    `pricing_node_id` BIGINT COMMENT 'Foreign key linking to market.pricing_node. Business justification: Congestion events occur at specific pricing nodes where transmission constraints bind. Real-time market operations, LMP decomposition reporting, and congestion revenue rights settlement all require li',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Chronic congestion triggers regulatory proceedings for transmission upgrade approval, cost allocation disputes, or market rule changes. Business process: RTO stakeholder processes, FERC complaints und',
    `flowgate_id` BIGINT COMMENT 'The unique identifier for the flowgate (a monitored transmission interface or corridor) associated with this congestion event. Used for inter-RTO coordination and Available Flowgate Capability (AFC) calculations.',
    `lmp_price_id` BIGINT COMMENT 'Reference to the associated LMP congestion component record that captures the pricing impact of this constraint at specific pricing nodes. Links congestion events to market pricing data.',
    `outage_id` BIGINT COMMENT 'Reference to the transmission outage record that caused or contributed to the congestion event. Null if the event was not outage-related.',
    `regulatory_deferral_id` BIGINT COMMENT 'Foreign key linking to finance.regulatory_deferral. Business justification: Congestion costs may be deferred as regulatory assets when authorized by PUC orders for future recovery. Link tracks deferred congestion cost balances, amortization schedules, and rate case recovery m',
    `rto_iso_id` BIGINT COMMENT 'FK to market.rto_iso',
    `bes_element_flag` BOOLEAN COMMENT 'Indicates whether the constrained element is classified as part of the Bulk Electric System (true) under NERC definitions, which determines applicability of NERC reliability standards and FERC jurisdiction.',
    `binding_constraint_flag` BOOLEAN COMMENT 'Indicates whether the constraint was fully binding (true) or near-binding/monitoring (false) during the event. Binding constraints directly impact dispatch and pricing.',
    `congestion_cost_usd` DECIMAL(18,2) COMMENT 'Total economic cost of the congestion event in US dollars, calculated as the product of shadow price, curtailed MW, and duration. Used for transmission upgrade economic justification and FTR/ARR hedging analysis.',
    `constraint_name` STRING COMMENT 'The RTO/ISO-assigned name or identifier for the binding constraint as reported in the market systems (e.g., constraint ID from day-ahead or real-time market).',
    `constraint_type` STRING COMMENT 'Classification of the physical or economic constraint that caused the congestion event: thermal (line/transformer loading limit), voltage (voltage stability limit), stability (transient or dynamic stability limit), contractual (OATT or tariff-based limit), or other.. Valid values are `thermal|voltage|stability|contractual|other`',
    `contingency_element_name` STRING COMMENT 'The name of the transmission element whose outage or failure would cause the monitored element to exceed its limit. Used for N-1 and N-2 contingency analysis and NERC TPL compliance.',
    `curtailed_mw` DECIMAL(18,2) COMMENT 'The amount of power flow in megawatts that was curtailed or limited due to the binding constraint. Represents the difference between desired and actual flow on the constrained element.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the congestion event in hours, calculated as the difference between event start and end timestamps. Used for congestion cost allocation and transmission planning analysis.',
    `element_rating_mw` DECIMAL(18,2) COMMENT 'The thermal, voltage, or stability rating of the constrained element in megawatts, representing the maximum allowable power flow under the applicable operating conditions (normal, emergency, or contingency).',
    `event_end_timestamp` TIMESTAMP COMMENT 'The date and time when the transmission constraint was relieved and the congestion event concluded. Null if the event is still active. Recorded in ISO 8601 format with timezone.',
    `event_start_timestamp` TIMESTAMP COMMENT 'The date and time when the transmission constraint became binding or near-binding, marking the beginning of the congestion event. Recorded in ISO 8601 format with timezone.',
    `event_status` STRING COMMENT 'Current lifecycle status of the congestion event: active (constraint is currently binding), resolved (constraint has been relieved), monitoring (near-binding, under observation), or escalated (requires TLR or emergency action).. Valid values are `active|resolved|monitoring|escalated`',
    `generation_redispatch_mw` DECIMAL(18,2) COMMENT 'The total amount of generation redispatch in megawatts that was required to relieve the congestion event. Represents the change in generation output across multiple units to reduce constraint loading.',
    `interconnection_name` STRING COMMENT 'The North American electric interconnection in which the congestion event occurred: Eastern, Western, ERCOT (Texas), or Quebec. Interconnections operate as synchronous grids with limited DC ties between them.. Valid values are `Eastern|Western|ERCOT|Quebec`',
    `load_shed_mw` DECIMAL(18,2) COMMENT 'The amount of customer load in megawatts that was curtailed or shed as a last-resort action to relieve the congestion event. Non-zero values indicate emergency operating conditions.',
    `market_interval_type` STRING COMMENT 'The market timeframe in which the congestion event occurred: day_ahead (DAM), real_time (RTM), or intra_day (intermediate market run). Used for market settlement and congestion revenue rights allocation.. Valid values are `day_ahead|real_time|intra_day`',
    `monitored_element_name` STRING COMMENT 'The name or designation of the specific transmission element (line, transformer, or interface) that was monitored and experienced the constraint. May differ from the constrained element if the constraint is a proxy or aggregate.',
    `nerc_region` STRING COMMENT 'The NERC regional entity jurisdiction in which the congestion event occurred: WECC (Western), ERCOT (Texas), MRO (Midwest), NPCC (Northeast), RF (ReliabilityFirst), SERC (Southeast), SPP (Southwest), or TRE (Texas RE). [ENUM-REF-CANDIDATE: WECC|ERCOT|MRO|NPCC|RF|SERC|SPP|TRE — 8 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for operational notes, comments, or additional context about the congestion event, resolution actions, or lessons learned. Used for post-event analysis and knowledge management.',
    `outage_related_flag` BOOLEAN COMMENT 'Indicates whether the congestion event was caused by or related to a planned or forced outage of a transmission element (true) or occurred under normal system topology (false).',
    `post_contingency_flow_mw` DECIMAL(18,2) COMMENT 'The projected or actual power flow in megawatts on the monitored element following the contingency event. Used to determine constraint severity and required relief actions.',
    `pre_contingency_flow_mw` DECIMAL(18,2) COMMENT 'The power flow in megawatts on the monitored element under normal (pre-contingency) operating conditions, before the contingency event that triggered the constraint.',
    `rating_type` STRING COMMENT 'The type of facility rating that was exceeded or approached during the congestion event: normal (continuous rating), emergency (short-term rating for system disturbances), or contingency (post-contingency rating for N-1 or N-2 analysis).. Valid values are `normal|emergency|contingency`',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this congestion event record was first created in the source system. Used for data lineage and audit trail purposes.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this congestion event record was last modified in the source system. Used for change tracking and incremental data processing.',
    `resolution_action` STRING COMMENT 'The operational action taken to resolve or mitigate the congestion event: redispatch (generation re-optimization), tlr (Transmission Loading Relief procedure), switching (network reconfiguration), load_shed (demand curtailment), topology_change (line/transformer switching), or none (constraint self-resolved).. Valid values are `redispatch|tlr|switching|load_shed|topology_change|none`',
    `shadow_price_per_mwh` DECIMAL(18,2) COMMENT 'The marginal cost of the transmission constraint in dollars per MWh, representing the economic value of relieving the constraint by one additional MWh. Also known as the congestion component of LMP.',
    `source_system` STRING COMMENT 'The operational system that recorded or reported the congestion event data (e.g., ABB EMS, GE EMS, RTO market system, SCADA historian). Used for data lineage and reconciliation.',
    `tlr_level` STRING COMMENT 'The NERC Transmission Loading Relief procedure level invoked to manage the congestion event, ranging from TLR0 (monitoring) to TLR6 (emergency curtailment of firm transactions). Null if no TLR was required. [ENUM-REF-CANDIDATE: TLR0|TLR1|TLR2|TLR3|TLR4|TLR5|TLR6 — 7 candidates stripped; promote to reference product]',
    `voltage_level_kv` STRING COMMENT 'The nominal voltage level in kilovolts of the constrained transmission element (e.g., 69, 115, 138, 230, 345, 500, 765). Used for BES classification and NERC CIP applicability determination.',
    `weather_condition` STRING COMMENT 'Description of the weather conditions at the time of the congestion event (e.g., high temperature, storm, wind, ice). Weather is a common driver of transmission congestion due to increased load or reduced line ratings.',
    CONSTRAINT pk_congestion_event PRIMARY KEY(`congestion_event_id`)
) COMMENT 'Records transmission congestion events on the BES — instances where physical or economic constraints limit power flow on a transmission path, flowgate, or monitored element. Each record represents a single binding or near-binding constraint event. Captures event ID, constrained element reference (line/transformer/flowgate), constraint type (thermal/voltage/stability/contractual), start/end datetime, duration (hours), binding constraint flag, shadow price ($/MWh), congestion cost ($), curtailed MW, TLR level (if applicable), RTO/ISO constraint name, associated LMP congestion component reference, and resolution action taken (redispatch/TLR/switching/load shed). Used for congestion cost tracking, FTR/ARR hedging analysis, transmission upgrade economic justification, and NERC TPL compliance. Source system: ABB/GE EMS, RTO/ISO constraint and LMP data feeds.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`outage` (
    `outage_id` BIGINT COMMENT 'Primary key for outage',
    `crew_id` BIGINT COMMENT 'Foreign key linking to transmission.crew. Business justification: Outages are resolved by crews. The outage table has crew_assignment STRING. Normalizing to FK to crew. Removes crew_assignment string.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to billing.rate_schedule. Business justification: Transmission outages triggering customer credits require rate schedule context for regulatory compliance—credit calculations vary by customer class (residential/commercial) and rate structure. Utility',
    `distribution_outage_event_id` BIGINT COMMENT 'Foreign key linking to distribution.outage_event. Business justification: Transmission outages frequently cause downstream distribution outages. Critical for root cause analysis, customer impact assessment, SAIDI/SAIFI attribution, restoration coordination, and regulatory r',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_event. Business justification: Transmission outages violating NERC reliability standards (TOP, IRO) or causing significant customer impact trigger regulatory compliance events and potential violations. Business process: NERC TADS r',
    `bus_id` BIGINT COMMENT 'Identifier of the originating bus or electrical node for transmission line outages. Defines the starting point of the affected line segment.',
    `opex_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.opex_transaction. Business justification: Unplanned outages generate O&M expenses for crew labor, materials, and contractor costs. Link enables outage cost tracking, budget variance analysis, storm cost deferral accounting, and regulatory rep',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Outages affect specific transmission elements. The current schema uses polymorphic pattern (element_reference STRING + element_name STRING + element_type STRING). Normalizing to explicit FKs for lines',
    `transformer_id` BIGINT COMMENT 'Foreign key linking to transmission.transformer. Business justification: Outages also affect transformers. This FK links outages to transformers. Together with outaged_line_id, replaces the polymorphic element_reference pattern with explicit typed FKs.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Planned transmission outages often require procurement of contractor services, replacement equipment, or specialized materials. PO tracks the procurement supporting outage execution. Real business pro',
    `transmission_substation_id` BIGINT COMMENT 'Identifier of the substation associated with the outage, if applicable. Links to the substation master data in the asset management or GIS system.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when the transmission element was restored to service and returned to normal operation.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when the transmission element was taken out of service. This is the authoritative timestamp for outage duration calculations and SAIDI/SAIFI metrics.',
    `approval_status` STRING COMMENT 'Approval status of the planned outage request. Pending indicates awaiting review. Approved indicates authorization granted. Rejected indicates request denied. Conditional indicates approval with specific constraints or requirements.. Valid values are `pending|approved|rejected|conditional`',
    `cause_code` STRING COMMENT 'Standardized NERC cause code classifying the root cause of the outage. Used for NERC TADS reporting and reliability analysis.',
    `cause_description` STRING COMMENT 'High-level categorization of the outage cause. Weather includes storms, lightning, ice, wind. Equipment failure covers mechanical or electrical component breakdown. Human error includes operational mistakes. Vegetation refers to tree contact. Third party includes vehicle accidents or construction damage. [ENUM-REF-CANDIDATE: weather|equipment_failure|human_error|vegetation|animal|third_party|scheduled_maintenance|other — 8 candidates stripped; promote to reference product]',
    `contingency_analysis_performed_flag` BOOLEAN COMMENT 'Indicates whether a contingency analysis was performed to assess the impact of the outage on system reliability and identify potential N-1 or N-2 violations. Required for planned outages of critical BES elements.',
    `coordinator` STRING COMMENT 'Name or identifier of the transmission operations staff member responsible for coordinating the outage with the RTO/ISO, adjacent utilities, and internal stakeholders.',
    `customers_affected_count` STRING COMMENT 'Number of end-use customers who experienced service interruption as a result of the transmission outage. Used for SAIFI calculation and customer impact assessment.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the outage in hours, calculated as the difference between actual end and actual start timestamps. Used for reliability metrics and performance analysis.',
    `load_impact_mw` DECIMAL(18,2) COMMENT 'Estimated or actual megawatt load impact of the outage on the transmission system. Represents the amount of power flow interrupted or curtailed due to the outage.',
    `nerc_region` STRING COMMENT 'NERC regional entity jurisdiction where the outage occurred. WECC (Western Electricity Coordinating Council), ERCOT (Electric Reliability Council of Texas), MRO (Midwest Reliability Organization), NPCC (Northeast Power Coordinating Council), RF (ReliabilityFirst), SERC (SERC Reliability Corporation), TRE (Texas Reliability Entity), SPP (Southwest Power Pool). [ENUM-REF-CANDIDATE: WECC|ERCOT|MRO|NPCC|RF|SERC|TRE|SPP — 8 candidates stripped; promote to reference product]',
    `nerc_tads_reporting_flag` BOOLEAN COMMENT 'Indicates whether this outage must be reported to NERC TADS. True for outages of BES elements that meet NERC reporting thresholds. False for minor outages below reporting thresholds.',
    `notes` STRING COMMENT 'Free-text field for additional comments, observations, or special instructions related to the outage. May include details about restoration challenges, lessons learned, or coordination issues.',
    `outage_number` STRING COMMENT 'Business identifier for the outage event, typically assigned by the Outage Management System (OMS) or Energy Management System (EMS). Used for external communication with RTO/ISO and internal tracking.',
    `outage_status` STRING COMMENT 'Current lifecycle state of the outage. Scheduled indicates future planned work. Active indicates the element is currently out of service. Restored indicates the element has been returned to service. Cancelled indicates the outage was not executed. Deferred indicates postponement to a future date.. Valid values are `scheduled|active|restored|cancelled|deferred`',
    `outage_type` STRING COMMENT 'Classification of the outage event. Planned outages are scheduled in advance for maintenance or construction. Forced outages are unplanned events due to equipment failure or external factors. Maintenance outages are routine preventive work. Emergency outages are immediate responses to critical conditions.. Valid values are `planned|forced|maintenance|emergency`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this outage record was first created in the system. Used for audit trail and data lineage tracking.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this outage record was last modified. Tracks the most recent update to any field in the record.',
    `restoration_priority` STRING COMMENT 'Priority level assigned for restoration activities. Critical priority for outages affecting critical infrastructure or large customer populations. High priority for significant system impacts. Medium and low for routine maintenance outages.. Valid values are `critical|high|medium|low`',
    `rto_iso_notification_reference` STRING COMMENT 'Reference number or identifier for the outage notification submitted to the RTO or ISO. Required for coordination of transmission outages that affect the bulk electric system.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned date and time when the outage is scheduled to end and the element is expected to be restored to service.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when the outage is scheduled to begin. For forced outages, this may be null or equal to actual start time.',
    `switching_order_reference` STRING COMMENT 'Reference to the associated switching order or operating order that authorizes the isolation and de-energization of the transmission element. Links to the switching procedure documentation.',
    `to_bus_code` STRING COMMENT 'Identifier of the terminating bus or electrical node for transmission line outages. Defines the ending point of the affected line segment.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Operating voltage level of the affected transmission element in kilovolts. Typical BES voltage levels are 69 kV, 115 kV, 138 kV, 230 kV, 345 kV, 500 kV, and 765 kV.',
    `weather_condition` STRING COMMENT 'Description of weather conditions at the time of the outage, if weather was a contributing factor. Includes storm type, wind speed, temperature, precipitation, or other relevant meteorological data.',
    `work_order_reference` STRING COMMENT 'Reference to the associated work order in the Enterprise Asset Management (EAM) system that documents the maintenance or construction activities performed during the outage.',
    CONSTRAINT pk_outage PRIMARY KEY(`outage_id`)
) COMMENT 'Records planned, forced, and maintenance outages of BES transmission elements (lines, transformers, substations, buses, switching equipment) for maintenance, construction, emergency restoration, or third-party accommodation. Captures outage ID, element type and ID, outage type (planned/forced/maintenance), outage cause (weather/equipment failure/human error/vegetation), start/end datetime, outage duration (hours), MW load impact, affected customers count, NERC outage cause code, RTO/ISO notification reference, NERC TADS reporting flag, associated switching order reference, crew assignment, and restoration status. Feeds NERC TADS (Transmission Availability Data System) reporting, SAIDI/SAIFI reliability metrics, and RTO/ISO outage coordination. Source system: Schneider/GE OMS, Oracle WAM/IBM Maximo, ABB/GE EMS.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` (
    `nerc_cip_asset_id` BIGINT COMMENT 'Unique identifier for the NERC CIP regulated BES cyber system asset record.',
    `capex_expenditure_id` BIGINT COMMENT 'Foreign key linking to finance.capex_expenditure. Business justification: NERC CIP compliance investments in cyber security infrastructure and physical security enhancements are capitalized expenditures. Link supports CIP cost recovery in rate cases and proper capital vs. e',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_event. Business justification: CIP assets are the subject of compliance violations, self-reports, and audit findings requiring event tracking. Business process: violation investigation, penalty assessment, corrective action plan im',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: CIP assets must comply with specific NERC CIP standards (CIP-002 through CIP-014) tracked as compliance obligations. Business process: CIP compliance program management, audit preparation, evidence ar',
    `control_center_id` BIGINT COMMENT 'Foreign key reference to the control center facility where this BES cyber system asset is located, if applicable.',
    `master_id` BIGINT COMMENT 'Foreign key linking to asset.asset_master. Business justification: NERC CIP cyber assets ARE physical transmission assets requiring full EAM lifecycle tracking (maintenance, financials, depreciation, warranty, condition assessments). Currently missing FK creates data',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key reference to the transmission substation where this BES cyber system asset is located.',
    `applicable_cip_standards` STRING COMMENT 'Comma-separated list of applicable NERC CIP standard requirements for this asset (e.g., CIP-002, CIP-003, CIP-004, CIP-005, CIP-006, CIP-007, CIP-008, CIP-009, CIP-010, CIP-011, CIP-014).',
    `asset_owner` STRING COMMENT 'The organizational unit or department that owns and maintains this BES cyber system asset.',
    `bes_cyber_system_identifier` STRING COMMENT 'The unique identifier assigned to the BES cyber system (e.g., EMS, SCADA RTU, relay communication processor) within the transmission facility.',
    `cip_version` STRING COMMENT 'The version of the NERC CIP standards applicable to this asset (e.g., CIP Version 5, CIP Version 6).',
    `compliance_status` STRING COMMENT 'The current NERC CIP compliance status of the BES cyber system asset.. Valid values are `compliant|non_compliant|remediation_in_progress|pending_review`',
    `configuration_baseline_reference` STRING COMMENT 'Reference identifier to the configuration baseline documentation for this BES cyber system asset per NERC CIP-010 configuration management requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this NERC CIP asset record was first created in the system.',
    `criticality_score` DECIMAL(18,2) COMMENT 'A numerical score representing the criticality of this BES cyber system asset to grid reliability and operations, used for prioritization of security controls and assessments.',
    `cyber_security_incident_count` STRING COMMENT 'The total number of reportable cyber security incidents associated with this BES cyber system asset.',
    `esp_identifier` STRING COMMENT 'The unique identifier of the Electronic Security Perimeter to which this asset belongs, if applicable.',
    `esp_membership` BOOLEAN COMMENT 'Indicates whether the asset is a member of an Electronic Security Perimeter as defined in NERC CIP-005.',
    `evidence_artifact_reference` STRING COMMENT 'Reference identifier or URI to the compliance evidence artifacts (documentation, logs, reports) associated with this BES cyber system asset.',
    `firmware_version` STRING COMMENT 'The current firmware or software version installed on the BES cyber system asset.',
    `impact_rating` STRING COMMENT 'The CIP impact rating assigned to the BES cyber system per NERC CIP-002-5.1a categorization (high, medium, or low impact).. Valid values are `high|medium|low`',
    `ip_address` STRING COMMENT 'The primary IP address assigned to this BES cyber system asset within the network infrastructure.',
    `last_cip_audit_date` DATE COMMENT 'The date of the most recent NERC CIP compliance audit that included this BES cyber system asset.',
    `last_incident_date` DATE COMMENT 'The date of the most recent cyber security incident involving this BES cyber system asset.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this NERC CIP asset record was most recently updated or modified.',
    `last_vulnerability_assessment_date` DATE COMMENT 'The date of the most recent vulnerability assessment performed on this BES cyber system asset per NERC CIP-010 requirements.',
    `network_zone` STRING COMMENT 'The network security zone or segment where this BES cyber system asset resides (e.g., control network, corporate network, DMZ).',
    `next_cip_audit_due_date` DATE COMMENT 'The date by which the next NERC CIP compliance audit is scheduled or due for this asset.',
    `next_vulnerability_assessment_due_date` DATE COMMENT 'The date by which the next vulnerability assessment must be completed for this BES cyber system asset.',
    `notes` STRING COMMENT 'Additional notes, comments, or contextual information about this BES cyber system asset and its CIP compliance status.',
    `physical_security_assessment_date` DATE COMMENT 'The date of the most recent physical security assessment performed for this asset per NERC CIP-014 requirements.',
    `psp_identifier` STRING COMMENT 'The unique identifier of the Physical Security Perimeter where this asset is located, if applicable.',
    `psp_membership` BOOLEAN COMMENT 'Indicates whether the asset is located within a Physical Security Perimeter as defined in NERC CIP-006.',
    `remediation_plan_reference` STRING COMMENT 'Reference identifier to the remediation or mitigation plan for any identified non-compliance or vulnerabilities associated with this asset.',
    `responsible_entity` STRING COMMENT 'The name of the registered entity responsible for the compliance of this BES cyber system asset under NERC CIP standards.',
    `retirement_reason` STRING COMMENT 'The reason or justification for retiring or decommissioning this BES cyber system asset.',
    CONSTRAINT pk_nerc_cip_asset PRIMARY KEY(`nerc_cip_asset_id`)
) COMMENT 'Master record for NERC CIP (Critical Infrastructure Protection) regulated BES cyber systems and associated cyber assets at transmission facilities. Each record represents a distinct BES cyber system (e.g., EMS, SCADA RTU, relay communication processor) within a CIP-regulated substation or control center. Captures asset ID, associated substation or control center, BES cyber system identifier, impact rating (high/medium/low per CIP-002-5.1a), applicable CIP standard requirements (CIP-002 through CIP-014), electronic security perimeter (ESP) membership, physical security perimeter (PSP) membership, responsible entity, last vulnerability assessment date, last CIP audit date, evidence artifact reference, compliance status, remediation plan reference, and next assessment due date. SSOT for NERC CIP asset inventory within the transmission domain — critical for CIP-002 categorization, CIP-005 ESP management, CIP-010 configuration management, and CIP-014 physical security assessments. Source system: NERC CIP compliance management systems (e.g., RSA Archer, ServiceNow GRC).';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`tariff_rate` (
    `tariff_rate_id` BIGINT COMMENT 'Primary key for tariff_rate',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tariff rates are developed using cost center data for functionalization and classification in cost-of-service rate cases. Link supports revenue requirement allocation, rate design, and FERC tariff fil',
    `rate_schedule_id` BIGINT COMMENT 'Externally-known identifier for the FERC-approved transmission rate schedule under the Open Access Transmission Tariff (OATT). Examples include network integration transmission service, point-to-point firm, point-to-point non-firm, and ancillary service schedules.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Tariff rates are defined for specific transmission paths (point of receipt to point of delivery). Normalizing point_of_receipt STRING to FK to transmission_substation.',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Transmission tariff rates implement commission-approved tariff schedules (OATT rates). Business process: rate reconciliation between billing system and regulatory approval, tariff sheet cross-referenc',
    `allowed_roe_percent` DECIMAL(18,2) COMMENT 'FERC-approved return on equity percentage used in the cost-of-service calculation for this transmission rate. Represents the allowed profit margin on transmission investment. Typically ranges from 9% to 12% for transmission utilities.',
    `ancillary_service_rate` DECIMAL(18,2) COMMENT 'Rate component for ancillary services required to support transmission service, including scheduling, system control, reactive supply, voltage support, regulation, frequency response, operating reserves, and energy imbalance. Expressed in dollars per unit (kW or MWh depending on service type).',
    `approval_date` DATE COMMENT 'Date on which FERC or the applicable Public Utility Commission (PUC) approved this transmission rate for use. Null for rates that are still pending approval or were rejected.',
    `approval_status` STRING COMMENT 'Current regulatory approval status of the transmission rate. Draft rates are under internal development; filed rates have been submitted to FERC; pending rates are under FERC review; approved rates are effective; rejected rates were not accepted; suspended rates are under investigation; superseded rates have been replaced by newer filings. [ENUM-REF-CANDIDATE: draft|filed|pending_ferc_review|approved|rejected|suspended|superseded — 7 candidates stripped; promote to reference product]',
    `approving_authority` STRING COMMENT 'Regulatory body or authority that approved this transmission rate. FERC has jurisdiction over interstate transmission rates under the Federal Power Act; state PUCs may have jurisdiction over intrastate rates; RTO/ISO may approve rates under delegated authority; internal indicates rates set under formula rate mechanisms.. Valid values are `FERC|state_puc|rto_iso|internal`',
    `congestion_charge_applicable_flag` BOOLEAN COMMENT 'Indicates whether transmission congestion charges (based on Locational Marginal Price differences) apply in addition to the stated transmission rate. Typically true in RTO/ISO markets with nodal pricing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission rate record was first created in the system. Used for audit trail and data lineage tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this rate record. Power and Utilities operates exclusively in United States dollars (USD).. Valid values are `USD`',
    `demand_charge_per_kw_month` DECIMAL(18,2) COMMENT 'Monthly demand charge component of the transmission rate, expressed in dollars per kilowatt (kW) of reserved transmission capacity per month. This is the primary cost driver for firm transmission service.',
    `discount_policy_flag` BOOLEAN COMMENT 'Indicates whether this rate schedule permits discounting below the stated maximum rate. FERC allows transmission providers to offer discounted rates for competitive reasons, subject to non-discrimination requirements.',
    `effective_date` DATE COMMENT 'Date on which this transmission rate becomes effective and applicable to transmission service agreements. Rates cannot be applied retroactively prior to FERC approval and the effective date specified in the tariff filing.',
    `energy_charge_per_mwh` DECIMAL(18,2) COMMENT 'Energy-based charge component of the transmission rate, expressed in dollars per megawatt-hour (MWh) of energy transmitted. Typically applies to non-firm or short-term point-to-point service.',
    `expiration_date` DATE COMMENT 'Date on which this transmission rate expires and is superseded by a new rate schedule. Nullable for rates that remain in effect until explicitly superseded by a subsequent FERC-approved filing.',
    `ferc_docket_number` STRING COMMENT 'FERC docket number under which this transmission rate was filed, reviewed, and approved. Format follows FERC convention: ER (Electric Rate), EL (Electric Litigation), or RM (Rulemaking) followed by year and sequential number.. Valid values are `^(ER|EL|RM)[0-9]{2}-[0-9]{3,5}(-[0-9]{3})?$`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this transmission rate record was last updated. Used for audit trail and change tracking.',
    `last_rate_case_date` DATE COMMENT 'Date of the most recent general transmission rate case filing that established or modified this rate. Rate cases are comprehensive regulatory proceedings to review and approve transmission revenue requirements and rate design.',
    `loss_compensation_percent` DECIMAL(18,2) COMMENT 'Percentage of transmitted energy that must be provided by the transmission customer to compensate for electrical losses on the transmission system. Typically ranges from 1% to 5% depending on distance and voltage class.',
    `maximum_reservation_kw` STRING COMMENT 'Maximum transmission capacity reservation allowed under this rate schedule, expressed in kilowatts (kW). Null if no maximum applies.',
    `minimum_reservation_kw` STRING COMMENT 'Minimum transmission capacity reservation required to qualify for this rate, expressed in kilowatts (kW). Some rate schedules have minimum thresholds below which different rates or service terms apply.',
    `nerc_region_code` STRING COMMENT 'NERC regional reliability entity code indicating the geographic reliability region in which this transmission rate applies. Used for compliance reporting and reliability coordination. [ENUM-REF-CANDIDATE: WECC|ERCOT|MRO|NPCC|RF|SERC|TRE|SPP — 8 candidates stripped; promote to reference product]',
    `next_rate_case_scheduled_date` DATE COMMENT 'Scheduled date for the next general transmission rate case filing, if known. Null if no rate case is currently scheduled. Some formula rates update annually without full rate case proceedings.',
    `point_of_delivery` STRING COMMENT 'Transmission system location or pricing node where power is withdrawn from the transmission system under a point-to-point transmission service agreement. Null for network integration transmission service.',
    `rate_basis` STRING COMMENT 'Methodology used to determine the transmission rate. Cost-of-service rates are based on embedded transmission system costs and allowed return on equity (ROE); market-based rates reflect competitive market conditions; formula rates adjust automatically based on actual costs; negotiated rates are bilaterally agreed; stated rates are fixed tariff rates.. Valid values are `cost_of_service|market_based|formula_rate|negotiated|stated_rate`',
    `rate_pancaking_flag` BOOLEAN COMMENT 'Indicates whether this rate is subject to pancaking (multiple transmission rate charges applied sequentially as power crosses multiple transmission owner service territories). FERC has worked to eliminate pancaking through RTO/ISO formation.',
    `rate_type` STRING COMMENT 'Classification of the transmission rate based on the type of service provided. Network rates apply to bundled transmission service; point-to-point rates apply to firm or non-firm transmission reservations; ancillary service rates cover scheduling, voltage support, and operating reserves.. Valid values are `network|point_to_point|ancillary_service|generator_interconnection|reactive_supply|black_start`',
    `rate_zone_code` STRING COMMENT 'Geographic or operational zone identifier to which this transmission rate applies. Rate zones segment the transmission system for cost allocation and pricing purposes, often aligned with load-serving areas or transmission owner territories.. Valid values are `^[A-Z0-9_]{2,10}$`',
    `reactive_supply_charge` DECIMAL(18,2) COMMENT 'Charge for reactive power supply and voltage control service necessary to maintain transmission system voltage within acceptable limits. Typically expressed in dollars per kilovar (kVAR) or as a percentage of demand charge.',
    `rollover_rights_flag` BOOLEAN COMMENT 'Indicates whether customers holding long-term firm point-to-point transmission service under this rate have rollover rights to renew their service at contract expiration, subject to system capability.',
    `rto_iso_code` STRING COMMENT 'Identifier for the RTO or ISO that administers this transmission rate, if applicable. Non-RTO indicates the transmission provider operates outside of an organized wholesale market. [ENUM-REF-CANDIDATE: CAISO|ERCOT|ISO_NE|MISO|NYISO|PJM|SPP|non_rto — 8 candidates stripped; promote to reference product]',
    `scheduling_coordination_charge` DECIMAL(18,2) COMMENT 'Charge for scheduling, system control, and dispatch services provided by the transmission provider to coordinate the movement of power across the transmission system.',
    `service_class` STRING COMMENT 'Indicates whether the transmission service is firm (guaranteed delivery with curtailment only under emergency conditions), non-firm (interruptible), or conditional firm (firm subject to specific conditions).. Valid values are `firm|non_firm|conditional_firm`',
    `source_system` STRING COMMENT 'Operational system of record from which this transmission rate data originated. Rates may be sourced from the Customer Information System (SAP IS-U or Oracle CC&B), directly from FERC eTariff filings, or entered manually by regulatory affairs staff.. Valid values are `SAP_IS_U|Oracle_CCB|FERC_eTariff|Manual_Entry`',
    `tariff_version` STRING COMMENT 'Version number of the OATT tariff document in which this rate is published. Follows semantic versioning convention to track tariff amendments and supersessions.. Valid values are `^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$`',
    `transmission_owner_code` STRING COMMENT 'Identifier for the transmission owner or transmission provider to whom this rate applies. In multi-owner transmission systems, different owners may have different rate schedules within the same OATT.. Valid values are `^[A-Z0-9]{2,10}$`',
    `voltage_class_kv` STRING COMMENT 'Nominal voltage class of the transmission facilities to which this rate applies, expressed in kilovolts (kV). Common transmission voltage classes include 69 kV, 115 kV, 138 kV, 230 kV, 345 kV, 500 kV, and 765 kV. Higher voltage classes typically have different rate structures due to differences in cost and capacity.',
    CONSTRAINT pk_tariff_rate PRIMARY KEY(`tariff_rate_id`)
) COMMENT 'Reference master for FERC-approved transmission tariff rates and rate schedules applicable under the OATT. Captures rate schedule ID, rate type (network/point-to-point/ancillary service), service class (firm/non-firm), rate zone, demand charge ($/kW-month), energy charge ($/MWh), ancillary service component rates, FERC docket reference, effective date, expiration date, and PUC/FERC approval status. Used for transmission service billing and OATT compliance. Source system: SAP IS-U/Oracle CC&B, FERC eTariff.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`switching_order` (
    `switching_order_id` BIGINT COMMENT 'Unique identifier for the switching order. Primary key for the switching order record.',
    `operator_id` BIGINT COMMENT 'Identifier of the transmission system operator or supervisor who approved and authorized the switching order for execution. Required for compliance with switching authority protocols.',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_event. Business justification: Switching errors or unauthorized operations result in NERC TOP/IRO standard violations requiring compliance event tracking. Business process: self-reporting of switching violations, operations audit t',
    `crew_id` BIGINT COMMENT 'Identifier of the field crew assigned to physically execute the switching operations. Links to workforce management system for crew scheduling and dispatch.',
    `opex_transaction_id` BIGINT COMMENT 'Foreign key linking to finance.opex_transaction. Business justification: Switching operations incur labor and operational costs recorded in O&M expense accounts. Required for functional cost allocation to transmission operations, maintenance expense tracking, and FERC func',
    `outage_id` BIGINT COMMENT 'Identifier of the associated transmission outage record that this switching order supports. Links to the broader outage management workflow and NERC Transmission Availability Data System (TADS) reporting.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Switching orders operate on specific transmission elements. The current schema uses polymorphic pattern (transmission_element_reference BIGINT + transmission_element_name STRING + transmission_element',
    `transformer_id` BIGINT COMMENT 'Foreign key linking to transmission.transformer. Business justification: Switching orders also operate on transformers. This FK links switching orders to transformers being switched. Together with switched_line_id, replaces the polymorphic transmission_element_reference pa',
    `transmission_substation_id` BIGINT COMMENT 'Identifier of the transmission substation where the switching operation will be performed. Links to transmission substation master data.',
    `superseded_switching_order_id` BIGINT COMMENT 'Self-referencing FK on switching_order (superseded_switching_order_id)',
    `actual_end_datetime` TIMESTAMP COMMENT 'Actual date and time when the switching operation was completed. Enables calculation of actual duration and comparison against planned schedule for operational efficiency metrics.',
    `actual_start_datetime` TIMESTAMP COMMENT 'Actual date and time when the switching operation execution began. Used for performance tracking, variance analysis, and regulatory reporting of switching activities.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the switching order was formally approved by the authorizing operator. Marks the transition from draft to approved status and authorization for execution.',
    `authorizing_operator_name` STRING COMMENT 'Full name of the transmission system operator or supervisor who approved and authorized the switching order for execution.',
    `bes_element_flag` BOOLEAN COMMENT 'Indicates whether the transmission element being switched is classified as part of the Bulk Electric System under NERC definitions. BES elements require additional coordination and reporting.',
    `cancellation_reason` STRING COMMENT 'Explanation of why the switching order was cancelled. Common reasons include weather conditions, equipment unavailability, system conditions, or work completion by alternative means.',
    `cancellation_timestamp` TIMESTAMP COMMENT 'Date and time when the switching order was cancelled. Populated only for orders that were cancelled before completion.',
    `clearance_tag_reference` STRING COMMENT 'Reference number or identifier of the physical clearance tag(s) or tagout permit(s) associated with this switching order. Used for lockout/tagout compliance and worker safety protection.',
    `contingency_analysis_performed_flag` BOOLEAN COMMENT 'Indicates whether a contingency analysis was performed to assess system reliability impacts of the switching operation. Required for planned outages affecting BES elements.',
    `control_area` STRING COMMENT 'Balancing Authority control area where the switching operation occurs. Used for coordination of generation and load balancing during switching activities.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this switching order record was first created in the system. Used for audit trail and operational analytics.',
    `ems_reference` STRING COMMENT 'Reference identifier from the Energy Management System (ABB or GE EMS) where this switching order was created or synchronized. Enables bidirectional integration between EMS and switching order management.',
    `executing_crew_name` STRING COMMENT 'Name or designation of the field crew assigned to physically execute the switching operations.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this switching order record was most recently modified. Tracks the latest change to any field in the record for change management and audit purposes.',
    `load_impact_mw` DECIMAL(18,2) COMMENT 'Estimated or actual load in megawatts that will be interrupted or affected by this switching operation. Used for customer impact assessment and restoration priority planning.',
    `nerc_cip_applicable_flag` BOOLEAN COMMENT 'Indicates whether this switching order involves Critical Infrastructure Protection (CIP) assets requiring cyber security and physical security controls under NERC CIP standards.',
    `nerc_iro_compliance_flag` BOOLEAN COMMENT 'Indicates whether this switching order requires coordination with the Reliability Coordinator under NERC Interchange and Reliability Operations (IRO) standards. True for switching operations affecting Bulk Electric System (BES) reliability.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special instructions, coordination requirements, or lessons learned. Used by operators and field crews for information not captured in structured fields.',
    `oms_reference` STRING COMMENT 'Reference identifier from the Outage Management System (Schneider Electric AMS or GE PowerOn) where this switching order was created or synchronized. Links switching operations to outage restoration workflows.',
    `order_number` STRING COMMENT 'Human-readable business identifier for the switching order, typically assigned by the Energy Management System (EMS) or Outage Management System (OMS). Used by transmission dispatchers and field crews for operational reference.',
    `order_status` STRING COMMENT 'Current lifecycle status of the switching order. Tracks progression from draft through approval, execution, and completion or cancellation.. Valid values are `draft|approved|in_progress|completed|cancelled|suspended`',
    `order_type` STRING COMMENT 'Classification of the switching order based on operational purpose. Planned orders support scheduled maintenance or outages; emergency orders respond to unplanned events; restoration orders return equipment to service.. Valid values are `planned|emergency|maintenance|restoration|testing|commissioning`',
    `planned_end_datetime` TIMESTAMP COMMENT 'Scheduled date and time when the switching operation is planned to be completed and equipment returned to normal state. Critical for outage duration planning and customer impact assessment.',
    `planned_start_datetime` TIMESTAMP COMMENT 'Scheduled date and time when the switching operation is planned to begin. Used for coordination with field crews, outage scheduling, and system operator shift planning.',
    `priority` STRING COMMENT 'Operational priority level assigned to the switching order. Critical priority indicates immediate safety or reliability concerns requiring expedited execution.. Valid values are `critical|high|normal|low`',
    `requesting_operator_code` STRING COMMENT 'Identifier of the transmission system operator or dispatcher who initiated the switching order request. Used for accountability and audit trail purposes.',
    `requesting_operator_name` STRING COMMENT 'Full name of the transmission system operator or dispatcher who initiated the switching order request.',
    `rto_iso_notification_flag` BOOLEAN COMMENT 'Indicates whether this switching order requires notification to the Regional Transmission Organization (RTO) or Independent System Operator (ISO) due to potential impact on transmission capacity or market operations.',
    `rto_iso_region` STRING COMMENT 'Name or code of the Regional Transmission Organization or Independent System Operator region where this switching operation occurs. Examples include PJM, MISO, CAISO, SPP, ERCOT, NYISO, ISO-NE.',
    `safety_ground_placement` STRING COMMENT 'Description of safety ground locations and installation requirements for this switching order. Specifies where protective grounds must be installed to protect workers from induced voltage or backfeed.',
    `substation_name` STRING COMMENT 'Name of the transmission substation where the switching operation will be performed. Used for field crew dispatch and geographic coordination.',
    `switching_sequence_steps` STRING COMMENT 'Detailed step-by-step instructions for the switching operation sequence. Specifies the order of breaker and disconnect operations, verification steps, and safety checkpoints. May reference standard operating procedures.',
    `transfer_capability_impact_mw` DECIMAL(18,2) COMMENT 'Estimated reduction in Available Transfer Capability (ATC) in megawatts resulting from this switching operation. Critical for transmission service scheduling and market operations.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage class in kilovolts of the transmission element being switched. Critical for determining safety clearance distances and personal protective equipment requirements.',
    `work_order_reference` STRING COMMENT 'Reference number of the maintenance or construction work order that necessitates this switching operation. Links to Enterprise Asset Management (EAM) system for work coordination.',
    CONSTRAINT pk_switching_order PRIMARY KEY(`switching_order_id`)
) COMMENT 'Records switching orders (also called clearance orders or tagout orders) that authorize the opening/closing of breakers, disconnects, and switches on the BES to isolate or energize transmission elements. Captures order ID, requesting operator, authorizing operator, associated transmission element(s), switching sequence steps, clearance tag references, safety ground placement, planned start/end datetime, actual execution datetime, order status (draft/approved/in-progress/completed/cancelled), associated outage reference, and NERC IRO compliance flag. SSOT for all switching operations on the transmission system — the primary daily operational workflow for transmission dispatchers and field crews. Source system: ABB/GE EMS, Schneider/GE OMS.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`protection_system` (
    `protection_system_id` BIGINT COMMENT 'Unique identifier for the protective relay system or protection scheme. Primary key for the protection system entity. Serves as the authoritative reference for all protection equipment records across relay management systems, Enterprise Asset Management (EAM), and NERC Protection and Control (PRC) compliance tracking.',
    `backup_protection_system_id` BIGINT COMMENT 'Foreign key reference to the backup or redundant protection system that provides secondary protection for the same transmission element. Used for coordination studies and reliability analysis per NERC PRC-023 requirements.',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_event. Business justification: Protection system misoperations or testing failures generate NERC PRC-004 compliance events requiring investigation and reporting. Business process: misoperation analysis, violation self-reporting, co',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Protection systems must comply with NERC PRC standards (PRC-005 relay testing, PRC-004 misoperation reporting). Business process: relay testing program scheduling, compliance evidence collection, main',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Protection relays and systems are capitalized assets with book values and depreciation tracked in fixed_asset. Required for asset accounting, depreciation expense calculation, retirement accounting, a',
    `master_id` BIGINT COMMENT 'External reference to the protection system record in the Enterprise Asset Management system (Oracle WAM, IBM Maximo). Links protection data to work orders, maintenance history, spare parts inventory, and financial asset records.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Protection systems protect specific transmission elements. The current schema uses a polymorphic pattern (transmission_element_reference BIGINT + transmission_element_type STRING). Normalizing to expl',
    `transformer_id` BIGINT COMMENT 'Foreign key linking to transmission.transformer. Business justification: Protection systems also protect transformers. This FK links protection systems to the transformers they protect. Together with protected_line_id, this replaces the polymorphic transmission_element_ref',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Protection relays are procured equipment with manufacturer part numbers and specifications. Material master enables spare parts inventory management, standardization of relay types across substations,',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key reference to the transmission substation where this protection system is physically located. Links protection equipment to facility for maintenance dispatch, outage coordination, and physical security management.',
    `communication_protocol` STRING COMMENT 'Communication protocol used by the relay for SCADA integration, synchrophasor data exchange, or remote monitoring (e.g., DNP3, IEC 61850 GOOSE/MMS, Modbus, IEEE C37.118 for PMUs). Critical for cybersecurity assessments and NERC CIP compliance.. Valid values are `dnp3|iec_61850|modbus|c37_118|proprietary|none`',
    `coordination_study_reference` STRING COMMENT 'Reference identifier to the protection coordination study that validated this systems settings and selectivity with adjacent devices. Links to engineering analysis documentation required for NERC PRC compliance and fault investigation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this protection system record was first created in the data management system. Used for data lineage tracking and audit trail purposes.',
    `ct_ratio` STRING COMMENT 'Current transformer turns ratio (e.g., 2000:5, 1200:1) that scales primary current to secondary relay input. Essential for relay setting calculations, coordination studies, and accurate fault current measurement.',
    `fault_record_count` STRING COMMENT 'Total number of fault events recorded by this protection system since commissioning or last counter reset. Used for reliability analysis, equipment stress assessment, and predictive maintenance planning.',
    `ferc_account_code` STRING COMMENT 'FERC Uniform System of Accounts classification code for capitalization and depreciation of the protection system asset (typically Account 353 - Station Equipment). Required for regulatory financial reporting and rate case cost studies.',
    `firmware_version` STRING COMMENT 'Current firmware or software version installed on the protective relay. Critical for cybersecurity vulnerability management, NERC CIP compliance, and ensuring compatibility with protection coordination studies.',
    `in_service_date` DATE COMMENT 'Date when the protection system was commissioned and placed into active service protecting the transmission element. Marks the start of the operational lifecycle and NERC compliance obligations.',
    `installation_date` DATE COMMENT 'Date when the protection system was physically installed at the substation or transmission facility. Used for asset lifecycle tracking, depreciation calculations, and replacement planning.',
    `is_bes_protection` BOOLEAN COMMENT 'Boolean indicator of whether this protection system is classified as protecting a BES element and therefore subject to NERC reliability standards. Determines applicability of NERC PRC and CIP compliance requirements.',
    `last_calibration_date` DATE COMMENT 'Date when the protective relay was last tested, calibrated, and verified to be operating within manufacturer specifications. Critical for NERC PRC-005 maintenance compliance and reliability assurance.',
    `last_fault_date` DATE COMMENT 'Date when this protection system last detected and responded to a fault condition. Used for operational trending and to correlate protection performance with transmission outage events.',
    `last_misoperation_date` DATE COMMENT 'Date of the most recent documented protection system misoperation. Triggers NERC PRC-004 investigation and corrective action plan requirements. Nullable if no misoperations have occurred.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this protection system record was most recently modified. Used for change tracking, data synchronization, and audit trail purposes.',
    `misoperation_count` STRING COMMENT 'Cumulative count of documented protection system misoperations (incorrect trips or failures to trip) as defined by NERC PRC-004. Used for reliability trending, root cause analysis, and identification of systematic protection issues.',
    `nerc_cip_applicable` BOOLEAN COMMENT 'Boolean indicator of whether this protection system is a BES Cyber System subject to NERC CIP cybersecurity standards (CIP-002 through CIP-014). Determines requirements for electronic security perimeters, access controls, and vulnerability assessments.',
    `nerc_prc_compliance_status` STRING COMMENT 'Current compliance status with applicable NERC PRC standards (PRC-005, PRC-019, PRC-023, PRC-025, PRC-027). Tracks whether maintenance, testing, coordination, and documentation requirements are met. Critical for regulatory audits and reliability assurance.. Valid values are `compliant|non_compliant|pending_review|exempted|not_applicable`',
    `next_calibration_due_date` DATE COMMENT 'Scheduled date for the next required calibration or maintenance test based on NERC PRC-005 time-based or performance-based maintenance intervals. Used for preventive maintenance planning and compliance tracking.',
    `notes` STRING COMMENT 'Free-text field for operational notes, special configuration details, known issues, or historical context about the protection system. Used by protection engineers and maintenance personnel for knowledge transfer and troubleshooting.',
    `operational_status` STRING COMMENT 'Current operational state of the protection system. Indicates whether the system is actively protecting the transmission element, temporarily out for testing/maintenance, or permanently retired. Critical for real-time grid operations and SCADA monitoring.. Valid values are `in_service|out_of_service|testing|maintenance|retired|standby`',
    `original_cost_usd` DECIMAL(18,2) COMMENT 'Original installed cost of the protection system in US dollars, including equipment, engineering, installation labor, and commissioning. Used for FERC rate base calculations, depreciation, and capital expenditure tracking.',
    `protection_scheme_type` STRING COMMENT 'Primary protection principle or relay logic employed by this system (e.g., distance protection for transmission lines, differential for transformers, pilot schemes for critical circuits). Defines the protection philosophy and coordination requirements per IEEE and NERC standards. [ENUM-REF-CANDIDATE: distance|differential|overcurrent|pilot|directional_comparison|transfer_trip|breaker_failure|undervoltage|overvoltage|underfrequency|overfrequency — 11 candidates stripped; promote to reference product]',
    `protection_system_code` STRING COMMENT 'Standardized alphanumeric code or tag number assigned to the protection system for asset tracking, SCADA integration, and maintenance scheduling. Often follows utility-specific naming conventions aligned with substation or transmission line designations.',
    `protection_system_name` STRING COMMENT 'Human-readable name or designation of the protection system, typically including location and function identifiers (e.g., Main-1 Line Differential, Bus 5 Overcurrent). Used for operational identification and work order references.',
    `protection_zone` STRING COMMENT 'Protection zone classification defining the reach and coordination tier of the relay (e.g., Zone 1 instantaneous, Zone 2 time-delayed, Zone 3 remote backup). Critical for selectivity and coordination with adjacent protection systems per IEEE standards.. Valid values are `zone_1|zone_2|zone_3|zone_4|backup|remote_backup`',
    `pt_ratio` STRING COMMENT 'Potential (voltage) transformer turns ratio (e.g., 115000:115, 345000:120) that scales primary voltage to secondary relay input. Required for distance relay reach calculations and voltage-based protection schemes.',
    `relay_management_system_reference` STRING COMMENT 'External reference to the protection system record in the relay management system (SEL AcSELerator, GE UR Setup, ABB PCM600). Links to relay settings files, event records, and firmware management.',
    `relay_serial_number` STRING COMMENT 'Unique manufacturer-assigned serial number for the physical relay device. Used for warranty tracking, asset inventory, and device-specific configuration management in relay management systems.',
    `retirement_date` DATE COMMENT 'Date when the protection system was permanently decommissioned and removed from service. Nullable for active systems. Used for asset lifecycle closure and historical fault analysis records.',
    `scada_point_reference` STRING COMMENT 'SCADA system point identifier or tag name for real-time monitoring of protection system status, trip signals, and alarm conditions. Links relay to Energy Management System (EMS) for operational visibility.',
    `settings_last_modified_date` DATE COMMENT 'Date when the relay settings were last changed or updated. Critical for change management tracking, NERC PRC compliance documentation, and correlation with system performance changes.',
    `settings_modified_by` STRING COMMENT 'Name or identifier of the engineer or technician who last modified the relay settings. Required for audit trails, accountability, and NERC CIP access control compliance.',
    `trip_setting_reference` STRING COMMENT 'Reference identifier or file path to the approved relay settings document, including pickup values, time delays, reach settings, and logic configurations. Required for NERC PRC-019 compliance and protection coordination verification.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage class in kilovolts of the transmission element protected by this system (e.g., 115, 230, 345, 500, 765 kV). Determines applicable protection schemes, relay settings, and NERC reliability standards.',
    CONSTRAINT pk_protection_system PRIMARY KEY(`protection_system_id`)
) COMMENT 'Master record for protective relay systems and protection schemes installed on BES transmission elements (lines, transformers, buses). Captures protection system ID, associated transmission element, relay type (distance/differential/overcurrent/pilot), relay manufacturer and model, CT/PT ratios, protection zone, trip settings, coordination study reference, firmware version, last calibration date, NERC PRC compliance status, and operational status. Required for NERC PRC (Protection and Control) standard compliance, fault analysis, and misoperation tracking. Source system: SEL/GE/ABB relay management systems, Oracle WAM/IBM Maximo.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`constrained_element` (
    `constrained_element_id` BIGINT COMMENT 'Primary key for constrained_element',
    `balancing_authority_id` BIGINT COMMENT 'FK to transmission.balancing_authority',
    `transmission_substation_id` BIGINT COMMENT 'FK to transmission.transmission_substation',
    `pricing_node_id` BIGINT COMMENT 'Associated LMP pricing node identifier used for market settlement and congestion pricing at this element.',
    `to_transmission_substation_id` BIGINT COMMENT 'FK to transmission.transmission_substation',
    `associated_constrained_element_id` BIGINT COMMENT 'Self-referencing FK on constrained_element (associated_constrained_element_id)',
    `available_transfer_capability_mw` DECIMAL(18,2) COMMENT 'Current available transfer capability in megawatts (MW) for transmission service on this element.',
    `cip_classification` STRING COMMENT 'NERC CIP impact rating classification for cybersecurity and physical security requirements.',
    `circuit_number` STRING COMMENT 'Circuit identifier for parallel transmission lines between the same substations.',
    `congestion_frequency_score` DECIMAL(18,2) COMMENT 'Historical frequency score indicating how often this element experiences congestion or binding constraints (0-100 scale).',
    `constraint_type` STRING COMMENT 'Type of operational constraint that limits the element (thermal overload, voltage limit, stability limit, or reliability constraint).',
    `contingency_flag` BOOLEAN COMMENT 'Indicates whether this element is monitored as part of contingency analysis for N-1 or N-2 reliability assessments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this constrained element record was first created in the system.',
    `constrained_element_description` STRING COMMENT 'Detailed description of the constrained element including operational characteristics, constraint drivers, and mitigation strategies.',
    `element_identifier` STRING COMMENT 'External business identifier or code used by RTO/ISO and market participants to reference this constrained element (e.g., flowgate ID, contingency element ID).',
    `element_name` STRING COMMENT 'Human-readable name or designation of the constrained transmission element (e.g., line name, transformer name, interface name).',
    `element_type` STRING COMMENT 'Classification of the constrained element by infrastructure type within the bulk electric system.',
    `emergency_rating_mva` DECIMAL(18,2) COMMENT 'Emergency operating rating of the element in megavolt-amperes (MVA) for short-term contingency conditions.',
    `geographic_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the constrained element location in decimal degrees.',
    `geographic_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the constrained element location in decimal degrees.',
    `in_service_date` DATE COMMENT 'Date when the constrained element was first placed into commercial operation.',
    `interconnection_queue_flag` BOOLEAN COMMENT 'Indicates whether this element is associated with pending generator interconnection requests that may affect its constraint status.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance or inspection performed on this element.',
    `nerc_region` STRING COMMENT 'NERC regional entity with jurisdiction over reliability standards compliance for this element.',
    `next_maintenance_date` DATE COMMENT 'Date of the next scheduled maintenance or inspection for this element.',
    `normal_rating_mva` DECIMAL(18,2) COMMENT 'Normal continuous operating rating of the element in megavolt-amperes (MVA) under standard ambient conditions.',
    `oatt_service_type` STRING COMMENT 'Type of transmission service available on this element under FERC OATT requirements.',
    `retirement_date` DATE COMMENT 'Planned or actual date when the constrained element was or will be retired from service.',
    `rto_iso_region` STRING COMMENT 'The RTO or ISO region that has operational authority over this constrained element.',
    `seasonal_rating_flag` BOOLEAN COMMENT 'Indicates whether this element has different ratings based on seasonal ambient temperature conditions.',
    `constrained_element_status` STRING COMMENT 'Current lifecycle status of the constrained element within the transmission system.',
    `total_transfer_capability_mw` DECIMAL(18,2) COMMENT 'Total transfer capability in megawatts (MW) representing the maximum power that can be transferred across this element.',
    `transmission_owner` STRING COMMENT 'The entity that owns and maintains the physical transmission infrastructure for this constrained element.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this constrained element record was last modified.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal operating voltage level of the constrained element in kilovolts (kV). Critical for determining bulk electric system classification.',
    CONSTRAINT pk_constrained_element PRIMARY KEY(`constrained_element_id`)
) COMMENT 'Master reference table for constrained_element. Referenced by constrained_element_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`flowgate` (
    `flowgate_id` BIGINT COMMENT 'Primary key for flowgate',
    `balancing_authority_id` BIGINT COMMENT 'Identifier of the balancing authority responsible for maintaining load-resource balance in the area containing this flowgate.',
    `transmission_substation_id` BIGINT COMMENT 'Identifier of the originating substation or node at one end of the flowgate for directional flow analysis.',
    `operator_id` BIGINT COMMENT 'Identifier of the entity that owns the physical transmission assets comprising this flowgate.',
    `rto_iso_id` BIGINT COMMENT 'FK to market.rto_iso',
    `to_substation_id` BIGINT COMMENT 'Identifier of the destination substation or node at the other end of the flowgate for directional flow analysis.',
    `associated_flowgate_id` BIGINT COMMENT 'Self-referencing FK on flowgate (associated_flowgate_id)',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum power transfer capacity of the flowgate measured in megawatts under normal operating conditions.',
    `congestion_threshold_percent` DECIMAL(18,2) COMMENT 'Percentage of capacity utilization at which the flowgate is considered congested and may trigger transmission loading relief or pricing adjustments.',
    `contingency_rating_mw` DECIMAL(18,2) COMMENT 'Power transfer limit for the flowgate under single contingency conditions (N-1 criteria) to maintain system reliability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this flowgate record was first created in the transmission system of record.',
    `critical_infrastructure_flag` BOOLEAN COMMENT 'Indicates whether this flowgate is designated as critical infrastructure under NERC CIP standards requiring enhanced cybersecurity and physical security controls.',
    `flowgate_description` STRING COMMENT 'Detailed textual description of the flowgate including its physical location, operational characteristics, and any special considerations for transmission planning and operations.',
    `direction` STRING COMMENT 'Directional characteristic of power flow through the flowgate, indicating whether it supports bidirectional flow or is constrained to a single direction.',
    `effective_date` DATE COMMENT 'Date when this flowgate configuration became or will become operationally effective in the transmission system.',
    `emergency_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum power transfer capacity of the flowgate under emergency operating conditions, typically higher than normal capacity for short durations.',
    `expiration_date` DATE COMMENT 'Date when this flowgate configuration is scheduled to expire or be retired from the transmission system, null for indefinite operation.',
    `flowgate_code` STRING COMMENT 'Externally-known unique code or identifier for the flowgate used in interchange scheduling and RTO/ISO coordination.',
    `flowgate_name` STRING COMMENT 'Human-readable name or designation of the flowgate used for operational identification and communication.',
    `flowgate_type` STRING COMMENT 'Classification of the flowgate based on the physical infrastructure element it represents (transmission line, transformer, interface, corridor, or path).',
    `geographic_region` STRING COMMENT 'Geographic area or market zone in which the flowgate is located, used for regional transmission planning and congestion management.',
    `interconnection_type` STRING COMMENT 'North American power grid interconnection to which this flowgate belongs (Eastern, Western, Texas) or if it represents a seam between interconnections.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this flowgate record was most recently updated or modified in the transmission system of record.',
    `monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether real-time monitoring and reporting of this flowgate is required for reliability coordination and market operations.',
    `nerc_region_code` STRING COMMENT 'NERC regional entity code indicating the reliability region in which this flowgate operates.',
    `oatt_service_type` STRING COMMENT 'Type of transmission service offered on this flowgate under OATT regulations, determining priority and curtailment rules.',
    `parallel_path_adjustment_factor` DECIMAL(18,2) COMMENT 'Factor used to account for loop flow and parallel path impacts when calculating Available Transfer Capability (ATC) across this flowgate.',
    `seasonal_rating_flag` BOOLEAN COMMENT 'Indicates whether this flowgate has different capacity ratings for different seasons due to ambient temperature effects on thermal limits.',
    `stability_limit_mw` DECIMAL(18,2) COMMENT 'Maximum power transfer constrained by transient or dynamic stability limits to prevent system oscillations or loss of synchronism.',
    `flowgate_status` STRING COMMENT 'Current operational status of the flowgate in the transmission system lifecycle.',
    `thermal_limit_mw` DECIMAL(18,2) COMMENT 'Maximum power transfer based on thermal heating constraints of conductors and equipment to prevent physical damage.',
    `voltage_kv` DECIMAL(18,2) COMMENT 'Operating voltage level of the flowgate measured in kilovolts, indicating the transmission system tier.',
    `voltage_limit_mw` DECIMAL(18,2) COMMENT 'Maximum power transfer constrained by voltage stability limits to maintain acceptable voltage levels across the transmission system.',
    CONSTRAINT pk_flowgate PRIMARY KEY(`flowgate_id`)
) COMMENT 'Master reference table for flowgate. Referenced by flowgate_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`contingency_scenario` (
    `contingency_scenario_id` BIGINT COMMENT 'Primary key for contingency_scenario',
    `base_contingency_scenario_id` BIGINT COMMENT 'Self-referencing FK on contingency_scenario (base_contingency_scenario_id)',
    `affected_voltage_class_kv` STRING COMMENT 'Voltage level(s) of the Bulk Electric System (BES) facilities affected by the contingency scenario, expressed in kilovolts.',
    `approval_date` DATE COMMENT 'Date on which the contingency scenario definition was formally approved for use in transmission planning studies.',
    `approved_by` STRING COMMENT 'Name or identifier of the planning authority or engineer who approved the contingency scenario for use in studies.',
    `cascading_potential_flag` BOOLEAN COMMENT 'Indicator of whether the contingency scenario has the potential to result in cascading outages beyond the initial event.',
    `contingency_scenario_category` STRING COMMENT 'NERC Transmission Planning (TPL) category designation (P0 through P7) indicating the severity and probability class of the contingency.',
    `common_mode_flag` BOOLEAN COMMENT 'Indicator of whether the contingency scenario involves common mode failures affecting multiple facilities simultaneously.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the contingency scenario record was first created in the system.',
    `contingency_scenario_description` STRING COMMENT 'Detailed narrative description of the contingency scenario including the specific equipment outages, operating conditions, and assumptions.',
    `effective_date` DATE COMMENT 'Date on which the contingency scenario definition becomes active and applicable for planning studies.',
    `expiration_date` DATE COMMENT 'Date on which the contingency scenario definition is no longer applicable or is superseded by updated scenarios.',
    `ferc_reportable_flag` BOOLEAN COMMENT 'Indicator of whether the contingency scenario results must be included in FERC jurisdictional reporting.',
    `generation_dispatch` STRING COMMENT 'Description of the generation resource commitment and dispatch pattern assumed in the contingency scenario analysis.',
    `geographic_scope` STRING COMMENT 'Spatial extent of the contingency scenario impact across the transmission system footprint.',
    `initiating_event` STRING COMMENT 'Primary triggering event or equipment failure that defines the start of the contingency scenario sequence.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the contingency scenario record was most recently updated or modified.',
    `last_review_date` DATE COMMENT 'Most recent date on which the contingency scenario definition was reviewed and validated by planning engineers.',
    `load_level` STRING COMMENT 'System demand condition under which the contingency scenario is evaluated in planning studies.',
    `nerc_compliance_flag` BOOLEAN COMMENT 'Indicator of whether the contingency scenario is required for NERC TPL standard compliance demonstration.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next periodic review and update of the contingency scenario definition.',
    `notes` STRING COMMENT 'Additional comments, assumptions, or clarifications related to the contingency scenario definition and application.',
    `outage_count` STRING COMMENT 'Number of simultaneous equipment or facility outages included in the contingency scenario definition.',
    `probability_class` STRING COMMENT 'Expected likelihood classification of the contingency scenario occurrence based on historical data and engineering judgment.',
    `rto_iso_coordination_required_flag` BOOLEAN COMMENT 'Indicator of whether the contingency scenario requires coordination with the RTO or ISO for analysis or operational response.',
    `scenario_code` STRING COMMENT 'Externally-known unique code identifying the contingency scenario for planning and operational reference.',
    `scenario_name` STRING COMMENT 'Human-readable name of the contingency scenario describing the event or condition being modeled.',
    `scenario_type` STRING COMMENT 'Classification of the contingency scenario based on the number and nature of simultaneous outages or events.',
    `season` STRING COMMENT 'Seasonal period during which the contingency scenario is most relevant or critical for planning analysis.',
    `severity_level` STRING COMMENT 'Qualitative assessment of the potential impact severity of the contingency scenario on system reliability and customer service.',
    `source_document` STRING COMMENT 'Reference to the planning study, engineering report, or regulatory filing that defines or documents the contingency scenario.',
    `contingency_scenario_status` STRING COMMENT 'Current lifecycle status of the contingency scenario indicating whether it is actively used in planning studies.',
    `study_year` STRING COMMENT 'Planning horizon year for which the contingency scenario is defined and analyzed.',
    `version_number` STRING COMMENT 'Version identifier tracking revisions and updates to the contingency scenario definition over time.',
    CONSTRAINT pk_contingency_scenario PRIMARY KEY(`contingency_scenario_id`)
) COMMENT 'Master reference table for contingency_scenario. Referenced by contingency_scenario_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`control_area` (
    `control_area_id` BIGINT COMMENT 'Primary key for control_area',
    `parent_control_area_id` BIGINT COMMENT 'Reference to a parent or umbrella control area if this control area is a sub-area or nested within a larger operational boundary.',
    `balancing_authority_flag` BOOLEAN COMMENT 'Indicates whether this control area is registered as a NERC Balancing Authority responsible for load-resource balance within its metered boundaries.',
    `cip_critical_asset_flag` BOOLEAN COMMENT 'Indicates whether this control area contains facilities designated as critical cyber assets under NERC CIP standards.',
    `contact_email` STRING COMMENT 'Primary email address for operational notifications and coordination with the control area.',
    `contact_name` STRING COMMENT 'Name of the primary operational contact or control area operator responsible for coordination and communications.',
    `contact_phone` STRING COMMENT 'Primary phone number for operational coordination and emergency communications with the control area.',
    `control_area_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the control area within the interconnection. Typically assigned by NERC or the Regional Transmission Organization (RTO).',
    `control_performance_standard_1_target` DECIMAL(18,2) COMMENT 'Target compliance value for NERC Control Performance Standard 1, measuring frequency control performance over a rolling 12-month period.',
    `control_performance_standard_2_target` DECIMAL(18,2) COMMENT 'Target compliance value for NERC Control Performance Standard 2, measuring the control areas ability to limit unscheduled flow.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this control area record was first created in the system.',
    `disturbance_control_standard_target_minutes` STRING COMMENT 'Target recovery time in minutes for returning Area Control Error to specified limits following a reportable disturbance, per NERC DCS requirements.',
    `effective_date` DATE COMMENT 'Date when this control area became operational or when the current registration became effective.',
    `ferc_jurisdictional_flag` BOOLEAN COMMENT 'Indicates whether this control area falls under FERC jurisdiction for interstate transmission and wholesale power transactions.',
    `frequency_bias_setting_mw_per_0_1_hz` DECIMAL(18,2) COMMENT 'The frequency bias setting in MW per 0.1 Hz used in Area Control Error (ACE) calculations for automatic generation control.',
    `headquarters_address` STRING COMMENT 'Physical address of the control areas operational headquarters or control center.',
    `headquarters_city` STRING COMMENT 'City where the control areas operational headquarters or control center is located.',
    `headquarters_country` STRING COMMENT 'Country where the control areas operational headquarters is located, using ISO 3166-1 alpha-3 country codes.',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the control areas headquarters location.',
    `headquarters_state_province` STRING COMMENT 'State or province where the control areas operational headquarters is located.',
    `installed_generation_capacity_mw` DECIMAL(18,2) COMMENT 'Total installed generation capacity in megawatts within the control area boundaries.',
    `interconnection` STRING COMMENT 'The major North American interconnection to which this control area belongs. Defines the synchronous grid boundary.',
    `last_audit_date` DATE COMMENT 'Date of the most recent NERC compliance audit or reliability assessment conducted for this control area.',
    `control_area_name` STRING COMMENT 'Full legal or operational name of the control area as registered with the reliability coordinator.',
    `nerc_region` STRING COMMENT 'The NERC regional entity responsible for reliability oversight of this control area.',
    `nerc_registration_number` STRING COMMENT 'Official NERC registration identifier assigned to this control area for compliance and reporting purposes.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next NERC compliance audit or reliability assessment.',
    `notes` STRING COMMENT 'Additional operational notes, special conditions, or remarks regarding this control area.',
    `oatt_on_file_flag` BOOLEAN COMMENT 'Indicates whether this control area has an approved Open Access Transmission Tariff on file with FERC for non-discriminatory transmission service.',
    `peak_load_mw` DECIMAL(18,2) COMMENT 'Historical or forecasted peak demand in megawatts for this control area, used for capacity planning and reliability assessments.',
    `reliability_coordinator_code` BIGINT COMMENT 'Reference to the NERC Reliability Coordinator that provides wide-area reliability oversight for this control area.',
    `reserve_margin_percent` DECIMAL(18,2) COMMENT 'Planning reserve margin expressed as a percentage, representing the excess generation capacity above peak load required for reliability.',
    `rto_iso_affiliation` STRING COMMENT 'Name of the RTO or ISO that operates or coordinates this control area, if applicable. Examples include PJM, MISO, CAISO, NYISO, ISO-NE, SPP.',
    `service_territory_description` STRING COMMENT 'Textual description of the geographic or jurisdictional boundaries served by this control area.',
    `short_name` STRING COMMENT 'Abbreviated or commonly used name for the control area for operational communications and reporting.',
    `control_area_status` STRING COMMENT 'Current operational status of the control area within the interconnection.',
    `termination_date` DATE COMMENT 'Date when this control area ceased operations or was decommissioned, if applicable.',
    `time_zone` STRING COMMENT 'Primary time zone used for operational scheduling and reporting within this control area, typically in IANA time zone format.',
    `transmission_operator_flag` BOOLEAN COMMENT 'Indicates whether this control area operates transmission facilities and is registered as a NERC Transmission Operator.',
    `control_area_type` STRING COMMENT 'Functional classification of the control area based on its operational role within the bulk electric system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this control area record was last modified in the system.',
    CONSTRAINT pk_control_area PRIMARY KEY(`control_area_id`)
) COMMENT 'Master reference table for control_area. Referenced by control_area_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`balancing_authority` (
    `balancing_authority_id` BIGINT COMMENT 'Primary key for balancing_authority',
    `counterparty_balancing_authority_id` BIGINT COMMENT 'Self-referencing FK on balancing_authority (counterparty_balancing_authority_id)',
    `ace_reporting_flag` BOOLEAN COMMENT 'Indicates whether this balancing authority reports Area Control Error (ACE) metrics to NERC for compliance monitoring.',
    `ba_code` STRING COMMENT 'Standard alphanumeric code assigned to the balancing authority by NERC. Typically 2-4 uppercase letters (e.g., PJM, MISO, CAISO, ERCOT).',
    `ba_name` STRING COMMENT 'Full legal or operating name of the balancing authority organization.',
    `ba_type` STRING COMMENT 'Classification of the balancing authority organizational structure: Independent System Operator (ISO), Regional Transmission Organization (RTO), investor-owned utility, cooperative, federal power authority, or municipal utility.',
    `cps1_threshold_percent` DECIMAL(18,2) COMMENT 'NERC Control Performance Standard 1 (CPS1) compliance threshold percentage for this balancing authority. CPS1 measures how well the BA controls ACE over a one-year period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this balancing authority record was first created in the system.',
    `disturbance_control_standard_mw` DECIMAL(18,2) COMMENT 'NERC Disturbance Control Standard (DCS) requirement for this balancing authority, representing the most severe single contingency loss in megawatts (MW).',
    `ferc_jurisdiction_flag` BOOLEAN COMMENT 'Indicates whether this balancing authority is subject to FERC jurisdictional oversight for interstate transmission and wholesale power markets.',
    `headquarters_address_line1` STRING COMMENT 'First line of the street address for the balancing authority headquarters or control center.',
    `headquarters_address_line2` STRING COMMENT 'Second line of the street address for the balancing authority headquarters (suite, floor, building).',
    `headquarters_city` STRING COMMENT 'City where the balancing authority headquarters or control center is located.',
    `headquarters_country_code` STRING COMMENT 'ISO 3166-1 alpha-3 country code for the balancing authority headquarters location (USA, CAN, MEX).',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the balancing authority headquarters or control center.',
    `headquarters_state_province` STRING COMMENT 'State or province where the balancing authority headquarters or control center is located.',
    `interconnection` STRING COMMENT 'North American electric grid interconnection to which this balancing authority belongs: Eastern Interconnection, Western Interconnection, Texas Interconnection (ERCOT), or Quebec Interconnection.',
    `last_compliance_audit_date` DATE COMMENT 'Date of the most recent NERC compliance audit conducted for this balancing authority.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this balancing authority record was last modified in the system.',
    `lmp_pricing_flag` BOOLEAN COMMENT 'Indicates whether this balancing authority uses locational marginal pricing methodology for wholesale energy pricing.',
    `market_operator_flag` BOOLEAN COMMENT 'Indicates whether this balancing authority operates organized wholesale electricity markets (day-ahead, real-time energy, capacity, ancillary services).',
    `nerc_region` STRING COMMENT 'NERC regional entity jurisdiction under which this balancing authority operates: Western Electricity Coordinating Council (WECC), Texas Reliability Entity (TRE), Midwest Reliability Organization (MRO), SERC Reliability Corporation (SERC), ReliabilityFirst (RF), or Northeast Power Coordinating Council (NPCC).',
    `nerc_registration_number` STRING COMMENT 'Unique registration identifier assigned by NERC to this balancing authority in the NERC Compliance Registry.',
    `next_compliance_audit_date` DATE COMMENT 'Scheduled date for the next NERC compliance audit for this balancing authority.',
    `notes` STRING COMMENT 'Free-form text field for additional operational notes, special conditions, or historical context about the balancing authority.',
    `oasis_url` STRING COMMENT 'URL for the balancing authority OASIS node, providing real-time transmission availability and scheduling information as required by FERC.',
    `oatt_on_file_flag` BOOLEAN COMMENT 'Indicates whether the balancing authority has an approved Open Access Transmission Tariff on file with FERC.',
    `operational_status` STRING COMMENT 'Current operational state of the balancing authority in the NERC registry and grid operations.',
    `peak_demand_mw` DECIMAL(18,2) COMMENT 'Historical or forecasted peak demand within the balancing authority area, measured in megawatts (MW).',
    `primary_contact_email` STRING COMMENT 'Email address of the primary operational contact for the balancing authority.',
    `primary_contact_name` STRING COMMENT 'Name of the primary operational contact or responsible officer for the balancing authority.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary operational contact for the balancing authority.',
    `registered_capacity_mw` DECIMAL(18,2) COMMENT 'Total registered generation capacity under the balancing authority control area, measured in megawatts (MW).',
    `registration_effective_date` DATE COMMENT 'Date when the balancing authority registration with NERC became effective.',
    `registration_expiration_date` DATE COMMENT 'Date when the balancing authority registration with NERC expires or is scheduled for renewal. Null for indefinite registrations.',
    `service_territory_area_sq_mi` DECIMAL(18,2) COMMENT 'Geographic area covered by the balancing authority service territory, measured in square miles.',
    `time_zone` STRING COMMENT 'Primary time zone used for operational scheduling and reporting by the balancing authority: Eastern Standard Time (EST), Central Standard Time (CST), Mountain Standard Time (MST), Pacific Standard Time (PST), Alaska Standard Time (AKST), or Hawaii Standard Time (HST).',
    `website_url` STRING COMMENT 'Official website URL for the balancing authority, providing public access to operational data, tariffs, and market information.',
    CONSTRAINT pk_balancing_authority PRIMARY KEY(`balancing_authority_id`)
) COMMENT 'Master reference table for balancing_authority. Referenced by counterparty_ba_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`control_center` (
    `control_center_id` BIGINT COMMENT 'Primary key for control_center',
    `backup_control_center_id` BIGINT COMMENT 'Reference to the designated backup control center that can assume operational control if this primary control center becomes unavailable.',
    `balancing_authority_id` BIGINT COMMENT 'FK to transmission.balancing_authority',
    `annual_operating_budget_usd` DECIMAL(18,2) COMMENT 'Annual operating budget allocated for this control center in US dollars. Business-confidential financial data.',
    `certification_expiry_date` DATE COMMENT 'Expiration date of the control center operational certification or NERC registration requiring renewal.',
    `city` STRING COMMENT 'City where the control center facility is physically located. Business-confidential organizational location data.',
    `commissioning_date` DATE COMMENT 'Date when the control center was officially commissioned and began operational service.',
    `control_area_mw_capacity` DECIMAL(18,2) COMMENT 'Total generation capacity in megawatts under the operational control of this control center.',
    `control_center_code` STRING COMMENT 'Unique alphanumeric code assigned to the control center for system identification and interchange scheduling. Used in OASIS postings and RTO/ISO communications.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the control center is located within the North American interconnection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this control center record was first created in the system.',
    `disaster_recovery_site_location` STRING COMMENT 'Geographic location description of the disaster recovery or backup site for this control center. Confidential for security reasons.',
    `emergency_phone` STRING COMMENT '24/7 emergency contact telephone number for the control center used during grid disturbances or critical events. Business-confidential organizational contact data.',
    `ems_platform_version` STRING COMMENT 'Version identifier of the energy management system software platform deployed at this control center.',
    `is_primary_control_center` BOOLEAN COMMENT 'Indicates whether this control center serves as the primary operational control facility (true) or a backup/secondary facility (false).',
    `last_major_upgrade_date` DATE COMMENT 'Date of the most recent major system upgrade or modernization project completed at this control center.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this control center record was most recently updated.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the control center facility in decimal degrees. Confidential for physical security reasons per NERC CIP standards.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the control center facility in decimal degrees. Confidential for physical security reasons per NERC CIP standards.',
    `monitored_transmission_elements_count` STRING COMMENT 'Number of bulk electric system transmission elements (lines, transformers, breakers) actively monitored by this control center.',
    `control_center_name` STRING COMMENT 'Official name of the control center facility used for operational identification and communication.',
    `nerc_cip_classification` STRING COMMENT 'NERC CIP impact rating classification determining the cybersecurity and physical security requirements applicable to this control center.',
    `nerc_registered_entity_number` STRING COMMENT 'NERC-assigned identifier for the registered entity operating this control center. Required for compliance reporting and CIP standards adherence.',
    `notes` STRING COMMENT 'Additional operational notes, special instructions, or contextual information about the control center.',
    `operational_status` STRING COMMENT 'Current operational state of the control center indicating its availability for grid operations.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the control center facility address. Business-confidential organizational location data.',
    `primary_address_line_1` STRING COMMENT 'First line of the physical street address where the control center facility is located. Business-confidential organizational location data.',
    `primary_address_line_2` STRING COMMENT 'Second line of the physical street address (suite, floor, building) for the control center facility. Business-confidential organizational location data.',
    `primary_email` STRING COMMENT 'Primary email address for operational communications with the control center. Business-confidential organizational contact data.',
    `primary_phone` STRING COMMENT 'Main telephone number for operational contact with the control center. Business-confidential organizational contact data.',
    `redundancy_level` STRING COMMENT 'Level of system redundancy implemented at the control center for critical systems and infrastructure.',
    `rto_iso_affiliation` STRING COMMENT 'The RTO or ISO market that this control center operates within or coordinates with for transmission scheduling and market operations.',
    `scada_system_vendor` STRING COMMENT 'Name of the primary SCADA system vendor providing the energy management system platform for this control center.',
    `staffing_level` STRING COMMENT 'Typical number of operators and support personnel staffing the control center during normal operations.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the control center is located. Business-confidential organizational location data.',
    `supports_market_operations` BOOLEAN COMMENT 'Indicates whether this control center performs energy market operations including day-ahead and real-time market functions.',
    `supports_real_time_operations` BOOLEAN COMMENT 'Indicates whether this control center is equipped and staffed for real-time grid monitoring and control operations.',
    `time_zone` STRING COMMENT 'IANA time zone identifier for the control center location used for scheduling and timestamp coordination.',
    `control_center_type` STRING COMMENT 'Functional classification of the control center based on its operational role in the electric grid.',
    CONSTRAINT pk_control_center PRIMARY KEY(`control_center_id`)
) COMMENT 'Master reference table for control_center. Referenced by control_center_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`bus` (
    `bus_id` BIGINT COMMENT 'Primary key for bus',
    `control_area_id` BIGINT COMMENT 'Reference to the control area or balancing authority area to which this bus belongs. Used for interchange scheduling and area control error (ACE) calculations.',
    `operator_id` BIGINT COMMENT 'Reference to the transmission owner or operator responsible for this bus. Critical for NERC CIP compliance and jurisdictional reporting.',
    `transmission_substation_id` BIGINT COMMENT 'Reference to the substation where this bus is physically located. Links to the substation master table.',
    `market_zone_id` BIGINT COMMENT 'Reference to the transmission zone or pricing zone for locational marginal pricing (LMP) and congestion management. Used by RTO/ISO for market operations.',
    `active_power_mw` DECIMAL(18,2) COMMENT 'Net active power injection or withdrawal at the bus in megawatts (MW). Positive values indicate generation; negative values indicate load.',
    `base_voltage_kv` DECIMAL(18,2) COMMENT 'Base voltage used for per-unit calculations in power flow and stability studies. Typically matches the nominal voltage level but may differ for analytical purposes.',
    `bes_designation` BOOLEAN COMMENT 'Indicates whether this bus is part of the NERC-defined Bulk Electric System (BES). True if the bus meets BES criteria and is subject to NERC reliability standards and CIP compliance.',
    `bus_name` STRING COMMENT 'Human-readable name or designation of the bus, often reflecting the substation or geographic location it serves (e.g., Main Street 345kV Bus A).',
    `bus_number` STRING COMMENT 'Externally-known unique alphanumeric identifier for the bus used in operational systems, SCADA, and interchange scheduling. Typically assigned by the transmission operator or RTO/ISO.',
    `bus_type` STRING COMMENT 'Classification of the bus based on its role in power flow analysis. Slack (swing) bus maintains system voltage and frequency reference; generator bus has active generation; load bus serves demand; isolated bus is disconnected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this bus record was first created in the system. Used for data lineage and audit purposes.',
    `critical_infrastructure_flag` BOOLEAN COMMENT 'Indicates whether this bus is designated as critical infrastructure requiring enhanced physical and cyber security measures under NERC CIP standards.',
    `bus_description` STRING COMMENT 'Additional descriptive information about the bus, including configuration details, special operating characteristics, or notes relevant to operations and planning.',
    `ferc_jurisdiction_flag` BOOLEAN COMMENT 'Indicates whether this bus is under FERC jurisdiction for interstate transmission. True for facilities subject to FERC rate regulation and OATT compliance.',
    `generation_mvar` DECIMAL(18,2) COMMENT 'Reactive power generation at the bus in megavolt-amperes reactive (MVAR). Sum of all generator reactive outputs connected to this bus.',
    `generation_mw` DECIMAL(18,2) COMMENT 'Active power generation at the bus in megawatts (MW). Sum of all generator outputs connected to this bus.',
    `in_service_date` DATE COMMENT 'Date when the bus was first energized and placed into commercial operation. Used for asset lifecycle tracking and depreciation calculations.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent scheduled maintenance or inspection performed on the bus and associated equipment.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the bus location in decimal degrees. Used for GIS mapping, outage management, and spatial analysis.',
    `load_mvar` DECIMAL(18,2) COMMENT 'Reactive power load at the bus in megavolt-amperes reactive (MVAR). Represents reactive demand connected to this bus.',
    `load_mw` DECIMAL(18,2) COMMENT 'Active power load served at the bus in megawatts (MW). Represents demand connected to this bus.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the bus location in decimal degrees. Used for GIS mapping, outage management, and spatial analysis.',
    `nerc_region` STRING COMMENT 'NERC regional entity with jurisdiction over this bus. Used for compliance reporting and regional coordination.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the next planned maintenance or inspection of the bus and associated equipment.',
    `operational_status` STRING COMMENT 'Current operational state of the bus. In-service indicates the bus is energized and available; out-of-service indicates the bus is de-energized; testing and maintenance indicate temporary unavailability; retired indicates permanent decommissioning; planned indicates future installation.',
    `reactive_power_mvar` DECIMAL(18,2) COMMENT 'Net reactive power injection or withdrawal at the bus in megavolt-amperes reactive (MVAR). Critical for voltage control and VAR management.',
    `retirement_date` DATE COMMENT 'Planned or actual date when the bus was or will be permanently de-energized and retired from service. Null for active buses.',
    `rto_iso_code` STRING COMMENT 'Code identifying the RTO or ISO that operates the market and manages transmission service for this bus (e.g., PJM, MISO, CAISO, NYISO, ISO-NE, SPP).',
    `shunt_susceptance_mvar` DECIMAL(18,2) COMMENT 'Fixed shunt susceptance at the bus in MVAR at nominal voltage. Represents capacitor banks or reactor banks permanently connected to the bus for voltage support.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this bus record was last modified. Used for change tracking and data synchronization.',
    `voltage_angle_degrees` DECIMAL(18,2) COMMENT 'Phase angle of the bus voltage in degrees relative to the system reference (slack bus). Critical for power flow analysis and stability assessment.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level of the bus in kilovolts (kV). Defines the operating voltage class for the bus (e.g., 69, 115, 138, 230, 345, 500, 765 kV).',
    `voltage_magnitude_pu` DECIMAL(18,2) COMMENT 'Voltage magnitude at the bus expressed in per-unit (pu) of the base voltage. Typically maintained between 0.95 and 1.05 pu under normal operating conditions.',
    CONSTRAINT pk_bus PRIMARY KEY(`bus_id`)
) COMMENT 'Master reference table for bus. Referenced by from_bus_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`operator` (
    `operator_id` BIGINT COMMENT 'Primary key for operator',
    `control_area_id` BIGINT COMMENT 'Foreign key linking to transmission.control_area. Business justification: Operators manage control areas. The operator table has control_area_name STRING. Normalizing to FK to control_area. Removes control_area_name string.',
    `authorizing_operator_id` BIGINT COMMENT 'Self-referencing FK on operator (authorizing_operator_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this operator record was first created in the system.',
    `deregistration_date` DATE COMMENT 'Date when the operator ceased operations or was deregistered from NERC, if applicable.',
    `emergency_contact_phone` STRING COMMENT '24/7 emergency hotline number for system emergencies, outages, and reliability events.',
    `ferc_jurisdiction_flag` BOOLEAN COMMENT 'Indicates whether the operator is subject to FERC jurisdictional oversight for transmission services and rates.',
    `headquarters_address` STRING COMMENT 'Physical street address of the operators headquarters or primary control center.',
    `headquarters_city` STRING COMMENT 'City where the operators headquarters or primary control center is located.',
    `headquarters_country` STRING COMMENT 'Country where the operators headquarters is located. Three-letter ISO country code.',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code for the operators headquarters address.',
    `headquarters_state_province` STRING COMMENT 'State or province where the operators headquarters is located. Use two-letter abbreviation for US states and Canadian provinces.',
    `interconnection` STRING COMMENT 'The major North American interconnection to which the operator belongs. Defines synchronous grid boundaries.',
    `last_audit_date` DATE COMMENT 'Date of the most recent NERC compliance audit or reliability assessment conducted for this operator.',
    `nerc_cip_compliance_flag` BOOLEAN COMMENT 'Indicates whether the operator is subject to NERC CIP cybersecurity standards for bulk electric system protection.',
    `nerc_registration_number` STRING COMMENT 'Official NERC registry identifier for the operator entity. Required for compliance reporting and CIP standards applicability.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next NERC compliance audit or reliability assessment.',
    `notes` STRING COMMENT 'Additional notes, comments, or special considerations regarding the transmission operator.',
    `oasis_node_url` STRING COMMENT 'Web address of the operators OASIS node for posting available transmission capacity and accepting transmission service requests.',
    `oatt_tariff_number` STRING COMMENT 'FERC-approved tariff number under which the operator provides transmission service. Required for FERC jurisdictional operators.',
    `operational_status` STRING COMMENT 'Current operational status of the transmission operator within the NERC registry and interconnection.',
    `operator_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the transmission operator within the interconnection. Used for interchange scheduling and NERC reporting.',
    `operator_name` STRING COMMENT 'Full legal name of the transmission system operator or control area operator.',
    `operator_type` STRING COMMENT 'Functional classification of the operator within the bulk electric system. Defines the operational role and regulatory responsibilities.',
    `parent_company_name` STRING COMMENT 'Name of the parent holding company or corporate entity that owns the transmission operator, if applicable.',
    `primary_contact_email` STRING COMMENT 'Primary email address for operational coordination and interchange scheduling communications.',
    `primary_contact_name` STRING COMMENT 'Name of the primary operational contact person for the transmission operator.',
    `primary_contact_phone` STRING COMMENT 'Primary telephone number for operational coordination and emergency contact with the transmission operator.',
    `registration_date` DATE COMMENT 'Date when the operator was first registered with NERC or began transmission operations.',
    `rto_iso_affiliation` STRING COMMENT 'Name of the RTO or ISO market to which the operator belongs, if applicable. Examples: PJM, CAISO, MISO, SPP, NYISO, ISO-NE, ERCOT.',
    `service_territory_description` STRING COMMENT 'Textual description of the geographic service territory covered by the transmission operator.',
    `total_transmission_capacity_mw` DECIMAL(18,2) COMMENT 'Total rated transmission capacity in megawatts managed by the operator across all transmission lines and substations.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this operator record was last modified in the system.',
    `voltage_class_range` STRING COMMENT 'Range of voltage classes operated by the transmission operator, typically expressed as minimum to maximum kilovolts (e.g., 115 kV to 500 kV).',
    CONSTRAINT pk_operator PRIMARY KEY(`operator_id`)
) COMMENT 'Master reference table for operator. Referenced by authorizing_operator_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`transmission`.`crew` (
    `crew_id` BIGINT COMMENT 'Primary key for crew',
    `facility_id` BIGINT COMMENT 'Reference to the primary depot, yard, or service center where this crew is based. Used for resource allocation and travel time calculations.',
    `relieved_crew_id` BIGINT COMMENT 'Self-referencing FK on crew (relieved_crew_id)',
    `active_from_date` DATE COMMENT 'Date this crew became active and available for work assignments. Used for crew lifecycle tracking and historical analysis.',
    `active_until_date` DATE COMMENT 'Date this crew is scheduled to become inactive or contract ends. Null for indefinite assignments. Used for resource planning and contract management.',
    `certification_level` STRING COMMENT 'Overall qualification level of the crew based on training, experience, and certifications. Determines complexity of work assignments the crew can execute.',
    `contract_end_date` DATE COMMENT 'End date of the contract period for contractor crews. Null for internal crews or open-ended contracts. Used for contract renewal planning.',
    `contract_number` STRING COMMENT 'Contract or purchase order number governing the engagement of this contractor crew. Null for internal crews. Used for financial tracking and compliance.',
    `contract_start_date` DATE COMMENT 'Start date of the contract period for contractor crews. Null for internal crews. Used for contract lifecycle management.',
    `contractor_company_name` STRING COMMENT 'Name of the contracting company if this is a contractor crew. Null for internal utility crews. Used for vendor management and billing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was first created in the system. Used for audit trail and data lineage.',
    `crew_classification` STRING COMMENT 'Organizational classification of the crew. Internal crews are utility employees, contractor crews are third-party resources, mutual aid crews are from other utilities under mutual assistance agreements, emergency support crews are specialized external resources for major events.',
    `crew_lead_contact` STRING COMMENT 'Primary contact phone number for the crew lead. Used for dispatch coordination and emergency communication.',
    `crew_lead_name` STRING COMMENT 'Full name of the crew lead or foreman responsible for directing crew activities and ensuring safety compliance.',
    `crew_name` STRING COMMENT 'Human-readable name or designation of the crew (e.g., North Region Line Crew A, Substation Maintenance Team 3).',
    `crew_number` STRING COMMENT 'Business identifier for the crew, used in work orders and dispatch systems. Externally visible crew designation.',
    `crew_size` STRING COMMENT 'Number of personnel assigned to this crew. Used for resource planning and safety compliance (minimum crew size requirements per OSHA).',
    `crew_status` STRING COMMENT 'Current operational status of the crew. Active crews are available for dispatch, on_assignment crews are currently executing work, available crews are ready for immediate dispatch, training crews are in qualification activities, suspended crews are temporarily unavailable, inactive crews are not in service.',
    `crew_type` STRING COMMENT 'Classification of crew based on primary function: line crews for transmission line work, substation crews for substation equipment, switching crews for switching operations, emergency response for outage restoration, maintenance for scheduled upkeep, construction for new installations.',
    `days_since_last_incident` STRING COMMENT 'Number of days since the last safety incident. Used for safety performance recognition and monitoring.',
    `emergency_response_capable` BOOLEAN COMMENT 'Indicates whether this crew is equipped and trained for emergency outage restoration and storm response. Emergency-capable crews have specialized equipment and 24/7 availability.',
    `hot_line_qualified` BOOLEAN COMMENT 'Indicates whether the crew is qualified to perform energized (hot) work on transmission lines. Requires specialized training and equipment per OSHA 1910.269.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Standard hourly billing rate for this crew in USD. Used for cost estimation and budget planning. Applies to contractor crews; may be average rate for internal crews.',
    `last_incident_date` DATE COMMENT 'Date of the most recent safety incident involving this crew. Null if no incidents have occurred. Used for safety trend analysis.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was last updated. Used for audit trail and change tracking.',
    `last_training_date` DATE COMMENT 'Date of the most recent safety or technical training completed by this crew. Used to track training currency and compliance with NERC PER standards.',
    `mutual_aid_eligible` BOOLEAN COMMENT 'Indicates whether this crew can be deployed to assist other utilities under mutual assistance agreements during major events or emergencies.',
    `nerc_cip_clearance` BOOLEAN COMMENT 'Indicates whether all crew members hold valid NERC CIP personnel risk assessment clearances required for access to Bulk Electric System (BES) Cyber Systems and associated physical security perimeters.',
    `next_training_due_date` DATE COMMENT 'Date by which the crew must complete next required training to maintain qualifications. Used for training schedule planning and compliance tracking.',
    `notes` STRING COMMENT 'Free-form text field for additional information about the crew, such as special capabilities, equipment limitations, scheduling constraints, or operational notes.',
    `overtime_rate` DECIMAL(18,2) COMMENT 'Overtime hourly billing rate for this crew in USD. Used for after-hours and emergency work cost calculations.',
    `primary_equipment_specialization` STRING COMMENT 'Type of transmission equipment this crew specializes in (e.g., transmission towers, power transformers, circuit breakers, disconnect switches, series capacitors, static VAR compensators). Free text to accommodate diverse equipment types.',
    `safety_incident_count` STRING COMMENT 'Cumulative count of OSHA-recordable safety incidents involving this crew. Used for safety performance tracking and risk assessment.',
    `service_territory` STRING COMMENT 'Geographic region or territory this crew is assigned to serve. May reference transmission planning zones or operational areas.',
    `shift_schedule` STRING COMMENT 'Standard work schedule pattern for this crew. Day crews work standard business hours, night crews work overnight, rotating crews alternate shifts, on-call crews respond to emergencies, 24x7 crews provide continuous coverage.',
    `substation_access_authorized` BOOLEAN COMMENT 'Indicates whether the crew is authorized for unescorted access to transmission substations. Requires NERC CIP training and background checks.',
    `vehicle_fleet_assigned` STRING COMMENT 'List or description of vehicles and mobile equipment assigned to this crew (e.g., bucket trucks, digger derricks, line trucks, trailers). Used for resource tracking and dispatch planning.',
    `voltage_class_qualified` STRING COMMENT 'Voltage levels this crew is qualified and authorized to work on (e.g., 69kV, 138kV, 230kV, 345kV, 500kV). Pipe-separated list for crews qualified at multiple voltage classes. Critical for safety and NERC CIP compliance.',
    CONSTRAINT pk_crew PRIMARY KEY(`crew_id`)
) COMMENT 'Master reference table for crew. Referenced by executing_crew_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_bus_id` FOREIGN KEY (`bus_id`) REFERENCES `power_and_utilities`.`transmission`.`bus`(`bus_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_to_transmission_substation_id` FOREIGN KEY (`to_transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`line` ADD CONSTRAINT `fk_transmission_line_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `power_and_utilities`.`transmission`.`control_area`(`control_area_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ADD CONSTRAINT `fk_transmission_transmission_substation_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `power_and_utilities`.`transmission`.`operator`(`operator_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ADD CONSTRAINT `fk_transmission_transformer_bus_id` FOREIGN KEY (`bus_id`) REFERENCES `power_and_utilities`.`transmission`.`bus`(`bus_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ADD CONSTRAINT `fk_transmission_transformer_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ADD CONSTRAINT `fk_transmission_grid_topology_contingency_scenario_id` FOREIGN KEY (`contingency_scenario_id`) REFERENCES `power_and_utilities`.`transmission`.`contingency_scenario`(`contingency_scenario_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ADD CONSTRAINT `fk_transmission_grid_topology_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `power_and_utilities`.`transmission`.`control_area`(`control_area_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ADD CONSTRAINT `fk_transmission_grid_topology_previous_version_grid_topology_id` FOREIGN KEY (`previous_version_grid_topology_id`) REFERENCES `power_and_utilities`.`transmission`.`grid_topology`(`grid_topology_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ADD CONSTRAINT `fk_transmission_transfer_capability_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `power_and_utilities`.`transmission`.`control_area`(`control_area_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ADD CONSTRAINT `fk_transmission_transfer_capability_grid_topology_id` FOREIGN KEY (`grid_topology_id`) REFERENCES `power_and_utilities`.`transmission`.`grid_topology`(`grid_topology_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ADD CONSTRAINT `fk_transmission_transfer_capability_superseded_by_transfer_capability_id` FOREIGN KEY (`superseded_by_transfer_capability_id`) REFERENCES `power_and_utilities`.`transmission`.`transfer_capability`(`transfer_capability_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ADD CONSTRAINT `fk_transmission_interchange_schedule_balancing_authority_id` FOREIGN KEY (`balancing_authority_id`) REFERENCES `power_and_utilities`.`transmission`.`balancing_authority`(`balancing_authority_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ADD CONSTRAINT `fk_transmission_service_request_interconnection_request_id` FOREIGN KEY (`interconnection_request_id`) REFERENCES `power_and_utilities`.`transmission`.`interconnection_request`(`interconnection_request_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ADD CONSTRAINT `fk_transmission_service_request_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ADD CONSTRAINT `fk_transmission_interconnection_request_bus_id` FOREIGN KEY (`bus_id`) REFERENCES `power_and_utilities`.`transmission`.`bus`(`bus_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ADD CONSTRAINT `fk_transmission_interconnection_request_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_constrained_element_id` FOREIGN KEY (`constrained_element_id`) REFERENCES `power_and_utilities`.`transmission`.`constrained_element`(`constrained_element_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_flowgate_id` FOREIGN KEY (`flowgate_id`) REFERENCES `power_and_utilities`.`transmission`.`flowgate`(`flowgate_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ADD CONSTRAINT `fk_transmission_congestion_event_outage_id` FOREIGN KEY (`outage_id`) REFERENCES `power_and_utilities`.`transmission`.`outage`(`outage_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ADD CONSTRAINT `fk_transmission_outage_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities`.`transmission`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ADD CONSTRAINT `fk_transmission_outage_bus_id` FOREIGN KEY (`bus_id`) REFERENCES `power_and_utilities`.`transmission`.`bus`(`bus_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ADD CONSTRAINT `fk_transmission_outage_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ADD CONSTRAINT `fk_transmission_outage_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `power_and_utilities`.`transmission`.`transformer`(`transformer_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ADD CONSTRAINT `fk_transmission_outage_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ADD CONSTRAINT `fk_transmission_nerc_cip_asset_control_center_id` FOREIGN KEY (`control_center_id`) REFERENCES `power_and_utilities`.`transmission`.`control_center`(`control_center_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ADD CONSTRAINT `fk_transmission_nerc_cip_asset_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ADD CONSTRAINT `fk_transmission_tariff_rate_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ADD CONSTRAINT `fk_transmission_switching_order_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `power_and_utilities`.`transmission`.`operator`(`operator_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ADD CONSTRAINT `fk_transmission_switching_order_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities`.`transmission`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ADD CONSTRAINT `fk_transmission_switching_order_outage_id` FOREIGN KEY (`outage_id`) REFERENCES `power_and_utilities`.`transmission`.`outage`(`outage_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ADD CONSTRAINT `fk_transmission_switching_order_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ADD CONSTRAINT `fk_transmission_switching_order_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `power_and_utilities`.`transmission`.`transformer`(`transformer_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ADD CONSTRAINT `fk_transmission_switching_order_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ADD CONSTRAINT `fk_transmission_switching_order_superseded_switching_order_id` FOREIGN KEY (`superseded_switching_order_id`) REFERENCES `power_and_utilities`.`transmission`.`switching_order`(`switching_order_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ADD CONSTRAINT `fk_transmission_protection_system_backup_protection_system_id` FOREIGN KEY (`backup_protection_system_id`) REFERENCES `power_and_utilities`.`transmission`.`protection_system`(`protection_system_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ADD CONSTRAINT `fk_transmission_protection_system_line_id` FOREIGN KEY (`line_id`) REFERENCES `power_and_utilities`.`transmission`.`line`(`line_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ADD CONSTRAINT `fk_transmission_protection_system_transformer_id` FOREIGN KEY (`transformer_id`) REFERENCES `power_and_utilities`.`transmission`.`transformer`(`transformer_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ADD CONSTRAINT `fk_transmission_protection_system_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`constrained_element` ADD CONSTRAINT `fk_transmission_constrained_element_balancing_authority_id` FOREIGN KEY (`balancing_authority_id`) REFERENCES `power_and_utilities`.`transmission`.`balancing_authority`(`balancing_authority_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`constrained_element` ADD CONSTRAINT `fk_transmission_constrained_element_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`constrained_element` ADD CONSTRAINT `fk_transmission_constrained_element_to_transmission_substation_id` FOREIGN KEY (`to_transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`constrained_element` ADD CONSTRAINT `fk_transmission_constrained_element_associated_constrained_element_id` FOREIGN KEY (`associated_constrained_element_id`) REFERENCES `power_and_utilities`.`transmission`.`constrained_element`(`constrained_element_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`flowgate` ADD CONSTRAINT `fk_transmission_flowgate_balancing_authority_id` FOREIGN KEY (`balancing_authority_id`) REFERENCES `power_and_utilities`.`transmission`.`balancing_authority`(`balancing_authority_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`flowgate` ADD CONSTRAINT `fk_transmission_flowgate_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`flowgate` ADD CONSTRAINT `fk_transmission_flowgate_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `power_and_utilities`.`transmission`.`operator`(`operator_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`flowgate` ADD CONSTRAINT `fk_transmission_flowgate_to_substation_id` FOREIGN KEY (`to_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`flowgate` ADD CONSTRAINT `fk_transmission_flowgate_associated_flowgate_id` FOREIGN KEY (`associated_flowgate_id`) REFERENCES `power_and_utilities`.`transmission`.`flowgate`(`flowgate_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`contingency_scenario` ADD CONSTRAINT `fk_transmission_contingency_scenario_base_contingency_scenario_id` FOREIGN KEY (`base_contingency_scenario_id`) REFERENCES `power_and_utilities`.`transmission`.`contingency_scenario`(`contingency_scenario_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` ADD CONSTRAINT `fk_transmission_control_area_parent_control_area_id` FOREIGN KEY (`parent_control_area_id`) REFERENCES `power_and_utilities`.`transmission`.`control_area`(`control_area_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ADD CONSTRAINT `fk_transmission_balancing_authority_counterparty_balancing_authority_id` FOREIGN KEY (`counterparty_balancing_authority_id`) REFERENCES `power_and_utilities`.`transmission`.`balancing_authority`(`balancing_authority_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ADD CONSTRAINT `fk_transmission_control_center_backup_control_center_id` FOREIGN KEY (`backup_control_center_id`) REFERENCES `power_and_utilities`.`transmission`.`control_center`(`control_center_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ADD CONSTRAINT `fk_transmission_control_center_balancing_authority_id` FOREIGN KEY (`balancing_authority_id`) REFERENCES `power_and_utilities`.`transmission`.`balancing_authority`(`balancing_authority_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`bus` ADD CONSTRAINT `fk_transmission_bus_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `power_and_utilities`.`transmission`.`control_area`(`control_area_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`bus` ADD CONSTRAINT `fk_transmission_bus_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `power_and_utilities`.`transmission`.`operator`(`operator_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`bus` ADD CONSTRAINT `fk_transmission_bus_transmission_substation_id` FOREIGN KEY (`transmission_substation_id`) REFERENCES `power_and_utilities`.`transmission`.`transmission_substation`(`transmission_substation_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ADD CONSTRAINT `fk_transmission_operator_control_area_id` FOREIGN KEY (`control_area_id`) REFERENCES `power_and_utilities`.`transmission`.`control_area`(`control_area_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ADD CONSTRAINT `fk_transmission_operator_authorizing_operator_id` FOREIGN KEY (`authorizing_operator_id`) REFERENCES `power_and_utilities`.`transmission`.`operator`(`operator_id`);
ALTER TABLE `power_and_utilities`.`transmission`.`crew` ADD CONSTRAINT `fk_transmission_crew_relieved_crew_id` FOREIGN KEY (`relieved_crew_id`) REFERENCES `power_and_utilities`.`transmission`.`crew`(`crew_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities`.`transmission` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities`.`transmission` SET TAGS ('dbx_domain' = 'transmission');
ALTER TABLE `power_and_utilities`.`transmission`.`line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`line` SET TAGS ('dbx_subdomain' = 'asset_infrastructure');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Line Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Conductor Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `bus_id` SET TAGS ('dbx_business_glossary_term' = 'From Bus Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `to_transmission_substation_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'From Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `available_transfer_capability_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Transfer Capability (ATC) (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `bes_classified` SET TAGS ('dbx_business_glossary_term' = 'Bulk Electric System (BES) Classification Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `circuit_configuration` SET TAGS ('dbx_business_glossary_term' = 'Circuit Configuration');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `circuit_configuration` SET TAGS ('dbx_value_regex' = 'single_circuit|double_circuit|multi_circuit');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `co_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Co-Owner Name');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `commissioning_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Cost (USD)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `commissioning_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `depreciation_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate (Percent)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `depreciation_rate_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `emergency_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Emergency Thermal Rating (MVA)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `ems_element_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Management System (EMS) Element ID');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `ferc_jurisdictional` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Jurisdictional Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature ID');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `insulation_type` SET TAGS ('dbx_business_glossary_term' = 'Insulation Type');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `insulation_type` SET TAGS ('dbx_value_regex' = 'ceramic|glass|polymer|XLPE|oil_paper');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `interconnection_type` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Type');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `interconnection_type` SET TAGS ('dbx_value_regex' = 'intra_utility|inter_utility|interstate|international');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `length_miles` SET TAGS ('dbx_business_glossary_term' = 'Line Length (Miles)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Code');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Name');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `line_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Type');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `line_type` SET TAGS ('dbx_value_regex' = 'overhead|underground|submarine');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `multi_state_flag` SET TAGS ('dbx_business_glossary_term' = 'Multi-State Line Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `nerc_cip_applicable` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Critical Infrastructure Protection (CIP) Applicable Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `number_of_structures` SET TAGS ('dbx_business_glossary_term' = 'Number of Structures');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `operating_status` SET TAGS ('dbx_business_glossary_term' = 'Operating Status');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `operating_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|mothballed|retired|under_construction|planned');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `rated_capacity_mva` SET TAGS ('dbx_business_glossary_term' = 'Rated Thermal Capacity (MVA)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `reactance_ohms_per_mile` SET TAGS ('dbx_business_glossary_term' = 'Reactance (Ohms per Mile)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `resistance_ohms_per_mile` SET TAGS ('dbx_business_glossary_term' = 'Resistance (Ohms per Mile)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `right_of_way_width_ft` SET TAGS ('dbx_business_glossary_term' = 'Right-of-Way (ROW) Width (Feet)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization / Independent System Operator (RTO/ISO) Region');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `scada_monitored` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Monitored Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `structure_type` SET TAGS ('dbx_business_glossary_term' = 'Structure Type');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `structure_type` SET TAGS ('dbx_value_regex' = 'lattice_steel|monopole_steel|wood_pole|concrete_pole|H_frame');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `total_transfer_capability_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Capability (TTC) (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `voltage_class_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class (kV)');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `wam_asset_reference` SET TAGS ('dbx_business_glossary_term' = 'Work and Asset Management (WAM) Asset ID');
ALTER TABLE `power_and_utilities`.`transmission`.`line` ALTER COLUMN `year_constructed` SET TAGS ('dbx_business_glossary_term' = 'Year Constructed');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` SET TAGS ('dbx_subdomain' = 'asset_infrastructure');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation ID');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Asset Management (EAM) Asset ID');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `operator_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `bes_flag` SET TAGS ('dbx_business_glossary_term' = 'Bulk Electric System (BES) Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `bus_configuration` SET TAGS ('dbx_business_glossary_term' = 'Bus Configuration');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `bus_configuration` SET TAGS ('dbx_value_regex' = 'single_bus|double_bus|ring_bus|breaker_and_half|main_and_transfer|double_bus_double_breaker');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `communications_type` SET TAGS ('dbx_business_glossary_term' = 'Communications Type');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `communications_type` SET TAGS ('dbx_value_regex' = 'fiber_optic|microwave|power_line_carrier|leased_line|satellite|cellular');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `elevation_m` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Meters)');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `ems_node_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Management System (EMS) Node Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `ferc_account_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Account Number');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `ferc_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `ferc_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `ferc_jurisdiction_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Jurisdiction Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature ID');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `installed_capacity_mva` SET TAGS ('dbx_business_glossary_term' = 'Installed Transformer Capacity (MVA)');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `land_ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Land Ownership Type');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `land_ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|easement|right_of_way|licensed');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `nerc_cip_classification` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation Critical Infrastructure Protection (NERC CIP) Classification');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `nerc_cip_classification` SET TAGS ('dbx_value_regex' = 'high_impact|medium_impact|low_impact|not_applicable');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `nerc_cip_classification` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `nerc_node_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Node ID');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `next_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Maintenance Date');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `num_transformer_banks` SET TAGS ('dbx_business_glossary_term' = 'Number of Transformer Banks');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `num_transmission_lines` SET TAGS ('dbx_business_glossary_term' = 'Number of Transmission Lines');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `operating_status` SET TAGS ('dbx_business_glossary_term' = 'Operating Status');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `operating_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|under_construction|mothballed|decommissioned');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `original_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Original Cost (USD)');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `original_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `owner_name` SET TAGS ('dbx_business_glossary_term' = 'Owner Name');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `physical_address` SET TAGS ('dbx_business_glossary_term' = 'Physical Address');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `physical_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `physical_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_value_regex' = 'differential|distance|overcurrent|pilot|directional_comparison|line_current_differential');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization / Independent System Operator (RTO/ISO) Region');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `scada_point_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Point Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `state_code` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `state_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `substation_code` SET TAGS ('dbx_business_glossary_term' = 'Substation Code');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `substation_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]{2,20}$');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `substation_name` SET TAGS ('dbx_business_glossary_term' = 'Substation Name');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `substation_type` SET TAGS ('dbx_business_glossary_term' = 'Substation Type');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `substation_type` SET TAGS ('dbx_value_regex' = 'switching|step_down|step_up|converter|autotransformer|distribution_substation');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `transmission_zone` SET TAGS ('dbx_business_glossary_term' = 'Transmission Zone');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `voltage_high_kv` SET TAGS ('dbx_business_glossary_term' = 'High-Side Voltage (kV)');
ALTER TABLE `power_and_utilities`.`transmission`.`transmission_substation` ALTER COLUMN `voltage_low_kv` SET TAGS ('dbx_business_glossary_term' = 'Low-Side Voltage (kV)');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` SET TAGS ('dbx_subdomain' = 'asset_infrastructure');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Transformer ID');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `bus_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Bus Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation ID');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `cooling_class` SET TAGS ('dbx_business_glossary_term' = 'Cooling Class (IEC/IEEE Designation)');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `cooling_class` SET TAGS ('dbx_value_regex' = 'ONAN|ONAF|OFAN|OFAF|ODAF|ODAN');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `dga_baseline_date` SET TAGS ('dbx_business_glossary_term' = 'Dissolved Gas Analysis (DGA) Baseline Date');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `dga_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Dissolved Gas Analysis (DGA) Condition Code');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `dga_condition_code` SET TAGS ('dbx_value_regex' = 'normal|caution|warning|critical');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_business_glossary_term' = 'FERC Uniform System of Accounts Code');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Rated Frequency (Hz)');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `hv_kv_rating` SET TAGS ('dbx_business_glossary_term' = 'High-Voltage (HV) Winding Kilovolt (kV) Rating');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `impedance_pct` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Impedance Percentage (%)');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `is_bes_asset` SET TAGS ('dbx_business_glossary_term' = 'Bulk Electric System (BES) Asset Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `lv_kv_rating` SET TAGS ('dbx_business_glossary_term' = 'Low-Voltage (LV) Winding Kilovolt (kV) Rating');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `manufacture_year` SET TAGS ('dbx_business_glossary_term' = 'Year of Manufacture');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `maximo_asset_num` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Number');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `mva_rating_nameplate` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Megavolt-Ampere (MVA) Rating');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `mva_rating_ultimate` SET TAGS ('dbx_business_glossary_term' = 'Ultimate Megavolt-Ampere (MVA) Rating');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `nerc_cip_asset_class` SET TAGS ('dbx_business_glossary_term' = 'NERC Critical Infrastructure Protection (CIP) Asset Classification');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `nerc_cip_asset_class` SET TAGS ('dbx_value_regex' = 'high|medium|low|not_applicable');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Inspection Date');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `num_phases` SET TAGS ('dbx_business_glossary_term' = 'Number of Phases');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `oil_type` SET TAGS ('dbx_business_glossary_term' = 'Insulating Oil Type');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `oil_type` SET TAGS ('dbx_value_regex' = 'mineral_oil|FR3_natural_ester|silicone|askarel');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `oil_volume_gallons` SET TAGS ('dbx_business_glossary_term' = 'Insulating Oil Volume (Gallons)');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|spare|retired|under_maintenance|commissioning');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `protection_zone` SET TAGS ('dbx_business_glossary_term' = 'Protection Zone Designation');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Serial Number');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `tap_changer_type` SET TAGS ('dbx_business_glossary_term' = 'Tap Changer Type');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `tap_changer_type` SET TAGS ('dbx_value_regex' = 'LTC|fixed|DETC');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `tap_position_max` SET TAGS ('dbx_business_glossary_term' = 'Maximum Tap Position');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `tap_position_min` SET TAGS ('dbx_business_glossary_term' = 'Minimum Tap Position');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `tap_position_nominal` SET TAGS ('dbx_business_glossary_term' = 'Nominal Tap Position');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `transformer_name` SET TAGS ('dbx_business_glossary_term' = 'Transformer Name');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `transformer_type` SET TAGS ('dbx_business_glossary_term' = 'Transformer Type');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `transformer_type` SET TAGS ('dbx_value_regex' = 'power_transformer|autotransformer|phase_shifting_transformer|grounding_transformer');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `tv_kv_rating` SET TAGS ('dbx_business_glossary_term' = 'Tertiary Voltage (TV) Winding Kilovolt (kV) Rating');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `voltage_class` SET TAGS ('dbx_business_glossary_term' = 'Transmission Voltage Class');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `weight_lbs` SET TAGS ('dbx_business_glossary_term' = 'Total Weight (Pounds)');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `winding_configuration` SET TAGS ('dbx_business_glossary_term' = 'Winding Configuration');
ALTER TABLE `power_and_utilities`.`transmission`.`transformer` ALTER COLUMN `winding_configuration` SET TAGS ('dbx_value_regex' = 'delta_wye|wye_wye|delta_delta|wye_delta|auto');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` SET TAGS ('dbx_subdomain' = 'asset_infrastructure');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `grid_topology_id` SET TAGS ('dbx_business_glossary_term' = 'Grid Topology ID');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `contingency_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Contingency Scenario Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `previous_version_grid_topology_id` SET TAGS ('dbx_business_glossary_term' = 'Previous Topology Version ID');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Model Approved By');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Model Approval Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `branch_count` SET TAGS ('dbx_business_glossary_term' = 'Branch Count');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `bus_count` SET TAGS ('dbx_business_glossary_term' = 'Bus Count');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Topology Change Description');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `contingency_type` SET TAGS ('dbx_business_glossary_term' = 'Contingency Type');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `contingency_type` SET TAGS ('dbx_value_regex' = 'N-0|N-1|N-2|N-k|extreme_event');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `effective_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Topology Effective End Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `effective_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Topology Effective Start Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `ems_model_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Management System (EMS) Model Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `ems_model_sync_status` SET TAGS ('dbx_business_glossary_term' = 'Energy Management System (EMS) Model Synchronization Status');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `ems_model_sync_status` SET TAGS ('dbx_value_regex' = 'synchronized|out_of_sync|pending_sync|sync_failed');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `generator_count` SET TAGS ('dbx_business_glossary_term' = 'Generator Count');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `is_base_case` SET TAGS ('dbx_business_glossary_term' = 'Base Case Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `is_cip_applicable` SET TAGS ('dbx_business_glossary_term' = 'NERC Critical Infrastructure Protection (CIP) Applicability Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `is_nerc_bes` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Bulk Electric System (BES) Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `load_count` SET TAGS ('dbx_business_glossary_term' = 'Load Count');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `model_change_reason` SET TAGS ('dbx_business_glossary_term' = 'Model Change Reason');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `model_type` SET TAGS ('dbx_business_glossary_term' = 'Network Model Type');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `model_type` SET TAGS ('dbx_value_regex' = 'bus_branch|node_breaker');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `model_version_notes` SET TAGS ('dbx_business_glossary_term' = 'Model Version Notes');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `nerc_reliability_region` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reliability Region');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `nerc_reliability_region` SET TAGS ('dbx_value_regex' = 'MRO|NPCC|RF|SERC|Texas RE|WECC');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `network_island_code` SET TAGS ('dbx_business_glossary_term' = 'Network Island Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `peak_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Peak Load (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `power_flow_solution_status` SET TAGS ('dbx_business_glossary_term' = 'Power Flow Solution Status');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `power_flow_solution_status` SET TAGS ('dbx_value_regex' = 'converged|diverged|not_run|infeasible');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization / Independent System Operator (RTO/ISO) Region');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `seasonal_period` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Study Period');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `seasonal_period` SET TAGS ('dbx_value_regex' = 'summer_peak|winter_peak|spring_light_load|fall_light_load|annual');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `snapshot_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Topology Snapshot Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ABB_EMS|GE_EMS|PSSE|PSLF|manual');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `state_estimator_status` SET TAGS ('dbx_business_glossary_term' = 'State Estimator Solution Status');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `state_estimator_status` SET TAGS ('dbx_value_regex' = 'converged|diverged|not_run|flat_start|initializing');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `study_model_file_reference` SET TAGS ('dbx_business_glossary_term' = 'Study Model File Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `study_year` SET TAGS ('dbx_business_glossary_term' = 'Study Year');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `topology_name` SET TAGS ('dbx_business_glossary_term' = 'Topology Model Name');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `topology_status` SET TAGS ('dbx_business_glossary_term' = 'Topology Model Status');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `topology_status` SET TAGS ('dbx_value_regex' = 'active|archived|draft|superseded|under_review');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `topology_version_number` SET TAGS ('dbx_business_glossary_term' = 'Topology Version Number');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `topology_version_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-.]{1,50}$');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `total_installed_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Installed Generation Capacity (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `total_line_length_miles` SET TAGS ('dbx_business_glossary_term' = 'Total Transmission Line Length (Miles)');
ALTER TABLE `power_and_utilities`.`transmission`.`grid_topology` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Nominal Voltage Level (kV)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `transfer_capability_id` SET TAGS ('dbx_business_glossary_term' = 'Transfer Capability Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'From Control Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `grid_topology_id` SET TAGS ('dbx_business_glossary_term' = 'Base Case Topology Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `superseded_by_transfer_capability_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Transmission Capacity ID');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `atc_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Transfer Capability (ATC) in Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `atc_status` SET TAGS ('dbx_business_glossary_term' = 'ATC Posting Status');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `atc_status` SET TAGS ('dbx_value_regex' = 'POSTED|REVISED|SUPERSEDED|WITHDRAWN|PENDING');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `binding_constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Binding Constraint Type');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `binding_constraint_type` SET TAGS ('dbx_value_regex' = 'THERMAL|VOLTAGE|STABILITY|LOOP_FLOW|OTHER');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `calculation_engine` SET TAGS ('dbx_business_glossary_term' = 'ATC Calculation Engine');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `cbm_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity Benefit Margin (CBM) in Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'ATC Calculation Comments');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `contingency_set` SET TAGS ('dbx_business_glossary_term' = 'Contingency Set Applied');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Transfer Direction');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'FORWARD|REVERSE');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `existing_commitments_mw` SET TAGS ('dbx_business_glossary_term' = 'Existing Transmission Commitments (ETC) in Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `horizon_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Horizon End Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `horizon_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Horizon Start Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `is_coordinated_path` SET TAGS ('dbx_business_glossary_term' = 'Coordinated Transmission Path Indicator');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `is_firm_service` SET TAGS ('dbx_business_glossary_term' = 'Firm Transmission Service Indicator');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `loop_flow_adjustment_mw` SET TAGS ('dbx_business_glossary_term' = 'Loop Flow Adjustment in Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `nerc_cip_applicable` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Applicability Indicator');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `nerc_mod_methodology` SET TAGS ('dbx_business_glossary_term' = 'NERC MOD Calculation Methodology');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `nerc_mod_methodology` SET TAGS ('dbx_value_regex' = 'MOD-028|MOD-029|MOD-030');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `oasis_posting_reference` SET TAGS ('dbx_business_glossary_term' = 'OASIS Posting Reference Number');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `oatt_tariff_rate_schedule` SET TAGS ('dbx_business_glossary_term' = 'Open Access Transmission Tariff (OATT) Rate Schedule');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `path_flowgate_code` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path / Flowgate Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `path_flowgate_name` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path / Flowgate Name');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `pending_commitments_mw` SET TAGS ('dbx_business_glossary_term' = 'Pending Transmission Commitments in Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'OASIS Posting Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `recalculation_trigger` SET TAGS ('dbx_business_glossary_term' = 'ATC Recalculation Trigger');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `recalculation_trigger` SET TAGS ('dbx_value_regex' = 'TOPOLOGY_CHANGE|SCHEDULE_UPDATE|TLR_EVENT|PERIODIC|MANUAL|OUTAGE_UPDATE');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Region');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ABB_EMS|GE_EMS|OASIS_PORTAL|ATC_ENGINE|MANUAL');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `stability_limit_mw` SET TAGS ('dbx_business_glossary_term' = 'Stability Limit in Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `study_analyst` SET TAGS ('dbx_business_glossary_term' = 'ATC Study Analyst');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `study_horizon` SET TAGS ('dbx_business_glossary_term' = 'ATC Study Horizon');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `study_horizon` SET TAGS ('dbx_value_regex' = 'HOURLY|DAILY|WEEKLY|MONTHLY');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `thermal_limit_mw` SET TAGS ('dbx_business_glossary_term' = 'Thermal Rating Limit in Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `tlr_level` SET TAGS ('dbx_business_glossary_term' = 'Transmission Loading Relief (TLR) Level');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `to_area` SET TAGS ('dbx_business_glossary_term' = 'To Control Area / Balancing Authority');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `transmission_provider` SET TAGS ('dbx_business_glossary_term' = 'Transmission Provider Name');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `trm_mw` SET TAGS ('dbx_business_glossary_term' = 'Transmission Reliability Margin (TRM) in Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `ttc_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Transfer Capability (TTC) in Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Nominal Voltage (kV)');
ALTER TABLE `power_and_utilities`.`transmission`.`transfer_capability` ALTER COLUMN `voltage_limit_mw` SET TAGS ('dbx_business_glossary_term' = 'Voltage Stability Limit in Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `interchange_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Interchange Schedule ID');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `balancing_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Balancing Authority (BA) ID');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Power Purchase Agreement (PPA) Contract ID');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Node ID');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `rto_iso_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `transmission_right_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Right ID');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `actual_mw` SET TAGS ('dbx_business_glossary_term' = 'Actual Interchange Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `checkout_status` SET TAGS ('dbx_business_glossary_term' = 'Checkout Status');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `checkout_status` SET TAGS ('dbx_value_regex' = 'confirmed|denied|pending');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `curtailed_mw` SET TAGS ('dbx_business_glossary_term' = 'Curtailed Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `curtailment_flag` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `curtailment_priority` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Priority');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `energy_mwh` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Energy (MWh)');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `etag_reference_number` SET TAGS ('dbx_business_glossary_term' = 'e-Tag Reference Number');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `ferc_eqr_reportable` SET TAGS ('dbx_business_glossary_term' = 'FERC Electric Quarterly Report (EQR) Reportable Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `inadvertent_mw` SET TAGS ('dbx_business_glossary_term' = 'Inadvertent Interchange Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `interval_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration (Minutes)');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `interval_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Interval End Datetime');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `interval_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Interval Start Datetime');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `is_dynamic_transfer` SET TAGS ('dbx_business_glossary_term' = 'Dynamic Transfer Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'DAM|RTM|bilateral');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `nerc_bal006_reportable` SET TAGS ('dbx_business_glossary_term' = 'NERC BAL-006 Reportable Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `nerc_etag_number` SET TAGS ('dbx_business_glossary_term' = 'NERC e-Tag ID');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `operating_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Date');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `operating_hour` SET TAGS ('dbx_business_glossary_term' = 'Operating Hour');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `ramp_rate_mw_per_min` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate (MW/min)');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `schedule_confirmed_datetime` SET TAGS ('dbx_business_glossary_term' = 'Schedule Confirmed Datetime');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Interchange Schedule Number');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `schedule_submitted_datetime` SET TAGS ('dbx_business_glossary_term' = 'Schedule Submitted Datetime');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Interchange Schedule Type');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'import|export|wheel_through|dynamic_transfer');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `schedule_version` SET TAGS ('dbx_business_glossary_term' = 'Schedule Version');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `scheduled_mw` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `scheduling_entity_code` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Entity Code');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'unsettled|settled|disputed|adjusted');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `sink_ba_code` SET TAGS ('dbx_business_glossary_term' = 'Sink Balancing Authority (BA) Code');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `source_ba_code` SET TAGS ('dbx_business_glossary_term' = 'Source Balancing Authority (BA) Code');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ABB_EMS|GE_EMS|OATI_webTrans|RTO_portal|manual');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `transmission_path` SET TAGS ('dbx_business_glossary_term' = 'Transmission Path');
ALTER TABLE `power_and_utilities`.`transmission`.`interchange_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `service_request_id` SET TAGS ('dbx_business_glossary_term' = 'Service Request Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `interconnection_request_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Request Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Requesting Entity ID');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Receipt Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `approved_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Approved Transmission Capacity (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `atc_available_mw` SET TAGS ('dbx_business_glossary_term' = 'Available Transfer Capability (ATC) at Time of Request (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `curtailment_priority` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Priority');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `denial_reason` SET TAGS ('dbx_business_glossary_term' = 'Request Denial Reason');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `deposit_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Study Deposit Amount (USD)');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `deposit_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `deposit_received_date` SET TAGS ('dbx_business_glossary_term' = 'Study Deposit Received Date');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `estimated_upgrade_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Network Upgrade Cost (USD)');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `estimated_upgrade_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `facilities_study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Facilities Study Completion Date');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `facilities_study_status` SET TAGS ('dbx_business_glossary_term' = 'Facilities Study Status');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `facilities_study_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|complete|waived');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `feasibility_study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Completion Date');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `feasibility_study_status` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Status');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `feasibility_study_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|complete|waived');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `ferc_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Filing Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `firmness_indicator` SET TAGS ('dbx_business_glossary_term' = 'Service Firmness Indicator');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `firmness_indicator` SET TAGS ('dbx_value_regex' = 'firm|non_firm');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `nerc_path_designation` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Path Designation');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `oasis_queue_number` SET TAGS ('dbx_business_glossary_term' = 'Open Access Same-Time Information System (OASIS) Queue Number');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `point_of_delivery` SET TAGS ('dbx_business_glossary_term' = 'Point of Delivery (POD)');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `request_notes` SET TAGS ('dbx_business_glossary_term' = 'Request Notes');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Request Status');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `requested_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Requested Transmission Capacity (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service End Date');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Start Date');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `requesting_entity_duns` SET TAGS ('dbx_business_glossary_term' = 'Requesting Entity Data Universal Numbering System (DUNS) Number');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `requesting_entity_duns` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `requesting_entity_duns` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `requesting_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Entity Name');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `requesting_entity_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization / Independent System Operator (RTO/ISO) Region');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `service_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Agreement Number');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `service_term_type` SET TAGS ('dbx_business_glossary_term' = 'Service Term Type');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `service_term_type` SET TAGS ('dbx_value_regex' = 'short_term|long_term|monthly|annual|multi_year');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Type');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'firm_ptp|non_firm_ptp|nits|secondary_network|other');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `sink_load_name` SET TAGS ('dbx_business_glossary_term' = 'Sink Load Name');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `source_resource_name` SET TAGS ('dbx_business_glossary_term' = 'Source Generation Resource Name');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `system_impact_study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'System Impact Study (SIS) Completion Date');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `system_impact_study_status` SET TAGS ('dbx_business_glossary_term' = 'System Impact Study (SIS) Status');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `system_impact_study_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|complete|waived');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `tariff_rate_schedule` SET TAGS ('dbx_business_glossary_term' = 'Open Access Transmission Tariff (OATT) Rate Schedule');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `transmission_provider_code` SET TAGS ('dbx_business_glossary_term' = 'Transmission Provider Code');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `transmission_rate_mw_per_year` SET TAGS ('dbx_business_glossary_term' = 'Transmission Rate (USD per MW per Year)');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `transmission_rate_mw_per_year` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`service_request` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Request Withdrawal Date');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `interconnection_request_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Request Identifier (ID)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `participant_registration_id` SET TAGS ('dbx_business_glossary_term' = 'Participant Registration Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `bus_id` SET TAGS ('dbx_business_glossary_term' = 'Poi Bus Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `regulatory_asset_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Entry Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `rto_iso_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Poi Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `actual_cod` SET TAGS ('dbx_business_glossary_term' = 'Actual Commercial Operation Date (COD)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Email Address');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Phone Number');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Legal Name');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `applicant_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `environmental_permit_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Status');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `environmental_permit_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `estimated_interconnection_facility_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Interconnection Facility Cost in United States Dollars (USD)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `estimated_interconnection_facility_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `estimated_network_upgrade_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Network Upgrade Cost in United States Dollars (USD)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `estimated_network_upgrade_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `facilities_study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Facilities Study Completion Date');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `facilities_study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Facilities Study Start Date');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `feasibility_study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Completion Date');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `feasibility_study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Start Date');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `interconnection_agreement_executed_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Executed Date');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `is_energy_only` SET TAGS ('dbx_business_glossary_term' = 'Energy Resource Interconnection Service Indicator');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `is_network_resource` SET TAGS ('dbx_business_glossary_term' = 'Network Resource Interconnection Service Indicator');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Request Notes');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `poi_latitude` SET TAGS ('dbx_business_glossary_term' = 'Point of Interconnection (POI) Latitude');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `poi_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `poi_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `poi_longitude` SET TAGS ('dbx_business_glossary_term' = 'Point of Interconnection (POI) Longitude');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `poi_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `poi_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Project Name');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Project Type');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'generation|load|storage');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `queue_position` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Queue Position');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Request Number');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `request_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `request_status` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Request Status');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `requested_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Requested Capacity in Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `requires_nerc_registration` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Registration Required Indicator');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `study_phase` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Study Phase');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `study_phase` SET TAGS ('dbx_value_regex' = 'pre_application|feasibility|system_impact|facilities|completed');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Request Submission Date');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `system_impact_study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'System Impact Study Completion Date');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `system_impact_study_start_date` SET TAGS ('dbx_business_glossary_term' = 'System Impact Study Start Date');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `target_cod` SET TAGS ('dbx_business_glossary_term' = 'Target Commercial Operation Date (COD)');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Generation Technology Type');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `transmission_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Transmission Owner Name');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `withdrawal_date` SET TAGS ('dbx_business_glossary_term' = 'Request Withdrawal Date');
ALTER TABLE `power_and_utilities`.`transmission`.`interconnection_request` ALTER COLUMN `withdrawal_reason` SET TAGS ('dbx_business_glossary_term' = 'Request Withdrawal Reason');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `congestion_event_id` SET TAGS ('dbx_business_glossary_term' = 'Congestion Event ID');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `constrained_element_id` SET TAGS ('dbx_business_glossary_term' = 'Constrained Element ID');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Constrained Pricing Node Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `flowgate_id` SET TAGS ('dbx_business_glossary_term' = 'Flowgate ID');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `lmp_price_id` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Congestion Component ID');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `outage_id` SET TAGS ('dbx_business_glossary_term' = 'Outage ID');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `regulatory_deferral_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Deferral Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `rto_iso_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `bes_element_flag` SET TAGS ('dbx_business_glossary_term' = 'Bulk Electric System (BES) Element Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `binding_constraint_flag` SET TAGS ('dbx_business_glossary_term' = 'Binding Constraint Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `congestion_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Congestion Cost United States Dollars (USD)');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `constraint_name` SET TAGS ('dbx_business_glossary_term' = 'Constraint Name');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `constraint_type` SET TAGS ('dbx_business_glossary_term' = 'Constraint Type');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `constraint_type` SET TAGS ('dbx_value_regex' = 'thermal|voltage|stability|contractual|other');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `contingency_element_name` SET TAGS ('dbx_business_glossary_term' = 'Contingency Element Name');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `curtailed_mw` SET TAGS ('dbx_business_glossary_term' = 'Curtailed Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Duration Hours');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `element_rating_mw` SET TAGS ('dbx_business_glossary_term' = 'Element Rating Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `event_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event End Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `event_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Start Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `event_status` SET TAGS ('dbx_business_glossary_term' = 'Event Status');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `event_status` SET TAGS ('dbx_value_regex' = 'active|resolved|monitoring|escalated');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `generation_redispatch_mw` SET TAGS ('dbx_business_glossary_term' = 'Generation Redispatch Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `interconnection_name` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Name');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `interconnection_name` SET TAGS ('dbx_value_regex' = 'Eastern|Western|ERCOT|Quebec');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `load_shed_mw` SET TAGS ('dbx_business_glossary_term' = 'Load Shed Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `market_interval_type` SET TAGS ('dbx_business_glossary_term' = 'Market Interval Type');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `market_interval_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|intra_day');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `monitored_element_name` SET TAGS ('dbx_business_glossary_term' = 'Monitored Element Name');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `nerc_region` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Region');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `outage_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Related Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `post_contingency_flow_mw` SET TAGS ('dbx_business_glossary_term' = 'Post-Contingency Flow Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `pre_contingency_flow_mw` SET TAGS ('dbx_business_glossary_term' = 'Pre-Contingency Flow Megawatts (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `rating_type` SET TAGS ('dbx_business_glossary_term' = 'Rating Type');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `rating_type` SET TAGS ('dbx_value_regex' = 'normal|emergency|contingency');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_business_glossary_term' = 'Resolution Action');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `resolution_action` SET TAGS ('dbx_value_regex' = 'redispatch|tlr|switching|load_shed|topology_change|none');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `shadow_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Shadow Price per Megawatt-Hour (MWh)');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `tlr_level` SET TAGS ('dbx_business_glossary_term' = 'Transmission Loading Relief (TLR) Level');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level Kilovolts (kV)');
ALTER TABLE `power_and_utilities`.`transmission`.`congestion_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `outage_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `distribution_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Caused Distribution Outage Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `bus_id` SET TAGS ('dbx_business_glossary_term' = 'From Bus Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `opex_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Opex Transaction Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Outaged Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Outaged Transformer Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Outage Approval Status');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|conditional');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Outage Cause Code');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Outage Cause Description');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `contingency_analysis_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Contingency Analysis Performed Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `coordinator` SET TAGS ('dbx_business_glossary_term' = 'Outage Coordinator');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `customers_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Affected Count');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Hours)');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `load_impact_mw` SET TAGS ('dbx_business_glossary_term' = 'Load Impact (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `nerc_region` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Region');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `nerc_tads_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Transmission Availability Data System (TADS) Reporting Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Outage Notes');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `outage_number` SET TAGS ('dbx_business_glossary_term' = 'Outage Number');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `outage_status` SET TAGS ('dbx_business_glossary_term' = 'Outage Status');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `outage_status` SET TAGS ('dbx_value_regex' = 'scheduled|active|restored|cancelled|deferred');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_business_glossary_term' = 'Outage Type');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `outage_type` SET TAGS ('dbx_value_regex' = 'planned|forced|maintenance|emergency');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `restoration_priority` SET TAGS ('dbx_business_glossary_term' = 'Restoration Priority');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `restoration_priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `rto_iso_notification_reference` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Notification Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `switching_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `to_bus_code` SET TAGS ('dbx_business_glossary_term' = 'To Bus Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV)');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `power_and_utilities`.`transmission`.`outage` ALTER COLUMN `work_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Order Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` SET TAGS ('dbx_subdomain' = 'asset_infrastructure');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `nerc_cip_asset_id` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Asset ID');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `capex_expenditure_id` SET TAGS ('dbx_business_glossary_term' = 'Capex Expenditure Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `control_center_id` SET TAGS ('dbx_business_glossary_term' = 'Control Center ID');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation ID');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `applicable_cip_standards` SET TAGS ('dbx_business_glossary_term' = 'Applicable CIP Standards');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `asset_owner` SET TAGS ('dbx_business_glossary_term' = 'Asset Owner');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `bes_cyber_system_identifier` SET TAGS ('dbx_business_glossary_term' = 'Bulk Electric System (BES) Cyber System Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `cip_version` SET TAGS ('dbx_business_glossary_term' = 'CIP Version');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|remediation_in_progress|pending_review');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `configuration_baseline_reference` SET TAGS ('dbx_business_glossary_term' = 'Configuration Baseline Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `criticality_score` SET TAGS ('dbx_business_glossary_term' = 'Criticality Score');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `cyber_security_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Cyber Security Incident Count');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `esp_identifier` SET TAGS ('dbx_business_glossary_term' = 'Electronic Security Perimeter (ESP) Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `esp_membership` SET TAGS ('dbx_business_glossary_term' = 'Electronic Security Perimeter (ESP) Membership');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `evidence_artifact_reference` SET TAGS ('dbx_business_glossary_term' = 'Evidence Artifact Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Firmware Version');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `impact_rating` SET TAGS ('dbx_business_glossary_term' = 'Impact Rating');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `impact_rating` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_business_glossary_term' = 'IP Address');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `ip_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `last_cip_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last CIP Audit Date');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `last_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Last Incident Date');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `last_vulnerability_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Vulnerability Assessment Date');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `network_zone` SET TAGS ('dbx_business_glossary_term' = 'Network Zone');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `next_cip_audit_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next CIP Audit Due Date');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `next_vulnerability_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Vulnerability Assessment Due Date');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `physical_security_assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Physical Security Assessment Date');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `psp_identifier` SET TAGS ('dbx_business_glossary_term' = 'Physical Security Perimeter (PSP) Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `psp_membership` SET TAGS ('dbx_business_glossary_term' = 'Physical Security Perimeter (PSP) Membership');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `remediation_plan_reference` SET TAGS ('dbx_business_glossary_term' = 'Remediation Plan Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `responsible_entity` SET TAGS ('dbx_business_glossary_term' = 'Responsible Entity');
ALTER TABLE `power_and_utilities`.`transmission`.`nerc_cip_asset` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `tariff_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rate Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Receipt Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `allowed_roe_percent` SET TAGS ('dbx_business_glossary_term' = 'Allowed Return on Equity (ROE) Percent');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `ancillary_service_rate` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Rate');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `approving_authority` SET TAGS ('dbx_business_glossary_term' = 'Approving Authority');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `approving_authority` SET TAGS ('dbx_value_regex' = 'FERC|state_puc|rto_iso|internal');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `congestion_charge_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'Congestion Charge Applicable Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `demand_charge_per_kw_month` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge per Kilowatt (kW) per Month');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `discount_policy_flag` SET TAGS ('dbx_business_glossary_term' = 'Discount Policy Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `energy_charge_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Charge per Megawatt-Hour (MWh)');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `ferc_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Docket Number');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `ferc_docket_number` SET TAGS ('dbx_value_regex' = '^(ER|EL|RM)[0-9]{2}-[0-9]{3,5}(-[0-9]{3})?$');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `last_rate_case_date` SET TAGS ('dbx_business_glossary_term' = 'Last Rate Case Date');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `loss_compensation_percent` SET TAGS ('dbx_business_glossary_term' = 'Loss Compensation Percent');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `loss_compensation_percent` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `loss_compensation_percent` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `maximum_reservation_kw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Reservation in Kilowatts (kW)');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `minimum_reservation_kw` SET TAGS ('dbx_business_glossary_term' = 'Minimum Reservation in Kilowatts (kW)');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `nerc_region_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Region Code');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `next_rate_case_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Next Rate Case Scheduled Date');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `point_of_delivery` SET TAGS ('dbx_business_glossary_term' = 'Point of Delivery');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_business_glossary_term' = 'Rate Basis');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `rate_basis` SET TAGS ('dbx_value_regex' = 'cost_of_service|market_based|formula_rate|negotiated|stated_rate');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `rate_pancaking_flag` SET TAGS ('dbx_business_glossary_term' = 'Rate Pancaking Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'network|point_to_point|ancillary_service|generator_interconnection|reactive_supply|black_start');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `rate_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Zone Code');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `rate_zone_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,10}$');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `reactive_supply_charge` SET TAGS ('dbx_business_glossary_term' = 'Reactive Supply and Voltage Control Charge');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `rollover_rights_flag` SET TAGS ('dbx_business_glossary_term' = 'Rollover Rights Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `rto_iso_code` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) Code');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `scheduling_coordination_charge` SET TAGS ('dbx_business_glossary_term' = 'Scheduling, System Control, and Dispatch Charge');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `service_class` SET TAGS ('dbx_business_glossary_term' = 'Service Class');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `service_class` SET TAGS ('dbx_value_regex' = 'firm|non_firm|conditional_firm');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_IS_U|Oracle_CCB|FERC_eTariff|Manual_Entry');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `tariff_version` SET TAGS ('dbx_business_glossary_term' = 'Tariff Version');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `tariff_version` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}.[0-9]{1,3}(.[0-9]{1,3})?$');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `transmission_owner_code` SET TAGS ('dbx_business_glossary_term' = 'Transmission Owner Code');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `transmission_owner_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `power_and_utilities`.`transmission`.`tariff_rate` ALTER COLUMN `voltage_class_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class in Kilovolts (kV)');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `switching_order_id` SET TAGS ('dbx_business_glossary_term' = 'Switching Order ID');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Operator ID');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `operator_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Executing Crew ID');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `opex_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Opex Transaction Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `outage_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Outage ID');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Switched Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Switched Transformer Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation ID');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `superseded_switching_order_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `actual_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual End Date and Time');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `actual_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Date and Time');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `authorizing_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Operator Name');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `authorizing_operator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `bes_element_flag` SET TAGS ('dbx_business_glossary_term' = 'Bulk Electric System (BES) Element Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `cancellation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `clearance_tag_reference` SET TAGS ('dbx_business_glossary_term' = 'Clearance Tag Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `contingency_analysis_performed_flag` SET TAGS ('dbx_business_glossary_term' = 'Contingency Analysis Performed Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `control_area` SET TAGS ('dbx_business_glossary_term' = 'Control Area');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `ems_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Management System (EMS) Reference ID');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `executing_crew_name` SET TAGS ('dbx_business_glossary_term' = 'Executing Crew Name');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `load_impact_mw` SET TAGS ('dbx_business_glossary_term' = 'Load Impact (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `nerc_cip_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Applicable Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `nerc_iro_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'NERC IRO Compliance Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Notes');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `oms_reference` SET TAGS ('dbx_business_glossary_term' = 'Outage Management System (OMS) Reference ID');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Number');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Status');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|approved|in_progress|completed|cancelled|suspended');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Type');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'planned|emergency|maintenance|restoration|testing|commissioning');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `planned_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Planned End Date and Time');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `planned_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date and Time');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Priority');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|normal|low');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `requesting_operator_code` SET TAGS ('dbx_business_glossary_term' = 'Requesting Operator ID');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `requesting_operator_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `requesting_operator_name` SET TAGS ('dbx_business_glossary_term' = 'Requesting Operator Name');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `requesting_operator_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `rto_iso_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'RTO/ISO Notification Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `rto_iso_region` SET TAGS ('dbx_business_glossary_term' = 'RTO/ISO Region');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `safety_ground_placement` SET TAGS ('dbx_business_glossary_term' = 'Safety Ground Placement');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `substation_name` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Name');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `switching_sequence_steps` SET TAGS ('dbx_business_glossary_term' = 'Switching Sequence Steps');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `transfer_capability_impact_mw` SET TAGS ('dbx_business_glossary_term' = 'Transfer Capability Impact (MW)');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV)');
ALTER TABLE `power_and_utilities`.`transmission`.`switching_order` ALTER COLUMN `work_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Order Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` SET TAGS ('dbx_subdomain' = 'asset_infrastructure');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `protection_system_id` SET TAGS ('dbx_business_glossary_term' = 'Protection System Identifier (ID)');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `backup_protection_system_id` SET TAGS ('dbx_business_glossary_term' = 'Backup Protection System Identifier (ID)');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Asset Management (EAM) Asset Identifier (ID)');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Protected Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Protected Transformer Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Relay Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Identifier (ID)');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'dnp3|iec_61850|modbus|c37_118|proprietary|none');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `coordination_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Coordination Study Reference Document');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `ct_ratio` SET TAGS ('dbx_business_glossary_term' = 'Current Transformer (CT) Ratio');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `fault_record_count` SET TAGS ('dbx_business_glossary_term' = 'Fault Record Count');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Account Code');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `firmware_version` SET TAGS ('dbx_business_glossary_term' = 'Relay Firmware Version');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `is_bes_protection` SET TAGS ('dbx_business_glossary_term' = 'Bulk Electric System (BES) Protection Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `last_fault_date` SET TAGS ('dbx_business_glossary_term' = 'Last Fault Date');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `last_misoperation_date` SET TAGS ('dbx_business_glossary_term' = 'Last Misoperation Date');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `misoperation_count` SET TAGS ('dbx_business_glossary_term' = 'Misoperation Count');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `nerc_cip_applicable` SET TAGS ('dbx_business_glossary_term' = 'NERC Critical Infrastructure Protection (CIP) Applicable Flag');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `nerc_prc_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'NERC Protection and Control (PRC) Compliance Status');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `nerc_prc_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|exempted|not_applicable');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `next_calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Calibration Due Date');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Protection System Notes');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|testing|maintenance|retired|standby');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `original_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Original Cost in United States Dollars (USD)');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `original_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `protection_scheme_type` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme Type');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `protection_system_code` SET TAGS ('dbx_business_glossary_term' = 'Protection System Code');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `protection_system_name` SET TAGS ('dbx_business_glossary_term' = 'Protection System Name');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `protection_zone` SET TAGS ('dbx_business_glossary_term' = 'Protection Zone Designation');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `protection_zone` SET TAGS ('dbx_value_regex' = 'zone_1|zone_2|zone_3|zone_4|backup|remote_backup');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `pt_ratio` SET TAGS ('dbx_business_glossary_term' = 'Potential Transformer (PT) Ratio');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `relay_management_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Relay Management System Identifier (ID)');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `relay_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Relay Serial Number');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `scada_point_reference` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Point Reference');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `settings_last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Settings Last Modified Date');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `settings_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Settings Modified By User');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `trip_setting_reference` SET TAGS ('dbx_business_glossary_term' = 'Trip Setting Reference Document');
ALTER TABLE `power_and_utilities`.`transmission`.`protection_system` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level in Kilovolts (kV)');
ALTER TABLE `power_and_utilities`.`transmission`.`constrained_element` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`constrained_element` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`constrained_element` ALTER COLUMN `constrained_element_id` SET TAGS ('dbx_business_glossary_term' = 'Constrained Element Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`constrained_element` ALTER COLUMN `balancing_authority_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`constrained_element` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`constrained_element` ALTER COLUMN `to_transmission_substation_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`constrained_element` ALTER COLUMN `associated_constrained_element_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`flowgate` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`flowgate` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`flowgate` ALTER COLUMN `flowgate_id` SET TAGS ('dbx_business_glossary_term' = 'Flowgate Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`flowgate` ALTER COLUMN `rto_iso_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`flowgate` ALTER COLUMN `associated_flowgate_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`contingency_scenario` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`contingency_scenario` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`contingency_scenario` ALTER COLUMN `contingency_scenario_id` SET TAGS ('dbx_business_glossary_term' = 'Contingency Scenario Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`contingency_scenario` ALTER COLUMN `base_contingency_scenario_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` ALTER COLUMN `contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` ALTER COLUMN `contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_area` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `balancing_authority_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Authority Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `counterparty_balancing_authority_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`balancing_authority` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `control_center_id` SET TAGS ('dbx_business_glossary_term' = 'Control Center Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `balancing_authority_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `annual_operating_budget_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `disaster_recovery_site_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `emergency_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `emergency_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `primary_address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `primary_address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `primary_address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `primary_address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `primary_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `primary_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`control_center` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`bus` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`bus` SET TAGS ('dbx_subdomain' = 'asset_infrastructure');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `operator_id` SET TAGS ('dbx_business_glossary_term' = 'Operator Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `control_area_id` SET TAGS ('dbx_business_glossary_term' = 'Control Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `authorizing_operator_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `headquarters_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`operator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`transmission`.`crew` SET TAGS ('dbx_subdomain' = 'operational_coordination');
ALTER TABLE `power_and_utilities`.`transmission`.`crew` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier');
ALTER TABLE `power_and_utilities`.`transmission`.`crew` ALTER COLUMN `relieved_crew_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`crew` ALTER COLUMN `crew_lead_contact` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`crew` ALTER COLUMN `crew_lead_contact` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`crew` ALTER COLUMN `crew_lead_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`crew` ALTER COLUMN `crew_lead_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`crew` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`transmission`.`crew` ALTER COLUMN `overtime_rate` SET TAGS ('dbx_confidential' = 'true');
