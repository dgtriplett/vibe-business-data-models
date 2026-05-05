-- Schema for Domain: asset | Business: Power and Utilities | Version: v1_mvm
-- Generated on: 2026-04-29 23:12:53

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities`.`asset` COMMENT 'Serves as the enterprise SSOT for all physical asset lifecycle data across generation, T&D, and gas infrastructure — asset master records, preventive and corrective maintenance work orders, inspection records, failure history, and capital project tracking (CAPEX/OPEX, AFUDC, WIP). Integrates with EAM (Oracle WAM / IBM Maximo) and GIS (ESRI ArcGIS) for spatial asset management. Supports regulatory asset base reporting and depreciation schedules for rate cases.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`master` (
    `master_id` BIGINT COMMENT 'Unique identifier for the physical utility asset record. Primary key for the asset master entity. Serves as the anchor for all maintenance, inspection, failure, condition, warranty, and capital project records in the asset domain.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-specific assets (meters, service equipment) are assigned to accounts for billing, service delivery tracking, and cost allocation. Required for meter-to-bill reconciliation and customer servic',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assets are assigned to cost centers for ownership, responsibility, and budget allocation. Required for asset accounting, depreciation expense allocation, and management reporting by organizational uni',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.asset_location. Business justification: Normalize location data to asset_location SSOT. The asset_location product is explicitly described as Master record for the physical or functional location where utility assets are installed and con',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Distribution assets (transformers, meters, service lines) are physically installed at customer premises. Essential for outage management, service planning, asset location tracking, and customer impact',
    `asset_class` STRING COMMENT 'High-level classification of the asset type across generation, transmission, distribution, and gas infrastructure. Determines the applicable maintenance programs, regulatory reporting requirements, and depreciation schedules. [ENUM-REF-CANDIDATE: generation_unit|transmission_line|distribution_transformer|gas_main|substation|meter|capacitor_bank|voltage_regulator — 8 candidates stripped; promote to reference product]',
    `asset_status` STRING COMMENT 'Current lifecycle status of the asset. Active assets are in service and generating revenue or providing service. Retired assets are removed from service but not yet decommissioned. Decommissioned assets are permanently removed and disposed. Under construction assets are in the capital project phase (WIP). Standby assets are available but not currently in service. Out of service assets are temporarily unavailable due to maintenance or failure.. Valid values are `active|retired|decommissioned|under_construction|standby|out_of_service`',
    `asset_tag` STRING COMMENT 'Externally-known unique asset identifier assigned by the utility for physical asset tracking and field identification. Typically affixed to the physical asset as a barcode or RFID tag. Used by field crews and maintenance personnel for asset lookup.',
    `asset_type` STRING COMMENT 'Detailed asset type within the asset class. Examples: combustion turbine, combined cycle unit, overhead transmission line, underground distribution cable, steel gas main, AMI electric meter, pad-mounted transformer. Drives specific maintenance procedures and inspection protocols.',
    `capacity_unit` STRING COMMENT 'Unit of measure for the rated capacity field. MW (Megawatt) for generation. kVA or MVA for transformers. MCF (Thousand Cubic Feet) or BCF (Billion Cubic Feet) for gas infrastructure. kV (Kilovolt) for voltage level. [ENUM-REF-CANDIDATE: MW|kW|MVA|kVA|MCF|BCF|kV — 7 candidates stripped; promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset master record was first created in the system. Used for data lineage and audit trail purposes.',
    `depreciation_method` STRING COMMENT 'Accounting depreciation method applied to this asset for financial reporting and rate case preparation. Straight-line is most common for utility assets. Method must be approved by the regulatory commission.. Valid values are `straight_line|declining_balance|sum_of_years_digits|units_of_production`',
    `eam_system_reference` STRING COMMENT 'Unique identifier for this asset in the source Enterprise Asset Management system (Oracle WAM or IBM Maximo). Used for bi-directional synchronization between the lakehouse and the operational EAM system.',
    `easement_reference` STRING COMMENT 'Reference to the easement or right-of-way agreement that grants the utility legal access to the asset location. Critical for transmission and distribution assets on private property. Used for legal compliance and property rights management.',
    `ferc_account_code` STRING COMMENT 'FERC Uniform System of Accounts code for regulatory asset classification and depreciation tracking. Examples: 311 (Intangible Plant), 314 (Transmission Plant), 360-373 (Distribution Plant), 101 (Gas Plant in Service). Required for rate case filings and regulatory asset base reporting.',
    `gas_pressure_zone` STRING COMMENT 'Operating pressure zone classification for gas infrastructure assets. Examples: high pressure transmission, medium pressure distribution, low pressure service. Not applicable to electric assets.',
    `gis_feature_class` STRING COMMENT 'ESRI ArcGIS feature class name for the spatial representation of this asset. Examples: ElectricTransmissionLine, DistributionTransformer, GasMain, Substation. Links the asset master record to the authoritative spatial record in the GIS system.',
    `gis_object_reference` STRING COMMENT 'Unique object identifier in the ESRI ArcGIS geodatabase for this asset feature. Enables direct lookup and synchronization between the EAM system (Oracle WAM / IBM Maximo) and the GIS system.',
    `in_service_date` DATE COMMENT 'Date the asset was placed into active service and began generating revenue or providing utility service. This is the official date for depreciation start and regulatory asset base inclusion. Critical for rate case preparation and FERC/PUC reporting.',
    `installation_date` DATE COMMENT 'Date the asset was physically installed at its location. May precede the in-service date if commissioning and testing are required before the asset is placed into active service.',
    `land_parcel_reference` STRING COMMENT 'Reference to the land parcel or property where the asset is located. Typically an assessor parcel number (APN) or legal land description. Used for property rights verification, easement tracking, and real estate tax assessment.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset master record was last updated. Used for change tracking and data synchronization between systems.',
    `location_accuracy_class` STRING COMMENT 'Classification of the spatial accuracy of the asset location coordinates. GPS-surveyed: sub-meter accuracy from field GPS survey. As-built: derived from engineering as-built drawings. Estimated: approximate location from design drawings or aerial imagery. Unknown: location accuracy not verified.. Valid values are `gps_surveyed|as_built|estimated|unknown`',
    `manufacturer` STRING COMMENT 'Name of the original equipment manufacturer (OEM) who produced the asset. Used for warranty tracking, parts sourcing, and technical support. Examples: GE, Siemens, ABB, Schneider Electric, Sensus, Itron.',
    `model_number` STRING COMMENT 'Manufacturer model number or designation for the asset. Used to identify technical specifications, compatible parts, and maintenance procedures specific to this model.',
    `naruc_account_code` STRING COMMENT 'NARUC Uniform System of Accounts code for state-level regulatory reporting. May differ from FERC codes for distribution and retail assets under state PUC jurisdiction.',
    `original_cost` DECIMAL(18,2) COMMENT 'Original installed cost of the asset including equipment, labor, materials, and capitalized overheads. This is the basis for depreciation and regulatory asset base valuation. Includes AFUDC (Allowance for Funds Used During Construction) if applicable.',
    `rated_capacity` DECIMAL(18,2) COMMENT 'Nameplate rated capacity of the asset in the appropriate unit of measure. For generation units: MW. For transformers: kVA or MVA. For gas mains: MCF per day. For transmission lines: MVA. Critical for capacity planning, load balancing, and regulatory reporting.',
    `regulatory_asset_base_flag` BOOLEAN COMMENT 'Boolean flag indicating whether this asset is included in the regulatory asset base (rate base) for rate case calculations. True if the asset is used and useful in providing utility service and eligible for cost recovery through rates. False if the asset is excluded from rate base (e.g., non-utility use, under construction, retired).',
    `retirement_date` DATE COMMENT 'Date the asset was permanently removed from active service. Marks the end of depreciation and the beginning of decommissioning activities. Nullable for assets still in service.',
    `salvage_value` DECIMAL(18,2) COMMENT 'Estimated residual value of the asset at the end of its useful life. Used in depreciation calculations to determine the depreciable base (original cost minus salvage value). Typically expressed in dollars.',
    `serial_number` STRING COMMENT 'Unique serial number assigned by the manufacturer to this specific asset unit. Used for warranty claims, recall tracking, and precise asset identification.',
    `useful_life_years` STRING COMMENT 'Expected useful life of the asset in years for depreciation calculation purposes. Determined by engineering studies and approved by the regulatory commission. Used to calculate annual depreciation expense.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Operating voltage level of the electric asset in kilovolts (kV). Applicable to transmission lines, distribution circuits, transformers, and substations. Examples: 765, 500, 345, 230, 138, 69, 34.5, 13.8, 4.16 kV. Not applicable to gas assets.',
    CONSTRAINT pk_master PRIMARY KEY(`master_id`)
) COMMENT 'Enterprise SSOT for all physical utility assets across generation, transmission, distribution, and gas infrastructure. Captures the full asset master record including asset class (generation unit, transmission line, distribution transformer, gas main, meter), asset type, manufacturer, model, serial number, installation date, in-service date, retirement date, asset status (active, retired, decommissioned), rated capacity (MW, kV, MCF), and FERC/NARUC account code. Includes full geospatial and network location attributes: GIS feature class, GIS object ID, latitude, longitude, elevation, address, municipality, county, state, utility service territory, electric circuit/feeder ID, substation name, voltage level (kV), gas pressure zone, pipeline segment ID, land parcel reference, easement reference, and location accuracy class (GPS-surveyed, as-built, estimated). Also captures regulatory asset base inclusion flag, depreciation method, useful life, and salvage value. Integrates with Oracle WAM / IBM Maximo as the EAM system of record and ESRI ArcGIS as the authoritative spatial record. Serves as the anchor entity for all maintenance, inspection, failure, condition, warranty, and capital project records in the asset domain.';

CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`hierarchy` (
    `hierarchy_id` BIGINT COMMENT 'Unique identifier for the asset hierarchy relationship record. Primary key for the asset hierarchy product.',
    `child_asset_asset_master_id` BIGINT COMMENT 'Identifier of the child asset in the hierarchy structure. References the subordinate asset in the parent-child relationship (e.g., transformer as child of substation, circuit breaker as child of feeder).',
    `master_id` BIGINT COMMENT 'Identifier of the parent asset in the hierarchy structure. References the superior asset in the parent-child relationship (e.g., substation as parent of transformer, feeder as parent of circuit breaker).',
    `connectivity_role` STRING COMMENT 'Electrical or operational connectivity role of the child asset relative to the parent in network topology. Upstream indicates the child is electrically upstream (source side) of the parent. Downstream indicates the child is electrically downstream (load side). Parallel indicates the child operates in parallel with siblings. Redundant indicates the child provides backup capacity. Backup indicates standby configuration. Isolated indicates the child is electrically isolated. Used by OMS for fault isolation and upstream/downstream asset identification during outage events.. Valid values are `upstream|downstream|parallel|redundant|backup|isolated`',
    `cost_rollup_enabled` BOOLEAN COMMENT 'Boolean flag indicating whether maintenance and capital costs (CAPEX/OPEX) for the child asset should be rolled up and aggregated to the parent asset for financial reporting. True enables cost aggregation for rate case cost studies, depreciation schedules, and regulatory asset base reporting. False isolates child costs for separate tracking. Used by EAM (Oracle WAM/Maximo) for work order cost allocation and AFUDC calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset hierarchy relationship record was first created in the system. Used for data lineage, audit trail, and temporal analysis of hierarchy configuration changes. Supports regulatory compliance and data governance requirements.',
    `criticality_inheritance` STRING COMMENT 'Rule governing how asset criticality rating is inherited or calculated within the hierarchy. Inherit from parent means the child adopts the parents criticality. Override independent means the child has its own criticality rating. Aggregate children means the parents criticality is calculated from child criticalities. Highest in branch means the criticality is the maximum value in the hierarchy branch. Used for risk-based maintenance prioritization and regulatory compliance (NERC CIP asset identification).. Valid values are `inherit_from_parent|override_independent|aggregate_children|highest_in_branch`',
    `effective_date` DATE COMMENT 'Date when the parent-child hierarchical relationship became or will become active. Used for temporal hierarchy tracking to support asset configuration changes, capital project commissioning (CPCN), and regulatory asset base reporting. Supports point-in-time hierarchy reconstruction for rate case cost studies and depreciation schedule audits.',
    `expiration_date` DATE COMMENT 'Date when the parent-child hierarchical relationship ended or will end. Null for currently active relationships. Populated when assets are relocated, reconfigured, or retired. Used for temporal hierarchy tracking to support asset lifecycle analysis, work order cost roll-up accuracy, and regulatory depreciation reporting.',
    `hierarchy_level` STRING COMMENT 'Numeric depth level of the child asset within the overall hierarchy tree. Level 1 represents top-level assets (e.g., power plant, transmission substation), with increasing numbers representing deeper nesting (e.g., level 5 might be individual relay components). Used for drill-down navigation and cost roll-up aggregation in EAM systems.',
    `hierarchy_type` STRING COMMENT 'Classification of the hierarchical relationship type. Functional location represents geographic or operational location hierarchy (plant > substation > bay). Asset assembly represents physical component breakdown (transformer > winding > bushing). Network segment represents electrical connectivity (transmission line > circuit > segment). Linear reference represents distance-based positioning along linear assets (pipeline > mile marker). System subsystem represents logical grouping (generation system > turbine subsystem). Spatial containment represents GIS-based geographic containment.. Valid values are `functional_location|asset_assembly|network_segment|linear_reference|system_subsystem|spatial_containment`',
    `is_primary_parent` BOOLEAN COMMENT 'Boolean flag indicating whether this parent represents the primary hierarchical relationship for the child asset. True when this is the authoritative parent for cost roll-up, work order scoping, and regulatory reporting. False for secondary or reference-only parent relationships. An asset may have multiple parents in different hierarchy types (functional location vs. network segment), but only one primary parent per type.',
    `linear_measure_from` DECIMAL(18,2) COMMENT 'Starting linear distance measure along the parent linear asset (transmission line, gas pipeline) where the child asset begins. Measured in the unit specified by linear measure unit (typically miles, kilometers, or feet). Used for linear referencing systems to position assets along network segments. Supports GIS linear referencing and pipeline integrity management (PHMSA compliance).',
    `linear_measure_to` DECIMAL(18,2) COMMENT 'Ending linear distance measure along the parent linear asset (transmission line, gas pipeline) where the child asset ends. Measured in the unit specified by linear measure unit (typically miles, kilometers, or feet). Used for linear referencing systems to define asset span or coverage. Supports GIS linear referencing and pipeline integrity management (PHMSA compliance).',
    `linear_measure_unit` STRING COMMENT 'Unit of measure for linear distance measurements (linear measure from and linear measure to) along linear assets. Miles and feet are common in US utilities. Kilometers and meters are common internationally. Used for linear referencing systems in GIS and pipeline integrity management.. Valid values are `miles|kilometers|feet|meters`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the asset hierarchy relationship record was last modified. Updated whenever any attribute of the relationship changes. Used for change tracking, audit trail, and data synchronization between EAM (Oracle WAM/Maximo) and GIS (ESRI ArcGIS) systems.',
    `position_slot` STRING COMMENT 'Physical or logical position identifier of the child asset within the parent assembly. Examples include bay number within substation (Bay-A, Bay-B), slot number in control panel (Slot-03), phase designation (Phase-A, Phase-B, Phase-C), or valve station milepost (MP-45.2). Used for spatial asset management and maintenance work order scoping.',
    `relationship_description` STRING COMMENT 'Free-text description providing additional context about the parent-child hierarchical relationship. May include physical connection details, functional dependency notes, or special configuration information relevant to maintenance planning, outage management, or network analysis.',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the parent-child hierarchical relationship. Active indicates the relationship is currently in effect. Inactive indicates the relationship has been superseded but retained for historical reference. Planned indicates a future relationship for capital projects (CAPEX) or asset additions. Decommissioned indicates the relationship ended due to asset retirement. Temporary indicates a short-term relationship for construction or maintenance activities.. Valid values are `active|inactive|planned|decommissioned|temporary`',
    `sort_order` STRING COMMENT 'Numeric sequence for ordering child assets within the same parent and hierarchy level. Used to control display order in EAM work order hierarchies, GIS network trace results, and asset drill-down reports. Lower numbers appear first.',
    `spatial_reference_system` STRING COMMENT 'Geographic coordinate system or spatial reference identifier used for GIS-based hierarchy positioning. Examples include EPSG codes (e.g., EPSG:4326 for WGS84, EPSG:3857 for Web Mercator) or state plane coordinate systems. Used by ESRI ArcGIS for spatial asset management, network connectivity modeling, and linear referencing along transmission lines and gas pipelines.',
    CONSTRAINT pk_hierarchy PRIMARY KEY(`hierarchy_id`)
) COMMENT 'Defines the parent-child structural hierarchy of utility assets — from functional location (plant, substation, feeder) down to individual component (circuit breaker, transformer winding, valve assembly). Captures hierarchy level, hierarchy type (functional location, asset assembly, network segment, linear reference), parent asset reference, child asset reference, position/slot within parent, sort order, and effective/expiration dates for temporal hierarchy changes. Supports drill-down from bulk electric system (BES) transmission topology to individual field devices, and from gas transmission pipeline systems to individual valve stations. Used by EAM (Oracle WAM / Maximo) for work order scoping and cost roll-up, by GIS (ESRI ArcGIS) for network connectivity modeling, and by outage management systems for upstream/downstream asset identification during fault isolation.';

CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`work_order` (
    `work_order_id` BIGINT COMMENT 'Unique identifier for the work order. Primary key for the work order entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Customer-requested work orders (service upgrades, complaint resolution, move-in/move-out) must link to accounts for cost recovery, billing, and customer communication. Standard utility field service m',
    `capex_project_id` BIGINT COMMENT 'Foreign key reference to the capital project or WIP account to which this work order cost should be allocated. Used for capital project tracking and rate base reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Work order cost settlement requires linking actual labor/material costs to cost centers for financial accounting, budget variance reporting, and FERC account classification. Essential for work order c',
    `generating_unit_id` BIGINT COMMENT 'FK to generation.generating_unit.generating_unit_id — Links maintenance work orders to specific generation assets — required for generation unit availability tracking, NERC GADS reporting, and maintenance cost allocation to generating units.',
    `location_id` BIGINT COMMENT 'Foreign key reference to the physical location where the work is to be performed. May reference a substation, plant, facility, or geographic service area.',
    `master_id` BIGINT COMMENT 'Foreign key reference to the primary asset on which this work order is being performed. Links to the asset master record in the asset management domain.',
    `pm_schedule_id` BIGINT COMMENT 'Foreign key reference to the preventive maintenance schedule or plan that generated this work order. Applicable only for PM work order types.',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to market.ppa_contract. Business justification: Work orders on PPA-contracted generation assets must track governing contract for cost allocation to counterparty, compliance with maintenance windows, and contract performance reporting required by F',
    `actual_finish_timestamp` TIMESTAMP COMMENT 'Actual date and time when work was completed, captured from crew check-out or mobile work management system. Used for cycle time analysis and reliability reporting.',
    `actual_labor_hours` DECIMAL(18,2) COMMENT 'Total labor hours actually expended on the work order, captured from crew time sheets and used for cost accounting and productivity analysis.',
    `actual_material_cost` DECIMAL(18,2) COMMENT 'Actual cost of materials, parts, and supplies consumed during work order execution, expressed in USD. Captured from inventory withdrawals and purchase orders.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work commenced, captured from crew check-in or mobile work management system. Used for performance measurement and outage duration calculation.',
    `actual_total_cost` DECIMAL(18,2) COMMENT 'Total actual cost incurred for the work order including all labor, materials, equipment, and overhead charges, expressed in USD. Used for financial reporting and rate case cost substantiation.',
    `afudc_eligible_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the work order costs are eligible for AFUDC capitalization under FERC accounting rules. True indicates AFUDC-eligible capital work; False indicates non-eligible work.',
    `approved_by` STRING COMMENT 'User ID or name of the supervisor, manager, or authorized approver who approved the work order for execution. Used for authorization audit trail and compliance verification.',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was approved for execution. Used for workflow tracking and authorization audit.',
    `closed_by` STRING COMMENT 'User ID or name of the individual who closed the work order after verifying completion and approving final costs. Used for accountability and audit trail.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date and time when the work order was formally closed and finalized. Used for cycle time measurement and financial period cutoff.',
    `completion_notes` STRING COMMENT 'Free-text field capturing crew observations, work performed, issues encountered, follow-up actions required, and any deviations from the original work plan. Used for knowledge capture and continuous improvement.',
    `cost_classification` STRING COMMENT 'Accounting classification of the work order cost: OPEX (Operating Expenditure) for routine maintenance and repairs expensed in the current period, or CAPEX (Capital Expenditure) for asset improvements capitalized and depreciated over time. Critical for regulatory rate case reporting and financial statement preparation.. Valid values are `opex|capex`',
    `craft_trade_required` STRING COMMENT 'Skilled trade or craft discipline required to perform the work, such as electrician, lineman, mechanic, welder, or instrumentation technician. Used for crew assignment and labor planning.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was first created in the EAM system. Used for audit trail and work order aging analysis.',
    `crew_assignment` STRING COMMENT 'Identifier or name of the crew, team, or individual worker assigned to perform the work order. May reference a crew ID from the workforce management system.',
    `estimated_labor_hours` DECIMAL(18,2) COMMENT 'Planned total labor hours required to complete the work order, used for resource scheduling and cost estimation.',
    `estimated_material_cost` DECIMAL(18,2) COMMENT 'Planned cost of materials, parts, and supplies required for the work order, expressed in USD. Used for budgeting and procurement planning.',
    `estimated_total_cost` DECIMAL(18,2) COMMENT 'Total planned cost for the work order including labor, materials, equipment, and overhead, expressed in USD. Used for budget authorization and variance analysis.',
    `failure_code` STRING COMMENT 'Standardized code identifying the type of failure or defect that triggered the work order (for corrective and emergency work). Used for failure mode analysis, reliability engineering, and predictive maintenance modeling.',
    `modified_timestamp` TIMESTAMP COMMENT 'Date and time when the work order record was last updated. Used for change tracking and data quality monitoring.',
    `outage_duration_minutes` STRING COMMENT 'Planned or actual duration of the outage in minutes. Used for customer impact assessment, SAIDI/SAIFI reliability index calculation, and regulatory reporting.',
    `outage_required_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether the work requires a planned outage or de-energization of equipment. True indicates an outage is necessary; False indicates work can be performed energized or does not impact service.',
    `priority` STRING COMMENT 'Business priority level indicating urgency and impact: critical for immediate safety or reliability threats, high for significant operational impact, medium for routine scheduled work, low for deferrable tasks.. Valid values are `critical|high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) specifying whether this work order is driven by a regulatory compliance requirement (e.g., NERC CIP, EPA emissions control, PUC-mandated inspection). True indicates regulatory compliance work; False indicates discretionary or operational work.',
    `safety_permit_reference` STRING COMMENT 'Reference number or identifier for any safety permits, hot work permits, confined space permits, or switching orders required for the work. Ensures compliance with OSHA and internal safety protocols.',
    `scheduled_finish_date` DATE COMMENT 'Planned date when work is scheduled to be completed. Used for resource planning and commitment tracking.',
    `scheduled_start_date` DATE COMMENT 'Planned date when work is scheduled to begin. Used for crew scheduling, outage coordination, and customer notification.',
    `work_order_description` STRING COMMENT 'Detailed narrative description of the work to be performed, including scope, objectives, and any special instructions or safety considerations.',
    `work_order_number` STRING COMMENT 'Externally visible business identifier for the work order, typically generated by the EAM system (Oracle WAM / IBM Maximo). Used for tracking, reporting, and communication with field crews and regulatory bodies.. Valid values are `^WO-[0-9]{8,12}$`',
    `work_order_status` STRING COMMENT 'Current lifecycle state of the work order: created (initial entry), planned (resources allocated), scheduled (date/time assigned), in-progress (crew actively working), completed (work finished, pending review), closed (finalized and approved), or cancelled (work not performed). [ENUM-REF-CANDIDATE: created|planned|scheduled|in_progress|completed|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `work_order_type` STRING COMMENT 'Classification of the work order by its purpose: preventive maintenance (PM) for scheduled upkeep, corrective maintenance (CM) for repairs, emergency for unplanned critical work, inspection for compliance or condition assessment, capital for asset improvement projects, or project for multi-phase construction work.. Valid values are `preventive_maintenance|corrective_maintenance|emergency|inspection|capital|project`',
    CONSTRAINT pk_work_order PRIMARY KEY(`work_order_id`)
) COMMENT 'Core transactional record for all preventive maintenance (PM), corrective maintenance (CM), and emergency work performed on utility assets. Captures work order number, work order type (PM, CM, emergency, inspection, capital), priority, originating asset, work description, craft/trade required, estimated and actual labor hours, estimated and actual material cost, estimated and actual total cost (OPEX vs CAPEX classification), work order status (created, planned, scheduled, in-progress, completed, closed), scheduled start/finish dates, actual start/finish dates, crew assignment, outage required flag, outage duration, safety permit references, and completion notes. Sourced from Oracle WAM / IBM Maximo WMS. Feeds regulatory O&M cost reporting and rate case OPEX/CAPEX substantiation.';

CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`pm_schedule` (
    `pm_schedule_id` BIGINT COMMENT 'Unique identifier for the preventive maintenance schedule record. Primary key.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: PM schedules driven by specific regulatory obligations (NERC vegetation management, EPA leak detection, PUC inspection mandates). Links maintenance frequency to regulatory requirements. Removes denorm',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: PM schedules must allocate maintenance labor and material budgets to cost centers for financial planning, variance analysis, and regulatory cost-of-service reporting. Replaces denormalized cost_center',
    `master_id` BIGINT COMMENT 'Foreign key reference to the specific asset to which this PM schedule is assigned. Null if the schedule applies to an asset class rather than an individual asset.',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to market.ppa_contract. Business justification: Preventive maintenance schedules for PPA assets must align with contract availability requirements, coordinate planned outages with counterparty notification obligations, and ensure maintenance doesn',
    `asset_class_code` STRING COMMENT 'Code identifying the asset class (e.g., XFMR-DIST, BREAKER-HV, GAS-REGULATOR) to which this PM schedule applies. Used when the schedule is applied to all assets of a given type rather than a specific asset.',
    `auto_generate_work_order_flag` BOOLEAN COMMENT 'Boolean flag indicating whether work orders should be automatically generated when the schedule triggers (True) or require manual creation (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this PM schedule record was first created in the source system.',
    `effective_end_date` DATE COMMENT 'Date when this PM schedule expires or is retired. Null for schedules with no planned end date.',
    `effective_start_date` DATE COMMENT 'Date when this PM schedule becomes active and begins generating work orders.',
    `estimated_duration_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours required to complete the preventive maintenance tasks. Used for work planning and resource scheduling.',
    `estimated_outage_duration_hours` DECIMAL(18,2) COMMENT 'Estimated duration in hours that the asset will be out of service if an outage is required. Used for outage planning and customer impact assessment.',
    `frequency_interval` STRING COMMENT 'Numeric interval for the PM schedule frequency (e.g., 90 for 90 days, 10000 for 10,000 operating hours). Interpretation depends on frequency_type and frequency_unit.',
    `frequency_type` STRING COMMENT 'Type of frequency basis for the PM schedule. Calendar-based schedules trigger on time intervals (e.g., every 90 days). Meter-based schedules trigger on usage metrics (e.g., every 10,000 operating hours). Condition-based schedules trigger on asset condition thresholds. Event-based schedules trigger on specific operational events.. Valid values are `calendar|meter|condition|event`',
    `frequency_unit` STRING COMMENT 'Unit of measure for the frequency interval (e.g., days, weeks, months, years for calendar-based; hours, cycles, starts for meter-based). [ENUM-REF-CANDIDATE: days|weeks|months|years|hours|cycles|starts — 7 candidates stripped; promote to reference product]',
    `grace_period_days` STRING COMMENT 'Number of days after the next due date that the maintenance can be performed without being considered overdue. Provides scheduling flexibility while maintaining compliance.',
    `last_modified_by` STRING COMMENT 'User ID or name of the person who last modified this PM schedule record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this PM schedule record was last modified in the source system.',
    `last_performed_date` DATE COMMENT 'Date when the preventive maintenance was last completed for this schedule. Used to calculate the next due date.',
    `lead_time_days` STRING COMMENT 'Number of days before the next due date that the work order should be generated. Allows time for planning, material procurement, and crew scheduling.',
    `maintenance_task_description` STRING COMMENT 'Detailed description of the preventive maintenance tasks to be performed (e.g., Inspect breaker contacts, test trip mechanism, verify protective relay settings, perform oil dielectric test).',
    `next_due_date` DATE COMMENT 'Calculated date when the next preventive maintenance is due based on the frequency interval and last performed date. Work orders are typically auto-generated when this date approaches.',
    `outage_required_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the maintenance task requires taking the asset out of service (True) or can be performed while the asset is energized/in-service (False).',
    `pm_plan_name` STRING COMMENT 'Descriptive name of the preventive maintenance plan (e.g., Quarterly Transformer Oil Analysis, Annual Substation Breaker Inspection).',
    `pm_plan_number` STRING COMMENT 'Business identifier for the PM plan, typically assigned by the Enterprise Asset Management (EAM) system (Oracle WAM or IBM Maximo). Used for external reference and reporting.',
    `priority` STRING COMMENT 'Priority level for the preventive maintenance schedule. Critical schedules support Bulk Electric System (BES) assets and NERC compliance. High priority schedules support key distribution and transmission infrastructure. Medium and low priority schedules support general asset population.. Valid values are `critical|high|medium|low`',
    `required_craft` STRING COMMENT 'Craft or trade skill required to perform the maintenance (e.g., Electrician, Lineman, Instrument Technician, Gas Technician). May reference a craft code from the EAM system.',
    `required_crew_size` STRING COMMENT 'Number of personnel required to perform the maintenance task safely and efficiently.',
    `required_materials` STRING COMMENT 'List or description of materials, parts, and consumables required for the maintenance task (e.g., Transformer oil, oil filter, gaskets, contact cleaner).',
    `safety_requirements` STRING COMMENT 'Special safety requirements, permits, or precautions needed for the maintenance task (e.g., Confined space entry permit required, High voltage switching procedure, Gas detection required).',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the PM schedule. Active schedules generate work orders on trigger. Suspended schedules are temporarily paused. Retired schedules are no longer in use. Pending schedules are awaiting activation.. Valid values are `active|suspended|retired|pending`',
    `seasonal_restriction` STRING COMMENT 'Seasonal constraints on when the maintenance can be performed (e.g., Avoid peak summer months, Winter only, Spring/Fall preferred). Used for maintenance that requires outages during low-demand periods.',
    `work_location_code` STRING COMMENT 'Geographic or organizational location code where the maintenance will be performed. Used for crew dispatch and regional maintenance planning.',
    `work_order_type` STRING COMMENT 'Type of work order to be generated when this PM schedule triggers (e.g., PM-INSPECTION, PM-SERVICE, PM-TESTING). Maps to work order type codes in the EAM system.',
    `created_by` STRING COMMENT 'User ID or name of the person who created this PM schedule record in the EAM system.',
    CONSTRAINT pk_pm_schedule PRIMARY KEY(`pm_schedule_id`)
) COMMENT 'Preventive maintenance schedule master defining the recurring maintenance plans applied to asset classes and individual assets. Captures PM plan name, associated asset class or specific asset, maintenance task description, frequency type (calendar-based, meter-based, condition-based), frequency interval (e.g., 90 days, 10,000 operating hours), last performed date, next due date, estimated duration, required craft, required materials, regulatory compliance driver (NERC FAC, PHMSA pipeline integrity, OSHA), and schedule status (active, suspended, retired). Integrates with Oracle WAM / Maximo PM module to auto-generate work orders on schedule trigger. Supports NERC reliability standard compliance and PHMSA pipeline safety program documentation.';

CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`inspection_record` (
    `inspection_record_id` BIGINT COMMENT 'Unique identifier for the inspection record. Primary key for the inspection_record product.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Inspections fulfill specific regulatory obligations (NERC FAC standards, pipeline integrity rules, substation inspections). Tracks which obligation each inspection satisfies. Removes denormalized regu',
    `inspection_crew_id` BIGINT COMMENT 'Identifier of the crew or team that performed the inspection, if applicable. Used when inspections are performed by multi-person teams.',
    `inspector_id` BIGINT COMMENT 'Identifier of the employee or contractor who performed the inspection. Links to workforce or employee master data.',
    `master_id` BIGINT COMMENT 'Identifier of the utility asset that was inspected (generation unit, transmission line, distribution transformer, gas main, substation equipment, etc.).',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Meter inspections, service point checks, and safety inspections occur at customer premises. Required for regulatory compliance reporting, customer notification of inspection results, and access schedu',
    `work_order_id` BIGINT COMMENT 'Reference to the work order under which this inspection was performed, if applicable. Links inspection to maintenance or project work.',
    `corrective_action_priority` STRING COMMENT 'Priority level for recommended corrective actions (immediate, urgent, routine, deferred). Determines the timeframe for follow-up work.. Valid values are `immediate|urgent|routine|deferred`',
    `corrective_action_recommendation` STRING COMMENT 'Inspector recommendation for corrective actions to address identified deficiencies. May include repair, replacement, monitoring, or further investigation.',
    `corrective_action_required_flag` BOOLEAN COMMENT 'Boolean indicator of whether corrective action or follow-up work is required based on inspection findings. True if action required, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was first created in the system. Used for audit trail and data lineage tracking.',
    `deficiency_count` STRING COMMENT 'Number of distinct deficiencies or issues identified during this inspection. Used for deficiency tracking and trend analysis.',
    `deficiency_description` STRING COMMENT 'Detailed narrative description of the deficiencies, anomalies, or issues identified during the inspection. Includes inspector observations and findings.',
    `deficiency_identified_flag` BOOLEAN COMMENT 'Boolean indicator of whether any deficiencies, anomalies, or issues were identified during the inspection. True if deficiencies found, False otherwise.',
    `deficiency_severity` STRING COMMENT 'Highest severity rating of any deficiency identified during the inspection (critical, high, medium, low, none). Drives prioritization of corrective actions.. Valid values are `critical|high|medium|low|none`',
    `inspection_date` DATE COMMENT 'The date on which the field inspection was performed. This is the principal business event timestamp for the inspection occurrence.',
    `inspection_document_reference` STRING COMMENT 'Reference identifier or URI to external inspection documentation, photos, test reports, or supporting materials stored in document management system.',
    `inspection_end_time` TIMESTAMP COMMENT 'Timestamp when the inspection activity was completed in the field. Used to calculate inspection duration and labor hours.',
    `inspection_findings` STRING COMMENT 'Comprehensive narrative of all inspection findings, observations, measurements, and assessments. Serves as the primary inspection documentation record.',
    `inspection_frequency_days` STRING COMMENT 'Required inspection frequency in days based on regulatory requirements or internal maintenance standards. Used to calculate next inspection due date.',
    `inspection_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the inspection location in decimal degrees. Used for spatial analysis and GIS integration.',
    `inspection_location` STRING COMMENT 'Physical location or site where the inspection was performed. May include substation name, line segment, pole number, or GPS coordinates.',
    `inspection_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the inspection location in decimal degrees. Used for spatial analysis and GIS integration.',
    `inspection_method` STRING COMMENT 'Detailed description of the inspection methodology, tools, and techniques used. May include equipment model numbers, test procedures, and measurement protocols.',
    `inspection_notes` STRING COMMENT 'Additional notes, comments, or observations recorded by the inspector. Captures contextual information not covered in structured fields.',
    `inspection_number` STRING COMMENT 'Business identifier for the inspection event, often a human-readable reference number used in field operations and regulatory reporting.',
    `inspection_photos_attached_flag` BOOLEAN COMMENT 'Boolean indicator of whether photographic documentation was captured and attached to this inspection record. True if photos attached, False otherwise.',
    `inspection_program` STRING COMMENT 'Name or code of the regulatory or internal inspection program under which this inspection was conducted (e.g., NERC Transmission Vegetation Management, PHMSA Integrity Management Program, PUC General Order 165 compliance).',
    `inspection_result` STRING COMMENT 'Overall outcome of the inspection (pass, fail, conditional, not applicable). High-level finding that determines whether corrective action is required.. Valid values are `pass|fail|conditional|not_applicable`',
    `inspection_start_time` TIMESTAMP COMMENT 'Timestamp when the inspection activity began in the field. Used for labor tracking and compliance documentation.',
    `inspection_status` STRING COMMENT 'Current lifecycle status of the inspection record (scheduled, in progress, completed, cancelled, deferred). Tracks the inspection workflow state.. Valid values are `scheduled|in_progress|completed|cancelled|deferred`',
    `inspection_type` STRING COMMENT 'Classification of the inspection method or technique used (aerial patrol, ground patrol, thermographic, ultrasonic, pipeline integrity, transformer oil analysis). Determines the inspection protocol and equipment used.. Valid values are `aerial_patrol|ground_patrol|thermographic|ultrasonic|pipeline_integrity|transformer_oil_analysis`',
    `inspector_name` STRING COMMENT 'Full name of the inspector who performed the inspection. Captured for audit trail and regulatory reporting purposes.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection record was last updated in the system. Used for audit trail and change tracking.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next inspection of this asset based on inspection frequency requirements and current inspection findings. Used for preventive maintenance scheduling.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator of whether this inspection was performed to satisfy a regulatory compliance requirement. True for regulatory inspections, False for internal inspections.',
    `weather_conditions` STRING COMMENT 'Weather conditions at the time of inspection. Relevant for outdoor inspections where weather may affect inspection quality or asset condition assessment.',
    CONSTRAINT pk_inspection_record PRIMARY KEY(`inspection_record_id`)
) COMMENT 'Captures individual point-in-time field inspection events performed on utility assets including routine patrol inspections, regulatory compliance inspections, and targeted diagnostic assessments. Distinct from asset_condition in that inspection_record is the raw event record of a specific inspection occurrence, while asset_condition represents the derived, aggregated health state over time. Records inspection date, inspector ID, asset inspected, inspection type (aerial patrol, ground patrol, thermographic, ultrasonic, pipeline integrity, transformer oil analysis), inspection findings (pass/fail/conditional), deficiency severity rating, deficiencies identified, recommended corrective actions, follow-up work order reference, regulatory inspection program reference (NERC FAC-003, PHMSA 49 CFR 192, PUC General Order 165), and next inspection due date. Supports NERC transmission inspection compliance, PHMSA pipeline integrity management program (IMP), and PUC-mandated distribution inspection programs.';

CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`failure_event` (
    `failure_event_id` BIGINT COMMENT 'Unique identifier for the asset failure event record. Primary key for the failure event entity.',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_event. Business justification: Reportable failures (NERC Category 1-5, major outages) trigger mandatory compliance event filings. Links asset failures to regulatory reporting obligations. Critical for NERC violation tracking, penal',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Critical operational link: failure events trigger corrective maintenance work orders. The existing work_order_number (STRING) is a business key reference, not a proper FK. Adding corrective_work_order',
    `distribution_outage_event_id` BIGINT COMMENT 'Reference to the associated outage event record in the Outage Management System (OMS). Links the failure to customer impact and service restoration activities.',
    `master_id` BIGINT COMMENT 'Identifier of the physical asset that experienced the failure. Links to the asset master record in the Enterprise Asset Management (EAM) system.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Asset failures on metering infrastructure (meter socket failures, CT/PT failures, service panel issues) require direct meter linkage for outage correlation, VEE processing of affected intervals, and c',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to market.ppa_contract. Business justification: Failure events on PPA-contracted generation assets impact contract performance obligations, trigger availability guarantee calculations, determine liquidated damages exposure, and require counterparty',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Equipment failures at customer premises (service drops, meters, transformers) require premise linkage for customer impact analysis, outage attribution, and targeted customer communication. Essential f',
    `asset_age_years` STRING COMMENT 'Age of the failed asset in years at the time of failure, calculated from installation date to failure date. Used for age-related failure analysis and asset health scoring.',
    `asset_criticality_rating` STRING COMMENT 'Criticality classification of the failed asset based on customer impact, system reliability importance, and safety considerations. Used for prioritizing corrective actions and replacement investments.. Valid values are `low|medium|high|critical`',
    `asset_location` STRING COMMENT 'Physical location description of the failed asset, including substation name, feeder ID, pole number, or street address. Used for geographic failure analysis and crew dispatch.',
    `consequential_cost_amount` DECIMAL(18,2) COMMENT 'Indirect costs resulting from the failure, including lost revenue during outage, customer compensation payments, regulatory penalties, and emergency response costs.',
    `corrective_action_taken` STRING COMMENT 'Description of the corrective actions taken to restore service and repair or replace the failed asset. Includes temporary repairs, permanent fixes, and preventive measures implemented.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this failure event record was first created in the system. Used for data lineage and audit trail.',
    `customer_minutes_interrupted` DECIMAL(18,2) COMMENT 'Total customer-minutes of interruption, calculated as customers_affected_count multiplied by outage_duration_minutes. Direct input to SAIDI calculation.',
    `customers_affected_count` STRING COMMENT 'Number of customer accounts that experienced service interruption as a result of this failure. Used for SAIFI calculation and regulatory reporting.',
    `detection_timestamp` TIMESTAMP COMMENT 'Date and time when the failure was first detected by monitoring systems, SCADA alarms, or customer calls. May differ from actual failure timestamp for latent failures.',
    `equipment_type` STRING COMMENT 'Classification of the failed equipment type (e.g., transformer, circuit breaker, conductor, pole, underground cable, gas main, meter). Used for failure trend analysis by equipment class.',
    `failure_cause_category` STRING COMMENT 'High-level categorization of the root cause of failure (e.g., equipment defect, environmental conditions, human error, external interference, age-related degradation). Used for trend analysis and preventive maintenance planning.',
    `failure_cost_amount` DECIMAL(18,2) COMMENT 'Total cost of the failure event including direct repair costs, replacement parts, labor, equipment rental, and consequential costs such as lost revenue and customer compensation. Used for asset lifecycle cost analysis and replacement prioritization.',
    `failure_description` STRING COMMENT 'Detailed narrative description of the failure event, including observed symptoms, field crew observations, and any unusual circumstances. Free-text field for operational context.',
    `failure_mode` STRING COMMENT 'Technical classification of how the asset failed. Describes the physical mechanism of failure. [ENUM-REF-CANDIDATE: insulation_breakdown|mechanical_failure|corrosion|overload|lightning_strike|third_party_damage|thermal_degradation|electrical_fault|structural_failure|control_system_failure|communication_failure|software_malfunction — promote to reference product]. Valid values are `insulation_breakdown|mechanical_failure|corrosion|overload|lightning_strike|third_party_damage`',
    `failure_number` STRING COMMENT 'Business identifier for the failure event, typically generated by the Outage Management System (OMS) or EAM system. Used for external reporting and cross-system reference.',
    `failure_severity` STRING COMMENT 'Classification of the failure impact severity. Minor: localized impact, quick restoration. Major: significant customer impact or extended outage. Catastrophic: widespread outage, safety risk, or major asset damage.. Valid values are `minor|major|catastrophic`',
    `failure_timestamp` TIMESTAMP COMMENT 'Date and time when the asset failure occurred. Captured from SCADA alarms, OMS event logs, or field crew reports. Critical for reliability index calculations and root cause analysis.',
    `forced_outage_flag` BOOLEAN COMMENT 'Indicates whether the failure resulted in a forced (unplanned) outage of the asset. True for unplanned outages, False for failures that did not require immediate service interruption.',
    `major_event_day_flag` BOOLEAN COMMENT 'Indicates whether this failure occurred during a Major Event Day as defined by IEEE Std 1366. Failures during MEDs are typically excluded from reliability index calculations per regulatory rules.',
    `nerc_reportable_flag` BOOLEAN COMMENT 'Indicates whether this failure event meets NERC criteria for mandatory reporting as a Bulk Electric System (BES) event or reliability standard violation.',
    `outage_duration_minutes` DECIMAL(18,2) COMMENT 'Total duration of the service interruption in minutes, calculated from failure timestamp to restoration timestamp. Used for SAIDI and CAIDI calculations.',
    `preventive_action_recommended` STRING COMMENT 'Recommended preventive actions to avoid similar failures in the future, such as design changes, maintenance procedure updates, or asset replacement programs.',
    `previous_failure_count` STRING COMMENT 'Number of previous failure events recorded for this specific asset. Used to identify chronic problem assets and prioritize replacement.',
    `puc_reportable_flag` BOOLEAN COMMENT 'Indicates whether this failure event meets state PUC criteria for mandatory reporting, typically based on customer impact thresholds or service quality standards.',
    `rca_completed_flag` BOOLEAN COMMENT 'Indicates whether a formal Root Cause Analysis has been completed for this failure event. True if RCA is complete, False if pending or not required.',
    `rca_findings` STRING COMMENT 'Summary of the root cause analysis findings, including identified root cause, contributing factors, and recommended corrective actions. Free-text field for detailed engineering analysis.',
    `regulatory_reportable_flag` BOOLEAN COMMENT 'Indicates whether this failure event meets the threshold for mandatory reporting to regulatory bodies such as NERC, FERC, or state Public Utility Commissions (PUCs). True if reportable, False otherwise.',
    `repair_cost_amount` DECIMAL(18,2) COMMENT 'Direct cost of repairing or replacing the failed asset, including materials, labor, and contractor expenses. Subset of total failure cost.',
    `restoration_timestamp` TIMESTAMP COMMENT 'Date and time when service was fully restored following the failure event. Used to calculate outage duration and SAIDI contributions.',
    `saidi_contribution` DECIMAL(18,2) COMMENT 'This failure events contribution to the system-wide SAIDI reliability index, measured in minutes per customer. Calculated as customer_minutes_interrupted divided by total customers served.',
    `saifi_contribution` DECIMAL(18,2) COMMENT 'This failure events contribution to the system-wide SAIFI reliability index, measured in interruptions per customer. Calculated as customers_affected_count divided by total customers served.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time when this failure event record was last modified. Used for data lineage and audit trail.',
    `weather_condition` STRING COMMENT 'Weather conditions present at the time of failure. Used to correlate failures with environmental factors and support storm damage analysis. [ENUM-REF-CANDIDATE: clear|rain|snow|ice|wind|lightning|extreme_heat|extreme_cold|fog|tornado|hurricane — promote to reference product]',
    CONSTRAINT pk_failure_event PRIMARY KEY(`failure_event_id`)
) COMMENT 'Records asset failure events including equipment failures, forced outages, and unplanned interruptions. Captures failure date/time, failed asset, failure mode (insulation breakdown, mechanical failure, corrosion, overload, lightning strike, third-party damage), failure cause category, failure severity (minor, major, catastrophic), associated outage event reference, customers affected count, outage duration (minutes), SAIDI/SAIFI contribution, corrective work order reference, root cause analysis (RCA) findings, failure cost (repair + consequential), and whether failure triggered a regulatory reportable event (NERC, PUC). Feeds reliability indices (SAIDI, SAIFI, CAIDI) and supports asset health scoring and replacement prioritization.';

CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`condition` (
    `condition_id` BIGINT COMMENT 'Unique identifier for the asset condition assessment record. Primary key for the asset_condition data product.',
    `master_id` BIGINT COMMENT 'Reference to the utility asset being assessed. Links to the asset master record in the asset management system (Oracle WAM or IBM Maximo).',
    `inspection_record_id` BIGINT COMMENT 'Foreign key linking to asset.inspection_record. Business justification: Condition assessments are often produced by inspection activities. The existing source_inspection_reference (STRING) is a weak reference that should be replaced with a proper FK to inspection_record. ',
    `assessed_by` STRING COMMENT 'Name or identifier of the inspector, technician, or contractor who performed the condition assessment. May reference internal workforce or external service provider.',
    `assessment_cost` DECIMAL(18,2) COMMENT 'Total cost incurred to perform the condition assessment, including labor, equipment, and contractor fees. Used for O&M (Operations and Maintenance) expense tracking.',
    `assessment_date` DATE COMMENT 'Date when the condition assessment was performed. Represents the point-in-time snapshot of asset health.',
    `assessment_method` STRING COMMENT 'Method or technique used to assess the asset condition. Includes visual inspection, diagnostic testing, oil analysis, thermography, LiDAR (Light Detection and Ranging) scan, ultrasonic testing, and partial discharge testing for electrical equipment. [ENUM-REF-CANDIDATE: visual_inspection|diagnostic_testing|oil_analysis|thermography|lidar_scan|ultrasonic_testing|partial_discharge_testing — 7 candidates stripped; promote to reference product]',
    `assessment_notes` STRING COMMENT 'Additional free-text notes or observations from the condition assessment. Captures context, environmental factors, or anomalies not covered by structured fields.',
    `assessment_status` STRING COMMENT 'Lifecycle status of the condition assessment record. Draft assessments are under review; approved assessments are the current authoritative condition state; superseded assessments have been replaced by newer evaluations.. Valid values are `draft|approved|superseded|archived`',
    `assessor_organization` STRING COMMENT 'Organization or company that performed the assessment (internal utility workforce, contracted inspection firm, OEM service provider).',
    `corrosion_level` STRING COMMENT 'Assessment of corrosion severity on metal components of the asset. Critical for gas pipelines, transmission towers, and substation structures.. Valid values are `none|minor|moderate|severe|critical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this condition assessment record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `failure_mode_indicators` STRING COMMENT 'Observed indicators or symptoms of specific failure modes (e.g., overheating, vibration, oil contamination, partial discharge activity). Free-text field capturing diagnostic findings.',
    `health_index` DECIMAL(18,2) COMMENT 'Normalized health index score (0-100) representing the assets current condition relative to its expected lifecycle. Higher values indicate better health. Used for asset replacement prioritization and risk-based maintenance planning.',
    `insulation_condition_score` DECIMAL(18,2) COMMENT 'Condition score specific to the insulation integrity of electrical assets (transformers, cables, switchgear). Scale of 1.0 to 5.0, where lower scores indicate degraded insulation requiring attention.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this condition assessment record. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `loading_history_factor` DECIMAL(18,2) COMMENT 'Factor representing the cumulative impact of historical loading patterns on asset degradation. Values above 1.0 indicate the asset has been operated above nameplate capacity, accelerating wear.',
    `maintenance_recommendation` STRING COMMENT 'Recommended maintenance actions based on the condition assessment (e.g., continue monitoring, schedule preventive maintenance, perform corrective repair, replace asset). Feeds work order generation in EAM system.',
    `mechanical_condition_score` DECIMAL(18,2) COMMENT 'Condition score for mechanical components of the asset (bearings, gears, valves, actuators, structural integrity). Scale of 1.0 to 5.0.',
    `next_assessment_due_date` DATE COMMENT 'Scheduled date for the next condition assessment. Driven by regulatory requirements, manufacturer recommendations, or risk-based inspection intervals.',
    `overall_condition_score` DECIMAL(18,2) COMMENT 'Aggregated health score representing the overall condition of the asset on a scale of 1.0 to 5.0, where 1.0 indicates critical/failed condition and 5.0 indicates excellent/new condition. This score synthesizes multiple condition attributes and inspection findings.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Boolean indicator (True/False) denoting whether this assessment was performed to satisfy a regulatory compliance obligation (NERC, FERC, PUC, PHMSA requirements).',
    `remaining_useful_life_years` DECIMAL(18,2) COMMENT 'Estimated remaining useful life of the asset in years, based on current condition, loading history, and expected degradation rate. Used for capital planning and replacement scheduling.',
    `replacement_urgency` STRING COMMENT 'Categorization of replacement urgency based on condition assessment and risk analysis. Drives capital investment prioritization and rate case justification for asset replacement programs.. Valid values are `immediate|within_1_year|1_to_3_years|3_to_7_years|beyond_7_years`',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score combining probability of failure (derived from condition) and consequence of failure (impact on reliability, safety, and customer service). Used for risk-based maintenance prioritization.',
    `trend` STRING COMMENT 'Trend direction of asset condition based on comparison with previous assessments. Rapidly degrading assets require accelerated intervention.. Valid values are `improving|stable|degrading|rapidly_degrading`',
    CONSTRAINT pk_condition PRIMARY KEY(`condition_id`)
) COMMENT 'Stores the current and historical condition assessments of utility assets, providing a longitudinal health record used for asset replacement prioritization and risk-based maintenance planning. Distinct from inspection_record in that asset_condition represents the derived, aggregated health state of an asset (potentially synthesized from multiple inspections, diagnostic tests, and operational data), while inspection_record captures individual point-in-time field inspection events. Captures assessment date, asset reference, condition assessment method (visual inspection, diagnostic testing, oil analysis, thermography, LiDAR scan), overall condition score (1-5 or health index), individual condition attribute scores (insulation condition, mechanical condition, corrosion level, loading history), remaining useful life estimate, replacement urgency rating (immediate, 1-3 years, 3-7 years, 7+ years), assessed by (inspector/contractor), source inspection reference(s), and next assessment due date. Feeds asset investment planning (AIP) models and supports PUC rate case justification for capital replacement programs.';

CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`work_order_material` (
    `work_order_material_id` BIGINT COMMENT 'Unique identifier for the work order material line item. Primary key for this transactional record of material consumption against a maintenance or capital work order.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Work order material consumption requires proper material master linkage for inventory management, MRP planning, cost rollup to work orders, and regulatory reporting of O&M vs capital material usage. M',
    `work_order_id` BIGINT COMMENT 'Reference to the parent maintenance or capital work order against which this material was requested, issued, consumed, or returned. Links material consumption to the work activity.',
    `cost_center` STRING COMMENT 'Cost center or organizational unit responsible for this material expense. Used for departmental cost allocation and budget tracking across generation, transmission, distribution, and gas operations.',
    `cost_type` STRING COMMENT 'Accounting classification of material cost as either OPEX (Operating Expenditure for maintenance and repairs) or CAPEX (Capital Expenditure for asset improvements and additions). Critical for regulatory rate case cost allocation and financial reporting.. Valid values are `OPEX|CAPEX`',
    `critical_spare_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this material is classified as a critical spare part. Critical spares are high-value, long-lead-time components essential for maintaining system reliability (e.g., transformer spare parts, large circuit breakers). Used for inventory depletion alerts and strategic spare management.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for material cost. Typically USD for U.S. utility operations.. Valid values are `USD`',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this material cost is charged. Maps material expense to the appropriate financial account structure for regulatory reporting and internal cost management.',
    `hazmat_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this material is classified as hazardous (e.g., SF6 gas, PCB-containing oil, asbestos, lead-acid batteries). Triggers special handling, storage, and disposal requirements per EPA and OSHA regulations.',
    `issue_date` DATE COMMENT 'Date when the material was issued from storeroom inventory to the work order. Marks the point at which inventory is decremented and material cost is allocated to the work order.',
    `issued_by` STRING COMMENT 'Name or employee identifier of the storeroom clerk or system user who issued the material to the work order. Supports accountability and audit trail for inventory transactions.',
    `line_number` STRING COMMENT 'Sequential line number of this material item within the parent work order. Used for ordering and referencing specific material lines in work order documentation.',
    `lot_number` STRING COMMENT 'Manufacturer lot or batch number for traceable materials and components. Critical for quality control, warranty tracking, and recall management for items such as transformer oil, SF6 gas, cables, and critical spare parts.',
    `material_source` STRING COMMENT 'Source from which the material was obtained for the work order. Values include storeroom_issue (issued from utility inventory), direct_purchase (procured directly for this work order), contractor_supplied (provided by contractor), emergency_procurement (expedited purchase), customer_provided (supplied by customer).. Valid values are `storeroom_issue|direct_purchase|contractor_supplied|emergency_procurement|customer_provided`',
    `material_status` STRING COMMENT 'Current lifecycle status of this material line item. Values include requested (material need identified), reserved (allocated from inventory), issued (released to work order), consumed (used in work execution), returned (unused material returned to stock), cancelled (request voided).. Valid values are `requested|reserved|issued|consumed|returned|cancelled`',
    `notes` STRING COMMENT 'Free-text notes or comments related to this material transaction. May include special handling instructions, substitution justifications, quality issues, or other contextual information relevant to material usage.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with direct material procurement for this work order. Links material transaction to procurement and accounts payable processes. Null for storeroom-issued materials.',
    `quantity_consumed` DECIMAL(18,2) COMMENT 'Actual quantity of material consumed or installed during work order execution. Represents the final material usage after accounting for any returns or adjustments.',
    `quantity_issued` DECIMAL(18,2) COMMENT 'Actual quantity of material issued from storeroom inventory to the work order. May differ from quantity requested due to availability constraints or revised work scope.',
    `quantity_requested` DECIMAL(18,2) COMMENT 'Quantity of material originally requested by the work planner or technician for the work order. Represents the planned material requirement before actual issue.',
    `quantity_returned` DECIMAL(18,2) COMMENT 'Quantity of material returned to storeroom inventory after work order completion. Represents unused material that was issued but not consumed during the work activity.',
    `received_by` STRING COMMENT 'Name or employee identifier of the technician or crew member who received the material for work order execution. Confirms material custody transfer from storeroom to field operations.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this work order material record was first created in the EAM or ERP system. Supports audit trail and data lineage tracking for material transaction history.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this work order material record was last modified in the EAM or ERP system. Tracks changes to material quantities, costs, or status throughout the work order lifecycle.',
    `return_date` DATE COMMENT 'Date when unused material was returned to storeroom inventory after work order completion. Null if no material was returned. Used for inventory reconciliation and cost adjustment.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized components and equipment. Used for asset traceability, warranty management, and lifecycle tracking of high-value items such as transformer bushings, circuit breakers, meters, and protective relays.',
    `storeroom_location` STRING COMMENT 'Physical storeroom, warehouse, or inventory location code from which the material was issued. Used for inventory tracking and replenishment planning across distributed storeroom network.',
    `total_material_cost` DECIMAL(18,2) COMMENT 'Total cost of material consumed for this line item, calculated as quantity consumed multiplied by unit cost. Aggregates to work order total material cost for O&M expense tracking and rate case substantiation.',
    `transaction_timestamp` TIMESTAMP COMMENT 'Precise timestamp when this material transaction was recorded in the EAM or ERP system. Represents the business event time for material issue, consumption, or return activity.',
    `unit_cost` DECIMAL(18,2) COMMENT 'Cost per unit of measure for the material at the time of issue. Used to calculate total material cost for the work order and supports OPEX/CAPEX cost tracking for regulatory reporting.',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for material quantity tracking. Common values include EA (each), FT (feet), GAL (gallons), LB (pounds), KG (kilograms), M (meters), L (liters), BOX, ROLL, DRUM, CYLINDER, SET. [ENUM-REF-CANDIDATE: EA|FT|GAL|LB|KG|M|L|BOX|ROLL|DRUM|CYLINDER|SET — 12 candidates stripped; promote to reference product]',
    `vendor_name` STRING COMMENT 'Name of the vendor or supplier from whom the material was procured. Applicable for direct purchase and emergency procurement transactions. Null for storeroom-issued materials.',
    `warranty_flag` BOOLEAN COMMENT 'Boolean indicator identifying whether this material or component is covered under manufacturer or vendor warranty. Used for warranty claim tracking and cost recovery from suppliers for defective parts.',
    CONSTRAINT pk_work_order_material PRIMARY KEY(`work_order_material_id`)
) COMMENT 'Line-item transactional record of materials, spare parts, and consumables consumed, reserved, or returned against a maintenance or capital work order. This is a high-volume transactional entity with its own lifecycle (requested → issued → consumed/returned → costed) independent of the parent work order. Captures work order reference, material/part number (cross-referenced to storeroom catalog), material description, storeroom location, quantity requested, quantity issued, quantity returned, unit of measure, unit cost, total material cost, issue date, return date, material source (storeroom issue, direct purchase, contractor-supplied), and lot/serial number for traceable components (e.g., transformer bushings, SF6 gas cylinders). Supports O&M material cost tracking per work order, storeroom inventory consumption reporting, critical spare depletion alerts, and OPEX cost substantiation for regulatory filings. Integrates with SAP MM Materials Management or Oracle ERP Supply Chain for inventory depletion and reorder point triggers.';

CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`warranty` (
    `warranty_id` BIGINT COMMENT 'Unique identifier for the warranty record. Primary key for the warranty product.',
    `capex_project_id` BIGINT COMMENT 'Reference to the capital project under which the warranted asset was installed. Links warranty to Work in Progress (WIP) and Allowance for Funds Used During Construction (AFUDC) tracking for regulatory asset base reporting. Critical for rate case cost allocation.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order that installed or commissioned the warranted asset. Links warranty to installation contractor and workmanship warranty terms. Used to trigger warranty claim workflows when failure events occur within warranty period.',
    `master_id` BIGINT COMMENT 'Reference to the utility asset covered by this warranty. Links to the asset_master product to identify the specific generation, transmission, distribution, or gas infrastructure equipment under warranty coverage.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Warranty validation requires linking to originating purchase order for cost verification, vendor accountability, and capital project cost tracking. Utilities must prove warranty coverage through procu',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Warranty claims, vendor performance tracking, and insurance certificate validation require formal vendor linkage. Utilities manage warranty providers as vendors for procurement compliance, payment pro',
    `renewed_warranty_id` BIGINT COMMENT 'Self-referencing FK on warranty (renewed_warranty_id)',
    `claims_approved_amount` DECIMAL(18,2) COMMENT 'Total dollar value of warranty claims approved and paid by the warranty provider to date. Represents actual cost recovery achieved, reducing Operations and Maintenance (O&M) expenses charged to ratepayers. Critical for regulatory reporting and rate case cost justification. Expressed in USD.',
    `claims_denied_amount` DECIMAL(18,2) COMMENT 'Total dollar value of warranty claims denied by the warranty provider to date. Denied claims result in costs being charged to utility O&M or CAPEX accounts. High denial rates may indicate warranty term violations, inadequate maintenance documentation, or disputes requiring escalation. Expressed in USD.',
    `claims_filed_count` STRING COMMENT 'Total number of warranty claims filed against this warranty to date. Used to track warranty utilization, identify problematic assets or vendors, and support vendor performance scorecarding. High claim counts may indicate quality issues.',
    `claims_pending_amount` DECIMAL(18,2) COMMENT 'Total dollar value of warranty claims currently under review by the warranty provider. Represents potential cost recovery not yet realized. Used for financial forecasting and accrual accounting. Expressed in USD.',
    `coverage_scope` STRING COMMENT 'Defines what costs are covered under the warranty. Parts only covers replacement component costs. Parts and labor includes installation and repair labor. Full replacement covers complete asset replacement if repair is not feasible. Performance guarantee covers operational shortfalls. On-site service includes field service technician dispatch.. Valid values are `parts_only|parts_and_labor|full_replacement|performance_guarantee|on_site_service`',
    `coverage_terms_summary` STRING COMMENT 'High-level summary of warranty terms and conditions including coverage limitations, exclusions, maintenance requirements, and claim procedures. Full warranty document reference should be maintained in document management system.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this warranty record was first created in the system. Audit field for data lineage and regulatory compliance. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Dollar amount the utility must pay before warranty coverage applies to a claim. Common in extended service agreements and third-party warranty insurance. Zero for most manufacturer standard warranties. Expressed in USD.',
    `document_reference` STRING COMMENT 'Reference identifier or URI to the full warranty certificate, agreement, or contract document stored in the enterprise document management system. Provides access to complete warranty terms, conditions, exclusions, and claim procedures.',
    `duration_months` STRING COMMENT 'Length of warranty coverage period expressed in months. Standard manufacturer warranties typically range from 12-60 months. Extended service agreements may provide coverage up to 120+ months. Used for warranty lifecycle planning and asset maintenance scheduling.',
    `expiration_date` DATE COMMENT 'Date when warranty coverage ends. After this date, repair and replacement costs are charged to Operations and Maintenance (O&M) or Capital Expenditure (CAPEX) accounts rather than recovered from warranty provider. Critical for regulatory asset base reporting.',
    `last_modified_by` STRING COMMENT 'User identifier or name of the person or system process that last updated this warranty record. Supports audit trail for warranty status changes, claim updates, and data corrections. May reference HCM system user ID.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this warranty record was last updated. Tracks warranty status changes, claim updates, and data corrections. Audit field for data governance and change tracking. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `maintenance_requirements` STRING COMMENT 'Summary of preventive maintenance activities required to maintain warranty validity. Many manufacturer warranties require adherence to specified maintenance schedules and use of OEM parts. Failure to comply may void warranty coverage. Integrates with PM schedule and inspection record products.',
    `maximum_claim_value` DECIMAL(18,2) COMMENT 'Maximum dollar amount that can be claimed under this warranty over its lifetime. For capital equipment, this may equal or exceed the original asset cost. For performance guarantees, this represents the maximum penalty or credit amount. Expressed in USD.',
    `notes` STRING COMMENT 'Free-form text field for additional warranty information, special conditions, claim history narrative, or vendor negotiation details. Used by asset management and procurement teams for warranty administration and vendor relationship management.',
    `prorated_flag` BOOLEAN COMMENT 'Indicates whether warranty coverage value decreases over time on a prorated basis. True if claim reimbursement is reduced based on asset age or usage. False if full coverage applies throughout warranty period. Common in extended warranties for high-value generation equipment.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether this warranty is subject to regulatory reporting requirements for rate case cost recovery. True if warranty cost savings must be documented for Public Utility Commission (PUC) or Federal Energy Regulatory Commission (FERC) filings. Supports prudent cost management demonstration.',
    `start_date` DATE COMMENT 'Date when warranty coverage becomes effective. Typically the asset in-service date or substantial completion date for capital projects. Used to calculate warranty expiration and claim eligibility windows.',
    `transferable_flag` BOOLEAN COMMENT 'Indicates whether warranty coverage transfers if the asset is relocated, sold, or reassigned to a different facility or service territory. True if warranty remains valid after transfer. False if warranty is void upon asset transfer. Important for asset lifecycle management and divestiture transactions.',
    `warranty_number` STRING COMMENT 'Externally-known unique warranty certificate or agreement number issued by the manufacturer, contractor, or warranty provider. Used for warranty claim filing and tracking.',
    `warranty_status` STRING COMMENT 'Current lifecycle status of the warranty. Active indicates warranty is in force and claims can be filed. Expired indicates warranty period has ended. Claimed indicates a claim has been filed. Voided indicates warranty has been invalidated due to misuse or breach of terms. Supports warranty cost recovery workflows.. Valid values are `active|expired|claimed|voided|suspended|pending_activation`',
    `warranty_type` STRING COMMENT 'Classification of the warranty coverage type. Manufacturer equipment warranty covers defects in materials and workmanship from OEM. Contractor workmanship warranty covers installation quality. Extended service agreement provides post-standard warranty coverage. Performance guarantee ensures asset meets specified operational parameters.. Valid values are `manufacturer_equipment|contractor_workmanship|extended_service_agreement|performance_guarantee|parts_only|full_replacement`',
    `created_by` STRING COMMENT 'User identifier or name of the person or system process that created this warranty record. Supports audit trail and data quality accountability. May reference Human Capital Management (HCM) system user ID.',
    CONSTRAINT pk_warranty PRIMARY KEY(`warranty_id`)
) COMMENT 'Tracks manufacturer and contractor warranties and guarantees associated with utility assets and capital project installations. Captures warranty type (manufacturer equipment warranty, contractor workmanship warranty, extended service agreement, performance guarantee), warranted asset reference, warranty provider (manufacturer, contractor, third-party insurer), warranty start date, warranty expiration date, warranty terms and conditions summary, coverage scope (parts only, parts and labor, full replacement), maximum claim value, deductible amount, claims filed count, claims approved amount, claims denied amount, warranty status (active, expired, claimed, voided), and associated purchase order or capital project reference. Supports warranty cost recovery when assets fail within warranty period — reducing O&M and capital replacement costs charged to ratepayers. Integrates with work_order and failure_event records to trigger warranty claim workflows and with capital_project for installation warranty tracking.';

CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`location` (
    `location_id` BIGINT COMMENT 'Unique identifier for the asset location record. Primary key for the asset location entity.',
    `parent_location_id` BIGINT COMMENT 'Reference to the parent location in a hierarchical location structure, enabling nested location relationships such as a pole within a circuit or a bay within a substation.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Asset locations often coincide with customer premises (pad-mount transformers, meters, service equipment at property). Supports spatial analysis, service territory planning, and asset-to-customer mapp',
    `access_restrictions` STRING COMMENT 'Description of any physical or regulatory restrictions on accessing the asset location, such as locked gates, permit requirements, or hazardous conditions.',
    `city` STRING COMMENT 'City or municipality where the asset location is situated.',
    `coordinate_accuracy_class` STRING COMMENT 'Classification of the spatial coordinate accuracy for the asset location, indicating the precision and reliability of latitude and longitude data.. Valid values are `survey_grade|gps_high|gps_standard|estimated|unknown`',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the asset location is situated.. Valid values are `^[A-Z]{3}$`',
    `county` STRING COMMENT 'County or parish jurisdiction where the asset location resides, used for regulatory compliance and tax reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset location record was first created in the system.',
    `criticality_rating` STRING COMMENT 'Business criticality classification of the asset location based on customer impact, system reliability, and operational importance. Drives maintenance prioritization and emergency response.. Valid values are `critical|high|medium|low`',
    `eam_system_reference` STRING COMMENT 'Unique identifier for this asset location in the source Enterprise Asset Management system (Oracle WAM or IBM Maximo), used for cross-system reconciliation.',
    `easement_reference` STRING COMMENT 'Reference identifier for the utility easement or right-of-way agreement granting access to this location, critical for legal compliance and asset access rights.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation of the asset location above sea level in feet, relevant for transmission line clearance calculations and flood risk assessment.',
    `environmental_zone` STRING COMMENT 'Environmental classification or sensitive area designation for the location, such as wetland, floodplain, or protected habitat, used for environmental compliance.',
    `gas_pressure_zone` STRING COMMENT 'Natural gas pressure zone designation for locations on the gas distribution network, used for pipeline safety and operational planning.',
    `gis_feature_class` STRING COMMENT 'GIS feature class or layer name in the ESRI ArcGIS system where this location is represented, enabling integration with spatial asset management.',
    `gis_object_reference` STRING COMMENT 'Unique object identifier in the GIS system for this asset location, used for cross-system integration between Enterprise Asset Management (EAM) and GIS platforms.',
    `in_service_date` DATE COMMENT 'Date when the asset location became operational and available for asset installation and service delivery.',
    `installation_date` DATE COMMENT 'Date when the asset location was first established or commissioned for utility operations.',
    `land_parcel_reference` STRING COMMENT 'Tax parcel identifier or legal land description for the property where the asset location resides, used for easement management and property tax reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this asset location record was most recently updated, used for data lineage and audit trail.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the asset location in decimal degrees, used for Geographic Information System (GIS) integration and spatial analysis.',
    `location_code` STRING COMMENT 'Business identifier code for the asset location, used for operational reference and work order dispatching. Typically follows utility-specific naming conventions for substations, plants, poles, vaults, and other infrastructure locations.',
    `location_description` STRING COMMENT 'Detailed textual description of the asset location, including landmarks, access instructions, and physical characteristics to aid field crews in locating the site.',
    `location_name` STRING COMMENT 'Human-readable name or designation of the asset location, such as substation name, plant name, or pole identifier.',
    `location_status` STRING COMMENT 'Current operational status of the asset location in its lifecycle. Indicates whether the location is available for asset installation and operational use.. Valid values are `active|inactive|planned|decommissioned|under_construction|temporarily_closed`',
    `location_type` STRING COMMENT 'Classification of the physical or functional location type where utility assets are installed. Determines the spatial and operational characteristics of the location. [ENUM-REF-CANDIDATE: substation|generating_plant|transmission_tower|distribution_pole|vault|manhole|right_of_way — 7 candidates stripped; promote to reference product]',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the asset location in decimal degrees, used for Geographic Information System (GIS) integration and spatial analysis.',
    `modified_by` STRING COMMENT 'User identifier or system account that last modified this asset location record, supporting audit and data governance requirements.',
    `operating_center` STRING COMMENT 'Operational control center or district responsible for managing assets at this location, used for crew dispatching and maintenance planning.',
    `ownership_type` STRING COMMENT 'Classification of the ownership or control arrangement for the asset location, indicating whether it is utility-owned, customer-owned, or under easement.. Valid values are `utility_owned|customer_owned|joint_owned|leased|easement`',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the asset location address.',
    `regulatory_jurisdiction` STRING COMMENT 'Public Utility Commission (PUC) or regulatory body with jurisdiction over this asset location, used for compliance reporting and rate case preparation.',
    `retirement_date` DATE COMMENT 'Date when the asset location was decommissioned or retired from active service, used for regulatory asset base reporting.',
    `service_territory` STRING COMMENT 'Geographic service territory or operating region where the asset location resides, used for jurisdictional and regulatory reporting.',
    `spatial_reference_system` STRING COMMENT 'Coordinate reference system or projection used for the location coordinates, typically WGS84 or a state plane coordinate system.',
    `state` STRING COMMENT 'State or province where the asset location is located, critical for Public Utility Commission (PUC) jurisdictional reporting.',
    `street_address` STRING COMMENT 'Physical street address of the asset location, including street number and name. Used for emergency response, crew dispatching, and regulatory reporting.',
    `substation_name` STRING COMMENT 'Name of the substation where this location resides, applicable for locations within substation boundaries. Used for operational coordination and outage management.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level in kilovolts (kV) at this location, indicating whether it is transmission, sub-transmission, or distribution voltage.',
    CONSTRAINT pk_location PRIMARY KEY(`location_id`)
) COMMENT 'Master record for the physical or functional location where utility assets are installed — substations, plants, poles, vaults, manholes, and right-of-way segments. Provides the spatial anchor for asset hierarchy and work order dispatching, linking assets to GIS coordinates and jurisdictional boundaries.';

CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`inspector` (
    `inspector_id` BIGINT COMMENT 'Primary key for inspector',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor or manager responsible for overseeing this inspectors work assignments and performance.',
    `vendor_id` BIGINT COMMENT 'Identifier of the contracting vendor company if the inspector is a contractor or third-party resource. Null for internal employees.',
    `lead_inspector_id` BIGINT COMMENT 'Self-referencing FK on inspector (lead_inspector_id)',
    `authorized_asset_classes` STRING COMMENT 'Comma-separated list of asset class codes that the inspector is certified and authorized to inspect based on training and certification.',
    `background_check_date` DATE COMMENT 'Date when the most recent background check was completed for the inspector, required for access to critical infrastructure.',
    `certification_level` STRING COMMENT 'Qualification level of the inspector indicating scope of inspection authority and asset complexity they are authorized to inspect.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspector record was first created in the system.',
    `email_address` STRING COMMENT 'Primary corporate email address for the inspector used for work order notifications and inspection report distribution.',
    `emergency_contact_name` STRING COMMENT 'Name of the emergency contact person for the inspector in case of workplace incidents or accidents.',
    `emergency_contact_phone` STRING COMMENT 'Phone number of the emergency contact person for the inspector.',
    `first_name` STRING COMMENT 'Legal first name of the inspector as recorded in human resources systems.',
    `geographic_territory` STRING COMMENT 'Geographic service territory or region assigned to the inspector for inspection coverage (e.g., district codes, county names, or service area identifiers).',
    `hire_date` DATE COMMENT 'Date when the inspector was hired or contracted by the utility company.',
    `home_location_code` STRING COMMENT 'Code identifying the primary work location or service center where the inspector is based for dispatch and assignment purposes.',
    `inspection_count` STRING COMMENT 'Cumulative number of inspections completed by this inspector across all asset types and inspection programs.',
    `inspector_number` STRING COMMENT 'Business identifier assigned to the inspector for external reference and reporting. Typically follows utility-specific numbering convention.',
    `inspector_type` STRING COMMENT 'Classification of the inspector based on employment relationship. Internal inspectors are utility employees, contractors are external resources, third-party are independent auditors, and regulatory are government agency inspectors.',
    `last_name` STRING COMMENT 'Legal last name of the inspector as recorded in human resources systems.',
    `license_expiration_date` DATE COMMENT 'Date when the inspectors license expires and requires renewal to continue performing inspections.',
    `license_number` STRING COMMENT 'State or regulatory body issued license number authorizing the inspector to perform inspections on utility assets.',
    `middle_initial` STRING COMMENT 'Middle initial of the inspector, if applicable.',
    `mobile_device_code` STRING COMMENT 'Identifier of the mobile device or tablet assigned to the inspector for field data collection and work order management.',
    `nerc_clearance_level` STRING COMMENT 'Security clearance level for the inspector to access critical cyber and physical assets under NERC Critical Infrastructure Protection standards.',
    `notes` STRING COMMENT 'Free-form text field for additional notes, comments, or special instructions related to the inspectors qualifications, restrictions, or administrative details.',
    `phone_number` STRING COMMENT 'Primary contact phone number for the inspector, typically mobile device for field communication.',
    `quality_rating` DECIMAL(18,2) COMMENT 'Performance quality score for the inspector based on inspection accuracy, completeness, and audit results. Scale of 0.00 to 5.00.',
    `safety_certification_date` DATE COMMENT 'Date when the inspector last completed required safety training and certification for working on energized equipment and in hazardous environments.',
    `specialization` STRING COMMENT 'Primary area of technical expertise for the inspector (e.g., transmission lines, substations, transformers, gas pipelines, distribution equipment, generation facilities). [ENUM-REF-CANDIDATE: transmission_lines|substations|transformers|gas_pipelines|distribution_equipment|generation_facilities|metering|protection_systems — promote to reference product]',
    `inspector_status` STRING COMMENT 'Current operational status of the inspector indicating availability for inspection assignments.',
    `termination_date` DATE COMMENT 'Date when the inspectors employment or contract with the utility ended. Null for active inspectors.',
    `union_membership_flag` BOOLEAN COMMENT 'Indicates whether the inspector is a member of a labor union. True if union member, False otherwise.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspector record was last modified in the system.',
    `years_of_experience` STRING COMMENT 'Total number of years the inspector has been performing asset inspections in the utility industry.',
    CONSTRAINT pk_inspector PRIMARY KEY(`inspector_id`)
) COMMENT 'Master reference table for inspector. Referenced by inspector_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`inspection_crew` (
    `inspection_crew_id` BIGINT COMMENT 'Primary key for inspection_crew',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `location_id` BIGINT COMMENT 'Reference to the primary service center or operations facility where this inspection crew is based and reports for duty.',
    `employee_id` BIGINT COMMENT 'FK to workforce.employee',
    `parent_inspection_crew_id` BIGINT COMMENT 'Self-referencing FK on inspection_crew (parent_inspection_crew_id)',
    `active_from_date` DATE COMMENT 'Date when this inspection crew was established and became available for work assignment.',
    `active_until_date` DATE COMMENT 'Date when this inspection crew was or will be deactivated or disbanded. Null for currently active crews with no planned end date.',
    `average_inspection_capacity_per_day` DECIMAL(18,2) COMMENT 'Average number of asset inspections this crew can complete per working day, used for work order planning and resource allocation.',
    `certification_level` STRING COMMENT 'Qualification level of the inspection crew indicating the complexity and criticality of assets they are authorized to inspect.',
    `contractor_company_name` STRING COMMENT 'Name of the contracting company providing this inspection crew, applicable only when contractor_flag is True.',
    `contractor_flag` BOOLEAN COMMENT 'Indicates whether this inspection crew is composed of contractor personnel (True) or internal utility employees (False).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection crew record was first created in the system.',
    `crew_code` STRING COMMENT 'Externally-known unique alphanumeric code assigned to the inspection crew for identification in work orders, scheduling systems, and field operations.',
    `crew_name` STRING COMMENT 'Human-readable name or designation of the inspection crew, typically including geographic area or specialization (e.g., North Region T&D Inspection Team).',
    `crew_size` STRING COMMENT 'Number of personnel assigned to this inspection crew, representing the teams capacity for field inspection work.',
    `crew_status` STRING COMMENT 'Current operational status of the inspection crew indicating availability for assignment to inspection work orders.',
    `crew_type` STRING COMMENT 'Classification of the inspection crew based on the asset infrastructure type they specialize in inspecting.',
    `emergency_response_qualified` BOOLEAN COMMENT 'Indicates whether this inspection crew is qualified and available for emergency response and storm restoration inspection work.',
    `equipment_assigned` STRING COMMENT 'List of specialized inspection equipment and tools assigned to this crew (e.g., thermal cameras, ultrasonic detectors, climbing gear).',
    `gis_mobile_device_ids` STRING COMMENT 'Comma-separated list of GIS-enabled mobile device identifiers assigned to this crew for field data collection and asset location verification.',
    `hourly_labor_rate` DECIMAL(18,2) COMMENT 'Standard hourly labor rate for this inspection crew, used for work order costing and budget planning. Expressed in local currency.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this inspection crew record was most recently updated in the system.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent formal performance review conducted for this inspection crew.',
    `last_safety_training_date` DATE COMMENT 'Date when the inspection crew last completed mandatory safety training, used to ensure compliance with safety certification requirements.',
    `next_certification_renewal_date` DATE COMMENT 'Scheduled date for the crews next certification renewal or recertification assessment, ensuring continued qualification for inspection work.',
    `notes` STRING COMMENT 'Free-form text field for additional information about the inspection crew, including special capabilities, restrictions, or operational notes.',
    `operating_region` STRING COMMENT 'Geographic region or service territory where the inspection crew primarily operates, used for work assignment and resource planning.',
    `performance_rating` STRING COMMENT 'Most recent performance evaluation rating for this inspection crew based on inspection quality, timeliness, and safety metrics.',
    `safety_incident_count` STRING COMMENT 'Cumulative count of reportable safety incidents involving this inspection crew, tracked for safety performance monitoring.',
    `shift_schedule` STRING COMMENT 'Standard work shift pattern for this inspection crew, determining availability windows for work order assignment.',
    `specialization_tags` STRING COMMENT 'Comma-separated list of specialized inspection capabilities or equipment expertise (e.g., infrared thermography, drone inspection, high voltage).',
    `union_affiliation` STRING COMMENT 'Labor union or collective bargaining unit to which the inspection crew members belong, relevant for scheduling and labor relations.',
    `vehicle_fleet_ids` STRING COMMENT 'Comma-separated list of vehicle identifiers assigned to this inspection crew for field mobility and equipment transport.',
    `work_order_system_user_group` STRING COMMENT 'User group or role identifier in the EAM work order system (Oracle WAM/IBM Maximo) that this crew is assigned to for work visibility and assignment.',
    CONSTRAINT pk_inspection_crew PRIMARY KEY(`inspection_crew_id`)
) COMMENT 'Master reference table for inspection_crew. Referenced by inspection_crew_id.';

