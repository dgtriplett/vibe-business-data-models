-- Schema for Domain: safety | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`safety` COMMENT 'Manages occupational safety programs, environmental health, incident reporting, hazardous material handling, and environmental compliance across all utility operations. Tracks OSHA recordable incidents, near-misses, safety audits, PPE compliance, PSC safety audits, EPA emissions reporting, PHMSA pipeline integrity management, and CIP compliance. Supports safety culture metrics and corrective action tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`incident` (
    `incident_id` BIGINT COMMENT 'System-generated unique identifier for the safety incident record.',
    `asset_permit_compliance_document_id` BIGINT COMMENT 'Reference to the compliance document associated with the incident.',
    `registry_id` BIGINT COMMENT 'Identifier of the asset (equipment, facility, vehicle) associated with the incident.',
    `asset_risk_risk_assessment_id` BIGINT COMMENT 'Reference to the risk assessment record linked to the incident.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Regulatory incident cost recovery requires linking each incident to the customers billing account to generate fines or service credits on the next bill.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Incident Impact Reporting requires linking each incident to the affected customer account for regulatory and service‑impact analysis.',
    `compliance_document_id` BIGINT COMMENT 'Reference to the compliance document associated with the incident.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Incidents often generate compliance obligations; FK supports tracking obligations arising from specific incidents.',
    `contractor_vendor_id` BIGINT COMMENT 'Identifier of the contractor (if any) involved in the incident.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Regulatory incident cost allocation report requires charging each incident to a cost center for financial impact analysis.',
    `distribution_service_point_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_service_point. Business justification: Incidents at the customer interface are recorded against the service point to enable root‑cause analysis and customer impact reporting.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Regulatory dockets capture the formal proceeding for incident investigations; linking ties incident to its docket.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Facility safety performance metrics depend on linking each incident to the specific substation or plant where it occurred.',
    `feeder_id` BIGINT COMMENT 'Foreign key linking to distribution.feeder. Business justification: Feeder‑level incidents (e.g., vegetation contact) are linked to the feeder asset for outage management and reliability metrics.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Regulatory filing is required to report major incidents; linking incident to filing enables incident reporting workflow.',
    `generating_unit_id` BIGINT COMMENT 'Foreign key linking to generation.generating_unit. Business justification: Unit‑level incident tracking enables root‑cause analysis and reliability reporting for each generator.',
    `location_id` BIGINT COMMENT 'Reference to the geographic location or site where the incident occurred.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Incident investigation report requires linking the incident to the specific meter that failed, enabling root‑cause analysis and regulatory reporting.',
    `ot_asset_id` BIGINT COMMENT 'Identifier of the asset (equipment, facility, vehicle) associated with the incident.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Regulatory incident reporting requires identifying the land parcel of the event for OSHA and environmental compliance; utilities track incidents per parcel.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Regulatory incident reports must reference the generating plant where the event occurred for OSHA/FERC compliance.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who reported the incident.',
    `risk_assessment_id` BIGINT COMMENT 'Reference to the risk assessment record linked to the incident.',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Incident belongs to a safety program; replace free‑text safety_program with FK to SAFETY_PROGRAM for proper normalization.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Incident response logs require the field technician who performed the on‑site response; the Incident Response Report references technician_id.',
    `vendor_id` BIGINT COMMENT 'Identifier of the contractor (if any) involved in the incident.',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to regulatory.violation_notice. Business justification: When an incident breaches standards, a violation notice is issued; linking provides traceability for enforcement actions.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Incident investigations reference the work order active at the time of the event for root‑cause analysis and regulatory reporting.',
    `corrective_action_due_date` DATE COMMENT 'Target date for completion of corrective actions.',
    `corrective_action_status` STRING COMMENT 'Current status of corrective actions derived from the incident.. Valid values are `pending|in_progress|completed`',
    `dart_days` STRING COMMENT 'Total number of Days Away, Restricted, or Transferred due to the incident.',
    `equipment_involved` STRING COMMENT 'Identifier or description of equipment involved in the incident.',
    `fatality_flag` BOOLEAN COMMENT 'True if the incident resulted in a fatality.',
    `fed_notification_date` DATE COMMENT 'Date of notification to the federal regulatory agency.',
    `incident_category` STRING COMMENT 'Broad category describing the nature of the incident.. Valid values are `environmental|electrical|mechanical|chemical|other`',
    `incident_description` STRING COMMENT 'Narrative description of what happened, including circumstances and observations.',
    `incident_number` STRING COMMENT 'Business-visible identifier assigned to the incident (e.g., INC-2023-000123).',
    `incident_status` STRING COMMENT 'Current workflow status of the incident record.. Valid values are `open|under_investigation|closed|reopened`',
    `incident_timestamp` TIMESTAMP COMMENT 'Date and time when the incident actually occurred.',
    `incident_type` STRING COMMENT 'Classification of the incident (e.g., slip, equipment failure, chemical release).',
    `injury_body_part` STRING COMMENT 'Body part(s) affected by the injury.',
    `injury_severity` STRING COMMENT 'Severity rating of the injury based on medical assessment.. Valid values are `minor|moderate|severe|critical`',
    `injury_type` STRING COMMENT 'Classification of injury severity for the affected individual.. Valid values are `first_aid|medical_treatment|restricted_duty|lost_time|fatality`',
    `investigation_complete_date` DATE COMMENT 'Date when the investigation was formally closed.',
    `investigation_status` STRING COMMENT 'Current status of the incident investigation.. Valid values are `not_started|in_progress|completed`',
    `is_osha_recordable` BOOLEAN COMMENT 'Indicates whether the incident meets OSHA recordability criteria.',
    `is_reported_to_fed` BOOLEAN COMMENT 'Indicates if the incident was reported to a federal regulator (e.g., FERC, NERC).',
    `is_reported_to_puc` BOOLEAN COMMENT 'Indicates if the incident was reported to the Public Utility Commission.',
    `last_update_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the incident record.',
    `lost_time_days` STRING COMMENT 'Number of workdays lost due to the injury.',
    `medical_treatment_required` BOOLEAN COMMENT 'True if medical treatment beyond first aid was required.',
    `near_miss_flag` BOOLEAN COMMENT 'True if the event was a near miss (no injury but potential for harm).',
    `notification_sent_date` DATE COMMENT 'Date when required regulatory notification was sent.',
    `puc_notification_date` DATE COMMENT 'Date of notification to the Public Utility Commission.',
    `regulatory_notification_required` BOOLEAN COMMENT 'Indicates if the incident must be reported to a regulatory agency.',
    `report_timestamp` TIMESTAMP COMMENT 'Date and time when the incident was first recorded in the system.',
    `restricted_duty_days` STRING COMMENT 'Number of days the employee performed restricted duty.',
    `root_cause_category` STRING COMMENT 'High-level category of the root cause (e.g., human error, equipment failure, process gap).',
    `root_cause_subcategory` STRING COMMENT 'More detailed subcategory describing the specific root cause.',
    `severity` STRING COMMENT 'Severity level assigned based on potential impact and injury.. Valid values are `low|medium|high|critical`',
    `shift` STRING COMMENT 'Work shift during which the incident occurred.. Valid values are `day|night|swing`',
    `source_system` STRING COMMENT 'Originating operational system (e.g., Maximo, SAP EHS).',
    `subcategory` STRING COMMENT 'More specific subcategory within the incident category.',
    `weather_condition` STRING COMMENT 'Weather at the time of the incident.. Valid values are `clear|rain|snow|wind|storm`',
    `witness_count` STRING COMMENT 'Number of witnesses who observed the incident.',
    CONSTRAINT pk_incident PRIMARY KEY(`incident_id`)
) COMMENT 'OSHA recordable incidents, near-misses, first-aid events, unsafe conditions, and fatalities occurring across all utility operations (generation, T&D, gas, field crews). Captures incident type, severity classification (near-miss, first-aid, medical treatment, restricted duty, lost time, fatality), OSHA recordability determination, location, involved personnel, root cause category, days away/restricted/transferred (DART), medical case management details, and regulatory notification requirements. Serves as the authoritative SSOT for all occupational safety events including near-miss reports and OSHA 300 Log recordable case data. Sourced from Maximo EAM safety module and SAP EHS.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`safety_program` (
    `safety_program_id` BIGINT COMMENT 'Unique identifier for the safety program record.',
    `body_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_body. Business justification: Safety programs are mandated by a specific regulatory body; FK replaces the free‑text field for accurate governance.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Safety program budgeting requires linking program to its approved budget for variance analysis and reporting.',
    `business_entity_id` BIGINT COMMENT 'Foreign key linking to customer.business_entity. Business justification: Regulatory audit requires each safety program to be owned by a corporate entity; linking enables ownership reporting.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the internal owner responsible for the program.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Safety programs are deployed per facility; program effectiveness is measured at the facility level.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Safety programs are assigned to individual plants to satisfy corporate and regulator safety standards.',
    `person_id` BIGINT COMMENT 'Unique identifier of the internal owner responsible for the program.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Required for Safety Program compliance tracking per Product Program; regulatory reports tie safety initiatives to specific incentive programs.',
    `audit_frequency_months` STRING COMMENT 'Interval in months between mandatory audits of the program.',
    `compliance_deadline` DATE COMMENT 'Latest date by which required compliance actions must be completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `documentation_url` STRING COMMENT 'Link to the central repository where program documents are stored.',
    `effectiveness_metric` STRING COMMENT 'Key metric used to assess program effectiveness (e.g., incident rate).',
    `effectiveness_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) representing program performance against its metric.',
    `end_date` DATE COMMENT 'Date the program was terminated or superseded (nullable).',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the program is required by regulation (true) or voluntary (false).',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit.',
    `last_review_date` DATE COMMENT 'Date the program was most recently reviewed.',
    `next_audit_date` DATE COMMENT 'Scheduled date for the next audit.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next program review.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or comments.',
    `owner_department` STRING COMMENT 'Organizational department that owns the program.',
    `program_category` STRING COMMENT 'Secondary categorization used for reporting and analytics.. Valid values are `safety|environment|process|emergency|training`',
    `program_code` STRING COMMENT 'Unique alphanumeric code used to reference the program internally.',
    `program_description` STRING COMMENT 'Detailed narrative describing the program objectives and activities.',
    `program_name` STRING COMMENT 'Descriptive name of the safety program.',
    `program_scope` STRING COMMENT 'Description of the functional or geographic scope covered by the program.',
    `program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|retired|pending|suspended`',
    `program_type` STRING COMMENT 'High‑level classification of the program purpose.. Valid values are `occupational|environmental|process|emergency|training`',
    `regulatory_citation` STRING COMMENT 'Citation of the governing regulation or standard (e.g., OSHA 29 CFR 1910.119).',
    `responsible_owner_name` STRING COMMENT 'Full name of the program owner.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory program reviews.',
    `risk_level` STRING COMMENT 'Risk classification associated with the program.. Valid values are `low|medium|high|critical`',
    `start_date` DATE COMMENT 'Date the program became effective.',
    `training_frequency_months` STRING COMMENT 'How often required training must be recertified, expressed in months.',
    `training_required` BOOLEAN COMMENT 'Indicates if formal training is required for program compliance.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the program record.',
    `version` STRING COMMENT 'Version identifier for the program documentation (e.g., v1.2).',
    CONSTRAINT pk_safety_program PRIMARY KEY(`safety_program_id`)
) COMMENT 'Master catalog of occupational safety, environmental health, and process safety programs administered by the utility, including OSHA PSM (Process Safety Management), NERC CIP physical security, PHMSA pipeline integrity management, lockout/tagout (LOTO), confined space entry, arc flash, fall protection, emergency response, and respiratory protection programs. Defines program scope, regulatory mandate (with specific CFR/standard citation), responsible owner, review cycle, program effectiveness metrics, and active/inactive status. Serves as the reference master that incidents, audits, training, and drills link to for program-level compliance tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`observation` (
    `observation_id` BIGINT COMMENT 'Unique identifier for the safety observation record.',
    `body_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_body. Business justification: Observations are often required by a particular regulator; linking enables reporting and audit alignment.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Safety observations are recorded at customer sites; linking to the account enables site‑specific safety performance tracking.',
    `crew_id` BIGINT COMMENT 'Identifier of the work crew or team being observed.',
    `distribution_transformer_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_transformer. Business justification: Safety observations of transformer condition are tied to the transformer asset to trigger inspections and corrective work.',
    `employee_id` BIGINT COMMENT 'System identifier of the employee or contractor who performed the observation.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Observations are recorded at a facility to support daily safety walk‑throughs and compliance audits.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Safety observation is performed during an incident; link to INCIDENT and remove duplicate incident_number and location_name.',
    `location_id` BIGINT COMMENT 'Identifier of the physical location where the observation occurred.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Safety observations of equipment (e.g., tampering) are recorded against the specific meter to trigger corrective actions and compliance tracking.',
    `metering_service_point_id` BIGINT COMMENT 'Foreign key linking to metering.metering_service_point. Business justification: Observations tied to a service point allow aggregation of safety data for outage risk analysis and planning.',
    `ot_asset_id` BIGINT COMMENT 'Foreign key linking to technology.ot_asset. Business justification: Safety Observation records condition of specific OT equipment; linking to ot_asset enables tracking of asset health and integration with maintenance schedules.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Safety observations are logged against the specific generating plant where the observation occurred.',
    `pole_id` BIGINT COMMENT 'Foreign key linking to distribution.pole. Business justification: Field safety observations are recorded against specific poles for maintenance planning and compliance audits.',
    `behavior_description` STRING COMMENT 'Narrative describing the specific behavior observed.',
    `comments` STRING COMMENT 'Additional free‑form notes captured by the observer.',
    `condition_description` STRING COMMENT 'Narrative describing the physical condition or environment observed.',
    `corrective_action_taken` STRING COMMENT 'Immediate coaching or corrective measure applied at the time of observation.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the observation record was first created.',
    `follow_up_due_date` DATE COMMENT 'Date by which any required follow‑up actions must be completed.',
    `follow_up_required` BOOLEAN COMMENT 'Flag indicating whether additional follow‑up or verification is needed after the observation.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the observation is deemed a critical safety issue.',
    `observation_status` STRING COMMENT 'Current lifecycle status of the observation record.. Valid values are `open|closed|in_progress`',
    `observation_timestamp` TIMESTAMP COMMENT 'Date and time when the safety observation was made.',
    `observation_type` STRING COMMENT 'Classification of the observation: safe act, at‑risk behavior, safe condition, or unsafe condition.. Valid values are `safe_act|at_risk_behavior|safe_condition|unsafe_condition`',
    `observer_name` STRING COMMENT 'Legal full name of the person who made the observation.',
    `risk_rating` DECIMAL(18,2) COMMENT 'Numeric risk rating (e.g., 1.00‑5.00) derived from severity and likelihood.',
    `severity_level` STRING COMMENT 'Risk severity assigned to the observation, used for prioritization.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Originating system or method used to capture the observation.. Valid values are `WFM|Manual|MobileApp`',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the observation record.',
    `work_activity` STRING COMMENT 'Description of the primary work activity being performed during the observation.',
    CONSTRAINT pk_observation PRIMARY KEY(`observation_id`)
) COMMENT 'Behavioral safety observations and field-level safety walks conducted by supervisors, safety officers, and peer observers as part of behavior-based safety (BBS) programs. Captures observation date, observer identity, crew/work group observed, work activity, observation type (safe act, at-risk behavior, safe condition, unsafe condition), specific behavior or condition noted, immediate corrective coaching provided, and follow-up required flag. Supports leading indicator dashboards, safety culture metrics, and proactive hazard identification programs.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`safety_audit` (
    `safety_audit_id` BIGINT COMMENT 'System-generated unique identifier for the safety audit record.',
    `body_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_body. Business justification: Safety audits are scoped by a regulatory authority; FK ensures the audit is associated with the correct regulator.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Audit expense tracking ties each safety audit to a cost center for financial reporting and audit cost recovery.',
    `distribution_substation_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_substation. Business justification: Safety audits are performed on substations; linking audit records to the substation enables audit scope tracking and regulatory reporting.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Audits are conducted at individual facilities; audit findings are tied to the audited facility for tracking.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Safety audits of metering infrastructure require referencing each audited meter to document findings and compliance status.',
    `metering_service_point_id` BIGINT COMMENT 'Foreign key linking to metering.metering_service_point. Business justification: Audit reports include the service point to evaluate safety conditions of the distribution network at the point of delivery.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory safety audits must record the employee auditor responsible for the audit; the Audit Responsibility Report stores audit_responsible_employee_id.',
    `audit_category` STRING COMMENT 'Safety domain focus of the audit (e.g., electrical, mechanical, environmental).',
    `audit_number` STRING COMMENT 'External audit reference number assigned by the utility or regulator.',
    `audit_scope` STRING COMMENT 'Narrative description of the functional, geographic, or asset scope covered by the audit.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit.. Valid values are `planned|in_progress|completed|closed|cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit based on its initiation source.. Valid values are `scheduled|unannounced|regulatory|internal`',
    `compliance_rating` STRING COMMENT 'Overall rating indicating the level of compliance identified during the audit.. Valid values are `compliant|non_compliant|partial|critical`',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `end_timestamp` TIMESTAMP COMMENT 'Date and time when the audit fieldwork concluded.',
    `findings_critical` STRING COMMENT 'Number of findings classified as critical severity.',
    `findings_major` STRING COMMENT 'Number of findings classified as major severity.',
    `findings_minor` STRING COMMENT 'Number of findings classified as minor severity.',
    `findings_observation` STRING COMMENT 'Number of findings classified as observation (non‑deficiency).',
    `findings_total` STRING COMMENT 'Total number of findings recorded for the audit.',
    `location_code` STRING COMMENT 'Identifier of the primary plant, substation, or facility where the audit was performed.',
    `notes` STRING COMMENT 'Free‑form comments or observations captured by the audit team.',
    `overall_disposition` STRING COMMENT 'Final disposition of the audit after findings are addressed.. Valid values are `pass|fail|conditional`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the audit record.',
    `report_url` STRING COMMENT 'Link to the electronic audit report document stored in the document management system.',
    `start_timestamp` TIMESTAMP COMMENT 'Date and time when the audit fieldwork began.',
    `team` STRING COMMENT 'Names or identifiers of the internal/external auditors who performed the audit.',
    `total_penalty_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary penalties assessed for all findings, expressed in US dollars.',
    CONSTRAINT pk_safety_audit PRIMARY KEY(`safety_audit_id`)
) COMMENT 'Formal safety audits, inspections, and regulatory examinations conducted internally or by external regulators (OSHA, PSC, PHMSA, NERC), including all associated findings, violations, and observations as line-level detail. Header level captures audit type (scheduled, unannounced, regulatory), scope, audit team composition, schedule, compliance rating, and overall disposition. Finding/line level captures individual deficiencies with finding ID, severity classification (critical, major, minor, observation), regulatory citation (e.g., OSHA 29 CFR 1910.147), violation determination, penalty assessment, required corrective action, responsible party, due date, closure status, and evidence of remediation. Serves as the authoritative SSOT for the complete audit execution lifecycle from planning through finding closure and regulatory response management. No separate finding-level product exists — all finding data lives here.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`audit_finding` (
    `audit_finding_id` BIGINT COMMENT 'System-generated unique identifier for the audit finding record.',
    `asset_registry_id` BIGINT COMMENT 'Identifier of the asset associated with the finding, if applicable.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each audit finding is assigned to a specific employee for remediation; the Finding Assignment Register tracks finding_employee_id.',
    `registry_id` BIGINT COMMENT 'Identifier of the asset associated with the finding, if applicable.',
    `safety_audit_id` BIGINT COMMENT 'Foreign key linking to safety.safety_audit. Business justification: Audit finding is part of a safety audit; add FK to SAFETY_AUDIT to capture parent‑child relationship.',
    `work_order_id` BIGINT COMMENT 'Work order generated to address the finding, if any.',
    `audit_category` STRING COMMENT 'High‑level category of the audit activity.. Valid values are `inspection|audit|review`',
    `audit_date` DATE COMMENT 'Date on which the audit or inspection was performed.',
    `audit_finding_description` STRING COMMENT 'Detailed narrative describing the observation, condition, or violation.',
    `audit_finding_status` STRING COMMENT 'Current workflow status of the finding.. Valid values are `open|in_progress|closed|rejected`',
    `audit_team` STRING COMMENT 'Name(s) of the team or individual auditors who performed the audit.',
    `audit_type` STRING COMMENT 'Indicates whether the audit was internal, external, or regulatory.. Valid values are `internal|external|regulatory`',
    `closure_date` DATE COMMENT 'Date the finding was formally closed.',
    `closure_status` STRING COMMENT 'Result of the finding after corrective actions.. Valid values are `resolved|unresolved|withdrawn`',
    `comments` STRING COMMENT 'Free‑form comments entered by auditors or reviewers.',
    `compliance_status` STRING COMMENT 'Overall compliance determination for the finding.. Valid values are `compliant|non_compliant|partial`',
    `corrective_action_due_date` DATE COMMENT 'Target date by which the corrective action must be completed.',
    `corrective_action_owner` STRING COMMENT 'Individual or team responsible for executing the corrective action.',
    `corrective_action_plan` STRING COMMENT 'Planned steps to remediate the finding.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action implementation.. Valid values are `not_started|in_progress|completed|deferred`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the finding record was first created in the system.',
    `finding_number` STRING COMMENT 'External reference number assigned to the finding by the audit team.',
    `finding_type` STRING COMMENT 'Category of the finding based on the domain it affects.. Valid values are `safety|environment|regulatory|operational`',
    `follow_up_action` STRING COMMENT 'Description of any additional actions required post‑closure.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether additional follow‑up actions are needed after closure.',
    `location` STRING COMMENT 'Physical location or facility where the finding was observed.',
    `observation_details` STRING COMMENT 'Specific details captured during the observation of the finding.',
    `regulatory_citation` STRING COMMENT 'Reference to the specific regulation or standard cited (e.g., OSHA 29 CFR 1910.147).',
    `risk_score` DECIMAL(18,2) COMMENT 'Quantitative risk rating assigned to the finding (e.g., 0.00–10.00).',
    `root_cause` STRING COMMENT 'Analysis of the underlying cause that led to the finding.',
    `severity` STRING COMMENT 'Severity classification indicating the potential impact of the finding.. Valid values are `critical|major|minor|observation`',
    `source_system` STRING COMMENT 'System of record that originated the finding (e.g., OSHA, EPA, internal audit).',
    `title` STRING COMMENT 'Brief descriptive title of the audit finding.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the finding record.',
    CONSTRAINT pk_audit_finding PRIMARY KEY(`audit_finding_id`)
) COMMENT 'Individual findings, violations, and observations identified during a safety audit or regulatory inspection. Each finding has its own severity classification (critical, major, minor, observation), regulatory citation (e.g., OSHA 29 CFR 1910.147), required corrective action, due date, and closure status. Supports corrective action tracking and regulatory response management.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`corrective_action` (
    `corrective_action_id` BIGINT COMMENT 'System-generated unique identifier for the corrective action record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Corrective actions are tied to specific assets to track remediation, cost, and compliance status in asset management.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Corrective action cost tracking uses cost_center to record expenditures against budgeted safety spend.',
    `distribution_transformer_id` BIGINT COMMENT 'Foreign key linking to distribution.distribution_transformer. Business justification: Corrective actions arising from safety incidents often target a specific transformer; the link supports work‑order generation and compliance tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the system user who created the corrective action.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Corrective actions stem from issues identified at a specific facility and are managed in the facilitys maintenance plan.',
    `incident_id` BIGINT COMMENT 'Identifier of the incident, near‑miss, or audit finding linked to this action.',
    `location_id` BIGINT COMMENT 'Reference to the physical location (plant, substation, site) associated with the action.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Corrective actions arising from meter faults need a direct link to the meter to schedule repairs and close the loop on compliance.',
    `person_id` BIGINT COMMENT 'Identifier of the person or group accountable for executing the action.',
    `responsible_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Corrective actions are owned by a designated employee; the Corrective Action Ownership Report records responsible_employee_id.',
    `responsible_party_employee_id` BIGINT COMMENT 'Identifier of the person or group accountable for executing the action.',
    `updated_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who last modified the corrective action.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Corrective actions often originate from a work order; linking provides traceability of costs and responsibilities.',
    `action_category` STRING COMMENT 'Broad category of the action for reporting purposes.. Valid values are `safety|environment|regulatory`',
    `action_code` STRING COMMENT 'Business‑assigned code used for tracking and reporting.',
    `action_description` STRING COMMENT 'Detailed description of the corrective action, including what will be done and why.',
    `action_title` STRING COMMENT 'Brief title summarizing the corrective action.',
    `action_type` STRING COMMENT 'Classifies the action as corrective, preventive, or detective.. Valid values are `corrective|preventive|detective`',
    `actual_completion_date` DATE COMMENT 'Date the corrective action was actually completed.',
    `audit_trail` STRING COMMENT 'JSON string capturing change history for compliance audits.',
    `comments` STRING COMMENT 'Free‑form notes or remarks related to the corrective action.',
    `compliance_reference` STRING COMMENT 'Regulatory program or standard that triggered the corrective action.. Valid values are `OSHA|NERC|EPA|PHMSA`',
    `corrective_action_status` STRING COMMENT 'Current lifecycle status of the corrective action.. Valid values are `open|in_progress|completed|closed|cancelled`',
    `cost_actual` DECIMAL(18,2) COMMENT 'Actual monetary cost incurred for the corrective action.',
    `cost_estimate` DECIMAL(18,2) COMMENT 'Estimated monetary cost to implement the corrective action.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the corrective action record was first created in the system.',
    `effectiveness_rating` STRING COMMENT 'Result of the effectiveness review for the corrective action.. Valid values are `effective|partially_effective|ineffective`',
    `effectiveness_review_date` DATE COMMENT 'Date the effectiveness rating was recorded.',
    `is_closed` BOOLEAN COMMENT 'Indicates whether the corrective action has been closed (true) or is still open (false).',
    `priority` STRING COMMENT 'Priority level assigned to the action based on risk and impact.. Valid values are `low|medium|high|critical`',
    `responsible_party_name` STRING COMMENT 'Full name of the responsible employee or team.',
    `risk_level` STRING COMMENT 'Risk rating of the issue that triggered the corrective action.. Valid values are `low|moderate|high|critical`',
    `root_cause` STRING COMMENT 'Narrative of the underlying cause identified for the incident or audit finding.',
    `root_cause_category` STRING COMMENT 'High‑level category of the root cause.. Valid values are `equipment|process|human|environment|external`',
    `target_completion_date` DATE COMMENT 'Planned date by which the corrective action should be finished.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the corrective action record.',
    `verification_date` DATE COMMENT 'Date the verification activity was performed.',
    `verification_method` STRING COMMENT 'Method used to verify that the corrective action was effective.. Valid values are `inspection|test|audit|review`',
    CONSTRAINT pk_corrective_action PRIMARY KEY(`corrective_action_id`)
) COMMENT 'Corrective and preventive actions (CAPAs) generated from incidents, near-misses, audit findings, and safety observations. Tracks action description, responsible party, target completion date, actual completion date, verification method, and effectiveness review. Serves as the SSOT for all safety-related corrective action tracking across OSHA, PHMSA, NERC CIP, and EPA compliance programs.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` (
    `hazmat_inventory_id` BIGINT COMMENT 'Unique identifier for the hazardous material inventory record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Hazmat inventory must be assigned to a custodian employee for accountability; the Hazmat Custody Log uses custodian_employee_id.',
    `facility_id` BIGINT COMMENT 'Identifier of the facility containing the material.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Hazardous material inventories are tracked per plant to meet EPA and OSHA hazardous waste regulations.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Regulatory hazardous material tracking mandates linking each hazmat inventory record to the specific warehouse storing it for compliance reporting.',
    `average_quantity` DECIMAL(18,2) COMMENT 'Average quantity of the material over a defined period.',
    `cas_number` STRING COMMENT 'Unique CAS registry number identifying the chemical.',
    `chemical_name` STRING COMMENT 'Common name of the hazardous chemical or material.',
    `containment_action` STRING COMMENT 'Action taken to contain the release.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventory record was first created.',
    `disposal_date` DATE COMMENT 'Date the material was disposed.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the material (e.g., incineration, landfill).',
    `effective_from` DATE COMMENT 'Date the inventory record becomes effective.',
    `effective_until` DATE COMMENT 'Date the inventory record expires or is superseded (nullable).',
    `emergency_contact_email` STRING COMMENT 'Email address for the emergency contact.',
    `emergency_contact_name` STRING COMMENT 'Name of the designated emergency contact for the material.',
    `emergency_contact_phone` STRING COMMENT 'Phone number for the emergency contact.',
    `environmental_media` STRING COMMENT 'Environmental medium impacted by the release.. Valid values are `air|water|soil|groundwater`',
    `epa_rmp_applicable` BOOLEAN COMMENT 'True if the material falls under EPA RMP requirements.',
    `hazard_category` STRING COMMENT 'Category of hazard (e.g., health, physical).',
    `hazard_class` STRING COMMENT 'Regulatory hazard class (e.g., flammable, toxic).',
    `hazmat_inventory_status` STRING COMMENT 'Current lifecycle status of the material in inventory.. Valid values are `active|inactive|retired|disposed`',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.. Valid values are `passed|failed|pending`',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the material is classified as hazardous.',
    `is_ppe_required` BOOLEAN COMMENT 'Indicates if PPE is required when handling the material.',
    `is_reportable` BOOLEAN COMMENT 'True if the material must be reported under regulatory programs.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety inspection of the material storage.',
    `material_type` STRING COMMENT 'Broad classification of the material (e.g., chemical, gas, liquid).',
    `max_quantity` DECIMAL(18,2) COMMENT 'Maximum recorded quantity of the material on hand.',
    `notes` STRING COMMENT 'Free-text field for additional comments or observations.',
    `notification_deadline` DATE COMMENT 'Regulatory deadline by which notification must be submitted.',
    `ppe_requirements` STRING COMMENT 'Description of required PPE for handling the material.',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current amount of material physically present.',
    `quantity_unit` STRING COMMENT 'Unit of measure for quantity fields (e.g., kg, L, gal).',
    `regulatory_notification_status` STRING COMMENT 'Status of required regulatory notifications for the release.. Valid values are `not_notified|notified|completed`',
    `release_date` DATE COMMENT 'Date the release or spill occurred.',
    `release_point` STRING COMMENT 'Specific point or equipment where the release originated.',
    `release_quantity` DECIMAL(18,2) COMMENT 'Amount of material released during the event.',
    `release_quantity_unit` STRING COMMENT 'Unit of measure for the release quantity (e.g., kg, L).',
    `release_type` STRING COMMENT 'Category of material release event.. Valid values are `spill|leak|emission`',
    `remediation_action` STRING COMMENT 'Remediation steps performed after the release.',
    `root_cause_description` STRING COMMENT 'Narrative of the root cause analysis for the release.',
    `sara_title_iii_tier_ii_reportable` BOOLEAN COMMENT 'Indicates if the material is subject to SARA Title III Tier II reporting.',
    `sds_url` STRING COMMENT 'Link to the electronic Safety Data Sheet for the material.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `waste_code` STRING COMMENT 'EPA hazardous waste code applicable to the material.',
    CONSTRAINT pk_hazmat_inventory PRIMARY KEY(`hazmat_inventory_id`)
) COMMENT 'Hazardous materials lifecycle management covering chemical inventory, storage, and reportable release/spill events at utility facilities (generation plants, substations, gas compressor stations, service centers). For inventory: tracks chemical name, CAS number, maximum/average quantity on hand, storage location, SDS reference, SARA Title III Tier II reporting status, and EPA RMP applicability. For releases/spills: captures release type (spill, leak, atmospheric emission), substance, quantity released, release point, environmental media affected (air, water, soil), regulatory notification timeline and status (EPA NRC, state agency, local LEPC), containment and remediation actions, and root cause. Serves as the SSOT for all hazardous material records from cradle-to-grave including OSHA HazCom, EPA EPCRA Tier II reporting, PHMSA compliance, and emergency spill response management.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` (
    `hazmat_release_id` BIGINT COMMENT 'System-generated unique identifier for the hazardous material release record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Remediation and liability costs from hazmat releases are allocated to a cost center for regulatory and financial liability tracking.',
    `facility_id` BIGINT COMMENT 'Identifier of the utility facility or site where the release occurred.',
    `incident_id` BIGINT COMMENT 'Identifier assigned by external regulators or reporting systems.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Hazmat release reports must identify the originating plant for incident management and regulatory filing.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory hazmat release reports require the employee who reported the incident; the Release Reporting Form captures reporting_employee_id.',
    `cause_category` STRING COMMENT 'High-level classification of the root cause.. Valid values are `equipment_failure|human_error|natural|unknown`',
    `cause_description` STRING COMMENT 'Detailed explanation of the cause of the release.',
    `comments` STRING COMMENT 'Free‑form notes or additional information.',
    `compliance_review_status` STRING COMMENT 'Status of internal compliance audit for the release.. Valid values are `pending|completed|exempt`',
    `containment_method` STRING COMMENT 'Method used to contain or control the release.',
    `corrective_action_plan` STRING COMMENT 'Documented plan to prevent recurrence.',
    `detection_method` STRING COMMENT 'How the release was detected (e.g., sensor, visual inspection).',
    `emergency_response_required` BOOLEAN COMMENT 'Indicates if emergency services were engaged.',
    `epa_reported_flag` BOOLEAN COMMENT 'True if the release was reported to the EPA.',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected financial cost to remediate the release.',
    `follow_up_date` DATE COMMENT 'Scheduled date for post‑release review or inspection.',
    `hazmat_release_status` STRING COMMENT 'Current processing status of the release record.. Valid values are `reported|investigated|closed|rejected`',
    `incident_description` STRING COMMENT 'Narrative description of the release event.',
    `is_duplicate_report` BOOLEAN COMMENT 'True if this release duplicates a previously logged incident.',
    `is_hazardous` BOOLEAN COMMENT 'Indicates whether the substance is classified as hazardous.',
    `is_reportable` BOOLEAN COMMENT 'Indicates whether the release meets regulatory reporting thresholds.',
    `last_modified_by` STRING COMMENT 'User identifier who last updated the release record.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the release location.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the release location.',
    `media_affected` STRING COMMENT 'Environmental medium impacted by the release.. Valid values are `air|water|soil|groundwater`',
    `notification_date` DATE COMMENT 'Date when the regulatory agency was notified.',
    `nrc_reported_flag` BOOLEAN COMMENT 'True if the release was reported to the Nuclear Regulatory Commission (for nuclear materials).',
    `quantity_released` DECIMAL(18,2) COMMENT 'Measured amount of material released.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the release record was first entered into the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the release record.',
    `regulatory_notification_status` STRING COMMENT 'Current status of required regulatory notifications.. Valid values are `not_notified|notified|pending|completed`',
    `release_number` STRING COMMENT 'External reference number assigned to the release event for tracking and reporting.',
    `release_timestamp` TIMESTAMP COMMENT 'Date and time when the hazardous material release actually occurred.',
    `release_type` STRING COMMENT 'Classification of how the material was released.. Valid values are `spill|leak|emission|accidental|intentional`',
    `remediation_action` STRING COMMENT 'Planned or executed action to mitigate the release impact.',
    `remediation_status` STRING COMMENT 'Current state of the remediation effort.. Valid values are `pending|in_progress|completed|not_required`',
    `report_date` DATE COMMENT 'Date the release was formally reported in the system.',
    `reported_by` STRING COMMENT 'Name of the individual who initially reported the release.',
    `risk_level` STRING COMMENT 'Overall risk rating for the release based on severity and exposure.. Valid values are `low|medium|high|critical`',
    `source_system` STRING COMMENT 'Originating operational system (e.g., Maximo, PI Historian).',
    `state_regulatory_agency` STRING COMMENT 'State-level agency notified about the release.',
    `substance` STRING COMMENT 'Common name of the hazardous material released.',
    `substance_cas_number` STRING COMMENT 'Chemical Abstracts Service registry number for the released substance.',
    `unit_of_measure` STRING COMMENT 'Units used for the quantity released.. Valid values are `gallons|liters|kg|tons|cubic_meters`',
    `weather_conditions` STRING COMMENT 'Relevant weather information at the time of release.',
    `created_by` STRING COMMENT 'User identifier who created the release record.',
    CONSTRAINT pk_hazmat_release PRIMARY KEY(`hazmat_release_id`)
) COMMENT 'Reportable releases, spills, and emissions events involving hazardous materials, chemicals, or gases at utility facilities or during field operations. Captures release type (spill, leak, atmospheric emission), substance released, quantity, release point, environmental media affected (air, water, soil), regulatory notification status (EPA NRC, state agency), and remediation actions initiated.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`training` (
    `training_id` BIGINT COMMENT 'Unique surrogate key for each safety training record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Training expenses are recorded against a cost center to manage safety training budgets and cost recovery.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the employee or contractor who received the training.',
    `person_id` BIGINT COMMENT 'Unique identifier of the employee or contractor who received the training.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Training records are tied to the plant where employees work to satisfy safety certification requirements.',
    `safety_program_id` BIGINT COMMENT 'Foreign key linking to safety.safety_program. Business justification: Safety training is administered under a safety program; link training records to SAFETY_PROGRAM.',
    `certification_expiration_date` DATE COMMENT 'Date the certification becomes invalid.',
    `certification_number` STRING COMMENT 'Identifier of the certification awarded upon successful completion.',
    `completion_date` DATE COMMENT 'Date the employee completed the training.',
    `course_code` STRING COMMENT 'Standardized code used to reference the training curriculum.',
    `course_name` STRING COMMENT 'Descriptive title of the safety training course.',
    `expiration_date` DATE COMMENT 'Date the training certification expires and must be renewed.',
    `hours` STRING COMMENT 'Total instructional hours associated with the training.',
    `location` STRING COMMENT 'Physical or virtual location where the training was delivered.',
    `mandatory_flag` BOOLEAN COMMENT 'Indicates whether the training is required by regulation or policy.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the training session.',
    `pass_fail_status` STRING COMMENT 'Result of the training assessment.. Valid values are `pass|fail`',
    `provider_name` STRING COMMENT 'Organization or internal department delivering the training.',
    `recertification_due_date` DATE COMMENT 'Deadline for the employee to complete recertification training.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the training record was first created.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the training record.',
    `record_number` STRING COMMENT 'Human‑readable identifier assigned to the training event for tracking and audit.',
    `regulatory_requirement` STRING COMMENT 'Regulation that mandates the training (e.g., OSHA, NERC CIP, PHMSA, DOT).. Valid values are `OSHA|NERC_CIP|PHMSA|DOT`',
    `score` DECIMAL(18,2) COMMENT 'Numeric score achieved on the training assessment (percentage).',
    `training_category` STRING COMMENT 'Broad classification of the training content.. Valid values are `safety|environmental|compliance|operational|leadership`',
    `training_mode` STRING COMMENT 'Delivery mode of the training.. Valid values are `eLearning|instructor_led|on_the_job|blended`',
    `training_status` STRING COMMENT 'Current lifecycle state of the training record.. Valid values are `completed|in_progress|expired|cancelled|failed`',
    `training_timestamp` TIMESTAMP COMMENT 'Exact timestamp when the training event was recorded in the system.',
    `training_type` STRING COMMENT 'Method used to deliver the training.. Valid values are `online|classroom|on_the_job|blended`',
    CONSTRAINT pk_training PRIMARY KEY(`training_id`)
) COMMENT 'Safety training course completions and certifications for utility employees and contractors. Tracks training course name, regulatory requirement (OSHA, NERC CIP, PHMSA, DOT), completion date, expiration date, training provider, pass/fail status, and recertification due date. Supports OSHA training compliance, NERC CIP personnel training requirements, and workforce safety readiness.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` (
    `job_hazard_analysis_id` BIGINT COMMENT 'Unique identifier for the job hazard analysis record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: JHA documents are authored by a safety analyst employee; the JHA Analyst Register stores analyst_employee_id.',
    `asset_registry_id` BIGINT COMMENT 'Identifier of the asset associated with the task, if applicable.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: JHA funding is allocated to specific cost centers; linking enables budgeting and cost control of hazard mitigation.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: JHAs are created for tasks at each plant; linking enables risk‑assessment reporting per asset.',
    `registry_id` BIGINT COMMENT 'Identifier of the asset associated with the task, if applicable.',
    `analysis_type` STRING COMMENT 'Specifies whether the analysis follows Job Hazard Analysis (JHA) or Job Safety Analysis (JSA) methodology.. Valid values are `JHA|JSA`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the analysis was approved.',
    `approver_name` STRING COMMENT 'Name of the employee who approved the hazard analysis.',
    `author_name` STRING COMMENT 'Name of the employee who authored the hazard analysis.',
    `comments` STRING COMMENT 'Additional comments or notes.',
    `compliance_status` STRING COMMENT 'Compliance status of the analysis with applicable regulations.. Valid values are `compliant|non_compliant|exempt|pending`',
    `control_measures` STRING COMMENT 'Description of engineering or administrative controls to mitigate the hazard.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the hazard analysis record was created.',
    `department` STRING COMMENT 'Organizational department responsible for the analysis.',
    `document_version` STRING COMMENT 'Version identifier of the document (e.g., v1.2).',
    `effective_date` DATE COMMENT 'Date when the analysis becomes effective for the task.',
    `emergency_procedure` STRING COMMENT 'Emergency response procedure applicable to the hazard.',
    `expiration_date` DATE COMMENT 'Date when the analysis expires or is superseded.',
    `hazard_category` STRING COMMENT 'Broad category of the identified hazard.. Valid values are `Electrical|Mechanical|Chemical|Physical|Environmental|Other`',
    `hazard_identified_date` DATE COMMENT 'Date when the hazard was initially identified.',
    `jha_number` STRING COMMENT 'External reference number for the hazard analysis as used in safety documentation.',
    `job_hazard_analysis_status` STRING COMMENT 'Current lifecycle status of the hazard analysis.. Valid values are `draft|pending_approval|approved|active|retired`',
    `location` STRING COMMENT 'Physical location or facility where the task is performed.',
    `lockout_tagout_required` BOOLEAN COMMENT 'Indicates if lockout/tagout procedures are required.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next review of the analysis.',
    `permit_required` BOOLEAN COMMENT 'Indicates if a work permit is required.',
    `ppe_required` STRING COMMENT 'Personal protective equipment required for the task.',
    `regulatory_reference` STRING COMMENT 'Relevant regulatory standards or codes (e.g., OSHA, NERC) referenced.',
    `revision_date` DATE COMMENT 'Date of the current revision.',
    `revision_number` STRING COMMENT 'Revision number of the hazard analysis document.',
    `risk_likelihood` STRING COMMENT 'Likelihood rating of the hazard occurrence.. Valid values are `Rare|Unlikely|Possible|Likely|Almost_Certain`',
    `risk_score` DECIMAL(18,2) COMMENT 'Calculated risk score combining severity and likelihood (e.g., 1‑25).',
    `risk_severity` STRING COMMENT 'Severity rating of the hazard.. Valid values are `Low|Medium|High|Critical`',
    `safety_audit_flag` BOOLEAN COMMENT 'Flag indicating if the analysis has been audited for safety compliance.',
    `task_description` STRING COMMENT 'Detailed description of the work task being analyzed.',
    `task_duration_minutes` STRING COMMENT 'Estimated duration of the task in minutes.',
    `task_frequency_per_year` STRING COMMENT 'Number of times the task is performed annually.',
    `title` STRING COMMENT 'Descriptive title of the hazard analysis, typically the work task name.',
    `training_required` BOOLEAN COMMENT 'Indicates if specific training is required for personnel.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the hazard analysis record.',
    CONSTRAINT pk_job_hazard_analysis PRIMARY KEY(`job_hazard_analysis_id`)
) COMMENT 'Job Hazard Analyses (JHAs) and Job Safety Analyses (JSAs) developed for utility work tasks including energized electrical work, confined space entry, gas pipeline maintenance, and tree trimming. Captures task steps, identified hazards per step, required controls and PPE, approval authority, and revision history. Serves as the pre-work safety planning SSOT for field operations.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` (
    `permit_to_work_id` BIGINT COMMENT 'System-generated unique identifier for each permit-to-work record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Permit‑to‑work is issued for a particular asset (e.g., transformer) to ensure safety controls are applied to that equipment.',
    `authorized_by_employee_id` BIGINT COMMENT 'Identifier of the person who provided final authorization for the work.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Work permits are issued for activities at a customer’s premises; linking permits to the account ensures permit tracking and customer billing.',
    `contractor_vendor_id` BIGINT COMMENT 'Identifier of the external contractor or vendor performing the work.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Permit‑to‑work costs are charged to a cost center for work‑order financial tracking and compliance reporting.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who requested the permit.',
    `issuer_employee_id` BIGINT COMMENT 'Identifier of the authorized individual who issued the permit.',
    `ot_asset_id` BIGINT COMMENT 'Foreign key linking to technology.ot_asset. Business justification: Permit‑to‑Work must specify the OT asset undergoing maintenance; linking ensures compliance checks and risk assessment per NERC CIP.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Permit‑to‑Work systems require the plant identifier to control work activities and lockout procedures.',
    `primary_permit_employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who requested the permit.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Work permits are issued for tasks at a specific site; tracking site association is required for safety and regulatory audits.',
    `tertiary_permit_authorized_by_employee_id` BIGINT COMMENT 'Identifier of the person who provided final authorization for the work.',
    `vendor_id` BIGINT COMMENT 'Identifier of the external contractor or vendor performing the work.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Permit‑to‑work must be associated with the work order that initiates the job for safety compliance and audit trails.',
    `area_code` STRING COMMENT 'Utility service area or grid zone code where the work is located.',
    `compliance_checklist` STRING COMMENT 'Serialized list of checklist items completed to satisfy regulatory compliance.',
    `confined_space_required` BOOLEAN COMMENT 'True when the work involves entry into a confined space, triggering additional safety checks.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the estimated cost (e.g., USD).',
    `end_timestamp` TIMESTAMP COMMENT 'Scheduled completion date and time for the permitted work.',
    `equipment_tag` STRING COMMENT 'Asset tag or identifier of equipment involved in the work (e.g., transformer T‑1234).',
    `estimated_cost_amount` DECIMAL(18,2) COMMENT 'Projected monetary cost of the work authorized by the permit.',
    `hazard_controls` STRING COMMENT 'List of engineering and administrative controls applied to mitigate identified hazards.',
    `lockout_tagout_required` BOOLEAN COMMENT 'Indicates whether lockout/tagout procedures must be applied before work begins.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or observations.',
    `permit_category` STRING COMMENT 'High‑level classification indicating the urgency and planning horizon of the work.. Valid values are `routine|emergency|planned|unscheduled`',
    `permit_closure_confirmation` BOOLEAN COMMENT 'Indicates whether the closure was verified by the authorized supervisor.',
    `permit_closure_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit was officially closed after work completion.',
    `permit_number` STRING COMMENT 'External reference number assigned to the permit, used for tracking and regulatory reporting.',
    `permit_to_work_status` STRING COMMENT 'Current lifecycle state of the permit.. Valid values are `draft|issued|active|closed|cancelled`',
    `permit_type` STRING COMMENT 'Category of work authorized by the permit, aligned with NFPA 70E and OSHA classifications.. Valid values are `electrical|confined_space|hot_work|excavation|gas_line|general`',
    `permit_valid_from` TIMESTAMP COMMENT 'Date and time when the permit becomes effective and work may commence.',
    `permit_valid_until` TIMESTAMP COMMENT 'Date and time after which the permit expires if work has not started.',
    `regulatory_reference` STRING COMMENT 'Citation to the specific OSHA, NERC, or state regulation governing the permit.',
    `safety_measures` STRING COMMENT 'Specific safety procedures (e.g., PPE, LOTO) required for the work.',
    `start_timestamp` TIMESTAMP COMMENT 'Scheduled start date and time for the permitted work.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the permit record.',
    `work_description` STRING COMMENT 'Narrative description of the tasks to be performed under the permit.',
    `work_location` STRING COMMENT 'Physical location where the permitted work will be performed, e.g., substation name or GPS coordinate.',
    `work_risk_level` STRING COMMENT 'Risk classification based on hazard analysis for the permitted activity.. Valid values are `low|medium|high|critical`',
    CONSTRAINT pk_permit_to_work PRIMARY KEY(`permit_to_work_id`)
) COMMENT 'Permit-to-work (PTW) records authorizing high-risk utility work activities including energized electrical work (NFPA 70E), confined space entry, hot work, excavation, and gas line work. Captures permit type, work location, authorized personnel, hazard controls verified, issuing authority, permit validity window, and closure confirmation. Supports OSHA lockout/tagout (LOTO) and confined space compliance.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` (
    `environmental_emission_id` BIGINT COMMENT 'Unique surrogate key for each emission record.',
    `eia_report_id` BIGINT COMMENT 'Identifier of the related Energy Information Administration (EIA) report.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: EPA emissions reporting is filed per generating facility; linking emissions to the facility enables accurate compliance tracking.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: EPA emission reporting is done per generating plant; linking ties measurements to the source asset.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: EPA emission reporting requires the employee who prepared the report; the Emission Reporting Log captures reporting_employee_id.',
    `compliance_status` STRING COMMENT 'Indicates whether the measured emission is within the regulatory limit.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the emission record was first created in the system.',
    `data_quality_flag` STRING COMMENT 'Indicator of the confidence level in the measurement data.. Valid values are `good|questionable|bad`',
    `emission_factor` DECIMAL(18,2) COMMENT 'Factor used to convert activity data to emissions, expressed in appropriate units.',
    `emission_rate` DECIMAL(18,2) COMMENT 'Measured emission rate for the pollutant, expressed in the unit defined by emission_rate_unit.',
    `emission_rate_unit` STRING COMMENT 'Unit of measure for the emission_rate value.. Valid values are `lb/hr|kg/hr|tonne/hr|g/s`',
    `emission_timestamp` TIMESTAMP COMMENT 'Date and time when the emission measurement was recorded.',
    `epa_permit_number` STRING COMMENT 'Permit number issued by EPA for the emission source.',
    `fuel_type` STRING COMMENT 'Primary fuel used by the emission source during the reporting period.. Valid values are `Coal|Natural_Gas|Oil|Biomass|Nuclear|Wind`',
    `location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the emission source.',
    `location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the emission source.',
    `measurement_method` STRING COMMENT 'Method used to obtain the emission measurement.. Valid values are `CEMS|Manual|Estimated`',
    `notes` STRING COMMENT 'Free‑form comments or observations about the emission measurement.',
    `pollutant_type` STRING COMMENT 'Type of pollutant measured for the emission record.. Valid values are `SO2|NOx|CO2|Mercury|PM`',
    `regulatory_limit` DECIMAL(18,2) COMMENT 'Maximum allowable emission rate for the pollutant as defined by the EPA permit.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period for which the emission is recorded.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period for which the emission is recorded.',
    `reporting_year` STRING COMMENT 'Calendar year associated with the reporting period.',
    `source_category` STRING COMMENT 'Category of the emission source within the facility.. Valid values are `Boiler|Turbine|Generator|Combustion|Process`',
    `source_code` BIGINT COMMENT 'Identifier of the generation asset or facility that produced the emission.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the emission record.',
    CONSTRAINT pk_environmental_emission PRIMARY KEY(`environmental_emission_id`)
) COMMENT 'Air emissions monitoring and reporting records for utility generation facilities subject to EPA Clean Air Act (CAA) Title V permits, including SO2, NOx, CO2, mercury, and particulate matter. Captures emission source unit, pollutant type, measured emission rate, regulatory limit, compliance status, and EIA/EPA reporting period. Supports EPA continuous emissions monitoring system (CEMS) data and annual emissions inventory reporting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` (
    `environmental_compliance_id` BIGINT COMMENT 'Primary key for environmental_compliance',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Compliance permits are overseen by a compliance officer employee; the Permit Compliance Register records compliance_officer_employee_id.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Environmental compliance activities incur costs; linking to cost_center supports financial reporting of compliance spend.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Environmental permits are issued to specific facilities; permit status is monitored at the facility level.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Environmental permits are issued to specific plants; the link supports compliance status tracking.',
    `safety_audit_id` BIGINT COMMENT 'Foreign key linking to safety.safety_audit. Business justification: Environmental compliance records are generated from a safety audit; associate with SAFETY_AUDIT for traceability.',
    `compliance_audit_date` DATE COMMENT 'Date when a formal compliance audit was performed.',
    `compliance_audit_result` STRING COMMENT 'Outcome of the compliance audit.. Valid values are `pass|fail|conditional`',
    `compliance_status` STRING COMMENT 'Overall compliance determination for the reporting period.. Valid values are `compliant|non_compliant|conditionally_compliant|pending`',
    `corrective_action_required` STRING COMMENT 'Description of any corrective actions mandated due to exceedances or violations.',
    `corrective_action_status` STRING COMMENT 'Current status of the corrective action plan.. Valid values are `not_started|in_progress|completed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit record was first created in the system.',
    `effective_date` DATE COMMENT 'Date the permit becomes effective.',
    `emission_limit_co2_tons` DECIMAL(18,2) COMMENT 'Regulatory limit for carbon dioxide emissions (tons).',
    `emission_limit_mercury_pounds` DECIMAL(18,2) COMMENT 'Regulatory limit for mercury emissions (pounds).',
    `emission_limit_nox_tons` DECIMAL(18,2) COMMENT 'Regulatory limit for nitrogen oxides emissions (tons).',
    `emission_limit_pm2_5_tons` DECIMAL(18,2) COMMENT 'Regulatory limit for fine particulate matter emissions (tons).',
    `emission_limit_so2_tons` DECIMAL(18,2) COMMENT 'Regulatory limit for sulfur dioxide emissions (tons) for the permit period.',
    `emission_source_description` STRING COMMENT 'Human‑readable description of the emission source unit.',
    `emission_source_unit_code` STRING COMMENT 'Identifier of the equipment or process generating emissions.',
    `exceedance_flag_co2` BOOLEAN COMMENT 'True if measured CO₂ exceeds the permit limit.',
    `exceedance_flag_mercury` BOOLEAN COMMENT 'True if measured mercury exceeds the permit limit.',
    `exceedance_flag_nox` BOOLEAN COMMENT 'True if measured NOₓ exceeds the permit limit.',
    `exceedance_flag_pm2_5` BOOLEAN COMMENT 'True if measured PM2.5 exceeds the permit limit.',
    `exceedance_flag_so2` BOOLEAN COMMENT 'True if measured SO₂ exceeds the permit limit for the period.',
    `expiration_date` DATE COMMENT 'Date the permit expires or must be renewed.',
    `hazardous_waste_disposal_method` STRING COMMENT 'Method used to dispose of or treat hazardous waste.. Valid values are `landfill|incineration|recycling|other`',
    `hazardous_waste_quantity_tons` DECIMAL(18,2) COMMENT 'Total quantity of hazardous waste generated or handled during the period.',
    `hazardous_waste_type` STRING COMMENT 'Classification of hazardous waste covered by the permit.. Valid values are `rcra|universal|other`',
    `issuing_agency` STRING COMMENT 'Regulatory body that issued the permit.. Valid values are `EPA|State|Local|Tribal|Other`',
    `last_compliance_review_date` DATE COMMENT 'Date of the most recent compliance review or audit.',
    `measured_co2_tons` DECIMAL(18,2) COMMENT 'Total carbon dioxide emissions measured for the reporting period (tons).',
    `measured_mercury_pounds` DECIMAL(18,2) COMMENT 'Total mercury emissions measured for the reporting period (pounds).',
    `measured_nox_tons` DECIMAL(18,2) COMMENT 'Total nitrogen oxides emissions measured for the reporting period (tons).',
    `measured_pm2_5_tons` DECIMAL(18,2) COMMENT 'Total fine particulate matter emissions measured for the reporting period (tons).',
    `measured_so2_tons` DECIMAL(18,2) COMMENT 'Total sulfur dioxide emissions measured for the reporting period (tons).',
    `notes` STRING COMMENT 'Free‑form notes related to the permit or compliance activities.',
    `permit_condition_summary` STRING COMMENT 'Brief description of key permit conditions and obligations.',
    `permit_number` STRING COMMENT 'Official permit number assigned by the issuing regulatory agency.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit.. Valid values are `active|suspended|revoked|expired|pending`',
    `permit_type` STRING COMMENT 'Category of the environmental permit (e.g., air emissions, water discharge, hazardous waste).. Valid values are `air|water|hazardous_waste|rcr|title_v`',
    `renewal_date` DATE COMMENT 'Scheduled date for permit renewal.',
    `reporting_frequency` STRING COMMENT 'How often the permit requires emissions or discharge reporting.. Valid values are `monthly|quarterly|annually|ad_hoc`',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period covered by the data.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period covered by the data.',
    `source_system` STRING COMMENT 'Originating operational system of record for the permit data.. Valid values are `SAP|Oracle|PI|Maximo|Other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the permit record.',
    `water_effluent_limit_gal_per_day` DECIMAL(18,2) COMMENT 'Maximum allowable water discharge volume per day as defined by the permit.',
    `water_effluent_measured_gal_per_day` DECIMAL(18,2) COMMENT 'Actual water discharge volume measured for the reporting period.',
    `water_exceedance_flag` BOOLEAN COMMENT 'True if measured water discharge exceeds the permit limit.',
    CONSTRAINT pk_environmental_compliance PRIMARY KEY(`environmental_compliance_id`)
) COMMENT 'Environmental compliance management records encompassing operating permits (EPA Title V air, NPDES water discharge, RCRA hazardous waste, state agency permits), air emissions monitoring and reporting (SO2, NOx, CO2, mercury, PM under CAA Title V including CEMS continuous data and annual emissions inventory), water discharge monitoring (effluent limits, DMR reporting), and periodic environmental sampling (groundwater, stormwater, soil). Tracks permit conditions, emission source units, measured emission rates vs. regulatory limits, monitoring station results, exceedance flags and notifications, compliance status, and EPA/EIA reporting period data. Serves as the SSOT for all environmental regulatory compliance obligations, monitoring evidence, and emissions reporting. No separate emissions product exists — all emissions data lives here.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` (
    `pipeline_integrity_assessment_id` BIGINT COMMENT 'Unique surrogate key for each pipeline integrity assessment record.',
    `assessor_employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who performed the assessment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Integrity assessment projects are funded by cost centers; linking enables tracking of assessment expenses and budgeting.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or contractor who performed the assessment.',
    `gas_main_id` BIGINT COMMENT 'Identifier of the pipeline segment that was assessed.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Integrity assessments are tied to the physical site where a pipeline segment resides for risk management.',
    `assessment_date` DATE COMMENT 'Calendar date on which the assessment was conducted.',
    `assessment_method` STRING COMMENT 'Technique used to perform the integrity assessment: Inline Inspection (ILI), pressure test, or direct assessment.. Valid values are `ili|pressure_test|direct_assessment`',
    `assessment_name` STRING COMMENT 'Human‑readable name or title for the assessment, often combining segment ID and date.',
    `assessment_number` STRING COMMENT 'External business identifier assigned to the assessment, used in regulatory filings and internal tracking.',
    `assessment_status` STRING COMMENT 'Current lifecycle status of the assessment record.. Valid values are `pending|in_progress|completed|failed`',
    `assessor_name` STRING COMMENT 'Full name of the assessor.',
    `compliance_due_date` DATE COMMENT 'Regulatory deadline by which the required repair or mitigation must be completed.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the assessment record was first created in the system.',
    `defect_length_mm` DECIMAL(18,2) COMMENT 'Measured length of the defect in millimetres.',
    `defect_severity` STRING COMMENT 'Severity rating assigned to the defect based on potential impact.. Valid values are `low|moderate|high|critical`',
    `defect_type` STRING COMMENT 'Category of defect identified during the assessment.. Valid values are `corrosion|crack|dent|external_damage|other`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the identified defect is classified as critical for safety.',
    `location_latitude` DOUBLE COMMENT 'Geographic latitude of the segment midpoint (decimal degrees).',
    `location_longitude` DOUBLE COMMENT 'Geographic longitude of the segment midpoint (decimal degrees).',
    `notes` STRING COMMENT 'Free‑form comments from the assessor, including observations and recommendations.',
    `regulatory_body` STRING COMMENT 'Governing agency overseeing the assessment, typically PHMSA.',
    `regulatory_reference` STRING COMMENT 'Citation to the specific CFR part or PHMSA directive (e.g., 49 CFR Part 192).',
    `repair_priority` STRING COMMENT 'Priority classification for corrective action.. Valid values are `low|medium|high|critical`',
    `risk_rating` DECIMAL(18,2) COMMENT 'Quantitative risk score derived from defect severity, length, and pipeline criticality.',
    `segment_end_mile` DECIMAL(18,2) COMMENT 'Ending milepost of the assessed segment.',
    `segment_start_mile` DECIMAL(18,2) COMMENT 'Starting milepost of the assessed segment measured from the pipelines origin.',
    `total_defect_length_mm` DECIMAL(18,2) COMMENT 'Aggregate length of all defects in the segment, expressed in millimetres.',
    `total_defects` STRING COMMENT 'Count of distinct defects recorded for the segment during this assessment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the assessment record.',
    CONSTRAINT pk_pipeline_integrity_assessment PRIMARY KEY(`pipeline_integrity_assessment_id`)
) COMMENT 'PHMSA-mandated pipeline integrity management assessments for natural gas transmission and distribution pipelines. Captures assessment method (ILI inline inspection, pressure test, direct assessment), pipeline segment assessed, assessment date, defects identified, repair priority classification, and regulatory due date compliance. Supports PHMSA 49 CFR Part 192/195 integrity management program (IMP) requirements.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` (
    `cip_compliance_record_id` BIGINT COMMENT 'Unique surrogate key for the CIP compliance evidence record.',
    `asset_registry_id` BIGINT COMMENT 'Identifier of the physical or logical asset covered by the CIP requirement.',
    `business_entity_id` BIGINT COMMENT 'Unique identifier of the party responsible for the evidence.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the compliance owner overseeing this record.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: CIP compliance records are maintained per facility to satisfy NERC cyber security requirements.',
    `person_id` BIGINT COMMENT 'Unique identifier of the compliance owner overseeing this record.',
    `registry_id` BIGINT COMMENT 'Identifier of the physical or logical asset covered by the CIP requirement.',
    `audit_critical_findings` STRING COMMENT 'Count of critical findings from the audit.',
    `audit_findings_count` STRING COMMENT 'Number of audit findings identified for this evidence.',
    `audit_major_findings` STRING COMMENT 'Count of major findings from the audit.',
    `audit_minor_findings` STRING COMMENT 'Count of minor findings from the audit.',
    `audit_status` STRING COMMENT 'Current audit workflow status for this evidence.. Valid values are `open|closed|in_progress`',
    `bes_cyber_system_code` STRING COMMENT 'Identifier of the BES cyber system to which this compliance record applies.',
    `cip_requirement` STRING COMMENT 'Specific requirement identifier within the CIP standard (e.g., R1, R2).',
    `cip_standard` STRING COMMENT 'NERC CIP standard applicable to this evidence (e.g., CIP-002, CIP-003).',
    `compliance_owner_name` STRING COMMENT 'Name of the compliance owner.',
    `compliance_period_end` DATE COMMENT 'End date of the compliance reporting period (nullable for open‑ended periods).',
    `compliance_period_start` DATE COMMENT 'Start date of the compliance reporting period.',
    `compliance_period_year` STRING COMMENT 'Calendar year associated with the compliance period.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the compliance record was first created in the lakehouse.',
    `disposition_date` DATE COMMENT 'Date the disposition status was assigned.',
    `disposition_notes` STRING COMMENT 'Additional comments or rationale for the disposition.',
    `disposition_status` STRING COMMENT 'Current disposition of the evidence (self‑certified, audit pending, audit passed, audit failed, exempt).. Valid values are `self_certified|audit_pending|audit_passed|audit_failed|exempt`',
    `evidence_collection_date` DATE COMMENT 'Date the evidence was collected or created.',
    `evidence_description` STRING COMMENT 'Free‑text description of the evidence content and purpose.',
    `evidence_file_hash` STRING COMMENT 'Cryptographic hash (e.g., SHA‑256) of the evidence file for integrity verification.',
    `evidence_file_path` STRING COMMENT 'File system or storage path where the evidence document is stored.',
    `evidence_type` STRING COMMENT 'Category of evidence provided (policy, procedure, log, screenshot, attestation).. Valid values are `policy|procedure|log|screenshot|attestation`',
    `is_confidential` BOOLEAN COMMENT 'Indicates whether the evidence contains confidential information.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the last compliance review or audit of this record.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations.',
    `record_status` STRING COMMENT 'Lifecycle status of the compliance record.. Valid values are `active|inactive|archived`',
    `regulatory_body` STRING COMMENT 'Regulatory authority governing the compliance requirement.. Valid values are `NERC|FERC|PUC|EPA`',
    `responsible_entity_name` STRING COMMENT 'Human‑readable name of the responsible party.',
    `rsaw_mapping` STRING COMMENT 'Reference to the RSAW that maps this evidence to the applicable reliability standard.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the evidence (e.g., Maximo, Oracle).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the compliance record.',
    CONSTRAINT pk_cip_compliance_record PRIMARY KEY(`cip_compliance_record_id`)
) COMMENT 'NERC CIP (Critical Infrastructure Protection) compliance evidence records for bulk electric system (BES) cyber and physical security standards. Tracks CIP standard and requirement (CIP-002 through CIP-014), applicable BES Cyber System or physical asset, evidence type (policy, procedure, log, screenshot, attestation), evidence collection date, compliance period, responsible entity and compliance owner, RSAW (Reliability Standard Audit Worksheet) mapping, and self-certification or audit disposition status. Supports NERC CIP annual self-certification filings, FERC/NERC audit readiness, and internal compliance monitoring programs.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` (
    `emergency_drill_id` BIGINT COMMENT 'Unique identifier for the emergency drill record.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Emergency drills are scheduled per customer location; associating drills with the account supports compliance reporting and drill effectiveness metrics.',
    `location_id` BIGINT COMMENT 'Identifier for the physical location where the drill took place.',
    `employee_id` BIGINT COMMENT 'Identifier of the primary responder leading the drill.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Emergency drills are scheduled at specific generating plants for preparedness and regulatory drills reporting.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Emergency drills are scheduled for each site; drill results are reported per site for emergency preparedness compliance.',
    `rescheduled_from_emergency_drill_id` BIGINT COMMENT 'Self-referencing FK on emergency_drill (rescheduled_from_emergency_drill_id)',
    `after_action_report_url` STRING COMMENT 'Link to the detailed after‑action report document.',
    `agencies_involved` STRING COMMENT 'List of external agencies or partners that participated.',
    `compliance_status` STRING COMMENT 'Overall compliance outcome of the drill against applicable regulations.. Valid values are `compliant|non_compliant|partial`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the drill record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for cost fields.. Valid values are `[A-Z]{3}`',
    `drill_cost_actual` DECIMAL(18,2) COMMENT 'Actual expenditure incurred for the drill.',
    `drill_cost_estimate` DECIMAL(18,2) COMMENT 'Budgeted cost for conducting the drill.',
    `drill_number` STRING COMMENT 'Unique business identifier assigned to each drill.',
    `drill_timestamp` TIMESTAMP COMMENT 'Date and time when the drill was performed.',
    `drill_type` STRING COMMENT 'Category of drill execution method (e.g., tabletop, functional, full-scale).. Valid values are `tabletop|functional|full_scale`',
    `duration_minutes` STRING COMMENT 'Total elapsed time of the drill in minutes.',
    `emergency_drill_status` STRING COMMENT 'Current lifecycle state of the drill.. Valid values are `planned|in_progress|completed|cancelled`',
    `equipment_used` STRING COMMENT 'Key equipment and resources deployed during the drill.',
    `findings_summary` STRING COMMENT 'High‑level summary of findings from the drill.',
    `improvement_items` STRING COMMENT 'List of corrective actions or improvements identified.',
    `lead_responder_name` STRING COMMENT 'Full name of the lead responder.',
    `mutual_aid_partners` STRING COMMENT 'External mutual‑aid organizations coordinated with for the drill.',
    `next_drill_due_date` DATE COMMENT 'Planned date for the next required drill.',
    `notes` STRING COMMENT 'Free‑form field for any extra information.',
    `number_of_participants` STRING COMMENT 'Count of individuals who took part in the drill.',
    `objectives` STRING COMMENT 'Specific performance objectives the drill is intended to achieve.',
    `regulatory_body` STRING COMMENT 'Regulatory authority governing the drill requirements.. Valid values are `OSHA|PHMSA|NRC|State|Local`',
    `risk_assessment_score` STRING COMMENT 'Score representing the risk level identified during the drill.',
    `safety_observations_recorded` BOOLEAN COMMENT 'Indicates whether safety observations were captured during the drill.',
    `scenario_description` STRING COMMENT 'Narrative description of the emergency scenario simulated.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the drill record.',
    CONSTRAINT pk_emergency_drill PRIMARY KEY(`emergency_drill_id`)
) COMMENT 'Emergency drill and exercise records documenting planned and executed emergency response exercises required by OSHA 1910.38 (emergency action plans), PHMSA 49 CFR 192.615 (gas pipeline emergency response), NRC emergency preparedness (nuclear), and state/local fire marshal requirements. Captures drill type (tabletop, functional, full-scale), scenario description, participating personnel and agencies, drill date, performance objectives, after-action findings, improvement items, and regulatory compliance status. Supports annual drill compliance tracking, mutual aid coordination documentation, and emergency preparedness program effectiveness measurement.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`safety`.`emergency_response_plan` (
    `emergency_response_plan_id` BIGINT COMMENT 'Primary key for emergency_response_plan',
    `superseded_emergency_response_plan_id` BIGINT COMMENT 'Self-referencing FK on emergency_response_plan (superseded_emergency_response_plan_id)',
    `activation_trigger` STRING COMMENT 'Condition or event that initiates the emergency response plan.',
    `applicable_facilities` STRING COMMENT 'Comma‑separated list of facility identifiers the plan applies to.',
    `approval_date` DATE COMMENT 'Date when the plan received formal approval.',
    `approval_status` STRING COMMENT 'Current approval state of the plan.',
    `approved_by` STRING COMMENT 'Name of the individual or authority that approved the plan.',
    `author_name` STRING COMMENT 'Name of the individual or team that authored the plan.',
    `communication_protocol` STRING COMMENT 'Primary communication method(s) used during activation.',
    `contact_email` STRING COMMENT 'Primary email address for plan coordination.',
    `contact_phone` STRING COMMENT 'Primary phone number for plan coordination.',
    `creation_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan record was first created in the system.',
    `document_url` STRING COMMENT 'Link to the stored digital copy of the plan document.',
    `drill_frequency_days` STRING COMMENT 'Number of days between mandatory emergency drills for this plan.',
    `effective_end_date` DATE COMMENT 'Date when the plan expires or is superseded; null if indefinite.',
    `effective_start_date` DATE COMMENT 'Date when the plan becomes operational.',
    `geographic_scope` STRING COMMENT 'Geographic region(s) the plan covers.',
    `hazard_category` STRING COMMENT 'Primary hazard type addressed by the plan.',
    `last_drill_date` DATE COMMENT 'Date of the most recent drill conducted under this plan.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the plan record.',
    `next_drill_date` DATE COMMENT 'Scheduled date for the next required drill.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next plan review.',
    `notes` STRING COMMENT 'Free‑form field for additional comments or observations.',
    `owner_department` STRING COMMENT 'Organizational department responsible for the plan.',
    `plan_name` STRING COMMENT 'Descriptive name of the emergency response plan.',
    `plan_type` STRING COMMENT 'Category of incident the plan addresses.',
    `regulatory_compliance_codes` STRING COMMENT 'List of regulatory codes (e.g., OSHA, EPA) that the plan satisfies.',
    `resource_requirements` STRING COMMENT 'Key resources (personnel, equipment, supplies) required to execute the plan.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory plan reviews.',
    `risk_level` STRING COMMENT 'Overall risk rating assigned to the plan.',
    `severity` STRING COMMENT 'Potential severity of incidents covered by the plan.',
    `emergency_response_plan_status` STRING COMMENT 'Current lifecycle status of the plan.',
    `training_required` BOOLEAN COMMENT 'Indicates whether personnel must complete specific training to execute the plan.',
    `version_number` STRING COMMENT 'Version identifier for the plan, e.g., v1.2.',
    CONSTRAINT pk_emergency_response_plan PRIMARY KEY(`emergency_response_plan_id`)
) COMMENT 'Master reference table for emergency_response_plan. Referenced by emergency_response_plan_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ADD CONSTRAINT `fk_safety_incident_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `power_and_utilities_v2`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ADD CONSTRAINT `fk_safety_observation_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ADD CONSTRAINT `fk_safety_audit_finding_safety_audit_id` FOREIGN KEY (`safety_audit_id`) REFERENCES `power_and_utilities_v2`.`safety`.`safety_audit`(`safety_audit_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ADD CONSTRAINT `fk_safety_corrective_action_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ADD CONSTRAINT `fk_safety_hazmat_release_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `power_and_utilities_v2`.`safety`.`incident`(`incident_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ADD CONSTRAINT `fk_safety_training_safety_program_id` FOREIGN KEY (`safety_program_id`) REFERENCES `power_and_utilities_v2`.`safety`.`safety_program`(`safety_program_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ADD CONSTRAINT `fk_safety_environmental_compliance_safety_audit_id` FOREIGN KEY (`safety_audit_id`) REFERENCES `power_and_utilities_v2`.`safety`.`safety_audit`(`safety_audit_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ADD CONSTRAINT `fk_safety_emergency_drill_rescheduled_from_emergency_drill_id` FOREIGN KEY (`rescheduled_from_emergency_drill_id`) REFERENCES `power_and_utilities_v2`.`safety`.`emergency_drill`(`emergency_drill_id`);
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_response_plan` ADD CONSTRAINT `fk_safety_emergency_response_plan_superseded_emergency_response_plan_id` FOREIGN KEY (`superseded_emergency_response_plan_id`) REFERENCES `power_and_utilities_v2`.`safety`.`emergency_response_plan`(`emergency_response_plan_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`safety` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `power_and_utilities_v2`.`safety` SET TAGS ('dbx_domain' = 'safety');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `asset_permit_compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `asset_risk_risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `contractor_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `contractor_vendor_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `contractor_vendor_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Service Point Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `ot_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Employee ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `risk_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `vendor_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `vendor_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `dart_days` SET TAGS ('dbx_business_glossary_term' = 'DART Days');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `equipment_involved` SET TAGS ('dbx_business_glossary_term' = 'Equipment Involved');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `fatality_flag` SET TAGS ('dbx_business_glossary_term' = 'Fatality Flag');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `fed_notification_date` SET TAGS ('dbx_business_glossary_term' = 'Federal Notification Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_business_glossary_term' = 'Incident Category');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `incident_category` SET TAGS ('dbx_value_regex' = 'environmental|electrical|mechanical|chemical|other');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `incident_number` SET TAGS ('dbx_business_glossary_term' = 'Incident Number');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_business_glossary_term' = 'Incident Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `incident_status` SET TAGS ('dbx_value_regex' = 'open|under_investigation|closed|reopened');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `incident_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Incident Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `incident_type` SET TAGS ('dbx_business_glossary_term' = 'Incident Type');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `injury_body_part` SET TAGS ('dbx_business_glossary_term' = 'Injury Body Part');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_business_glossary_term' = 'Injury Severity');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `injury_severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|severe|critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `injury_type` SET TAGS ('dbx_business_glossary_term' = 'Injury Type');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `injury_type` SET TAGS ('dbx_value_regex' = 'first_aid|medical_treatment|restricted_duty|lost_time|fatality');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `investigation_complete_date` SET TAGS ('dbx_business_glossary_term' = 'Investigation Completion Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_business_glossary_term' = 'Investigation Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `investigation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `is_osha_recordable` SET TAGS ('dbx_business_glossary_term' = 'OSHA Recordable Flag');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `is_reported_to_fed` SET TAGS ('dbx_business_glossary_term' = 'Reported to Federal Agency Flag');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `is_reported_to_puc` SET TAGS ('dbx_business_glossary_term' = 'Reported to PUC Flag');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `last_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `lost_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lost Time Days');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `medical_treatment_required` SET TAGS ('dbx_business_glossary_term' = 'Medical Treatment Required');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `medical_treatment_required` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `medical_treatment_required` SET TAGS ('dbx_pii_health' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `near_miss_flag` SET TAGS ('dbx_business_glossary_term' = 'Near Miss Flag');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `notification_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Sent Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `puc_notification_date` SET TAGS ('dbx_business_glossary_term' = 'PUC Notification Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `regulatory_notification_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Required');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `report_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Report Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `restricted_duty_days` SET TAGS ('dbx_business_glossary_term' = 'Restricted Duty Days');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `root_cause_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Subcategory');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Incident Severity');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `shift` SET TAGS ('dbx_business_glossary_term' = 'Work Shift');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `shift` SET TAGS ('dbx_value_regex' = 'day|night|swing');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Incident Subcategory');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `weather_condition` SET TAGS ('dbx_business_glossary_term' = 'Weather Condition');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `weather_condition` SET TAGS ('dbx_value_regex' = 'clear|rain|snow|wind|storm');
ALTER TABLE `power_and_utilities_v2`.`safety`.`incident` ALTER COLUMN `witness_count` SET TAGS ('dbx_business_glossary_term' = 'Witness Count');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` SET TAGS ('dbx_subdomain' = 'safety_programs');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Business Entity Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Identifier (RO_ID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Identifier (RO_ID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `audit_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Audit Frequency (Months) (AF_MTH)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline (CD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRT_TS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `documentation_url` SET TAGS ('dbx_business_glossary_term' = 'Program Documentation URL (DOC_URL)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `effectiveness_metric` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Metric (EM)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `effectiveness_score` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Score (ES)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Program End Date (PED)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory (MANDATORY)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date (LAD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LRD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `next_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Date (NAD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (NRD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Program Owner Department (POD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category (PCAT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'safety|environment|process|emergency|training');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code (PC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description (PDESC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name (PN)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `program_scope` SET TAGS ('dbx_business_glossary_term' = 'Program Scope (PSCOPE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status (PS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending|suspended');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type (PT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'occupational|environmental|process|emergency|training');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation (RC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `responsible_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Name (RO_NAME)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months) (RC_MTH)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Program Risk Level (PRL)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Start Date (PSD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `training_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Program Training Frequency (Months) (TRAIN_FREQ_MTH)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Program Training Required (TRAIN_REQ)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_program` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Program Version (PV)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` SET TAGS ('dbx_subdomain' = 'safety_programs');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `observation_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Observation ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `distribution_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Transformer Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Observer ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `metering_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `ot_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `pole_id` SET TAGS ('dbx_business_glossary_term' = 'Pole Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `behavior_description` SET TAGS ('dbx_business_glossary_term' = 'Behavior Description');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Condition Description');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `corrective_action_taken` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Taken');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Due Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Is Critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_business_glossary_term' = 'Observation Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `observation_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `observation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Observation Timestamp (TS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `observation_type` SET TAGS ('dbx_business_glossary_term' = 'Observation Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `observation_type` SET TAGS ('dbx_value_regex' = 'safe_act|at_risk_behavior|safe_condition|unsafe_condition');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_business_glossary_term' = 'Observer Full Name (NAME)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `observer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `severity_level` SET TAGS ('dbx_business_glossary_term' = 'Severity Level');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `severity_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'WFM|Manual|MobileApp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`observation` ALTER COLUMN `work_activity` SET TAGS ('dbx_business_glossary_term' = 'Work Activity');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `metering_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Responsible Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (AUDIT_NO)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status (AUDIT_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|closed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (AUDIT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'scheduled|unannounced|regulatory|internal');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `compliance_rating` SET TAGS ('dbx_business_glossary_term' = 'Compliance Rating');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `compliance_rating` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `findings_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Findings Count');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `findings_major` SET TAGS ('dbx_business_glossary_term' = 'Major Findings Count');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `findings_minor` SET TAGS ('dbx_business_glossary_term' = 'Minor Findings Count');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `findings_observation` SET TAGS ('dbx_business_glossary_term' = 'Observation Findings Count');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `findings_total` SET TAGS ('dbx_business_glossary_term' = 'Total Findings Count');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `location_code` SET TAGS ('dbx_business_glossary_term' = 'Location Code');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `overall_disposition` SET TAGS ('dbx_business_glossary_term' = 'Overall Disposition');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `overall_disposition` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report URL');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `team` SET TAGS ('dbx_business_glossary_term' = 'Audit Team');
ALTER TABLE `power_and_utilities_v2`.`safety`.`safety_audit` ALTER COLUMN `total_penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Penalty Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `audit_finding_id` SET TAGS ('dbx_business_glossary_term' = 'Audit Finding ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Finding Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `audit_category` SET TAGS ('dbx_value_regex' = 'inspection|audit|review');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `audit_finding_description` SET TAGS ('dbx_business_glossary_term' = 'Finding Description');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `audit_finding_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|rejected');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `audit_team` SET TAGS ('dbx_business_glossary_term' = 'Audit Team');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'internal|external|regulatory');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Finding Closure Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Finding Comments');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `corrective_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Due Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `corrective_action_owner` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Owner');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|deferred');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `finding_number` SET TAGS ('dbx_business_glossary_term' = 'Finding Number');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_business_glossary_term' = 'Finding Type');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `finding_type` SET TAGS ('dbx_value_regex' = 'safety|environment|regulatory|operational');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `follow_up_action` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Action');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Finding Location');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `observation_details` SET TAGS ('dbx_business_glossary_term' = 'Observation Details');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `regulatory_citation` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Citation');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Finding Severity');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'critical|major|minor|observation');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Finding Title');
ALTER TABLE `power_and_utilities_v2`.`safety`.`audit_finding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` SET TAGS ('dbx_subdomain' = 'incident_response');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `corrective_action_id` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `distribution_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Transformer Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Related Incident Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `responsible_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `responsible_party_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `action_category` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Category');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `action_category` SET TAGS ('dbx_value_regex' = 'safety|environment|regulatory');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `action_code` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Code');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `action_description` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Description');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `action_title` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Title');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Type (Corrective|Preventive|Detective)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|detective');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `audit_trail` SET TAGS ('dbx_business_glossary_term' = 'Audit Trail (JSON)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Additional Comments');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Reference');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `compliance_reference` SET TAGS ('dbx_value_regex' = 'OSHA|NERC|EPA|PHMSA');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|completed|closed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Cost Estimate (USD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Rating');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_rating` SET TAGS ('dbx_value_regex' = 'effective|partially_effective|ineffective');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `effectiveness_review_date` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Review Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `is_closed` SET TAGS ('dbx_business_glossary_term' = 'Is Closed Flag');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Priority');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Name');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `responsible_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Risk Level');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Category');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `root_cause_category` SET TAGS ('dbx_value_regex' = 'equipment|process|human|environment|external');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `verification_date` SET TAGS ('dbx_business_glossary_term' = 'Verification Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method');
ALTER TABLE `power_and_utilities_v2`.`safety`.`corrective_action` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'inspection|test|audit|review');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` SET TAGS ('dbx_subdomain' = 'hazard_management');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `hazmat_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Inventory ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Custodian Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `average_quantity` SET TAGS ('dbx_business_glossary_term' = 'Average Quantity On Hand');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `cas_number` SET TAGS ('dbx_business_glossary_term' = 'Chemical Abstracts Service (CAS) Number');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `chemical_name` SET TAGS ('dbx_business_glossary_term' = 'Chemical Name');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `containment_action` SET TAGS ('dbx_business_glossary_term' = 'Containment Action');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Email');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `emergency_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Name');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `emergency_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Emergency Contact Phone');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `emergency_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `environmental_media` SET TAGS ('dbx_business_glossary_term' = 'Environmental Media Affected');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `environmental_media` SET TAGS ('dbx_value_regex' = 'air|water|soil|groundwater');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `epa_rmp_applicable` SET TAGS ('dbx_business_glossary_term' = 'EPA Risk Management Plan Applicability');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `hazmat_inventory_status` SET TAGS ('dbx_business_glossary_term' = 'Material Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `hazmat_inventory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|disposed');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous Flag');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `is_ppe_required` SET TAGS ('dbx_business_glossary_term' = 'Personal Protective Equipment Required');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable Flag');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `max_quantity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity On Hand');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `notification_deadline` SET TAGS ('dbx_business_glossary_term' = 'Notification Deadline');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `ppe_requirements` SET TAGS ('dbx_business_glossary_term' = 'PPE Requirements');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'not_notified|notified|completed');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Release Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `release_point` SET TAGS ('dbx_business_glossary_term' = 'Release Point');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `release_quantity` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `release_quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Release Quantity Unit');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `release_type` SET TAGS ('dbx_value_regex' = 'spill|leak|emission');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `root_cause_description` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `sara_title_iii_tier_ii_reportable` SET TAGS ('dbx_business_glossary_term' = 'SARA Title III Tier II Reportable');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `sds_url` SET TAGS ('dbx_business_glossary_term' = 'Safety Data Sheet URL');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_inventory` ALTER COLUMN `waste_code` SET TAGS ('dbx_business_glossary_term' = 'EPA Waste Code');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` SET TAGS ('dbx_subdomain' = 'hazard_management');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `hazmat_release_id` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Release ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'External Incident ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `cause_category` SET TAGS ('dbx_business_glossary_term' = 'Cause Category');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `cause_category` SET TAGS ('dbx_value_regex' = 'equipment_failure|human_error|natural|unknown');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `cause_description` SET TAGS ('dbx_business_glossary_term' = 'Cause Description');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|completed|exempt');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `containment_method` SET TAGS ('dbx_business_glossary_term' = 'Containment Method');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `corrective_action_plan` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `detection_method` SET TAGS ('dbx_business_glossary_term' = 'Detection Method');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `emergency_response_required` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Required');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `epa_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'EPA Reported Flag');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `follow_up_date` SET TAGS ('dbx_business_glossary_term' = 'Follow-up Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `hazmat_release_status` SET TAGS ('dbx_business_glossary_term' = 'Release Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `hazmat_release_status` SET TAGS ('dbx_value_regex' = 'reported|investigated|closed|rejected');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `incident_description` SET TAGS ('dbx_business_glossary_term' = 'Incident Description');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `is_duplicate_report` SET TAGS ('dbx_business_glossary_term' = 'Is Duplicate Report');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `is_hazardous` SET TAGS ('dbx_business_glossary_term' = 'Is Hazardous');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `is_reportable` SET TAGS ('dbx_business_glossary_term' = 'Is Reportable');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `media_affected` SET TAGS ('dbx_business_glossary_term' = 'Media Affected');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `media_affected` SET TAGS ('dbx_value_regex' = 'air|water|soil|groundwater');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `nrc_reported_flag` SET TAGS ('dbx_business_glossary_term' = 'NRC Reported Flag');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `quantity_released` SET TAGS ('dbx_business_glossary_term' = 'Quantity Released');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `regulatory_notification_status` SET TAGS ('dbx_value_regex' = 'not_notified|notified|pending|completed');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `release_number` SET TAGS ('dbx_business_glossary_term' = 'Release Number');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `release_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Release Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `release_type` SET TAGS ('dbx_business_glossary_term' = 'Release Type');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `release_type` SET TAGS ('dbx_value_regex' = 'spill|leak|emission|accidental|intentional');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `remediation_action` SET TAGS ('dbx_business_glossary_term' = 'Remediation Action');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|not_required');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `report_date` SET TAGS ('dbx_business_glossary_term' = 'Report Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `reported_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `reported_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `state_regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'State Regulatory Agency');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `substance` SET TAGS ('dbx_business_glossary_term' = 'Substance Name');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `substance_cas_number` SET TAGS ('dbx_business_glossary_term' = 'Substance CAS Number');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'gallons|liters|kg|tons|cubic_meters');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `power_and_utilities_v2`.`safety`.`hazmat_release` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` SET TAGS ('dbx_subdomain' = 'safety_programs');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `training_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Training Record ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (EMP_ID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier (EMP_ID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `safety_program_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `certification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Expiration Date (CERT_EXP)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `certification_number` SET TAGS ('dbx_business_glossary_term' = 'Certification Number (CERT_NO)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `certification_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `certification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Date (COMP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `course_code` SET TAGS ('dbx_business_glossary_term' = 'Training Course Code (COURSE_CD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `course_name` SET TAGS ('dbx_business_glossary_term' = 'Training Course Name (COURSE_NAME)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Training Expiration Date (EXP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `hours` SET TAGS ('dbx_business_glossary_term' = 'Training Duration Hours (HOURS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Training Location (LOC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `mandatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Training Flag (MANDATORY)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Training Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_business_glossary_term' = 'Pass/Fail Status (PASS_FAIL)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `pass_fail_status` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `provider_name` SET TAGS ('dbx_business_glossary_term' = 'Training Provider Name (PROV_NAME)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date (RECERT_DUE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `record_number` SET TAGS ('dbx_business_glossary_term' = 'Training Record Number (TRN)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Requirement (REG_REQ)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `regulatory_requirement` SET TAGS ('dbx_value_regex' = 'OSHA|NERC_CIP|PHMSA|DOT');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `score` SET TAGS ('dbx_business_glossary_term' = 'Training Score (SCORE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `training_category` SET TAGS ('dbx_business_glossary_term' = 'Training Category (CATEGORY)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `training_category` SET TAGS ('dbx_value_regex' = 'safety|environmental|compliance|operational|leadership');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `training_mode` SET TAGS ('dbx_business_glossary_term' = 'Training Mode (MODE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `training_mode` SET TAGS ('dbx_value_regex' = 'eLearning|instructor_led|on_the_job|blended');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_business_glossary_term' = 'Training Record Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `training_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|expired|cancelled|failed');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `training_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Training Event Timestamp (EVENT_TS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `training_type` SET TAGS ('dbx_business_glossary_term' = 'Training Delivery Type (TRAIN_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`training` ALTER COLUMN `training_type` SET TAGS ('dbx_value_regex' = 'online|classroom|on_the_job|blended');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` SET TAGS ('dbx_subdomain' = 'hazard_management');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `job_hazard_analysis_id` SET TAGS ('dbx_business_glossary_term' = 'Job Hazard Analysis ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Analyst Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `analysis_type` SET TAGS ('dbx_business_glossary_term' = 'Analysis Type (JHA/JSA)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `analysis_type` SET TAGS ('dbx_value_regex' = 'JHA|JSA');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp (APPROVED_TS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name (APPROVER)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `approver_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `approver_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `author_name` SET TAGS ('dbx_business_glossary_term' = 'Author Name (AUTHOR)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `author_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `author_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments (COMMENTS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|pending');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `control_measures` SET TAGS ('dbx_business_glossary_term' = 'Control Measures (CONTROLS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `department` SET TAGS ('dbx_business_glossary_term' = 'Department (DEPT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `document_version` SET TAGS ('dbx_business_glossary_term' = 'Document Version (DOC_VER)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `emergency_procedure` SET TAGS ('dbx_business_glossary_term' = 'Emergency Procedure (EMERGENCY)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRATION_DT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `hazard_category` SET TAGS ('dbx_business_glossary_term' = 'Hazard Category (CATEGORY)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `hazard_category` SET TAGS ('dbx_value_regex' = 'Electrical|Mechanical|Chemical|Physical|Environmental|Other');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `hazard_identified_date` SET TAGS ('dbx_business_glossary_term' = 'Hazard Identified Date (HAZARD_DATE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `jha_number` SET TAGS ('dbx_business_glossary_term' = 'Job Hazard Analysis Number (JHA)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `job_hazard_analysis_status` SET TAGS ('dbx_business_glossary_term' = 'Analysis Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `job_hazard_analysis_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|approved|active|retired');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `location` SET TAGS ('dbx_business_glossary_term' = 'Location (LOC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `lockout_tagout_required` SET TAGS ('dbx_business_glossary_term' = 'Lockout/Tagout Required (LOTO)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (NEXT_REVIEW)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `permit_required` SET TAGS ('dbx_business_glossary_term' = 'Permit Required (PERMIT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `ppe_required` SET TAGS ('dbx_business_glossary_term' = 'PPE Required (PPE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (REG_REF)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `revision_date` SET TAGS ('dbx_business_glossary_term' = 'Revision Date (REV_DATE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `revision_number` SET TAGS ('dbx_business_glossary_term' = 'Revision Number (REV_NO)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `risk_likelihood` SET TAGS ('dbx_business_glossary_term' = 'Risk Likelihood (LIKELIHOOD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `risk_likelihood` SET TAGS ('dbx_value_regex' = 'Rare|Unlikely|Possible|Likely|Almost_Certain');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `risk_severity` SET TAGS ('dbx_business_glossary_term' = 'Risk Severity (SEVERITY)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `risk_severity` SET TAGS ('dbx_value_regex' = 'Low|Medium|High|Critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `safety_audit_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit Flag (AUDIT_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `task_description` SET TAGS ('dbx_business_glossary_term' = 'Task Description (TASK_DESC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `task_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Task Duration Minutes (DURATION_MIN)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `task_frequency_per_year` SET TAGS ('dbx_business_glossary_term' = 'Task Frequency Per Year (FREQ_YR)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Job Hazard Analysis Title');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `training_required` SET TAGS ('dbx_business_glossary_term' = 'Training Required (TRAINING)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`job_hazard_analysis` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` SET TAGS ('dbx_subdomain' = 'safety_programs');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `permit_to_work_id` SET TAGS ('dbx_business_glossary_term' = 'Permit to Work Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `authorized_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By ID (AUTHID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `contractor_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID (CONID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor ID (REQID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `issuer_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuer ID (ISSID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `ot_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Work Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `primary_permit_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requestor ID (REQID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `primary_permit_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `primary_permit_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `tertiary_permit_authorized_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Authorized By ID (AUTHID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `tertiary_permit_authorized_by_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `tertiary_permit_authorized_by_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID (CONID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `area_code` SET TAGS ('dbx_business_glossary_term' = 'Area Code (AC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `compliance_checklist` SET TAGS ('dbx_business_glossary_term' = 'Compliance Checklist (CC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `confined_space_required` SET TAGS ('dbx_business_glossary_term' = 'Confined Space Required (CSR)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CCY)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned End Timestamp (PET)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `equipment_tag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Tag (ET)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `estimated_cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost Amount (ECA)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `hazard_controls` SET TAGS ('dbx_business_glossary_term' = 'Hazard Controls (HC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `lockout_tagout_required` SET TAGS ('dbx_business_glossary_term' = 'Lockout/Tagout Required (LOTO)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (AN)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `permit_category` SET TAGS ('dbx_business_glossary_term' = 'Permit Category (PC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `permit_category` SET TAGS ('dbx_value_regex' = 'routine|emergency|planned|unscheduled');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `permit_closure_confirmation` SET TAGS ('dbx_business_glossary_term' = 'Permit Closure Confirmation (PCC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `permit_closure_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Permit Closure Timestamp (PCT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number (PN)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `permit_to_work_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status (PS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `permit_to_work_status` SET TAGS ('dbx_value_regex' = 'draft|issued|active|closed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type (PT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'electrical|confined_space|hot_work|excavation|gas_line|general');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `permit_valid_from` SET TAGS ('dbx_business_glossary_term' = 'Permit Valid From (PVF)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `permit_valid_until` SET TAGS ('dbx_business_glossary_term' = 'Permit Valid Until (PVU)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (RR)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `safety_measures` SET TAGS ('dbx_business_glossary_term' = 'Safety Measures (SM)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Start Timestamp (PST)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description (WD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `work_location` SET TAGS ('dbx_business_glossary_term' = 'Work Location (WL)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `work_risk_level` SET TAGS ('dbx_business_glossary_term' = 'Work Risk Level (WRL)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`permit_to_work` ALTER COLUMN `work_risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `environmental_emission_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Emission ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `eia_report_id` SET TAGS ('dbx_business_glossary_term' = 'EIA Report Identifier (ERI)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reporting Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag (DQF)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `emission_factor` SET TAGS ('dbx_business_glossary_term' = 'Emission Factor (EF)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `emission_rate` SET TAGS ('dbx_business_glossary_term' = 'Emission Rate (ER)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `emission_rate_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Rate Unit (ERU)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `emission_rate_unit` SET TAGS ('dbx_value_regex' = 'lb/hr|kg/hr|tonne/hr|g/s');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `emission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Emission Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `epa_permit_number` SET TAGS ('dbx_business_glossary_term' = 'EPA Permit Number (EPN)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type (FT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'Coal|Natural_Gas|Oil|Biomass|Nuclear|Wind');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude (Lat)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude (Lon)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `measurement_method` SET TAGS ('dbx_business_glossary_term' = 'Measurement Method (MM)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `measurement_method` SET TAGS ('dbx_value_regex' = 'CEMS|Manual|Estimated');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (N)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `pollutant_type` SET TAGS ('dbx_business_glossary_term' = 'Pollutant Type (PT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `pollutant_type` SET TAGS ('dbx_value_regex' = 'SO2|NOx|CO2|Mercury|PM');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `regulatory_limit` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Limit (RL)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date (RPED)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date (RPSD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year (RY)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `source_category` SET TAGS ('dbx_business_glossary_term' = 'Source Category (SC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `source_category` SET TAGS ('dbx_value_regex' = 'Boiler|Turbine|Generator|Combustion|Process');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `source_code` SET TAGS ('dbx_business_glossary_term' = 'Source Asset ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_emission` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `environmental_compliance_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Officer Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `safety_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Safety Audit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `compliance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Date (CAD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `compliance_audit_result` SET TAGS ('dbx_business_glossary_term' = 'Compliance Audit Result (CAR)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `compliance_audit_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|conditionally_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required (CAR)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status (CAS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (ED)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `emission_limit_co2_tons` SET TAGS ('dbx_business_glossary_term' = 'CO₂ Emission Limit (tons) (CO2_LIMIT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `emission_limit_mercury_pounds` SET TAGS ('dbx_business_glossary_term' = 'Mercury Emission Limit (lb) (HG_LIMIT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `emission_limit_nox_tons` SET TAGS ('dbx_business_glossary_term' = 'NOₓ Emission Limit (tons) (NOX_LIMIT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `emission_limit_pm2_5_tons` SET TAGS ('dbx_business_glossary_term' = 'PM2.5 Emission Limit (tons) (PM25_LIMIT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `emission_limit_so2_tons` SET TAGS ('dbx_business_glossary_term' = 'SO₂ Emission Limit (tons) (SO2_LIMIT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `emission_source_description` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Description (ESU_DESC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `emission_source_unit_code` SET TAGS ('dbx_business_glossary_term' = 'Emission Source Unit ID (ESU_ID)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `exceedance_flag_co2` SET TAGS ('dbx_business_glossary_term' = 'CO₂ Exceedance Flag (CO2_EXC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `exceedance_flag_mercury` SET TAGS ('dbx_business_glossary_term' = 'Mercury Exceedance Flag (HG_EXC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `exceedance_flag_nox` SET TAGS ('dbx_business_glossary_term' = 'NOₓ Exceedance Flag (NOX_EXC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `exceedance_flag_pm2_5` SET TAGS ('dbx_business_glossary_term' = 'PM2.5 Exceedance Flag (PM25_EXC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `exceedance_flag_so2` SET TAGS ('dbx_business_glossary_term' = 'SO₂ Exceedance Flag (SO2_EXC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `hazardous_waste_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Disposal Method (HW_DM)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `hazardous_waste_disposal_method` SET TAGS ('dbx_value_regex' = 'landfill|incineration|recycling|other');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `hazardous_waste_quantity_tons` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Quantity (tons) (HW_QTY)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `hazardous_waste_type` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Waste Type (HWT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `hazardous_waste_type` SET TAGS ('dbx_value_regex' = 'rcra|universal|other');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency (IA)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_value_regex' = 'EPA|State|Local|Tribal|Other');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `last_compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Review Date (LCRD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `measured_co2_tons` SET TAGS ('dbx_business_glossary_term' = 'Measured CO₂ Emissions (tons) (CO2_MEAS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `measured_mercury_pounds` SET TAGS ('dbx_business_glossary_term' = 'Measured Mercury Emissions (lb) (HG_MEAS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `measured_nox_tons` SET TAGS ('dbx_business_glossary_term' = 'Measured NOₓ Emissions (tons) (NOX_MEAS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `measured_pm2_5_tons` SET TAGS ('dbx_business_glossary_term' = 'Measured PM2.5 Emissions (tons) (PM25_MEAS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `measured_so2_tons` SET TAGS ('dbx_business_glossary_term' = 'Measured SO₂ Emissions (tons) (SO2_MEAS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes (NOTE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `permit_condition_summary` SET TAGS ('dbx_business_glossary_term' = 'Permit Condition Summary (PCS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number (PN)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status (PS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|suspended|revoked|expired|pending');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type (PT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'air|water|hazardous_waste|rcr|title_v');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date (RD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_business_glossary_term' = 'Reporting Frequency (RF)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `reporting_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|ad_hoc');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End (RPE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start (RPS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|PI|Maximo|Other');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `water_effluent_limit_gal_per_day` SET TAGS ('dbx_business_glossary_term' = 'Water Effluent Limit (gal/day) (WEL)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `water_effluent_measured_gal_per_day` SET TAGS ('dbx_business_glossary_term' = 'Measured Water Effluent (gal/day) (WEM)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`environmental_compliance` ALTER COLUMN `water_exceedance_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Exceedance Flag (WEF)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` SET TAGS ('dbx_subdomain' = 'environmental_monitoring');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `pipeline_integrity_assessment_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Integrity Assessment ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `assessor_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assessor ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `gas_main_id` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Segment ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Assessment Date (ASSESS_DATE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_business_glossary_term' = 'Assessment Method (ASSESS_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `assessment_method` SET TAGS ('dbx_value_regex' = 'ili|pressure_test|direct_assessment');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `assessment_name` SET TAGS ('dbx_business_glossary_term' = 'Assessment Name (ASSESS_NAME)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `assessment_number` SET TAGS ('dbx_business_glossary_term' = 'Assessment Number (ASSESS_NUM)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_business_glossary_term' = 'Assessment Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `assessment_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_business_glossary_term' = 'Assessor Name (ASSR_NAME)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `assessor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `compliance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Due Date (DUE_DATE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `defect_length_mm` SET TAGS ('dbx_business_glossary_term' = 'Defect Length (DEFECT_LEN_MM)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `defect_severity` SET TAGS ('dbx_business_glossary_term' = 'Defect Severity (DEFECT_SEV)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `defect_severity` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `defect_type` SET TAGS ('dbx_business_glossary_term' = 'Defect Type (DEFECT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `defect_type` SET TAGS ('dbx_value_regex' = 'corrosion|crack|dent|external_damage|other');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Defect Flag (IS_CRITICAL)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Assessment Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference (REG_REF)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `repair_priority` SET TAGS ('dbx_business_glossary_term' = 'Repair Priority (REPAIR_PRIO)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `repair_priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `segment_end_mile` SET TAGS ('dbx_business_glossary_term' = 'Segment End Mile (END_MILE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `segment_start_mile` SET TAGS ('dbx_business_glossary_term' = 'Segment Start Mile (START_MILE)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `total_defect_length_mm` SET TAGS ('dbx_business_glossary_term' = 'Total Defect Length (TOTAL_DEF_LEN_MM)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `total_defects` SET TAGS ('dbx_business_glossary_term' = 'Total Defects (TOTAL_DEF)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`pipeline_integrity_assessment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` SET TAGS ('dbx_subdomain' = 'compliance_records');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `cip_compliance_record_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Compliance Record ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `asset_registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Entity ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `audit_critical_findings` SET TAGS ('dbx_business_glossary_term' = 'Critical Audit Findings Count');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Total Audit Findings Count');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `audit_major_findings` SET TAGS ('dbx_business_glossary_term' = 'Major Audit Findings Count');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `audit_minor_findings` SET TAGS ('dbx_business_glossary_term' = 'Minor Audit Findings Count');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `bes_cyber_system_code` SET TAGS ('dbx_business_glossary_term' = 'Bulk Electric System (BES) Cyber System ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `cip_requirement` SET TAGS ('dbx_business_glossary_term' = 'CIP Requirement Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `cip_standard` SET TAGS ('dbx_business_glossary_term' = 'NERC Critical Infrastructure Protection (CIP) Standard');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `compliance_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Compliance Owner Name');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `compliance_period_end` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period End Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `compliance_period_start` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `compliance_period_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Period Year');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `disposition_date` SET TAGS ('dbx_business_glossary_term' = 'Disposition Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `disposition_notes` SET TAGS ('dbx_business_glossary_term' = 'Disposition Notes');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Disposition Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'self_certified|audit_pending|audit_passed|audit_failed|exempt');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `evidence_collection_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Collection Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Evidence Description');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `evidence_file_hash` SET TAGS ('dbx_business_glossary_term' = 'Evidence File Hash');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `evidence_file_path` SET TAGS ('dbx_business_glossary_term' = 'Evidence File Path');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `evidence_type` SET TAGS ('dbx_value_regex' = 'policy|procedure|log|screenshot|attestation');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'NERC|FERC|PUC|EPA');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `responsible_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Entity Name');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `rsaw_mapping` SET TAGS ('dbx_business_glossary_term' = 'Reliability Standard Audit Worksheet (RSAW) Mapping');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`safety`.`cip_compliance_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` SET TAGS ('dbx_subdomain' = 'compliance_records');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `emergency_drill_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Drill Location ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Lead Responder ID');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `rescheduled_from_emergency_drill_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `after_action_report_url` SET TAGS ('dbx_business_glossary_term' = 'After‑Action Report URL');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `agencies_involved` SET TAGS ('dbx_business_glossary_term' = 'Participating Agencies');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `drill_cost_actual` SET TAGS ('dbx_business_glossary_term' = 'Actual Drill Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `drill_cost_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Drill Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `drill_number` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill Number');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `drill_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill Execution Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `drill_type` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill Type');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `drill_type` SET TAGS ('dbx_value_regex' = 'tabletop|functional|full_scale');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Drill Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `emergency_drill_status` SET TAGS ('dbx_business_glossary_term' = 'Emergency Drill Status');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `emergency_drill_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `equipment_used` SET TAGS ('dbx_business_glossary_term' = 'Equipment Used in Drill');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `improvement_items` SET TAGS ('dbx_business_glossary_term' = 'Improvement Items Identified');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `lead_responder_name` SET TAGS ('dbx_business_glossary_term' = 'Lead Responder Full Name');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `lead_responder_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `lead_responder_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `mutual_aid_partners` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Partners');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `next_drill_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Drill Date');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `number_of_participants` SET TAGS ('dbx_business_glossary_term' = 'Number of Participants');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `objectives` SET TAGS ('dbx_business_glossary_term' = 'Drill Performance Objectives');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'OSHA|PHMSA|NRC|State|Local');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `risk_assessment_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Score');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `safety_observations_recorded` SET TAGS ('dbx_business_glossary_term' = 'Safety Observations Recorded');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `scenario_description` SET TAGS ('dbx_business_glossary_term' = 'Drill Scenario Description');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_drill` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_response_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_response_plan` SET TAGS ('dbx_subdomain' = 'compliance_records');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_response_plan` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Identifier');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_response_plan` ALTER COLUMN `superseded_emergency_response_plan_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_response_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_response_plan` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_response_plan` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`safety`.`emergency_response_plan` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
