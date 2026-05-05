-- Schema for Domain: asset | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`asset` COMMENT 'Enterprise asset management serving as the SSOT for all physical infrastructure assets across generation, T&D, gas systems, substations, and field equipment. Manages asset registry, lifecycle status, condition metrics, depreciation schedules, maintenance work orders, inspections, and CAPEX planning. Integrates with Maximo EAM and Esri ArcGIS for geospatial asset tracking. Supports ISO 55000 compliance and RAB reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`registry` (
    `registry_id` BIGINT COMMENT 'Primary key for registry',
    `asset_capex_project_id` BIGINT COMMENT 'Foreign key linking to asset.asset_capex_project. Business justification: An asset can be part of a capital project; many assets belong to one capex project, so add FK to capture project association.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Needed for Market Participation and NERC reporting; assets must be assigned to a balancing area to aggregate generation/load and calculate settlements.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Required for financial reporting: each asset must be assigned a Chart of Accounts to post capital expenditures and depreciation in the General Ledger.',
    `classification_id` BIGINT COMMENT 'Reference to the asset classification hierarchy defining the type and category of this asset (e.g., generation equipment, transmission line, distribution transformer, gas pipeline segment).',
    `control_zone_id` BIGINT COMMENT 'Foreign key linking to gridops.control_zone. Business justification: Operational dispatch and outage coordination require each asset to be mapped to its control zone for SCADA/EMS visibility and reliability analysis.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center responsible for this asset in the financial accounting structure. Used for O&M expense allocation.',
    `dsm_program_id` BIGINT COMMENT 'Foreign key linking to engagement.dsm_program. Business justification: REQUIRED: DSM enrollment tracks which assets (e.g., smart meters) participate in each DSM program for incentive calculation.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: REGULATORY: Asset inventory reports require linking each asset to its owning facility for compliance and maintenance planning.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: IT Asset Management: link physical asset to IT inventory for depreciation, cost allocation, and compliance reporting (Asset Capitalization Report).',
    `location_id` BIGINT COMMENT 'Reference to the geospatial location record defining where this asset is physically installed. Integrates with Esri ArcGIS for spatial tracking.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record in the supply chain domain defining technical specifications, procurement details, and material composition for this asset type.',
    `material_material_master_id` BIGINT COMMENT 'Reference to the material master record in the supply chain domain defining technical specifications, procurement details, and material composition for this asset type.',
    `ot_asset_id` BIGINT COMMENT 'Foreign key linking to technology.ot_asset. Business justification: OT Asset Integration: associate OT device record with master asset registry for lifecycle, compliance, and outage impact analysis (OT Asset Compliance Audit).',
    `parent_asset_registry_id` BIGINT COMMENT 'Reference to the parent asset in a hierarchical asset structure (e.g., a transformer within a substation, a meter on a service point). Nullable for top-level assets.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Required for the Program Enrollment Tracking report, which records which physical assets participate in incentive programs; utilities need this for regulatory compliance and incentive accounting.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: SCADA Assignment: each major asset (e.g., substation) is monitored by a specific SCADA system, required for operational monitoring and NERC CIP reporting.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: CAPEX: Site‑level asset registers support capital budgeting and outage management across generation or transmission sites.',
    `tech_project_id` BIGINT COMMENT 'Foreign key linking to technology.tech_project. Business justification: Technology Project Planning: associate physical assets with technology projects for budgeting, regulatory filing, and portfolio reporting.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Required for Asset Procurement & Warranty Management; linking each asset to its original supplying vendor enables warranty claim tracking and regulatory reporting of vendor‑specific compliance.',
    `vpp_agreement_id` BIGINT COMMENT 'Foreign key linking to engagement.vpp_agreement. Business justification: REQUIRED: VPP operations need to map each DER asset to its VPP agreement for dispatch scheduling and settlement reporting.',
    `wbs_element_id` BIGINT COMMENT 'Reference to the WBS element if this asset was constructed as part of a capital project. Links asset to CAPEX project tracking.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total accumulated depreciation charged against the asset since commissioning. Used for regulatory asset base calculations and financial reporting.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Original acquisition or construction cost of the asset in USD. Forms the basis for depreciation calculations and regulatory asset base reporting to state PUCs.',
    `asset_name` STRING COMMENT 'Human-readable name or title of the asset for identification and reporting purposes.',
    `asset_tag` STRING COMMENT 'Externally-known unique asset identification tag or number assigned to the physical infrastructure asset. Used for field identification and tracking.. Valid values are `^[A-Z0-9]{8,20}$`',
    `asset_type` STRING COMMENT 'High-level categorization of the asset type within the utility infrastructure. [ENUM-REF-CANDIDATE: generation_equipment|transmission_line|transmission_tower|distribution_line|distribution_pole|substation_equipment|transformer|circuit_breaker|capacitor_bank|gas_pipeline|gas_regulator|gas_meter|electric_meter|scada_device|protection_relay|switch|recloser|sectionalizer|conductor|cable|other — 21 candidates stripped; promote to reference product]',
    `capacity_unit` STRING COMMENT 'Unit of measure for the rated capacity value (Megawatt, Megavolt-Ampere, Thousand Cubic Feet, etc.). [ENUM-REF-CANDIDATE: MW|MVA|kVA|kW|MCF|MMCF|GPM|PSI — 8 candidates stripped; promote to reference product]',
    `commissioning_date` DATE COMMENT 'Date when the asset was commissioned and placed into active service. Marks the start of the operational lifecycle and depreciation period for RAB reporting.',
    `condition_rating` STRING COMMENT 'Qualitative condition rating based on inspection findings and condition score. Used for executive reporting and risk assessment.. Valid values are `excellent|good|fair|poor|critical`',
    `condition_score` DECIMAL(18,2) COMMENT 'Quantitative condition assessment score (typically 0-100 scale) based on inspections, testing, and predictive analytics. Drives maintenance prioritization and replacement decisions.',
    `criticality_rating` STRING COMMENT 'Business criticality rating indicating the impact of asset failure on operations, customer service, and safety. Drives maintenance prioritization and spare parts inventory.. Valid values are `critical|high|medium|low`',
    `current_book_value` DECIMAL(18,2) COMMENT 'Current net book value of the asset after accumulated depreciation. Updated through periodic depreciation runs and used for financial statement reporting.',
    `depreciation_method` STRING COMMENT 'Depreciation method applied to this asset as approved by the state PUC for rate base calculations.. Valid values are `straight_line|declining_balance|units_of_production|regulatory`',
    `disposal_date` DATE COMMENT 'Date when the retired asset was physically disposed of, sold, or scrapped. Final step in asset lifecycle for accounting closure.',
    `expected_useful_life_years` STRING COMMENT 'Expected useful life of the asset in years as defined by engineering standards and regulatory depreciation schedules. Used for CAPEX planning and depreciation calculations.',
    `ferc_account_code` STRING COMMENT 'Federal Energy Regulatory Commission Uniform System of Accounts code for asset classification and financial reporting. Required for FERC Form 1 submissions.. Valid values are `^[0-9]{3,6}$`',
    `gis_feature_code` STRING COMMENT 'Unique identifier in the Esri ArcGIS system linking this asset record to its geospatial feature representation for mapping and spatial analysis.',
    `in_service_date` DATE COMMENT 'Date when the asset entered revenue service. Critical for regulatory rate base calculations and depreciation schedules reported to state PUCs.',
    `installation_date` DATE COMMENT 'Date when the asset was physically installed at its location. Used for age-based maintenance planning and depreciation calculations.',
    `is_critical_infrastructure` BOOLEAN COMMENT 'Indicates whether this asset is designated as critical infrastructure under NERC CIP standards requiring enhanced cybersecurity and physical security controls.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection or condition assessment performed on the asset. Critical for compliance with NERC and OSHA inspection requirements.',
    `lifecycle_status` STRING COMMENT 'Current state of the asset in its lifecycle from planning through disposal. Critical for operational readiness and maintenance planning. [ENUM-REF-CANDIDATE: planned|ordered|in_transit|installed|commissioned|in_service|standby|out_of_service|retired|disposed — 10 candidates stripped; promote to reference product]',
    `maintenance_strategy` STRING COMMENT 'Assigned maintenance strategy defining how this asset is maintained (reactive, preventive, predictive, condition-based). Drives work order generation in Maximo.. Valid values are `reactive|preventive|predictive|condition_based|run_to_failure`',
    `manufacturer_name` STRING COMMENT 'Name of the company that manufactured the asset. Critical for warranty tracking and parts procurement.',
    `maximo_asset_number` STRING COMMENT 'Asset number in the Maximo Enterprise Asset Management system. Used for integration and work order management.',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for the asset. Used for technical specifications lookup and parts compatibility.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection based on regulatory requirements and maintenance schedules. Used for work order planning.',
    `operational_status` STRING COMMENT 'Current operational state indicating whether the asset is actively functioning and available for service.. Valid values are `operational|non_operational|under_maintenance|failed|testing`',
    `primary_voltage_kv` DECIMAL(18,2) COMMENT 'Primary side voltage in kilovolts for transformers and voltage conversion equipment.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'Nameplate rated capacity of the asset in its primary unit of measure (MW for generation, MVA for transformers, MCF for gas pipelines, etc.). Critical for load planning and grid operations.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset registry record was first created in the system. Audit trail for data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset registry record was last modified. Audit trail for change tracking and data quality monitoring.',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Estimated remaining useful life of the asset in years based on current condition assessments and maintenance history. Updated periodically for asset replacement planning.',
    `retirement_date` DATE COMMENT 'Date when the asset was retired from service. Marks the end of the operational lifecycle and triggers removal from the regulatory asset base.',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk score combining probability of failure (condition) and consequence of failure (criticality). Used for asset investment prioritization.',
    `scada_monitored_flag` BOOLEAN COMMENT 'Indicates whether this asset is monitored by the SCADA system for real-time operational data collection and remote control.',
    `secondary_voltage_kv` DECIMAL(18,2) COMMENT 'Secondary side voltage in kilovolts for transformers and voltage conversion equipment.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific asset unit. Critical for warranty claims and asset tracking.',
    `voltage_class_kv` DECIMAL(18,2) COMMENT 'Nominal voltage class of the asset in kilovolts. Applicable to electrical assets (transmission lines, transformers, substations). Critical for grid operations and safety compliance.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty coverage expires. Used for maintenance planning and cost forecasting.',
    CONSTRAINT pk_registry PRIMARY KEY(`registry_id`)
) COMMENT 'Master record for every physical infrastructure asset owned or operated by the utility, including generation plant equipment, T&D poles/lines/cables, gas pipeline segments, substations, transformers, meters, and field devices. Serves as the enterprise SSOT for asset identity, classification (referencing asset class), installation details, geospatial location (FK to location), manufacturer data, model/serial numbers, rated capacity, voltage class, material composition, commissioning date, retirement date, and current lifecycle status. Integrates with Maximo EAM as the system of record and Esri ArcGIS for spatial attributes. Supports ISO 55000 asset management compliance and RAB reporting to state PUCs. Technical material specifications for procurement are referenced via FK to the supply domains material master.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Primary key for hierarchy',
    `child_asset_asset_registry_id` BIGINT COMMENT 'Identifier of the child asset in the hierarchy structure. References the subordinate asset in the parent-child relationship.',
    `child_asset_registry_id` BIGINT COMMENT 'Identifier of the child asset in the hierarchy structure. References the subordinate asset in the parent-child relationship.',
    `hierarchy_asset_registry_id` BIGINT COMMENT 'Identifier of the parent asset in the hierarchy structure. References the superior asset in the parent-child relationship.',
    `registry_id` BIGINT COMMENT 'Identifier of the parent asset in the hierarchy structure. References the superior asset in the parent-child relationship.',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'Percentage of child asset costs (Operations and Maintenance, depreciation, CAPEX) allocated to the parent asset for financial roll-up and rate base reporting. May differ from ownership percentage in regulated utility accounting. Value between 0.00 and 100.00.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the hierarchy relationship record was first created in the system. Used for audit trail and data lineage tracking.',
    `criticality_inheritance_flag` BOOLEAN COMMENT 'Indicates whether the child asset inherits criticality classification from the parent asset. True means child criticality is derived from parent, false means child has independent criticality assessment.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Automated data quality score for the hierarchy relationship record based on completeness, consistency, and validation rules. Value between 0.00 and 1.00 where 1.00 represents perfect quality.',
    `effective_end_date` DATE COMMENT 'Date when the hierarchy relationship ceases or ceased to be effective. Null indicates an open-ended relationship. Used for temporal hierarchy queries and asset reorganization tracking.',
    `effective_start_date` DATE COMMENT 'Date when the hierarchy relationship becomes or became effective. Used for temporal hierarchy queries and historical asset structure analysis.',
    `geographic_containment_flag` BOOLEAN COMMENT 'Indicates whether the child asset is physically contained within the geographic boundaries of the parent asset. True for spatial containment (e.g., transformer inside substation), false for logical relationships without physical containment.',
    `gis_feature_relationship_code` STRING COMMENT 'External identifier linking this hierarchy relationship to the corresponding feature relationship in Esri ArcGIS. Enables synchronization between EAM and GIS systems for geospatial asset tracking.',
    `hierarchy_description` STRING COMMENT 'Free-text description explaining the nature and business purpose of the parent-child relationship. Provides context for non-standard or complex hierarchical arrangements.',
    `hierarchy_level` STRING COMMENT 'Numeric level in the hierarchy tree structure where level 1 is the root and higher numbers represent deeper nesting. Used for roll-up calculations and tree traversal.',
    `hierarchy_type` STRING COMMENT 'Classification of the hierarchy relationship type. Functional represents operational groupings, spatial represents physical location containment, accounting represents financial roll-up structures, network represents electrical or gas connectivity, organizational represents ownership or responsibility structures, and maintenance represents work planning groupings.. Valid values are `functional|spatial|accounting|network|organizational|maintenance`',
    `last_modified_by` STRING COMMENT 'User identifier or system account that last modified the hierarchy relationship record. Used for audit trail and change tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the hierarchy relationship record was last modified. Used for audit trail, change detection, and incremental data processing.',
    `maintenance_responsibility_code` STRING COMMENT 'Code identifying the organizational unit or crew responsible for maintaining the child asset within this hierarchy context. Used for work order routing and maintenance planning.',
    `maximo_relationship_code` STRING COMMENT 'External identifier from Maximo EAM system representing the source asset relationship record. Used for data lineage and bidirectional synchronization with the operational EAM system.',
    `network_topology_role` STRING COMMENT 'Role of the child asset relative to the parent in electrical or gas network topology. Upstream indicates the child feeds the parent, downstream indicates the parent feeds the child, parallel indicates side-by-side configuration, redundant indicates backup relationship, and isolated indicates no active flow relationship.. Valid values are `upstream|downstream|parallel|redundant|isolated`',
    `outage_propagation_flag` BOOLEAN COMMENT 'Indicates whether an outage of the parent asset automatically causes an outage of the child asset. True for dependent assets where parent failure cascades to children, false for independent operation. Used in Outage Management System (OMS) impact analysis.',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Percentage of the child asset owned or allocated to the parent asset in joint ownership or shared asset scenarios. Used for proportional CAPEX allocation and Regulatory Asset Base (RAB) calculations. Value between 0.00 and 100.00.',
    `path` STRING COMMENT 'Full hierarchical path from root to child asset represented as a delimited string of asset identifiers. Enables efficient ancestor and descendant queries. Format example: /1/45/892/3421.',
    `primary_hierarchy_flag` BOOLEAN COMMENT 'Indicates whether this is the primary hierarchy relationship for the child asset when multiple hierarchy types exist. True designates the authoritative parent-child relationship for default reporting and CAPEX roll-up.',
    `rab_allocation_method` STRING COMMENT 'Method used to allocate child asset value to parent for Regulatory Asset Base reporting. Direct assigns full value to parent, proportional uses ownership percentage, shared distributes across multiple parents, and excluded removes from RAB roll-up.. Valid values are `direct|proportional|shared|excluded`',
    `relationship_established_date` DATE COMMENT 'Date when the hierarchy relationship was first created in the system. Distinct from effective start date; represents the administrative creation date for audit purposes.',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the hierarchy relationship. Active indicates the relationship is currently in effect, inactive indicates it has been terminated, pending indicates it is scheduled for future activation, and superseded indicates it has been replaced by a newer relationship.. Valid values are `active|inactive|pending|superseded`',
    `relationship_terminated_date` DATE COMMENT 'Date when the hierarchy relationship was administratively terminated or removed from the system. Used for audit trail and historical analysis of asset reorganizations.',
    `sequence_number` STRING COMMENT 'Ordering sequence of the child asset among its siblings within the same parent. Used for display ordering and operational sequencing in maintenance routes and inspection plans.',
    `source_system` STRING COMMENT 'System of origin for the hierarchy relationship record. Maximo indicates EAM system, ArcGIS indicates geospatial system, SAP PM indicates plant maintenance module, manual indicates user-entered data, and migration indicates legacy system conversion.. Valid values are `maximo|arcgis|sap_pm|manual|migration`',
    `termination_reason_code` STRING COMMENT 'Code indicating the reason for terminating the hierarchy relationship. Asset retired indicates child asset decommissioned, asset transferred indicates ownership change, reorganization indicates structural change, error correction indicates data quality fix, asset replaced indicates equipment upgrade, and consolidation indicates merger of asset records.. Valid values are `asset_retired|asset_transferred|reorganization|error_correction|asset_replaced|consolidation`',
    `validation_status` STRING COMMENT 'Status of data quality validation for the hierarchy relationship. Validated indicates passed all business rules, pending review indicates flagged for manual inspection, failed indicates rule violations detected, and not validated indicates validation not yet performed.. Valid values are `validated|pending_review|failed|not_validated`',
    `validation_timestamp` TIMESTAMP COMMENT 'Timestamp when the most recent data quality validation was performed on the hierarchy relationship record.',
    `created_by` STRING COMMENT 'User identifier or system account that created the hierarchy relationship record. Used for audit trail and data governance.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Defines the parent-child structural hierarchy of utility assets, enabling roll-up from individual components (e.g., a circuit breaker) to functional units (e.g., a substation bay) to facilities (e.g., a substation) to network segments (e.g., a transmission corridor). Captures hierarchy type (functional, spatial, accounting), relationship effective dates, and hierarchy level codes. Used for CAPEX roll-up, maintenance planning, outage impact analysis, and RAB reporting. Sourced from Maximo EAM location/asset hierarchy and Esri ArcGIS network topology.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`location` (
    `location_id` BIGINT COMMENT 'Primary key for location',
    `parcel_id` BIGINT COMMENT 'Tax parcel or land parcel identifier from county assessor records, used for property rights and easement management.',
    `network_device_id` BIGINT COMMENT 'Foreign key linking to technology.network_device. Business justification: Network Device Mapping: link GIS location to network device for outage management and field crew dispatch (Network Outage Response Plan).',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Spare Parts Logistics; linking asset locations (e.g., substations) to the serving warehouse supports inventory allocation, delivery planning, and regulatory logistics reporting.',
    `access_restrictions` STRING COMMENT 'Description of any access restrictions or special requirements for field crews to reach the location (e.g., locked gate, private property, permit required).',
    `city` STRING COMMENT 'City or municipality name where the location is situated.',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the location is situated.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County jurisdiction where the location resides, used for regulatory territory reporting and permitting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this location record was first created in the system.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Calculated data quality score (0-100) based on completeness, accuracy, and timeliness of location attributes.',
    `data_source_system` STRING COMMENT 'Source system of record from which this location data originated (e.g., Esri ArcGIS, Maximo EAM, manual survey).',
    `decommission_date` DATE COMMENT 'Date when the location was decommissioned or retired from active service, if applicable.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation above sea level in feet, used for engineering calculations and flood risk assessment.',
    `gis_feature_class` STRING COMMENT 'GIS feature class identifier from Esri ArcGIS system used for spatial data management and mapping.',
    `gis_object_code` STRING COMMENT 'Unique object identifier within the GIS system for cross-system integration and spatial query operations.',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'Estimated accuracy of the GPS coordinates in meters, indicating the precision of the geospatial data.',
    `hazard_classification` STRING COMMENT 'Environmental or safety hazard classification for the location used for risk assessment and crew safety planning.. Valid values are `none|flood_zone|wildfire_risk|seismic_zone|environmental_sensitive|confined_space`',
    `installation_date` DATE COMMENT 'Date when the location was first established or commissioned for utility operations.',
    `is_critical_infrastructure` BOOLEAN COMMENT 'Indicates whether this location is designated as critical infrastructure under NERC Critical Infrastructure Protection (CIP) standards requiring enhanced security and monitoring.',
    `is_remote_accessible` BOOLEAN COMMENT 'Indicates whether the location can be accessed or monitored remotely via SCADA or other telemetry systems.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection or site survey conducted at this location.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this location record was last updated or modified.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate in decimal degrees format (WGS84 datum) for precise geospatial positioning.',
    `location_code` STRING COMMENT 'Business identifier for the location, used for external reference and integration with Geographic Information System (GIS) and Enterprise Asset Management (EAM) systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `location_description` STRING COMMENT 'Detailed textual description of the location including landmarks, directions, or special characteristics to aid field crew navigation.',
    `location_name` STRING COMMENT 'Human-readable name or description of the location (e.g., substation name, pole identifier, vault reference).',
    `location_status` STRING COMMENT 'Current lifecycle status of the location indicating operational availability and readiness.. Valid values are `active|inactive|planned|decommissioned|under_construction|temporarily_closed`',
    `location_type` STRING COMMENT 'Classification of the location type within the utility infrastructure (e.g., substation, transmission tower, distribution pole, underground vault, generation facility). [ENUM-REF-CANDIDATE: substation|transmission_tower|distribution_pole|underground_vault|generation_facility|service_center|meter_location|switching_station — 8 candidates stripped; promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate in decimal degrees format (WGS84 datum) for precise geospatial positioning.',
    `nerc_region` STRING COMMENT 'NERC regional entity jurisdiction for reliability compliance and reporting.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection or site survey based on regulatory or maintenance requirements.',
    `notes` STRING COMMENT 'Free-form notes or comments about the location for operational reference and knowledge capture.',
    `operating_region` STRING COMMENT 'Higher-level operating region or division responsible for this location, used for organizational reporting.',
    `ownership_type` STRING COMMENT 'Type of land or property ownership arrangement for the location (e.g., utility-owned, leased, easement, right-of-way).. Valid values are `utility_owned|leased|easement|right_of_way|public_land|customer_premises`',
    `pole_number` STRING COMMENT 'Unique pole or structure number for overhead distribution and transmission assets, used for field identification.',
    `postal_code` STRING COMMENT 'Postal ZIP code for the location address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory jurisdiction (e.g., state Public Utility Commission) governing this location for rate case and compliance reporting.',
    `rto_iso_territory` STRING COMMENT 'RTO or ISO territory jurisdiction for locations within transmission grid, used for market operations and compliance reporting.',
    `service_territory_zone` STRING COMMENT 'Service territory zone identifier indicating the operational service area or district for resource allocation and planning.',
    `state_province` STRING COMMENT 'Two-letter state or province code where the location is situated.. Valid values are `^[A-Z]{2}$`',
    `street_address` STRING COMMENT 'Physical street address of the location where applicable, used for field crew navigation and permitting.',
    `substation_name` STRING COMMENT 'Name of the associated substation if the location is within or connected to a substation facility.',
    `vault_reference` STRING COMMENT 'Reference identifier for underground vault or manhole where underground assets are located.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Geospatial and physical location master for utility assets, capturing GPS coordinates (latitude/longitude), GIS feature class, county/municipality, service territory zone, transmission/distribution circuit identifier, substation name, pole/structure number, underground vault reference, and address where applicable. Integrates with Esri ArcGIS for spatial data management. Supports field crew navigation, outage restoration, permitting, and regulatory territory reporting. Each asset in asset_registry references one location record.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`classification` (
    `classification_id` BIGINT COMMENT 'Primary key for classification',
    `parent_asset_class_classification_id` BIGINT COMMENT 'Reference to the parent asset class in a hierarchical taxonomy structure, enabling multi-level classification (e.g., Distribution Equipment as parent of Distribution Transformer). Null if this is a top-level class.',
    `active_status` STRING COMMENT 'Current lifecycle status of the asset class definition: active (in use for new assets), inactive (no longer used but historical data exists), deprecated (being phased out), or pending approval (awaiting classification committee review).. Valid values are `active|inactive|deprecated|pending_approval`',
    `approval_date` DATE COMMENT 'Date when this asset class definition was formally approved by the asset classification governance committee. Format: yyyy-MM-dd.',
    `approved_by` STRING COMMENT 'Name or identifier of the user or governance committee that approved this asset class definition for use in the enterprise asset taxonomy.',
    `asset_category` STRING COMMENT 'High-level categorization of the asset class by operational domain: generation (power plants, turbines), transmission (high-voltage lines, towers), distribution (poles, transformers, feeders), gas (pipelines, regulators), substation (breakers, relays), metering (AMI meters, MDM devices), fleet (vehicles, mobile equipment), IT/OT (SCADA systems, servers), facilities (buildings, warehouses), or other. [ENUM-REF-CANDIDATE: generation|transmission|distribution|gas|substation|metering|fleet|it_ot|facilities|other — 10 candidates stripped; promote to reference product]',
    `asset_class_code` STRING COMMENT 'Standardized alphanumeric code uniquely identifying the asset class within the utilitys asset taxonomy. Used as the business identifier for asset classification across all systems.. Valid values are `^[A-Z0-9]{3,12}$`',
    `asset_class_description` STRING COMMENT 'Detailed textual description of the asset class, including typical use cases, technical characteristics, and operational context within the utilitys infrastructure.',
    `asset_class_level` STRING COMMENT 'Numeric level in the asset classification hierarchy, with 1 representing top-level categories and higher numbers representing more granular sub-classifications.',
    `asset_class_name` STRING COMMENT 'Full descriptive name of the asset class (e.g., Distribution Transformer, Transmission Tower, Gas Regulator Station).',
    `asset_criticality_rating` STRING COMMENT 'Default criticality classification for assets in this class based on impact to grid reliability, safety, and regulatory compliance. Used for prioritizing maintenance and capital investment.. Valid values are `critical|high|medium|low`',
    `average_unit_cost` DECIMAL(18,2) COMMENT 'Average acquisition or installation cost per unit for assets in this class, used for budgeting and capital expenditure (CAPEX) planning. Updated periodically based on procurement history.',
    `average_unit_cost_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the average unit cost (e.g., USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `capitalization_threshold_amount` DECIMAL(18,2) COMMENT 'Minimum dollar value required for an asset in this class to be capitalized as a fixed asset rather than expensed. Aligns with FASB ASC 980 and internal CAPEX policies.',
    `capitalization_threshold_currency` STRING COMMENT 'ISO 4217 three-letter currency code for the capitalization threshold amount (e.g., USD, CAD).. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset class record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate assets in this class: straight-line (equal annual expense), declining balance (accelerated), sum-of-years digits, units of production (usage-based), group/composite (pooled depreciation), or other method approved by regulatory authority.. Valid values are `straight_line|declining_balance|sum_of_years_digits|units_of_production|group_composite|other`',
    `effective_end_date` DATE COMMENT 'Date when this asset class definition was retired or superseded. Null if currently active. Format: yyyy-MM-dd.',
    `effective_start_date` DATE COMMENT 'Date when this asset class definition became effective for use in asset registration and accounting. Format: yyyy-MM-dd.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether assets in this class are subject to Environmental Protection Agency (EPA) or state environmental regulations (e.g., emissions monitoring, hazardous materials handling, spill prevention). True if environmental compliance tracking is required.',
    `ferc_account_number` STRING COMMENT 'FERC Uniform System of Accounts number for regulatory accounting classification. Maps asset class to the appropriate plant account for rate base and depreciation reporting (e.g., 364 for Poles and Fixtures, 365 for Overhead Conductors).. Valid values are `^[0-9]{3}(.[0-9]{1,2})?$`',
    `gis_trackable_flag` BOOLEAN COMMENT 'Indicates whether assets in this class are spatially tracked in the Esri ArcGIS system with geospatial coordinates. True if GIS location tracking is required for operational and planning purposes.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether assets in this class must be covered by property insurance policies. True if insurance coverage is mandatory for risk management and regulatory compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset class record was most recently updated. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `maintenance_strategy` STRING COMMENT 'Standard maintenance approach for assets in this class: reactive (repair on failure), preventive (scheduled maintenance), predictive (sensor-driven), condition-based (inspection-driven), reliability-centered (RCM), or run-to-failure (no maintenance).. Valid values are `reactive|preventive|predictive|condition_based|reliability_centered|run_to_failure`',
    `manufacturer_agnostic_flag` BOOLEAN COMMENT 'Indicates whether this asset class is defined independently of manufacturer or vendor (true) or is specific to a particular manufacturers product line (false).',
    `mobile_asset_flag` BOOLEAN COMMENT 'Indicates whether assets in this class are mobile (e.g., fleet vehicles, portable generators, mobile substations) rather than fixed infrastructure. True if the asset class represents mobile equipment.',
    `nerc_cip_applicable_flag` BOOLEAN COMMENT 'Indicates whether assets in this class are subject to NERC CIP cybersecurity and physical security standards for Bulk Electric System (BES) protection. True if CIP standards apply, false otherwise.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, special instructions, or clarifications regarding the asset class definition and usage.',
    `replacement_cycle_years` DECIMAL(18,2) COMMENT 'Typical replacement or refresh cycle for assets in this class, used for long-term capital planning and Integrated Resource Plan (IRP) forecasting. May differ from depreciation life.',
    `safety_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether assets in this class require periodic safety inspections per Occupational Safety and Health Administration (OSHA) or utility safety standards. True if mandatory safety inspections apply.',
    `salvage_value_percentage` DECIMAL(18,2) COMMENT 'Expected residual value of assets in this class at end of useful life, expressed as a percentage of original cost. Used in depreciation calculations per FERC and FASB ASC 980 requirements.',
    `serialized_asset_flag` BOOLEAN COMMENT 'Indicates whether individual assets in this class are tracked by unique serial numbers or asset tags. True if serialization is required for inventory and lifecycle management.',
    `standard_unit_of_measure` STRING COMMENT 'Standard unit used to quantify assets in this class for inventory and planning purposes (e.g., each, mile, meter, MVA, MCF). Aligns with industry measurement standards.',
    `standard_useful_life_years` DECIMAL(18,2) COMMENT 'Expected service life of assets in this class, measured in years, as approved by the Public Utility Commission (PUC) for depreciation rate calculation and Regulatory Asset Base (RAB) reporting.',
    `warranty_tracking_required_flag` BOOLEAN COMMENT 'Indicates whether assets in this class require warranty period and warranty claim tracking. True if warranty management is applicable for this asset class.',
    CONSTRAINT pk_classification PRIMARY KEY(`classification_id`)
) COMMENT 'Reference taxonomy defining the classification scheme for utility assets by asset class code, asset class name, asset category (generation, transmission, distribution, gas, substation, metering, fleet, IT/OT), FERC account number for regulatory accounting, depreciation method, standard useful life in years, capitalization threshold, and applicable maintenance strategy. Aligns with FERC Uniform System of Accounts and FASB ASC 980 regulated operations accounting. Used for depreciation scheduling, RAB calculation, and rate case filing.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` (
    `condition_assessment_id` BIGINT COMMENT 'Primary key for condition_assessment',
    `asset_registry_id` BIGINT COMMENT 'Reference to the physical asset being assessed. Links to the asset registry for generation, transmission, distribution, or gas infrastructure equipment.',
    `employee_id` BIGINT COMMENT 'Reference to the technician or inspector who performed the assessment. Links to workforce technician registry.',
    `generating_unit_id` BIGINT COMMENT 'Foreign key linking to generation.generating_unit. Business justification: Condition assessments are performed on individual generating units; linking them supports reliability analysis and predictive maintenance.',
    `location_id` BIGINT COMMENT 'Esri ArcGIS location identifier for geospatial tracking of the asset being assessed. Enables spatial analysis of asset condition patterns.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset being assessed. Links to the asset registry for generation, transmission, distribution, or gas infrastructure equipment.',
    `scada_point_id` BIGINT COMMENT 'Reference to the SCADA point or PI Historian tag that provided the operational reading data for automated measurements.',
    `technician_id` BIGINT COMMENT 'Reference to the technician or inspector who performed the assessment. Links to workforce technician registry.',
    `work_order_id` BIGINT COMMENT 'Reference to the Maximo work order that initiated or resulted from this condition assessment. Links inspection findings to maintenance execution.',
    `ambient_temperature_c` DECIMAL(18,2) COMMENT 'Ambient air temperature in degrees Celsius at the time of assessment. Contextual data for interpreting thermal and electrical measurements.',
    `assessment_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for performing the condition assessment including labor, equipment, and contractor fees. Supports O&M (Operations and Maintenance) cost tracking.',
    `assessment_method` STRING COMMENT 'Technical method used to assess asset condition: visual inspection, thermographic imaging, ultrasonic testing, oil sample analysis, vibration analysis, dissolved gas analysis (DGA), or insulation resistance testing. [ENUM-REF-CANDIDATE: visual|thermographic|ultrasonic|oil_sample|vibration|dga|insulation_test — 7 candidates stripped; promote to reference product]',
    `assessment_source` STRING COMMENT 'Origin of the condition assessment data: field inspection by utility crews, automated SCADA reading, PI Historian data feed, manual data entry, or third-party contractor assessment.. Valid values are `field_inspection|scada_automated|pi_historian|manual_entry|third_party_contractor`',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the condition assessment activity.. Valid values are `scheduled|in_progress|completed|cancelled|failed`',
    `assessment_timestamp` TIMESTAMP COMMENT 'Date and time when the condition assessment was performed or measurement was captured. Primary business event timestamp for the assessment.',
    `assessment_type` STRING COMMENT 'Category of condition assessment record: inspection event, condition score evaluation, or operational reading measurement. [ENUM-REF-CANDIDATE: inspection|condition_score|operational_reading|thermographic|structural|environmental|regulatory — 7 candidates stripped; promote to reference product]',
    `compliance_status` STRING COMMENT 'Regulatory compliance status based on assessment results: compliant with requirements, non-compliant requiring corrective action, pending regulatory review, or remediation in progress.. Valid values are `compliant|non_compliant|pending_review|remediation_required`',
    `condition_index` DECIMAL(18,2) COMMENT 'Calculated condition index score (0-100 scale) representing overall asset health based on multiple assessment factors.',
    `condition_score` DECIMAL(18,2) COMMENT 'Numeric condition grade on a 1-5 scale where 5 is excellent/new condition and 1 is poor/end-of-life. Used for asset health index calculations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this condition assessment record was first created in the system. Audit trail for data lineage.',
    `deficiency_count` STRING COMMENT 'Number of deficiencies or issues identified during the inspection.',
    `dga_ppm` DECIMAL(18,2) COMMENT 'Concentration of dissolved gases in transformer oil measured in parts per million. Used to detect incipient faults in oil-filled electrical equipment.',
    `failure_probability_rating` STRING COMMENT 'Assessed likelihood of asset failure within the planning horizon. Used for risk-based maintenance prioritization.. Valid values are `very_low|low|moderate|high|very_high`',
    `findings_summary` STRING COMMENT 'Narrative summary of inspection findings, observations, and deficiencies identified during the assessment.',
    `gas_pressure_psi` DECIMAL(18,2) COMMENT 'Measured natural gas pipeline pressure in pounds per square inch. Critical safety and operational parameter for gas distribution systems.',
    `inspection_result` STRING COMMENT 'Overall outcome of the inspection: pass (no issues), fail (critical deficiencies), conditional (minor issues noted), or requires follow-up investigation.. Valid values are `pass|fail|conditional|requires_followup`',
    `inspection_type` STRING COMMENT 'Specific type of inspection conducted for inspection assessment records. Includes routine patrol, thermographic imaging, structural integrity, environmental compliance, NERC CIP (Critical Infrastructure Protection) security, and PHMSA (Pipeline and Hazardous Materials Safety Administration) pipeline inspections.. Valid values are `routine_patrol|thermographic|structural|environmental|nerc_cip|phmsa_pipeline`',
    `inspector_certification` STRING COMMENT 'Professional certification or qualification held by the inspector conducting the assessment (e.g., Level II Thermographer, NACE Corrosion Specialist, API 510 Pressure Vessel Inspector).',
    `insulation_resistance_mohm` DECIMAL(18,2) COMMENT 'Measured insulation resistance in megaohms for cables and electrical equipment. Indicates insulation integrity and moisture ingress.',
    `measurement_parameter` STRING COMMENT 'Name of the operational parameter being measured for operational reading records (e.g., transformer loading, oil temperature, gas pressure, insulation resistance).',
    `measurement_unit` STRING COMMENT 'Unit of measure for the operational reading (e.g., %, °C, PSI, MΩ, ppm, Hz, kV).',
    `measurement_value` DECIMAL(18,2) COMMENT 'Quantitative measurement value captured from SCADA/PI Historian or field instruments for operational readings.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this condition assessment record was last modified. Audit trail for data lineage and change tracking.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next required condition assessment based on regulatory requirements, manufacturer recommendations, or risk-based maintenance intervals.',
    `notes` STRING COMMENT 'Additional notes, observations, or context provided by the inspector or assessment system.',
    `oil_temperature_c` DECIMAL(18,2) COMMENT 'Measured oil temperature in degrees Celsius for oil-filled transformers and circuit breakers. Key indicator of thermal stress and cooling system performance.',
    `photo_attachment_count` STRING COMMENT 'Number of digital photographs or thermal images attached to the assessment record for documentation purposes.',
    `recommended_action` STRING COMMENT 'Recommended remediation action based on condition assessment: continue monitoring, schedule routine maintenance, perform corrective maintenance, major repair, or asset replacement.. Valid values are `monitor|routine_maintenance|corrective_maintenance|major_repair|replacement`',
    `regulatory_program` STRING COMMENT 'Name of the regulatory compliance program associated with this assessment (e.g., NERC CIP-006, PHMSA Integrity Management, EPA Environmental Inspection).',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Estimated remaining useful life of the asset in years based on current condition assessment. Supports CAPEX planning and replacement scheduling.',
    `third_party_contractor` STRING COMMENT 'Name of the third-party inspection contractor or vendor if assessment was performed by external party.',
    `threshold_breach_flag` BOOLEAN COMMENT 'Indicates whether the measured value exceeded acceptable threshold limits (true) or remained within normal operating range (false).',
    `threshold_max` DECIMAL(18,2) COMMENT 'Maximum acceptable threshold value for the operational parameter. Values above this trigger alerts.',
    `threshold_min` DECIMAL(18,2) COMMENT 'Minimum acceptable threshold value for the operational parameter. Values below this trigger alerts.',
    `transformer_loading_pct` DECIMAL(18,2) COMMENT 'Current loading percentage of transformer capacity for transformer assets. Critical operational metric for transmission and distribution transformers.',
    `vibration_level_mm_s` DECIMAL(18,2) COMMENT 'Measured vibration velocity in millimeters per second for rotating equipment (generators, turbines, motors). Indicates mechanical condition and bearing health.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of field inspection (e.g., clear, rain, snow, high wind) that may affect assessment accuracy or asset condition.',
    CONSTRAINT pk_condition_assessment PRIMARY KEY(`condition_assessment_id`)
) COMMENT 'Comprehensive condition monitoring and assessment records for utility assets, serving as the single source of truth for asset health data. Captures three integrated record types: (1) Inspection events — formal field inspections conducted by utility crews, third-party inspectors, or regulatory auditors including inspection type (routine patrol, thermographic, structural, environmental, NERC CIP, PHMSA pipeline), inspector certification, inspection result (pass/fail/conditional), findings summary, deficiency count, and regulatory program association; (2) Condition scores — periodic condition grades (1-5 scale), condition index scores, failure probability ratings, remaining useful life estimates, recommended remediation actions, and assessment method (visual, thermographic, ultrasonic, oil sample); (3) Operational readings — quantitative measurements from SCADA/PI Historian and field instruments including transformer loading %, oil temperature, dissolved gas analysis (DGA) ppm, cable insulation resistance MΩ, gas pipeline pressure PSI, vibration levels, and threshold breach flags. Feeds asset health index calculations for risk-based maintenance prioritization and CAPEX planning. Sourced from Maximo inspection workflows, OSIsoft PI Historian, and field measurement instruments. Distinct from AMI meter interval reads (owned by metering domain).';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order record. Primary key sourced from Maximo Enterprise Asset Management (EAM) system.',
    `approved_by_employee_id` BIGINT COMMENT 'Foreign key reference to the manager or engineer who approved the work order for execution. Required for capital project and high-priority work.',
    `asset_registry_id` BIGINT COMMENT 'Foreign key reference to the physical asset on which maintenance work is performed. Links work order to asset registry in Maximo and GIS.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Work orders for customer‑initiated service are billed to the customer’s account; linking enables invoice generation and revenue recognition per work order.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: REQUIRED: Service Order Management ties each work order to the customer account for billing, SLA tracking, and the Service Order Report.',
    `closed_by_employee_id` BIGINT COMMENT 'Foreign key reference to the user who closed the work order. Indicates final review and acceptance of completed work.',
    `cost_center_id` BIGINT COMMENT 'Foreign key reference to the cost center charged for work order expenses. Links to SAP FI/CO for financial accounting and rate case cost allocation.',
    `employee_id` BIGINT COMMENT 'Foreign key reference to the supervisor or foreman responsible for overseeing work order execution. Links to workforce management system.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: MAINTENANCE: Work orders are scheduled per facility (substation/plant) to coordinate crews and meet safety regulations.',
    `generating_unit_id` BIGINT COMMENT 'Foreign key linking to generation.generating_unit. Business justification: Maintenance work orders are often created for a specific generating unit; the link enables unit‑specific scheduling and cost allocation.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: IT Service Work Orders: track work orders that pertain to IT services, needed for ITSM KPI and SLA reporting.',
    `location_id` BIGINT COMMENT 'Foreign key reference to the geographic location or facility where work is performed. Supports crew dispatch routing and outage coordination.',
    `parent_work_order_id` BIGINT COMMENT 'Foreign key reference to the parent work order if this is a child or sub-task work order. Supports hierarchical project breakdown for capital projects.',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key reference to the preventive maintenance schedule that generated this work order. Links to recurring PM program for compliance tracking.',
    `technician_id` BIGINT COMMENT 'Foreign key reference to the supervisor or foreman responsible for overseeing work order execution. Links to workforce management system.',
    `registry_id` BIGINT COMMENT 'Foreign key reference to the physical asset on which maintenance work is performed. Links work order to asset registry in Maximo and GIS.',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Work orders must reference the applicable safety program (e.g., lockout/tagout) to ensure required safety procedures are followed and documented.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: OPERATIONS: Site‑wide work orders (e.g., generation site upgrades) need site context for permits and reporting.',
    `tertiary_work_closed_by_technician_id` BIGINT COMMENT 'Foreign key reference to the user who closed the work order. Indicates final review and acceptance of completed work.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: External Service Vendor Tracking; work orders often contract third‑party vendors, and linking enables safety compliance, performance monitoring, and cost attribution.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key reference to the WBS element for capital project work orders. Links to SAP PS for CAPEX project tracking and RAB capitalization.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when work order execution was completed. Used to calculate actual duration and labor hours for cost accounting.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours actually expended on the work order. Captured from time entry system for cost accounting and productivity analysis.',
    `actual_material_cost` DECIMAL(18,2) COMMENT 'Total cost of materials and parts actually consumed on the work order. Captured from inventory transactions in SAP MM for cost accounting.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work order execution began. Captured from crew mobile device or workforce management system for labor tracking.',
    `actual_total_cost` DECIMAL(18,2) COMMENT 'Total cost actually incurred for the work order. Captured from SAP ERP for financial reporting and Regulatory Asset Base (RAB) reporting.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was approved for execution. Marks transition from draft to scheduled status in workflow.',
    `capitalized_flag` BOOLEAN COMMENT 'Indicates whether work order costs are capitalized to the Regulatory Asset Base (RAB) or expensed as Operations and Maintenance (O&M). Determines financial accounting treatment.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was closed. Marks completion of all work and administrative tasks for cost accounting finalization.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was first created in Maximo. Audit field for record lifecycle tracking.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Planned total labor hours required to complete the work order. Used for crew scheduling and OPEX budget planning.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Planned total cost of materials and parts required for the work order. Used for supply chain requisition and budget planning.',
    `estimated_total_cost` DECIMAL(18,2) COMMENT 'Planned total cost of the work order including labor, materials, equipment, and contractor costs. Used for budget authorization and CAPEX/OPEX planning.',
    `failure_code` STRING COMMENT 'Standardized code identifying the type of asset failure or condition that triggered corrective maintenance. Used for reliability analysis and failure mode tracking.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was last modified. Audit field for change tracking and data lineage.',
    `originating_source` STRING COMMENT 'System or business process that initiated the work order. Identifies root cause trigger for maintenance activity and supports reliability analysis.. Valid values are `scada_alarm|inspection_finding|customer_complaint|scheduled_pm|condition_monitoring|regulatory_requirement`',
    `outage_duration_minutes` STRING COMMENT 'Planned or actual duration of the outage in minutes. Used for SAIDI/SAIFI reliability metrics calculation and customer impact assessment.',
    `outage_required_flag` BOOLEAN COMMENT 'Indicates whether the work order requires a planned outage of the asset or circuit. Used for outage coordination with OMS and customer notification.',
    `permit_required_flag` BOOLEAN COMMENT 'Indicates whether regulatory or municipal permits are required before work can begin. Triggers permit acquisition workflow.',
    `planned_finish_date` DATE COMMENT 'Scheduled date when work order execution is planned to be completed. Used for outage duration planning and customer communication.',
    `planned_start_date` DATE COMMENT 'Scheduled date when work order execution is planned to begin. Used for resource planning and outage coordination.',
    `priority` STRING COMMENT 'Business priority level determining scheduling sequence and resource allocation urgency. Emergency priority triggers immediate dispatch for grid reliability.. Valid values are `emergency|urgent|high|medium|low`',
    `problem_description` STRING COMMENT 'Detailed description of the asset problem or condition observed. Captured from inspection findings, SCADA alarms, or customer complaints.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this work order is required for regulatory compliance (NERC CIP, FERC, PUC mandates). Used for compliance reporting and audit trails.',
    `resolution_description` STRING COMMENT 'Detailed description of the corrective actions taken and work performed. Captured by crew upon work order completion for maintenance history.',
    `safety_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a formal safety plan is required for work order execution. Triggers safety review and OSHA compliance documentation.',
    `work_order_description` STRING COMMENT 'Detailed narrative description of the work to be performed. Includes scope, safety considerations, and special instructions for crew execution.',
    `work_order_number` STRING COMMENT 'Externally-known business identifier for the work order. Human-readable unique number assigned by Maximo for tracking and reference across systems.. Valid values are `^WO[0-9]{8,12}$`',
    `work_order_status` STRING COMMENT 'Current lifecycle state of the work order in the Maximo workflow. Tracks progression from creation through execution to closure. [ENUM-REF-CANDIDATE: draft|approved|scheduled|in_progress|on_hold|completed|closed|cancelled — 8 candidates stripped; promote to reference product]',
    `work_type` STRING COMMENT 'Classification of the work order by maintenance category. Determines scheduling priority, resource allocation, and cost accounting treatment.. Valid values are `preventive_maintenance|corrective_maintenance|inspection|capital_project|emergency_restoration|predictive_maintenance`',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Maximo-sourced work order master representing all planned, corrective, and emergency maintenance activities performed on utility assets. Captures work order number, work type (preventive maintenance, corrective maintenance, inspection, capital project, emergency restoration), priority level, originating source (SCADA alarm, inspection finding, customer complaint, scheduled PM), work order status, planned start/finish dates, actual start/finish dates, crew assignment, estimated and actual labor hours, estimated and actual material cost, and associated asset. Central operational record linking asset maintenance to workforce dispatch and supply chain material consumption.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`work_order_task` (
    `work_order_task_id` BIGINT COMMENT 'Unique identifier for the work order task. Primary key.',
    `asset_registry_id` BIGINT COMMENT 'Foreign key reference to the specific asset this task is performed on. May be null if task is location-based rather than asset-specific.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Task-level cost tracking requires cost center to allocate labor/material costs in financial statements.',
    `crew_id` BIGINT COMMENT 'Foreign key reference to the crew assigned to this task. Null if task is assigned to an individual technician rather than a crew.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: GL account on task enables precise expense posting for each work order activity.',
    `job_plan_id` BIGINT COMMENT 'Foreign key reference to the standard job plan template from which this task was generated. Null if task is ad-hoc.',
    `location_id` BIGINT COMMENT 'Foreign key reference to the physical location where this task is performed (e.g., substation, plant, facility). Used when task is location-based.',
    `registry_id` BIGINT COMMENT 'Foreign key reference to the specific asset this task is performed on. May be null if task is location-based rather than asset-specific.',
    `technician_id` BIGINT COMMENT 'Foreign key reference to the primary technician assigned to perform this task. Links to workforce.technician.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: WBS element on task ties activity to project hierarchy for capital vs OPEX budgeting.',
    `work_order_id` BIGINT COMMENT 'Foreign key reference to the parent work order. Links this task to its containing work order.',
    `actual_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for this task. Calculated from time entries, material issues, and equipment charges. Used for Regulatory Asset Base (RAB) reporting.',
    `actual_duration_hours` DECIMAL(18,2) COMMENT 'Actual elapsed time (clock hours) from task start to completion. Used for schedule performance analysis.',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when this task was completed. Used for performance tracking and labor cost allocation.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Actual labor hours expended on this task. Captured from time entry records for cost allocation and performance analysis.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work on this task began. Captured from field technician mobile device or time entry system.',
    `completion_date` DATE COMMENT 'Date when the task was marked as completed in the system. May differ from actual_finish_timestamp if there is a delay in system update.',
    `completion_notes` STRING COMMENT 'Summary notes documenting task completion status, results, or any deviations from the planned procedure. Used for audit trail and knowledge management.',
    `craft_code` STRING COMMENT 'Code identifying the skilled trade or craft required to perform this task (e.g., ELEC for electrician, MECH for mechanic, LINEMAN for line worker, RELAY for relay technician).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this task record was first created in the system. Used for audit trail and data lineage.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Estimated total cost for this task including labor, materials, and equipment. Used for budget planning and Capital Expenditure (CAPEX) tracking.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated elapsed time (clock hours) to complete the task, including wait times and non-labor activities. Used for scheduling.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Planned labor hours required to complete this task. Used for scheduling and cost estimation.',
    `failure_code` STRING COMMENT 'Standardized code identifying the type of failure or issue addressed by this task. Used for failure mode analysis and reliability engineering.',
    `inspection_result` STRING COMMENT 'Result of inspection tasks. Indicates whether the inspected asset or component passed inspection criteria.. Valid values are `pass|fail|conditional|not_applicable`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether this task must be completed for the work order to be considered complete. True for mandatory tasks, false for optional tasks.',
    `is_safety_critical` BOOLEAN COMMENT 'Indicates whether this task involves safety-critical procedures requiring special permits, lockout/tagout, or safety oversight. True for safety-critical tasks.',
    `measurement_unit` STRING COMMENT 'Unit of measure for the measurement_value (e.g., kV, psi, degrees C, ohms). Ensures proper interpretation of test results.',
    `measurement_value` DECIMAL(18,2) COMMENT 'Numeric measurement or test result captured during task execution (e.g., oil dielectric strength, relay pickup current, gas pressure). Used for condition-based maintenance.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this task record was last modified. Used for audit trail and change tracking.',
    `outage_required` BOOLEAN COMMENT 'Indicates whether this task requires taking equipment or circuits out of service. True for tasks requiring planned outages.',
    `permit_number` STRING COMMENT 'Reference number of the work permit associated with this task. Null if no permit is required.',
    `permit_required` BOOLEAN COMMENT 'Indicates whether a work permit (e.g., hot work permit, confined space permit, switching permit) is required before this task can begin.',
    `priority` STRING COMMENT 'Numeric priority ranking for this task within the work order. Lower numbers indicate higher priority. Used for resource allocation decisions.',
    `scheduled_finish_date` DATE COMMENT 'Planned date when this task is scheduled to be completed. Used for project planning and outage coordination.',
    `scheduled_start_date` DATE COMMENT 'Planned date when this task is scheduled to begin. Used for workforce planning and resource allocation.',
    `skill_level` STRING COMMENT 'Required skill or certification level for the craft performing this task. Ensures qualified personnel are assigned.. Valid values are `apprentice|journeyman|master|specialist`',
    `task_description` STRING COMMENT 'Detailed description of the work to be performed in this task. May include specific instructions, safety requirements, or procedural steps (e.g., Perform transformer oil sampling and analysis, Test relay protection settings).',
    `task_number` STRING COMMENT 'Business identifier for the task within the work order. Often formatted as a sequence or step number (e.g., 10, 20, 30 or 1.1, 1.2).',
    `task_sequence` STRING COMMENT 'Numeric ordering of the task within the work order. Determines the execution order of tasks in multi-step maintenance procedures.',
    `task_status` STRING COMMENT 'Current lifecycle status of the task. Tracks progression through the task workflow.. Valid values are `pending|in_progress|completed|cancelled|on_hold`',
    `task_type` STRING COMMENT 'Classification of the task by work type. Determines the nature of the work activity.. Valid values are `inspection|maintenance|repair|testing|calibration|replacement`',
    `technician_notes` STRING COMMENT 'Free-text notes entered by the technician during or after task completion. May include observations, issues encountered, or recommendations for future work.',
    CONSTRAINT pk_work_order_task PRIMARY KEY(`work_order_task_id`)
) COMMENT 'Individual task or job plan step within a Maximo work order, capturing task sequence number, task description, craft/skill required, estimated labor hours per craft, actual labor hours, task status, completion date, and technician notes. Enables granular tracking of multi-step maintenance procedures (e.g., transformer oil sampling, relay testing, gas leak survey steps) and supports labor cost allocation at the task level. Child entity of work_order.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record. Primary key.',
    `asset_registry_id` BIGINT COMMENT 'Reference to the individual asset to which this PM schedule applies. Null if the schedule applies to an asset class rather than a specific asset.',
    `classification_id` BIGINT COMMENT 'Reference to the asset class to which this PM schedule applies. Null if the schedule applies to a specific individual asset.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: PREVENTIVE MAINTENANCE: Schedules are defined per facility to ensure equipment reliability and meet NERC standards.',
    `job_plan_id` BIGINT COMMENT 'Reference to the job plan template that defines the detailed tasks, labor, materials, and procedures for this PM schedule. Links to the Maximo job plan master.',
    `registry_id` BIGINT COMMENT 'Reference to the individual asset to which this PM schedule applies. Null if the schedule applies to an asset class rather than a specific asset.',
    `annual_opex_budget_allocation` DECIMAL(18,2) COMMENT 'Annual Operations and Maintenance (O&M) budget allocated for this PM program, including labor, materials, and contractor costs. Used for O&M budget forecasting and variance analysis.',
    `auto_generate_wo_flag` BOOLEAN COMMENT 'Indicates whether work orders should be automatically generated by Maximo when the next due date is reached (true) or require manual creation (false).',
    `compliance_mandatory_flag` BOOLEAN COMMENT 'Indicates whether this PM schedule is mandated by regulatory compliance requirements (true) or is a voluntary best-practice program (false).',
    `condition_monitoring_required_flag` BOOLEAN COMMENT 'Indicates whether this PM schedule requires condition monitoring data (e.g., oil analysis, thermography, vibration analysis) to be collected and evaluated as part of the maintenance work.',
    `condition_threshold_unit` STRING COMMENT 'Unit of measure for the condition threshold value (e.g., kV, inches/second, ppm, degrees C, percent).',
    `condition_threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold value that triggers PM work when exceeded (e.g., oil dielectric strength below 30 kV, vibration above 0.5 inches/second). Applicable only for condition-based maintenance strategies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PM schedule record was first created in the system.',
    `crew_type_required` STRING COMMENT 'Type of maintenance crew or skill set required to perform this PM work (e.g., Substation Electrician, Transmission Line Crew, Gas Technician, Relay Technician).',
    `criticality_tier` STRING COMMENT 'Criticality classification of the asset or asset class for this PM schedule: 1 (critical - immediate impact on grid reliability or safety), 2 (essential - significant operational impact), 3 (standard - routine maintenance).',
    `effective_end_date` DATE COMMENT 'Date when this PM schedule is retired or superseded by a new program. Null for active ongoing schedules.',
    `effective_start_date` DATE COMMENT 'Date when this PM schedule becomes active and begins generating work orders. Used for phased rollout of new maintenance programs.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated labor hours required to complete the PM work, used for workforce scheduling and capacity planning.',
    `estimated_outage_duration_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the asset will be out of service if an outage is required for this PM work. Used for outage scheduling and customer impact analysis.',
    `failure_mode_addressed` STRING COMMENT 'Primary failure mode or degradation mechanism that this PM schedule is designed to prevent or detect (e.g., Insulation Breakdown, Bearing Wear, Corrosion, Contact Erosion).',
    `frequency_interval` STRING COMMENT 'Numeric interval value for the PM schedule (e.g., 90 for 90 days, 500 for 500 operating hours). Interpretation depends on frequency_type.',
    `frequency_type` STRING COMMENT 'The basis for scheduling PM work: calendar days (fixed interval), operating hours (runtime-based), meter reading (usage-based), condition trigger (sensor/inspection-based), or event-based (after specific events).. Valid values are `calendar_days|operating_hours|meter_reading|condition_trigger|event_based`',
    `frequency_unit` STRING COMMENT 'Unit of measure for the frequency interval (days, weeks, months, years, operating hours, cycles, or events). [ENUM-REF-CANDIDATE: days|weeks|months|years|hours|cycles|events — 7 candidates stripped; promote to reference product]',
    `last_completion_date` DATE COMMENT 'Date when the most recent PM work order generated from this schedule was completed. Used to calculate next due date.',
    `last_review_date` DATE COMMENT 'Date when this PM schedule was last reviewed and validated by maintenance planning or asset management personnel.',
    `lead_time_days` STRING COMMENT 'Number of days before the next due date that the work order should be generated to allow for planning, scheduling, and resource allocation.',
    `maintenance_strategy_type` STRING COMMENT 'The strategic maintenance approach applied to this PM schedule: time-based (calendar or meter), condition-based (triggered by asset condition), reliability-centered maintenance (RCM), risk-based, predictive (using analytics), or run-to-failure.. Valid values are `time_based|condition_based|reliability_centered_maintenance|risk_based|predictive|run_to_failure`',
    `mean_time_between_maintenance_hours` DECIMAL(18,2) COMMENT 'Target mean time between maintenance interventions for this PM schedule, used to optimize maintenance intervals and balance reliability with cost.',
    `modified_by` STRING COMMENT 'User ID or name of the person who last modified this PM schedule record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this PM schedule record was last modified.',
    `next_due_date` DATE COMMENT 'Calculated date when the next PM work order should be generated based on frequency interval and last completion date. Drives automatic work order creation in Maximo.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of this PM schedule to assess effectiveness and make necessary adjustments.',
    `outage_required_flag` BOOLEAN COMMENT 'Indicates whether this PM work requires taking the asset out of service (true) or can be performed while the asset is energized/operational (false). Critical for outage planning and grid reliability.',
    `plan_review_cycle_months` STRING COMMENT 'Frequency in months at which this PM schedule should be reviewed and updated to ensure continued effectiveness and alignment with asset performance and regulatory requirements.',
    `pm_number` STRING COMMENT 'Business identifier for the PM schedule, externally visible and used in work order generation and maintenance reporting. Equivalent to Maximo PM record number.. Valid values are `^PM-[A-Z0-9]{8,12}$`',
    `priority_code` STRING COMMENT 'Work priority classification for PM work orders generated from this schedule: emergency (immediate), urgent (within 24 hours), high (within 1 week), medium (within 1 month), low (routine scheduling).. Valid values are `emergency|urgent|high|medium|low`',
    `program_name` STRING COMMENT 'Descriptive name of the preventive maintenance program (e.g., Transformer Annual Inspection, Substation Breaker Quarterly Maintenance).',
    `regulatory_driver` STRING COMMENT 'Regulatory requirement or standard that mandates or influences this PM schedule (e.g., NERC CIP-007, PHMSA Part 192, PUC Order 12345). Multiple drivers separated by semicolons.',
    `required_inspection_frequency` STRING COMMENT 'Minimum number of inspections or PM executions required per year to maintain regulatory compliance and asset reliability targets.',
    `safety_permit_required` STRING COMMENT 'Type of safety permit or clearance required for this PM work (e.g., Hot Work Permit, Confined Space Entry, Energized Work Permit, Switching Order). Multiple permits separated by semicolons.',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the PM schedule: active (generating work orders), inactive (not generating work orders), suspended (temporarily paused), under_review (being evaluated for changes), retired (no longer in use).. Valid values are `active|inactive|suspended|under_review|retired`',
    `seasonal_restriction_flag` BOOLEAN COMMENT 'Indicates whether this PM schedule has seasonal restrictions (true) that limit when work can be performed (e.g., transmission line work restricted during peak demand periods).',
    `seasonal_restriction_notes` STRING COMMENT 'Detailed description of seasonal or operational restrictions on when this PM work can be performed (e.g., No work during summer peak June-August, Winter access only).',
    `strategy_rationale` STRING COMMENT 'Business justification and reasoning for the selected maintenance strategy, documenting why this approach was chosen for this asset or asset class.',
    `work_type` STRING COMMENT 'Primary type of maintenance work performed under this PM schedule: inspection, testing, calibration, lubrication, cleaning, adjustment, component replacement, or major overhaul. [ENUM-REF-CANDIDATE: inspection|testing|calibration|lubrication|cleaning|adjustment|replacement|overhaul — 8 candidates stripped; promote to reference product]',
    `created_by` STRING COMMENT 'User ID or name of the maintenance planner or asset manager who created this PM schedule record.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Preventive maintenance program master defining both the strategic maintenance policy and operational scheduling for asset classes and individual assets. Serves as the single source of truth for all PM configuration — equivalent to the Maximo PM record. Captures PM program name, maintenance strategy type (time-based, condition-based, reliability-centered RCM, risk-based), strategy rationale, frequency type and interval (calendar days, operating hours, condition trigger), criticality tier (1-critical, 2-essential, 3-standard), regulatory compliance driver (NERC, PHMSA, PUC), associated job plan template, applicable asset class or individual asset, annual O&M budget allocation, required inspection frequency, last completion date, next due date, schedule status, and plan review cycle. Drives automatic work order generation in Maximo, supports O&M budget forecasting, documents maintenance compliance for regulatory filings, and provides the strategic policy context for maintenance program governance.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`inspection` (
    `inspection_id` BIGINT COMMENT 'Unique identifier for the inspection event record. Primary key.',
    `asset_registry_id` BIGINT COMMENT 'Reference to the physical asset that was inspected (generation unit, transformer, substation, pipeline segment, pole, conductor, etc.).',
    `work_order_id` BIGINT COMMENT 'Reference to the corrective or remedial work order generated as a result of inspection findings, if applicable. Links to Maximo work order.',
    `inspection_work_order_id` BIGINT COMMENT 'Reference to the work order under which this inspection was performed, if applicable. Links to Maximo EAM work order.',
    `technician_id` BIGINT COMMENT 'Reference to the technician or crew member who performed the inspection. Links to workforce technician master.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset that was inspected (generation unit, transformer, substation, pipeline segment, pole, conductor, etc.).',
    `document_id` BIGINT COMMENT 'Reference identifier or URI to the formal inspection report document stored in the enterprise document management system or Maximo attachments.',
    `ambient_temperature_f` DECIMAL(18,2) COMMENT 'Ambient air temperature in degrees Fahrenheit at the time of inspection, relevant for thermographic inspections and equipment performance assessment.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the inspection results were formally approved by the supervisor or engineering authority.',
    `approved_by_supervisor_flag` BOOLEAN COMMENT 'Boolean indicator of whether the inspection results have been reviewed and approved by a supervisor or engineering authority (True = approved, False = pending approval).',
    `asset_condition_score` DECIMAL(18,2) COMMENT 'Quantitative condition score or health index assigned to the asset as a result of this inspection, typically on a 0-100 scale or utility-defined rating system. This is the inspection-derived score that may feed into the asset_condition product.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether corrective action or remediation work is required as a result of this inspection (True = action required, False = no action required).',
    `cost` DECIMAL(18,2) COMMENT 'Total cost incurred for this inspection activity, including labor, equipment, contractor fees, and materials. Captured in USD.',
    `critical_deficiency_count` STRING COMMENT 'Number of critical or high-severity deficiencies identified that pose immediate safety, reliability, or compliance risk and require urgent corrective action.',
    `deficiency_count` STRING COMMENT 'Total number of deficiencies, non-conformances, or issues identified during the inspection that require corrective action.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the inspection activity in hours, calculated from start to end timestamp or manually recorded.',
    `end_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspection activity was completed.',
    `findings_summary` STRING COMMENT 'Narrative summary of the inspection findings, observations, and any anomalies or deficiencies identified during the inspection activity.',
    `frequency_code` STRING COMMENT 'Planned frequency or cadence for this type of inspection: annual, semi-annual, quarterly, monthly, weekly, daily, on-demand, event-driven (triggered by alarm or incident), or regulatory-mandated interval. [ENUM-REF-CANDIDATE: annual|semi_annual|quarterly|monthly|weekly|daily|on_demand|event_driven|regulatory_mandated — 9 candidates stripped; promote to reference product]',
    `gis_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate (decimal degrees) of the inspection location, captured from mobile field systems or GIS.',
    `gis_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate (decimal degrees) of the inspection location, captured from mobile field systems or GIS.',
    `inspection_date` DATE COMMENT 'The calendar date on which the inspection was conducted in the field.',
    `inspection_method` STRING COMMENT 'Technical method or technology used to perform the inspection: visual observation, thermographic (infrared), ultrasonic testing, radiographic testing, magnetic particle, dye penetrant, eddy current, acoustic monitoring, vibration analysis, oil analysis, electrical testing, pressure testing, leak detection, drone aerial survey, or LiDAR scanning. [ENUM-REF-CANDIDATE: visual|thermographic|ultrasonic|radiographic|magnetic_particle|dye_penetrant|eddy_current|acoustic|vibration_analysis|oil_analysis|electrical_testing|pressure_testing|leak_detection|drone_survey|lidar_scan — 15 candidates stripped; promote to reference product]',
    `inspection_number` STRING COMMENT 'Business-facing unique identifier or tracking number for the inspection event, often generated by field systems or Maximo.',
    `inspection_result` STRING COMMENT 'Overall outcome of the inspection: pass (asset meets standards), fail (asset does not meet standards), conditional (pass with minor observations), requires follow-up action, or not applicable.. Valid values are `pass|fail|conditional|requires_follow_up|not_applicable`',
    `inspection_scope` STRING COMMENT 'Description of the scope or extent of the inspection activity, including specific components, systems, or areas covered (e.g., all bushings and insulators, primary and secondary windings, foundation and structural supports).',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection event: scheduled, in progress, completed, cancelled, deferred to future date, or under review by supervisor or engineering.. Valid values are `scheduled|in_progress|completed|cancelled|deferred|under_review`',
    `inspection_type` STRING COMMENT 'Classification of the inspection activity: routine patrol, thermographic (infrared), structural integrity, environmental compliance, NERC CIP cybersecurity, PHMSA pipeline safety, vegetation management, corrosion assessment, relay protection testing, transformer oil analysis, aerial survey, ground inspection, drone inspection, regulatory compliance audit, safety inspection, or quality assurance review. [ENUM-REF-CANDIDATE: routine_patrol|thermographic|structural|environmental|nerc_cip|phmsa_pipeline|vegetation_management|corrosion|relay_protection|transformer_oil_analysis|aerial|ground|drone|regulatory_compliance|safety|quality_assurance — 16 candidates stripped; promote to reference product]',
    `inspector_certification_number` STRING COMMENT 'Professional certification or license number of the inspector (e.g., thermography Level II, NACE corrosion specialist, API pipeline inspector, electrical relay technician certification).',
    `inspector_name` STRING COMMENT 'Full name of the individual who conducted the inspection. May be internal utility crew member, contractor, or third-party auditor.',
    `inspector_organization` STRING COMMENT 'Type of organization that performed the inspection: internal utility staff, external contractor, third-party auditor, or regulatory agency inspector.. Valid values are `internal|contractor|third_party_auditor|regulatory_agency`',
    `location_description` STRING COMMENT 'Textual description of the physical location where the inspection was performed (e.g., Substation 42 Bay 3, Transmission Line 765kV Mile Marker 12.5, Gas Pipeline Segment 4A Valve Station).',
    `next_inspection_due_date` DATE COMMENT 'Calculated or scheduled date for the next required inspection of this asset, based on inspection frequency, regulatory requirements, and current condition assessment.',
    `photo_count` STRING COMMENT 'Number of photographs or images captured during the inspection and attached to the inspection record for documentation and evidence.',
    `priority` STRING COMMENT 'Priority level assigned to the inspection based on asset criticality, regulatory mandate, or risk assessment: critical, high, medium, low, or routine.. Valid values are `critical|high|medium|low|routine`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection record was first created in the source system or data platform.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Date and time when this inspection record was last modified or updated in the source system or data platform.',
    `regulatory_program` STRING COMMENT 'Name or code of the regulatory compliance program under which this inspection was mandated (e.g., NERC CIP-006, PHMSA 49 CFR Part 192, EPA Clean Air Act, OSHA 1910.269, state PUC vegetation management order).',
    `regulatory_requirement_reference` STRING COMMENT 'Specific citation or reference to the regulatory standard, code section, or compliance requirement that mandates this inspection (e.g., NERC CIP-006-6 R1.5, PHMSA §192.465, NESC Rule 218).',
    `risk_level` STRING COMMENT 'Risk level assessment based on inspection findings, considering probability of failure and consequence of failure: critical, high, medium, low, or negligible.. Valid values are `critical|high|medium|low|negligible`',
    `source_system` STRING COMMENT 'Name or code of the operational system from which this inspection record originated (e.g., Maximo EAM, ClickSoftware WFM, mobile field inspection application, third-party contractor system).',
    `source_system_record_code` STRING COMMENT 'Unique identifier or primary key of this inspection record in the source operational system, used for data lineage and reconciliation.',
    `start_timestamp` TIMESTAMP COMMENT 'Precise date and time when the inspection activity began, captured from field systems or mobile workforce applications.',
    `supervisor_name` STRING COMMENT 'Full name of the supervisor or engineering authority who reviewed and approved the inspection results.',
    `weather_conditions` STRING COMMENT 'Description of weather conditions at the time of inspection, which may affect inspection quality or asset condition observations (e.g., clear, rain, snow, fog, high wind, extreme temperature).',
    CONSTRAINT pk_inspection PRIMARY KEY(`inspection_id`)
) COMMENT 'Field inspection event record capturing formal asset inspections conducted by utility crews, third-party inspectors, or regulatory auditors. Includes inspection type (routine patrol, thermographic, structural, environmental, NERC CIP, PHMSA pipeline), inspection date, inspector name and certification, inspection result (pass/fail/conditional), findings summary, number of deficiencies identified, corrective action required flag, follow-up work order reference, and regulatory program association. Distinct from asset_condition (which captures the scored health state) — inspection is the event record of the inspection activity itself.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`failure_event` (
    `failure_event_id` BIGINT COMMENT 'Unique identifier for the asset failure event record. Primary key for the failure event entity.',
    `asset_registry_id` BIGINT COMMENT 'Reference to the physical asset that experienced the failure. Links to the asset registry for equipment details, location, and specifications.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: OUTAGE ANALYSIS: Failure events are reported by parcel to assess customer impact and regulatory outage metrics.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset that experienced the failure. Links to the asset registry for equipment details, location, and specifications.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order created to address this failure event. Links to Maximo work order for repair actions and labor tracking.',
    `asset_age_years` DECIMAL(18,2) COMMENT 'Age of the asset in years at the time of failure. Calculated from asset installation date to failure date. Used for age-based reliability analysis and replacement prioritization.',
    `asset_criticality_tier` STRING COMMENT 'Business criticality classification of the failed asset based on customer impact, system reliability importance, and replacement cost. Tier 1 assets receive highest priority for reliability investment.. Valid values are `tier_1_critical|tier_2_high|tier_3_medium|tier_4_low`',
    `cause_code` STRING COMMENT 'Standardized code identifying the root cause category of the failure. Format: XX-NNN where XX is cause category and NNN is specific cause. Aligns with NERC GADS cause code taxonomy.. Valid values are `^[A-Z]{2}-[0-9]{3}$`',
    `cause_description` STRING COMMENT 'Detailed narrative description of the root cause analysis findings, contributing factors, and conditions that led to the asset failure. Captured from engineering investigation reports.',
    `component_failed` STRING COMMENT 'Specific component, sub-assembly, or part of the asset that experienced the failure. Examples: transformer winding, circuit breaker contact, turbine blade, valve actuator, insulator string.',
    `corrective_action_plan` STRING COMMENT 'Description of long-term corrective actions planned or implemented to prevent recurrence of similar failures. May include design changes, maintenance program updates, or asset replacement decisions.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this failure event record was first created in the system. Audit field for data lineage and record lifecycle tracking.',
    `crew_arrival_timestamp` TIMESTAMP COMMENT 'Date and time when the response crew arrived on site at the failed asset location. Used to calculate travel time and overall response time metrics.',
    `customers_affected` STRING COMMENT 'Number of customer accounts that experienced service interruption as a result of this failure event. Critical input for SAIFI and CAIDI calculations.',
    `detection_method` STRING COMMENT 'Method by which the failure was initially detected. Indicates whether failure was caught by automated systems, operator vigilance, or customer impact.. Valid values are `scada_alarm|operator_observation|protective_relay|routine_inspection|customer_report|automated_monitoring`',
    `energy_not_supplied_mwh` DECIMAL(18,2) COMMENT 'Total energy in megawatt-hours (MWh) that could not be delivered to customers during the outage period. Calculated as load lost multiplied by outage duration.',
    `estimated_revenue_loss_amount` DECIMAL(18,2) COMMENT 'Estimated revenue loss in USD due to energy not supplied during the outage period. Calculated using average retail rates and energy not supplied volume.',
    `failure_date` DATE COMMENT 'Calendar date when the asset failure occurred. Used for reliability trending and MTBF calculations.',
    `failure_event_number` STRING COMMENT 'Business identifier for the failure event used in operational communications and reporting. Format: FE-XXXXXXXXXX.. Valid values are `^FE-[0-9]{10}$`',
    `failure_mode` STRING COMMENT 'Classification of the physical mechanism or mode by which the asset failed. Examples include insulation breakdown, mechanical wear, corrosion, overload, lightning strike, short circuit, thermal fatigue, vibration damage. [ENUM-REF-CANDIDATE: insulation_breakdown|mechanical_wear|corrosion|overload|lightning_strike|short_circuit|thermal_fatigue|vibration_damage|contamination|fatigue_crack|seal_failure|bearing_failure — promote to reference product]. Valid values are `insulation_breakdown|mechanical_wear|corrosion|overload|lightning_strike|short_circuit`',
    `failure_notification_timestamp` TIMESTAMP COMMENT 'Date and time when the failure was first reported or logged in the outage management system. Used to measure detection and response time performance.',
    `failure_severity` STRING COMMENT 'Business impact classification of the failure event based on customer impact, safety risk, and system reliability. Critical failures require immediate response and executive notification.. Valid values are `critical|major|moderate|minor`',
    `failure_timestamp` TIMESTAMP COMMENT 'Precise date and time when the asset failure was detected or occurred. Captured from SCADA alarm systems or operator logs.',
    `failure_type` STRING COMMENT 'High-level categorization of the failure event distinguishing between forced outages, unplanned derates, equipment malfunctions, protective relay trips, cascading failures, and external events.. Valid values are `forced_outage|unplanned_derate|equipment_malfunction|protective_relay_trip|cascading_failure|external_event`',
    `forced_outage_flag` BOOLEAN COMMENT 'Indicates whether this failure resulted in a forced (unplanned) outage requiring immediate removal of the asset from service. True for forced outages, False for failures that did not require immediate outage.',
    `insurance_claim_number` STRING COMMENT 'Insurance claim reference number if a claim was filed for this failure event. Format: INS-XXXXXXXX. Used to track insurance recovery for major equipment failures.. Valid values are `^INS-[0-9]{8}$`',
    `insurance_claim_status` STRING COMMENT 'Current status of the insurance claim associated with this failure event. Tracks claim lifecycle from filing through payment.. Valid values are `not_filed|filed|under_review|approved|denied|paid`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this failure event record was most recently updated. Audit field for change tracking and data quality monitoring.',
    `load_lost_mw` DECIMAL(18,2) COMMENT 'Amount of electrical load in megawatts (MW) that was lost or interrupted due to the failure event. Used for transmission and generation reliability reporting.',
    `major_event_day_flag` BOOLEAN COMMENT 'Indicates whether this failure occurred during a major event day as defined by IEEE 1366 beta method. Major event days may be excluded from reliability performance metrics per regulatory rules.',
    `mtbf_contribution_hours` DECIMAL(18,2) COMMENT 'Operating hours accumulated by the asset since the previous failure event. Used to calculate fleet-level MTBF statistics for asset class reliability benchmarking.',
    `operating_voltage_kv` DECIMAL(18,2) COMMENT 'Nominal operating voltage in kilovolts (kV) of the asset or system where the failure occurred. Used for failure rate analysis by voltage class.',
    `outage_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration in minutes that the asset was out of service due to the failure event. Used for SAIDI, SAIFI, and CAIDI reliability metric calculations.',
    `regulatory_report_number` STRING COMMENT 'Reference number assigned to the regulatory report filed for this failure event. Format: REG-XXXX-NNNNNN where XXXX is agency code. Links to compliance documentation.. Valid values are `^REG-[A-Z]{4}-[0-9]{6}$`',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this failure event meets thresholds requiring mandatory reporting to regulatory bodies such as FERC, NERC, state PUC, or OSHA. True if reportable, False otherwise.',
    `repair_action_taken` STRING COMMENT 'Description of the corrective maintenance actions performed to restore the asset to service. Includes parts replaced, repairs completed, and temporary vs permanent fixes.',
    `repair_cost_amount` DECIMAL(18,2) COMMENT 'Total cost in USD incurred to repair the failed asset including labor, materials, contractor services, and equipment rental. Sourced from work order actuals in Maximo and SAP.',
    `replacement_recommended_flag` BOOLEAN COMMENT 'Indicates whether engineering analysis recommends full asset replacement rather than continued repair. Used to prioritize capital investment and asset replacement programs.',
    `response_crew_dispatched_timestamp` TIMESTAMP COMMENT 'Date and time when field crew was dispatched to respond to the failure event. Used to calculate dispatch time and crew response performance metrics.',
    `restoration_timestamp` TIMESTAMP COMMENT 'Date and time when the asset was successfully returned to service following repair actions. Used to calculate mean time to repair (MTTR).',
    `root_cause_analysis_completed_flag` BOOLEAN COMMENT 'Indicates whether a formal root cause analysis investigation has been completed for this failure event. RCA is typically required for critical and major severity failures.',
    `safety_incident_flag` BOOLEAN COMMENT 'Indicates whether the failure event resulted in or contributed to a worker or public safety incident requiring OSHA reporting or internal safety investigation.',
    `time_since_last_maintenance_days` STRING COMMENT 'Number of days elapsed between the last preventive maintenance activity and this failure event. Used to evaluate maintenance program effectiveness.',
    `weather_condition` STRING COMMENT 'Specific weather condition present at the time of failure if weather-related. Used for correlation analysis and major event day classification. [ENUM-REF-CANDIDATE: lightning|high_wind|ice_storm|flooding|extreme_heat|extreme_cold|normal — 7 candidates stripped; promote to reference product]',
    `weather_related_flag` BOOLEAN COMMENT 'Indicates whether the failure was caused by or contributed to by weather conditions such as lightning, wind, ice, temperature extremes, or flooding. Used for major event day (MED) exclusions in reliability reporting.',
    CONSTRAINT pk_failure_event PRIMARY KEY(`failure_event_id`)
) COMMENT 'Records of asset failures, forced outages, and unplanned equipment failures capturing failure date/time, failure mode (insulation breakdown, mechanical wear, corrosion, overload, lightning strike, etc.), failure severity, affected asset, contributing cause codes, mean time between failures (MTBF) tracking, repair action taken, return-to-service date/time, and associated work order. Feeds reliability metrics (SAIDI, SAIFI, CAIDI) and supports root cause analysis, asset replacement prioritization, and insurance claims. Sourced from OMS/DMS failure records and Maximo failure reporting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` (
    `depreciation_schedule_id` BIGINT COMMENT 'Unique identifier for the depreciation schedule record. Primary key for the depreciation schedule entity.',
    `asset_registry_id` BIGINT COMMENT 'Reference to the physical asset being depreciated. Links to the asset registry in the enterprise asset management system.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Depreciation expense allocation needs cost center reference for OPEX reporting per asset schedule.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset being depreciated. Links to the asset registry in the enterprise asset management system.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: WBS element links depreciation charges to project work breakdown for capital budgeting.',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'The total depreciation expense recognized to date since the asset was placed in service. Represents the cumulative reduction in the assets book value. Expressed in USD.',
    `annual_depreciation_expense` DECIMAL(18,2) COMMENT 'The calculated annual depreciation expense for this asset based on the depreciation method and remaining life. Used for financial reporting and rate case filings. Expressed in USD.',
    `asset_category` STRING COMMENT 'High-level categorization of the asset type for reporting and analysis. Aligns with major business functions and regulatory reporting segments. [ENUM-REF-CANDIDATE: generation|transmission|distribution|gas_distribution|substation|metering|it_equipment|vehicles|buildings|land — 10 candidates stripped; promote to reference product]',
    `asset_class_code` STRING COMMENT 'Internal classification code grouping similar assets for depreciation purposes. Examples include transformers, poles, conductors, meters, generation equipment.',
    `asset_location_code` STRING COMMENT 'Geographic or functional location code for the asset. May reference GIS coordinates, substation ID, service territory, or facility code.',
    `book_reserve_percentage` DECIMAL(18,2) COMMENT 'The accumulated depreciation expressed as a percentage of the original cost. Used in depreciation studies to assess the adequacy of depreciation rates. Also known as reserve ratio.',
    `book_tax_timing_difference` DECIMAL(18,2) COMMENT 'The cumulative difference between book depreciation and tax depreciation, creating deferred tax assets or liabilities. Important for regulatory accounting and rate-making. Expressed in USD.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this depreciation schedule record was first created in the system. Used for audit trail and data lineage tracking.',
    `depreciable_cost_basis` DECIMAL(18,2) COMMENT 'The original cost basis of the asset subject to depreciation, net of any salvage value. Represents the total amount to be depreciated over the assets useful life. Expressed in USD.',
    `depreciation_method` STRING COMMENT 'The accounting method used to calculate depreciation expense for this asset. Straight-line is most common for utility assets under FERC regulations. MACRS (Modified Accelerated Cost Recovery System) is used for tax purposes.. Valid values are `straight_line|declining_balance|sum_of_years_digits|units_of_production|macrs|acrs`',
    `depreciation_rate_percentage` DECIMAL(18,2) COMMENT 'The annual depreciation rate expressed as a percentage of the depreciable cost basis. Calculated based on depreciation method and useful life. Used in regulatory reporting.',
    `depreciation_status` STRING COMMENT 'Current status of the depreciation schedule. Active schedules accrue depreciation expense; suspended schedules are temporarily paused; fully depreciated assets have zero net book value; retired assets are no longer in service.. Valid values are `active|suspended|fully_depreciated|retired|pending_study_revision`',
    `depreciation_study_reference` STRING COMMENT 'Reference identifier or citation to the depreciation study that established the depreciation parameters for this asset class. Depreciation studies are typically conducted every 5-10 years and filed with regulatory commissions.',
    `ferc_account_code` STRING COMMENT 'The FERC Uniform System of Accounts code that classifies this asset for regulatory reporting. Examples include 311 (Intangible Plant), 314 (Transmission Plant), 360-373 (Distribution Plant).. Valid values are `^[0-9]{3,6}$`',
    `impairment_indicator_flag` BOOLEAN COMMENT 'Indicates whether this asset has been flagged for potential impairment testing due to events such as obsolescence, damage, regulatory disallowance, or changes in market conditions.',
    `impairment_loss_amount` DECIMAL(18,2) COMMENT 'The cumulative impairment loss recognized for this asset if its carrying value exceeds its recoverable amount. Expressed in USD. Null if no impairment has been recorded.',
    `in_service_date` DATE COMMENT 'The date the asset was placed into service and began being depreciated. Critical for calculating accumulated depreciation and remaining life.',
    `last_depreciation_run_date` DATE COMMENT 'The date of the most recent depreciation calculation run that updated accumulated depreciation and net book value for this asset. Typically monthly or quarterly.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this depreciation schedule record was last updated. Used for audit trail and change tracking.',
    `modified_by_user` STRING COMMENT 'The user ID or name of the person who last modified this depreciation schedule record. Used for audit trail and accountability.',
    `net_book_value` DECIMAL(18,2) COMMENT 'The current book value of the asset calculated as depreciable cost basis minus accumulated depreciation. Represents the undepreciated value remaining on the balance sheet. Expressed in USD.',
    `next_depreciation_run_date` DATE COMMENT 'The scheduled date for the next depreciation calculation run. Used for planning and ensuring timely financial close.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or explanations regarding the depreciation schedule, such as special regulatory treatment, study assumptions, or adjustments.',
    `original_useful_life_years` DECIMAL(18,2) COMMENT 'The estimated useful life of the asset in years as determined at the time of initial capitalization or most recent depreciation study. Used to calculate annual depreciation rates.',
    `rate_base_eligible_flag` BOOLEAN COMMENT 'Indicates whether this asset is eligible for inclusion in the Regulatory Asset Base (RAB) for rate-making purposes. True for used and useful assets; false for assets not yet in service or disallowed by regulators.',
    `regulatory_approval_reference` STRING COMMENT 'Reference to the regulatory order, rate case docket number, or Certificate of Public Convenience and Necessity (CPCN) that approved the capitalization and depreciation treatment of this asset.',
    `regulatory_jurisdiction` STRING COMMENT 'The regulatory authority governing the depreciation treatment of this asset. Federal jurisdiction applies to interstate transmission assets under FERC; state jurisdiction applies to distribution and generation assets under state PUCs.. Valid values are `federal|state|municipal|joint`',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'The estimated remaining useful life of the asset in years from the current date. Used for capital planning, replacement forecasting, and rate base calculations.',
    `retirement_date` DATE COMMENT 'The date the asset was retired from service and depreciation ceased. Null for assets still in service.',
    `salvage_value` DECIMAL(18,2) COMMENT 'The estimated residual value of the asset at the end of its useful life. Subtracted from original cost to determine depreciable cost basis. May be zero for many utility assets. Expressed in USD.',
    `salvage_value_percentage` DECIMAL(18,2) COMMENT 'The salvage value expressed as a percentage of the original asset cost. Commonly used in depreciation studies and rate case filings.',
    `schedule_effective_date` DATE COMMENT 'The date when this depreciation schedule becomes effective for the asset. Typically the asset in-service date or the date of a depreciation study revision.',
    `tax_depreciation_life_years` DECIMAL(18,2) COMMENT 'The useful life used for tax depreciation purposes, which may differ from book depreciation life. Determined by IRS asset class and recovery period tables.',
    `tax_depreciation_method` STRING COMMENT 'The depreciation method used for income tax purposes, which may differ from book depreciation. MACRS (Modified Accelerated Cost Recovery System) is most common for tax purposes.. Valid values are `macrs|acrs|straight_line|bonus_depreciation|section_179`',
    `wbs_element` STRING COMMENT 'The project WBS element if this asset was capitalized as part of a capital project. Links to SAP PS project structure for CAPEX tracking and reporting.',
    CONSTRAINT pk_depreciation_schedule PRIMARY KEY(`depreciation_schedule_id`)
) COMMENT 'Asset depreciation schedule records aligned with FERC Uniform System of Accounts and FASB ASC 980 regulated operations accounting. Captures asset ID, depreciation method (straight-line, MACRS, units-of-production), depreciable cost basis, accumulated depreciation to date, annual depreciation expense, net book value, remaining depreciable life, salvage value estimate, depreciation study reference, and effective date. Supports RAB (Regulatory Asset Base) calculation for rate case filings with state PUCs and FERC. Integrates with SAP FI/CO fixed asset module.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` (
    `asset_capex_project_id` BIGINT COMMENT 'Unique identifier for the capital expenditure project record. Primary key.',
    `classification_id` BIGINT COMMENT 'Foreign key linking to asset.classification. Business justification: Capex project is associated with an asset class; replace free‑text asset_class with FK to classification for consistency.',
    `cost_center_id` BIGINT COMMENT 'Cost center identifier for the organizational unit responsible for the capital project budget and expenditures.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: CAPITAL PLANNING: Projects are tied to a specific facility for budgeting, regulatory approval, and cost allocation.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: Capital Project Procurement Link; associates a capex project with its procurement contract, required for contract compliance, milestone reporting, and audit of project expenditures.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Capital project management requires linking each capex project to its responsible employee manager for budgeting, reporting, and regulatory compliance.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: CAPITAL PLANNING: Large projects (e.g., new generation site) require site linkage for environmental permits and reporting.',
    `wbs_element_id` BIGINT COMMENT 'SAP Work Breakdown Structure element identifier linking the capital project to the financial and project management hierarchy.',
    `actual_spend_to_date_amount` DECIMAL(18,2) COMMENT 'Cumulative actual capital expenditure incurred on the project as of the current reporting period, expressed in USD.',
    `budget_variance_amount` DECIMAL(18,2) COMMENT 'Difference between the total authorized budget and the forecast at completion, indicating over or under budget status, expressed in USD.',
    `contingency_reserve_amount` DECIMAL(18,2) COMMENT 'Contingency reserve budget allocated for unforeseen risks and changes during project execution, expressed in USD.',
    `cpcn_number` STRING COMMENT 'Certificate number issued by the state Public Utility Commission (PUC) or Public Service Commission (PSC) authorizing the utility to construct or acquire major capital assets.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital project record was first created in the system.',
    `depreciation_method` STRING COMMENT 'Depreciation method to be applied to the capital asset once placed in service (e.g., Straight-Line, Declining Balance, Units of Production).',
    `environmental_permit_number` STRING COMMENT 'Reference number for the environmental permit or approval obtained for the capital project.',
    `environmental_permit_required_flag` BOOLEAN COMMENT 'Indicates whether the capital project requires environmental permits or assessments from EPA or state environmental agencies.',
    `ferc_account_code` STRING COMMENT 'FERC Uniform System of Accounts code for the capital asset classification, used for regulatory reporting and rate base determination.',
    `forecast_at_completion_amount` DECIMAL(18,2) COMMENT 'Projected total capital expenditure at project completion based on current actuals and remaining estimates, expressed in USD.',
    `funding_source` STRING COMMENT 'Source of capital funding for the project, such as rate base recovery, debt financing, equity, grants, or customer contributions.',
    `geographic_region` STRING COMMENT 'Geographic region or service territory where the capital project is located (e.g., Northern Region, Southern Region, Metro Area).',
    `in_service_date_actual` DATE COMMENT 'Actual date when the capital asset or system was placed into operational service, triggering depreciation and rate base inclusion.',
    `in_service_date_target` DATE COMMENT 'Target date when the capital asset or system is planned to be placed into operational service and begin depreciation.',
    `irp_alignment_flag` BOOLEAN COMMENT 'Indicates whether the capital project is aligned with and included in the utilitys approved Integrated Resource Plan (IRP).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the capital project record was last updated or modified.',
    `planning_horizon` STRING COMMENT 'Time horizon category for capital planning purposes: 1-year (near-term), 5-year (mid-term), or 10-year (long-term) planning cycle.. Valid values are `1_year|5_year|10_year`',
    `project_completion_date` DATE COMMENT 'Date when the capital project was officially closed and all deliverables were completed.',
    `project_description` STRING COMMENT 'Detailed narrative description of the capital project scope, objectives, deliverables, and business justification.',
    `project_name` STRING COMMENT 'Descriptive name of the capital project for human identification and reporting purposes.',
    `project_number` STRING COMMENT 'Business identifier for the CAPEX project, typically the SAP Work Breakdown Structure (WBS) element or project code used across financial and project management systems.',
    `project_start_date` DATE COMMENT 'Date when the capital project officially commenced, marking the beginning of planning or execution activities.',
    `project_status` STRING COMMENT 'Current lifecycle phase of the capital project: planning, design, procurement, construction, commissioning, or closed.. Valid values are `planning|design|procurement|construction|commissioning|closed`',
    `project_type` STRING COMMENT 'Classification of the capital project by its primary purpose: new construction, asset replacement, system upgrade, compliance-driven investment, capacity expansion, or technology modernization.. Valid values are `new_construction|replacement|upgrade|compliance_driven|capacity_expansion|technology_modernization`',
    `rab_inclusion_flag` BOOLEAN COMMENT 'Indicates whether the capital project is included in the Regulatory Asset Base (RAB) for rate-making purposes.',
    `rate_case_reference` STRING COMMENT 'Reference identifier for the General Rate Case (GRC) filing in which the capital project is included for cost recovery.',
    `regulatory_approval_reference` STRING COMMENT 'Reference number or identifier for the regulatory approval or Certificate of Public Convenience and Necessity (CPCN) authorizing the capital investment.',
    `replacement_driver` STRING COMMENT 'Primary business or technical reason driving the asset replacement or capital investment: end-of-life, condition-based assessment, regulatory compliance, capacity constraints, or technology obsolescence.. Valid values are `end_of_life|condition_based|compliance|capacity|technology_obsolescence`',
    `replacement_priority_score` STRING COMMENT 'Numerical score representing the relative priority of the replacement project based on risk, condition, criticality, and business impact assessment.',
    `safety_classification` STRING COMMENT 'Safety risk classification of the capital project based on OSHA and internal safety standards (e.g., High Risk, Medium Risk, Low Risk).',
    `service_territory_code` STRING COMMENT 'Code identifying the specific service territory or operating area where the capital project is deployed.',
    `sponsoring_business_unit` STRING COMMENT 'The organizational division or business unit responsible for sponsoring and owning the capital project (e.g., Generation, Transmission, Distribution, Gas Operations).',
    `total_authorized_budget_amount` DECIMAL(18,2) COMMENT 'Total capital expenditure budget authorized for the project by executive management or board approval, expressed in USD.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the capital asset in years, used for depreciation calculation and asset management planning.',
    CONSTRAINT pk_asset_capex_project PRIMARY KEY(`asset_capex_project_id`)
) COMMENT 'Capital expenditure project master for utility infrastructure investments including new construction, major refurbishment, system upgrades, technology modernization, and asset replacement programs. Captures project number (SAP WBS element), project name, project type (new construction, replacement, upgrade, compliance-driven, capacity expansion), sponsoring business unit, total authorized budget (CAPEX), actual spend to date, forecast at completion, project phase (planning, design, procurement, construction, commissioning, closed), in-service date target, regulatory approval reference (CPCN), IRP alignment flag, replacement driver (end-of-life, condition-based, compliance, capacity, technology obsolescence), replacement priority score, planning horizon (1-year, 5-year, 10-year), and funding source. Integrates with SAP PS (Project System) and supports CAPEX planning, replacement program management, and rate case capital testimony.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` (
    `lifecycle_event_id` BIGINT COMMENT 'Primary key for lifecycle_event',
    `approved_by_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the event.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who authorized the lifecycle event.',
    `filing_id` BIGINT COMMENT 'Identifier of the regulatory report generated for this event, if applicable.',
    `primary_lifecycle_asset_registry_id` BIGINT COMMENT 'Unique identifier of the physical asset to which the lifecycle event applies.',
    `technician_id` BIGINT COMMENT 'Identifier of the employee or contractor who authorized the lifecycle event.',
    `registry_id` BIGINT COMMENT 'Unique identifier of the physical asset to which the lifecycle event applies.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that triggered or is associated with this lifecycle event.',
    `approval_status` STRING COMMENT 'Current approval state of the event.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the event was approved.',
    `asset_condition_after` STRING COMMENT 'Condition rating of the asset after the event.. Valid values are `good|fair|poor`',
    `asset_condition_before` STRING COMMENT 'Condition rating of the asset prior to the event.. Valid values are `good|fair|poor`',
    `asset_location_code` STRING COMMENT 'Standardized code representing the assets primary location (e.g., substation or plant code).',
    `asset_serial_number` STRING COMMENT 'Manufacturer‑assigned serial number of the asset.',
    `asset_tag_number` STRING COMMENT 'Physical tag number affixed to the asset.',
    `capital_expenditure_flag` BOOLEAN COMMENT 'True if the event is classified as a capital expenditure.',
    `compliance_status` STRING COMMENT 'Compliance outcome after the event.. Valid values are `compliant|non_compliant|pending`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary cost directly attributable to the lifecycle event.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost amount.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `depreciation_impact_amount` DECIMAL(18,2) COMMENT 'Change to the assets depreciation schedule caused by the event.',
    `depreciation_impact_type` STRING COMMENT 'Nature of the depreciation impact.. Valid values are `increase|decrease|none`',
    `emissions_change_tons_co2e` DECIMAL(18,2) COMMENT 'Net change in CO₂‑equivalent emissions attributable to the event, expressed in metric tons.',
    `environmental_impact_flag` BOOLEAN COMMENT 'True if the event has a measurable environmental impact (e.g., emissions change).',
    `event_category` STRING COMMENT 'High‑level classification of the lifecycle event.. Valid values are `installation|modification|maintenance|retirement|transfer|disposal`',
    `event_document_reference` STRING COMMENT 'Reference (e.g., URL or file ID) to supporting documentation for the event.',
    `event_effective_date` DATE COMMENT 'Date on which the new status becomes effective.',
    `event_expiration_date` DATE COMMENT 'Date on which the events effect expires, if applicable.',
    `event_location_latitude` DOUBLE COMMENT 'Latitude coordinate of the asset at the time of the event.',
    `event_location_longitude` DOUBLE COMMENT 'Longitude coordinate of the asset at the time of the event.',
    `event_notes` STRING COMMENT 'Free‑text notes providing additional context or justification for the event.',
    `event_sequence_number` STRING COMMENT 'Sequential number of the event for the given asset, starting at 1.',
    `event_source_type` STRING COMMENT 'Indicates whether the event originated from an automated system or manual entry.. Valid values are `system|manual`',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the lifecycle event occurred, recorded in UTC.',
    `event_type` STRING COMMENT 'Type of lifecycle transition (e.g., commissioned, transferred, modified, refurbished, retired, disposed, written-off).',
    `impact_on_rab_flag` BOOLEAN COMMENT 'True if the event changes the assets contribution to the Regulatory Asset Base.',
    `is_manual_entry` BOOLEAN COMMENT 'True if the event was entered manually rather than generated by a system.',
    `new_status` STRING COMMENT 'Asset status code after the event was applied.',
    `opex_expenditure_flag` BOOLEAN COMMENT 'True if the event is classified as an operating expense.',
    `previous_status` STRING COMMENT 'Asset status code before the event was applied.',
    `project_reference` STRING COMMENT 'Identifier of the capital project associated with the event, if any.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the event record was first loaded into the lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the event record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the event must be reported to a regulatory body.',
    `source_system` STRING COMMENT 'System of record that originated the event data.. Valid values are `Maximo|ArcGIS|SAP|Oracle|GE|Allegro`',
    `warranty_status_after` STRING COMMENT 'Warranty coverage status after the event.. Valid values are `active|expired|none`',
    `warranty_status_before` STRING COMMENT 'Warranty coverage status before the event.. Valid values are `active|expired|none`',
    CONSTRAINT pk_lifecycle_event PRIMARY KEY(`lifecycle_event_id`)
) COMMENT 'Chronological log of significant lifecycle state transitions for each asset, capturing event type (commissioned, transferred, modified, refurbished, retired, disposed, written-off), event date, previous status, new status, triggering work order or project reference, authorizing personnel, and event notes. Provides a complete audit trail of an assets life from installation through retirement. Supports ISO 55000 lifecycle management, regulatory asset tracking, and insurance valuation. Distinct from asset_condition (health snapshots) and failure_event (unplanned failures).';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` (
    `risk_assessment_id` BIGINT COMMENT 'Primary key for risk_assessment',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who performed the risk assessment, linking to SAP HR records.',
    `asset_capex_project_id` BIGINT COMMENT 'Reference to the capital project in SAP ERP that includes this asset replacement or upgrade, if the mitigation action requires capital investment.',
    `asset_registry_id` BIGINT COMMENT 'Reference to the physical asset being assessed for risk. Links to the asset registry in Maximo EAM.',
    `work_order_id` BIGINT COMMENT 'Reference to the Maximo work order created to execute the risk mitigation action, if applicable.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: RISK MANAGEMENT: Parcel location is needed to evaluate environmental and community exposure in risk scores.',
    `filing_id` BIGINT COMMENT 'Reference identifier for the General Rate Case (GRC) or other regulatory filing that includes this asset risk assessment as justification for capital investment.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset being assessed for risk. Links to the asset registry in Maximo EAM.',
    `rate_case_id` BIGINT COMMENT 'Reference identifier for the General Rate Case (GRC) or other regulatory filing that includes this asset risk assessment as justification for capital investment.',
    `technician_id` BIGINT COMMENT 'Employee identifier of the person who performed the risk assessment, linking to SAP HR records.',
    `assessment_date` DATE COMMENT 'Date when the risk assessment was performed or last updated.',
    `assessment_method` STRING COMMENT 'Methodology used to perform the risk assessment (quantitative analysis, qualitative scoring, condition-based assessment, age-based analysis, or hybrid approach).. Valid values are `quantitative|qualitative|semi_quantitative|condition_based|age_based|hybrid`',
    `assessment_notes` STRING COMMENT 'Free-text notes providing additional context, assumptions, data sources, or special considerations for the risk assessment.',
    `assessor_name` STRING COMMENT 'Name of the engineer or analyst who performed the risk assessment.',
    `asset_age_years` DECIMAL(18,2) COMMENT 'Age of the asset in years at the time of risk assessment, calculated from in-service date. Key input for age-based risk models.',
    `asset_condition_index` DECIMAL(18,2) COMMENT 'Numerical index representing the current physical condition of the asset based on inspection findings, test results, and maintenance history. Typically scaled 0-100 where higher values indicate better condition.',
    `asset_health_score` DECIMAL(18,2) COMMENT 'Overall health score combining condition, performance, and reliability metrics. Used as input to probability of failure calculations.',
    `composite_risk_index` DECIMAL(18,2) COMMENT 'Overall risk score calculated by combining probability of failure and consequence of failure scores. Typically computed as POF × (weighted sum of COF components). Used for asset prioritization and CAPEX planning.',
    `consequence_of_failure_environmental_score` DECIMAL(18,2) COMMENT 'Score quantifying the environmental impact if the asset fails, including potential for spills, emissions, contamination, and EPA compliance violations.',
    `consequence_of_failure_financial_score` DECIMAL(18,2) COMMENT 'Score quantifying the direct and indirect financial impact if the asset fails, including replacement cost, lost revenue, regulatory fines, and emergency response costs.',
    `consequence_of_failure_reliability_score` DECIMAL(18,2) COMMENT 'Score quantifying the reliability and service continuity impact if the asset fails, including effects on SAIDI, SAIFI, and customer interruptions.',
    `consequence_of_failure_safety_score` DECIMAL(18,2) COMMENT 'Score quantifying the safety impact if the asset fails, including risk to personnel, public safety, and OSHA compliance exposure.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk assessment record was first created in the system.',
    `criticality_score` DECIMAL(18,2) COMMENT 'Score representing the importance of the asset to system operations, based on number of customers served, load magnitude, redundancy availability, and strategic importance.',
    `customers_at_risk_count` STRING COMMENT 'Number of customers who would be affected by failure of this asset. Key input to consequence of failure reliability scoring and regulatory reporting.',
    `data_quality_score` DECIMAL(18,2) COMMENT 'Score representing the quality and completeness of input data used for the risk assessment. Higher scores indicate more reliable risk estimates.',
    `estimated_failure_cost_usd` DECIMAL(18,2) COMMENT 'Estimated total cost in USD if the asset fails, including emergency response, lost revenue, regulatory fines, customer compensation, and reputational damage.',
    `estimated_replacement_cost_usd` DECIMAL(18,2) COMMENT 'Estimated cost in USD to replace the asset with equivalent functionality, including equipment, labor, engineering, and project management. Used for consequence of failure financial scoring and CAPEX planning.',
    `expected_useful_life_years` DECIMAL(18,2) COMMENT 'Expected useful life of the asset in years based on manufacturer specifications, industry standards, and utility experience. Used to calculate remaining life and depreciation schedules.',
    `load_at_risk_mw` DECIMAL(18,2) COMMENT 'Total electrical load in megawatts that would be interrupted if this asset fails. Used for consequence of failure reliability calculations.',
    `loading_factor_percent` DECIMAL(18,2) COMMENT 'Percentage of rated capacity at which the asset is currently operating. High loading accelerates aging and increases failure probability.',
    `mitigation_action_recommended` STRING COMMENT 'Recommended action to mitigate the identified risk, such as accelerated replacement, enhanced monitoring, load transfer, preventive maintenance upgrade, or operational restrictions.',
    `mitigation_priority` STRING COMMENT 'Priority level for executing the recommended mitigation action based on risk tier, asset criticality, and available resources.. Valid values are `immediate|urgent|high|medium|low|monitor`',
    `mitigation_status` STRING COMMENT 'Current status of the risk mitigation action execution.. Valid values are `not_started|planned|in_progress|completed|deferred|cancelled`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk assessment record was last modified.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next periodic risk assessment of this asset. Assessment frequency is typically based on asset criticality and risk tier.',
    `probability_of_failure_score` DECIMAL(18,2) COMMENT 'Numerical score representing the likelihood that the asset will fail within a defined time horizon. Typically scaled 0-100 or 0-10 depending on methodology.',
    `regulatory_justification_flag` BOOLEAN COMMENT 'Indicates whether this risk assessment is being used to justify capital investment in a rate case filing with the PUC or other regulatory body.',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Estimated remaining useful life of the asset in years. Calculated as expected useful life minus asset age, adjusted for condition and operational factors.',
    `review_date` DATE COMMENT 'Date when the risk assessment was reviewed and approved by management or engineering leadership.',
    `risk_driver_primary` STRING COMMENT 'The dominant factor contributing to the assets risk profile (asset age, physical condition, operational loading, environmental exposure, criticality of served load, or technological obsolescence).. Valid values are `age|condition|loading|environmental_exposure|criticality|obsolescence`',
    `risk_driver_secondary` STRING COMMENT 'The secondary factor contributing to the assets risk profile. Provides additional context for risk mitigation planning.. Valid values are `age|condition|loading|environmental_exposure|criticality|obsolescence`',
    `risk_tier` STRING COMMENT 'Categorical classification of the asset risk level based on the composite risk index. Used to prioritize maintenance, replacement, and capital investment decisions.. Valid values are `critical|high|medium|low|negligible`',
    `target_mitigation_date` DATE COMMENT 'Target date by which the recommended mitigation action should be completed to reduce risk to acceptable levels.',
    CONSTRAINT pk_risk_assessment PRIMARY KEY(`risk_assessment_id`)
) COMMENT 'Risk assessment records for utility assets capturing probability of failure score, consequence of failure score (safety, reliability, environmental, financial), composite risk index, risk tier classification (high/medium/low), risk driver (age, condition, loading, environmental exposure, criticality of served load), recommended risk mitigation action, target mitigation date, and risk assessment date. Supports risk-based asset management per ISO 55000, CAPEX prioritization for replacement programs, and regulatory justification for capital investments in rate cases.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`operational_reading` (
    `operational_reading_id` BIGINT COMMENT 'Primary key for operational_reading',
    `asset_registry_id` BIGINT COMMENT 'Reference to the physical utility asset (transformer, substation, pipeline, generating unit, etc.) from which this operational reading was captured.',
    `employee_id` BIGINT COMMENT 'Reference to the user or engineer who validated this operational reading, ensuring data quality and accuracy for analytics and reporting.',
    `inspection_id` BIGINT COMMENT 'Reference to the formal asset inspection event during which this reading was recorded, supporting compliance and condition assessment workflows.',
    `registry_id` BIGINT COMMENT 'Reference to the physical utility asset (transformer, substation, pipeline, generating unit, etc.) from which this operational reading was captured.',
    `scada_point_id` BIGINT COMMENT 'Reference to the specific SCADA point or tag in the SCADA system from which this measurement was retrieved, enabling traceability to real-time operational data sources.',
    `technician_id` BIGINT COMMENT 'Reference to the field technician or operator who manually recorded this measurement, if applicable. Used for accountability and quality assurance.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance work order during which this operational reading was captured, if applicable. Links measurement to preventive or corrective maintenance activity.',
    `alarm_severity_level` STRING COMMENT 'Severity classification of the alarm or alert triggered by this measurement if a threshold breach occurred (normal, low, medium, high, critical). Used for prioritizing maintenance and operational response.. Valid values are `NORMAL|LOW|MEDIUM|HIGH|CRITICAL`',
    `ambient_temperature` DECIMAL(18,2) COMMENT 'The ambient environmental temperature in degrees Celsius at the time of measurement, used for temperature-dependent asset performance analysis.',
    `asset_condition_score` DECIMAL(18,2) COMMENT 'Calculated or assessed condition score for the asset based on this measurement, typically on a scale of 0-100, where higher scores indicate better asset health. Used for predictive maintenance and asset lifecycle planning.',
    `calibration_due_date` DATE COMMENT 'The date by which the measurement instrument must be recalibrated to ensure accuracy and compliance with operational standards.',
    `compliance_threshold_exceeded_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this measurement exceeded a regulatory compliance threshold, requiring notification or corrective action per NERC, FERC, or state PUC requirements.',
    `data_lineage_code` STRING COMMENT 'Unique identifier for tracking the data lineage and transformation history of this operational reading from source system through integration and analytics layers.',
    `data_validation_status` STRING COMMENT 'Status of the data validation process for this operational reading (pending validation, validated and approved, rejected as erroneous, under review by engineering).. Valid values are `PENDING|VALIDATED|REJECTED|UNDER_REVIEW`',
    `instrument_tag_code` STRING COMMENT 'Unique identifier or tag number of the measurement instrument or sensor that recorded this reading. Used for traceability and calibration tracking.',
    `last_calibration_date` DATE COMMENT 'The date when the measurement instrument was last calibrated, ensuring the reading accuracy and reliability.',
    `measurement_location_description` STRING COMMENT 'Textual description of the specific physical location or component on the asset where the measurement was taken (e.g., top oil temperature sensor, phase A bushing, inlet valve, bearing housing).',
    `measurement_method_code` STRING COMMENT 'The method or frequency by which this measurement is captured (continuous real-time monitoring, periodic manual reading, scheduled automated collection, on-demand measurement, condition-based trigger).. Valid values are `CONTINUOUS_MONITORING|PERIODIC_MANUAL|SCHEDULED_AUTOMATED|ON_DEMAND|CONDITION_BASED`',
    `measurement_notes` STRING COMMENT 'Free-text field for technician or system comments regarding the measurement, including observations, anomalies, or contextual information relevant to interpretation.',
    `measurement_quality_code` STRING COMMENT 'Quality indicator for the operational reading reflecting data integrity, sensor health, and reliability of the measurement (good, questionable, bad, substituted value, estimated value, calibration required).. Valid values are `GOOD|QUESTIONABLE|BAD|SUBSTITUTED|ESTIMATED|CALIBRATION_REQUIRED`',
    `measurement_source` STRING COMMENT 'The system or method by which the operational reading was captured (SCADA system, OSIsoft PI Historian, manual field reading by technician, laboratory analysis, Distribution Management System, Energy Management System, IoT sensor, portable field instrument). [ENUM-REF-CANDIDATE: SCADA|PI_HISTORIAN|MANUAL_FIELD|LAB_ANALYSIS|DMS|EMS|SENSOR_IOT|PORTABLE_INSTRUMENT — 8 candidates stripped; promote to reference product]',
    `measurement_timestamp` TIMESTAMP COMMENT 'The precise date and time when the operational measurement was recorded or observed in the field or by the monitoring system.',
    `measurement_type_code` STRING COMMENT 'Standardized code identifying the type of operational measurement being recorded (transformer loading percentage, oil temperature, dissolved gas analysis parts per million, cable insulation resistance megaohms, gas pipeline pressure pounds per square inch, vibration level, battery state-of-charge, voltage, current, power factor, frequency, flow rate). [ENUM-REF-CANDIDATE: XFMR_LOAD_PCT|OIL_TEMP|DGA_PPM|CABLE_INSUL_RESIST|GAS_PRESSURE|VIBRATION|BATTERY_SOC|VOLTAGE|CURRENT|POWER_FACTOR|FREQUENCY|FLOW_RATE — 12 candidates stripped; promote to reference product]',
    `measurement_value` DECIMAL(18,2) COMMENT 'The numeric value of the operational reading as recorded by the measurement instrument or system. Precision supports high-accuracy sensor data.',
    `operating_condition_code` STRING COMMENT 'Code describing the operational state or load condition of the asset at the time the measurement was taken (normal load, peak load, off-peak, startup, shutdown, maintenance mode, emergency operation, testing). [ENUM-REF-CANDIDATE: NORMAL_LOAD|PEAK_LOAD|OFF_PEAK|STARTUP|SHUTDOWN|MAINTENANCE|EMERGENCY|TESTING — 8 candidates stripped; promote to reference product]',
    `pi_tag_name` STRING COMMENT 'The OSIsoft PI Historian tag name associated with this operational reading, used for time-series data retrieval and historian integration.',
    `reading_sequence_number` STRING COMMENT 'Sequential order number of this reading within a series of measurements for the same asset and measurement type, used for time-series analysis and trend detection.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The date and time when this operational reading record was first inserted into the data management system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this operational reading record was last modified or updated in the data management system.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this operational reading must be included in regulatory compliance reports to FERC, NERC, state PUCs, or other governing bodies.',
    `source_system_code` STRING COMMENT 'Code identifying the originating system of record for this operational reading (Maximo EAM, OSIsoft PI Historian, SCADA, Esri ArcGIS, GE PowerOn DMS, EMS, manual field entry). [ENUM-REF-CANDIDATE: MAXIMO|PI_HISTORIAN|SCADA|GIS|DMS|EMS|MANUAL_ENTRY — 7 candidates stripped; promote to reference product]',
    `threshold_breach_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether the measured value exceeded a predefined operational threshold or alarm limit, triggering potential maintenance or operational response.',
    `threshold_lower_limit` DECIMAL(18,2) COMMENT 'The minimum acceptable value for this measurement type. Values below this threshold may indicate asset degradation or operational risk.',
    `threshold_upper_limit` DECIMAL(18,2) COMMENT 'The maximum acceptable value for this measurement type. Values above this threshold may indicate asset stress, overload, or failure risk.',
    `trend_direction_code` STRING COMMENT 'Indicator of the trend direction for this measurement type over recent readings (improving, stable, degrading, critical decline). Supports predictive maintenance and early warning systems.. Valid values are `IMPROVING|STABLE|DEGRADING|CRITICAL_DECLINE`',
    `unit_of_measure` STRING COMMENT 'The unit in which the measurement value is expressed (percent, degrees Celsius, degrees Fahrenheit, parts per million, megaohms, pounds per square inch, millimeters per second, kilovolts, amperes, megawatts, megavolt-amperes reactive, hertz, gallons per minute, cubic feet per minute, bar). [ENUM-REF-CANDIDATE: PCT|DEGC|DEGF|PPM|MOHM|PSI|MMS|KV|AMP|MW|MVAR|HZ|GPM|CFM|BAR — 15 candidates stripped; promote to reference product]',
    `validation_timestamp` TIMESTAMP COMMENT 'The date and time when this operational reading was validated or approved by engineering or operations personnel.',
    `weather_condition_code` STRING COMMENT 'Weather condition at the time of measurement, relevant for outdoor assets where environmental factors impact performance and readings (clear, rain, snow, wind, extreme heat, extreme cold, storm, fog). [ENUM-REF-CANDIDATE: CLEAR|RAIN|SNOW|WIND|EXTREME_HEAT|EXTREME_COLD|STORM|FOG — 8 candidates stripped; promote to reference product]',
    CONSTRAINT pk_operational_reading PRIMARY KEY(`operational_reading_id`)
) COMMENT 'Periodic operational measurement and performance readings recorded against utility assets, capturing measurement type (transformer loading %, oil temperature, dissolved gas analysis ppm, cable insulation resistance MΩ, gas pipeline pressure PSI, vibration level, battery state-of-charge), measured value, unit of measure, measurement timestamp, measurement source (SCADA/PI Historian, manual field reading, lab analysis), and threshold breach flag. Distinct from AMI meter interval reads (owned by metering domain) — this covers operational asset health measurements from OSIsoft PI Historian and field instruments.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`compliance_document` (
    `compliance_document_id` BIGINT COMMENT 'Primary key for compliance_document',
    `asset_capex_project_id` BIGINT COMMENT 'Reference to the capital project or work order for which this permit or document was obtained. Links compliance documentation to CAPEX planning and project management.',
    `asset_registry_id` BIGINT COMMENT 'Reference to the physical asset or equipment to which this compliance document or permit applies. Links to the asset registry in Maximo EAM.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Permit cost allocation requires cost center for regulatory expense tracking.',
    `facility_id` BIGINT COMMENT 'Reference to the facility, plant, substation, or site to which this compliance document or permit applies. May be used when the document applies to an entire facility rather than a specific asset.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: GL account on permit documents records expense posting for compliance fees.',
    `registry_id` BIGINT COMMENT 'Reference to the physical asset or equipment to which this compliance document or permit applies. Links to the asset registry in Maximo EAM.',
    `superseded_by_document_compliance_document_id` BIGINT COMMENT 'Reference to the compliance document that supersedes or replaces this document. Used to track document revision chains and ensure field crews access the latest version.',
    `access_restriction_flag` BOOLEAN COMMENT 'Indicates whether access to this document is restricted to specific roles or individuals due to security, safety, or regulatory requirements.',
    `active_flag` BOOLEAN COMMENT 'Indicates whether this compliance document or permit is currently active and in force. Inactive records represent superseded, expired, or cancelled documents retained for historical reference.',
    `compliance_conditions` STRING COMMENT 'Detailed text describing the specific conditions, requirements, or restrictions imposed by the regulatory authority as part of the permit or license. May include operational limits, reporting requirements, or environmental mitigation measures.',
    `compliance_status` STRING COMMENT 'Current compliance state of the permit or document. Indicates whether the utility is meeting all conditions and requirements associated with this regulatory document.. Valid values are `compliant|non_compliant|conditional|under_review|suspended`',
    `confidentiality_level` STRING COMMENT 'The data classification level of the document content. Determines access controls and distribution restrictions. Critical Infrastructure Protection (CIP) documents may be restricted.. Valid values are `public|internal|confidential|restricted`',
    `contact_email` STRING COMMENT 'The email address of the responsible party or document owner for inquiries and compliance coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'The phone number of the responsible party or document owner for urgent compliance matters.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance document record was first created in the system. Audit trail for data lineage and compliance tracking.',
    `dms_reference` STRING COMMENT 'The unique identifier or URL reference to the document in the enterprise document management system. Enables direct access to the digital document file.',
    `document_category` STRING COMMENT 'High-level classification of the document by its primary business function. Used for organizing and filtering documents in the document management system.. Valid values are `regulatory|technical|operational|legal|environmental|safety`',
    `document_description` STRING COMMENT 'Detailed narrative description of the compliance document or permit, including its scope, purpose, and any special conditions or requirements.',
    `document_number` STRING COMMENT 'The externally-known unique identifier or permit number assigned by the issuing authority or document management system. Examples include construction permit number, operating license number, environmental permit number, or engineering drawing number.',
    `document_originator` STRING COMMENT 'The person, department, or external contractor who created or authored the document. Relevant for engineering drawings, test reports, and operational manuals.',
    `document_size_mb` DECIMAL(18,2) COMMENT 'The file size of the digital document in megabytes. Used for storage planning and mobile data transfer optimization.',
    `document_title` STRING COMMENT 'The full descriptive title or name of the compliance document or permit as it appears on the official record.',
    `document_type` STRING COMMENT 'Classification of the compliance document or permit. Indicates the nature and purpose of the document within the regulatory and operational framework. [ENUM-REF-CANDIDATE: construction_permit|operating_license|environmental_permit|right_of_way|easement|engineering_drawing|as_built_drawing|test_report|om_manual|relay_setting_sheet|inspection_certificate|compliance_certificate|safety_certificate|other — 14 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'The date on which the permit or document becomes legally binding or operationally effective. May differ from issue date for permits with future start dates.',
    `expiration_date` DATE COMMENT 'The date on which the permit or license expires and must be renewed. Null for documents without expiration such as as-built drawings or permanent easements.',
    `file_format` STRING COMMENT 'The digital file format of the stored document. Important for determining accessibility and compatibility with field crew mobile devices and engineering software. [ENUM-REF-CANDIDATE: pdf|dwg|dxf|docx|xlsx|tiff|jpg|other — 8 candidates stripped; promote to reference product]',
    `gis_reference` STRING COMMENT 'The unique identifier linking this document to a geographic feature or asset location in Esri ArcGIS. Enables spatial analysis and map-based document retrieval.',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether this permit or document requires periodic inspections or audits to maintain compliance.',
    `issue_date` DATE COMMENT 'The date on which the permit was issued by the regulatory authority or the document was officially released. Represents the principal business event timestamp for this compliance record.',
    `issuing_authority` STRING COMMENT 'The regulatory body, government agency, or organization that issued the permit or created the document. Examples include FERC, state PUC, EPA, local municipality, or internal engineering department.',
    `jurisdiction` STRING COMMENT 'The geographic or regulatory jurisdiction under which this document or permit applies. May be federal, state, county, or municipal level.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The date and time when this compliance document record was most recently modified. Audit trail for change tracking and data quality monitoring.',
    `next_inspection_date` DATE COMMENT 'The scheduled date for the next required inspection or compliance audit associated with this permit or document.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, special instructions, or historical context related to the compliance document or permit.',
    `permit_cost_amount` DECIMAL(18,2) COMMENT 'The total cost incurred to obtain or maintain this permit or license, including application fees, legal costs, and consulting expenses. Used for rate case documentation and regulatory asset base (RAB) reporting.',
    `permit_cost_currency` STRING COMMENT 'The currency in which permit costs are denominated. Standardized to USD for this utility.. Valid values are `USD`',
    `regulatory_framework` STRING COMMENT 'The specific regulatory program, statute, or framework under which this permit or document was issued. Examples include Clean Air Act, NERC CIP standards, FERC transmission tariff, or state-specific utility regulations.',
    `renewal_date` DATE COMMENT 'The date by which the permit or license must be renewed to maintain compliance. Used for tracking renewal cycles and compliance deadlines.',
    `renewal_status` STRING COMMENT 'Current state of the permit or license renewal process. Tracks whether the document is current, requires renewal action, or has expired.. Valid values are `current|pending_renewal|renewal_submitted|expired|not_applicable`',
    `responsible_party` STRING COMMENT 'The name or identifier of the individual, department, or contractor responsible for maintaining compliance with this document or permit. Used for accountability and workflow routing.',
    `revision_number` STRING COMMENT 'The version or revision identifier for the document. Tracks changes and updates to engineering drawings, permits, and operational documents over time.',
    `storage_location` STRING COMMENT 'The physical or digital location where the original or official copy of the document is stored. May include document management system reference, file path, cabinet location, or external repository identifier.',
    CONSTRAINT pk_compliance_document PRIMARY KEY(`compliance_document_id`)
) COMMENT 'Regulatory compliance and technical documentation registry linking permits, licenses, engineering drawings, and operational documents to utility assets and facilities. Captures document/permit type (construction permit, operating license, environmental permit, right-of-way, easement, engineering drawing, as-built, test report, O&M manual, relay setting sheet), issuing authority or document originator, document/permit number, revision, issue date, expiration date, renewal status, compliance conditions, storage location (DMS reference), and associated asset or facility. Supports regulatory compliance tracking, field crew access to technical documentation, ISO 55000 information management, and rate case documentation of permit costs.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` (
    `parcel_allocation_id` BIGINT COMMENT 'Primary key for the asset_parcel_allocation association',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset registry',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to parcel',
    `cost_allocation_percentage` DECIMAL(18,2) COMMENT 'Portion of the assets cost allocated to the parcel',
    `geographic_containment_flag` BOOLEAN COMMENT 'Indicates if the asset is geographically contained within the parcel boundaries',
    `network_topology_role` STRING COMMENT 'Role of the asset within the network on this parcel (e.g., feeder, transformer)',
    `outage_propagation_flag` BOOLEAN COMMENT 'Indicates whether an outage on this asset affects the parcels service area',
    `ownership_percentage` DECIMAL(18,2) COMMENT 'Portion of the asset owned on the parcel',
    CONSTRAINT pk_parcel_allocation PRIMARY KEY(`parcel_allocation_id`)
) COMMENT 'Represents the allocation of a physical utility asset to one or more land parcels, capturing ownership and cost split, network role, and operational flags for each allocation.. Existence Justification: An asset can occupy multiple parcels and a parcel can contain multiple assets. The utility actively tracks which portion of an asset resides on each parcel, including ownership and cost allocation percentages, and the role of the asset in the network topology. This relationship is managed as a distinct business entity.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`asset`.`job_plan` (
    `job_plan_id` BIGINT COMMENT 'Primary key for job_plan',
    `registry_id` BIGINT COMMENT 'Identifier of the specific asset instance linked to the plan.',
    `location_id` BIGINT COMMENT 'Reference to the geographic location or site where the plan is applied.',
    `parent_job_plan_id` BIGINT COMMENT 'Self-referencing FK on job_plan (parent_job_plan_id)',
    `approval_status` STRING COMMENT 'Current approval state of the job plan.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the plan.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date‑time when the plan received approval.',
    `associated_asset_type` STRING COMMENT 'Type of physical asset to which the job plan applies.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance clauses that must be satisfied.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the job plan record was first created in the system.',
    `job_plan_description` STRING COMMENT 'Detailed textual description of the plans purpose, scope, and methodology.',
    `effective_end_date` DATE COMMENT 'Date when the job plan expires or is superseded; null if open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the job plan becomes effective and may be used for work orders.',
    `equipment_needed` STRING COMMENT 'List of equipment, tools, or material identifiers required.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected monetary cost to perform the plan, excluding contingencies.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Typical total labor hours required to execute the plan.',
    `frequency` STRING COMMENT 'Standard recurrence interval for the plan execution.',
    `is_template` BOOLEAN COMMENT 'Indicates whether the plan is a reusable template for multiple work orders.',
    `labor_hours_required` DECIMAL(18,2) COMMENT 'Total labor hours allocated for the plan, used for staffing and budgeting.',
    `last_review_date` DATE COMMENT 'Date when the job plan was last reviewed for relevance or compliance.',
    `next_review_date` DATE COMMENT 'Planned future date for the next systematic review of the plan.',
    `plan_code` STRING COMMENT 'Internal alphanumeric code that uniquely identifies the job plan across the enterprise.',
    `plan_name` STRING COMMENT 'Human‑readable name or title of the job plan.',
    `plan_type` STRING COMMENT 'Category of work the plan addresses, such as maintenance or inspection.',
    `priority` STRING COMMENT 'Business priority level used for scheduling and resource allocation.',
    `regulatory_code` STRING COMMENT 'Code referencing the specific regulation (e.g., ISO 55000 clause) applicable to the plan.',
    `required_skill_set` STRING COMMENT 'Comma‑separated list of skill codes or certifications needed to execute the plan.',
    `revision_number` STRING COMMENT 'Sequential revision counter for plan updates.',
    `safety_requirements` STRING COMMENT 'Safety procedures, PPE, and compliance checks required for the plan.',
    `schedule_type` STRING COMMENT 'How the plan is scheduled relative to asset condition or calendar.',
    `job_plan_status` STRING COMMENT 'Current lifecycle status of the job plan.',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the job plan record.',
    `version` STRING COMMENT 'Version label (e.g., v1.0, v2.1) for the job plan.',
    `work_center` STRING COMMENT 'Identifier of the primary work center or crew responsible for the plan.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_job_plan PRIMARY KEY(`job_plan_id`)
) COMMENT 'Master reference table for job_plan. Referenced by job_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_asset_capex_project_id` FOREIGN KEY (`asset_capex_project_id`) REFERENCES `power_and_utilities_v2`.`asset`.`asset_capex_project`(`asset_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_classification_id` FOREIGN KEY (`classification_id`) REFERENCES `power_and_utilities_v2`.`asset`.`classification`(`classification_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ADD CONSTRAINT `fk_asset_registry_parent_asset_registry_id` FOREIGN KEY (`parent_asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_child_asset_asset_registry_id` FOREIGN KEY (`child_asset_asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_child_asset_registry_id` FOREIGN KEY (`child_asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_hierarchy_asset_registry_id` FOREIGN KEY (`hierarchy_asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ADD CONSTRAINT `fk_asset_classification_parent_asset_class_classification_id` FOREIGN KEY (`parent_asset_class_classification_id`) REFERENCES `power_and_utilities_v2`.`asset`.`classification`(`classification_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ADD CONSTRAINT `fk_asset_condition_assessment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_parent_work_order_id` FOREIGN KEY (`parent_work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `power_and_utilities_v2`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ADD CONSTRAINT `fk_asset_work_order_task_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ADD CONSTRAINT `fk_asset_work_order_task_job_plan_id` FOREIGN KEY (`job_plan_id`) REFERENCES `power_and_utilities_v2`.`asset`.`job_plan`(`job_plan_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ADD CONSTRAINT `fk_asset_work_order_task_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ADD CONSTRAINT `fk_asset_work_order_task_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ADD CONSTRAINT `fk_asset_work_order_task_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_classification_id` FOREIGN KEY (`classification_id`) REFERENCES `power_and_utilities_v2`.`asset`.`classification`(`classification_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_job_plan_id` FOREIGN KEY (`job_plan_id`) REFERENCES `power_and_utilities_v2`.`asset`.`job_plan`(`job_plan_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_inspection_work_order_id` FOREIGN KEY (`inspection_work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ADD CONSTRAINT `fk_asset_inspection_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ADD CONSTRAINT `fk_asset_depreciation_schedule_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ADD CONSTRAINT `fk_asset_asset_capex_project_classification_id` FOREIGN KEY (`classification_id`) REFERENCES `power_and_utilities_v2`.`asset`.`classification`(`classification_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ADD CONSTRAINT `fk_asset_lifecycle_event_primary_lifecycle_asset_registry_id` FOREIGN KEY (`primary_lifecycle_asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ADD CONSTRAINT `fk_asset_lifecycle_event_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ADD CONSTRAINT `fk_asset_lifecycle_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ADD CONSTRAINT `fk_asset_risk_assessment_asset_capex_project_id` FOREIGN KEY (`asset_capex_project_id`) REFERENCES `power_and_utilities_v2`.`asset`.`asset_capex_project`(`asset_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ADD CONSTRAINT `fk_asset_risk_assessment_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ADD CONSTRAINT `fk_asset_risk_assessment_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ADD CONSTRAINT `fk_asset_risk_assessment_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ADD CONSTRAINT `fk_asset_operational_reading_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ADD CONSTRAINT `fk_asset_operational_reading_inspection_id` FOREIGN KEY (`inspection_id`) REFERENCES `power_and_utilities_v2`.`asset`.`inspection`(`inspection_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ADD CONSTRAINT `fk_asset_operational_reading_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ADD CONSTRAINT `fk_asset_operational_reading_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities_v2`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ADD CONSTRAINT `fk_asset_compliance_document_asset_capex_project_id` FOREIGN KEY (`asset_capex_project_id`) REFERENCES `power_and_utilities_v2`.`asset`.`asset_capex_project`(`asset_capex_project_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ADD CONSTRAINT `fk_asset_compliance_document_asset_registry_id` FOREIGN KEY (`asset_registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ADD CONSTRAINT `fk_asset_compliance_document_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ADD CONSTRAINT `fk_asset_compliance_document_superseded_by_document_compliance_document_id` FOREIGN KEY (`superseded_by_document_compliance_document_id`) REFERENCES `power_and_utilities_v2`.`asset`.`compliance_document`(`compliance_document_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` ADD CONSTRAINT `fk_asset_parcel_allocation_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_registry_id` FOREIGN KEY (`registry_id`) REFERENCES `power_and_utilities_v2`.`asset`.`registry`(`registry_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities_v2`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities_v2`.`asset`.`job_plan` ADD CONSTRAINT `fk_asset_job_plan_parent_job_plan_id` FOREIGN KEY (`parent_job_plan_id`) REFERENCES `power_and_utilities_v2`.`asset`.`job_plan`(`job_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`asset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities_v2`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` SET TAGS ('dbx_subdomain' = 'master_registry');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Registry Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `asset_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Capex Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `classification_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `control_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Control Zone Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `dsm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Dsm Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `material_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `ot_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ot Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `parent_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `vpp_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vpp Agreement Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Asset Acquisition Cost');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Rating');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|critical');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `condition_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `current_book_value` SET TAGS ('dbx_business_glossary_term' = 'Current Book Value');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `current_book_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production|regulatory');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life (Years)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_business_glossary_term' = 'FERC Account Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3,6}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'reactive|preventive|predictive|condition_based|run_to_failure');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `maximo_asset_number` SET TAGS ('dbx_business_glossary_term' = 'Maximo Asset Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|non_operational|under_maintenance|failed|testing');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `primary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Primary Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Risk Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `scada_monitored_flag` SET TAGS ('dbx_business_glossary_term' = 'SCADA Monitored Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `secondary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Secondary Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `voltage_class_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class (kV)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`registry` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` SET TAGS ('dbx_subdomain' = 'master_registry');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `child_asset_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Child Asset Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `child_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Child Asset Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `criticality_inheritance_flag` SET TAGS ('dbx_business_glossary_term' = 'Criticality Inheritance Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `geographic_containment_flag` SET TAGS ('dbx_business_glossary_term' = 'Geographic Containment Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `gis_feature_relationship_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Relationship Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_description` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Relationship Description');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'functional|spatial|accounting|network|organizational|maintenance');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `maintenance_responsibility_code` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Responsibility Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `maximo_relationship_code` SET TAGS ('dbx_business_glossary_term' = 'Maximo Relationship Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `network_topology_role` SET TAGS ('dbx_business_glossary_term' = 'Network Topology Role');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `network_topology_role` SET TAGS ('dbx_value_regex' = 'upstream|downstream|parallel|redundant|isolated');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `outage_propagation_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Propagation Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `path` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Path');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `primary_hierarchy_flag` SET TAGS ('dbx_business_glossary_term' = 'Primary Hierarchy Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `rab_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base (RAB) Allocation Method');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `rab_allocation_method` SET TAGS ('dbx_value_regex' = 'direct|proportional|shared|excluded');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `relationship_established_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Established Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `relationship_terminated_date` SET TAGS ('dbx_business_glossary_term' = 'Relationship Terminated Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Sequence Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'maximo|arcgis|sap_pm|manual|migration');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `termination_reason_code` SET TAGS ('dbx_value_regex' = 'asset_retired|asset_transferred|reorganization|error_correction|asset_replaced|consolidation');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `validation_status` SET TAGS ('dbx_business_glossary_term' = 'Validation Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `validation_status` SET TAGS ('dbx_value_regex' = 'validated|pending_review|failed|not_validated');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`hierarchy` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` SET TAGS ('dbx_subdomain' = 'master_registry');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Land Parcel Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `network_device_id` SET TAGS ('dbx_business_glossary_term' = 'Network Device Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `network_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `network_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation in Feet');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `gis_feature_class` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Class');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `gis_object_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Object Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Accuracy in Meters');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_business_glossary_term' = 'Hazard Classification');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `hazard_classification` SET TAGS ('dbx_value_regex' = 'none|flood_zone|wildfire_risk|seismic_zone|environmental_sensitive|confined_space');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `is_remote_accessible` SET TAGS ('dbx_business_glossary_term' = 'Remote Accessible Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude Coordinate');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|under_construction|temporarily_closed');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude Coordinate');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `nerc_region` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Region');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Location Notes');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `operating_region` SET TAGS ('dbx_business_glossary_term' = 'Operating Region');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|leased|easement|right_of_way|public_land|customer_premises');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `pole_number` SET TAGS ('dbx_business_glossary_term' = 'Pole Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `rto_iso_territory` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) Territory');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `service_territory_zone` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Zone');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `substation_name` SET TAGS ('dbx_business_glossary_term' = 'Substation Name');
ALTER TABLE `power_and_utilities_v2`.`asset`.`location` ALTER COLUMN `vault_reference` SET TAGS ('dbx_business_glossary_term' = 'Underground Vault Reference');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` SET TAGS ('dbx_subdomain' = 'master_registry');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `classification_id` SET TAGS ('dbx_business_glossary_term' = 'Classification Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `parent_asset_class_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset Class Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `active_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Active Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `active_status` SET TAGS ('dbx_value_regex' = 'active|inactive|deprecated|pending_approval');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By User');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,12}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `asset_class_description` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Description');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `asset_class_level` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Hierarchy Level');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `asset_class_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Name');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `asset_criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `asset_criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `average_unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Cost');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `average_unit_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `average_unit_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Average Unit Cost Currency Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `average_unit_cost_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `capitalization_threshold_amount` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Threshold Amount');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `capitalization_threshold_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `capitalization_threshold_currency` SET TAGS ('dbx_business_glossary_term' = 'Capitalization Threshold Currency Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `capitalization_threshold_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|sum_of_years_digits|units_of_production|group_composite|other');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `ferc_account_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Account Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `ferc_account_number` SET TAGS ('dbx_value_regex' = '^[0-9]{3}(.[0-9]{1,2})?$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `ferc_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `ferc_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `gis_trackable_flag` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Trackable Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `maintenance_strategy` SET TAGS ('dbx_value_regex' = 'reactive|preventive|predictive|condition_based|reliability_centered|run_to_failure');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `manufacturer_agnostic_flag` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Agnostic Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `mobile_asset_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Asset Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `mobile_asset_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `mobile_asset_flag` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `nerc_cip_applicable_flag` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Critical Infrastructure Protection (CIP) Applicable Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Notes');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `replacement_cycle_years` SET TAGS ('dbx_business_glossary_term' = 'Replacement Cycle in Years');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `safety_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Inspection Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `salvage_value_percentage` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value Percentage');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `serialized_asset_flag` SET TAGS ('dbx_business_glossary_term' = 'Serialized Asset Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `standard_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Standard Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `standard_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Standard Useful Life in Years');
ALTER TABLE `power_and_utilities_v2`.`asset`.`classification` ALTER COLUMN `warranty_tracking_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Tracking Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` SET TAGS ('dbx_subdomain' = 'health_monitoring');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `condition_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Condition Assessment Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Location ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `scada_point_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Point ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `ambient_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Celsius)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `assessment_cost` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `assessment_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `assessment_source` SET TAGS ('dbx_business_glossary_term' = 'Assessment Source');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `assessment_source` SET TAGS ('dbx_value_regex' = 'field_inspection|scada_automated|pi_historian|manual_entry|third_party_contractor');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|failed');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assessment Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `assessment_type` SET TAGS ('dbx_business_glossary_term' = 'Assessment Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review|remediation_required');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `condition_index` SET TAGS ('dbx_business_glossary_term' = 'Condition Index');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `condition_score` SET TAGS ('dbx_business_glossary_term' = 'Condition Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `dga_ppm` SET TAGS ('dbx_business_glossary_term' = 'Dissolved Gas Analysis (DGA) Parts Per Million (PPM)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `failure_probability_rating` SET TAGS ('dbx_business_glossary_term' = 'Failure Probability Rating');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `failure_probability_rating` SET TAGS ('dbx_value_regex' = 'very_low|low|moderate|high|very_high');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `gas_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Gas Pressure (PSI)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|requires_followup');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'routine_patrol|thermographic|structural|environmental|nerc_cip|phmsa_pipeline');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `inspector_certification` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `insulation_resistance_mohm` SET TAGS ('dbx_business_glossary_term' = 'Insulation Resistance (Megaohms)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `measurement_parameter` SET TAGS ('dbx_business_glossary_term' = 'Measurement Parameter');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `oil_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Oil Temperature (Celsius)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `photo_attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Attachment Count');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `recommended_action` SET TAGS ('dbx_business_glossary_term' = 'Recommended Action');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `recommended_action` SET TAGS ('dbx_value_regex' = 'monitor|routine_maintenance|corrective_maintenance|major_repair|replacement');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `third_party_contractor` SET TAGS ('dbx_business_glossary_term' = 'Third Party Contractor');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `threshold_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Threshold Breach Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `threshold_max` SET TAGS ('dbx_business_glossary_term' = 'Threshold Maximum Value');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `threshold_min` SET TAGS ('dbx_business_glossary_term' = 'Threshold Minimum Value');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `transformer_loading_pct` SET TAGS ('dbx_business_glossary_term' = 'Transformer Loading Percentage');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `vibration_level_mm_s` SET TAGS ('dbx_business_glossary_term' = 'Vibration Level (Millimeters per Second)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`condition_assessment` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `closed_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `parent_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `tertiary_work_closed_by_technician_id` SET TAGS ('dbx_business_glossary_term' = 'Closed By ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `actual_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Material Cost');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `actual_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Total Cost');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `capitalized_flag` SET TAGS ('dbx_business_glossary_term' = 'Capitalized Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `estimated_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Cost');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `originating_source` SET TAGS ('dbx_business_glossary_term' = 'Originating Source');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `originating_source` SET TAGS ('dbx_value_regex' = 'scada_alarm|inspection_finding|customer_complaint|scheduled_pm|condition_monitoring|regulatory_requirement');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration Minutes');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `outage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `planned_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Finish Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `planned_start_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'emergency|urgent|high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `problem_description` SET TAGS ('dbx_business_glossary_term' = 'Problem Description');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `safety_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Plan Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `work_order_description` SET TAGS ('dbx_business_glossary_term' = 'Work Order Description');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO[0-9]{8,12}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `work_type` SET TAGS ('dbx_business_glossary_term' = 'Work Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order` ALTER COLUMN `work_type` SET TAGS ('dbx_value_regex' = 'preventive_maintenance|corrective_maintenance|inspection|capital_project|emergency_restoration|predictive_maintenance');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `work_order_task_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Task Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `actual_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Task Cost');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `actual_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration Hours');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `craft_code` SET TAGS ('dbx_business_glossary_term' = 'Craft Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Task Cost');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory Task Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `is_safety_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Safety Critical Task Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `outage_required` SET TAGS ('dbx_business_glossary_term' = 'Outage Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `permit_required` SET TAGS ('dbx_business_glossary_term' = 'Permit Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Task Priority');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `skill_level` SET TAGS ('dbx_business_glossary_term' = 'Skill Level');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `skill_level` SET TAGS ('dbx_value_regex' = 'apprentice|journeyman|master|specialist');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `task_number` SET TAGS ('dbx_business_glossary_term' = 'Task Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `task_sequence` SET TAGS ('dbx_business_glossary_term' = 'Task Sequence Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `task_status` SET TAGS ('dbx_business_glossary_term' = 'Task Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `task_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|cancelled|on_hold');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `task_type` SET TAGS ('dbx_business_glossary_term' = 'Task Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `task_type` SET TAGS ('dbx_value_regex' = 'inspection|maintenance|repair|testing|calibration|replacement');
ALTER TABLE `power_and_utilities_v2`.`asset`.`work_order_task` ALTER COLUMN `technician_notes` SET TAGS ('dbx_business_glossary_term' = 'Technician Notes');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `classification_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `annual_opex_budget_allocation` SET TAGS ('dbx_business_glossary_term' = 'Annual Operating Expenditure (OPEX) Budget Allocation');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `annual_opex_budget_allocation` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `auto_generate_wo_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Generate Work Order (WO) Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `compliance_mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Mandatory Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `condition_monitoring_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Condition Monitoring Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `condition_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Condition Threshold Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `condition_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Condition Threshold Value');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `crew_type_required` SET TAGS ('dbx_business_glossary_term' = 'Crew Type Required');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `criticality_tier` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Tier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `estimated_outage_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Outage Duration Hours');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `failure_mode_addressed` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Addressed');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `frequency_interval` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `frequency_type` SET TAGS ('dbx_business_glossary_term' = 'Frequency Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `frequency_type` SET TAGS ('dbx_value_regex' = 'calendar_days|operating_hours|meter_reading|condition_trigger|event_based');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Unit');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `last_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Last Completion Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `maintenance_strategy_type` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `maintenance_strategy_type` SET TAGS ('dbx_value_regex' = 'time_based|condition_based|reliability_centered_maintenance|risk_based|predictive|run_to_failure');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `mean_time_between_maintenance_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Maintenance (MTBM) Hours');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `outage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `plan_review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Cycle Months');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `pm_number` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `pm_number` SET TAGS ('dbx_value_regex' = '^PM-[A-Z0-9]{8,12}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'emergency|urgent|high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Program Name');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `regulatory_driver` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Driver');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `required_inspection_frequency` SET TAGS ('dbx_business_glossary_term' = 'Required Inspection Frequency');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `safety_permit_required` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Required');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|under_review|retired');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `seasonal_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Restriction Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `seasonal_restriction_notes` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Restriction Notes');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `strategy_rationale` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Strategy Rationale');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `work_type` SET TAGS ('dbx_business_glossary_term' = 'Work Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`pm_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Follow-Up Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspection_work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Technician ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report Document ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `ambient_temperature_f` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (Fahrenheit)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `approved_by_supervisor_flag` SET TAGS ('dbx_business_glossary_term' = 'Approved by Supervisor Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `asset_condition_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `cost` SET TAGS ('dbx_business_glossary_term' = 'Inspection Cost');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `critical_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Critical Deficiency Count');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Hours)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `frequency_code` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Latitude');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `gis_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Longitude');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `gis_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|requires_follow_up|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspection_scope` SET TAGS ('dbx_business_glossary_term' = 'Inspection Scope');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred|under_review');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspector_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Inspector Certification Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspector_organization` SET TAGS ('dbx_business_glossary_term' = 'Inspector Organization');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `inspector_organization` SET TAGS ('dbx_value_regex' = 'internal|contractor|third_party_auditor|regulatory_agency');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location Description');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `photo_count` SET TAGS ('dbx_business_glossary_term' = 'Photo Count');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Inspection Priority');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|routine');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `regulatory_program` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `regulatory_requirement_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Reference');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Name');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `supervisor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` SET TAGS ('dbx_subdomain' = 'health_monitoring');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `failure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `asset_age_years` SET TAGS ('dbx_business_glossary_term' = 'Asset Age at Failure (Years)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `asset_criticality_tier` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Tier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `asset_criticality_tier` SET TAGS ('dbx_value_regex' = 'tier_1_critical|tier_2_high|tier_3_medium|tier_4_low');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `cause_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}-[0-9]{3}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause Description');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `component_failed` SET TAGS ('dbx_business_glossary_term' = 'Component Failed');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `crew_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Crew Arrival Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `customers_affected` SET TAGS ('dbx_business_glossary_term' = 'Customers Affected Count');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Failure Detection Method');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `detection_method` SET TAGS ('dbx_value_regex' = 'scada_alarm|operator_observation|protective_relay|routine_inspection|customer_report|automated_monitoring');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `energy_not_supplied_mwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Not Supplied (Megawatt-Hours)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `estimated_revenue_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Revenue Loss Amount');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `estimated_revenue_loss_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `failure_date` SET TAGS ('dbx_business_glossary_term' = 'Failure Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `failure_event_number` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `failure_event_number` SET TAGS ('dbx_value_regex' = '^FE-[0-9]{10}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `failure_mode` SET TAGS ('dbx_value_regex' = 'insulation_breakdown|mechanical_wear|corrosion|overload|lightning_strike|short_circuit');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `failure_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Failure Notification Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `failure_severity` SET TAGS ('dbx_business_glossary_term' = 'Failure Severity');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `failure_severity` SET TAGS ('dbx_value_regex' = 'critical|major|moderate|minor');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `failure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Failure Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `failure_type` SET TAGS ('dbx_business_glossary_term' = 'Failure Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `failure_type` SET TAGS ('dbx_value_regex' = 'forced_outage|unplanned_derate|equipment_malfunction|protective_relay_trip|cascading_failure|external_event');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `forced_outage_flag` SET TAGS ('dbx_business_glossary_term' = 'Forced Outage Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_value_regex' = '^INS-[0-9]{8}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `insurance_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `insurance_claim_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Claim Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `insurance_claim_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|under_review|approved|denied|paid');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `insurance_claim_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `load_lost_mw` SET TAGS ('dbx_business_glossary_term' = 'Load Lost (Megawatts)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `major_event_day_flag` SET TAGS ('dbx_business_glossary_term' = 'Major Event Day (MED) Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `mtbf_contribution_hours` SET TAGS ('dbx_business_glossary_term' = 'Mean Time Between Failures (MTBF) Contribution (Hours)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `operating_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Operating Voltage (Kilovolts)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `regulatory_report_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `regulatory_report_number` SET TAGS ('dbx_value_regex' = '^REG-[A-Z]{4}-[0-9]{6}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `repair_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Repair Action Taken');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `repair_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Repair Cost Amount');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `repair_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `replacement_recommended_flag` SET TAGS ('dbx_business_glossary_term' = 'Replacement Recommended Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `response_crew_dispatched_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Response Crew Dispatched Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `restoration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Restoration Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `root_cause_analysis_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Completed Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `time_since_last_maintenance_days` SET TAGS ('dbx_business_glossary_term' = 'Time Since Last Maintenance (Days)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `power_and_utilities_v2`.`asset`.`failure_event` ALTER COLUMN `weather_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Weather Related Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` SET TAGS ('dbx_subdomain' = 'capital_finance');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Schedule Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `accumulated_depreciation` SET TAGS ('dbx_business_glossary_term' = 'Accumulated Depreciation');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `annual_depreciation_expense` SET TAGS ('dbx_business_glossary_term' = 'Annual Depreciation Expense');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `asset_location_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `book_reserve_percentage` SET TAGS ('dbx_business_glossary_term' = 'Book Reserve Percentage');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `book_tax_timing_difference` SET TAGS ('dbx_business_glossary_term' = 'Book-Tax Timing Difference');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciable_cost_basis` SET TAGS ('dbx_business_glossary_term' = 'Depreciable Cost Basis');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|sum_of_years_digits|units_of_production|macrs|acrs');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_rate_percentage` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate Percentage');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_status` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_status` SET TAGS ('dbx_value_regex' = 'active|suspended|fully_depreciated|retired|pending_study_revision');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `depreciation_study_reference` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Study Reference');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Account Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3,6}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `impairment_indicator_flag` SET TAGS ('dbx_business_glossary_term' = 'Impairment Indicator Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `impairment_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Impairment Loss Amount');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `last_depreciation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Last Depreciation Run Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `net_book_value` SET TAGS ('dbx_business_glossary_term' = 'Net Book Value (NBV)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `next_depreciation_run_date` SET TAGS ('dbx_business_glossary_term' = 'Next Depreciation Run Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Schedule Notes');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `original_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Original Useful Life (Years)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `rate_base_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Rate Base Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_value_regex' = 'federal|state|municipal|joint');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `salvage_value_percentage` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value Percentage');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `schedule_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Effective Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `tax_depreciation_life_years` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Life (Years)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Tax Depreciation Method');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `tax_depreciation_method` SET TAGS ('dbx_value_regex' = 'macrs|acrs|straight_line|bonus_depreciation|section_179');
ALTER TABLE `power_and_utilities_v2`.`asset`.`depreciation_schedule` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` SET TAGS ('dbx_subdomain' = 'capital_finance');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `asset_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Capital Expenditure (CAPEX) Project ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `classification_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `actual_spend_to_date_amount` SET TAGS ('dbx_business_glossary_term' = 'Actual Spend to Date Amount');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `budget_variance_amount` SET TAGS ('dbx_business_glossary_term' = 'Budget Variance Amount');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `contingency_reserve_amount` SET TAGS ('dbx_business_glossary_term' = 'Contingency Reserve Amount');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `cpcn_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Public Convenience and Necessity (CPCN) Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `environmental_permit_number` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `environmental_permit_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Account Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `forecast_at_completion_amount` SET TAGS ('dbx_business_glossary_term' = 'Forecast at Completion Amount');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `in_service_date_actual` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date Actual');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `in_service_date_target` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date Target');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `irp_alignment_flag` SET TAGS ('dbx_business_glossary_term' = 'Integrated Resource Plan (IRP) Alignment Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_value_regex' = '1_year|5_year|10_year');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `project_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Project Completion Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `project_number` SET TAGS ('dbx_business_glossary_term' = 'Project Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `project_start_date` SET TAGS ('dbx_business_glossary_term' = 'Project Start Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `project_status` SET TAGS ('dbx_business_glossary_term' = 'Project Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `project_status` SET TAGS ('dbx_value_regex' = 'planning|design|procurement|construction|commissioning|closed');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'new_construction|replacement|upgrade|compliance_driven|capacity_expansion|technology_modernization');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `rab_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base (RAB) Inclusion Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `rate_case_reference` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Reference');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `replacement_driver` SET TAGS ('dbx_business_glossary_term' = 'Replacement Driver');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `replacement_driver` SET TAGS ('dbx_value_regex' = 'end_of_life|condition_based|compliance|capacity|technology_obsolescence');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `replacement_priority_score` SET TAGS ('dbx_business_glossary_term' = 'Replacement Priority Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `safety_classification` SET TAGS ('dbx_business_glossary_term' = 'Safety Classification');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `sponsoring_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Sponsoring Business Unit');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `total_authorized_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Authorized Budget Amount');
ALTER TABLE `power_and_utilities_v2`.`asset`.`asset_capex_project` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life Years');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `lifecycle_event_id` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Personnel Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `primary_lifecycle_asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Personnel Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `asset_condition_after` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition After Event');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `asset_condition_after` SET TAGS ('dbx_value_regex' = 'good|fair|poor');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `asset_condition_before` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Before Event');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `asset_condition_before` SET TAGS ('dbx_value_regex' = 'good|fair|poor');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `asset_location_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `asset_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Serial Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `asset_tag_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `capital_expenditure_flag` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Event Cost Amount');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `depreciation_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Impact Amount');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `depreciation_impact_type` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Impact Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `depreciation_impact_type` SET TAGS ('dbx_value_regex' = 'increase|decrease|none');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `emissions_change_tons_co2e` SET TAGS ('dbx_business_glossary_term' = 'Emissions Change (tCO₂e)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_category` SET TAGS ('dbx_business_glossary_term' = 'Event Category');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_category` SET TAGS ('dbx_value_regex' = 'installation|modification|maintenance|retirement|transfer|disposal');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Event Document Reference');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Event Effective Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Event Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Event Latitude');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Event Longitude');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_notes` SET TAGS ('dbx_business_glossary_term' = 'Event Notes');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Event Sequence Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_source_type` SET TAGS ('dbx_business_glossary_term' = 'Event Source Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_source_type` SET TAGS ('dbx_value_regex' = 'system|manual');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Event Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `impact_on_rab_flag` SET TAGS ('dbx_business_glossary_term' = 'RAB Impact Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `is_manual_entry` SET TAGS ('dbx_business_glossary_term' = 'Manual Entry Indicator');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `new_status` SET TAGS ('dbx_business_glossary_term' = 'New Asset Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `opex_expenditure_flag` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `previous_status` SET TAGS ('dbx_business_glossary_term' = 'Previous Asset Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `project_reference` SET TAGS ('dbx_business_glossary_term' = 'Project Reference Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Maximo|ArcGIS|SAP|Oracle|GE|Allegro');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `warranty_status_after` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status After Event');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `warranty_status_after` SET TAGS ('dbx_value_regex' = 'active|expired|none');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `warranty_status_before` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status Before Event');
ALTER TABLE `power_and_utilities_v2`.`asset`.`lifecycle_event` ALTER COLUMN `warranty_status_before` SET TAGS ('dbx_value_regex' = 'active|expired|none');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` SET TAGS ('dbx_subdomain' = 'health_monitoring');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessor Employee ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `asset_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Filing ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Filing ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessor Employee ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Method');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'quantitative|qualitative|semi_quantitative|condition_based|age_based|hybrid');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Notes');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessor Name');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `asset_age_years` SET TAGS ('dbx_business_glossary_term' = 'Asset Age in Years');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `asset_condition_index` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Index');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `asset_health_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Health Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `asset_health_score` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `asset_health_score` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `composite_risk_index` SET TAGS ('dbx_business_glossary_term' = 'Composite Risk Index');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `consequence_of_failure_environmental_score` SET TAGS ('dbx_business_glossary_term' = 'Consequence of Failure (COF) Environmental Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `consequence_of_failure_financial_score` SET TAGS ('dbx_business_glossary_term' = 'Consequence of Failure (COF) Financial Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `consequence_of_failure_reliability_score` SET TAGS ('dbx_business_glossary_term' = 'Consequence of Failure (COF) Reliability Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `consequence_of_failure_safety_score` SET TAGS ('dbx_business_glossary_term' = 'Consequence of Failure (COF) Safety Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `criticality_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `customers_at_risk_count` SET TAGS ('dbx_business_glossary_term' = 'Customers at Risk Count');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `data_quality_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Data Quality Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `estimated_failure_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Failure Cost in United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `estimated_failure_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `estimated_replacement_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Replacement Cost in United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `estimated_replacement_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `expected_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Expected Useful Life in Years');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `load_at_risk_mw` SET TAGS ('dbx_business_glossary_term' = 'Load at Risk in Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `loading_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Loading Factor Percentage');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `mitigation_action_recommended` SET TAGS ('dbx_business_glossary_term' = 'Recommended Risk Mitigation Action');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `mitigation_priority` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Priority');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `mitigation_priority` SET TAGS ('dbx_value_regex' = 'immediate|urgent|high|medium|low|monitor');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `mitigation_status` SET TAGS ('dbx_value_regex' = 'not_started|planned|in_progress|completed|deferred|cancelled');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Risk Assessment Due Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `probability_of_failure_score` SET TAGS ('dbx_business_glossary_term' = 'Probability of Failure (POF) Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `regulatory_justification_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Justification Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life in Years');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Review Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `risk_driver_primary` SET TAGS ('dbx_business_glossary_term' = 'Primary Risk Driver');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `risk_driver_primary` SET TAGS ('dbx_value_regex' = 'age|condition|loading|environmental_exposure|criticality|obsolescence');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `risk_driver_secondary` SET TAGS ('dbx_business_glossary_term' = 'Secondary Risk Driver');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `risk_driver_secondary` SET TAGS ('dbx_value_regex' = 'age|condition|loading|environmental_exposure|criticality|obsolescence');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_business_glossary_term' = 'Risk Tier Classification');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `risk_tier` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|negligible');
ALTER TABLE `power_and_utilities_v2`.`asset`.`risk_assessment` ALTER COLUMN `target_mitigation_date` SET TAGS ('dbx_business_glossary_term' = 'Target Mitigation Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` SET TAGS ('dbx_subdomain' = 'health_monitoring');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `operational_reading_id` SET TAGS ('dbx_business_glossary_term' = 'Operational Reading Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Validated By User ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `scada_point_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisory Control and Data Acquisition (SCADA) Point ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `alarm_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Alarm Severity Level');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `alarm_severity_level` SET TAGS ('dbx_value_regex' = 'NORMAL|LOW|MEDIUM|HIGH|CRITICAL');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `ambient_temperature` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `asset_condition_score` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition Score');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `calibration_due_date` SET TAGS ('dbx_business_glossary_term' = 'Calibration Due Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `compliance_threshold_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Threshold Exceeded Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `data_lineage_code` SET TAGS ('dbx_business_glossary_term' = 'Data Lineage ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `data_validation_status` SET TAGS ('dbx_business_glossary_term' = 'Data Validation Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `data_validation_status` SET TAGS ('dbx_value_regex' = 'PENDING|VALIDATED|REJECTED|UNDER_REVIEW');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `instrument_tag_code` SET TAGS ('dbx_business_glossary_term' = 'Instrument Tag ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `last_calibration_date` SET TAGS ('dbx_business_glossary_term' = 'Last Calibration Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `measurement_location_description` SET TAGS ('dbx_business_glossary_term' = 'Measurement Location Description');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `measurement_method_code` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `measurement_method_code` SET TAGS ('dbx_value_regex' = 'CONTINUOUS_MONITORING|PERIODIC_MANUAL|SCHEDULED_AUTOMATED|ON_DEMAND|CONDITION_BASED');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `measurement_notes` SET TAGS ('dbx_business_glossary_term' = 'Measurement Notes');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `measurement_quality_code` SET TAGS ('dbx_business_glossary_term' = 'Measurement Quality Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `measurement_quality_code` SET TAGS ('dbx_value_regex' = 'GOOD|QUESTIONABLE|BAD|SUBSTITUTED|ESTIMATED|CALIBRATION_REQUIRED');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `measurement_source` SET TAGS ('dbx_business_glossary_term' = 'Measurement Source');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `measurement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Measurement Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `measurement_type_code` SET TAGS ('dbx_business_glossary_term' = 'Measurement Type Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `measurement_value` SET TAGS ('dbx_business_glossary_term' = 'Measurement Value');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `operating_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Operating Condition Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `pi_tag_name` SET TAGS ('dbx_business_glossary_term' = 'Process Information (PI) Tag Name');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `reading_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Reading Sequence Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `threshold_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Threshold Breach Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `threshold_lower_limit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Lower Limit');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `threshold_upper_limit` SET TAGS ('dbx_business_glossary_term' = 'Threshold Upper Limit');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `trend_direction_code` SET TAGS ('dbx_business_glossary_term' = 'Trend Direction Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `trend_direction_code` SET TAGS ('dbx_value_regex' = 'IMPROVING|STABLE|DEGRADING|CRITICAL_DECLINE');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `validation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Validation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`operational_reading` ALTER COLUMN `weather_condition_code` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition Code');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` SET TAGS ('dbx_subdomain' = 'capital_finance');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `asset_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Project ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `superseded_by_document_compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Document ID');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `access_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Access Restriction Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `active_flag` SET TAGS ('dbx_business_glossary_term' = 'Active Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `compliance_conditions` SET TAGS ('dbx_business_glossary_term' = 'Compliance Conditions');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditional|under_review|suspended');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `dms_reference` SET TAGS ('dbx_business_glossary_term' = 'Document Management System (DMS) Reference');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `document_category` SET TAGS ('dbx_business_glossary_term' = 'Document Category');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `document_category` SET TAGS ('dbx_value_regex' = 'regulatory|technical|operational|legal|environmental|safety');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `document_number` SET TAGS ('dbx_business_glossary_term' = 'Document Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `document_originator` SET TAGS ('dbx_business_glossary_term' = 'Document Originator');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `document_size_mb` SET TAGS ('dbx_business_glossary_term' = 'Document Size (MB)');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `document_title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `gis_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Reference');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `permit_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Permit Cost Amount');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `permit_cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Permit Cost Currency');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `permit_cost_currency` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `regulatory_framework` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Framework');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'current|pending_renewal|renewal_submitted|expired|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `responsible_party` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number');
ALTER TABLE `power_and_utilities_v2`.`asset`.`compliance_document` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` SET TAGS ('dbx_subdomain' = 'master_registry');
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` SET TAGS ('dbx_association_edges' = 'asset.registry,property.parcel');
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` ALTER COLUMN `parcel_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Parcel Allocation - Asset Parcel Allocation Id');
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Parcel Allocation - Asset Registry Id');
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Parcel Allocation - Parcel Id');
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` ALTER COLUMN `cost_allocation_percentage` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Percentage');
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` ALTER COLUMN `geographic_containment_flag` SET TAGS ('dbx_business_glossary_term' = 'Geographic Containment Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` ALTER COLUMN `network_topology_role` SET TAGS ('dbx_business_glossary_term' = 'Network Topology Role');
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` ALTER COLUMN `outage_propagation_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Propagation Flag');
ALTER TABLE `power_and_utilities_v2`.`asset`.`parcel_allocation` ALTER COLUMN `ownership_percentage` SET TAGS ('dbx_business_glossary_term' = 'Ownership Percentage');
ALTER TABLE `power_and_utilities_v2`.`asset`.`job_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`asset`.`job_plan` SET TAGS ('dbx_subdomain' = 'master_registry');
ALTER TABLE `power_and_utilities_v2`.`asset`.`job_plan` ALTER COLUMN `job_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Job Plan Identifier');
ALTER TABLE `power_and_utilities_v2`.`asset`.`job_plan` ALTER COLUMN `parent_job_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
