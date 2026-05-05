-- Schema for Domain: workforce | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:22

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`workforce` COMMENT 'Field workforce management including crew scheduling, dispatch, work assignment, mobile workforce coordination, labor tracking, and emergency storm response staffing. Manages technicians, lineworkers, meter readers, field service personnel, qualifications, certifications, and union agreements. Integrates with ClickSoftware WFM and SAP HR. Supports T&D construction, O&M crew dispatch, and OSHA safety training compliance.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`technician` (
    `technician_id` BIGINT COMMENT 'Unique surrogate identifier for the field workforce technician record in the Databricks Silver Layer. Serves as the primary key for the technician master record used in dispatch, scheduling, and OSHA compliance tracking.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Technician records represent field workforce personnel that are also employees; linking to employee eliminates duplicate personal attributes and enables unified HR reporting. New FK employee_id added ',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Scheduling process assigns technicians to a home facility for shift planning and safety compliance; linking enables facility‑based crew dispatch.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Asset Maintenance Scheduling report links each field technician to the IT asset they service, essential for planning and compliance.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: SCADA Operations staffing matrix links technicians to the SCADA system they operate, required for NERC‑CIP compliance reporting.',
    `base_location_code` STRING COMMENT 'The code identifying the technicians primary assigned service center, depot, or yard from which they are dispatched. Used for crew scheduling, travel time calculations, and storm response staging. Sourced from ClickSoftware WFM and SAP HR Infotype 0001 (Organizational Assignment).',
    `cdl_expiration_date` DATE COMMENT 'The expiration date of the technicians Commercial Drivers License (CDL). Used to enforce vehicle operation eligibility and trigger renewal notifications. Dispatch eligibility for heavy equipment operations is blocked when CDL is expired.',
    `cdl_license_class` STRING COMMENT 'The class of Commercial Drivers License (CDL) held by the technician, if any. Required for operating heavy utility vehicles, bucket trucks, and line equipment. Class A covers combination vehicles; Class B covers single heavy vehicles; Class C covers smaller commercial vehicles. Sourced from SAP HR.. Valid values are `A|B|C|none`',
    `clicksoftware_resource_code` STRING COMMENT 'The resource identifier assigned to the technician in ClickSoftware Workforce Management (WFM). Used for scheduling, dispatch, and mobile workforce coordination. Enables bi-directional synchronization between the Silver Layer and the WFM system.',
    `cost_center_code` STRING COMMENT 'The SAP FI/CO cost center to which the technicians labor costs are allocated. Used for CAPEX vs OPEX labor cost tracking, T&D project costing, and regulatory rate case (GRC) labor cost reporting. Sourced from SAP HR Infotype 0001.',
    `craft_type` STRING COMMENT 'The skilled trade or craft classification of the field technician, defining the type of work they are qualified to perform (e.g., Lineworker, Meter Reader, Gas Technician, T&D Construction, Field Service Technician, Substation Technician). Sourced from SAP HR and ClickSoftware WFM resource profile. [ENUM-REF-CANDIDATE: lineworker|meter_reader|gas_technician|td_construction|field_service|substation_technician|cable_splicer|relay_technician — promote to reference product]',
    `dispatch_eligible` BOOLEAN COMMENT 'Indicates whether the technician is currently eligible to be dispatched for field work assignments. Set to False when the technician is on leave, suspended, lacks required active certifications, or has a safety hold. Evaluated by ClickSoftware WFM during scheduling.',
    `drug_test_date` DATE COMMENT 'The date the technicians most recent drug and alcohol test was administered. Used to enforce testing frequency requirements for safety-sensitive roles under DOT and PHMSA regulations.',
    `drug_test_status` STRING COMMENT 'The current status of the technicians most recent DOT or company-mandated drug and alcohol test. Required for safety-sensitive positions operating heavy equipment or working on energized electrical infrastructure. Sourced from SAP HR or third-party testing system.. Valid values are `pass|fail|pending|not_required`',
    `employment_status` STRING COMMENT 'Current lifecycle status of the technicians employment relationship with the utility. Drives eligibility for dispatch, scheduling, and access to operational systems. Sourced from SAP HR Infotype 0000 (Actions).. Valid values are `active|on_leave|terminated|suspended|probationary`',
    `employment_type` STRING COMMENT 'Classification of the technicians employment arrangement with the utility. Determines eligibility for union agreements, overtime rules, and benefit entitlements. Sourced from SAP HR Infotype 0001.. Valid values are `full_time|part_time|contract|temporary|seasonal`',
    `ethnicity_code` STRING COMMENT 'The self-reported ethnicity classification of the technician per EEO-1 reporting categories. Used for federal EEO regulatory reporting and workforce diversity analytics. Sourced from SAP HR. [ENUM-REF-CANDIDATE: white|black_african_american|hispanic_latino|asian|native_american|pacific_islander|two_or_more|not_disclosed — promote to reference product]',
    `hire_date` DATE COMMENT 'The date the technician was officially hired by the utility company. Used to calculate seniority for union dispatch priority, benefit eligibility, and workforce tenure analytics. Sourced from SAP HR Infotype 0000.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'The technicians current base hourly wage rate in USD. Used for labor cost allocation to work orders, CAPEX vs OPEX labor tracking, and regulatory rate case (GRC) labor cost filings. Sourced from SAP HR Infotype 0008. Classified as confidential.',
    `last_osha_training_date` DATE COMMENT 'The date the technician most recently completed required OSHA safety training (e.g., OSHA 10, OSHA 30, or utility-specific electrical safety training per 29 CFR 1910.269). Used to enforce training currency requirements and trigger recertification workflows.',
    `nerc_cip_access_level` STRING COMMENT 'The level of NERC CIP-authorized access granted to the technician for Bulk Electric System (BES) critical infrastructure. Determines eligibility for work assignments at substations and control facilities subject to NERC CIP-004 personnel risk assessment requirements.. Valid values are `none|physical|logical|both`',
    `nerc_cip_background_check_date` DATE COMMENT 'The date the technicians most recent NERC CIP-004 personnel risk assessment (background check) was completed. Required for access to BES critical cyber assets and physical security perimeters. Must be renewed per NERC CIP-004 requirements.',
    `org_unit_code` STRING COMMENT 'The SAP HR organizational unit (department or work group) to which the technician belongs. Defines the reporting hierarchy for workforce planning, headcount reporting, and regulatory labor filings. Sourced from SAP HR Infotype 0001.',
    `osha_qualified` BOOLEAN COMMENT 'Indicates whether the technician holds current OSHA qualification status required for field work on electrical or gas infrastructure. Derived from active OSHA training certifications. Critical gate for dispatch eligibility on T&D and O&M work orders.',
    `osha_training_expiration_date` DATE COMMENT 'The date on which the technicians current OSHA safety training certification expires. When this date is reached, dispatch_eligible is set to False until recertification is completed. Critical for OSHA 29 CFR 1910.269 compliance.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether the technician is eligible for overtime pay under FLSA and applicable CBA rules. Exempt (salaried management) technicians are False; non-exempt hourly field workers are True. Sourced from SAP HR Infotype 0008.',
    `pay_grade` STRING COMMENT 'The compensation pay grade or band assigned to the technician, determining base wage range and step progression under the applicable CBA or management compensation structure. Sourced from SAP HR Infotype 0008. Classified as confidential business data.',
    `preferred_name` STRING COMMENT 'The name the technician prefers to be called in operational communications, dispatch notifications, and crew coordination. May differ from legal first name. Sourced from SAP HR or ClickSoftware WFM profile.',
    `primary_skill_code` STRING COMMENT 'The primary technical skill code assigned to the technician in ClickSoftware WFM, used as the dominant matching criterion for work order assignment and crew scheduling. Aligns with the WFM skill catalog (e.g., OH_LINE_CONSTRUCTION, UG_CABLE_SPLICE, GAS_MAIN_REPAIR, AMI_METER_INSTALL). Sourced from ClickSoftware WFM resource profile.',
    `record_created_timestamp` TIMESTAMP COMMENT 'The timestamp when the technician master record was first created in the Databricks Silver Layer. Supports data lineage, audit trail, and record lifecycle tracking. Populated automatically on initial load from SAP HR or ClickSoftware WFM.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'The timestamp when the technician master record was most recently updated in the Databricks Silver Layer. Used for change data capture (CDC), incremental processing, and audit trail maintenance.',
    `sap_personnel_number` STRING COMMENT 'The unique personnel number assigned to the technician in SAP HR (Infotype 0000). This is the authoritative source-system identifier used to cross-reference payroll, benefits, and HR master data in SAP ERP. Distinct from the surrogate technician_id.',
    `secondary_skill_codes` STRING COMMENT 'Comma-separated list of secondary skill codes from the ClickSoftware WFM skill catalog that the technician is qualified to perform beyond their primary skill. Enables flexible multi-skill dispatch during storm response and peak demand periods. Sourced from ClickSoftware WFM.',
    `service_start_date` DATE COMMENT 'The date the technician began active field service in their current craft or role. May differ from hire_date if the technician transferred from a non-field role or changed craft classification. Used for craft seniority calculations and CBA compliance.',
    `service_territory_code` STRING COMMENT 'The geographic service territory or district to which the technician is primarily assigned for T&D operations, O&M dispatch, and emergency response. Aligns with GIS-defined service territory boundaries in Esri ArcGIS. Sourced from ClickSoftware WFM.',
    `storm_response_tier` STRING COMMENT 'The emergency storm response mobilization tier assigned to the technician, defining their priority and role during major outage events. Tier 1 = immediate first responders; Tier 2 = secondary wave; Tier 3 = support/logistics; Exempt = not required for storm duty. Used by OMS and ClickSoftware WFM for emergency staffing.. Valid values are `tier_1|tier_2|tier_3|exempt`',
    `supervisor_personnel_number` STRING COMMENT 'The SAP personnel number of the technicians direct supervisor or crew foreman. Used for approval workflows, OSHA incident reporting chain of command, and dispatch escalation. Sourced from SAP HR Infotype 0001 (Organizational Assignment).',
    `termination_date` DATE COMMENT 'The date the technicians employment was terminated, if applicable. Null for active employees. Used to deactivate dispatch eligibility, revoke system access, and support workforce attrition reporting. Sourced from SAP HR Infotype 0000.',
    `travel_radius_miles` DECIMAL(18,2) COMMENT 'The maximum travel radius in miles from the technicians base location that they are contractually or operationally authorized to travel for work assignments under normal (non-storm) conditions. Used by ClickSoftware WFM for geographic dispatch optimization.',
    `union_affiliation` STRING COMMENT 'The labor union to which the technician belongs, if any. Drives application of collective bargaining agreement (CBA) rules for scheduling, overtime, dispatch priority, and grievance management. Common affiliations include IBEW (International Brotherhood of Electrical Workers) and UWUA (Utility Workers Union of America). Sourced from SAP HR Infotype 0011.. Valid values are `ibew|uwua|iuoe|non_union|management`',
    `union_local_number` STRING COMMENT 'The specific local chapter number of the union to which the technician belongs (e.g., IBEW Local 1245). Required for CBA compliance, grievance tracking, and labor reporting. Null for non-union and management employees. Sourced from SAP HR.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `vehicle_assignment_code` STRING COMMENT 'The fleet asset code of the utility vehicle (bucket truck, service van, digger derrick, etc.) currently assigned to the technician for field operations. Used for fleet management, GPS tracking integration, and work order costing. Sourced from Maximo EAM or fleet management system.',
    `work_schedule_code` STRING COMMENT 'The SAP HR work schedule rule code defining the technicians standard shift pattern (e.g., 4x10, 5x8, rotating shift, on-call). Drives ClickSoftware WFM availability windows, overtime eligibility, and CBA compliance for scheduling. Sourced from SAP HR Infotype 0007.',
    `worker_classification` STRING COMMENT 'The hierarchical skill and responsibility classification of the technician within their craft. Determines pay grade, work assignment eligibility, and supervisory authority on crew dispatches. Sourced from SAP HR Infotype 0001 and union agreement tables.. Valid values are `journeyman|apprentice|foreman|crew_lead|supervisor|specialist`',
    CONSTRAINT pk_technician PRIMARY KEY(`technician_id`)
) COMMENT 'Master record for all field workforce personnel including lineworkers, meter readers, field service technicians, gas technicians, and T&D construction crew members. Serves as the SSOT for worker identity, employment classification, union affiliation, craft type, and base assignment. Sourced from SAP HR and ClickSoftware WFM. Distinct from the corporate HR employee record — this is the operational field workforce profile used for dispatch, scheduling, and OSHA compliance tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`crew` (
    `crew_id` BIGINT COMMENT 'Unique surrogate identifier for the field crew unit within the Power and Utilities workforce data platform. Primary key for the crew entity. Role classification: MASTER_RESOURCE.',
    `gis_boundary_id` BIGINT COMMENT 'Reference to the geographic dispatch zone or service territory to which this crew is primarily assigned. Supports territory-based routing and load balancing in the Distribution Management System (DMS) and ClickSoftware WFM.',
    `depot_id` BIGINT COMMENT 'Reference to the facility (depot, garage, or service center) where this crew is based and from which it is typically dispatched. Used for travel-time optimization, vehicle assignment, and storm staging logistics in ClickSoftware WFM.',
    `labor_rate_id` BIGINT COMMENT 'Foreign key linking to workforce.labor_rate. Business justification: Crews labor rates are defined in labor_rate table; linking provides accurate rate lookup and removes code column.',
    `employee_id` BIGINT COMMENT 'Reference to the SAP HR employee record of the designated crew lead (foreman or lead technician) responsible for supervising field operations, safety compliance, and work order sign-off for this crew.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Field operations assign crews to sites for outage restoration; site linkage supports crew deployment dashboards.',
    `technician_id` BIGINT COMMENT 'Reference to the SAP HR employee record of the designated crew lead (foreman or lead technician) responsible for supervising field operations, safety compliance, and work order sign-off for this crew.',
    `union_agreement_id` BIGINT COMMENT 'Foreign key linking to workforce.union_agreement. Business justification: Crew belongs to a union agreement; linking enables enforcement of labor rules and eliminates redundant code column.',
    `arc_flash_rating_cal_cm2` DECIMAL(18,2) COMMENT 'Maximum arc flash incident energy rating in calories per square centimeter (cal/cm²) for which this crews PPE is rated. Determines the maximum voltage class and equipment the crew can safely work on. Required for NFPA 70E and OSHA electrical safety compliance.',
    `avg_jobs_per_shift` DECIMAL(18,2) COMMENT 'Historical average number of work orders completed by this crew per shift, calculated over a rolling period. Used by ClickSoftware WFM capacity planning and scheduling optimization to set realistic daily job load targets.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this crew record was first created in the source system (ClickSoftware WFM or SAP HR). Serves as the RECORD_AUDIT_CREATED field for this MASTER_RESOURCE entity. Stored in ISO 8601 format with timezone offset.',
    `crew_code` STRING COMMENT 'Externally-known alphanumeric business identifier for the crew unit as assigned in ClickSoftware WFM and referenced in dispatch orders, work orders, and SAP PM. Serves as the BUSINESS_IDENTIFIER for this MASTER_RESOURCE entity.. Valid values are `^[A-Z0-9-]{3,20}$`',
    `crew_name` STRING COMMENT 'Human-readable display name of the crew unit (e.g., North District Line Crew 4, Gas Distribution Crew 12). Serves as the IDENTITY_LABEL for this MASTER_RESOURCE entity. Used in dispatch screens, scheduling boards, and operational reports.',
    `crew_type` STRING COMMENT 'Categorical classification of the crew by the type of utility work performed. Drives dispatch eligibility, skill matching, and safety protocol assignment. Serves as the primary CLASSIFICATION_OR_TYPE for this MASTER_RESOURCE entity. [ENUM-REF-CANDIDATE: electric_line|gas_distribution|metering|substation|transmission|storm_restoration — promote to reference product]. Valid values are `electric_line|gas_distribution|metering|substation|transmission|storm_restoration`',
    `deactivation_date` DATE COMMENT 'Date on which this crew unit was disbanded, deactivated, or permanently removed from dispatch eligibility. Null for currently active crews. Supports historical workforce analysis and regulatory reporting.',
    `effective_date` DATE COMMENT 'Date on which this crew unit became operationally active and eligible for dispatch. Marks the start of the crews lifecycle in the workforce management system. Used for tenure reporting and historical crew composition analysis.',
    `gas_operator_qualified` BOOLEAN COMMENT 'Indicates whether this crew holds Operator Qualification (OQ) certification required by PHMSA for performing covered tasks on natural gas distribution and transmission pipelines. True = OQ-certified for gas work.',
    `gis_region_code` STRING COMMENT 'Esri ArcGIS region code identifying the geographic service territory region where this crew primarily operates. Enables spatial analysis of crew coverage, outage response mapping, and T&D asset maintenance territory alignment.',
    `is_emergency_qualified` BOOLEAN COMMENT 'Indicates whether this crew is certified and pre-qualified for emergency storm response and mutual aid dispatch under NERC reliability standards and state PUC emergency response plans. True = eligible for emergency activation.',
    `is_mutual_aid_eligible` BOOLEAN COMMENT 'Indicates whether this crew can be deployed to assist other utilities under mutual aid agreements (e.g., EEI Mutual Assistance Program). Distinct from internal emergency qualification — mutual aid requires additional credentialing and travel authorization.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this crew record in the source system. Used for incremental data pipeline processing, change detection, and audit trail maintenance in the Databricks Silver layer.',
    `last_safety_audit_date` DATE COMMENT 'Date of the most recent safety audit or field safety observation conducted for this crew. Used to track compliance with internal safety management programs and OSHA recordkeeping requirements.',
    `max_travel_radius_miles` DECIMAL(18,2) COMMENT 'Maximum distance in miles this crew is authorized or contractually permitted to travel from their home depot for a standard (non-emergency) dispatch. Used by ClickSoftware WFM routing engine to filter eligible crews for a given work order location.',
    `notes` STRING COMMENT 'Free-text operational notes or remarks about this crew unit, such as temporary restrictions, special capabilities, equipment limitations, or scheduling constraints. Visible to dispatchers in ClickSoftware WFM.',
    `operational_status` STRING COMMENT 'Current lifecycle state of the crew unit indicating whether it is available for dispatch and assignment. Serves as the LIFECYCLE_STATUS for this MASTER_RESOURCE entity. storm_standby indicates the crew is pre-positioned for emergency storm response.. Valid values are `active|inactive|on_leave|storm_standby|disbanded`',
    `osha_safety_training_expiry_date` DATE COMMENT 'Date on which the crews current OSHA-mandated safety training certification expires. Crews with expired certifications must be blocked from dispatch until recertification is completed. Supports OSHA 29 CFR 1910.269 compliance tracking.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates whether members of this crew are eligible for overtime pay under the applicable union CBA and FLSA regulations. Drives overtime cost calculations in SAP HR payroll and ClickSoftware WFM scheduling.',
    `ppe_compliance_status` STRING COMMENT 'Current status of the crews Personal Protective Equipment (PPE) compliance as verified during the most recent safety inspection. Non-compliant crews must be blocked from energized work dispatch per OSHA 29 CFR 1910.269.. Valid values are `compliant|non_compliant|pending_review`',
    `safety_incident_count_ytd` STRING COMMENT 'Count of OSHA-recordable safety incidents attributed to this crew in the current calendar year. Used for safety performance monitoring, crew risk scoring, and OSHA 300 log compliance. Reset annually.',
    `sap_hr_org_unit_code` STRING COMMENT 'SAP HR organizational unit identifier to which this crew is mapped in the HR hierarchy. Enables linkage between field crew operational data and HR cost reporting, headcount planning, and payroll processing.',
    `shift_type` STRING COMMENT 'Standard shift schedule assigned to this crew. Drives scheduling windows in ClickSoftware WFM, overtime eligibility calculations, and union CBA compliance for shift differentials.. Valid values are `day|evening|night|rotating|on_call`',
    `size` STRING COMMENT 'Authorized headcount (number of personnel) assigned to this crew unit. Serves as the principal MEASUREMENT_OR_VALUE for this MASTER_RESOURCE entity. Used for capacity planning, dispatch feasibility, and OSHA minimum crew-size compliance checks.',
    `specialty_certifications` STRING COMMENT 'Comma-delimited list of specialty certifications held by the crew as a unit (e.g., CDL,HazMat,Gas_Leak_Response,Confined_Space). Drives advanced dispatch eligibility filtering for specialized work orders in ClickSoftware WFM.',
    `standard_end_time` TIMESTAMP COMMENT 'Scheduled end time (HH:MM, 24-hour format) for this crews standard shift. Used alongside standard_start_time to define the crews available dispatch window and calculate daily labor hours.',
    `standard_start_time` TIMESTAMP COMMENT 'Scheduled start time (HH:MM, 24-hour format) for this crews standard shift. Used by ClickSoftware WFM for automated scheduling, dispatch window calculation, and overtime threshold monitoring.',
    `storm_priority_tier` STRING COMMENT 'Integer priority tier (1 = highest priority) assigned to this crew for storm restoration dispatch sequencing. Tier 1 crews are activated first during major outage events. Used by the OMS storm management module to optimize SAIDI/SAIFI restoration performance.',
    `vehicle_id` BIGINT COMMENT 'Reference to the primary fleet vehicle (bucket truck, digger derrick, service van, etc.) assigned to this crew for field operations. Sourced from the fleet/asset management system and linked to Maximo EAM vehicle records.',
    `voltage_class` STRING COMMENT 'Highest voltage class this crew is authorized and qualified to work on. Critical for dispatch eligibility — a distribution crew cannot be dispatched to transmission-level work. Aligns with NERC and OSHA electrical safety qualification requirements.. Valid values are `distribution|subtransmission|transmission|low_voltage|gas_only`',
    `wfm_crew_external_code` STRING COMMENT 'Native crew identifier as stored in ClickSoftware WFM. Preserved for cross-system reconciliation, data lineage tracing, and integration with WFM dispatch APIs. Distinct from the surrogate crew_id used in the lakehouse.',
    `work_function` STRING COMMENT 'Primary operational function this crew is configured to perform. Distinguishes T&D construction crews from O&M maintenance crews, storm restoration crews, and gas operations crews. Used for work order routing and resource planning. [ENUM-REF-CANDIDATE: construction|maintenance|inspection|storm_restoration|gas_ops|metering|emergency — promote to reference product]',
    CONSTRAINT pk_crew PRIMARY KEY(`crew_id`)
) COMMENT 'Defines a named field crew unit composed of one or more technicians assigned to perform T&D construction, O&M maintenance, storm restoration, or gas distribution work. Tracks crew type (electric line, gas, metering, substation), crew size, home depot/garage, crew lead, and operational status. A crew is a persistent organizational unit that can be dispatched as a single entity in ClickSoftware WFM.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`crew_member` (
    `crew_member_id` BIGINT COMMENT 'Unique surrogate identifier for the crew member association record in the Databricks Silver Layer. Serves as the primary key for this junction entity linking a worker to a crew with a specific role and effective period.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Tracking each crew members cost center is required for labor budgeting and expense allocation reports.',
    `crew_id` BIGINT COMMENT 'Reference to the crew to which this worker is assigned. Supports many-to-many crew composition over time as rosters change with seasonal staffing, storm augmentation, and contractor supplementation.',
    `employee_id` BIGINT COMMENT 'Reference to the individual field worker (technician, lineworker, meter reader, or field service personnel) assigned to this crew. Sourced from SAP HR employee master.',
    `technician_id` BIGINT COMMENT 'Reference to the individual field worker (technician, lineworker, meter reader, or field service personnel) assigned to this crew. Sourced from SAP HR employee master.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Contractor companies are registered vendors; linking enables labor cost tracking, compliance, and contractor performance monitoring.',
    `apprentice_program_year` STRING COMMENT 'For workers with crew_role of apprentice, indicates the current year of the apprenticeship program (1 through 5 for IBEW lineworker apprenticeships). Determines eligible task scope, supervision ratio requirements, and applicable wage step per the CBA.',
    `assignment_type` STRING COMMENT 'Classifies the nature of the crew membership assignment. Permanent assignments reflect standard roster composition. Storm assignments are activated during emergency response events. Mutual aid assignments reflect workers deployed from or received by other utilities under mutual assistance agreements.. Valid values are `permanent|temporary|storm|training|mutual_aid`',
    `availability_end_time` TIMESTAMP COMMENT 'The timestamp at which this crew members availability for dispatch ends for their shift. Used by ClickSoftware WFM to prevent over-scheduling and to manage fatigue rule compliance during extended storm restoration events.',
    `availability_start_time` TIMESTAMP COMMENT 'The timestamp at which this crew member becomes available for dispatch at the start of their shift for this assignment. Used by ClickSoftware WFM scheduling engine for real-time crew availability and OMS outage restoration crew dispatch.',
    `background_check_date` DATE COMMENT 'The date on which the most recent background check was completed for this crew member. Required for NERC CIP-004 compliance for workers with CIP access, and for contractor qualification per state PUC requirements.',
    `cdl_expiration_date` DATE COMMENT 'The expiration date of the workers Commercial Drivers License. Used to trigger renewal alerts and prevent dispatch of workers with expired CDLs to vehicle-operating roles. Integrated with ClickSoftware WFM compliance checks.',
    `cdl_license_number` STRING COMMENT 'The state-issued Commercial Drivers License number for this worker, required when cdl_required_flag is true. Stored for DOT compliance verification and pre-dispatch validation. Classified as confidential PII per FMCSA regulations.',
    `cdl_required_flag` BOOLEAN COMMENT 'Indicates whether this crew member role requires a valid Commercial Drivers License (CDL) for operating heavy utility vehicles, bucket trucks, or digger derricks assigned to this crew. Drives pre-dispatch license verification checks.',
    `cip_access_flag` BOOLEAN COMMENT 'Indicates whether this crew member has been granted access to NERC CIP-defined Critical Infrastructure Protection facilities (e.g., substations, control rooms, communication nodes). Requires background check and personnel risk assessment per NERC CIP-004.',
    `contractor_po_number` STRING COMMENT 'The SAP MM purchase order number governing the contract under which this contractor crew member is engaged. Links workforce deployment to financial commitments for CAPEX/OPEX cost tracking and accounts payable reconciliation.',
    `craft_code` STRING COMMENT 'The trade or craft designation identifying the workers primary skill set (e.g., lineworker, electrician, gas technician, meter technician, substation technician). Used in ClickSoftware WFM for skill-based dispatch and crew composition validation. [ENUM-REF-CANDIDATE: lineworker|electrician|gas_tech|meter_tech|substation_tech|cable_splicer|tree_trimmer — promote to reference product]',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this crew member association record was first created in the system, sourced from ClickSoftware WFM or SAP HR. Provides audit trail for crew roster changes and supports regulatory compliance documentation.',
    `crew_lead_flag` BOOLEAN COMMENT 'Indicates whether this worker is designated as the crew lead or foreman for this crew assignment. A crew may have only one active lead at a time. Used for supervisory accountability, safety briefing responsibility, and OSHA incident reporting chain of command.',
    `crew_role` STRING COMMENT 'The functional role of the worker within the crew hierarchy. Determines supervisory authority, task eligibility, and pay rate applicability. Lead and foreman roles carry supervisory responsibility; apprentice and helper roles require journeyman oversight per union agreement and OSHA safety standards.. Valid values are `lead|journeyman|apprentice|helper|foreman|contractor`',
    `dispatch_zone` STRING COMMENT 'The geographic dispatch zone or service territory code within which this crew member is authorized and expected to respond. Used by GE PowerOn DMS/OMS for crew dispatch during outage restoration and by ClickSoftware WFM for field service scheduling.',
    `effective_end_date` DATE COMMENT 'The date on which the workers membership in this crew ended or is scheduled to end. Null indicates an open-ended, currently active assignment. Populated upon crew reassignment, seasonal demobilization, storm crew stand-down, or contractor departure.',
    `effective_start_date` DATE COMMENT 'The date on which the workers membership in this crew became effective. Used to reconstruct historical crew composition for incident investigation, regulatory reporting, and workforce analytics. Supports time-bounded crew roster queries.',
    `fatigue_hours_worked` DECIMAL(18,2) COMMENT 'Cumulative hours worked by this crew member in the current fatigue management window (typically 16-hour or 24-hour rolling period). Used to enforce NERC FAC-002 fatigue management rules and DOT hours-of-service limits during storm restoration.',
    `last_safety_briefing_date` DATE COMMENT 'The date of the most recent safety tailgate briefing attended by this crew member. Required for OSHA 29 CFR 1910.269 pre-job briefing compliance documentation and safety audit trails.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'The timestamp of the most recent modification to this crew member association record. Supports incremental data pipeline processing in the Databricks Silver Layer and provides audit trail for crew roster change management.',
    `membership_status` STRING COMMENT 'Current lifecycle status of the workers crew membership. Active indicates the worker is currently rostered on the crew. Suspended may reflect a safety hold or disciplinary action. Pending indicates a future-dated assignment awaiting activation.. Valid values are `active|inactive|suspended|pending|terminated`',
    `mobile_device_code` STRING COMMENT 'The identifier of the mobile device (tablet or smartphone) issued to this crew member for ClickSoftware WFM field app access, work order receipt, and real-time status updates. Used for device management and field connectivity troubleshooting.',
    `mutual_aid_utility` STRING COMMENT 'For storm augmentation or mutual aid assignments, identifies the name of the external utility company that deployed this worker. Null for internal employees. Required for mutual aid cost recovery billing and EEI mutual assistance program reporting.',
    `nerc_qualified_flag` BOOLEAN COMMENT 'Indicates whether this crew member holds current NERC PER-005 qualification for performing switching operations on the Bulk Electric System (BES). Required for crew members assigned to transmission switching, substation operations, or SCADA-controlled switching tasks.',
    `osha_qualified_flag` BOOLEAN COMMENT 'Indicates whether this worker meets OSHAs definition of a qualified person for electrical work on energized lines and equipment as required by 29 CFR 1910.269 and 1926.950. Must be true for workers assigned to live-line T&D construction and maintenance tasks.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether this crew member is eligible for overtime compensation under the applicable CBA or FLSA provisions for this crew assignment. Drives overtime cost forecasting during storm response and extended outage restoration events.',
    `per_diem_eligible_flag` BOOLEAN COMMENT 'Indicates whether this crew member is entitled to per diem allowances (meals, lodging) for this assignment, typically applicable to storm mutual aid deployments or out-of-territory assignments. Drives travel expense accruals and FEMA cost recovery documentation.',
    `ppe_kit_assigned` STRING COMMENT 'Identifier or description of the Personal Protective Equipment kit assigned to this crew member for this assignment (e.g., arc flash PPE category, rubber glove class). Required for OSHA 29 CFR 1910.269 PPE compliance tracking and safety audit trails.',
    `primary_work_center` STRING COMMENT 'The SAP PM/HR work center or service territory to which this crew member is primarily assigned. Determines geographic dispatch zone, vehicle assignment, and T&D operational area responsibility.',
    `safety_training_current_flag` BOOLEAN COMMENT 'Indicates whether the workers mandatory OSHA safety training certifications are current and not expired as of the effective_start_date of this crew assignment. A false value should prevent dispatch to hazardous work orders per OSHA compliance controls.',
    `scheduled_hours` DECIMAL(18,2) COMMENT 'The number of labor hours this crew member is scheduled to work on this crew assignment for the current scheduling period. Used by ClickSoftware WFM for capacity planning and by SAP HR time management for shift scheduling.',
    `source_system` STRING COMMENT 'Identifies the operational system of record from which this crew member association record was ingested into the Databricks Silver Layer. Supports data lineage tracking and conflict resolution when multiple systems contribute crew roster data.. Valid values are `ClickSoftware_WFM|SAP_HR|Maximo_EAM|manual`',
    `union_classification` STRING COMMENT 'The union job classification code applicable to this worker in this crew assignment (e.g., IBEW Journeyman Lineman, IBEW Apprentice Lineman, UWUA Gas Technician). Governs applicable wage rates, work rules, overtime eligibility, and jurisdictional work boundaries per the collective bargaining agreement. [ENUM-REF-CANDIDATE: IBEW_journeyman_lineman|IBEW_apprentice_lineman|UWUA_gas_tech|IBEW_foreman|non_union|contractor — promote to reference product]',
    `union_local_number` STRING COMMENT 'The specific union local chapter number to which the worker belongs (e.g., IBEW Local 1245, UWUA Local 132). Required for labor relations reporting, grievance tracking, and CBA compliance verification.. Valid values are `^[A-Z]{2,6}-[0-9]{1,5}$`',
    `vehicle_code` BIGINT COMMENT 'Reference to the utility vehicle (bucket truck, service van, digger derrick) assigned to this crew member for this assignment period. Supports fleet utilization tracking and DOT vehicle inspection compliance.',
    `wbs_element` STRING COMMENT 'The SAP PS Work Breakdown Structure element for capital project labor cost allocation when this crew member is assigned to a CAPEX project (e.g., transmission line construction, substation upgrade). Required for RAB tracking and CPCN project reporting.',
    `worker_type` STRING COMMENT 'Categorizes the workers employment relationship with the utility. Distinguishes regular employees from contractors, temporary hires, seasonal workers, and storm augmentation personnel. Drives payroll treatment, benefits eligibility, and OSHA recordkeeping obligations.. Valid values are `employee|contractor|temporary|seasonal|storm_augment`',
    CONSTRAINT pk_crew_member PRIMARY KEY(`crew_member_id`)
) COMMENT 'Association entity linking individual technicians to crews, capturing role within the crew (lead, journeyman, apprentice, helper), effective dates of crew membership, union classification, and active status. Supports many-to-many crew composition over time as crew rosters change with seasonal staffing, storm augmentation, and contractor supplementation.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` (
    `work_order_assignment_id` BIGINT COMMENT 'Unique identifier for the work order assignment record. Primary key for this transactional dispatch entity linking workforce resources to work execution tasks.',
    `crew_id` BIGINT COMMENT 'Reference to the crew or team assigned to this work order when the assignment is for a multi-person crew rather than an individual technician. Nullable when assignment is to a single technician.',
    `technician_id` BIGINT COMMENT 'Reference to the individual technician, lineworker, meter reader, or field service personnel assigned to this work order. Links to the workforce employee master record in SAP HR or ClickSoftware resource pool.',
    `work_order_id` BIGINT COMMENT 'Reference to the parent work order from Maximo EAM or GE PowerOn OMS that this assignment fulfills. Links the dispatch record to the underlying maintenance, construction, or service task.',
    `actual_arrival_timestamp` TIMESTAMP COMMENT 'Actual date and time when the technician or crew arrived at the work site, typically captured via mobile device GPS or manual check-in. Used for SLA compliance tracking and labor costing.',
    `actual_departure_timestamp` TIMESTAMP COMMENT 'Actual date and time when the technician or crew departed the work site, typically captured via mobile device. Used for travel time calculation and next-assignment routing.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual date and time when work was completed on site. Used for labor costing, productivity metrics, and work order closure processing.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual date and time when work began on site, distinct from arrival time. Captures the moment active work commenced, used for labor tracking and productivity analysis.',
    `assignment_notes` STRING COMMENT 'Free-text notes or special instructions for the technician or crew regarding this assignment. May include site access instructions, customer contact information, safety warnings, or work-specific guidance.',
    `assignment_number` STRING COMMENT 'Human-readable business identifier for this assignment, typically generated by ClickSoftware WFM or the dispatching system. Used for operational tracking and communication with field personnel.',
    `assignment_status` STRING COMMENT 'Current lifecycle state of the work order assignment. Tracks the progression from initial dispatch through field execution to completion or cancellation. Updated by mobile workforce application or dispatcher. [ENUM-REF-CANDIDATE: dispatched|en_route|on_site|in_progress|completed|cancelled|suspended|reassigned — 8 candidates stripped; promote to reference product]',
    `assignment_type` STRING COMMENT 'Classification of the assignment based on the nature and urgency of the work. Distinguishes between planned maintenance, emergency response, storm restoration, and other operational categories.. Valid values are `scheduled|emergency|on_demand|storm_response|preventive_maintenance|corrective_maintenance`',
    `cancellation_reason_code` STRING COMMENT 'Code identifying the reason for assignment cancellation when status is cancelled. Used for operational analysis and process improvement. Nullable when assignment is not cancelled. [ENUM-REF-CANDIDATE: customer_cancelled|weather|equipment_unavailable|crew_unavailable|duplicate|work_completed_by_other — promote to reference product]',
    `certification_required_flag` BOOLEAN COMMENT 'Indicates whether specific certifications or qualifications are required for this assignment (e.g., OSHA safety training, CDL, confined space entry). True when certifications are mandatory, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this assignment record was first created in the source system. Used for audit trail and data lineage tracking.',
    `customer_appointment_flag` BOOLEAN COMMENT 'Indicates whether this assignment requires a scheduled customer appointment or access to customer premises. True when customer coordination is required, False for utility-side work. Used for appointment window tracking and customer communication.',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Date and time when the assignment was dispatched to the technician or crew by the workforce management system or dispatcher. Represents the official start of the assignment lifecycle.',
    `equipment_required_flag` BOOLEAN COMMENT 'Indicates whether specialized equipment or vehicles are required for this assignment (e.g., bucket truck, digger derrick, cable splicer). True when special equipment is needed, False for standard assignments.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this assignment record was last updated in the source system. Used for change tracking and data synchronization.',
    `mobile_acknowledgment_flag` BOOLEAN COMMENT 'Indicates whether the technician acknowledged receipt of the assignment via mobile device. True when acknowledged, False when not yet acknowledged. Used for dispatch confirmation and communication tracking.',
    `mobile_acknowledgment_timestamp` TIMESTAMP COMMENT 'Date and time when the technician acknowledged the assignment via mobile device. Used for response time tracking and dispatcher confirmation.',
    `on_site_duration_minutes` DECIMAL(18,2) COMMENT 'Total time in minutes spent on site from arrival to departure. Calculated as the difference between actual departure and actual arrival timestamps. Used for labor costing and productivity metrics.',
    `outage_related_flag` BOOLEAN COMMENT 'Indicates whether this assignment is related to a customer outage or service interruption. True for outage restoration work, False for non-outage work. Used for reliability metrics (SAIDI, SAIFI, CAIDI) and priority dispatch.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether this assignment is eligible for overtime compensation based on time of day, day of week, or assignment type. True when overtime rules apply, False for regular time. Used for labor costing and payroll integration.',
    `priority_code` STRING COMMENT 'Business priority level for this assignment, determining dispatch sequence and resource allocation. Critical assignments (e.g., public safety hazards, major outages) receive immediate attention.. Valid values are `critical|high|medium|low|routine`',
    `reassignment_count` STRING COMMENT 'Number of times this work order has been reassigned to different technicians or crews. Used for dispatch efficiency analysis and work order complexity assessment. Zero for first-time assignments.',
    `safety_hazard_code` STRING COMMENT 'Code identifying known safety hazards at the work site (e.g., energized equipment, confined space, traffic hazard, hazardous materials). Used for crew safety briefings and OSHA compliance. [ENUM-REF-CANDIDATE: energized_equipment|confined_space|traffic_hazard|hazmat|fall_hazard|excavation|overhead_lines — promote to reference product]',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned date and time when the work is expected to be completed. Used for scheduling optimization, customer communication, and capacity planning.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned date and time when the technician or crew is expected to begin work on site. Used for crew scheduling, customer appointment windows, and resource planning.',
    `service_territory_code` STRING COMMENT 'Geographic service territory or district where the work is being performed. Used for crew routing, jurisdiction tracking, and regional reporting. Aligns with utility service area boundaries.',
    `skill_requirement_code` STRING COMMENT 'Primary skill or qualification required for this assignment (e.g., lineworker, electrician, meter technician, gas fitter). Used for crew matching and certification compliance. Aligns with union job classifications.',
    `source_system_code` STRING COMMENT 'Code identifying the operational system that originated this assignment record (ClickSoftware WFM, Maximo EAM, GE PowerOn OMS, SAP PM, or manual dispatch). Used for data lineage and system integration tracking.. Valid values are `clicksoftware|maximo|poweron|sap_pm|manual`',
    `storm_response_flag` BOOLEAN COMMENT 'Indicates whether this assignment is part of an emergency storm restoration effort. True for storm-related work, False for normal operations. Used for mutual aid tracking and regulatory reporting (SAIDI/SAIFI exclusions).',
    `travel_time_minutes` DECIMAL(18,2) COMMENT 'Total travel time in minutes from the technicians previous location to the work site. Used for labor costing, route optimization, and workforce productivity analysis.',
    `union_agreement_code` STRING COMMENT 'Code identifying the applicable collective bargaining agreement or union contract governing this assignment. Used for labor costing, overtime rules, and crew assignment compliance.',
    `work_duration_minutes` DECIMAL(18,2) COMMENT 'Actual productive work time in minutes, calculated as the difference between actual start and actual end timestamps. Excludes setup, breaks, and non-productive time. Used for labor costing and efficiency analysis.',
    `work_location_address` STRING COMMENT 'Street address or location description of the work site. Used for crew navigation, customer communication, and operational reporting. May include customer premises or utility infrastructure locations.',
    `work_location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the work site in decimal degrees. Used for mobile navigation, crew routing, and geospatial analysis. Sourced from GIS or mobile device GPS.',
    `work_location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the work site in decimal degrees. Used for mobile navigation, crew routing, and geospatial analysis. Sourced from GIS or mobile device GPS.',
    CONSTRAINT pk_work_order_assignment PRIMARY KEY(`work_order_assignment_id`)
) COMMENT 'Transactional record capturing the dispatch and assignment of a technician or crew to a specific work order (sourced from Maximo EAM or GE PowerOn OMS). Tracks assignment date/time, scheduled start and end, actual arrival and departure, travel time, assignment status (dispatched, en-route, on-site, completed, cancelled), and mobile acknowledgment. This is the core operational dispatch record in ClickSoftware WFM linking workforce to work execution.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`shift` (
    `shift_id` BIGINT COMMENT 'Unique identifier for the work shift. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Shift labor costs are charged to cost centers for overtime and premium pay reporting.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Shift staffing reports require the facility where the shift occurs for labor compliance and overtime tracking.',
    `call_out_eligible_flag` BOOLEAN COMMENT 'Indicates whether crew members on this shift are eligible for emergency call-out outside their regular shift hours. True if call-out provisions apply per union agreement, false if shift is exempt from call-out duty.',
    `consecutive_shift_limit` STRING COMMENT 'Maximum number of consecutive shifts of this type that can be worked before mandatory rest period is required. Enforces OSHA fatigue management and union agreement provisions to prevent worker exhaustion and safety incidents.',
    `created_by_user` STRING COMMENT 'User identifier or system account that created this shift record. Used for audit trail and accountability.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this shift record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and data lineage tracking.',
    `crew_size_maximum` STRING COMMENT 'Maximum number of personnel that can be assigned to this shift based on operational capacity, equipment availability, and budget constraints.',
    `crew_size_minimum` STRING COMMENT 'Minimum number of qualified personnel required to staff this shift to meet operational and safety requirements. Based on work type, equipment requirements, and OSHA safety regulations for field operations.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the shift measured in hours, including any built-in break periods. Calculated as the difference between end_time and start_time, accounting for overnight shifts that span midnight. Used for labor hour calculations and OSHA fatigue compliance monitoring.',
    `effective_end_date` DATE COMMENT 'Date when this shift definition expires or is no longer available for scheduling. Null for open-ended shifts. Used to manage seasonal shifts, temporary emergency shifts, and shift pattern changes.',
    `effective_start_date` DATE COMMENT 'Date when this shift definition becomes active and available for crew scheduling. Supports seasonal shift patterns and operational changes.',
    `emergency_response_flag` BOOLEAN COMMENT 'Indicates whether this shift is designated for emergency response and storm restoration work. True for shifts that can be mobilized for outage management system (OMS) dispatch and critical infrastructure protection (CIP) incidents.',
    `end_time` TIMESTAMP COMMENT 'Scheduled end time of the shift in 24-hour HH:mm format (e.g., 15:00, 23:30, 07:00). Represents the time when crew members are expected to complete work. May extend into the next calendar day for overnight shifts.',
    `fatigue_risk_score` STRING COMMENT 'Calculated risk score (0-100) assessing fatigue-related safety risk based on shift duration, time of day, consecutive shifts, and rest periods. Higher scores indicate greater fatigue risk requiring additional monitoring and mitigation measures per OSHA fatigue management guidelines.',
    `geographic_service_area` STRING COMMENT 'Geographic territory or service area covered by this shift (e.g., North Region, Metro District, Coastal Zone). Used for crew dispatch optimization and emergency response coordination.',
    `hazard_level` STRING COMMENT 'Risk classification of the shift based on work activities and safety hazards. Low hazard shifts involve minimal risk (office work), moderate hazard shifts include routine field operations, high hazard shifts involve energized equipment or elevated work, and critical hazard shifts require specialized safety protocols (e.g., high-voltage transmission work, confined space entry).. Valid values are `low|moderate|high|critical`',
    `holiday_work_flag` BOOLEAN COMMENT 'Indicates whether this shift may be scheduled on recognized holidays. True if holiday work is permitted, false if holidays are excluded. Affects premium pay calculations and holiday compensation per union agreements.',
    `minimum_rest_hours` DECIMAL(18,2) COMMENT 'Minimum number of hours of rest required between the end of this shift and the start of the next shift for the same crew member. Ensures compliance with OSHA fatigue management guidelines and union rest period provisions.',
    `modified_by_user` STRING COMMENT 'User identifier or system account that last modified this shift record. Used for audit trail and change management.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this shift record was last updated. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX. Used for audit trail and change tracking.',
    `notes` STRING COMMENT 'Free-text field for additional shift information, special instructions, or operational notes for crew scheduling and dispatch coordination.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether hours worked during this shift are eligible for overtime compensation under applicable labor agreements and regulations. True if overtime rules apply, false if shift is exempt or salaried.',
    `overtime_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours after which overtime compensation begins for this shift type. Typically 8 hours per day or 40 hours per week under FLSA, but may vary based on union agreements and state regulations.',
    `paid_break_minutes` STRING COMMENT 'Total minutes of paid break time included within the shift duration. Paid breaks are compensated time and count toward total hours worked for overtime calculations.',
    `ppe_requirements` STRING COMMENT 'Comma-separated list of required personal protective equipment for this shift (e.g., ARC_FLASH_SUIT, HARD_HAT, SAFETY_GLASSES, INSULATED_GLOVES, FALL_PROTECTION). Ensures compliance with OSHA safety standards and utility safety programs.',
    `premium_pay_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base hourly rate for premium compensation (e.g., 1.5 for time-and-a-half, 2.0 for double-time). Used for night differential, weekend premium, holiday pay, or emergency call-out compensation as defined in union agreements.',
    `qualification_requirement_codes` STRING COMMENT 'Comma-separated list of qualification codes required for personnel assigned to this shift (e.g., LINEWORKER_JOURNEYMAN, CDL_CLASS_A, CONFINED_SPACE_ENTRY, FIRST_AID_CPR). Used to match crew members with appropriate certifications and training to shift requirements.',
    `reporting_location` STRING COMMENT 'Physical location where crew members report at shift start (e.g., Operations Center, Service Yard, Substation). May include address or facility identifier for dispatch and timekeeping purposes.',
    `rotation_cycle_days` STRING COMMENT 'Total number of days in one complete rotation cycle before the pattern repeats. Used for long-term crew scheduling and labor planning.',
    `rotation_pattern` STRING COMMENT 'Description of the rotation schedule for rotating shifts (e.g., 4-on-3-off, 2-2-3 Panama, 5-2 weekly). Defines the repeating pattern of work days and rest days for crew scheduling.',
    `scheduling_priority` STRING COMMENT 'Numeric priority ranking (1-100) used by ClickSoftware WFM to optimize crew assignments. Higher values indicate higher priority for staffing. Emergency and critical infrastructure shifts receive highest priority.',
    `shift_category` STRING COMMENT 'Operational category of the shift indicating the primary work purpose. Regular shifts support standard operations and maintenance (O&M), emergency shifts respond to unplanned outages, storm shifts mobilize for weather-related restoration, maintenance shifts focus on preventive and corrective asset maintenance, construction shifts support transmission and distribution (T&D) infrastructure projects, and inspection shifts perform regulatory compliance and safety inspections.. Valid values are `regular|emergency|storm|maintenance|construction|inspection`',
    `shift_code` STRING COMMENT 'Business identifier code for the shift used in scheduling systems and crew assignments. Typically follows organizational naming conventions (e.g., DAY-A, NIGHT-B, ROT-1).. Valid values are `^[A-Z0-9]{4,12}$`',
    `shift_name` STRING COMMENT 'Human-readable name of the shift for display and reporting purposes (e.g., Day Shift - A Crew, Night Shift - Emergency Response).',
    `shift_status` STRING COMMENT 'Current lifecycle status of the shift definition. Active shifts are available for crew scheduling, inactive shifts are temporarily disabled, suspended shifts are on hold pending review, and archived shifts are retained for historical reference only.. Valid values are `active|inactive|suspended|archived`',
    `shift_type` STRING COMMENT 'Classification of the shift based on time-of-day pattern. Day shifts typically run morning to afternoon, evening shifts cover afternoon to late evening, night shifts cover overnight hours, rotating shifts cycle through multiple patterns, on-call shifts require availability for emergency dispatch, and standby shifts are reserved for contingency staffing.. Valid values are `day|evening|night|rotating|on_call|standby`',
    `start_time` TIMESTAMP COMMENT 'Scheduled start time of the shift in 24-hour HH:mm format (e.g., 07:00, 15:30, 23:00). Represents the time when crew members are expected to begin work.',
    `union_agreement_code` STRING COMMENT 'Code identifying the collective bargaining agreement (CBA) or union contract that governs labor terms for this shift. References specific union local agreements (e.g., IBEW_LOCAL_1245, UWUA_LOCAL_304) that define work rules, compensation, and scheduling provisions.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `unpaid_break_minutes` STRING COMMENT 'Total minutes of unpaid break time (typically meal breaks) within the shift. Unpaid breaks do not count toward compensable hours and are excluded from overtime calculations.',
    `weekend_work_flag` BOOLEAN COMMENT 'Indicates whether this shift regularly includes weekend work (Saturday/Sunday). True if shift pattern includes weekend days, false if Monday-Friday only. Used for premium pay calculations and work-life balance planning.',
    `work_location_type` STRING COMMENT 'Primary location type where shift work is performed. Field shifts involve outdoor transmission and distribution (T&D) work, office shifts are administrative or control center operations, yard shifts are depot or warehouse-based, substation shifts involve electrical substation operations, plant shifts are generation facility operations, mobile shifts have no fixed location, and remote shifts are performed from home or remote offices. [ENUM-REF-CANDIDATE: field|office|yard|substation|plant|mobile|remote — 7 candidates stripped; promote to reference product]',
    `work_order_type_default` STRING COMMENT 'Default work order type code from Maximo Enterprise Asset Management (EAM) for work performed during this shift (e.g., PM for preventive maintenance, CM for corrective maintenance, EM for emergency, PROJ for capital projects). Used to pre-populate work order creation and labor tracking.',
    CONSTRAINT pk_shift PRIMARY KEY(`shift_id`)
) COMMENT 'Defines scheduled work shifts for field workforce including shift type (day, evening, night, rotating), shift start and end times, shift duration, overtime eligibility, and applicable union agreement provisions. Shifts are the building blocks of crew scheduling and are used to calculate labor hours, overtime costs, and OSHA fatigue compliance for T&D field operations.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`schedule` (
    `schedule_id` BIGINT COMMENT 'Unique identifier for the workforce schedule record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Schedules are budgeted to cost centers; the link supports schedule cost roll‑up and financial planning.',
    `crew_id` BIGINT COMMENT 'Reference to the crew assigned to this schedule. Nullable if schedule is for an individual technician rather than a crew.',
    `employee_id` BIGINT COMMENT 'User ID of the workforce planner or system user who created this schedule record.. Valid values are `^[A-Z0-9]{6,20}$`',
    `facility_id` BIGINT COMMENT 'Reference to the primary work location or service center where the technician reports for this schedule.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Schedules tied to internal orders allow project‑level cost tracking and compliance with capital project accounting.',
    `modified_by_user_employee_id` BIGINT COMMENT 'User ID of the workforce planner or system user who last modified this schedule record.. Valid values are `^[A-Z0-9]{6,20}$`',
    `resource_id` BIGINT COMMENT 'Foreign key linking to der.der_resource. Business justification: Maintenance and inspection schedules are created per DER asset; linking enables automated schedule generation and reporting.',
    `service_territory_id` BIGINT COMMENT 'Reference to the geographic service territory covered by this schedule. Used for T&D operations and outage response planning.',
    `technician_id` BIGINT COMMENT 'Reference to the technician or field worker assigned to this schedule.',
    `vehicle_id` BIGINT COMMENT 'Foreign key linking to workforce.vehicle. Business justification: Schedule may assign a vehicle for the shift; linking to vehicle provides full vehicle details and removes redundant code column.',
    `work_order_assignment_id` BIGINT COMMENT 'Reference to the planned work assignment or work order associated with this schedule. Nullable for general availability schedules.',
    `break_duration_minutes` STRING COMMENT 'Total scheduled break time in minutes (lunch, rest breaks). Required for labor law compliance and union contract adherence.',
    `certification_required` STRING COMMENT 'Specific certifications or licenses required for this schedule (e.g., CDL Class A, NERC CIP training, confined space entry). Pipe-separated list if multiple.',
    `confirmed_timestamp` TIMESTAMP COMMENT 'Timestamp when the technician acknowledged and confirmed the schedule. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `consecutive_days_worked` STRING COMMENT 'Number of consecutive days the technician is scheduled to work without a rest day. Used for union contract compliance (maximum consecutive days rules).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule record was first created in the system. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `end_date` DATE COMMENT 'The date when this schedule period ends. Format: yyyy-MM-dd.',
    `mobile_device_code` STRING COMMENT 'Identifier of the mobile device (tablet, smartphone) assigned to the technician for field data collection and work order updates.. Valid values are `^[A-Z0-9-]{10,20}$`',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this schedule record was last modified. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `mutual_assistance_flag` BOOLEAN COMMENT 'Indicates whether this schedule involves mutual assistance deployment to another utility service territory during emergency response.',
    `notes` STRING COMMENT 'Free-text notes or special instructions for the schedule (e.g., safety requirements, equipment needs, coordination instructions).',
    `on_call_flag` BOOLEAN COMMENT 'Indicates whether this schedule includes on-call duty for emergency response. True if technician is on standby for outage or emergency dispatch.',
    `optimization_score` DECIMAL(18,2) COMMENT 'Score generated by ClickSoftware WFM optimization engine indicating schedule quality (0-100). Higher scores indicate better resource utilization and constraint satisfaction.',
    `overtime_eligible_flag` BOOLEAN COMMENT 'Indicates whether hours worked under this schedule are eligible for overtime compensation per union agreement or FLSA rules.',
    `planning_horizon` STRING COMMENT 'Time period covered by this schedule (daily shift, weekly rotation, monthly assignment, or quarterly plan).. Valid values are `daily|weekly|monthly|quarterly`',
    `published_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule was published and communicated to the technician. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `rest_period_hours` DECIMAL(18,2) COMMENT 'Minimum rest period in hours between shifts. Required for OSHA safety compliance and union contract adherence.',
    `schedule_number` STRING COMMENT 'Business identifier for the schedule, typically generated by ClickSoftware WFM system. Format: SCH-YYYYMMDD.. Valid values are `^SCH-[0-9]{8}$`',
    `schedule_status` STRING COMMENT 'Current lifecycle status of the schedule. Draft schedules are being planned, published schedules are communicated to workers, confirmed schedules are acknowledged by workers.. Valid values are `draft|published|confirmed|in_progress|completed|cancelled`',
    `schedule_type` STRING COMMENT 'Classification of the schedule type indicating the nature of the work period.. Valid values are `regular|on_call|emergency|storm_response|planned_outage|training`',
    `shift_duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the scheduled shift in hours, including breaks. Used for labor capacity planning and union contract compliance.',
    `shift_end_time` TIMESTAMP COMMENT 'Timestamp when the scheduled shift ends. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `shift_pattern_code` STRING COMMENT 'Code representing the shift rotation pattern (e.g., 4x10, 5x8, 12HR-ROTATING). Used for union contract compliance and workforce planning.. Valid values are `^[A-Z0-9]{2,10}$`',
    `shift_start_time` TIMESTAMP COMMENT 'Timestamp when the scheduled shift begins. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX.',
    `skill_requirement_code` STRING COMMENT 'Primary skill or certification required for this schedule (e.g., LINEWORKER_JOURNEYMAN, METER_TECH_L2, SUBSTATION_OPERATOR). Used for qualification matching.. Valid values are `^[A-Z0-9_]{2,20}$`',
    `source_system_code` STRING COMMENT 'Code identifying the system of record that created this schedule (ClickSoftware WFM, SAP HR, Maximo, or manual entry).. Valid values are `CLICKSOFTWARE|SAP_HR|MAXIMO|MANUAL`',
    `start_date` DATE COMMENT 'The date when this schedule period begins. Format: yyyy-MM-dd.',
    `storm_response_flag` BOOLEAN COMMENT 'Indicates whether this schedule is part of emergency storm response staffing. True during major outage events requiring extended crew deployment.',
    `travel_time_minutes` STRING COMMENT 'Estimated travel time in minutes from work location to service territory or first job site. Used for schedule optimization and capacity planning.',
    `union_code` STRING COMMENT 'Code identifying the labor union governing this schedule. Used for contract compliance validation (work rules, overtime, rest periods).. Valid values are `^[A-Z0-9]{2,10}$`',
    `wbs_element` STRING COMMENT 'SAP WBS element for capital project work. Used for CAPEX labor tracking on T&D construction and infrastructure projects.. Valid values are `^[A-Z0-9.-]{6,24}$`',
    CONSTRAINT pk_schedule PRIMARY KEY(`schedule_id`)
) COMMENT 'Planned work schedule for a technician or crew over a defined planning horizon (daily, weekly, or monthly). Captures scheduled shifts, days on/off, planned assignments, territory coverage, and schedule status (draft, published, confirmed). Generated by ClickSoftware WFM optimization engine and used for resource capacity planning, outage response readiness, and union contract compliance (minimum rest periods, consecutive days worked).';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`time_entry` (
    `time_entry_id` BIGINT COMMENT 'Unique identifier for the time entry record. Primary key.',
    `approving_user_employee_id` BIGINT COMMENT 'Identifier of the user (supervisor or timekeeper) who approved the time entry.',
    `cost_center_id` BIGINT COMMENT 'Cost center to which labor hours are charged for financial accounting and cost allocation.',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor who authorized or approved the overtime hours.',
    `internal_order_id` BIGINT COMMENT 'Internal order number for tracking costs against specific operational or maintenance activities.',
    `technician_id` BIGINT COMMENT 'Identifier of the technician or field worker who performed the work. Links to workforce personnel master data.',
    `resource_id` BIGINT COMMENT 'Foreign key linking to der.der_resource. Business justification: Labor tracking for DER maintenance tasks requires associating time entries with the specific DER asset worked on.',
    `storm_event_id` BIGINT COMMENT 'Identifier of the storm event or major outage event for which this time was recorded, enabling storm cost tracking and regulatory reporting.',
    `tertiary_time_approving_user_technician_id` BIGINT COMMENT 'Identifier of the user (supervisor or timekeeper) who approved the time entry.',
    `wbs_element_id` BIGINT COMMENT 'WBS element for project-based work, enabling CAPEX/OPEX labor cost classification and project tracking.',
    `work_order_id` BIGINT COMMENT 'Identifier of the work order for which time was recorded. Links to work order management system.',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry was approved by the supervisor or timekeeper.',
    `authorization_timestamp` TIMESTAMP COMMENT 'Date and time when overtime authorization was granted by the supervisor.',
    `comments` STRING COMMENT 'Free-text comments or notes entered by the technician or supervisor providing additional context about the work performed or time recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was first created in the system.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of double-time hours worked, typically for holidays, emergency call-outs, or extended overtime per union agreement.',
    `emergency_response_flag` BOOLEAN COMMENT 'Indicates whether the time entry is associated with emergency response work such as storm restoration, outage repair, or critical infrastructure protection.',
    `estimated_hours` DECIMAL(18,2) COMMENT 'Estimated hours submitted during overtime pre-authorization request, used for variance analysis against actual hours.',
    `ferc_account_code` STRING COMMENT 'FERC uniform system of accounts code for regulatory financial reporting and rate case preparation.. Valid values are `^[0-9]{3,6}$`',
    `geographic_location_code` STRING COMMENT 'Code identifying the geographic location or service territory where the work was performed, used for regional cost allocation.. Valid values are `^[A-Z0-9]{3,10}$`',
    `gps_latitude` DECIMAL(18,2) COMMENT 'GPS latitude coordinate where the time entry was captured, used for field workforce location verification and audit.',
    `gps_longitude` DECIMAL(18,2) COMMENT 'GPS longitude coordinate where the time entry was captured, used for field workforce location verification and audit.',
    `labor_cost_classification` STRING COMMENT 'Classification of labor cost as CAPEX (capital expenditure for new construction), OPEX (operating expenditure for maintenance), or specific categories like emergency or storm response.. Valid values are `capex|opex|maintenance|construction|emergency|storm`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry record was last updated or modified.',
    `mobile_capture_flag` BOOLEAN COMMENT 'Indicates whether the time entry was captured via mobile device in the field using ClickSoftware mobile workforce application.',
    `on_call_hours` DECIMAL(18,2) COMMENT 'Number of hours in on-call status, available for emergency dispatch with on-call premium pay per union agreement.',
    `overtime_authorization_required` BOOLEAN COMMENT 'Indicates whether pre-authorization was required for overtime hours per company policy or union agreement.',
    `overtime_authorization_status` STRING COMMENT 'Status of overtime pre-authorization: not required, pending approval, approved, denied, or retroactively authorized.. Valid values are `not_required|pending|approved|denied|retroactive`',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of overtime hours worked beyond regular shift hours, subject to premium pay rates per union agreement or labor law.',
    `pay_code` STRING COMMENT 'Payroll code indicating the type of time and applicable pay rate (e.g., REG for regular, OT for overtime, DT for double-time, TRV for travel).. Valid values are `^[A-Z0-9]{2,6}$`',
    `payroll_period` STRING COMMENT 'Payroll period identifier (e.g., 2024-03-W2 for week 2 of March 2024) to which this time entry belongs for wage calculation.. Valid values are `^[0-9]{4}-(0[1-9]|1[0-2])-(W[1-5]|P[0-9]{2})$`',
    `payroll_posting_date` DATE COMMENT 'Date when the time entry was posted to payroll for wage calculation and payment processing.',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of regular work hours recorded, typically within standard shift hours per union agreement or employment contract.',
    `shift_end_time` TIMESTAMP COMMENT 'Timestamp when the technician completed their shift or work assignment for the day.',
    `shift_start_time` TIMESTAMP COMMENT 'Timestamp when the technician began their shift or work assignment for the day.',
    `source_system` STRING COMMENT 'System of record from which the time entry originated: ClickSoftware WFM, SAP HR, Maximo EAM, or manual entry.. Valid values are `clicksoftware|sap_hr|maximo|manual`',
    `source_system_code` STRING COMMENT 'Unique identifier of the time entry in the source system, used for data lineage and reconciliation.',
    `standby_hours` DECIMAL(18,2) COMMENT 'Number of hours on standby or ready-to-respond status, typically for emergency response crews with standby pay provisions.',
    `submission_timestamp` TIMESTAMP COMMENT 'Date and time when the time entry was submitted for approval by the technician or timekeeper.',
    `time_entry_number` STRING COMMENT 'Human-readable business identifier for the time entry, typically system-generated for reference and audit purposes.. Valid values are `^TE-[0-9]{10}$`',
    `time_entry_status` STRING COMMENT 'Current lifecycle status of the time entry: draft (not submitted), submitted (pending approval), approved, rejected, posted (to payroll), or cancelled.. Valid values are `draft|submitted|approved|rejected|posted|cancelled`',
    `time_type` STRING COMMENT 'Classification of time entry as productive (direct work), non-productive (downtime), indirect (support), administrative, or training.. Valid values are `productive|non_productive|indirect|administrative|training`',
    `total_hours` DECIMAL(18,2) COMMENT 'Total hours recorded across all time categories (regular, overtime, double-time, travel, standby, on-call) for the time entry.',
    `travel_hours` DECIMAL(18,2) COMMENT 'Number of hours spent traveling to and from work sites, compensable per union agreement or company policy.',
    `union_agreement_code` STRING COMMENT 'Code identifying the applicable collective bargaining agreement governing overtime provisions, pay rates, and work rules for this time entry.. Valid values are `^[A-Z0-9]{2,10}$`',
    `work_activity_code` STRING COMMENT 'Code identifying the specific type of work activity performed (e.g., line repair, meter installation, vegetation management, substation maintenance).. Valid values are `^[A-Z0-9]{3,10}$`',
    `work_date` DATE COMMENT 'The calendar date on which the work was performed. Used for payroll period determination and labor cost allocation.',
    CONSTRAINT pk_time_entry PRIMARY KEY(`time_entry_id`)
) COMMENT 'Transactional record of actual hours worked by a technician for a given date, work order, or cost object. Captures regular, overtime, double-time, travel, standby, and on-call hours with applicable pay code and cost center. Includes overtime pre-authorization tracking (requesting supervisor, authorization type, estimated vs actual hours). Supports CAPEX/OPEX labor cost classification via WBS element, union agreement overtime provisions, and FERC account coding. Sourced from ClickSoftware mobile time capture and integrated into SAP HR/Payroll.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`qualification` (
    `qualification_id` BIGINT COMMENT 'Unique identifier for the workforce qualification record. Primary key.',
    `superseded_by_qualification_id` BIGINT COMMENT 'Reference to the qualification_id that supersedes this qualification if it has been replaced by a newer version or updated standard. Null if not superseded.',
    `cost_per_worker_usd` DECIMAL(18,2) COMMENT 'Standard cost in US dollars to obtain or renew this qualification per worker, including training fees, examination fees, and certification fees. Used for workforce development budgeting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the system. Used for audit trail and data lineage.',
    `effective_date` DATE COMMENT 'Date when this qualification definition became effective and available for assignment to workers in the workforce management system.',
    `end_date` DATE COMMENT 'Date when this qualification definition was retired or superseded. Null if currently active. Used to maintain historical qualification definitions for audit and reporting.',
    `examination_required_flag` BOOLEAN COMMENT 'Indicates whether an examination or assessment is required to obtain this qualification (True) or if completion of training alone is sufficient (False).',
    `external_training_provider` STRING COMMENT 'Name of the primary external training provider or vendor if internal training is not available. Null if training is provided internally.',
    `internal_training_available_flag` BOOLEAN COMMENT 'Indicates whether the utility offers internal training programs for this qualification (True) or if workers must obtain it through external providers (False).',
    `issuing_authority` STRING COMMENT 'Name of the organization, agency, or body that issues or certifies this qualification (e.g., State Department of Motor Vehicles, OSHA, NFPA, PHMSA, internal utility training department).',
    `issuing_authority_type` STRING COMMENT 'Classification of the issuing authority: government agency (OSHA, DMV), industry association (NFPA, IEEE), internal utility training program, third-party certification body, or professional organization.. Valid values are `government|industry_association|internal|third_party_certifier|professional_body`',
    `job_role_applicability` STRING COMMENT 'Comma-separated list of job roles or positions for which this qualification is applicable or required (e.g., Lineworker, Substation Technician, Gas Service Technician, Meter Reader, Crew Chief).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last updated. Used for audit trail and change tracking.',
    `minimum_experience_months` STRING COMMENT 'Minimum months of relevant work experience required before a worker can pursue this qualification. Null if no experience requirement.',
    `nerc_cip_required_flag` BOOLEAN COMMENT 'Indicates whether this qualification is required under North American Electric Reliability Corporation Critical Infrastructure Protection standards for personnel with access to Bulk Electric System cyber or physical assets.',
    `notes` STRING COMMENT 'Additional notes, special instructions, or contextual information about this qualification that does not fit in other structured fields.',
    `practical_demonstration_required_flag` BOOLEAN COMMENT 'Indicates whether a hands-on practical demonstration or field evaluation is required to obtain this qualification (True) or not (False).',
    `prerequisite_qualifications` STRING COMMENT 'Comma-separated list of qualification codes that are prerequisites for obtaining this qualification. Null if no prerequisites exist.',
    `qualification_category` STRING COMMENT 'Broad functional category grouping qualifications by purpose: safety (OSHA, Arc Flash), technical (CDL, equipment operation), operational (switching authorization), regulatory (gas operator qualification), leadership (crew chief), or specialized (confined space entry).. Valid values are `safety|technical|operational|regulatory|leadership|specialized`',
    `qualification_code` STRING COMMENT 'Unique business identifier code for the qualification (e.g., CDL-A, OSHA-30, NFPA70E). Used for external reference and system integration.. Valid values are `^[A-Z0-9]{4,20}$`',
    `qualification_description` STRING COMMENT 'Detailed description of the qualification including scope, purpose, and what competencies or knowledge it represents.',
    `qualification_name` STRING COMMENT 'Full descriptive name of the qualification (e.g., Commercial Driver License Class A, OSHA 30-Hour Construction Safety, NFPA 70E Arc Flash Safety Training).',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the qualification in the catalog. Active qualifications are available for assignment and tracking; inactive or retired qualifications are no longer issued but may be maintained for historical worker records.. Valid values are `active|inactive|retired|under_review|pending_approval|suspended`',
    `qualification_type` STRING COMMENT 'Category of qualification distinguishing licenses, certifications, training completions, competency assessments, authorizations, and permits.. Valid values are `license|certification|training|competency|authorization|permit`',
    `regulatory_authority` STRING COMMENT 'Name of the regulatory body that mandates this qualification if regulatory_mandate_flag is True (e.g., OSHA, PHMSA, NERC, State Public Utility Commission). Null if not regulatory-mandated.',
    `regulatory_citation` STRING COMMENT 'Specific regulation, code section, or standard citation that mandates this qualification (e.g., 29 CFR 1910.269, 49 CFR Part 192 Subpart N, NERC CIP-004). Null if not regulatory-mandated.',
    `regulatory_mandate_flag` BOOLEAN COMMENT 'Indicates whether this qualification is mandated by federal, state, or local regulation (True) or is voluntary/internal best practice (False). Regulatory-mandated qualifications have compliance implications.',
    `renewal_method` STRING COMMENT 'Method by which the qualification must be renewed: retraining course, examination, continuing education credits, practical demonstration, administrative review, or not applicable if no renewal required.. Valid values are `retraining|examination|continuing_education|demonstration|administrative_review|not_applicable`',
    `renewal_required_flag` BOOLEAN COMMENT 'Indicates whether this qualification requires periodic renewal (True) or is valid indefinitely once obtained (False).',
    `safety_critical_flag` BOOLEAN COMMENT 'Indicates whether this qualification is designated as safety-critical (True), meaning its absence creates immediate safety risk to workers or the public. Used for compliance monitoring and workforce planning.',
    `training_duration_hours` DECIMAL(18,2) COMMENT 'Standard duration in hours of the training or course required to obtain this qualification. Null if not applicable (e.g., for licenses obtained through examination without formal training).',
    `union_agreement_reference` STRING COMMENT 'Reference to the collective bargaining agreement or union contract section that governs this qualification if applicable. Null if not covered by union agreement.',
    `validity_period_months` STRING COMMENT 'Standard validity period for this qualification in months from date of issuance. Null if the qualification does not expire (e.g., some licenses are perpetual until revoked).',
    `version_number` STRING COMMENT 'Version identifier for this qualification definition (e.g., 1.0, 2.1). Used when qualification requirements or standards are updated over time.. Valid values are `^[0-9]{1,3}(.[0-9]{1,3}){0,2}$`',
    `work_type_applicability` STRING COMMENT 'Comma-separated list of work types or activities for which this qualification is required (e.g., Overhead Line Construction, Underground Cable Splicing, Substation Switching, Gas Main Repair, Confined Space Entry, Energized Work).',
    CONSTRAINT pk_qualification PRIMARY KEY(`qualification_id`)
) COMMENT 'Master catalog of workforce qualifications, certifications, and competencies required for field utility work. Includes qualification type (CDL Class A, OSHA 10/30, NFPA 70E Arc Flash, Gas Operator Qualification, Substation Switching Authorization, Lineworker Journeyman Certificate), issuing authority, validity period, renewal requirements, and regulatory mandate (OSHA, PHMSA, NERC CIP). This is the reference catalog — not the individual workers attainment record.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` (
    `technician_qualification_id` BIGINT COMMENT 'Unique identifier for the technician qualification record. Primary key.',
    `technician_id` BIGINT COMMENT 'Identifier of the technician who holds this qualification. Links to the technician master record in workforce management systems.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: External vendors issue many certifications; tracking issuing vendor is needed for safety audits, regulatory reporting, and cost allocation.',
    `assessment_score` DECIMAL(18,2) COMMENT 'Numeric score or percentage achieved on the qualification assessment or examination. Null if no scored assessment was required.',
    `certificate_number` STRING COMMENT 'Unique certificate or credential number assigned by the certifying body. Used for verification and audit purposes.',
    `certifying_body` STRING COMMENT 'Name of the organization, agency, or institution that issued the qualification (e.g., OSHA, NERC, PHMSA, state licensing board, equipment manufacturer, internal training department).',
    `compliance_status` STRING COMMENT 'Current compliance state of the qualification indicating whether the technician is authorized to perform associated work. Expiring_soon triggers alerts; expired/suspended/revoked blocks dispatch assignment.. Valid values are `current|expiring_soon|expired|suspended|revoked|pending_verification`',
    `continuing_education_credits` DECIMAL(18,2) COMMENT 'Number of continuing education units (CEUs) or professional development hours earned through this qualification. Used for license maintenance and career development tracking.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Total cost incurred to obtain or renew this qualification, including training fees, examination fees, certification fees, and travel expenses. Used for workforce development budget tracking.',
    `cost_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the qualification cost. Defaults to USD for domestic operations.. Valid values are `USD`',
    `dispatch_eligibility_flag` BOOLEAN COMMENT 'Indicates whether this qualification enables the technician to be dispatched for specific work order types in ClickSoftware. True if qualification is used for skill-based dispatch matching.',
    `documentation_url` STRING COMMENT 'URL or file path to the digital copy of the qualification certificate, training completion record, or supporting documentation stored in the document management system.',
    `effective_date` DATE COMMENT 'Date from which the qualification becomes valid and the technician is authorized to perform associated work activities.',
    `equipment_authorization` STRING COMMENT 'Description of specialized equipment, tools, or vehicles the technician is authorized to operate based on this qualification (e.g., bucket truck, directional drill, live-line tools).',
    `expiration_date` DATE COMMENT 'Date on which the qualification expires and must be renewed. Null for qualifications with no expiration. Triggers renewal alerts in workforce management systems.',
    `funding_source` STRING COMMENT 'Entity that funded the qualification training and certification costs (company-paid, employee self-funded, government/industry grant, union training fund, vendor-sponsored).. Valid values are `company|employee|grant|union|vendor`',
    `instructor_name` STRING COMMENT 'Name of the primary instructor or trainer who delivered the qualification training. Used for training quality assessment and instructor evaluation.',
    `is_active` BOOLEAN COMMENT 'Indicates whether this qualification record is currently active and should be considered for dispatch eligibility and compliance reporting. False for historical or superseded records.',
    `issue_date` DATE COMMENT 'Date on which the qualification or certification was originally issued or awarded to the technician.',
    `last_renewal_date` DATE COMMENT 'Most recent date on which the qualification was renewed or recertified. Null if never renewed since original issue.',
    `next_renewal_due_date` DATE COMMENT 'Scheduled date by which the qualification must be renewed to maintain compliance. Used to trigger proactive renewal workflows and alerts.',
    `notes` STRING COMMENT 'Free-text field for additional information, special conditions, restrictions, or comments related to this qualification record.',
    `passing_score_threshold` DECIMAL(18,2) COMMENT 'Minimum score required to pass the qualification assessment. Used to validate qualification attainment.',
    `proficiency_level` STRING COMMENT 'Assessed skill level or proficiency tier for this qualification, used for work assignment complexity matching and career development planning.. Valid values are `basic|intermediate|advanced|expert|master`',
    `qualification_category` STRING COMMENT 'Broad functional category grouping qualifications by domain: safety (OSHA), technical (electrical/gas systems), regulatory (NERC CIP, PHMSA OQ), operational (SCADA, DMS), leadership, or specialized equipment operation.. Valid values are `safety|technical|regulatory|operational|leadership|specialized_equipment`',
    `qualification_code` STRING COMMENT 'Standardized code identifying the specific qualification, certification, or training credential. Used for skill-based dispatch matching in ClickSoftware.',
    `qualification_name` STRING COMMENT 'Full descriptive name of the qualification or certification (e.g., OSHA 10-Hour Construction Safety, NERC CIP Cyber Security Training, PHMSA Operator Qualification for Gas Distribution).',
    `qualification_type` STRING COMMENT 'Category of the qualification distinguishing certifications, licenses, training completions, operator qualifications, safety credentials, and technical skills.. Valid values are `certification|license|training|operator_qualification|safety_credential|technical_skill`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was first created in the lakehouse silver layer. Audit field for data lineage.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this qualification record was last updated in the lakehouse silver layer. Audit field for change tracking.',
    `regulatory_requirement_flag` BOOLEAN COMMENT 'Indicates whether this qualification is mandated by federal, state, or industry regulatory bodies (OSHA, NERC CIP, PHMSA OQ, PUC requirements). True for mandatory qualifications.',
    `renewal_notification_date` DATE COMMENT 'Date on which the renewal reminder notification was sent. Null if no notification has been sent.',
    `renewal_notification_sent_flag` BOOLEAN COMMENT 'Indicates whether a renewal reminder notification has been sent to the technician and their supervisor. True once notification is dispatched.',
    `source_system` STRING COMMENT 'Name of the operational system from which this qualification record originated (ClickSoftware WFM, SAP HR, internal training management system).',
    `source_system_code` STRING COMMENT 'Unique identifier of this qualification record in the source operational system. Used for data reconciliation and traceability.',
    `training_completion_date` DATE COMMENT 'Date on which the technician completed the required training or assessment for this qualification. May precede the issue date.',
    `training_hours` DECIMAL(18,2) COMMENT 'Total number of training hours completed to earn this qualification. Used for continuing education tracking and regulatory reporting.',
    `training_location` STRING COMMENT 'Physical or virtual location where the qualification training was conducted (facility name, city, or online platform).',
    `training_provider` STRING COMMENT 'Name of the organization or vendor that delivered the training or assessment leading to this qualification (may differ from certifying body).',
    `union_requirement_flag` BOOLEAN COMMENT 'Indicates whether this qualification is required by collective bargaining agreement or union contract provisions. True for union-mandated qualifications.',
    `verification_date` DATE COMMENT 'Date on which the qualification credentials were last verified by HR, safety, or compliance personnel. Used for audit trail and compliance documentation.',
    `verified_by` STRING COMMENT 'Name or identifier of the person or system that verified the authenticity and validity of this qualification record.',
    `work_type_authorization` STRING COMMENT 'Comma-separated list or description of work order types, task categories, or job classifications that this qualification authorizes the technician to perform (e.g., high-voltage switching, gas main repair, confined space entry).',
    CONSTRAINT pk_technician_qualification PRIMARY KEY(`technician_qualification_id`)
) COMMENT 'Tracks each technicians attainment, expiration, and renewal status for every required qualification or certification. Captures issue date, expiration date, certifying body, certificate number, training provider, and compliance status. Supports OSHA safety training compliance, PHMSA Operator Qualification (OQ) program for gas workers, NERC CIP personnel training requirements, and ClickSoftware skill-based dispatch matching. Triggers renewal alerts before expiration.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` (
    `union_agreement_id` BIGINT COMMENT 'Unique identifier for the collective bargaining agreement (CBA) record. Primary key.',
    `agreement_name` STRING COMMENT 'Full legal name of the collective bargaining agreement, typically including union name and jurisdiction.',
    `agreement_number` STRING COMMENT 'Externally-known unique identifier for the collective bargaining agreement, typically formatted as CBA- followed by alphanumeric code.. Valid values are `^CBA-[A-Z0-9]{6,12}$`',
    `agreement_type` STRING COMMENT 'Classification of the collective bargaining agreement by scope and purpose: master (company-wide), local (facility-specific), supplemental (addendum to master), project (specific construction project), or interim (temporary).. Valid values are `master|local|supplemental|project|interim`',
    `arbitration_provision_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes binding arbitration as the final step in grievance resolution. True if arbitration is included, False otherwise.',
    `bargaining_unit` STRING COMMENT 'Description of the employee group covered by this agreement, such as field technicians, lineworkers, meter readers, or substation operators.',
    `base_wage_increase_pct` DECIMAL(18,2) COMMENT 'Percentage increase in base wages negotiated in this agreement, expressed as a decimal (e.g., 3.50 for 3.5% increase).',
    `callout_minimum_hours` DECIMAL(18,2) COMMENT 'Minimum number of hours guaranteed for pay when an employee is called out for emergency or unscheduled work, regardless of actual hours worked.',
    `callout_response_time_minutes` STRING COMMENT 'Maximum number of minutes within which an employee must respond to a call-out notification, as specified in the agreement.',
    `covered_employee_count` STRING COMMENT 'Number of employees covered under this collective bargaining agreement at the time of ratification or most recent count.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this union agreement record was first created in the system.',
    `document_reference_url` STRING COMMENT 'URL or file path to the full legal text of the collective bargaining agreement document stored in the document management system.',
    `dues_checkoff_flag` BOOLEAN COMMENT 'Indicates whether the employer agrees to deduct union dues from employee paychecks and remit to the union. True if dues checkoff is authorized, False otherwise.',
    `effective_date` DATE COMMENT 'Date when the collective bargaining agreement becomes binding and enforceable.',
    `expiration_date` DATE COMMENT 'Date when the collective bargaining agreement terminates or requires renegotiation. Nullable for open-ended agreements.',
    `grievance_procedure_steps` STRING COMMENT 'Detailed description of the formal grievance resolution process defined in the agreement, including escalation steps, timelines, and arbitration provisions.',
    `health_benefits_summary` STRING COMMENT 'Summary of health insurance, medical benefits, and wellness programs provided under this agreement, including employer contribution levels and coverage tiers.',
    `jurisdiction_description` STRING COMMENT 'Geographic or operational scope defining where this agreement applies, such as specific service territories, facilities, or operational divisions.',
    `layoff_recall_provisions` STRING COMMENT 'Detailed provisions governing workforce reductions, layoff procedures, bumping rights, and recall procedures based on seniority and qualifications.',
    `management_rights_clause` STRING COMMENT 'Statement of rights reserved to management that are not subject to collective bargaining, such as operational decisions, technology adoption, and business strategy.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the system user who last modified this union agreement record.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this union agreement record was last modified or updated in the system.',
    `negotiating_team_lead` STRING COMMENT 'Name of the primary management representative who led negotiations for this agreement.',
    `negotiation_end_date` DATE COMMENT 'Date when formal negotiations concluded with agreement reached or impasse declared.',
    `negotiation_start_date` DATE COMMENT 'Date when formal negotiations for this agreement began between management and union representatives.',
    `no_strike_clause_flag` BOOLEAN COMMENT 'Indicates whether the agreement includes a no-strike provision prohibiting work stoppages during the term of the agreement. True if no-strike clause exists, False otherwise.',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Multiplier applied to base wage for overtime hours, typically 1.5 for time-and-a-half or 2.0 for double-time.',
    `overtime_threshold_hours` DECIMAL(18,2) COMMENT 'Number of hours worked in a period (daily or weekly) after which overtime rates apply, typically 8 hours per day or 40 hours per week.',
    `pension_contribution_pct` DECIMAL(18,2) COMMENT 'Percentage of wages contributed by employer to pension or retirement plan on behalf of covered employees, as specified in the agreement.',
    `ratification_date` DATE COMMENT 'Date when union membership voted to approve and ratify the collective bargaining agreement.',
    `safety_training_requirements` STRING COMMENT 'Mandatory safety training and certification requirements specified in the agreement for covered employees, aligned with OSHA and NERC standards.',
    `seniority_rules` STRING COMMENT 'Description of how seniority is calculated, applied, and used for purposes such as shift bidding, layoff order, recall rights, and vacation scheduling.',
    `shift_differential_pct` DECIMAL(18,2) COMMENT 'Percentage premium added to base wage for non-standard shifts such as evening, night, or weekend shifts.',
    `sick_leave_accrual_rate` DECIMAL(18,2) COMMENT 'Rate at which sick leave accrues for covered employees, typically expressed as hours per pay period or days per year.',
    `storm_pay_multiplier` DECIMAL(18,2) COMMENT 'Premium pay multiplier applied during declared storm or emergency restoration events, typically higher than standard overtime rates.',
    `storm_pay_trigger_conditions` STRING COMMENT 'Specific conditions or criteria that must be met to activate storm pay provisions, such as declaration of emergency by management or threshold of outages.',
    `subcontracting_restrictions` STRING COMMENT 'Limitations or conditions on the companys ability to subcontract work normally performed by bargaining unit members, including notification and consultation requirements.',
    `union_agreement_status` STRING COMMENT 'Current lifecycle state of the collective bargaining agreement: draft (being prepared), active (in force), expired (past end date), terminated (ended early), under_negotiation (being renegotiated), or ratified (approved but not yet effective).. Valid values are `draft|active|expired|terminated|under_negotiation|ratified`',
    `union_local_number` STRING COMMENT 'Local chapter or lodge number of the union, identifying the specific regional or facility-based union organization.',
    `union_name` STRING COMMENT 'Full name of the labor union or trade organization party to this agreement, such as International Brotherhood of Electrical Workers (IBEW).',
    `union_representative_name` STRING COMMENT 'Name of the primary union representative or business agent who led negotiations on behalf of the union.',
    `union_security_clause` STRING COMMENT 'Type of union membership or dues requirement for employees in the bargaining unit: open_shop (voluntary), union_shop (must join), agency_shop (must pay fees), closed_shop (must be member before hire), or right_to_work (no requirement).. Valid values are `open_shop|union_shop|agency_shop|closed_shop|right_to_work`',
    `vacation_accrual_rate` DECIMAL(18,2) COMMENT 'Rate at which vacation time accrues for covered employees, typically expressed as hours per pay period or days per year based on seniority.',
    `wage_scale_structure` STRING COMMENT 'Description of the wage classification system and pay scales defined in the agreement, including job classifications, step progressions, and rate tables.',
    `work_rules_summary` STRING COMMENT 'Summary of key work rules and operational provisions defined in the agreement, including jurisdictional boundaries, crew composition requirements, and work assignment protocols.',
    CONSTRAINT pk_union_agreement PRIMARY KEY(`union_agreement_id`)
) COMMENT 'Master record for collective bargaining agreements (CBAs) governing unionized field workforce including IBEW (International Brotherhood of Electrical Workers) and other trade union contracts. Captures agreement name, union local number, effective and expiration dates, wage scales by classification, overtime rules, call-out provisions, storm pay provisions, grievance procedures, and jurisdictional work rules. Drives labor cost calculations and scheduling constraint enforcement.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` (
    `labor_rate_id` BIGINT COMMENT 'Unique identifier for the labor rate record. Primary key.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Costing models use facility‑specific labor rates to calculate project estimates and regulatory cost reporting.',
    `union_agreement_id` BIGINT COMMENT 'FK to workforce.union_agreement',
    `burden_percentage` DECIMAL(18,2) COMMENT 'Percentage markup applied to direct labor rate to account for benefits, payroll taxes, insurance, and other overhead costs. Used for fully-loaded labor cost calculations in work order costing and rate case filings.',
    `capex_opex_indicator` STRING COMMENT 'Indicates whether labor costs for this craft are typically capitalized (CAPEX), expensed (OPEX), or split between both. Drives accounting treatment in work order settlement.. Valid values are `CAPEX|OPEX|both`',
    `cost_center_default` STRING COMMENT 'Default SAP cost center for charging labor costs associated with this craft classification. Used for work order cost allocation and financial reporting.. Valid values are `^[A-Z0-9]{6,12}$`',
    `craft_classification_code` STRING COMMENT 'Standardized code identifying the craft or trade classification (e.g., lineworker, electrician, meter technician, substation operator). Aligns with union job classifications and SAP HR organizational assignment codes.. Valid values are `^[A-Z0-9]{4,12}$`',
    `craft_classification_name` STRING COMMENT 'Full descriptive name of the craft or trade classification (e.g., Journeyman Lineworker, Senior Substation Electrician, Advanced Meter Technician).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this labor rate record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary rates (typically USD for U.S. utilities).. Valid values are `^[A-Z]{3}$`',
    `double_time_rate` DECIMAL(18,2) COMMENT 'Hourly labor rate for double-time hours (typically 2x straight time rate). Applied for holidays, Sundays, or extended overtime per union agreement.',
    `effective_end_date` DATE COMMENT 'Date when this labor rate expires or is superseded by a new rate. Null indicates the rate is currently active with no defined end date.',
    `effective_start_date` DATE COMMENT 'Date when this labor rate becomes effective. Supports rate changes due to union negotiations, annual adjustments, or contract renewals.',
    `employee_class` STRING COMMENT 'Broad classification of employee role (field workforce, office staff, technical specialist, supervisory, executive). Used for workforce planning and cost allocation.. Valid values are `field|office|technical|supervisory|executive`',
    `flsa_status` STRING COMMENT 'FLSA classification determining overtime eligibility. Non-exempt employees are entitled to overtime pay; exempt employees are not.. Valid values are `exempt|non-exempt`',
    `gl_account_default` STRING COMMENT 'Default general ledger account code for posting labor expenses. Aligns with FERC Uniform System of Accounts for regulated utility accounting.. Valid values are `^[0-9]{6,10}$`',
    `last_modified_by` STRING COMMENT 'User ID or system identifier of the person or process that last modified this labor rate record.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this labor rate record was last updated. Used for change tracking and audit compliance.',
    `notes` STRING COMMENT 'Free-text notes providing additional context about the labor rate, such as special conditions, negotiation history, or application rules.',
    `on_call_rate` DECIMAL(18,2) COMMENT 'Hourly or daily rate paid to employees on standby/on-call status, available for emergency dispatch. May be a flat rate or percentage of straight time rate.',
    `overhead_percentage` DECIMAL(18,2) COMMENT 'Percentage markup for indirect overhead costs (supervision, facilities, administrative support) allocated to labor. Used in CAPEX/OPEX cost allocation and regulatory reporting.',
    `overtime_rate` DECIMAL(18,2) COMMENT 'Hourly labor rate for overtime hours (typically 1.5x straight time rate). Applied for hours worked beyond standard shift or weekly threshold per union agreement and FLSA regulations.',
    `pay_grade` STRING COMMENT 'Pay grade or step level within the craft classification (e.g., Grade 1, Grade 2, Step A, Step B). Determines base compensation level per union agreement or company pay structure.. Valid values are `^[A-Z0-9]{1,6}$`',
    `rate_approval_authority` STRING COMMENT 'Entity or individual who approved the labor rate (e.g., HR Director, Union Negotiating Committee, Public Utility Commission).',
    `rate_approval_date` DATE COMMENT 'Date when the labor rate was formally approved by management, union ratification, or regulatory authority.',
    `rate_source` STRING COMMENT 'Source authority for the labor rate (union collective bargaining agreement, company compensation policy, market survey, contractor agreement, regulatory mandate).. Valid values are `union_cba|company_policy|market_survey|contractor_agreement|regulatory_mandate`',
    `rate_status` STRING COMMENT 'Current lifecycle status of the labor rate record (active and in use, pending approval, expired, superseded by newer rate, suspended).. Valid values are `active|pending|expired|superseded|suspended`',
    `rate_type` STRING COMMENT 'Classification of the labor rate source and employment relationship (union employee, non-union employee, contractor, temporary worker, apprentice, management).. Valid values are `union|non-union|contractor|temporary|apprentice|management`',
    `shift_differential_rate` DECIMAL(18,2) COMMENT 'Additional hourly premium for non-standard shifts (evening, night, weekend shifts). Added to base straight time rate.',
    `storm_emergency_rate` DECIMAL(18,2) COMMENT 'Premium hourly rate applied during declared storm or emergency restoration events. Typically higher than standard overtime to incentivize rapid response for grid restoration.',
    `straight_time_rate` DECIMAL(18,2) COMMENT 'Standard hourly labor rate for regular working hours (typically Monday-Friday, standard shift). Expressed in USD per hour.',
    `work_location_type` STRING COMMENT 'Primary work location type for this labor classification (field-based, office-based, hybrid, remote). Impacts travel time allowances and expense policies.. Valid values are `field|office|hybrid|remote`',
    `created_by` STRING COMMENT 'User ID or system identifier of the person or process that created this labor rate record.',
    CONSTRAINT pk_labor_rate PRIMARY KEY(`labor_rate_id`)
) COMMENT 'Reference table of labor rates by craft classification, union agreement, pay grade, and effective date period. Captures straight-time rate, overtime rate, double-time rate, on-call rate, storm rate, and applicable burden/overhead percentages. Used for work order cost estimation, CAPEX/OPEX labor cost allocation, rate case labor cost support, and contractor vs. employee cost comparison. Sourced from SAP HR wage type configuration and union CBA schedules.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`absence` (
    `absence_id` BIGINT COMMENT 'Unique identifier for the workforce absence record. Primary key.',
    `absence_employee_id` BIGINT COMMENT 'Identifier of the employee who is absent. Links to the employee master record in SAP HR.',
    `absence_replacement_employee_id` BIGINT COMMENT 'Identifier of the employee assigned to cover the absent employees shifts or work assignments. Nullable if no replacement assigned.',
    `technician_id` BIGINT COMMENT 'Identifier of the employee assigned to cover the absent employees shifts or work assignments. Nullable if no replacement assigned.',
    `absence_technician_id` BIGINT COMMENT 'Identifier of the employee who is absent. Links to the employee master record in SAP HR.',
    `approver_technician_id` BIGINT COMMENT 'Identifier of the supervisor or manager who approved or rejected the absence request.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Absence cost accruals are allocated to cost centers for labor cost forecasting and regulatory reporting.',
    `crew_id` BIGINT COMMENT 'Identifier of the crew or work group to which the absent employee is assigned. Used to assess crew coverage impact.',
    `employee_id` BIGINT COMMENT 'Identifier of the supervisor or manager who approved or rejected the absence request.',
    `payroll_period_id` BIGINT COMMENT 'Identifier of the payroll period in which this absence was processed for payment or deduction.',
    `absence_category` STRING COMMENT 'Classification of the absence as planned (scheduled in advance), unplanned (short-notice or same-day), or emergency (critical unplanned absence requiring immediate coverage).. Valid values are `planned|unplanned|emergency`',
    `accrual_deduction_hours` DECIMAL(18,2) COMMENT 'Number of hours deducted from the employees leave accrual balance (e.g., vacation bank, sick leave bank) for this absence.',
    `approval_date` DATE COMMENT 'The date when the absence request was approved or rejected by the approver.',
    `approval_status` STRING COMMENT 'Current approval status of the absence request in the workflow. Pending indicates awaiting supervisor approval, approved indicates authorized absence, rejected indicates denied request, cancelled indicates approved absence later revoked, withdrawn indicates employee retracted the request.. Valid values are `pending|approved|rejected|cancelled|withdrawn`',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this absence record was first created in the source system.',
    `duration_days` DECIMAL(18,2) COMMENT 'Total duration of the absence measured in calendar days or working days depending on absence type configuration.',
    `duration_hours` DECIMAL(18,2) COMMENT 'Total duration of the absence measured in hours. Used for payroll deduction and crew capacity planning.',
    `end_date` DATE COMMENT 'The date when the absence period ends. Nullable for open-ended absences pending return confirmation.',
    `fmla_case_number` STRING COMMENT 'Case number assigned to FMLA leave requests for tracking compliance with the Family Medical Leave Act. Populated only for FMLA absence types.. Valid values are `^FMLA-[0-9]{6,12}$`',
    `impact_on_crew_coverage` STRING COMMENT 'Assessment of the operational impact of this absence on crew coverage and service delivery. Critical indicates absence jeopardizes minimum crew requirements or emergency response capability.. Valid values are `none|low|medium|high|critical`',
    `intermittent_leave_flag` BOOLEAN COMMENT 'Indicates whether this absence is part of an approved intermittent leave arrangement (e.g., recurring FMLA leave taken in separate blocks rather than continuously).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The date and time when this absence record was last updated in the source system.',
    `medical_certification_date` DATE COMMENT 'The date when medical certification documentation was received and validated.',
    `medical_certification_received_flag` BOOLEAN COMMENT 'Indicates whether required medical certification documentation has been received for absences requiring medical justification (e.g., FMLA, extended sick leave, workers compensation).',
    `notification_method` STRING COMMENT 'The method by which the employee or their representative notified the employer of the absence (e.g., phone call, email, mobile app, direct supervisor notification, emergency contact).. Valid values are `phone|email|mobile_app|supervisor_direct|emergency_contact`',
    `notification_timestamp` TIMESTAMP COMMENT 'The date and time when the absence was first reported or notified to the employer.',
    `paid_flag` BOOLEAN COMMENT 'Indicates whether the absence is paid (true) or unpaid (false). Determines payroll treatment.',
    `payroll_processed_flag` BOOLEAN COMMENT 'Indicates whether the absence has been processed in payroll for wage deduction or paid leave disbursement.',
    `reason_description` STRING COMMENT 'Free-text description or notes providing additional context about the reason for the absence. May include details for reporting or documentation purposes.',
    `replacement_required_flag` BOOLEAN COMMENT 'Indicates whether a replacement worker must be scheduled to cover the absent employees duties. True for critical roles or minimum crew requirements.',
    `return_to_work_clearance_flag` BOOLEAN COMMENT 'Indicates whether the employee received medical or safety clearance to return to work following injury, illness, or extended absence. Required for workers compensation and FMLA cases.',
    `return_to_work_date` DATE COMMENT 'The actual date when the employee returned to active work status following the absence. May differ from planned end_date.',
    `scheduled_shift_end_time` TIMESTAMP COMMENT 'The originally scheduled end time of the shift or work assignment that the employee missed due to the absence.',
    `scheduled_shift_start_time` TIMESTAMP COMMENT 'The originally scheduled start time of the shift or work assignment that the employee missed due to the absence.',
    `source_system_code` STRING COMMENT 'Code identifying the system of record where the absence was originally created (SAP_HR for SAP HR Absence Management, CLICKSOFTWARE for ClickSoftware WFM, ESS for Employee Self-Service portal, MANUAL for manual entry).. Valid values are `SAP_HR|CLICKSOFTWARE|ESS|MANUAL`',
    `source_system_record_code` STRING COMMENT 'The unique identifier of this absence record in the source system of record. Used for data lineage and reconciliation.',
    `start_date` DATE COMMENT 'The date when the absence period begins.',
    `storm_response_flag` BOOLEAN COMMENT 'Indicates whether this absence occurred during a declared storm or emergency response period, impacting crew availability for critical restoration work.',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when the employee or their representative submitted the absence request.',
    `type_code` STRING COMMENT 'Code representing the type of absence (e.g., VAC for vacation, SICK for sick leave, FMLA for Family Medical Leave Act, UNION for union leave, JURY for jury duty, MIL for military leave, WC for workers compensation leave, UNPAID for unpaid leave).. Valid values are `^[A-Z0-9]{2,10}$`',
    `type_name` STRING COMMENT 'Human-readable name of the absence type (e.g., Vacation, Sick Leave, FMLA Leave, Union Business, Jury Duty, Military Leave, Workers Compensation, Unpaid Leave).',
    `union_code` STRING COMMENT 'Code identifying the labor union to which the employee belongs. Relevant for union leave types and collective bargaining agreement compliance.. Valid values are `^[A-Z0-9]{2,6}$`',
    `work_center_code` STRING COMMENT 'Code identifying the work center or operational facility where the employee is normally assigned. Used for resource capacity planning.. Valid values are `^[A-Z0-9]{4,10}$`',
    `workers_comp_claim_number` STRING COMMENT 'Claim number assigned to workers compensation leave for tracking occupational injury or illness cases. Populated only for workers compensation absence types.. Valid values are `^WC-[0-9]{6,12}$`',
    CONSTRAINT pk_absence PRIMARY KEY(`absence_id`)
) COMMENT 'Transactional record of planned and unplanned workforce absences including vacation, sick leave, FMLA, union leave, jury duty, military leave, and workers compensation leave. Captures absence type, start date, end date, duration in hours, approval status, and impact on crew coverage. Integrated with SAP HR absence management and used by ClickSoftware WFM to adjust available resource capacity for scheduling and storm response staffing.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`storm_event` (
    `storm_event_id` BIGINT COMMENT 'Unique identifier for the storm or emergency event record. Primary key for the storm event entity.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the designated Incident Commander responsible for overall storm response coordination and decision-making authority.',
    `technician_id` BIGINT COMMENT 'Employee identifier of the designated Incident Commander responsible for overall storm response coordination and decision-making authority.',
    `actual_restoration_cost_usd` DECIMAL(18,2) COMMENT 'Final actual cost in US dollars incurred for storm restoration activities. Captured after event closure for regulatory rate case filing and insurance claims.',
    `actual_restoration_timestamp` TIMESTAMP COMMENT 'Actual date and time when full service restoration was completed and all customers were restored to service.',
    `affected_customer_count` STRING COMMENT 'Total number of customers who experienced service interruption during the storm event. Used for SAIDI/SAIFI reliability metric calculations and regulatory reporting.',
    `affected_service_territory` STRING COMMENT 'Geographic description of the service territory areas impacted by the storm event. May include multiple regions, districts, or the entire service territory.',
    `closure_notes` STRING COMMENT 'Free-text summary of final storm event outcomes, lessons learned, and any outstanding follow-up actions required. Used for after-action review and continuous improvement.',
    `closure_timestamp` TIMESTAMP COMMENT 'Date and time when the storm event was officially closed, indicating completion of all restoration activities, demobilization of crews, and final cost reconciliation.',
    `contractor_crew_count` STRING COMMENT 'Total number of contractor crews engaged for storm restoration work under existing or emergency procurement agreements.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the storm event record was first created in the data management system.',
    `damage_assessment_completed_flag` BOOLEAN COMMENT 'Indicates whether comprehensive damage assessment of transmission and distribution infrastructure has been completed following the storm event.',
    `damage_assessment_timestamp` TIMESTAMP COMMENT 'Date and time when the initial comprehensive damage assessment was completed, enabling accurate restoration time estimates.',
    `declaration_timestamp` TIMESTAMP COMMENT 'Date and time when the storm event was officially declared by operations leadership, triggering emergency workforce mobilization protocols and mutual aid activation.',
    `emergency_operations_center_location` STRING COMMENT 'Physical location or facility name where the Emergency Operations Center was established for storm event coordination.',
    `estimated_restoration_cost_usd` DECIMAL(18,2) COMMENT 'Projected total cost in US dollars for storm restoration activities including labor, materials, equipment, and mutual aid expenses. Updated as event progresses.',
    `estimated_restoration_time` TIMESTAMP COMMENT 'Projected date and time when full service restoration is expected to be completed across all affected areas. Updated throughout the event as conditions and resource availability change.',
    `fema_declaration_flag` BOOLEAN COMMENT 'Indicates whether the storm event resulted in a federal disaster declaration by FEMA, enabling potential federal assistance and cost recovery.',
    `fema_declaration_number` STRING COMMENT 'Official FEMA disaster declaration number assigned to the event if federally declared. Used for tracking federal assistance and reimbursement claims.. Valid values are `^(DR|EM|FM|FS)-[0-9]{4,5}$`',
    `incident_command_activated_flag` BOOLEAN COMMENT 'Indicates whether formal Incident Command System (ICS) structure was activated for coordinated emergency response management.',
    `internal_crew_count` STRING COMMENT 'Total number of internal utility crews mobilized for storm response and restoration activities.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the storm event record was most recently updated, reflecting changes to status, estimates, or other event attributes.',
    `media_inquiries_count` STRING COMMENT 'Total number of media inquiries received from news organizations during the storm event, indicating public and media attention level.',
    `mutual_aid_activated_flag` BOOLEAN COMMENT 'Indicates whether mutual aid resources from other utilities were requested and activated for this storm event. True when external crews are mobilized.',
    `mutual_aid_crew_count` STRING COMMENT 'Total number of external mutual aid crews deployed to support restoration efforts during the storm event.',
    `oms_event_external_code` STRING COMMENT 'External system identifier from GE PowerOn Advanced OMS for linking storm event to outage records and restoration tracking.',
    `peak_outage_count` STRING COMMENT 'Maximum number of customers simultaneously without service at any point during the storm event. Key metric for assessing storm impact severity.',
    `public_communications_issued_count` STRING COMMENT 'Total number of public communications (press releases, social media updates, customer notifications) issued during the storm event for customer and stakeholder awareness.',
    `regulatory_report_due_date` DATE COMMENT 'Deadline date by which post-storm regulatory reports must be submitted to the Public Utility Commission per regulatory requirements.',
    `regulatory_report_submitted_flag` BOOLEAN COMMENT 'Indicates whether required post-storm regulatory reports have been submitted to the Public Utility Commission or other regulatory authorities.',
    `saidi_exclusion_eligible_flag` BOOLEAN COMMENT 'Indicates whether this storm event qualifies for exclusion from SAIDI reliability metric calculations under IEEE 1366 major event day (MED) criteria or regulatory commission rules.',
    `saifi_exclusion_eligible_flag` BOOLEAN COMMENT 'Indicates whether this storm event qualifies for exclusion from SAIFI reliability metric calculations under IEEE 1366 major event day (MED) criteria or regulatory commission rules.',
    `state_emergency_declaration_flag` BOOLEAN COMMENT 'Indicates whether the state governor declared a state of emergency for this storm event, which may trigger regulatory reporting requirements and cost recovery provisions.',
    `storm_end_timestamp` TIMESTAMP COMMENT 'Actual or forecasted date and time when the storm conditions ended or are expected to end in the service territory.',
    `storm_event_code` STRING COMMENT 'Business identifier code assigned to the storm event for external reference and communication with mutual aid partners, regulatory agencies, and internal systems.. Valid values are `^[A-Z0-9]{6,20}$`',
    `storm_name` STRING COMMENT 'Official name assigned to the storm event (e.g., Hurricane Sandy, Winter Storm Jonas). May be assigned by National Weather Service or internal operations.',
    `storm_severity_level` STRING COMMENT 'Numeric severity classification from 1 (minor) to 5 (catastrophic) that determines the scale of workforce mobilization, mutual aid activation, and executive escalation. Aligns with company emergency response plan tiers.',
    `storm_start_timestamp` TIMESTAMP COMMENT 'Actual or forecasted date and time when the storm conditions began or are expected to begin impacting the service territory.',
    `storm_status` STRING COMMENT 'Current lifecycle status of the storm event indicating the phase of emergency response and workforce mobilization.. Valid values are `declared|active|restoration|demobilization|closed|cancelled`',
    `storm_type` STRING COMMENT 'Classification of the storm or emergency event type that determines response protocols and resource mobilization strategies. [ENUM-REF-CANDIDATE: hurricane|tropical_storm|ice_storm|winter_storm|thunderstorm|tornado|derecho|noreaster|flood|wildfire|earthquake|other — 12 candidates stripped; promote to reference product]',
    `total_crew_hours` DECIMAL(18,2) COMMENT 'Cumulative labor hours worked by all crews (internal, mutual aid, and contractor) during the storm event. Used for cost tracking and resource utilization analysis.',
    `weather_forecast_source` STRING COMMENT 'Name of the meteorological service or vendor providing weather forecasting data for storm event planning and response (e.g., National Weather Service, DTN, Weather Company).',
    `wfm_storm_event_external_code` STRING COMMENT 'External system identifier from ClickSoftware Workforce Management system for cross-system reconciliation and integration.',
    CONSTRAINT pk_storm_event PRIMARY KEY(`storm_event_id`)
) COMMENT 'Master record for declared storm and emergency events that trigger emergency workforce mobilization protocols. Captures storm name, storm type (hurricane, ice storm, derecho, noreaster), declaration date/time, affected service territory, estimated restoration time (ERT), storm level (1-5 severity), mutual aid activation flag, and storm status (active, restoration, demobilization, closed). Drives storm crew scheduling, mutual aid crew tracking, and SAIDI/SAIFI storm exclusion reporting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` (
    `storm_assignment_id` BIGINT COMMENT 'Unique identifier for the storm assignment record. Primary key.',
    `cost_center_id` BIGINT COMMENT 'Reference to the cost center charged for this storm assignment. Used for financial accounting and Operations and Maintenance (O&M) expense allocation in SAP Financial Accounting (FI).',
    `created_by_user_employee_id` BIGINT COMMENT 'User identifier of the person or system that created this storm assignment record. Typically a dispatcher or workforce management system user.',
    `crew_id` BIGINT COMMENT 'Reference to the crew assigned to this storm event. May be internal utility crew or mutual aid crew from another utility under Edison Electric Institute (EEI) mutual aid agreements.',
    `employee_id` BIGINT COMMENT 'Reference to individual technician or lineworker assigned to storm duty. Used when assignment is to a specific employee rather than a crew. Mutually exclusive with crew_id for individual assignments.',
    `facility_id` BIGINT COMMENT 'Reference to the operations depot or staging area where the crew or technician reports for storm duty. Used for logistics coordination and resource deployment planning.',
    `internal_order_id` BIGINT COMMENT 'Reference to the SAP internal order used for storm cost collection. Enables tracking of all storm-related costs for regulatory cost recovery and financial reporting.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User identifier of the person or system that last modified this storm assignment record. Used for audit trail and accountability.',
    `storm_event_id` BIGINT COMMENT 'Reference to the declared storm event under which this assignment was created. Links to the storm event master record that triggered emergency response protocols.',
    `technician_id` BIGINT COMMENT 'Reference to individual technician or lineworker assigned to storm duty. Used when assignment is to a specific employee rather than a crew. Mutually exclusive with crew_id for individual assignments.',
    `work_order_id` BIGINT COMMENT 'Reference to the specific work order or restoration job assigned during the storm event. Links storm assignment to actual field work performed for outage restoration tracking.',
    `actual_total_cost` DECIMAL(18,2) COMMENT 'Actual total cost incurred for the storm assignment. Calculated after demobilization based on actual hours, equipment usage, and expenses. Used for post-storm cost recovery filings with regulatory authorities.',
    `assignment_end_timestamp` TIMESTAMP COMMENT 'Date and time when the storm assignment officially ended. May differ from demobilization timestamp due to administrative closeout activities.',
    `assignment_notes` STRING COMMENT 'Free-text notes and comments about the storm assignment. May include special instructions, coordination details, or post-assignment observations from supervisors or crew leads.',
    `assignment_number` STRING COMMENT 'Business identifier for the storm assignment. Format: SA-XXXXXXXXXX where X is numeric. Used for tracking and reporting in workforce management systems.. Valid values are `^SA-[0-9]{10}$`',
    `assignment_role` STRING COMMENT 'Functional role assigned to the crew or technician during the storm event. Determines work scope, safety protocols, and pay classification under International Brotherhood of Electrical Workers (IBEW) storm pay provisions. [ENUM-REF-CANDIDATE: restoration|damage_assessment|wire_guard|tree_removal|substation_repair|switching_operations|customer_liaison|logistics_support — 8 candidates stripped; promote to reference product]',
    `assignment_start_timestamp` TIMESTAMP COMMENT 'Date and time when the storm assignment officially begins. Marks the start of storm pay eligibility and labor cost tracking for the assignment.',
    `assignment_status` STRING COMMENT 'Current lifecycle status of the storm assignment. Tracks progression from initial assignment through mobilization, active work, and demobilization phases.. Valid values are `assigned|mobilized|active|demobilized|completed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this storm assignment record was first created in the system. Used for audit trail and data lineage tracking.',
    `demobilization_timestamp` TIMESTAMP COMMENT 'Date and time when the crew or technician was released from storm duty and demobilized. Marks the end of storm pay period and triggers final labor cost calculation.',
    `dispatch_zone_code` BIGINT COMMENT 'Reference to the geographic dispatch zone where the crew or technician is assigned to work during the storm. Used for territory management and resource allocation optimization.',
    `double_time_hours` DECIMAL(18,2) COMMENT 'Number of hours worked at double-time pay rate during the storm assignment. Applied for extended shifts or specific high-priority restoration work under union agreements.',
    `estimated_daily_cost` DECIMAL(18,2) COMMENT 'Estimated daily cost for the storm assignment including labor, equipment, lodging, and meals. Used for budget tracking and cost recovery planning. For mutual aid crews, based on EEI reimbursement rates.',
    `is_mutual_aid_crew` BOOLEAN COMMENT 'Flag indicating whether this assignment is for a mutual aid crew from another utility under Edison Electric Institute (EEI) mutual aid agreements. True for external crews, False for internal utility crews.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this storm assignment record was last updated. Used for audit trail and change tracking throughout the assignment lifecycle.',
    `lodging_location` STRING COMMENT 'Name and address of the hotel or facility where lodging was provided. Used for expense tracking and mutual aid cost reimbursement.',
    `lodging_provided` BOOLEAN COMMENT 'Flag indicating whether lodging accommodations were provided for the crew or technician during the storm assignment. Relevant for mutual aid crews and extended storm response operations.',
    `meals_provided_count` STRING COMMENT 'Total number of meals provided to the crew or technician during the storm assignment. Used for per diem calculation and mutual aid cost reimbursement under EEI agreements.',
    `mobilization_timestamp` TIMESTAMP COMMENT 'Date and time when the crew or technician physically mobilized to the storm response area. Distinct from assignment start; captures actual deployment time for logistics tracking.',
    `mutual_aid_crew_size` STRING COMMENT 'Number of personnel in the mutual aid crew. Used for lodging, meals, and logistics planning. Populated only for mutual aid assignments.',
    `mutual_aid_equipment_description` STRING COMMENT 'Description of equipment and vehicles brought by the mutual aid crew (e.g., bucket trucks, digger derricks, wire trailers). Used for asset tracking and cost reimbursement.',
    `originating_utility_code` STRING COMMENT 'Standard utility identifier code for the mutual aid provider. Follows EEI utility coding standards for mutual aid coordination and billing.. Valid values are `^[A-Z]{2,6}$`',
    `originating_utility_name` STRING COMMENT 'Name of the utility company that provided the mutual aid crew. Populated only for mutual aid assignments. Used for cost reimbursement tracking and EEI mutual aid billing.',
    `overtime_hours` DECIMAL(18,2) COMMENT 'Number of hours worked at overtime pay rate during the storm assignment. Typically hours beyond standard shift under IBEW storm pay provisions.',
    `priority_level` STRING COMMENT 'Priority classification for the storm assignment. Critical assignments address public safety hazards or critical infrastructure. Drives crew dispatch sequencing and resource allocation decisions.. Valid values are `critical|high|medium|low`',
    `regular_hours` DECIMAL(18,2) COMMENT 'Number of hours worked at regular pay rate during the storm assignment. Component of total hours worked for payroll and cost allocation.',
    `reporting_depot_code` BIGINT COMMENT 'Reference to the operations depot or staging area where the crew or technician reports for storm duty. Used for logistics coordination and resource deployment planning.',
    `safety_incident_description` STRING COMMENT 'Detailed description of any safety incident that occurred during the storm assignment. Populated only if safety_incident_flag is True. Used for OSHA reporting and safety analysis.',
    `safety_incident_flag` BOOLEAN COMMENT 'Flag indicating whether a safety incident occurred during this storm assignment. Triggers Occupational Safety and Health Administration (OSHA) reporting and safety review processes.',
    `sap_hr_assignment_code` STRING COMMENT 'Assignment identifier from SAP HR system used for payroll processing and labor cost accounting. Links storm assignment to SAP HR time recording and payroll modules.',
    `storm_pay_multiplier` DECIMAL(18,2) COMMENT 'Pay rate multiplier applied for storm duty under union agreement provisions. Typically ranges from 1.5x to 2.5x regular rate depending on conditions and duration. Used for payroll calculation.',
    `total_hours_worked` DECIMAL(18,2) COMMENT 'Total number of hours worked during the storm assignment period. Used for storm pay calculation under IBEW provisions and cost recovery filings with Public Utility Commission (PUC).',
    `union_agreement_code` STRING COMMENT 'Code identifying the applicable union collective bargaining agreement governing pay rates and working conditions for this assignment. Typically references IBEW local agreement for utility workers.. Valid values are `^[A-Z0-9]{4,10}$`',
    `wfm_assignment_external_code` STRING COMMENT 'External identifier from the source Workforce Management system (ClickSoftware). Used for data integration and reconciliation between lakehouse and operational WFM system.',
    CONSTRAINT pk_storm_assignment PRIMARY KEY(`storm_assignment_id`)
) COMMENT 'Transactional record tracking crew and technician assignments during a declared storm event, including both internal utility crews and mutual aid crews from other utilities under EEI mutual aid agreements. Captures storm event reference, assigned crew or technician, assignment role (restoration, damage assessment, wire guard), reporting depot, mobilization and demobilization timestamps, and hours worked under storm pay provisions. For mutual aid crews: originating utility, crew composition, equipment brought, and cost reimbursement tracking. Supports IBEW storm pay calculation, EEI mutual aid billing, and post-storm cost recovery filings.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` (
    `on_call_rotation_id` BIGINT COMMENT 'Unique identifier for the on-call rotation schedule record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: On‑call pay and related expenses must be allocated to cost centers for accurate financial statements.',
    `crew_id` BIGINT COMMENT 'Crew assigned to this on-call rotation if rotation is crew-based rather than individual technician-based.',
    `dispatch_zone_id` BIGINT COMMENT 'Dispatch zone within the service territory for this on-call rotation.',
    `employee_id` BIGINT COMMENT 'User ID of the workforce scheduler or system user who created this rotation record.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'User ID of the workforce scheduler or system user who last modified this rotation record.',
    `technician_id` BIGINT COMMENT 'Primary technician assigned to this on-call rotation period.',
    `shift_id` BIGINT COMMENT 'SAP HR shift plan identifier linked to this on-call rotation for payroll integration.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: On‑call activities are charged to WBS elements to track project‑level labor effort and compliance.',
    `actual_callouts_count` STRING COMMENT 'Number of emergency callouts that occurred during this rotation period.',
    `avg_response_time_minutes` DECIMAL(18,2) COMMENT 'Average response time in minutes for callouts during this rotation period.',
    `backup_contact_phone` STRING COMMENT 'Phone number to reach the backup technician during this rotation period.',
    `callout_minimum_hours` DECIMAL(18,2) COMMENT 'Minimum billable hours guaranteed per union agreement when technician is called out (e.g., 4-hour minimum per CBA).',
    `callout_radius_miles` DECIMAL(18,2) COMMENT 'Maximum distance in miles from technician home location or depot for emergency callout coverage.',
    `cdl_required` BOOLEAN COMMENT 'Indicates whether a valid CDL is required for this on-call rotation.',
    `clicksoftware_rotation_code` STRING COMMENT 'External identifier for this on-call rotation in the ClickSoftware Workforce Management system.',
    `contact_phone` STRING COMMENT 'Primary phone number to reach the on-call technician during this rotation period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this on-call rotation record was first created in the system.',
    `dispatch_center_code` STRING COMMENT 'Code identifying the dispatch center responsible for activating this on-call rotation.',
    `emergency_type_coverage` STRING COMMENT 'Comma-separated list of emergency incident types covered by this rotation (e.g., outage, gas leak, downed wire, transformer failure).',
    `gas_operator_qualified_required` BOOLEAN COMMENT 'Indicates whether DOT Pipeline and Hazardous Materials Safety Administration (PHMSA) gas operator qualification is required for this rotation.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this on-call rotation record was last updated.',
    `mutual_aid_eligible` BOOLEAN COMMENT 'Indicates whether technician/crew in this rotation can be deployed for mutual aid to other utilities during major events.',
    `nerc_cip_required` BOOLEAN COMMENT 'Indicates whether NERC CIP security clearance is required for this on-call rotation due to critical infrastructure access.',
    `notes` STRING COMMENT 'Free-text notes regarding special conditions, coverage changes, or incidents during this rotation period.',
    `on_call_pay_provision` STRING COMMENT 'Specific union CBA clause or company policy defining on-call compensation (e.g., standby pay rate, minimum call-in hours, overtime multiplier).',
    `on_call_pay_rate` DECIMAL(18,2) COMMENT 'Hourly or daily standby pay rate for being on-call during this rotation period.',
    `osha_qualification_required` STRING COMMENT 'OSHA safety qualifications required for technicians in this rotation (e.g., OSHA 10, OSHA 30, confined space, arc flash).',
    `overtime_multiplier` DECIMAL(18,2) COMMENT 'Overtime pay multiplier applied to callout work during on-call rotation (e.g., 1.5x, 2.0x for weekend/holiday).',
    `priority_tier` STRING COMMENT 'Priority tier for emergency dispatch escalation (Tier 1 = first responder, Tier 2 = backup, Tier 3 = management escalation).. Valid values are `tier_1|tier_2|tier_3|escalation`',
    `response_time_sla_minutes` STRING COMMENT 'Maximum number of minutes allowed for technician to respond to emergency callout during this rotation (e.g., 30-minute callout SLA).',
    `rotation_end_datetime` TIMESTAMP COMMENT 'Date and time when the on-call rotation period ends.',
    `rotation_name` STRING COMMENT 'Descriptive name for the on-call rotation schedule (e.g., Week 1 Gas Emergency, Storm Response Rotation A).',
    `rotation_start_datetime` TIMESTAMP COMMENT 'Date and time when the on-call rotation period begins.',
    `rotation_status` STRING COMMENT 'Current lifecycle status of the on-call rotation schedule.. Valid values are `scheduled|active|completed|cancelled|suspended`',
    `rotation_type` STRING COMMENT 'Frequency pattern of the on-call rotation schedule.. Valid values are `weekly|bi-weekly|monthly|daily|custom`',
    `service_territory_code` STRING COMMENT 'Geographic service territory covered by this on-call rotation.',
    `service_type` STRING COMMENT 'Type of emergency service this on-call rotation covers.. Valid values are `outage_restoration|gas_leak_response|downed_wire|emergency_dispatch|storm_response|after_hours_service`',
    `sla_compliance_rate` DECIMAL(18,2) COMMENT 'Percentage of callouts during this rotation that met the response time SLA.',
    `storm_response_eligible` BOOLEAN COMMENT 'Indicates whether this rotation is eligible for storm emergency response activation.',
    `union_agreement_code` STRING COMMENT 'Collective Bargaining Agreement (CBA) code governing on-call pay provisions and work rules for this rotation.',
    `voltage_class_coverage` STRING COMMENT 'Voltage classes this on-call rotation is qualified to handle (e.g., low voltage, medium voltage, high voltage, transmission).',
    CONSTRAINT pk_on_call_rotation PRIMARY KEY(`on_call_rotation_id`)
) COMMENT 'Defines the on-call rotation schedule for field technicians and crews responsible for after-hours emergency response including outage restoration, gas leak response, and downed wire calls. Captures rotation period (weekly, bi-weekly), technician assigned, backup technician, on-call start and end date/time, response time SLA (e.g., 30-minute callout), and union on-call pay provision. Supports 24/7 emergency dispatch readiness and union CBA on-call compensation compliance.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`employee` (
    `employee_id` BIGINT COMMENT 'Primary key for employee',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: HR reporting assigns each employee to a primary facility for payroll, safety training, and resource allocation.',
    `supervisor_employee_id` BIGINT COMMENT 'Employee ID of the direct supervisor.',
    `tech_project_id` BIGINT COMMENT 'Foreign key linking to technology.tech_project. Business justification: Technology Project Management process assigns a workforce employee as project manager for each tech project, used in project governance reports.',
    `manager_employee_id` BIGINT COMMENT 'Self-referencing FK on employee (manager_employee_id)',
    `address_line1` STRING COMMENT 'First line of the employees home address.',
    `availability_status` STRING COMMENT 'Current work availability of the employee.. Valid values are `available|unavailable|on_call`',
    `birth_date` DATE COMMENT 'Employees date of birth.',
    `cdl_expiration_date` DATE COMMENT 'Expiration date of the employees CDL.',
    `cdl_license_class` STRING COMMENT 'Commercial Drivers License class held by the employee, if applicable.',
    `city` STRING COMMENT 'City of the employees home address.',
    `clicksoftware_resource_code` STRING COMMENT 'Identifier for the employee in the ClickSoftware workforce management system.',
    `cost_center_code` STRING COMMENT 'Cost center associated with the employees labor charges.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the employees residence.',
    `craft_type` STRING COMMENT 'Primary trade or craft classification of the employee.. Valid values are `lineworker|meter_reader|technician|engineer|dispatcher`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the employee record was first created in the system.',
    `department_code` STRING COMMENT 'Code of the department to which the employee belongs.',
    `email_address` STRING COMMENT 'Primary work email address for the employee.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `employee_number` STRING COMMENT 'Internal employee identifier used across corporate systems.',
    `employee_status` STRING COMMENT 'Current lifecycle status of the employee.. Valid values are `active|inactive|terminated|retired|on_leave`',
    `employee_type` STRING COMMENT 'Classification of employment relationship.. Valid values are `full_time|part_time|contractor|temporary|seasonal`',
    `employment_status` STRING COMMENT 'Current employment status of the employee.. Valid values are `employed|terminated|retired|leave_of_absence`',
    `employment_type` STRING COMMENT 'Nature of the employment agreement.. Valid values are `permanent|temporary|contract`',
    `first_name` STRING COMMENT 'Given name of the employee.',
    `full_name` STRING COMMENT 'Legal full name of the employee as recorded in the HR system.',
    `gender_code` STRING COMMENT 'Gender of the employee.. Valid values are `M|F|X|U`',
    `hire_date` DATE COMMENT 'Date the employee was hired.',
    `hourly_rate` DECIMAL(18,2) COMMENT 'Standard hourly compensation rate for the employee.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: IT Service Ownership register assigns a workforce employee as service owner, needed for ITIL service management and SLA tracking.',
    `job_title` STRING COMMENT 'Official job title of the employee.',
    `last_name` STRING COMMENT 'Family name of the employee.',
    `last_safety_training_date` DATE COMMENT 'Date of the most recent safety training completed by the employee.',
    `location_code` STRING COMMENT 'Home depot or primary work location code for the employee.',
    `mobile_device_code` STRING COMMENT 'Identifier of the mobile device assigned to the employee for field operations.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the employee record.',
    `org_unit_code` STRING COMMENT 'Organizational unit identifier within the enterprise hierarchy.',
    `osha_qualified` BOOLEAN COMMENT 'Indicates whether the employee has completed required OSHA safety training.',
    `overtime_eligible` BOOLEAN COMMENT 'Indicates if the employee is eligible for overtime pay.',
    `pay_currency_code` STRING COMMENT 'ISO currency code for the employees compensation.. Valid values are `USD|CAD|MXN`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the employee.',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the employees home address.',
    `safety_incident_count` STRING COMMENT 'Cumulative count of safety incidents associated with the employee.',
    `sap_personnel_number` STRING COMMENT 'Personnel number assigned by SAP ERP HR module.',
    `social_security_number` STRING COMMENT 'Government‑issued identifier for the employee.',
    `state_province` STRING COMMENT 'State or province of the employees home address.',
    `termination_date` DATE COMMENT 'Date the employees employment ended, if applicable.',
    `termination_reason` STRING COMMENT 'Reason for termination of employment.',
    `union_affiliation_code` STRING COMMENT 'Code representing the employees union affiliation.',
    `union_local_number` STRING COMMENT 'Local union chapter number for the employee.',
    CONSTRAINT pk_employee PRIMARY KEY(`employee_id`)
) COMMENT 'Master reference table for employee. ';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`line_crew_assignment` (
    `line_crew_assignment_id` BIGINT COMMENT 'Primary key for the LineCrewAssignment association',
    `crew_id` BIGINT COMMENT 'Foreign key linking to the crew',
    `line_id` BIGINT COMMENT 'Foreign key linking to the transmission line',
    `assignment_end_date` DATE COMMENT 'Date the crew assignment to the line ends',
    `assignment_start_date` DATE COMMENT 'Date the crew assignment to the line begins',
    `role` STRING COMMENT 'Role of the crew for this assignment (e.g., construction, maintenance, emergency)',
    CONSTRAINT pk_line_crew_assignment PRIMARY KEY(`line_crew_assignment_id`)
) COMMENT 'Represents the assignment of a field crew to a transmission line. Each record captures the crew, the line, the assignment start and end dates, and the crews role for that assignment.. Existence Justification: A transmission line can be serviced by many field crews over its lifecycle, and a crew can be dispatched to work on many different transmission lines. The utility actively creates, updates, and deletes assignment records that capture which crew is assigned to which line, with start/end dates and role information.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` (
    `asset_technician_authorization_id` BIGINT COMMENT 'Primary key for the AssetTechnicianAuthorization association',
    `registry_id` BIGINT COMMENT 'Foreign key linking to the asset registry',
    `technician_id` BIGINT COMMENT 'Foreign key linking to the technician',
    `asset_technician_authorization_status` STRING COMMENT 'Current status of the authorization (active, suspended, revoked)',
    `authorization_date` DATE COMMENT 'Date the technician was authorized to work on the asset',
    `certification_level` STRING COMMENT 'Certification level required for the asset work',
    `expiration_date` DATE COMMENT 'Date the authorization expires',
    CONSTRAINT pk_asset_technician_authorization PRIMARY KEY(`asset_technician_authorization_id`)
) COMMENT 'Represents the authorization of field technicians to work on specific utility assets. Each record links one asset registry entry to one technician and stores attributes that belong only to the authorization relationship.. Existence Justification: Technicians are authorized to work on specific utility assets for safety, compliance, and scheduling. An asset can have multiple authorized technicians, and a technician can be authorized on many assets. Each authorization record captures dates, certification level, and status, making the relationship a managed business entity.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`storm_parcel_impact` (
    `storm_parcel_impact_id` BIGINT COMMENT 'Primary key for the storm_parcel_impact association',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to the parcel',
    `storm_event_id` BIGINT COMMENT 'Foreign key linking to the storm event',
    `actual_restoration_timestamp` TIMESTAMP COMMENT 'Actual date and time when restoration for this parcel was completed',
    `damage_assessment_completed_flag` BOOLEAN COMMENT 'Indicates whether a damage assessment has been completed for this parcel in the context of the storm',
    `estimated_restoration_time` TIMESTAMP COMMENT 'Estimated date and time when restoration work for this parcel is expected to be finished',
    CONSTRAINT pk_storm_parcel_impact PRIMARY KEY(`storm_parcel_impact_id`)
) COMMENT 'Represents the operational link between a storm event and a utility-owned parcel. Each record captures the damage assessment status and restoration timing for that specific parcel during the storm.. Existence Justification: Each storm event can affect many land parcels, and a single parcel can be impacted by multiple storm events over time. The utility creates and maintains a record for each storm‑parcel pair that captures damage assessment status and restoration timestamps, which are operational data managed by crews.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`payroll_period` (
    `payroll_period_id` BIGINT COMMENT 'Primary key for payroll_period',
    `prior_payroll_period_id` BIGINT COMMENT 'Self-referencing FK on payroll_period (prior_payroll_period_id)',
    `approval_status` STRING COMMENT 'Current approval state of the payroll period.',
    `approved_by` STRING COMMENT 'Name or identifier of the person who approved the payroll period.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll period was approved.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payroll period record was first created.',
    `payroll_period_description` STRING COMMENT 'Free‑form description or notes about the payroll period.',
    `end_date` DATE COMMENT 'Last calendar date of the payroll period.',
    `fiscal_year` STRING COMMENT 'Fiscal year to which the payroll period belongs.',
    `frequency` STRING COMMENT 'Standard frequency at which payroll is processed for this period.',
    `is_bonus_period` BOOLEAN COMMENT 'True if the period includes bonus compensation.',
    `is_overtime_eligible` BOOLEAN COMMENT 'True if employees are eligible for overtime pay during this period.',
    `labor_category` STRING COMMENT 'Primary labor category (e.g., lineworker, meter_reader) for the period.',
    `notes` STRING COMMENT 'Additional free‑form notes related to the payroll period.',
    `pay_date` DATE COMMENT 'Date on which payroll for the period is issued to employees.',
    `payroll_amount_cap` DECIMAL(18,2) COMMENT 'Maximum total payroll amount allowed for the period.',
    `payroll_currency` STRING COMMENT 'ISO 4217 currency code for payroll amounts (e.g., USD).',
    `payroll_cycle_type` STRING COMMENT 'Classification of the payroll cycle frequency for the period.',
    `payroll_method` STRING COMMENT 'Method used to disburse payroll for the period.',
    `period_name` STRING COMMENT 'Human‑readable name of the payroll period (e.g., "July 2023").',
    `period_number` STRING COMMENT 'Sequential number of the period within the fiscal year (e.g., 7 for July).',
    `start_date` DATE COMMENT 'First calendar date of the payroll period.',
    `payroll_period_status` STRING COMMENT 'Current lifecycle status of the payroll period.',
    `tax_withholding_code` STRING COMMENT 'Code representing the tax withholding classification applied to the period.',
    `union_applicable` BOOLEAN COMMENT 'True if union rules apply to labor during this period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the payroll period record.',
    CONSTRAINT pk_payroll_period PRIMARY KEY(`payroll_period_id`)
) COMMENT 'Master reference table for payroll_period. Referenced by payroll_period_id.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`vehicle` (
    `vehicle_id` BIGINT COMMENT 'Primary key for vehicle',
    `crew_id` BIGINT COMMENT 'Identifier of the field crew currently responsible for the vehicle.',
    `replaced_vehicle_id` BIGINT COMMENT 'Self-referencing FK on vehicle (replaced_vehicle_id)',
    `acquisition_date` DATE COMMENT 'Date the vehicle was purchased or otherwise obtained.',
    `compliance_status` STRING COMMENT 'Indicates whether the vehicle meets all applicable safety and environmental regulations.',
    `depot_location_code` STRING COMMENT 'Code of the depot or garage where the vehicle is based.',
    `depreciation_method` STRING COMMENT 'Accounting method used to depreciate the vehicles value.',
    `emission_standard` STRING COMMENT 'Regulatory emissions classification applicable to the vehicle.',
    `emissions_expiry_date` DATE COMMENT 'Date the current emissions certification expires.',
    `emissions_test_date` DATE COMMENT 'Date the vehicle last passed an emissions compliance test.',
    `fuel_capacity_gallons` DECIMAL(18,2) COMMENT 'Total fuel volume the vehicles tank can hold.',
    `fuel_type` STRING COMMENT 'Primary energy source used by the vehicle.',
    `gps_device_code` STRING COMMENT 'Unique identifier of the telematics/GPS unit installed in the vehicle.',
    `gps_enabled` BOOLEAN COMMENT 'Indicates whether the vehicle is equipped with an active GPS device.',
    `gps_last_update_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent location ping from the GPS device.',
    `insurance_expiry_date` DATE COMMENT 'Date the vehicles insurance coverage ends.',
    `insurance_policy_number` STRING COMMENT 'Identifier of the insurance contract covering the vehicle.',
    `last_known_latitude` DOUBLE COMMENT 'Most recent latitude coordinate reported by the vehicle.',
    `last_known_longitude` DOUBLE COMMENT 'Most recent longitude coordinate reported by the vehicle.',
    `last_known_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent location report.',
    `last_service_date` DATE COMMENT 'Most recent date on which the vehicle received maintenance.',
    `lease_end_date` DATE COMMENT 'Date the lease agreement for the vehicle expires (if applicable).',
    `license_plate` STRING COMMENT 'State‑issued registration plate identifier.',
    `maintenance_status` STRING COMMENT 'Current state of required maintenance activities.',
    `make` STRING COMMENT 'Company that manufactured the vehicle (e.g., Ford, Chevrolet).',
    `mileage_since_service_km` DECIMAL(18,2) COMMENT 'Distance traveled since the most recent service event.',
    `model` STRING COMMENT 'Specific model designation from the manufacturer.',
    `next_service_due` DATE COMMENT 'Scheduled date for the next preventive maintenance.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or observations about the vehicle.',
    `odometer_reading_km` DECIMAL(18,2) COMMENT 'Cumulative distance traveled by the vehicle, recorded in kilometers.',
    `payload_capacity_kg` DECIMAL(18,2) COMMENT 'Maximum weight the vehicle can safely carry, expressed in kilograms.',
    `purchase_currency` STRING COMMENT 'ISO 4217 currency code of the purchase price.',
    `purchase_price` DECIMAL(18,2) COMMENT 'Capital cost paid to acquire the vehicle.',
    `purchase_source` STRING COMMENT 'Indicates whether the vehicle was bought outright or obtained via lease.',
    `registration_expiry_date` DATE COMMENT 'Date the vehicles legal registration expires.',
    `retirement_date` DATE COMMENT 'Date the vehicle was removed from active service (nullable if still active).',
    `safety_certification_date` DATE COMMENT 'Date the vehicle received its most recent safety certification.',
    `safety_certification_expiry` DATE COMMENT 'Expiration date of the current safety certification.',
    `service_interval_km` DECIMAL(18,2) COMMENT 'Mileage threshold that triggers scheduled maintenance.',
    `vehicle_status` STRING COMMENT 'Current operational state of the vehicle.',
    `telematics_enabled` BOOLEAN COMMENT 'Indicates whether the vehicle transmits telematics data beyond basic GPS.',
    `vehicle_name` STRING COMMENT 'Human‑readable name or designation for the vehicle (e.g., "North Ridge Truck 12").',
    `vehicle_type` STRING COMMENT 'Category of vehicle based on function and design.',
    `vin` STRING COMMENT 'Manufacturer‑assigned 17‑character identifier for the vehicle.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Gross vehicle weight in kilograms.',
    `year` STRING COMMENT 'Calendar year the vehicle was manufactured.',
    CONSTRAINT pk_vehicle PRIMARY KEY(`vehicle_id`)
) COMMENT 'Master reference table for vehicle. Referenced by vehicle_id.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`dispatch_zone` (
    `dispatch_zone_id` BIGINT COMMENT 'Primary key for dispatch_zone',
    `distribution_substation_id` BIGINT COMMENT 'Identifier of the main substation supplying the dispatch zone.',
    `parent_dispatch_zone_id` BIGINT COMMENT 'Self-referencing FK on dispatch_zone (parent_dispatch_zone_id)',
    `area_sq_km` DECIMAL(18,2) COMMENT 'Geographic size of the dispatch zone in square kilometers.',
    `audit_user` STRING COMMENT 'User identifier who performed the most recent create or update operation.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the zone according to NERC and local standards.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the dispatch zone record was first created.',
    `crew_capacity` STRING COMMENT 'Maximum number of field crew members that can be assigned to the zone simultaneously.',
    `data_source` STRING COMMENT 'Originating system that supplied the zone record.',
    `dispatch_priority` STRING COMMENT 'Numeric priority used by scheduling algorithms; lower numbers indicate higher priority.',
    `effective_from` DATE COMMENT 'Date when the zone definition becomes effective for dispatch operations.',
    `effective_until` DATE COMMENT 'Date when the zone definition expires or is superseded; null if open‑ended.',
    `emergency_response_level` STRING COMMENT 'Designated emergency response tier for the zone during storms or outages.',
    `external_reference_code` STRING COMMENT 'Identifier used by external partner systems to reference the zone.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the zone is currently active in the dispatch system.',
    `last_outage_date` DATE COMMENT 'Date of the most recent recorded outage in the zone.',
    `last_outage_duration_minutes` STRING COMMENT 'Duration of the most recent outage measured in minutes.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the zone centroid.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle stage of the zone within the utilitys asset management.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the zone centroid.',
    `maintenance_window_end` STRING COMMENT 'Planned daily end time for routine maintenance activities (HH:mm, 24‑hour).',
    `maintenance_window_start` STRING COMMENT 'Planned daily start time for routine maintenance activities (HH:mm, 24‑hour).',
    `notes` STRING COMMENT 'Free‑form comments or operational notes about the zone.',
    `outage_history_flag` BOOLEAN COMMENT 'Indicates whether historical outage data is retained for the zone.',
    `region` STRING COMMENT 'Geographic region (e.g., North, South) for reporting and regulatory purposes.',
    `regulatory_zone_flag` BOOLEAN COMMENT 'True if the zone is subject to special regulatory reporting requirements.',
    `service_area` STRING COMMENT 'Higher‑level service area to which the dispatch zone belongs.',
    `dispatch_zone_status` STRING COMMENT 'Current operational status of the dispatch zone.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the dispatch zone record.',
    `version_number` STRING COMMENT 'Incremental version of the zone definition for change management.',
    `voltage_level` STRING COMMENT 'Typical operating voltage level of the zones distribution network.',
    `zone_code` STRING COMMENT 'External code assigned to the zone for integration with field systems.',
    `zone_name` STRING COMMENT 'Human‑readable name of the dispatch zone used in scheduling and reporting.',
    `zone_type` STRING COMMENT 'Category of the zone based on customer mix and criticality.',
    CONSTRAINT pk_dispatch_zone PRIMARY KEY(`dispatch_zone_id`)
) COMMENT 'Master reference table for dispatch_zone. Referenced by dispatch_zone_id.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`workforce`.`depot` (
    `depot_id` BIGINT COMMENT 'Primary key for depot',
    `parent_depot_id` BIGINT COMMENT 'Self-referencing FK on depot (parent_depot_id)',
    `address_line1` STRING COMMENT 'First line of the depots street address.',
    `address_line2` STRING COMMENT 'Second line of the depots street address (optional).',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum power capacity of the depot in megawatts.',
    `city` STRING COMMENT 'City where the depot is located.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the depot.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the depot location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the depot record was first created in the system.',
    `depot_code` STRING COMMENT 'Unique alphanumeric code assigned to the depot by the enterprise.',
    `depot_name` STRING COMMENT 'Human‑readable name of the depot.',
    `depot_type` STRING COMMENT 'Category of depot based on its primary operational function.',
    `effective_from` DATE COMMENT 'Date from which the depot record is considered active.',
    `effective_until` DATE COMMENT 'Date after which the depot record is no longer active (null if open‑ended).',
    `emergency_contact_name` STRING COMMENT 'Name of the designated emergency contact for the depot.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the emergency contact.',
    `fuel_type` STRING COMMENT 'Primary fuel source for depot‑owned equipment or generators.',
    `gps_accuracy_m` DOUBLE COMMENT 'Estimated accuracy of the GPS coordinates in meters.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.',
    `is_remote` BOOLEAN COMMENT 'True if the depot is located in a remote or hard‑to‑reach area.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or regulatory inspection.',
    `last_updated_by` STRING COMMENT 'User identifier of the person who performed the most recent update.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the depot in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the depot in decimal degrees.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or operational comments.',
    `number_of_crew` STRING COMMENT 'Total number of field personnel assigned to the depot.',
    `operational_since` DATE COMMENT 'Date the depot began operations.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the depot address.',
    `region` STRING COMMENT 'Geographic region classification for reporting.',
    `risk_level` STRING COMMENT 'Risk classification for safety, environmental, and operational exposure.',
    `safety_certified` BOOLEAN COMMENT 'Indicates whether the depot meets OSHA safety certification requirements.',
    `service_area` STRING COMMENT 'Name of the service area or grid zone the depot serves.',
    `state` STRING COMMENT 'State or province of the depot location.',
    `depot_status` STRING COMMENT 'Current lifecycle status of the depot.',
    `union_contract_number` STRING COMMENT 'Identifier of the collective bargaining agreement governing depot labor.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the depot record.',
    CONSTRAINT pk_depot PRIMARY KEY(`depot_id`)
) COMMENT 'Master reference table for depot. Referenced by home_depot_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ADD CONSTRAINT `fk_workforce_technician_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_depot_id` FOREIGN KEY (`depot_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`depot`(`depot_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_labor_rate_id` FOREIGN KEY (`labor_rate_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`labor_rate`(`labor_rate_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ADD CONSTRAINT `fk_workforce_crew_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ADD CONSTRAINT `fk_workforce_crew_member_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ADD CONSTRAINT `fk_workforce_crew_member_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ADD CONSTRAINT `fk_workforce_crew_member_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ADD CONSTRAINT `fk_workforce_work_order_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ADD CONSTRAINT `fk_workforce_work_order_assignment_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_modified_by_user_employee_id` FOREIGN KEY (`modified_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_vehicle_id` FOREIGN KEY (`vehicle_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`vehicle`(`vehicle_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ADD CONSTRAINT `fk_workforce_schedule_work_order_assignment_id` FOREIGN KEY (`work_order_assignment_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`work_order_assignment`(`work_order_assignment_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_approving_user_employee_id` FOREIGN KEY (`approving_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`storm_event`(`storm_event_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ADD CONSTRAINT `fk_workforce_time_entry_tertiary_time_approving_user_technician_id` FOREIGN KEY (`tertiary_time_approving_user_technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ADD CONSTRAINT `fk_workforce_qualification_superseded_by_qualification_id` FOREIGN KEY (`superseded_by_qualification_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`qualification`(`qualification_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ADD CONSTRAINT `fk_workforce_technician_qualification_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ADD CONSTRAINT `fk_workforce_labor_rate_union_agreement_id` FOREIGN KEY (`union_agreement_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`union_agreement`(`union_agreement_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ADD CONSTRAINT `fk_workforce_absence_absence_employee_id` FOREIGN KEY (`absence_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ADD CONSTRAINT `fk_workforce_absence_absence_replacement_employee_id` FOREIGN KEY (`absence_replacement_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ADD CONSTRAINT `fk_workforce_absence_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ADD CONSTRAINT `fk_workforce_absence_absence_technician_id` FOREIGN KEY (`absence_technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ADD CONSTRAINT `fk_workforce_absence_approver_technician_id` FOREIGN KEY (`approver_technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ADD CONSTRAINT `fk_workforce_absence_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ADD CONSTRAINT `fk_workforce_absence_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ADD CONSTRAINT `fk_workforce_absence_payroll_period_id` FOREIGN KEY (`payroll_period_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ADD CONSTRAINT `fk_workforce_storm_event_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ADD CONSTRAINT `fk_workforce_storm_event_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ADD CONSTRAINT `fk_workforce_storm_assignment_created_by_user_employee_id` FOREIGN KEY (`created_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ADD CONSTRAINT `fk_workforce_storm_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ADD CONSTRAINT `fk_workforce_storm_assignment_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ADD CONSTRAINT `fk_workforce_storm_assignment_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ADD CONSTRAINT `fk_workforce_storm_assignment_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`storm_event`(`storm_event_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ADD CONSTRAINT `fk_workforce_storm_assignment_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ADD CONSTRAINT `fk_workforce_on_call_rotation_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ADD CONSTRAINT `fk_workforce_on_call_rotation_dispatch_zone_id` FOREIGN KEY (`dispatch_zone_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`dispatch_zone`(`dispatch_zone_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ADD CONSTRAINT `fk_workforce_on_call_rotation_employee_id` FOREIGN KEY (`employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ADD CONSTRAINT `fk_workforce_on_call_rotation_last_modified_by_user_employee_id` FOREIGN KEY (`last_modified_by_user_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ADD CONSTRAINT `fk_workforce_on_call_rotation_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ADD CONSTRAINT `fk_workforce_on_call_rotation_shift_id` FOREIGN KEY (`shift_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`shift`(`shift_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_supervisor_employee_id` FOREIGN KEY (`supervisor_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ADD CONSTRAINT `fk_workforce_employee_manager_employee_id` FOREIGN KEY (`manager_employee_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`employee`(`employee_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`line_crew_assignment` ADD CONSTRAINT `fk_workforce_line_crew_assignment_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` ADD CONSTRAINT `fk_workforce_asset_technician_authorization_technician_id` FOREIGN KEY (`technician_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`technician`(`technician_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_parcel_impact` ADD CONSTRAINT `fk_workforce_storm_parcel_impact_storm_event_id` FOREIGN KEY (`storm_event_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`storm_event`(`storm_event_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`payroll_period` ADD CONSTRAINT `fk_workforce_payroll_period_prior_payroll_period_id` FOREIGN KEY (`prior_payroll_period_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`payroll_period`(`payroll_period_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`vehicle` ADD CONSTRAINT `fk_workforce_vehicle_crew_id` FOREIGN KEY (`crew_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`crew`(`crew_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`vehicle` ADD CONSTRAINT `fk_workforce_vehicle_replaced_vehicle_id` FOREIGN KEY (`replaced_vehicle_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`vehicle`(`vehicle_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`dispatch_zone` ADD CONSTRAINT `fk_workforce_dispatch_zone_parent_dispatch_zone_id` FOREIGN KEY (`parent_dispatch_zone_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`dispatch_zone`(`dispatch_zone_id`);
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ADD CONSTRAINT `fk_workforce_depot_parent_depot_id` FOREIGN KEY (`parent_depot_id`) REFERENCES `power_and_utilities_v2`.`workforce`.`depot`(`depot_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`workforce` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities_v2`.`workforce` SET TAGS ('dbx_domain' = 'workforce');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `base_location_code` SET TAGS ('dbx_business_glossary_term' = 'Base Location Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `cdl_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Drivers License (CDL) Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `cdl_license_class` SET TAGS ('dbx_business_glossary_term' = 'Commercial Drivers License (CDL) Class');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `cdl_license_class` SET TAGS ('dbx_value_regex' = 'A|B|C|none');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `clicksoftware_resource_code` SET TAGS ('dbx_business_glossary_term' = 'ClickSoftware Workforce Management (WFM) Resource ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `craft_type` SET TAGS ('dbx_business_glossary_term' = 'Craft Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `dispatch_eligible` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `drug_test_date` SET TAGS ('dbx_business_glossary_term' = 'Drug Test Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `drug_test_date` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `drug_test_status` SET TAGS ('dbx_business_glossary_term' = 'Drug Test Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `drug_test_status` SET TAGS ('dbx_value_regex' = 'pass|fail|pending|not_required');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `drug_test_status` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'active|on_leave|terminated|suspended|probationary');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contract|temporary|seasonal');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_business_glossary_term' = 'Ethnicity Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `ethnicity_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `last_osha_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Occupational Safety and Health Administration (OSHA) Training Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `nerc_cip_access_level` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Critical Infrastructure Protection (CIP) Access Level');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `nerc_cip_access_level` SET TAGS ('dbx_value_regex' = 'none|physical|logical|both');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `nerc_cip_background_check_date` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Critical Infrastructure Protection (CIP) Background Check Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `osha_qualified` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Qualified Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `osha_training_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Training Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `pay_grade` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Technician Preferred Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `primary_skill_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Skill Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `sap_personnel_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Personnel Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `sap_personnel_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `sap_personnel_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `secondary_skill_codes` SET TAGS ('dbx_business_glossary_term' = 'Secondary Skill Codes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `storm_response_tier` SET TAGS ('dbx_business_glossary_term' = 'Storm Response Tier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `storm_response_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|exempt');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `supervisor_personnel_number` SET TAGS ('dbx_business_glossary_term' = 'Supervisor SAP Personnel Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `travel_radius_miles` SET TAGS ('dbx_business_glossary_term' = 'Travel Radius Miles');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `union_affiliation` SET TAGS ('dbx_value_regex' = 'ibew|uwua|iuoe|non_union|management');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `union_local_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `vehicle_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Assignment Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `work_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Work Schedule Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `worker_classification` SET TAGS ('dbx_business_glossary_term' = 'Worker Classification');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician` ALTER COLUMN `worker_classification` SET TAGS ('dbx_value_regex' = 'journeyman|apprentice|foreman|crew_lead|supervisor|specialist');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `gis_boundary_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Zone ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Home Depot / Garage ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Lead Employee ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Lead Employee ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `arc_flash_rating_cal_cm2` SET TAGS ('dbx_business_glossary_term' = 'Arc Flash Rating (cal/cm²)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `avg_jobs_per_shift` SET TAGS ('dbx_business_glossary_term' = 'Average Jobs Per Shift');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('dbx_business_glossary_term' = 'Crew Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `crew_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{3,20}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `crew_name` SET TAGS ('dbx_business_glossary_term' = 'Crew Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `crew_type` SET TAGS ('dbx_business_glossary_term' = 'Crew Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `crew_type` SET TAGS ('dbx_value_regex' = 'electric_line|gas_distribution|metering|substation|transmission|storm_restoration');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `deactivation_date` SET TAGS ('dbx_business_glossary_term' = 'Crew Deactivation Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Crew Effective Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `gas_operator_qualified` SET TAGS ('dbx_business_glossary_term' = 'Gas Operator Qualified Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `gis_region_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Information System (GIS) Region Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `is_emergency_qualified` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Qualified Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `is_mutual_aid_eligible` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `last_safety_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Audit Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `max_travel_radius_miles` SET TAGS ('dbx_business_glossary_term' = 'Maximum Travel Radius (Miles)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Crew Notes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Crew Operational Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|storm_standby|disbanded');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `osha_safety_training_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'OSHA Safety Training Expiry Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `ppe_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `ppe_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `safety_incident_count_ytd` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count Year-to-Date (YTD)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `sap_hr_org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Human Resources (HR) Organizational Unit ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Crew Shift Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|on_call');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `size` SET TAGS ('dbx_business_glossary_term' = 'Crew Size');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `specialty_certifications` SET TAGS ('dbx_business_glossary_term' = 'Crew Specialty Certifications');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `standard_end_time` SET TAGS ('dbx_business_glossary_term' = 'Standard Shift End Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `standard_start_time` SET TAGS ('dbx_business_glossary_term' = 'Standard Shift Start Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `storm_priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Storm Response Priority Tier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Vehicle ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `voltage_class` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class Authorization');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `voltage_class` SET TAGS ('dbx_value_regex' = 'distribution|subtransmission|transmission|low_voltage|gas_only');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `wfm_crew_external_code` SET TAGS ('dbx_business_glossary_term' = 'Workforce Management (WFM) Crew External ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew` ALTER COLUMN `work_function` SET TAGS ('dbx_business_glossary_term' = 'Crew Work Function');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `crew_member_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Member ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `crew_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `crew_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Worker ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `apprentice_program_year` SET TAGS ('dbx_business_glossary_term' = 'Apprentice Program Year');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|storm|training|mutual_aid');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `availability_end_time` SET TAGS ('dbx_business_glossary_term' = 'Availability End Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `availability_start_time` SET TAGS ('dbx_business_glossary_term' = 'Availability Start Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `background_check_date` SET TAGS ('dbx_business_glossary_term' = 'Background Check Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `cdl_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `cdl_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `cdl_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Required Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `cip_access_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Protection (CIP) Access Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `contractor_po_number` SET TAGS ('dbx_business_glossary_term' = 'Contractor Purchase Order (PO) Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `craft_code` SET TAGS ('dbx_business_glossary_term' = 'Craft Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `crew_lead_flag` SET TAGS ('dbx_business_glossary_term' = 'Crew Lead Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `crew_role` SET TAGS ('dbx_business_glossary_term' = 'Crew Role');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `crew_role` SET TAGS ('dbx_value_regex' = 'lead|journeyman|apprentice|helper|foreman|contractor');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `dispatch_zone` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Zone');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `fatigue_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Hours Worked');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `last_safety_briefing_date` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Briefing Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_business_glossary_term' = 'Crew Membership Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `membership_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Device ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `mutual_aid_utility` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Utility Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `nerc_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Qualified Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `osha_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'OSHA Qualified Worker Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `per_diem_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Per Diem Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `ppe_kit_assigned` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Kit Assigned');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `primary_work_center` SET TAGS ('dbx_business_glossary_term' = 'Primary Work Center');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `safety_training_current_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Current Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `scheduled_hours` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ClickSoftware_WFM|SAP_HR|Maximo_EAM|manual');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `union_classification` SET TAGS ('dbx_business_glossary_term' = 'Union Classification');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `union_local_number` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}-[0-9]{1,5}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `vehicle_code` SET TAGS ('dbx_business_glossary_term' = 'Vehicle ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `worker_type` SET TAGS ('dbx_business_glossary_term' = 'Worker Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`crew_member` ALTER COLUMN `worker_type` SET TAGS ('dbx_value_regex' = 'employee|contractor|temporary|seasonal|storm_augment');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `work_order_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Assignment ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `actual_arrival_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `actual_departure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Departure Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Assignment Notes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Assignment Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Assignment Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Assignment Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `assignment_type` SET TAGS ('dbx_value_regex' = 'scheduled|emergency|on_demand|storm_response|preventive_maintenance|corrective_maintenance');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `cancellation_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `certification_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Certification Required Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `customer_appointment_flag` SET TAGS ('dbx_business_glossary_term' = 'Customer Appointment Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `equipment_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Required Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `mobile_acknowledgment_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Acknowledgment Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `mobile_acknowledgment_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `mobile_acknowledgment_flag` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `mobile_acknowledgment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mobile Acknowledgment Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `mobile_acknowledgment_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `mobile_acknowledgment_timestamp` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `on_site_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'On-Site Duration Minutes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `outage_related_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage Related Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|routine');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `reassignment_count` SET TAGS ('dbx_business_glossary_term' = 'Reassignment Count');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `safety_hazard_code` SET TAGS ('dbx_business_glossary_term' = 'Safety Hazard Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `skill_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Skill Requirement Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'clicksoftware|maximo|poweron|sap_pm|manual');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `storm_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Storm Response Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Travel Time Minutes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `work_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Work Duration Minutes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `work_location_address` SET TAGS ('dbx_business_glossary_term' = 'Work Location Address');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `work_location_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `work_location_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `work_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Work Location Latitude');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `work_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `work_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `work_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Work Location Longitude');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `work_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`work_order_assignment` ALTER COLUMN `work_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` SET TAGS ('dbx_subdomain' = 'workforce_scheduling');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'Shift Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `call_out_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Call-Out Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `consecutive_shift_limit` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Shift Limit');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `crew_size_maximum` SET TAGS ('dbx_business_glossary_term' = 'Maximum Crew Size');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `crew_size_minimum` SET TAGS ('dbx_business_glossary_term' = 'Minimum Crew Size');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration in Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `emergency_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `fatigue_risk_score` SET TAGS ('dbx_business_glossary_term' = 'Fatigue Risk Score');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `geographic_service_area` SET TAGS ('dbx_business_glossary_term' = 'Geographic Service Area');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `hazard_level` SET TAGS ('dbx_business_glossary_term' = 'Hazard Level');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `hazard_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `holiday_work_flag` SET TAGS ('dbx_business_glossary_term' = 'Holiday Work Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `minimum_rest_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Rest Hours Between Shifts');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Shift Notes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `overtime_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime Threshold in Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `paid_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Paid Break Duration in Minutes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment (PPE) Requirements');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `premium_pay_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Premium Pay Multiplier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `qualification_requirement_codes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Requirement Codes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `reporting_location` SET TAGS ('dbx_business_glossary_term' = 'Reporting Location');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `rotation_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Rotation Cycle Duration in Days');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `rotation_pattern` SET TAGS ('dbx_business_glossary_term' = 'Rotation Pattern');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `scheduling_priority` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Priority');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `shift_category` SET TAGS ('dbx_business_glossary_term' = 'Shift Category');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `shift_category` SET TAGS ('dbx_value_regex' = 'regular|emergency|storm|maintenance|construction|inspection');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `shift_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `shift_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `shift_name` SET TAGS ('dbx_business_glossary_term' = 'Shift Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_business_glossary_term' = 'Shift Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `shift_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|archived');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_business_glossary_term' = 'Shift Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `shift_type` SET TAGS ('dbx_value_regex' = 'day|evening|night|rotating|on_call|standby');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `unpaid_break_minutes` SET TAGS ('dbx_business_glossary_term' = 'Unpaid Break Duration in Minutes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `weekend_work_flag` SET TAGS ('dbx_business_glossary_term' = 'Weekend Work Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`shift` ALTER COLUMN `work_order_type_default` SET TAGS ('dbx_business_glossary_term' = 'Default Work Order Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` SET TAGS ('dbx_subdomain' = 'workforce_scheduling');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Schedule ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Work Location ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Modified By User ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Der Resource Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `work_order_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Work Assignment ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `break_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Break Duration Minutes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `certification_required` SET TAGS ('dbx_business_glossary_term' = 'Certification Required');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `confirmed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmed Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `consecutive_days_worked` SET TAGS ('dbx_business_glossary_term' = 'Consecutive Days Worked');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule End Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Device ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{10,20}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `mutual_assistance_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutual Assistance Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Schedule Notes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `on_call_flag` SET TAGS ('dbx_business_glossary_term' = 'On-Call Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `optimization_score` SET TAGS ('dbx_business_glossary_term' = 'Schedule Optimization Score');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `overtime_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `planning_horizon` SET TAGS ('dbx_value_regex' = 'daily|weekly|monthly|quarterly');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `published_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Published Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `rest_period_hours` SET TAGS ('dbx_business_glossary_term' = 'Rest Period Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_value_regex' = '^SCH-[0-9]{8}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `schedule_status` SET TAGS ('dbx_value_regex' = 'draft|published|confirmed|in_progress|completed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'regular|on_call|emergency|storm_response|planned_outage|training');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `shift_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Shift Duration Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `shift_pattern_code` SET TAGS ('dbx_business_glossary_term' = 'Shift Pattern Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `shift_pattern_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `skill_requirement_code` SET TAGS ('dbx_business_glossary_term' = 'Skill Requirement Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `skill_requirement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_]{2,20}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'CLICKSOFTWARE|SAP_HR|MAXIMO|MANUAL');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Schedule Start Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `storm_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Storm Response Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `travel_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Travel Time Minutes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`schedule` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9.-]{6,24}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` SET TAGS ('dbx_subdomain' = 'workforce_scheduling');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `time_entry_id` SET TAGS ('dbx_business_glossary_term' = 'Time Entry ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `approving_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving User ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `approving_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `approving_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Supervisor ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Der Resource Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Event ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `tertiary_time_approving_user_technician_id` SET TAGS ('dbx_business_glossary_term' = 'Approving User ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order (WO) ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `authorization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Authorization Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Comments');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `emergency_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `estimated_hours` SET TAGS ('dbx_business_glossary_term' = 'Estimated Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Account Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `ferc_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{3,6}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `geographic_location_code` SET TAGS ('dbx_business_glossary_term' = 'Geographic Location Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `geographic_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Latitude');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `gps_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_business_glossary_term' = 'Global Positioning System (GPS) Longitude');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `gps_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_classification` SET TAGS ('dbx_business_glossary_term' = 'Labor Cost Classification');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `labor_cost_classification` SET TAGS ('dbx_value_regex' = 'capex|opex|maintenance|construction|emergency|storm');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `mobile_capture_flag` SET TAGS ('dbx_business_glossary_term' = 'Mobile Capture Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `mobile_capture_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `mobile_capture_flag` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `on_call_hours` SET TAGS ('dbx_business_glossary_term' = 'On-Call Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `overtime_authorization_required` SET TAGS ('dbx_business_glossary_term' = 'Overtime Authorization Required Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `overtime_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Overtime Authorization Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `overtime_authorization_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|denied|retroactive');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `pay_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `pay_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `payroll_period` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `payroll_period` SET TAGS ('dbx_value_regex' = '^[0-9]{4}-(0[1-9]|1[0-2])-(W[1-5]|P[0-9]{2})$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `payroll_posting_date` SET TAGS ('dbx_business_glossary_term' = 'Payroll Posting Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Shift End Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Shift Start Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'clicksoftware|sap_hr|maximo|manual');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `standby_hours` SET TAGS ('dbx_business_glossary_term' = 'Standby Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `time_entry_number` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `time_entry_number` SET TAGS ('dbx_value_regex' = '^TE-[0-9]{10}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `time_entry_status` SET TAGS ('dbx_business_glossary_term' = 'Time Entry Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `time_entry_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|posted|cancelled');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `time_type` SET TAGS ('dbx_business_glossary_term' = 'Time Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `time_type` SET TAGS ('dbx_value_regex' = 'productive|non_productive|indirect|administrative|training');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `total_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `travel_hours` SET TAGS ('dbx_business_glossary_term' = 'Travel Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `work_activity_code` SET TAGS ('dbx_business_glossary_term' = 'Work Activity Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `work_activity_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`time_entry` ALTER COLUMN `work_date` SET TAGS ('dbx_business_glossary_term' = 'Work Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` SET TAGS ('dbx_subdomain' = 'labor_management');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `superseded_by_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Qualification ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `cost_per_worker_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Worker (USD)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `cost_per_worker_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'End Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `examination_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Examination Required Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `external_training_provider` SET TAGS ('dbx_business_glossary_term' = 'External Training Provider');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `internal_training_available_flag` SET TAGS ('dbx_business_glossary_term' = 'Internal Training Available Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `issuing_authority_type` SET TAGS ('dbx_business_glossary_term' = 'Issuing Authority Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `issuing_authority_type` SET TAGS ('dbx_value_regex' = 'government|industry_association|internal|third_party_certifier|professional_body');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `job_role_applicability` SET TAGS ('dbx_business_glossary_term' = 'Job Role Applicability');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `minimum_experience_months` SET TAGS ('dbx_business_glossary_term' = 'Minimum Experience (Months)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `nerc_cip_required_flag` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP (Critical Infrastructure Protection) Required Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `practical_demonstration_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Practical Demonstration Required Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `prerequisite_qualifications` SET TAGS ('dbx_business_glossary_term' = 'Prerequisite Qualifications');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `qualification_category` SET TAGS ('dbx_business_glossary_term' = 'Qualification Category');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `qualification_category` SET TAGS ('dbx_value_regex' = 'safety|technical|operational|regulatory|leadership|specialized');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `qualification_code` SET TAGS ('dbx_business_glossary_term' = 'Qualification Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `qualification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,20}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `qualification_description` SET TAGS ('dbx_business_glossary_term' = 'Qualification Description');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|under_review|pending_approval|suspended');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'license|certification|training|competency|authorization|permit');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `regulatory_authority` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Authority');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `regulatory_mandate_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `renewal_method` SET TAGS ('dbx_business_glossary_term' = 'Renewal Method');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `renewal_method` SET TAGS ('dbx_value_regex' = 'retraining|examination|continuing_education|demonstration|administrative_review|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `renewal_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `safety_critical_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Critical Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `training_duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration (Hours)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `union_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Reference');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Validity Period (Months)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `version_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,3}(.[0-9]{1,3}){0,2}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`qualification` ALTER COLUMN `work_type_applicability` SET TAGS ('dbx_business_glossary_term' = 'Work Type Applicability');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` SET TAGS ('dbx_subdomain' = 'labor_management');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `technician_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Qualification ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Assessment Score');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Certificate Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `certifying_body` SET TAGS ('dbx_business_glossary_term' = 'Certifying Body');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'current|expiring_soon|expired|suspended|revoked|pending_verification');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `continuing_education_credits` SET TAGS ('dbx_business_glossary_term' = 'Continuing Education Credits');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Qualification Cost Amount');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `cost_currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `dispatch_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Eligibility Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Documentation URL');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Effective Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `equipment_authorization` SET TAGS ('dbx_business_glossary_term' = 'Equipment Authorization');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'company|employee|grant|union|vendor');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `instructor_name` SET TAGS ('dbx_business_glossary_term' = 'Instructor Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Is Active Record');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Issue Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `last_renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Last Qualification Renewal Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `next_renewal_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Renewal Due Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Notes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `passing_score_threshold` SET TAGS ('dbx_business_glossary_term' = 'Passing Score Threshold');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_business_glossary_term' = 'Proficiency Level');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `proficiency_level` SET TAGS ('dbx_value_regex' = 'basic|intermediate|advanced|expert|master');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `qualification_category` SET TAGS ('dbx_business_glossary_term' = 'Qualification Category');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `qualification_category` SET TAGS ('dbx_value_regex' = 'safety|technical|regulatory|operational|leadership|specialized_equipment');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `qualification_code` SET TAGS ('dbx_business_glossary_term' = 'Qualification Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `qualification_name` SET TAGS ('dbx_business_glossary_term' = 'Qualification Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'certification|license|training|operator_qualification|safety_credential|technical_skill');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `regulatory_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `renewal_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `renewal_notification_sent_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notification Sent Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `training_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `training_hours` SET TAGS ('dbx_business_glossary_term' = 'Training Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `training_location` SET TAGS ('dbx_business_glossary_term' = 'Training Location');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `training_provider` SET TAGS ('dbx_business_glossary_term' = 'Training Provider');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `union_requirement_flag` SET TAGS ('dbx_business_glossary_term' = 'Union Requirement Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Verification Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `verified_by` SET TAGS ('dbx_business_glossary_term' = 'Verified By');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`technician_qualification` ALTER COLUMN `work_type_authorization` SET TAGS ('dbx_business_glossary_term' = 'Work Type Authorization');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` SET TAGS ('dbx_subdomain' = 'labor_management');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `agreement_name` SET TAGS ('dbx_business_glossary_term' = 'Agreement Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_value_regex' = '^CBA-[A-Z0-9]{6,12}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'master|local|supplemental|project|interim');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `arbitration_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Arbitration Provision Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `bargaining_unit` SET TAGS ('dbx_business_glossary_term' = 'Bargaining Unit');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `base_wage_increase_pct` SET TAGS ('dbx_business_glossary_term' = 'Base Wage Increase Percentage');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `base_wage_increase_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `callout_minimum_hours` SET TAGS ('dbx_business_glossary_term' = 'Call-Out Minimum Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `callout_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Call-Out Response Time Minutes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `covered_employee_count` SET TAGS ('dbx_business_glossary_term' = 'Covered Employee Count');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `document_reference_url` SET TAGS ('dbx_business_glossary_term' = 'Document Reference Uniform Resource Locator (URL)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `document_reference_url` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `dues_checkoff_flag` SET TAGS ('dbx_business_glossary_term' = 'Dues Check-Off Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `grievance_procedure_steps` SET TAGS ('dbx_business_glossary_term' = 'Grievance Procedure Steps');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `health_benefits_summary` SET TAGS ('dbx_business_glossary_term' = 'Health Benefits Summary');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `health_benefits_summary` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `jurisdiction_description` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Description');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `layoff_recall_provisions` SET TAGS ('dbx_business_glossary_term' = 'Layoff and Recall Provisions');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `management_rights_clause` SET TAGS ('dbx_business_glossary_term' = 'Management Rights Clause');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `negotiating_team_lead` SET TAGS ('dbx_business_glossary_term' = 'Negotiating Team Lead');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `negotiation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation End Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `negotiation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Negotiation Start Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `no_strike_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'No-Strike Clause Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Multiplier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `overtime_threshold_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Threshold Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `pension_contribution_pct` SET TAGS ('dbx_business_glossary_term' = 'Pension Contribution Percentage');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `pension_contribution_pct` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `ratification_date` SET TAGS ('dbx_business_glossary_term' = 'Ratification Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `safety_training_requirements` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Requirements');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `seniority_rules` SET TAGS ('dbx_business_glossary_term' = 'Seniority Rules');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `shift_differential_pct` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Percentage');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `sick_leave_accrual_rate` SET TAGS ('dbx_business_glossary_term' = 'Sick Leave Accrual Rate');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `storm_pay_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Storm Pay Multiplier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `storm_pay_trigger_conditions` SET TAGS ('dbx_business_glossary_term' = 'Storm Pay Trigger Conditions');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `subcontracting_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Subcontracting Restrictions');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `union_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `union_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|active|expired|terminated|under_negotiation|ratified');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `union_name` SET TAGS ('dbx_business_glossary_term' = 'Union Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `union_representative_name` SET TAGS ('dbx_business_glossary_term' = 'Union Representative Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `union_security_clause` SET TAGS ('dbx_business_glossary_term' = 'Union Security Clause');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `union_security_clause` SET TAGS ('dbx_value_regex' = 'open_shop|union_shop|agency_shop|closed_shop|right_to_work');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `vacation_accrual_rate` SET TAGS ('dbx_business_glossary_term' = 'Vacation Accrual Rate');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `wage_scale_structure` SET TAGS ('dbx_business_glossary_term' = 'Wage Scale Structure');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `wage_scale_structure` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`union_agreement` ALTER COLUMN `work_rules_summary` SET TAGS ('dbx_business_glossary_term' = 'Work Rules Summary');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` SET TAGS ('dbx_subdomain' = 'labor_management');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `labor_rate_id` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `union_agreement_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `burden_percentage` SET TAGS ('dbx_business_glossary_term' = 'Labor Burden Percentage');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) / Operating Expenditure (OPEX) Indicator');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `capex_opex_indicator` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX|both');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `cost_center_default` SET TAGS ('dbx_business_glossary_term' = 'Default Cost Center');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `cost_center_default` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `craft_classification_code` SET TAGS ('dbx_business_glossary_term' = 'Craft Classification Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `craft_classification_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `craft_classification_name` SET TAGS ('dbx_business_glossary_term' = 'Craft Classification Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `double_time_rate` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hourly Rate');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `employee_class` SET TAGS ('dbx_business_glossary_term' = 'Employee Class');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `employee_class` SET TAGS ('dbx_value_regex' = 'field|office|technical|supervisory|executive');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `flsa_status` SET TAGS ('dbx_business_glossary_term' = 'Fair Labor Standards Act (FLSA) Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `flsa_status` SET TAGS ('dbx_value_regex' = 'exempt|non-exempt');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `gl_account_default` SET TAGS ('dbx_business_glossary_term' = 'Default General Ledger (GL) Account');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `gl_account_default` SET TAGS ('dbx_value_regex' = '^[0-9]{6,10}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By User');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rate Notes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `on_call_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Call Standby Rate');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `overhead_percentage` SET TAGS ('dbx_business_glossary_term' = 'Overhead Allocation Percentage');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `overtime_rate` SET TAGS ('dbx_business_glossary_term' = 'Overtime Hourly Rate');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `pay_grade` SET TAGS ('dbx_business_glossary_term' = 'Pay Grade');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `pay_grade` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,6}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `rate_approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Rate Approval Authority');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `rate_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Rate Approval Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_business_glossary_term' = 'Rate Source');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `rate_source` SET TAGS ('dbx_value_regex' = 'union_cba|company_policy|market_survey|contractor_agreement|regulatory_mandate');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `rate_status` SET TAGS ('dbx_value_regex' = 'active|pending|expired|superseded|suspended');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Labor Rate Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'union|non-union|contractor|temporary|apprentice|management');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `shift_differential_rate` SET TAGS ('dbx_business_glossary_term' = 'Shift Differential Rate');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `storm_emergency_rate` SET TAGS ('dbx_business_glossary_term' = 'Storm Emergency Premium Rate');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `straight_time_rate` SET TAGS ('dbx_business_glossary_term' = 'Straight Time Hourly Rate');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `work_location_type` SET TAGS ('dbx_business_glossary_term' = 'Work Location Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `work_location_type` SET TAGS ('dbx_value_regex' = 'field|office|hybrid|remote');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`labor_rate` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By User');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` SET TAGS ('dbx_subdomain' = 'labor_management');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `absence_id` SET TAGS ('dbx_business_glossary_term' = 'Absence ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `absence_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `absence_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `absence_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `absence_replacement_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Employee ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `absence_replacement_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `absence_replacement_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Replacement Employee ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `absence_technician_id` SET TAGS ('dbx_business_glossary_term' = 'Employee ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `approver_technician_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Employee ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `absence_category` SET TAGS ('dbx_business_glossary_term' = 'Absence Category');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `absence_category` SET TAGS ('dbx_value_regex' = 'planned|unplanned|emergency');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `accrual_deduction_hours` SET TAGS ('dbx_business_glossary_term' = 'Accrual Deduction Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Approval Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Absence Approval Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|cancelled|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `duration_days` SET TAGS ('dbx_business_glossary_term' = 'Absence Duration in Days');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `duration_hours` SET TAGS ('dbx_business_glossary_term' = 'Absence Duration in Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Absence End Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_business_glossary_term' = 'Family Medical Leave Act (FMLA) Case Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_value_regex' = '^FMLA-[0-9]{6,12}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `fmla_case_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `impact_on_crew_coverage` SET TAGS ('dbx_business_glossary_term' = 'Impact on Crew Coverage');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `impact_on_crew_coverage` SET TAGS ('dbx_value_regex' = 'none|low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `intermittent_leave_flag` SET TAGS ('dbx_business_glossary_term' = 'Intermittent Leave Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `medical_certification_date` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `medical_certification_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Certification Received Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `medical_certification_received_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `medical_certification_received_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `notification_method` SET TAGS ('dbx_business_glossary_term' = 'Absence Notification Method');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `notification_method` SET TAGS ('dbx_value_regex' = 'phone|email|mobile_app|supervisor_direct|emergency_contact');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Absence Notification Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `paid_flag` SET TAGS ('dbx_business_glossary_term' = 'Paid Absence Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `payroll_processed_flag` SET TAGS ('dbx_business_glossary_term' = 'Payroll Processed Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Absence Reason Description');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `replacement_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Replacement Required Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `return_to_work_clearance_flag` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Clearance Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `return_to_work_date` SET TAGS ('dbx_business_glossary_term' = 'Return to Work Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `scheduled_shift_end_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift End Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `scheduled_shift_start_time` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Shift Start Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'SAP_HR|CLICKSOFTWARE|ESS|MANUAL');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `source_system_record_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Absence Start Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `storm_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Storm Response Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Absence Submission Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `type_code` SET TAGS ('dbx_business_glossary_term' = 'Absence Type Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `type_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `type_name` SET TAGS ('dbx_business_glossary_term' = 'Absence Type Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `union_code` SET TAGS ('dbx_business_glossary_term' = 'Union Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `union_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,6}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `work_center_code` SET TAGS ('dbx_business_glossary_term' = 'Work Center Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `work_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_business_glossary_term' = 'Workers Compensation Claim Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_value_regex' = '^WC-[0-9]{6,12}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`absence` ALTER COLUMN `workers_comp_claim_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` SET TAGS ('dbx_subdomain' = 'storm_response');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Commander Employee Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Commander Employee Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `actual_restoration_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Restoration Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `actual_restoration_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `actual_restoration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Restoration Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `affected_customer_count` SET TAGS ('dbx_business_glossary_term' = 'Affected Customer Count');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `affected_service_territory` SET TAGS ('dbx_business_glossary_term' = 'Affected Service Territory');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `closure_notes` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Closure Notes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Closure Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `contractor_crew_count` SET TAGS ('dbx_business_glossary_term' = 'Contractor Crew Count');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `damage_assessment_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Assessment Completed Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `damage_assessment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Damage Assessment Completion Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `declaration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Storm Declaration Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `emergency_operations_center_location` SET TAGS ('dbx_business_glossary_term' = 'Emergency Operations Center (EOC) Location');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `estimated_restoration_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Restoration Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `estimated_restoration_cost_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `estimated_restoration_time` SET TAGS ('dbx_business_glossary_term' = 'Estimated Restoration Time (ERT)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `fema_declaration_flag` SET TAGS ('dbx_business_glossary_term' = 'Federal Emergency Management Agency (FEMA) Declaration Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `fema_declaration_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Emergency Management Agency (FEMA) Declaration Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `fema_declaration_number` SET TAGS ('dbx_value_regex' = '^(DR|EM|FM|FS)-[0-9]{4,5}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `incident_command_activated_flag` SET TAGS ('dbx_business_glossary_term' = 'Incident Command System (ICS) Activated Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `internal_crew_count` SET TAGS ('dbx_business_glossary_term' = 'Internal Crew Count');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `media_inquiries_count` SET TAGS ('dbx_business_glossary_term' = 'Media Inquiries Count');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `mutual_aid_activated_flag` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Activated Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `mutual_aid_crew_count` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Crew Count');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `oms_event_external_code` SET TAGS ('dbx_business_glossary_term' = 'Outage Management System (OMS) Event External Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `peak_outage_count` SET TAGS ('dbx_business_glossary_term' = 'Peak Outage Count');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `public_communications_issued_count` SET TAGS ('dbx_business_glossary_term' = 'Public Communications Issued Count');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `regulatory_report_due_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Due Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `regulatory_report_submitted_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Submitted Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `saidi_exclusion_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'System Average Interruption Duration Index (SAIDI) Exclusion Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `saifi_exclusion_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'System Average Interruption Frequency Index (SAIFI) Exclusion Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `state_emergency_declaration_flag` SET TAGS ('dbx_business_glossary_term' = 'State Emergency Declaration Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `storm_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Storm End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `storm_event_code` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `storm_event_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,20}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `storm_name` SET TAGS ('dbx_business_glossary_term' = 'Storm Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `storm_severity_level` SET TAGS ('dbx_business_glossary_term' = 'Storm Severity Level');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `storm_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Storm Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `storm_status` SET TAGS ('dbx_business_glossary_term' = 'Storm Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `storm_status` SET TAGS ('dbx_value_regex' = 'declared|active|restoration|demobilization|closed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `storm_type` SET TAGS ('dbx_business_glossary_term' = 'Storm Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `total_crew_hours` SET TAGS ('dbx_business_glossary_term' = 'Total Crew Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `weather_forecast_source` SET TAGS ('dbx_business_glossary_term' = 'Weather Forecast Source');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_event` ALTER COLUMN `wfm_storm_event_external_code` SET TAGS ('dbx_business_glossary_term' = 'Workforce Management (WFM) Storm Event External Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` SET TAGS ('dbx_subdomain' = 'storm_response');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `storm_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Assignment Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Depot Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `actual_total_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Total Cost');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `actual_total_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `assignment_notes` SET TAGS ('dbx_business_glossary_term' = 'Storm Assignment Notes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_business_glossary_term' = 'Storm Assignment Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `assignment_number` SET TAGS ('dbx_value_regex' = '^SA-[0-9]{10}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `assignment_role` SET TAGS ('dbx_business_glossary_term' = 'Storm Assignment Role');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Storm Assignment Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `assignment_status` SET TAGS ('dbx_value_regex' = 'assigned|mobilized|active|demobilized|completed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `demobilization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Demobilization Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `dispatch_zone_code` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Zone Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `double_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Double Time Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `estimated_daily_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Daily Cost');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `estimated_daily_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `is_mutual_aid_crew` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Crew Indicator');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `lodging_location` SET TAGS ('dbx_business_glossary_term' = 'Lodging Location');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `lodging_provided` SET TAGS ('dbx_business_glossary_term' = 'Lodging Provided Indicator');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `meals_provided_count` SET TAGS ('dbx_business_glossary_term' = 'Meals Provided Count');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `mobilization_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Mobilization Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `mutual_aid_crew_size` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Crew Size');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `mutual_aid_equipment_description` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Equipment Description');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `originating_utility_code` SET TAGS ('dbx_business_glossary_term' = 'Originating Utility Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `originating_utility_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,6}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `originating_utility_name` SET TAGS ('dbx_business_glossary_term' = 'Originating Utility Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `overtime_hours` SET TAGS ('dbx_business_glossary_term' = 'Overtime (OT) Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Assignment Priority Level');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `regular_hours` SET TAGS ('dbx_business_glossary_term' = 'Regular Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `reporting_depot_code` SET TAGS ('dbx_business_glossary_term' = 'Reporting Depot Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `safety_incident_description` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Description');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `safety_incident_description` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `safety_incident_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Flag');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `sap_hr_assignment_code` SET TAGS ('dbx_business_glossary_term' = 'SAP Human Resources (HR) Assignment Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `storm_pay_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Storm Pay Multiplier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `storm_pay_multiplier` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `total_hours_worked` SET TAGS ('dbx_business_glossary_term' = 'Total Hours Worked');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_assignment` ALTER COLUMN `wfm_assignment_external_code` SET TAGS ('dbx_business_glossary_term' = 'Workforce Management (WFM) Assignment External Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` SET TAGS ('dbx_subdomain' = 'workforce_scheduling');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `on_call_rotation_id` SET TAGS ('dbx_business_glossary_term' = 'On-Call Rotation ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `dispatch_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Zone ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `shift_id` SET TAGS ('dbx_business_glossary_term' = 'SAP Human Resources (HR) Shift ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `actual_callouts_count` SET TAGS ('dbx_business_glossary_term' = 'Actual Callouts Count');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `avg_response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Average Response Time Minutes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `backup_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Backup Contact Phone Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `backup_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `backup_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `callout_minimum_hours` SET TAGS ('dbx_business_glossary_term' = 'Callout Minimum Hours');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `callout_radius_miles` SET TAGS ('dbx_business_glossary_term' = 'Callout Radius Miles');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `cdl_required` SET TAGS ('dbx_business_glossary_term' = 'Commercial Driver License (CDL) Required');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `clicksoftware_rotation_code` SET TAGS ('dbx_business_glossary_term' = 'ClickSoftware Rotation ID');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `dispatch_center_code` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Center Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `emergency_type_coverage` SET TAGS ('dbx_business_glossary_term' = 'Emergency Type Coverage');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `gas_operator_qualified_required` SET TAGS ('dbx_business_glossary_term' = 'Gas Operator Qualified Required');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `mutual_aid_eligible` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Eligible');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `nerc_cip_required` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Critical Infrastructure Protection (CIP) Required');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rotation Notes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `on_call_pay_provision` SET TAGS ('dbx_business_glossary_term' = 'On-Call Pay Provision');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `on_call_pay_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Call Pay Rate');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `on_call_pay_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `osha_qualification_required` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Qualification Required');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `overtime_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Overtime Multiplier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `priority_tier` SET TAGS ('dbx_business_glossary_term' = 'Priority Tier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `priority_tier` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|escalation');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `response_time_sla_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Time Service Level Agreement (SLA) Minutes');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `rotation_end_datetime` SET TAGS ('dbx_business_glossary_term' = 'Rotation End Date and Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `rotation_name` SET TAGS ('dbx_business_glossary_term' = 'Rotation Name');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `rotation_start_datetime` SET TAGS ('dbx_business_glossary_term' = 'Rotation Start Date and Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `rotation_status` SET TAGS ('dbx_business_glossary_term' = 'Rotation Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `rotation_status` SET TAGS ('dbx_value_regex' = 'scheduled|active|completed|cancelled|suspended');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `rotation_type` SET TAGS ('dbx_business_glossary_term' = 'Rotation Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `rotation_type` SET TAGS ('dbx_value_regex' = 'weekly|bi-weekly|monthly|daily|custom');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'outage_restoration|gas_leak_response|downed_wire|emergency_dispatch|storm_response|after_hours_service');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `sla_compliance_rate` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Rate');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `storm_response_eligible` SET TAGS ('dbx_business_glossary_term' = 'Storm Response Eligible');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `union_agreement_code` SET TAGS ('dbx_business_glossary_term' = 'Union Agreement Code');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`on_call_rotation` ALTER COLUMN `voltage_class_coverage` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class Coverage');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` SET TAGS ('dbx_subdomain' = 'labor_management');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Supervisor Employee ID (SUPV_ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `supervisor_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `manager_employee_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Employee Address Line 1 (ADDRESS_LINE1)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `availability_status` SET TAGS ('dbx_business_glossary_term' = 'Availability Status (AVAIL_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `availability_status` SET TAGS ('dbx_value_regex' = 'available|unavailable|on_call');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `birth_date` SET TAGS ('dbx_business_glossary_term' = 'Birth Date (DOB)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `birth_date` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `birth_date` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `cdl_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'CDL Expiration Date (CDL_EXP)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `cdl_license_class` SET TAGS ('dbx_business_glossary_term' = 'CDL License Class (CDL_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Employee City (CITY)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `clicksoftware_resource_code` SET TAGS ('dbx_business_glossary_term' = 'ClickSoftware Resource ID (CS_RES_ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CENTER)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Employee Country Code (COUNTRY_CODE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `craft_type` SET TAGS ('dbx_business_glossary_term' = 'Craft Type (CRAFT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `craft_type` SET TAGS ('dbx_value_regex' = 'lineworker|meter_reader|technician|engineer|dispatcher');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code (DEPT_CODE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Employee Email Address (EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `employee_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Number (EMP_NUM)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `employee_status` SET TAGS ('dbx_business_glossary_term' = 'Employee Status (EMP_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `employee_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|retired|on_leave');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `employee_type` SET TAGS ('dbx_business_glossary_term' = 'Employee Type (EMP_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `employee_type` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temporary|seasonal');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status (EMPLOY_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `employment_status` SET TAGS ('dbx_value_regex' = 'employed|terminated|retired|leave_of_absence');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_business_glossary_term' = 'Employment Type (EMPLOY_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `employment_type` SET TAGS ('dbx_value_regex' = 'permanent|temporary|contract');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'Employee First Name (FIRST_NAME)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Full Name (FULL_NAME)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `gender_code` SET TAGS ('dbx_business_glossary_term' = 'Gender Code (GENDER)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `gender_code` SET TAGS ('dbx_value_regex' = 'M|F|X|U');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `gender_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `gender_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date (HIRE_DATE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_business_glossary_term' = 'Hourly Rate (HR_RATE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `hourly_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `job_title` SET TAGS ('dbx_business_glossary_term' = 'Job Title (JOB_TITLE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Employee Last Name (LAST_NAME)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `last_safety_training_date` SET TAGS ('dbx_business_glossary_term' = 'Last Safety Training Date (LAST_SAFETY_TRAIN)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code (LOC_CODE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_business_glossary_term' = 'Mobile Device ID (MOBILE_DEV_ID)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `mobile_device_code` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Modified Timestamp (MODIFIED_TS)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `org_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Organizational Unit Code (ORG_UNIT)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `osha_qualified` SET TAGS ('dbx_business_glossary_term' = 'OSHA Qualified (OSHA_QUAL)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `overtime_eligible` SET TAGS ('dbx_business_glossary_term' = 'Overtime Eligible (OT_ELIGIBLE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `pay_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Pay Currency Code (PAY_CURR)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `pay_currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Employee Phone Number (PHONE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Employee Postal Code (POSTAL_CODE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count (SAFETY_INC_COUNT)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `sap_personnel_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Personnel Number (SAP_PER_NUM)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_business_glossary_term' = 'Social Security Number (SSN)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `social_security_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Employee State/Province (STATE_PROVINCE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TERM_DATE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERM_REASON)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `union_affiliation_code` SET TAGS ('dbx_business_glossary_term' = 'Union Affiliation Code (UNION_CODE)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`employee` ALTER COLUMN `union_local_number` SET TAGS ('dbx_business_glossary_term' = 'Union Local Number (UNION_LOCAL)');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`line_crew_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`line_crew_assignment` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`line_crew_assignment` SET TAGS ('dbx_association_edges' = 'transmission.line,workforce.crew');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`line_crew_assignment` ALTER COLUMN `line_crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Linecrewassignment - Line Crew Assignment Id');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`line_crew_assignment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Linecrewassignment - Crew Id');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`line_crew_assignment` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Linecrewassignment - Transmission Line Id');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`line_crew_assignment` ALTER COLUMN `assignment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`line_crew_assignment` ALTER COLUMN `assignment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`line_crew_assignment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Crew Role');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` SET TAGS ('dbx_association_edges' = 'asset.registry,workforce.technician');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` ALTER COLUMN `asset_technician_authorization_id` SET TAGS ('dbx_business_glossary_term' = 'Assettechnicianauthorization - Asset Technician Authorization Id');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Assettechnicianauthorization - Asset Registry Id');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Assettechnicianauthorization - Technician Id');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` ALTER COLUMN `asset_technician_authorization_status` SET TAGS ('dbx_business_glossary_term' = 'Authorization Status');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` ALTER COLUMN `authorization_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`asset_technician_authorization` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Expiration');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_parcel_impact` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_parcel_impact` SET TAGS ('dbx_subdomain' = 'storm_response');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_parcel_impact` SET TAGS ('dbx_association_edges' = 'workforce.storm_event,property.parcel');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_parcel_impact` ALTER COLUMN `storm_parcel_impact_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Parcel Impact - Storm Parcel Impact Id');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_parcel_impact` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Parcel Impact - Parcel Id');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_parcel_impact` ALTER COLUMN `storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Parcel Impact - Storm Event Id');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_parcel_impact` ALTER COLUMN `actual_restoration_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Restoration Timestamp');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_parcel_impact` ALTER COLUMN `damage_assessment_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Damage Assessment Completed');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`storm_parcel_impact` ALTER COLUMN `estimated_restoration_time` SET TAGS ('dbx_business_glossary_term' = 'Estimated Restoration Time');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`payroll_period` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`payroll_period` SET TAGS ('dbx_subdomain' = 'labor_management');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`payroll_period` ALTER COLUMN `payroll_period_id` SET TAGS ('dbx_business_glossary_term' = 'Payroll Period Identifier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`payroll_period` ALTER COLUMN `prior_payroll_period_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`vehicle` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`vehicle` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`vehicle` ALTER COLUMN `vehicle_id` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`vehicle` ALTER COLUMN `replaced_vehicle_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`vehicle` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`dispatch_zone` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`dispatch_zone` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`dispatch_zone` ALTER COLUMN `dispatch_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Zone Identifier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`dispatch_zone` ALTER COLUMN `parent_dispatch_zone_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` SET TAGS ('dbx_subdomain' = 'crew_operations');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `depot_id` SET TAGS ('dbx_business_glossary_term' = 'Depot Identifier');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `parent_depot_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`workforce`.`depot` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