CREATE OR REPLACE TABLE `power_and_utilities`.`asset`.`facility` (
    `facility_id` BIGINT COMMENT 'Primary key for facility',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Facilities are physical structures AT specific locations. The facility product has denormalized address and geospatial attributes that should be normalized to the location product. This eliminates dat',
    `master_id` BIGINT COMMENT 'Foreign key linking to asset.master. Business justification: Facility is a specialized asset type (generation plants, substations, service centers) and should link to its asset master record. The facility product has asset-like attributes (nameplate_capacity, i',
    `parent_facility_id` BIGINT COMMENT 'Self-referencing FK on facility (parent_facility_id)',
    `accumulated_depreciation` DECIMAL(18,2) COMMENT 'Total depreciation expense recognized to date on the facility, calculated using regulatory-approved depreciation rates and methods.',
    `asset_class` STRING COMMENT 'High-level asset classification for financial and depreciation purposes, aligning with the utility chart of accounts and capital planning categories.',
    `capacity_unit_of_measure` STRING COMMENT 'Unit of measurement for the facility capacity. MW for electric generation, MVA for substations, MCF or MMBTU for gas facilities.',
    `construction_completion_date` DATE COMMENT 'Date when construction was substantially completed and the facility was ready for commissioning or placed in service.',
    `construction_start_date` DATE COMMENT 'Date when physical construction or major capital project work began on the facility.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this facility record was first created in the enterprise data system.',
    `criticality_rating` STRING COMMENT 'Risk-based classification indicating the importance of the facility to system reliability and customer service, used to prioritize maintenance and capital investment.',
    `depreciation_method` STRING COMMENT 'Accounting method used to calculate periodic depreciation expense for this facility, as approved by regulatory authorities.',
    `facility_description` STRING COMMENT 'Detailed narrative description of the facility, including its purpose, key equipment, and operational characteristics.',
    `environmental_permit_required` BOOLEAN COMMENT 'Indicates whether the facility requires environmental permits or regulatory approvals for operation (e.g., air quality, water discharge, hazardous materials).',
    `facility_code` STRING COMMENT 'Externally-known unique business identifier for the facility, used across operational systems and regulatory reporting. Typically assigned by the enterprise asset management system.',
    `facility_name` STRING COMMENT 'Official business name of the facility as registered with regulatory authorities and used in operational documentation.',
    `facility_subtype` STRING COMMENT 'Detailed classification providing additional granularity within the facility type (e.g., coal plant, solar farm, switching station, distribution warehouse).',
    `facility_type` STRING COMMENT 'Classification of the facility based on its primary operational function within the utility infrastructure.',
    `ferc_account_code` STRING COMMENT 'FERC Uniform System of Accounts classification code used for regulatory asset base reporting and depreciation schedules in rate cases.',
    `in_service_date` DATE COMMENT 'Date when the facility was first placed into commercial operation and began serving customers or supporting utility operations.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent regulatory or operational inspection performed on the facility.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this facility record was most recently updated in the enterprise data system.',
    `nameplate_capacity` DECIMAL(18,2) COMMENT 'Maximum rated capacity of the facility in megawatts (MW) for generation facilities, or maximum throughput capacity for transmission and distribution facilities.',
    `net_book_value` DECIMAL(18,2) COMMENT 'Current book value of the facility after accumulated depreciation, representing the undepreciated capital investment remaining in the regulatory asset base.',
    `next_inspection_due_date` DATE COMMENT 'Scheduled date for the next required inspection based on regulatory requirements or preventive maintenance schedules.',
    `operating_organization` STRING COMMENT 'Business unit or department responsible for day-to-day operations and maintenance of the facility.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the facility indicating its availability and operational readiness for utility operations.',
    `original_cost` DECIMAL(18,2) COMMENT 'Total capital expenditure incurred to construct or acquire the facility, including direct costs and capitalized interest (AFUDC). Used as the basis for regulatory rate base and depreciation calculations.',
    `owner_organization` STRING COMMENT 'Business unit or legal entity that owns the facility for financial and regulatory reporting purposes.',
    `regulatory_jurisdiction` STRING COMMENT 'Primary regulatory authority level governing this facility for compliance and rate-making purposes.',
    `retirement_date` DATE COMMENT 'Date when the facility was permanently removed from service and retired from the asset base.',
    `service_territory` STRING COMMENT 'Geographic service area or regulatory territory that this facility serves, typically aligned with state or regional boundaries.',
    `useful_life_years` STRING COMMENT 'Expected service life of the facility in years, used for depreciation calculations and long-term capital planning.',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master reference table for facility. Referenced by facility_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities`.`asset`.`master` ADD CONSTRAINT `fk_asset_master_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_child_asset_asset_master_id` FOREIGN KEY (`child_asset_asset_master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ADD CONSTRAINT `fk_asset_hierarchy_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ADD CONSTRAINT `fk_asset_work_order_pm_schedule_id` FOREIGN KEY (`pm_schedule_id`) REFERENCES `power_and_utilities`.`asset`.`pm_schedule`(`pm_schedule_id`);
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ADD CONSTRAINT `fk_asset_pm_schedule_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_inspection_crew_id` FOREIGN KEY (`inspection_crew_id`) REFERENCES `power_and_utilities`.`asset`.`inspection_crew`(`inspection_crew_id`);
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_inspector_id` FOREIGN KEY (`inspector_id`) REFERENCES `power_and_utilities`.`asset`.`inspector`(`inspector_id`);
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ADD CONSTRAINT `fk_asset_inspection_record_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ADD CONSTRAINT `fk_asset_failure_event_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`asset`.`condition` ADD CONSTRAINT `fk_asset_condition_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`asset`.`condition` ADD CONSTRAINT `fk_asset_condition_inspection_record_id` FOREIGN KEY (`inspection_record_id`) REFERENCES `power_and_utilities`.`asset`.`inspection_record`(`inspection_record_id`);
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ADD CONSTRAINT `fk_asset_work_order_material_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_work_order_id` FOREIGN KEY (`work_order_id`) REFERENCES `power_and_utilities`.`asset`.`work_order`(`work_order_id`);
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ADD CONSTRAINT `fk_asset_warranty_renewed_warranty_id` FOREIGN KEY (`renewed_warranty_id`) REFERENCES `power_and_utilities`.`asset`.`warranty`(`warranty_id`);
ALTER TABLE `power_and_utilities`.`asset`.`location` ADD CONSTRAINT `fk_asset_location_parent_location_id` FOREIGN KEY (`parent_location_id`) REFERENCES `power_and_utilities`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ADD CONSTRAINT `fk_asset_inspector_lead_inspector_id` FOREIGN KEY (`lead_inspector_id`) REFERENCES `power_and_utilities`.`asset`.`inspector`(`inspector_id`);
ALTER TABLE `power_and_utilities`.`asset`.`inspection_crew` ADD CONSTRAINT `fk_asset_inspection_crew_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities`.`asset`.`inspection_crew` ADD CONSTRAINT `fk_asset_inspection_crew_parent_inspection_crew_id` FOREIGN KEY (`parent_inspection_crew_id`) REFERENCES `power_and_utilities`.`asset`.`inspection_crew`(`inspection_crew_id`);
ALTER TABLE `power_and_utilities`.`asset`.`facility` ADD CONSTRAINT `fk_asset_facility_location_id` FOREIGN KEY (`location_id`) REFERENCES `power_and_utilities`.`asset`.`location`(`location_id`);
ALTER TABLE `power_and_utilities`.`asset`.`facility` ADD CONSTRAINT `fk_asset_facility_master_id` FOREIGN KEY (`master_id`) REFERENCES `power_and_utilities`.`asset`.`master`(`master_id`);
ALTER TABLE `power_and_utilities`.`asset`.`facility` ADD CONSTRAINT `fk_asset_facility_parent_facility_id` FOREIGN KEY (`parent_facility_id`) REFERENCES `power_and_utilities`.`asset`.`facility`(`facility_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities`.`asset` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities`.`asset` SET TAGS ('dbx_domain' = 'asset');
ALTER TABLE `power_and_utilities`.`asset`.`master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`asset`.`master` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Master ID');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `asset_class` SET TAGS ('dbx_business_glossary_term' = 'Asset Class');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'active|retired|decommissioned|under_construction|standby|out_of_service');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag Number');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Capacity Unit of Measure');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|sum_of_years_digits|units_of_production');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `eam_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Asset Management (EAM) System ID');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `easement_reference` SET TAGS ('dbx_business_glossary_term' = 'Easement Reference');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Account Code');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `gas_pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Gas Pressure Zone');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `gis_feature_class` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Class');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `gis_object_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Object ID');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `land_parcel_reference` SET TAGS ('dbx_business_glossary_term' = 'Land Parcel Reference');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `location_accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Location Accuracy Class');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `location_accuracy_class` SET TAGS ('dbx_value_regex' = 'gps_surveyed|as_built|estimated|unknown');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `naruc_account_code` SET TAGS ('dbx_business_glossary_term' = 'National Association of Regulatory Utility Commissioners (NARUC) Account Code');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `original_cost` SET TAGS ('dbx_business_glossary_term' = 'Original Cost');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `rated_capacity` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `regulatory_asset_base_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base Inclusion Flag');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `salvage_value` SET TAGS ('dbx_business_glossary_term' = 'Salvage Value');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Useful Life (Years)');
ALTER TABLE `power_and_utilities`.`asset`.`master` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV)');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Hierarchy ID');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `child_asset_asset_master_id` SET TAGS ('dbx_business_glossary_term' = 'Child Asset ID');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Asset ID');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `connectivity_role` SET TAGS ('dbx_business_glossary_term' = 'Connectivity Role');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `connectivity_role` SET TAGS ('dbx_value_regex' = 'upstream|downstream|parallel|redundant|backup|isolated');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `cost_rollup_enabled` SET TAGS ('dbx_business_glossary_term' = 'Cost Rollup Enabled');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `criticality_inheritance` SET TAGS ('dbx_business_glossary_term' = 'Criticality Inheritance');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `criticality_inheritance` SET TAGS ('dbx_value_regex' = 'inherit_from_parent|override_independent|aggregate_children|highest_in_branch');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Level');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_business_glossary_term' = 'Hierarchy Type');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `hierarchy_type` SET TAGS ('dbx_value_regex' = 'functional_location|asset_assembly|network_segment|linear_reference|system_subsystem|spatial_containment');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `is_primary_parent` SET TAGS ('dbx_business_glossary_term' = 'Is Primary Parent');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `linear_measure_from` SET TAGS ('dbx_business_glossary_term' = 'Linear Measure From');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `linear_measure_to` SET TAGS ('dbx_business_glossary_term' = 'Linear Measure To');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `linear_measure_unit` SET TAGS ('dbx_business_glossary_term' = 'Linear Measure Unit');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `linear_measure_unit` SET TAGS ('dbx_value_regex' = 'miles|kilometers|feet|meters');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `position_slot` SET TAGS ('dbx_business_glossary_term' = 'Position Slot');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `relationship_description` SET TAGS ('dbx_business_glossary_term' = 'Relationship Description');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|temporary');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `sort_order` SET TAGS ('dbx_business_glossary_term' = 'Sort Order');
ALTER TABLE `power_and_utilities`.`asset`.`hierarchy` ALTER COLUMN `spatial_reference_system` SET TAGS ('dbx_business_glossary_term' = 'Spatial Reference System');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Work in Progress (WIP) Project ID');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `actual_finish_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Finish Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `actual_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Actual Labor Hours');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `actual_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Material Cost');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `actual_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Total Cost');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `afudc_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Allowance for Funds Used During Construction (AFUDC) Eligible Flag');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `closed_by` SET TAGS ('dbx_business_glossary_term' = 'Closed By');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Closed Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `completion_notes` SET TAGS ('dbx_business_glossary_term' = 'Completion Notes');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `cost_classification` SET TAGS ('dbx_business_glossary_term' = 'Cost Classification (OPEX vs CAPEX)');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `cost_classification` SET TAGS ('dbx_value_regex' = 'opex|capex');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `craft_trade_required` SET TAGS ('dbx_business_glossary_term' = 'Craft or Trade Required');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `crew_assignment` SET TAGS ('dbx_business_glossary_term' = 'Crew Assignment');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `estimated_labor_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Labor Hours');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `estimated_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Material Cost');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `estimated_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Cost');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `failure_code` SET TAGS ('dbx_business_glossary_term' = 'Failure Code');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Minutes)');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `outage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Required Flag');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Work Order Priority');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `safety_permit_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Permit Reference');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `scheduled_finish_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Finish Date');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `work_order_description` SET TAGS ('dbx_business_glossary_term' = 'Work Order Description');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_business_glossary_term' = 'Work Order Number');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `work_order_number` SET TAGS ('dbx_value_regex' = '^WO-[0-9]{8,12}$');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `work_order_status` SET TAGS ('dbx_business_glossary_term' = 'Work Order Status');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `power_and_utilities`.`asset`.`work_order` ALTER COLUMN `work_order_type` SET TAGS ('dbx_value_regex' = 'preventive_maintenance|corrective_maintenance|emergency|inspection|capital|project');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Schedule ID');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `asset_class_code` SET TAGS ('dbx_business_glossary_term' = 'Asset Class Code');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `auto_generate_work_order_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Generate Work Order Flag');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `estimated_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration Hours');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `estimated_outage_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Outage Duration Hours');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `frequency_interval` SET TAGS ('dbx_business_glossary_term' = 'Frequency Interval');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `frequency_type` SET TAGS ('dbx_business_glossary_term' = 'Frequency Type');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `frequency_type` SET TAGS ('dbx_value_regex' = 'calendar|meter|condition|event');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `frequency_unit` SET TAGS ('dbx_business_glossary_term' = 'Frequency Unit');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `last_performed_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performed Date');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time Days');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `maintenance_task_description` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Task Description');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `outage_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Required Flag');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `pm_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan Name');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `pm_plan_number` SET TAGS ('dbx_business_glossary_term' = 'Preventive Maintenance (PM) Plan Number');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `required_craft` SET TAGS ('dbx_business_glossary_term' = 'Required Craft');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `required_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Required Crew Size');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `required_materials` SET TAGS ('dbx_business_glossary_term' = 'Required Materials');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Requirements');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'active|suspended|retired|pending');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `seasonal_restriction` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Restriction');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `work_location_code` SET TAGS ('dbx_business_glossary_term' = 'Work Location Code');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `work_order_type` SET TAGS ('dbx_business_glossary_term' = 'Work Order Type');
ALTER TABLE `power_and_utilities`.`asset`.`pm_schedule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` SET TAGS ('dbx_subdomain' = 'condition_monitoring');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_record_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Record ID');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_crew_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Crew ID');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspector_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector ID');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `corrective_action_priority` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Priority');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `corrective_action_priority` SET TAGS ('dbx_value_regex' = 'immediate|urgent|routine|deferred');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `corrective_action_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Recommendation');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `corrective_action_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required Flag');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `deficiency_description` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Description');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `deficiency_identified_flag` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Identified Flag');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `deficiency_severity` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Severity');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `deficiency_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Inspection Document Reference');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_end_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection End Time');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_findings` SET TAGS ('dbx_business_glossary_term' = 'Inspection Findings');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_frequency_days` SET TAGS ('dbx_business_glossary_term' = 'Inspection Frequency Days');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_latitude` SET TAGS ('dbx_business_glossary_term' = 'Inspection Latitude');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_location` SET TAGS ('dbx_business_glossary_term' = 'Inspection Location');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_longitude` SET TAGS ('dbx_business_glossary_term' = 'Inspection Longitude');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_method` SET TAGS ('dbx_business_glossary_term' = 'Inspection Method');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_notes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Notes');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_number` SET TAGS ('dbx_business_glossary_term' = 'Inspection Number');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_photos_attached_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Photos Attached Flag');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_program` SET TAGS ('dbx_business_glossary_term' = 'Inspection Program');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional|not_applicable');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_start_time` SET TAGS ('dbx_business_glossary_term' = 'Inspection Start Time');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled|deferred');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'aerial_patrol|ground_patrol|thermographic|ultrasonic|pipeline_integrity|transformer_oil_analysis');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_record` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` SET TAGS ('dbx_subdomain' = 'condition_monitoring');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `failure_event_id` SET TAGS ('dbx_business_glossary_term' = 'Failure Event ID');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Work Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `distribution_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event ID');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `asset_age_years` SET TAGS ('dbx_business_glossary_term' = 'Asset Age (Years)');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `asset_criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Asset Criticality Rating');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `asset_criticality_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `asset_location` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Description');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `consequential_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Consequential Cost Amount');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `consequential_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `customer_minutes_interrupted` SET TAGS ('dbx_business_glossary_term' = 'Customer Minutes Interrupted (CMI)');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `customers_affected_count` SET TAGS ('dbx_business_glossary_term' = 'Customers Affected Count');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `detection_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Failure Detection Date and Time');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `failure_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Failure Cause Category');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `failure_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Failure Cost Amount');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `failure_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `failure_description` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Description');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `failure_mode` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `failure_mode` SET TAGS ('dbx_value_regex' = 'insulation_breakdown|mechanical_failure|corrosion|overload|lightning_strike|third_party_damage');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `failure_number` SET TAGS ('dbx_business_glossary_term' = 'Failure Event Number');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `failure_severity` SET TAGS ('dbx_business_glossary_term' = 'Failure Severity Level');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `failure_severity` SET TAGS ('dbx_value_regex' = 'minor|major|catastrophic');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `failure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Failure Date and Time');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `forced_outage_flag` SET TAGS ('dbx_business_glossary_term' = 'Forced Outage Indicator');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `major_event_day_flag` SET TAGS ('dbx_business_glossary_term' = 'Major Event Day (MED) Indicator');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `nerc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Reportable Indicator');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Outage Duration (Minutes)');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `preventive_action_recommended` SET TAGS ('dbx_business_glossary_term' = 'Preventive Action Recommended');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `previous_failure_count` SET TAGS ('dbx_business_glossary_term' = 'Previous Failure Count');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `puc_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Reportable Indicator');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `rca_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Completed Indicator');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `rca_findings` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis (RCA) Findings');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `regulatory_reportable_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reportable Event Indicator');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `repair_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Direct Repair Cost Amount');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `repair_cost_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `restoration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Restoration Date and Time');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `saidi_contribution` SET TAGS ('dbx_business_glossary_term' = 'System Average Interruption Duration Index (SAIDI) Contribution');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `saifi_contribution` SET TAGS ('dbx_business_glossary_term' = 'System Average Interruption Frequency Index (SAIFI) Contribution');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`failure_event` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition at Failure');
ALTER TABLE `power_and_utilities`.`asset`.`condition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`asset`.`condition` SET TAGS ('dbx_subdomain' = 'condition_monitoring');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `condition_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition ID');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `inspection_record_id` SET TAGS ('dbx_business_glossary_term' = 'Source Inspection Record Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `assessed_by` SET TAGS ('dbx_business_glossary_term' = 'Assessed By');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `assessment_cost` SET TAGS ('dbx_business_glossary_term' = 'Assessment Cost');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `assessment_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'draft|approved|superseded|archived');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `assessor_organization` SET TAGS ('dbx_business_glossary_term' = 'Assessor Organization');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `corrosion_level` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Level');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `corrosion_level` SET TAGS ('dbx_value_regex' = 'none|minor|moderate|severe|critical');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `failure_mode_indicators` SET TAGS ('dbx_business_glossary_term' = 'Failure Mode Indicators');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `health_index` SET TAGS ('dbx_business_glossary_term' = 'Health Index');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `health_index` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `health_index` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `insulation_condition_score` SET TAGS ('dbx_business_glossary_term' = 'Insulation Condition Score');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `loading_history_factor` SET TAGS ('dbx_business_glossary_term' = 'Loading History Factor');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `maintenance_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Recommendation');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `mechanical_condition_score` SET TAGS ('dbx_business_glossary_term' = 'Mechanical Condition Score');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `next_assessment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Assessment Due Date');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `overall_condition_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Condition Score');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `remaining_useful_life_years` SET TAGS ('dbx_business_glossary_term' = 'Remaining Useful Life (Years)');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `replacement_urgency` SET TAGS ('dbx_business_glossary_term' = 'Replacement Urgency Rating');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `replacement_urgency` SET TAGS ('dbx_value_regex' = 'immediate|within_1_year|1_to_3_years|3_to_7_years|beyond_7_years');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `trend` SET TAGS ('dbx_business_glossary_term' = 'Condition Trend');
ALTER TABLE `power_and_utilities`.`asset`.`condition` ALTER COLUMN `trend` SET TAGS ('dbx_value_regex' = 'improving|stable|degrading|rapidly_degrading');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` SET TAGS ('dbx_subdomain' = 'maintenance_operations');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `work_order_material_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Material ID');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `cost_center` SET TAGS ('dbx_business_glossary_term' = 'Cost Center');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `cost_type` SET TAGS ('dbx_business_glossary_term' = 'Cost Type (OPEX/CAPEX)');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `cost_type` SET TAGS ('dbx_value_regex' = 'OPEX|CAPEX');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `critical_spare_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Spare Flag');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Flag');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Material Issue Date');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `issued_by` SET TAGS ('dbx_business_glossary_term' = 'Issued By');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Material Line Number');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `material_source` SET TAGS ('dbx_business_glossary_term' = 'Material Source');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `material_source` SET TAGS ('dbx_value_regex' = 'storeroom_issue|direct_purchase|contractor_supplied|emergency_procurement|customer_provided');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Transaction Status');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'requested|reserved|issued|consumed|returned|cancelled');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Material Transaction Notes');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `quantity_consumed` SET TAGS ('dbx_business_glossary_term' = 'Quantity Consumed');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `quantity_issued` SET TAGS ('dbx_business_glossary_term' = 'Quantity Issued');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `quantity_requested` SET TAGS ('dbx_business_glossary_term' = 'Quantity Requested');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `quantity_returned` SET TAGS ('dbx_business_glossary_term' = 'Quantity Returned');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `received_by` SET TAGS ('dbx_business_glossary_term' = 'Received By');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `return_date` SET TAGS ('dbx_business_glossary_term' = 'Material Return Date');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `storeroom_location` SET TAGS ('dbx_business_glossary_term' = 'Storeroom Location');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `total_material_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Material Cost');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `transaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Material Transaction Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `unit_cost` SET TAGS ('dbx_business_glossary_term' = 'Unit Cost');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `power_and_utilities`.`asset`.`work_order_material` ALTER COLUMN `warranty_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Flag');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `warranty_id` SET TAGS ('dbx_business_glossary_term' = 'Warranty Identifier (ID)');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Project Identifier (ID)');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Installation Work Order Identifier (ID)');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier (ID)');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `renewed_warranty_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `claims_approved_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claims Approved Amount');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `claims_denied_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claims Denied Amount');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `claims_filed_count` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claims Filed Count');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `claims_pending_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Claims Pending Amount');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Scope');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `coverage_scope` SET TAGS ('dbx_value_regex' = 'parts_only|parts_and_labor|full_replacement|performance_guarantee|on_site_service');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `coverage_terms_summary` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Terms Summary');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Warranty Deductible Amount');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `document_reference` SET TAGS ('dbx_business_glossary_term' = 'Warranty Document Reference');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `duration_months` SET TAGS ('dbx_business_glossary_term' = 'Warranty Duration in Months');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `maintenance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Warranty Maintenance Requirements');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `maximum_claim_value` SET TAGS ('dbx_business_glossary_term' = 'Maximum Warranty Claim Value');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Warranty Notes');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `prorated_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Prorated Coverage Flag');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Start Date');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Warranty Transferable Flag');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `warranty_number` SET TAGS ('dbx_business_glossary_term' = 'Warranty Number');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `warranty_status` SET TAGS ('dbx_business_glossary_term' = 'Warranty Status');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `warranty_status` SET TAGS ('dbx_value_regex' = 'active|expired|claimed|voided|suspended|pending_activation');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_business_glossary_term' = 'Warranty Type');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `warranty_type` SET TAGS ('dbx_value_regex' = 'manufacturer_equipment|contractor_workmanship|extended_service_agreement|performance_guarantee|parts_only|full_replacement');
ALTER TABLE `power_and_utilities`.`asset`.`warranty` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `power_and_utilities`.`asset`.`location` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`asset`.`location` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Identifier (ID)');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `parent_location_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Location Identifier (ID)');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `access_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Access Restrictions');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `coordinate_accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Accuracy Class');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `coordinate_accuracy_class` SET TAGS ('dbx_value_regex' = 'survey_grade|gps_high|gps_standard|estimated|unknown');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Criticality Rating');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `eam_system_reference` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Asset Management (EAM) System Identifier (ID)');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `easement_reference` SET TAGS ('dbx_business_glossary_term' = 'Easement Reference');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Feet)');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `environmental_zone` SET TAGS ('dbx_business_glossary_term' = 'Environmental Zone');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `gas_pressure_zone` SET TAGS ('dbx_business_glossary_term' = 'Gas Pressure Zone');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `gis_feature_class` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Feature Class');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `gis_object_reference` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Object Identifier (ID)');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `in_service_date` SET TAGS ('dbx_business_glossary_term' = 'In-Service Date');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `land_parcel_reference` SET TAGS ('dbx_business_glossary_term' = 'Land Parcel Reference');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `location_name` SET TAGS ('dbx_business_glossary_term' = 'Location Name');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_business_glossary_term' = 'Location Status');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `location_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|under_construction|temporarily_closed');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `location_type` SET TAGS ('dbx_business_glossary_term' = 'Location Type');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `modified_by` SET TAGS ('dbx_business_glossary_term' = 'Modified By');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `operating_center` SET TAGS ('dbx_business_glossary_term' = 'Operating Center');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'utility_owned|customer_owned|joint_owned|leased|easement');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'Retirement Date');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `service_territory` SET TAGS ('dbx_business_glossary_term' = 'Service Territory');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `spatial_reference_system` SET TAGS ('dbx_business_glossary_term' = 'Spatial Reference System');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `substation_name` SET TAGS ('dbx_business_glossary_term' = 'Substation Name');
ALTER TABLE `power_and_utilities`.`asset`.`location` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (Kilovolts)');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` SET TAGS ('dbx_subdomain' = 'condition_monitoring');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `inspector_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `lead_inspector_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspector` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_crew` SET TAGS ('dbx_subdomain' = 'condition_monitoring');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_crew` ALTER COLUMN `inspection_crew_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Crew Identifier');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_crew` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_crew` ALTER COLUMN `parent_inspection_crew_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`inspection_crew` ALTER COLUMN `hourly_labor_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`asset`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`asset`.`facility` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities`.`asset`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `power_and_utilities`.`asset`.`facility` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`facility` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`asset`.`facility` ALTER COLUMN `parent_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
