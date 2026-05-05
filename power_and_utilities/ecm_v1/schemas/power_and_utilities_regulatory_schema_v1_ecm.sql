-- Schema for Domain: regulatory | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:19

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`regulatory` COMMENT 'Owns all regulatory filing data, rate case documentation, tariff schedules, and compliance reporting submitted to FERC, NERC, state PUCs, EPA, and PHMSA. Manages CPCN filings, GRC dockets, IRP submissions, NERC CIP compliance evidence, and regulatory correspondence. Serves as the SSOT for approved rates, regulatory assets (RAB), and compliance obligation tracking.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`filing` (
    `filing_id` BIGINT COMMENT 'System-generated unique identifier for the regulatory filing record.',
    `body_id` BIGINT COMMENT 'FK to regulatory.regulatory_body',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Regulatory filing for a large‑customer tariff requires linking to the customer account to track compliance and reporting.',
    `cpcn_application_id` BIGINT COMMENT 'Foreign key linking to regulatory.cpcn_application. Business justification: Filing may be the CPCN application filing.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Link filing to its docket; a filing is submitted to a docket, enabling navigation from filing to docket and consolidating docket_reference.',
    `eia_report_id` BIGINT COMMENT 'Foreign key linking to regulatory.eia_report. Business justification: Filing may be linked to the EIA report it supports.',
    `emission_allowance_id` BIGINT COMMENT 'Foreign key linking to regulatory.emission_allowance. Business justification: Filing may be linked to emission allowance transactions.',
    `employee_id` BIGINT COMMENT 'System identifier of the user who created the filing record.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Regulatory filings (e.g., EPA permits, FERC reports) are filed per facility; linking enables facility‑specific compliance tracking.',
    `ferc_form_id` BIGINT COMMENT 'Foreign key linking to regulatory.ferc_form. Business justification: Filing may be associated with the FERC form submission.',
    `irp_submission_id` BIGINT COMMENT 'Foreign key linking to regulatory.irp_submission. Business justification: Filing can be associated with an IRP submission when the filing is part of the IRP process.',
    `large_customer_contract_id` BIGINT COMMENT 'Foreign key linking to engagement.large_customer_contract. Business justification: Regulatory filings (e.g., tariff or rate filings) are required for large customer contracts; linking tracks which filing supports which contract.',
    `mitigation_plan_id` BIGINT COMMENT 'Foreign key linking to regulatory.mitigation_plan. Business justification: Filing may reference mitigation plan developed for a compliance issue.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Regulatory filings (e.g., environmental permits, construction approvals) are submitted per generation plant; linking enables tracking which plant each filing concerns.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to regulatory.environmental_permit. Business justification: Filing may be linked to the environmental permit it supports.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: A filing belongs to a rate case (e.g., GRC filing); adds parent relationship.',
    `asset_capex_project_id` BIGINT COMMENT 'Identifier of the capital or regulatory project linked to the filing.',
    `finance_capex_project_id` BIGINT COMMENT 'Identifier of the capital or regulatory project linked to the filing.',
    `responsible_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory filing preparation is assigned to a specific compliance employee; the filing record must reference that employee for accountability.',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Filing may reference the tariff schedule it supports.',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to regulatory.violation_notice. Business justification: Filing may be the source of a violation notice.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of adjustments, taxes, or fees applied to the gross amount.',
    `amendment_number` STRING COMMENT 'Sequential number indicating the amendment version of the filing.',
    `approval_date` DATE COMMENT 'Date the filing was approved by the regulator, if applicable.',
    `comments` STRING COMMENT 'Additional free‑form comments or notes about the filing.',
    `compliance_deadline` DATE COMMENT 'Regulatory deadline by which the filing must be submitted.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the filing record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `file_url` STRING COMMENT 'Link to the stored electronic copy of the filing document.',
    `filing_category` STRING COMMENT 'High‑level business category of the filing.. Valid values are `compliance|rate_case|planning|environmental`',
    `filing_date` DATE COMMENT 'Date the filing was officially submitted to the regulator.',
    `filing_description` STRING COMMENT 'Brief narrative describing the purpose and content of the filing.',
    `filing_method` STRING COMMENT 'Method used to submit the filing.. Valid values are `electronic|paper|portal`',
    `filing_number` STRING COMMENT 'Official filing number or docket identifier assigned by the regulatory body.',
    `filing_status` STRING COMMENT 'Current lifecycle status of the filing.. Valid values are `draft|submitted|approved|rejected|withdrawn|closed`',
    `filing_type` STRING COMMENT 'Category of the filing indicating the regulatory form or submission type. [ENUM-REF-CANDIDATE: FERC_FORM|EIA_SURVEY|IRP|RATE_CASE_FILING|CPCN|CIP_CERTIFICATION|ENVIRONMENTAL|OTHER — 8 candidates stripped; promote to reference product]',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross monetary amount reported in the filing before adjustments.',
    `is_amendment` BOOLEAN COMMENT 'Indicates whether the filing is an amendment to a prior submission.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net monetary amount after adjustments.',
    `priority` STRING COMMENT 'Priority level assigned to the filing for internal processing.. Valid values are `high|medium|low`',
    `regulatory_body` STRING COMMENT 'Regulatory agency to which the filing was submitted (e.g., FERC, NERC, EPA).',
    `rejection_reason` STRING COMMENT 'Explanation provided by the regulator for a rejected filing.',
    `reporting_period_end` DATE COMMENT 'End date of the reporting period covered by the filing.',
    `reporting_period_start` DATE COMMENT 'Start date of the reporting period covered by the filing.',
    `responsible_unit` STRING COMMENT 'Internal business unit or department responsible for the filing.',
    `submission_method` STRING COMMENT 'Channel through which the filing was submitted to the regulator.. Valid values are `web_portal|email|mail|fax`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the filing record.',
    `version` STRING COMMENT 'Version label or identifier for the filing document.',
    CONSTRAINT pk_filing PRIMARY KEY(`filing_id`)
) COMMENT 'Master record for every regulatory filing or submission made by the utility to any regulatory body (FERC, NERC, state PUCs, EPA, PHMSA, DOE, EIA). Encompasses rate case filings, IRP submissions, CPCN applications, NERC CIP self-certifications, environmental permit applications, FERC Forms (1, 2, 714), EIA surveys (860, 861, 923), and all other mandatory or voluntary regulatory submissions. Captures filing type, form number, docket reference, filing date, regulatory body, filing status, submission method, responsible organizational unit, reporting period, key reported metrics, financial data summaries, IRP planning horizon and resource mix details, and amendment history. Discriminated by filing_type (FERC_FORM, EIA_SURVEY, IRP, RATE_CASE_FILING, CPCN, CIP_CERTIFICATION, ENVIRONMENTAL, OTHER) to support form-specific attributes. Serves as the SSOT for all regulatory submission events and their lifecycle from draft through final disposition.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`docket` (
    `docket_id` BIGINT COMMENT 'System-generated unique identifier for the docket record.',
    `employee_id` BIGINT COMMENT 'Identifier of the regulatory affairs staff member responsible for the docket.',
    `amendment_count` STRING COMMENT 'Number of formal amendments filed for the docket.',
    `closure_date` DATE COMMENT 'Date the docket was formally closed or archived.',
    `confidentiality_level` STRING COMMENT 'Level of confidentiality applied to the docket information.. Valid values are `public|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the docket record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `current_status` STRING COMMENT 'Current lifecycle status of the docket.. Valid values are `open|closed|pending|withdrawn|settled|appealed`',
    `decision_date` DATE COMMENT 'Date the regulatory decision was issued.',
    `decision_summary` STRING COMMENT 'Brief summary of the regulatory decision and its implications.',
    `docket_category` STRING COMMENT 'High‑level business domain category of the docket.. Valid values are `energy|gas|environment|safety|market`',
    `docket_description` STRING COMMENT 'Detailed narrative describing the docket purpose and scope.',
    `docket_number` STRING COMMENT 'Official docket number assigned by the regulatory body.',
    `expected_decision_date` DATE COMMENT 'Projected date for the regulatory decision.',
    `filing_date` DATE COMMENT 'Date the initial filing was submitted to the regulatory body.',
    `is_appealed` BOOLEAN COMMENT 'Indicates whether the docket has been appealed to a higher authority.',
    `is_confidential` BOOLEAN COMMENT 'True if the docket contains confidential information subject to restricted access.',
    `is_settled` BOOLEAN COMMENT 'Indicates whether the docket has been settled or resolved outside of formal decision.',
    `jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction (e.g., state abbreviation) for the docket.',
    `last_response_date` DATE COMMENT 'Date the last response was actually submitted.',
    `last_response_due_date` DATE COMMENT 'Date by which the most recent required response must be submitted.',
    `next_action_description` STRING COMMENT 'Description of the upcoming required action for the docket.',
    `next_action_due_date` DATE COMMENT 'Date by which the next required action must be completed.',
    `open_date` DATE COMMENT 'Date the docket was opened by the regulatory body.',
    `outcome` STRING COMMENT 'Final outcome of the docket after decision.. Valid values are `approved|rejected|modified|pending|withdrawn`',
    `participant_count` STRING COMMENT 'Total number of distinct parties (intervenors, staff, advocates) involved in the docket.',
    `presiding_officer` STRING COMMENT 'Name of the presiding officer or administrative law judge for the proceeding.',
    `proceeding_type` STRING COMMENT 'Category of the regulatory proceeding.. Valid values are `rate_case|cpcn|grc|enforcement|rulemaking|complaint`',
    `record_source_system` STRING COMMENT 'Name of the source system that originally created the docket record (e.g., Oracle_CIS, SAP).',
    `regulatory_body` STRING COMMENT 'Regulatory agency overseeing the docket.. Valid values are `FERC|NERC|State_PUC|EPA|PHMSA`',
    `regulatory_fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee assessed by the regulatory body for filing or processing the docket.',
    `related_case_number` STRING COMMENT 'Identifier of a related docket or case, if cross‑referenced.',
    `status_reason` STRING COMMENT 'Explanation or code describing why the docket is in its current status.',
    `title` STRING COMMENT 'Short descriptive title of the docket.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the docket record.',
    CONSTRAINT pk_docket PRIMARY KEY(`docket_id`)
) COMMENT 'Master record for a regulatory docket or proceeding opened by a regulatory body (FERC, state PUC, NERC, EPA), including all formal correspondence and communications within the proceeding and participating party tracking. Tracks the docket number, proceeding type (GRC, CPCN, rate case, enforcement, rulemaking, complaint), assigned regulatory body, presiding officer/ALJ, open date, expected decision date, current status, and participating parties (intervenors, commission staff, consumer advocates, industry groups) with their roles and positions. Captures the complete correspondence audit trail: data requests, information requests (IRs), deficiency letters, comment letters, protest filings, settlement communications, direction (inbound/outbound), response due dates, actual response dates, and responsible regulatory affairs staff. SSOT for the complete proceeding record, participant roster, and regulatory communication history.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` (
    `rate_case_id` BIGINT COMMENT 'Primary key for rate_case',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rate case analysis incurs costs tracked to cost centers; the link supports budgeting and cost recovery reporting.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Rate cases calculate allowed rates for a specific plant/facility; the FK ties the case to the asset it affects.',
    `tech_project_id` BIGINT COMMENT 'Foreign key linking to technology.tech_project. Business justification: Rate cases often drive capital projects (e.g., infrastructure upgrades); linking enables tracking of project spend against the case.',
    `authorized_revenue_requirement` DECIMAL(18,2) COMMENT 'Revenue amount approved by the regulator.',
    `authorized_roe` DECIMAL(18,2) COMMENT 'ROE percentage approved by the regulator.',
    `capital_expenditure` DECIMAL(18,2) COMMENT 'Capital spending amount included in the case.',
    `case_category` STRING COMMENT 'Broad category of the filing (e.g., General Rate Case, Special Rate Case, Interim).. Valid values are `general|special|interim`',
    `case_closure_date` DATE COMMENT 'Date the case was formally closed in the system.',
    `case_name` STRING COMMENT 'Descriptive title of the rate case for easy reference.',
    `case_number` STRING COMMENT 'Official filing number assigned by the regulatory body.',
    `case_priority` STRING COMMENT 'Internal priority assigned to the filing.. Valid values are `high|medium|low`',
    `case_submission_deadline` DATE COMMENT 'Latest date by which supporting documentation must be submitted.',
    `case_type` STRING COMMENT 'Classification of the case by utility service type.. Valid values are `electric|gas|combined`',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the case.',
    `cost_of_capital` DECIMAL(18,2) COMMENT 'Percentage cost of capital used in the revenue requirement calculation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate case record was created in the system.',
    `depreciation_method` STRING COMMENT 'Methodology used to calculate depreciation for assets.. Valid values are `straight_line|declining_balance|units_of_production`',
    `effective_from` DATE COMMENT 'Date the interim or final rates become effective.',
    `effective_until` DATE COMMENT 'Date the rates cease to be effective (if applicable).',
    `exhibit_numbers` STRING COMMENT 'Comma‑separated list of exhibit identifiers attached to the filing.',
    `expert_witness_affiliation` STRING COMMENT 'Organization or institution the expert witness represents.',
    `expert_witness_name` STRING COMMENT 'Full name of the expert witness providing testimony.',
    `filing_date` DATE COMMENT 'Date the rate case was formally filed with the regulator.',
    `final_order_date` DATE COMMENT 'Date the regulator issued the final order.',
    `jurisdiction_state` STRING COMMENT 'Two‑letter state code where the filing is made.. Valid values are `^[A-Z]{2}$`',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last updated the record.',
    `operating_expenditure` DECIMAL(18,2) COMMENT 'Operating cost amount included in the case.',
    `outcome` STRING COMMENT 'Final decision outcome of the filing.. Valid values are `approved|denied|settled|withdrawn`',
    `outcome_description` STRING COMMENT 'Narrative description of the regulators decision.',
    `rab_value` DECIMAL(18,2) COMMENT 'Value of the utilitys regulated asset base used in the case.',
    `rate_case_status` STRING COMMENT 'Current lifecycle status of the rate case.. Valid values are `draft|filed|pending|approved|denied|closed`',
    `rate_design` STRING COMMENT 'Narrative of the proposed rate design methodology.',
    `regulatory_body` STRING COMMENT 'Regulatory agency overseeing the filing.. Valid values are `FERC|PUC|NERC|EPA|PHMSA`',
    `requested_revenue_requirement` DECIMAL(18,2) COMMENT 'Revenue amount the utility seeks to recover, as requested in the filing.',
    `requested_roe` DECIMAL(18,2) COMMENT 'ROE percentage the utility requested.',
    `test_year` STRING COMMENT 'Fiscal year used as the test base for the rate case.',
    `testimony_filing_date` DATE COMMENT 'Date the expert testimony was filed with the case record.',
    `testimony_subject_area` STRING COMMENT 'Primary subject matter of the expert testimony.. Valid values are `revenue_requirement|cost_of_capital|depreciation|rate_design|other`',
    `testimony_type` STRING COMMENT 'Nature of the expert testimony.. Valid values are `direct|rebuttal|surrebuttal`',
    `total_allowed_rate` DECIMAL(18,2) COMMENT 'Maximum rate per unit (e.g., $/kWh) authorized by the regulator.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rate case record.',
    CONSTRAINT pk_rate_case PRIMARY KEY(`rate_case_id`)
) COMMENT 'Master record for a General Rate Case (GRC) or rate proceeding filed with a state PUC or FERC, including all associated testimony and evidentiary records. Captures the test year, rate case type (electric, gas, combined), requested and authorized revenue requirement, ROE requested vs. authorized, RAB value, filing date, interim rate effective date, final order date, and rate case outcome. Also tracks expert witness testimony: testimony type (direct, rebuttal, surrebuttal), witness name and affiliation, subject area (revenue requirement, cost of capital, depreciation, rate design), filing date, and exhibit numbers. SSOT for approved revenue requirements, rate case history, and the evidentiary record of rate proceedings.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` (
    `tariff_schedule_id` BIGINT COMMENT 'System-generated unique identifier for the tariff schedule record.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Custom tariff schedules are negotiated for individual large accounts; linking records which account uses which schedule.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Tariff schedules are applied to the facility delivering the service; linking enables accurate billing and regulatory compliance.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Tariff schedules drive revenue and charge postings; linking to a GL account ensures proper accounting of tariff-derived income.',
    `superseded_by_schedule_tariff_schedule_id` BIGINT COMMENT 'Identifier of the tariff schedule that supersedes this one, if applicable.',
    `authorizing_rate_case` STRING COMMENT 'Identifier of the rate case or filing that approved the tariff.',
    `base_rate` DECIMAL(18,2) COMMENT 'Fundamental rate component (e.g., $ per kWh) applied before adjustments.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tariff schedule record was created in the system.',
    `customer_class` STRING COMMENT 'Customer classification (e.g., residential, commercial, industrial) for which the tariff is designed.',
    `demand_charge` DECIMAL(18,2) COMMENT 'Charge based on peak demand (e.g., $ per kW).',
    `effective_date` DATE COMMENT 'Date the tariff schedule becomes legally effective.',
    `energy_charge` DECIMAL(18,2) COMMENT 'Charge per unit of energy consumed (e.g., $ per MWh).',
    `expiration_date` DATE COMMENT 'Date the tariff schedule expires or is superseded (null if open‑ended).',
    `fixed_charge` DECIMAL(18,2) COMMENT 'Flat monthly charge independent of usage.',
    `jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction (state, PUC, or ISO) governing the tariff.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments.',
    `rate_structure_type` STRING COMMENT 'Design of the rate schedule (flat, time‑of‑use, critical peak pricing, real‑time pricing, tiered, demand‑based).. Valid values are `flat|tou|cpp|rtp|tiered|demand`',
    `regulatory_approval_date` DATE COMMENT 'Date the regulatory body approved the tariff schedule.',
    `regulatory_body` STRING COMMENT 'Regulatory agency that authorized the tariff.. Valid values are `FERC|NERC|PUC|EPA|PHMSA`',
    `revenue_allocation_percentages` STRING COMMENT 'Percentage of revenue allocated to each customer class or purpose, stored as JSON or delimited string.',
    `service_type` STRING COMMENT 'Type of utility service the tariff applies to.. Valid values are `electric|gas|transmission|distribution`',
    `tariff_category` STRING COMMENT 'High‑level classification of the tariff (e.g., residential, commercial, industrial, government).',
    `tariff_code` STRING COMMENT 'Official code assigned to the tariff schedule by the regulatory authority.',
    `tariff_name` STRING COMMENT 'Descriptive name of the tariff schedule used for reporting and UI display.',
    `tariff_schedule_description` STRING COMMENT 'Narrative description of the tariff schedule and its purpose.',
    `tariff_schedule_status` STRING COMMENT 'Current lifecycle status of the tariff schedule.. Valid values are `active|inactive|pending|superseded|retired`',
    `tiered_blocks` STRING COMMENT 'Tiered or block rate definitions, stored as JSON or delimited string.',
    `time_of_use_periods` STRING COMMENT 'Definition of TOU periods and associated rates, stored as JSON or delimited string.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tariff schedule record.',
    `version_number` STRING COMMENT 'Sequential version identifier for the tariff schedule.',
    CONSTRAINT pk_tariff_schedule PRIMARY KEY(`tariff_schedule_id`)
) COMMENT 'Approved tariff schedule or rate schedule as authorized by a regulatory body, with full rate design structure and temporal versioning. Captures tariff name, tariff code, service type (electric/gas distribution, transmission), customer class, effective date, expiration/superseded date, version number, base rate components, demand charge, energy charge, fixed customer charge, and jurisdiction. Includes rate design details: rate structure type (flat, TOU, CPP, RTP, tiered/inclining block, demand-based), rate component tiers, time-of-use periods, revenue allocation percentages by class, and the authorizing rate case. Supports version history to track rate changes over time. SSOT for approved rates and rate structures used by the billing domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` (
    `regulatory_tariff_rider_id` BIGINT COMMENT 'System-generated unique identifier for the tariff rider record.',
    `tariff_schedule_id` BIGINT COMMENT 'Identifier of the base tariff schedule that this rider amends.',
    `amendment_number` STRING COMMENT 'Number of the amendment to the original rider, if applicable.',
    `applicable_customer_class` STRING COMMENT 'Customer class(es) to which the rider applies.. Valid values are `residential|commercial|industrial|municipal`',
    `approval_date` DATE COMMENT 'Date the regulatory body approved the rider.',
    `approval_number` STRING COMMENT 'Unique identifier assigned by the regulatory body for the approved rider.',
    `calculation_methodology` STRING COMMENT 'Explanation of how the rider rate is calculated (e.g., fuel cost index, fixed surcharge).',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the rider.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rider record was first created in the system.',
    `docket_number` STRING COMMENT 'Official docket or filing number associated with the rider.',
    `effective_date` DATE COMMENT 'Date on which the rider becomes legally binding.',
    `filing_date` DATE COMMENT 'Date the rider was submitted to the regulatory agency.',
    `rate_amount` DECIMAL(18,2) COMMENT 'Monetary amount applied per unit of the specified measurement.',
    `rate_type` STRING COMMENT 'Indicates whether the rider rate is fixed for the term or varies with an index.. Valid values are `fixed|variable`',
    `regulatory_body` STRING COMMENT 'Regulatory agency that granted approval for the rider.. Valid values are `FERC|NERC|PUC|EPA|PHMSA`',
    `regulatory_tariff_rider_description` STRING COMMENT 'Detailed narrative describing the rider, its intent, and any special conditions.',
    `regulatory_tariff_rider_status` STRING COMMENT 'Current lifecycle status of the rider.. Valid values are `active|inactive|pending|withdrawn|expired`',
    `rider_code` STRING COMMENT 'Short alphanumeric code used to reference the rider in regulatory filings and internal systems.',
    `rider_name` STRING COMMENT 'Human‑readable name of the supplemental tariff rider.',
    `rider_type` STRING COMMENT 'Category of the rider indicating its regulatory purpose.. Valid values are `fuel_adjustment|infrastructure_surcharge|renewable_portfolio_standard|demand_response|low_income_assistance`',
    `sunset_date` DATE COMMENT 'Date on which the rider expires or is scheduled for termination.',
    `unit_of_measure` STRING COMMENT 'Measurement unit to which the rate_amount applies.. Valid values are `kWh|MWh|therm|MCF`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rider record.',
    `version_number` STRING COMMENT 'Sequential version of the rider reflecting revisions.',
    CONSTRAINT pk_regulatory_tariff_rider PRIMARY KEY(`regulatory_tariff_rider_id`)
) COMMENT 'Supplemental tariff rider or surcharge mechanism attached to a base tariff schedule, as approved by a regulatory body. Captures rider name, rider code, rider type (fuel adjustment, infrastructure surcharge, renewable portfolio standard, demand response, low-income assistance), calculation methodology, rate per unit, effective date, sunset date, and the parent tariff schedule it modifies. Riders are distinct regulatory instruments with their own approval lifecycle.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` (
    `commission_order_id` BIGINT COMMENT 'Primary key for commission_order',
    `rate_case_id` BIGINT COMMENT 'Identifier of the rate case (if any) that generated or is impacted by this order.',
    `filing_id` BIGINT COMMENT 'Identifier of the original filing or docket that prompted the order.',
    `tariff_id` BIGINT COMMENT 'Identifier of the tariff schedule associated with the order.',
    `tariff_schedule_id` BIGINT COMMENT 'Identifier of the tariff schedule associated with the order.',
    `tech_project_id` BIGINT COMMENT 'Foreign key linking to technology.tech_project. Business justification: Commission orders mandate changes that are executed as technology projects; linking orders to projects tracks implementation status.',
    `appeal_deadline` DATE COMMENT 'Last date the utility may submit an appeal or request reconsideration.',
    `commission_order_status` STRING COMMENT 'Current processing state of the order within the utilitys compliance workflow.. Valid values are `open|closed|in_progress|appealed|revoked`',
    `compliance_action_required` STRING COMMENT 'Text describing the specific actions the utility must take to satisfy the order.',
    `compliance_deadline` DATE COMMENT 'Final date by which the utility must satisfy the orders requirements.',
    `compliance_evidence_document` STRING COMMENT 'Reference (e.g., file path or URI) to supporting documentation proving compliance.',
    `compliance_status` STRING COMMENT 'Current status of the utilitys compliance with the order.. Valid values are `pending|compliant|non_compliant|waived`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the order record was first created in the data lake.',
    `docket_number` STRING COMMENT 'Identifier of the proceeding or filing docket to which the order belongs.',
    `effective_date` DATE COMMENT 'Date the order becomes legally effective and enforceable.',
    `effective_end_date` DATE COMMENT 'Date the order expires or is superseded (nullable for indefinite orders).',
    `is_appealed` BOOLEAN COMMENT 'Indicates whether the utility has filed an appeal against the order.',
    `issue_date` DATE COMMENT 'Date the regulatory body formally issued the order.',
    `issuing_body` STRING COMMENT 'Name of the agency that issued the order (e.g., FERC, State PUC, NERC, EPA).',
    `jurisdiction` STRING COMMENT 'Geographic or governmental scope (e.g., state abbreviation, Federal).',
    `order_category` STRING COMMENT 'High‑level business domain the order impacts (e.g., rate case, environmental, safety).. Valid values are `rate|environment|safety|market|operational`',
    `order_document_url` STRING COMMENT 'Link to the full text of the regulatory order as stored in the document repository.',
    `order_number` STRING COMMENT 'Official identifier assigned by the issuing regulatory body.. Valid values are `^[A-Z0-9-]+$`',
    `order_summary` STRING COMMENT 'Brief narrative describing the key obligations and actions required.',
    `order_type` STRING COMMENT 'Classification of the order based on its purpose and authority.. Valid values are `final|interim|show_cause|consent_decree|compliance`',
    `regulatory_area` STRING COMMENT 'Specific functional area of the utility affected by the order.. Valid values are `transmission|generation|distribution|safety|market|environment`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the order record.',
    CONSTRAINT pk_commission_order PRIMARY KEY(`commission_order_id`)
) COMMENT 'Formal order, decision, or ruling issued by a regulatory body (FERC, PUC, NERC, EPA) in response to a filing or proceeding. Captures the order number, issuing body, order type (final order, interim order, show cause, consent decree, compliance order), issue date, effective date, compliance deadline, order summary, and the docket it belongs to. Tracks the utilitys obligations arising from each regulatory order.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` (
    `compliance_obligation_id` BIGINT COMMENT 'Unique surrogate key for each compliance obligation record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Compliance Management Report requires each regulatory compliance obligation to be assigned to a specific physical asset for tracking and reporting.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Certain compliance obligations (e.g., emission caps) are assigned to a customer account for reporting and enforcement.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Compliance obligations are funded through specific cost centers; linking enables budgeting, expense tracking, and regulatory cost reporting.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Obligations (e.g., emission limits) are assigned to individual facilities; the FK supports obligation tracking per asset.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Compliance obligations (emission limits, reporting duties) are assigned to specific generation plants; the FK supports obligation‑to‑plant reporting.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: Obligation is often tied to a specific rate case.',
    `related_obligation_compliance_obligation_id` BIGINT COMMENT 'Identifier of a parent or linked obligation, if applicable.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Each compliance obligation is owned by a specific employee (e.g., compliance manager); linking enables obligation tracking and reporting.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Regulatory compliance obligations (NERC CIP) are assigned to specific SCADA systems; tracking which system each obligation applies to is required for audit readiness.',
    `audit_findings_count` STRING COMMENT 'Number of findings identified in the last audit.',
    `audit_readiness_status` STRING COMMENT 'Readiness of the obligation for upcoming audit.. Valid values are `ready|not_ready|in_progress`',
    `comments` STRING COMMENT 'Free‑form notes or comments about the obligation.',
    `compliance_deadline` DATE COMMENT 'Final deadline for demonstrating compliance.',
    `compliance_evidence_last_updated` DATE COMMENT 'Date the evidence status was last updated.',
    `compliance_evidence_status` STRING COMMENT 'Current status of the evidence collection process.. Valid values are `draft|submitted|accepted|rejected`',
    `compliance_gap_analysis` STRING COMMENT 'Narrative analysis of gaps between required and actual compliance.',
    `compliance_obligation_description` STRING COMMENT 'Full textual description of the regulatory requirement.',
    `compliance_obligation_status` STRING COMMENT 'Current lifecycle state of the obligation.. Valid values are `active|pending|completed|closed|non_compliant|exempt`',
    `compliance_status` STRING COMMENT 'Current compliance determination for the obligation.. Valid values are `compliant|non_compliant|partial|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the obligation record was first created.',
    `due_date` DATE COMMENT 'Date by which the obligation must be satisfied.',
    `effective_date` DATE COMMENT 'Date the obligation becomes binding.',
    `evidence_count` STRING COMMENT 'Number of evidence items currently attached.',
    `evidence_required` BOOLEAN COMMENT 'Indicates whether supporting evidence is mandatory.',
    `expiration_date` DATE COMMENT 'Date the obligation expires or is superseded (null if open‑ended).',
    `last_audit_date` DATE COMMENT 'Date of the most recent audit covering this obligation.',
    `last_evidence_submission_date` DATE COMMENT 'Date the most recent evidence was submitted.',
    `next_audit_due` DATE COMMENT 'Planned date for the next audit.',
    `obligation_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the regulatory obligation.',
    `obligation_title` STRING COMMENT 'Human‑readable title summarizing the obligation.',
    `obligation_type` STRING COMMENT 'Category of the obligation (e.g., NERC CIP, Renewable Portfolio Standard, safety, environmental, rate case).. Valid values are `CIP|RPS|Safety|Environmental|Rate`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty that may be assessed for non‑compliance.',
    `penalty_currency` STRING COMMENT 'Three‑letter ISO currency code for the penalty amount.',
    `regulation_source` STRING COMMENT 'Originating regulatory program or statute that created the obligation.. Valid values are `FERC|NERC|PUC|EPA|PHMSA`',
    `regulatory_body` STRING COMMENT 'Governing agency responsible for the regulation.. Valid values are `FERC|NERC|PUC|EPA|PHMSA`',
    `responsible_business_unit` STRING COMMENT 'Organizational unit accountable for meeting the obligation.',
    `risk_rating` STRING COMMENT 'Qualitative risk rating assigned to the obligation.. Valid values are `low|medium|high|critical`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0‑100) derived from risk assessment.',
    `source_document_reference` STRING COMMENT 'Identifier or filename of the regulatory source document.',
    `source_document_type` STRING COMMENT 'Classification of the source document.. Valid values are `order|policy|regulation|notice`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `violation_count` STRING COMMENT 'Total count of regulatory violations recorded for this obligation.',
    CONSTRAINT pk_compliance_obligation PRIMARY KEY(`compliance_obligation_id`)
) COMMENT 'Master record for every compliance obligation imposed on the utility by regulatory orders, rules, standards, or statutes — together with the complete evidence portfolio and audit/examination history. Encompasses NERC CIP requirements, RPS obligations, EPA/PHMSA safety mandates, and all other regulatory mandates. Captures obligation description, source regulation or order, regulatory body, obligation type, due date, responsible business unit, completion status, penalty exposure, and compliance gap analysis. Evidence tracking: evidence type (document, test result, inspection, attestation, log), evidence title, collection date, submission date, submitting party, evidence status (draft, submitted, accepted, rejected), and document reference. Audit tracking: audit type, conducting body, audit scope, audit period, on-site dates, findings count, violations identified, overall outcome, and audit readiness posture. SSOT for the complete compliance lifecycle from obligation creation through evidence collection, audit verification, and closure.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` (
    `compliance_evidence_id` BIGINT COMMENT 'System-generated unique identifier for the compliance evidence record.',
    `compliance_obligation_id` BIGINT COMMENT 'Identifier of the compliance obligation to which this evidence is linked.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Evidence such as monitoring data originates at a specific facility; linking ties evidence to its source for audits.',
    `checksum_sha256` STRING COMMENT 'SHA‑256 hash of the evidence file for integrity verification.',
    `collection_date` DATE COMMENT 'Date the evidence was originally collected or generated.',
    `compliance_evidence_description` STRING COMMENT 'Detailed narrative describing the content and purpose of the evidence.',
    `compliance_evidence_status` STRING COMMENT 'Current lifecycle status of the evidence record.. Valid values are `draft|submitted|accepted|rejected|archived`',
    `confidentiality_level` STRING COMMENT 'Data classification indicating the sensitivity of the evidence.. Valid values are `restricted|confidential|internal|public`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the evidence record was first created in the system.',
    `document_uri` STRING COMMENT 'Location (URL or file path) where the evidence document is stored.',
    `evidence_number` STRING COMMENT 'Business identifier assigned to the evidence (e.g., document number or test result code).',
    `evidence_subtype` STRING COMMENT 'More specific classification within the evidence type (e.g., safety inspection, emissions test).',
    `evidence_type` STRING COMMENT 'Category of evidence indicating its nature (e.g., document, test result, inspection, attestation, log file).. Valid values are `document|test_result|inspection|attestation|log_file`',
    `expiration_date` DATE COMMENT 'Date the evidence becomes invalid for compliance purposes.',
    `file_format` STRING COMMENT 'File format of the stored evidence document.. Valid values are `pdf|docx|xlsx|txt|csv`',
    `file_size_bytes` BIGINT COMMENT 'Size of the evidence file in bytes.',
    `is_archived` BOOLEAN COMMENT 'Flag indicating whether the evidence has been archived.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the evidence.',
    `regulatory_body` STRING COMMENT 'Regulatory agency or commission that requires the evidence.. Valid values are `FERC|NERC|PUC|EPA|PHMSA`',
    `related_system` STRING COMMENT 'Secondary system associated with the evidence, if any.',
    `retention_end_date` DATE COMMENT 'Date after which the evidence may be destroyed according to retention policy.',
    `source_system` STRING COMMENT 'Originating system that generated or captured the evidence (e.g., Oracle CC&B, SAP ERP, Maximo).',
    `submission_date` DATE COMMENT 'Date the evidence was submitted to the regulatory body or compliance system.',
    `submitting_party` STRING COMMENT 'Name of the internal or external party that submitted the evidence.',
    `title` STRING COMMENT 'Human‑readable title describing the evidence record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the evidence record.',
    `version_number` STRING COMMENT 'Sequential version of the evidence record for change tracking.',
    CONSTRAINT pk_compliance_evidence PRIMARY KEY(`compliance_evidence_id`)
) COMMENT 'Evidence record submitted or maintained to demonstrate fulfillment of a specific compliance obligation. Captures the evidence type (document, test result, inspection record, attestation, log file), evidence title, collection date, submission date, submitting party, associated obligation, regulatory body, evidence status (draft, submitted, accepted, rejected), and document reference. Supports NERC CIP, FERC, EPA, and PUC audit readiness.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` (
    `cip_standard_id` BIGINT COMMENT 'System-generated unique identifier for the NERC CIP standard record.',
    `body_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_body. Business justification: Standard is issued by a regulatory body; replace string column with FK.',
    `applicability_criteria` STRING COMMENT 'Business rules that determine which BES assets the standard applies to.',
    `asset_impact_total` STRING COMMENT 'Total number of BES assets impacted by this standard.',
    `cip_standard_status` STRING COMMENT 'Current lifecycle status of the standard record.. Valid values are `active|inactive|draft|pending|retired`',
    `classification_rationale` STRING COMMENT 'Narrative explaining how asset impact levels were determined.',
    `compliance_category` STRING COMMENT 'Category indicating the regulatory weight of the standard.. Valid values are `mandatory|voluntary|informational`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the standard record was first created in the system.',
    `effective_date` DATE COMMENT 'Date the CIP standard became effective for the utility.',
    `expiration_date` DATE COMMENT 'Date the CIP standard version expires or is superseded (nullable if open‑ended).',
    `high_impact_asset_count` STRING COMMENT 'Count of BES assets classified as high impact for this standard.',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance review.',
    `low_impact_asset_count` STRING COMMENT 'Count of BES assets classified as low impact for this standard.',
    `medium_impact_asset_count` STRING COMMENT 'Count of BES assets classified as medium impact for this standard.',
    `next_review_date` DATE COMMENT 'Planned date for the upcoming compliance review.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `requirement_count` STRING COMMENT 'Total number of individual compliance requirements defined in the standard.',
    `review_cycle` STRING COMMENT 'Frequency at which the standard is reviewed for updates.. Valid values are `annual|biennial|triennial`',
    `source_system` STRING COMMENT 'Originating operational system where the standard record is maintained.. Valid values are `SAP|Oracle|Maximo|Custom`',
    `standard_code` STRING COMMENT 'Official NERC CIP identifier (e.g., CIP-002, CIP-010).',
    `standard_title` STRING COMMENT 'Descriptive title of the CIP standard (e.g., "Critical Cyber Asset Identification").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the standard record.',
    `version` STRING COMMENT 'Version string of the standard (e.g., "v1.2").',
    CONSTRAINT pk_cip_standard PRIMARY KEY(`cip_standard_id`)
) COMMENT 'NERC Critical Infrastructure Protection (CIP) standard master record with associated BES Cyber System and asset impact classifications. Captures the standard identifier (CIP-002 through CIP-014), standard title, version, effective date, requirement count, applicability criteria, and compliance category. Includes BES asset impact classifications: asset identifier, asset type (substation, control center, generation facility, transmission line), assigned impact level (high, medium, low), classification rationale, classification date, review cycle, and responsible engineer. Drives which CIP requirements apply to each BES asset and maps to compliance obligations. SSOT for NERC CIP standard applicability and asset-level impact determinations.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` (
    `cip_asset_classification_id` BIGINT COMMENT 'Unique surrogate key for the CIP asset classification record.',
    `body_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_body. Business justification: Classification is governed by a regulatory body; add FK.',
    `employee_id` BIGINT COMMENT 'Identifier of the engineer accountable for the classification.',
    `registry_id` BIGINT COMMENT 'Identifier of the physical asset being classified.',
    `person_id` BIGINT COMMENT 'Identifier of the engineer accountable for the classification.',
    `tertiary_cip_registry_id` BIGINT COMMENT 'FK to asset.registry',
    `asset_location` STRING COMMENT 'Textual description of the assets geographic location.',
    `asset_name` STRING COMMENT 'Human‑readable name of the asset (e.g., "North Substation").',
    `asset_type` STRING COMMENT 'Category of the asset as defined by NERC CIP standards.. Valid values are `substation|control_center|generation_facility|transmission_line|distribution_transformer`',
    `audit_status` STRING COMMENT 'Result of the most recent CIP audit.. Valid values are `passed|failed|pending`',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum power capacity of the asset, where applicable.',
    `cip_asset_classification_status` STRING COMMENT 'Current lifecycle status of the classification record.. Valid values are `active|inactive|retired|pending`',
    `cip_requirement` STRING COMMENT 'Specific NERC CIP requirement(s) applicable to the asset.. Valid values are `CIP-002|CIP-003|CIP-004|CIP-005|CIP-006|CIP-007`',
    `classification_date` DATE COMMENT 'Date the asset was initially classified under CIP.',
    `classification_rationale` STRING COMMENT 'Narrative explanation for the assigned impact level.',
    `compliance_document_reference` STRING COMMENT 'Reference number of the supporting CIP compliance document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the classification record was first created.',
    `effective_end_date` DATE COMMENT 'Date the classification ceases to be effective (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date the classification becomes effective.',
    `impact_level` STRING COMMENT 'CIP impact classification assigned to the asset.. Valid values are `high|medium|low`',
    `is_critical_infrastructure` BOOLEAN COMMENT 'Indicates if the asset is designated as critical infrastructure under CIP.',
    `last_audit_date` DATE COMMENT 'Date of the most recent CIP audit for the asset.',
    `last_modified_by` STRING COMMENT 'User identifier who performed the most recent update.',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the asset location.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the asset location.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next classification review.',
    `notes` STRING COMMENT 'Free‑form field for additional comments or observations.',
    `regulatory_region` STRING COMMENT 'Regulatory jurisdiction governing the assets compliance.. Valid values are `NERC|FERC|STATE|EPA`',
    `responsible_engineer_name` STRING COMMENT 'Full name of the responsible engineer.',
    `review_cycle_months` STRING COMMENT 'Number of months between mandatory CIP classification reviews.',
    `source_system` STRING COMMENT 'Originating operational system of record for the classification data.. Valid values are `sap|maximo|arcgis|mdm|etrm`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the classification record.',
    `voltage_kv` DECIMAL(18,2) COMMENT 'Nominal operating voltage of the asset, where applicable.',
    CONSTRAINT pk_cip_asset_classification PRIMARY KEY(`cip_asset_classification_id`)
) COMMENT 'NERC CIP BES Cyber System and BES asset classification record assigning impact level (high, medium, low) to specific operational assets per CIP-002 requirements. Captures the asset identifier, asset type (substation, control center, generation facility, transmission line), assigned impact level, classification rationale, classification date, review cycle, and responsible engineer. Drives which CIP standards apply to each asset.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` (
    `irp_submission_id` BIGINT COMMENT 'Unique system-generated identifier for the IRP submission record.',
    `body_id` BIGINT COMMENT 'FK to regulatory.regulatory_body',
    `alternative_scenarios_description` STRING COMMENT 'Narrative description of alternative resource scenarios evaluated.',
    `approval_body` STRING COMMENT 'Name of the entity that granted approval for the IRP.',
    `approval_date` DATE COMMENT 'Date the regulatory body approved the IRP.',
    `approval_reference_number` STRING COMMENT 'Official reference number assigned by the approving authority.',
    `approval_status` STRING COMMENT 'Current approval state of the IRP submission.. Valid values are `pending|approved|rejected|withdrawn`',
    `climate_impact_assessment` STRING COMMENT 'Assessment of the IRPs impact on greenhouse‑gas emissions and climate goals.',
    `comments` STRING COMMENT 'Free-text field for additional remarks or notes.',
    `demand_response_program_included` BOOLEAN COMMENT 'Indicates whether demand response resources are part of the plan.',
    `effective_end_date` DATE COMMENT 'Date when the IRP plan expires or is superseded (nullable).',
    `effective_start_date` DATE COMMENT 'Date when the approved IRP plan becomes effective.',
    `filing_date` DATE COMMENT 'Date the IRP was officially filed with the regulatory authority.',
    `filing_deadline` DATE COMMENT 'Final date by which the IRP must be filed to remain compliant.',
    `irp_document_url` STRING COMMENT 'Link to the stored IRP document file.',
    `is_long_term_plan` BOOLEAN COMMENT 'Indicates whether the IRP is classified as a long‑term strategic plan.',
    `last_modified_by` STRING COMMENT 'User or system that performed the most recent update.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the IRP submission record.',
    `net_present_value_usd` DECIMAL(18,2) COMMENT 'Financial NPV of the IRP plan, expressed in US dollars.',
    `planned_demand_response_capacity_mw` DECIMAL(18,2) COMMENT 'Capacity expected from demand response programs, in megawatts.',
    `planned_fossil_capacity_mw` DECIMAL(18,2) COMMENT 'Capacity to be added from fossil fuel resources, in megawatts.',
    `planned_nuclear_capacity_mw` DECIMAL(18,2) COMMENT 'Capacity to be added from nuclear resources, in megawatts.',
    `planned_renewable_capacity_mw` DECIMAL(18,2) COMMENT 'Capacity to be added from renewable resources (wind, solar, hydro), in megawatts.',
    `planned_retirements_mw` DECIMAL(18,2) COMMENT 'Capacity scheduled for retirement during the planning horizon, in megawatts.',
    `planned_storage_capacity_mw` DECIMAL(18,2) COMMENT 'Capacity to be added from energy storage technologies, in megawatts.',
    `planning_horizon_years` STRING COMMENT 'Number of years covered by the IRP planning horizon.',
    `preferred_portfolio_description` STRING COMMENT 'Narrative description of the preferred resource portfolio mix.',
    `regulatory_body` STRING COMMENT 'Regulatory agency or commission receiving the IRP filing.. Valid values are `FERC|NERC|PUC|DOE|EPA`',
    `regulatory_body_code` STRING COMMENT 'Standard code representing the regulatory body (e.g., FERC, NERC).',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the IRP meets all applicable regulatory requirements.',
    `renewable_energy_certificate_target` STRING COMMENT 'Target number of RECs to be procured or generated.',
    `renewable_resource_mix` STRING COMMENT 'Breakdown of renewable resource types (e.g., wind, solar, hydro) in the portfolio.',
    `risk_assessment_summary` STRING COMMENT 'High‑level summary of identified risks and mitigation strategies.',
    `stakeholder_engagement_summary` STRING COMMENT 'Summary of stakeholder outreach and feedback incorporated into the IRP.',
    `storage_technology_type` STRING COMMENT 'Primary technology type used for planned storage capacity.. Valid values are `battery|pumped_hydro|compressed_air|flywheel`',
    `submission_cycle_year` STRING COMMENT 'Calendar year of the IRP planning cycle.',
    `submission_number` STRING COMMENT 'External reference number assigned to the IRP filing by the regulatory body.',
    `submission_status` STRING COMMENT 'Lifecycle status of the IRP filing.. Valid values are `draft|submitted|under_review|finalized`',
    `submission_timestamp` TIMESTAMP COMMENT 'Timestamp when the IRP submission record was created in the system.',
    `submission_type` STRING COMMENT 'Indicates whether the filing is an initial submission, an update, or a supplemental filing.. Valid values are `initial|update|supplemental`',
    `submitted_by` STRING COMMENT 'Name of the individual or department that submitted the IRP.',
    `total_capital_expenditure_usd` DECIMAL(18,2) COMMENT 'Projected capital investment required to implement the IRP, in US dollars.',
    `total_operating_expenditure_usd` DECIMAL(18,2) COMMENT 'Projected operating costs over the planning horizon, in US dollars.',
    `total_projected_load_mw` DECIMAL(18,2) COMMENT 'Forecasted total electricity load for the planning horizon, expressed in megawatts.',
    `version_number` STRING COMMENT 'Sequential version number of the IRP document.',
    `created_by` STRING COMMENT 'User or system that initially created the IRP record.',
    CONSTRAINT pk_irp_submission PRIMARY KEY(`irp_submission_id`)
) COMMENT 'Integrated Resource Plan (IRP) submission record filed with the state PUC or DOE. Captures the IRP cycle year, planning horizon (years), filing date, regulatory body, total projected load (MW), planned capacity additions by resource type (fossil, nuclear, renewable, storage, DR), planned retirements, preferred portfolio description, alternative scenarios evaluated, and IRP approval status. SSOT for long-range resource planning regulatory submissions.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` (
    `cpcn_application_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each CPCN application record.',
    `applicant_organization_business_entity_id` BIGINT COMMENT 'Identifier of the utility organization submitting the CPCN application.',
    `business_entity_id` BIGINT COMMENT 'Identifier of the utility organization submitting the CPCN application.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal employee responsible for managing the project.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: CPCN applications request approval for a new or modified facility; the FK identifies the facility under review.',
    `tariff_schedule_id` BIGINT COMMENT 'Reference to the tariff schedule that may be affected by the CPCN approval.',
    `applicant_contact_email` STRING COMMENT 'Email address of the primary contact for the CPCN application.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `applicant_contact_name` STRING COMMENT 'Full name of the primary contact person for the CPCN filing.',
    `applicant_contact_phone` STRING COMMENT 'Phone number of the primary contact for the CPCN filing.',
    `application_number` STRING COMMENT 'Official identifier assigned to the CPCN application by the filing authority.',
    `application_status` STRING COMMENT 'Lifecycle status of the CPCN application within the utilitys internal process.. Valid values are `draft|submitted|under_review|closed`',
    `approval_status` STRING COMMENT 'Current regulatory decision status of the CPCN application.. Valid values are `pending|approved|rejected|withdrawn`',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp representing the key business event (e.g., submission) for the CPCN application.',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Maximum electrical capacity of the proposed project expressed in megawatts (MW).',
    `capex_currency` STRING COMMENT 'Three‑letter ISO currency code for the estimated CAPEX amount.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `comments` STRING COMMENT 'Free‑form field for any supplemental information or notes.',
    `conditions_of_approval` STRING COMMENT 'Any conditions, commitments, or restrictions imposed by the regulator upon approval.',
    `cost_center_code` STRING COMMENT 'Internal cost center identifier used for budgeting and expense tracking.',
    `environmental_impact_assessment` STRING COMMENT 'Status of the required environmental impact study for the project.. Valid values are `completed|pending|not_required`',
    `estimated_capex` DECIMAL(18,2) COMMENT 'Projected total capital cost of the project in the applicants reporting currency.',
    `filing_date` DATE COMMENT 'Date the CPCN application was formally submitted to the regulatory body.',
    `funding_source` STRING COMMENT 'Primary source of financing for the project.. Valid values are `private|state|federal|bond`',
    `hearing_date` DATE COMMENT 'Scheduled date for the public hearing on the CPCN application.',
    `is_federal_funded` BOOLEAN COMMENT 'Flag indicating whether any portion of the project is funded by federal sources.',
    `is_major_project` BOOLEAN COMMENT 'Flag indicating whether the project is classified as a major capital investment.',
    `issuance_date` DATE COMMENT 'Date the CPCN was officially issued by the regulatory authority.',
    `project_completion_estimated` DATE COMMENT 'Planned date for project completion and commissioning.',
    `project_description` STRING COMMENT 'Narrative description of the projects purpose, scope, and key features.',
    `project_name` STRING COMMENT 'Descriptive name of the capital project or facility for which the CPCN is sought.',
    `project_start_estimated` DATE COMMENT 'Planned start date for construction or implementation of the project.',
    `project_type` STRING COMMENT 'Category of the project (e.g., generation, transmission line, substation, gas pipeline, distribution extension).. Valid values are `generation|transmission|substation|gas_pipeline|distribution_extension`',
    `public_hearing_outcome` STRING COMMENT 'Result of the public hearing regarding the CPCN application.. Valid values are `favorable|unfavorable|neutral`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the CPCN application record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the CPCN application record.',
    `regulatory_body` STRING COMMENT 'Name of the state Public Utility Commission or other agency reviewing the application.',
    `service_territory` STRING COMMENT 'Geographic area (state or region) where the project will serve customers.',
    CONSTRAINT pk_cpcn_application PRIMARY KEY(`cpcn_application_id`)
) COMMENT 'Certificate of Public Convenience and Necessity (CPCN) application filed with a state PUC for approval of a new capital project, facility, or service territory expansion. Captures the project name, project type (generation, transmission line, substation, gas pipeline, distribution extension), applied MW or capacity, estimated CAPEX, service territory affected, filing date, hearing date, certificate issuance date, and conditions of approval.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` (
    `rab_asset_id` BIGINT COMMENT 'Primary key for rab_asset',
    `regulatory_asset_id` BIGINT COMMENT 'System-generated unique identifier for each regulatory asset record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Rate Base Accounting links each RAB asset to the underlying physical asset to calculate allowed revenue recovery.',
    `depreciation_schedule_id` BIGINT COMMENT 'Identifier of the depreciation schedule that may be linked to the regulatory asset for accounting purposes.',
    `rate_case_id` BIGINT COMMENT 'Identifier of the rate case that authorized the recovery or created the liability.',
    `amortization_end_date` DATE COMMENT 'Projected date when the asset will be fully amortized.',
    `amortization_method` STRING COMMENT 'Method used to calculate annual amortization (e.g., straight‑line).. Valid values are `straight_line|units_of_production|sum_of_years`',
    `amortization_period_years` STRING COMMENT 'Number of years over which the asset will be amortized.',
    `amortization_start_date` DATE COMMENT 'Date when amortization of the regulatory asset begins.',
    `annual_amortization_amount` DECIMAL(18,2) COMMENT 'Amount of amortization expense recognized each fiscal year.',
    `asset_code` STRING COMMENT 'Business‑assigned code or tag that uniquely identifies the regulatory asset within the utilitys accounting system.',
    `asset_type` STRING COMMENT 'Category of the regulatory asset as defined by FASB ASC 980. [ENUM-REF-CANDIDATE: deferred_fuel_cost|storm_restoration|pension_obligation|environmental_remediation|plant_abandonment|deferred_rate_case_expense|securitized_cost — promote to reference product]',
    `authorized_recovery_amount` DECIMAL(18,2) COMMENT 'Maximum amount the utility is authorized to recover from customers for this asset, as approved by the regulator.',
    `compliance_document_reference` STRING COMMENT 'Reference identifier (e.g., document number) for the supporting regulatory filing or compliance evidence.',
    `cost_center_code` STRING COMMENT 'Internal cost‑center identifier to which the regulatory asset expense is charged.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the regulatory asset record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency in which monetary amounts are expressed (e.g., USD).',
    `effective_date` DATE COMMENT 'Date on which the regulatory asset becomes effective for accounting purposes.',
    `expiry_date` DATE COMMENT 'Date on which the regulatory asset is considered expired or fully written off, if applicable.',
    `is_deferred` BOOLEAN COMMENT 'True if the asset represents a deferred cost that will be recovered in future rate cases.',
    `is_liability` BOOLEAN COMMENT 'True if the record represents a regulatory liability (future obligation to customers) rather than an asset.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the regulatory asset record.',
    `rab_asset_description` STRING COMMENT 'Detailed narrative describing the nature, origin, and purpose of the regulatory asset.',
    `rab_asset_name` STRING COMMENT 'Human‑readable name of the regulatory asset (e.g., "Deferred Fuel Cost – Plant XYZ").',
    `rab_asset_status` STRING COMMENT 'Current lifecycle status of the regulatory asset.. Valid values are `active|inactive|closed|pending|written_off`',
    `regulatory_body` STRING COMMENT 'Regulatory authority that approved or oversees the asset.. Valid values are `FERC|NERC|PUC|EPA|PHMSA`',
    `regulatory_order_number` STRING COMMENT 'Identifier of the regulatory order, filing, or docket that gave rise to the asset (e.g., FERC Docket No.).',
    `regulatory_order_type` STRING COMMENT 'Type of regulatory instrument that created the asset (e.g., rate case, CPCN, GRC docket).',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Current outstanding balance of the regulatory asset that has not yet been amortized.',
    `total_original_amount` DECIMAL(18,2) COMMENT 'Original capitalized amount of the regulatory asset at inception before amortization.',
    CONSTRAINT pk_rab_asset PRIMARY KEY(`rab_asset_id`)
) COMMENT 'Regulatory asset or regulatory liability recorded under FASB ASC 980 (Regulated Operations) on the utilitys balance sheet. Captures the regulatory asset name, asset type (deferred fuel costs, storm restoration costs, pension obligations, environmental remediation, plant abandonment, deferred rate case expenses, securitized costs), originating regulatory order, authorized recovery amount, amortization period, amortization start date, remaining unamortized balance, annual amortization amount, and associated rate case. Supports both regulatory assets (future recovery authorized) and regulatory liabilities (future obligations to customers). SSOT for all regulatory assets and liabilities tracked for revenue requirement and balance sheet purposes.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` (
    `environmental_permit_id` BIGINT COMMENT 'Primary key for environmental_permit',
    `facility_id` BIGINT COMMENT 'Identifier of the facility or plant covered by the permit.',
    `ot_asset_id` BIGINT COMMENT 'Foreign key linking to technology.ot_asset. Business justification: Environmental permits are issued for particular generation assets; linking permits to OT assets enables compliance reporting per facility.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Monetary cost of acquiring the allowance.',
    `acquisition_date` DATE COMMENT 'Date the allowance was acquired.',
    `acquisition_method` STRING COMMENT 'Method used to acquire the allowance.. Valid values are `allocated|purchased|auctioned`',
    `allowance_quantity` DECIMAL(18,2) COMMENT 'Number of emission tons allocated or purchased.',
    `allowance_type` STRING COMMENT 'How the emission allowance was obtained.. Valid values are `allocation|purchase|auction`',
    `allowance_units` STRING COMMENT 'Unit for allowance quantity.. Valid values are `tons`',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the permit.',
    `compliance_requirements` STRING COMMENT 'Textual description of monitoring and reporting obligations.',
    `compliance_status` STRING COMMENT 'Current compliance determination for the permit.. Valid values are `compliant|non_compliant|under_review`',
    `county` STRING COMMENT 'County name of the facility location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the permit record was first created in the system.',
    `effective_from` DATE COMMENT 'Date the permit becomes effective for regulatory purposes.',
    `effective_until` DATE COMMENT 'Date the permit ceases to be effective (often same as expiration).',
    `emission_limit` DECIMAL(18,2) COMMENT 'Maximum allowable emissions per year as defined by the permit.',
    `emission_source` STRING COMMENT 'Specific source of emissions covered by the permit (e.g., boiler, generator).',
    `emission_unit` STRING COMMENT 'Unit of measure for the emission limit.. Valid values are `tons|kg`',
    `expiration_date` DATE COMMENT 'Date the permit expires unless renewed.',
    `holding_status` STRING COMMENT 'Current status of the allowance holding.. Valid values are `active|surrendered|banked|transferred`',
    `issue_date` DATE COMMENT 'Date the permit was originally issued.',
    `issuing_agency` STRING COMMENT 'Regulatory body that issued the permit (e.g., EPA, State Environmental Agency, PHMSA).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent compliance inspection.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the permitted facility.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the permitted facility.',
    `monitoring_frequency` STRING COMMENT 'How often compliance monitoring must be performed.. Valid values are `monthly|quarterly|annually|continuous`',
    `next_inspection_date` DATE COMMENT 'Scheduled date for the next required inspection.',
    `permit_category` STRING COMMENT 'High‑level classification such as operational or construction permit.',
    `permit_description` STRING COMMENT 'Narrative description of the permit scope and conditions.',
    `permit_number` STRING COMMENT 'Official permit identifier assigned by the issuing agency.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit.. Valid values are `active|inactive|suspended|revoked|expired`',
    `permit_type` STRING COMMENT 'Category of the environmental permit.. Valid values are `air_quality|water_discharge|hazardous_waste|pipeline_safety|stormwater`',
    `program_name` STRING COMMENT 'Name of the cap‑and‑trade or emissions credit program (e.g., CSAPR, RGGI).',
    `record_status` STRING COMMENT 'Workflow status of the permit record within the data system.. Valid values are `draft|submitted|approved|rejected`',
    `regulatory_reference` STRING COMMENT 'Reference to related regulatory docket, case number, or filing.',
    `renewal_status` STRING COMMENT 'Current renewal state of the permit.. Valid values are `pending|renewed|not_required|expired`',
    `serial_number_range` STRING COMMENT 'Range of serial numbers assigned to the allowance certificates.',
    `state` STRING COMMENT 'Two‑letter state abbreviation where the facility is located.',
    `transfer_history` STRING COMMENT 'Chronological record of allowance transfers (free‑text or JSON).',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the permit record.',
    `vintage_year` STRING COMMENT 'Year the allowance was issued or earned.',
    `zip_code` STRING COMMENT 'Five‑digit postal code for the facility address.. Valid values are `^d{5}$`',
    CONSTRAINT pk_environmental_permit PRIMARY KEY(`environmental_permit_id`)
) COMMENT 'Environmental operating permit and emission allowance/credit master record for the utility. Covers permits issued by EPA, state environmental agencies, or PHMSA: permit number, permit type (air quality, water discharge, hazardous waste, pipeline safety, stormwater), issuing agency, facility covered, issue/expiration dates, renewal status, emission limits, and compliance monitoring requirements. Also tracks emission allowances and credits under cap-and-trade programs (CSAPR, RGGI, state carbon): allowance type, program name, vintage year, quantity (tons), serial number range, acquisition method (allocated, purchased, auctioned), acquisition date, acquisition cost, current holding status (active, surrendered, banked, transferred), transfer history, and associated facility. SSOT for all environmental operating authorizations and the utilitys complete emission compliance inventory.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` (
    `emission_allowance_id` BIGINT COMMENT 'Unique system-generated identifier for the emission allowance record.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the allowance record.',
    `facility_id` BIGINT COMMENT 'Identifier of the generation or distribution facility to which the allowance is allocated.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who last modified the allowance record.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: Emission allowances are allocated to individual generation plants for compliance; linking plant_id enables allowance tracking per plant.',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Monetary cost paid to acquire the allowance, if applicable.',
    `acquisition_date` DATE COMMENT 'Date the allowance was acquired.',
    `acquisition_method` STRING COMMENT 'How the allowance was obtained: allocated by regulator, purchased on market, won at auction, or traded.. Valid values are `allocated|purchased|auctioned|traded`',
    `allowance_number` STRING COMMENT 'External reference number or code assigned to the allowance by the regulatory program.',
    `allowance_type` STRING COMMENT 'Type of pollutant the allowance covers.. Valid values are `SO2|NOx|CO2|CH4|PM2.5`',
    `banked_quantity` DECIMAL(18,2) COMMENT 'Portion of the allowance quantity that has been banked for future periods.',
    `compliance_status` STRING COMMENT 'Regulatory compliance state of the allowance within the reporting period.. Valid values are `compliant|non_compliant|pending`',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for the acquisition cost (e.g., USD, EUR).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the allowance record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date the allowance expires or is no longer usable (nullable for open‑ended allowances).',
    `effective_start_date` DATE COMMENT 'Date the allowance becomes effective for compliance reporting.',
    `emission_allowance_status` STRING COMMENT 'Current lifecycle state of the allowance.. Valid values are `active|surrendered|banked|transferred|expired`',
    `expiration_date` DATE COMMENT 'Date by which the allowance must be used or surrendered to remain valid.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the allowance.',
    `program_name` STRING COMMENT 'Name of the cap‑and‑trade or emissions program (e.g., CSAPR, RGGI, State Carbon Program).',
    `quantity_tons` DECIMAL(18,2) COMMENT 'Total number of tons of emissions the allowance permits.',
    `regulatory_docket_reference` STRING COMMENT 'Reference to the regulatory filing or docket linked to this allowance.',
    `remaining_quantity` DECIMAL(18,2) COMMENT 'Current unutilized quantity of the allowance (derived from original, banked, surrendered, transferred).',
    `reporting_period_end` DATE COMMENT 'End date of the compliance reporting period for which the allowance applies.',
    `reporting_period_start` DATE COMMENT 'Start date of the compliance reporting period for which the allowance applies.',
    `source_agency` STRING COMMENT 'Regulatory body that issued or administered the allowance (e.g., EPA, State PUC).. Valid values are `EPA|State`',
    `surrendered_quantity` DECIMAL(18,2) COMMENT 'Quantity of the allowance that has been surrendered to the regulator.',
    `transaction_reference` STRING COMMENT 'External transaction identifier (e.g., auction lot number, trade ID) associated with the acquisition.',
    `transferred_quantity` DECIMAL(18,2) COMMENT 'Quantity of the allowance transferred to another entity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the allowance record.',
    `vintage_year` STRING COMMENT 'Calendar year in which the allowance was issued or earned.',
    CONSTRAINT pk_emission_allowance PRIMARY KEY(`emission_allowance_id`)
) COMMENT 'Emission allowance or credit held by the utility under EPA cap-and-trade programs (e.g., SO2, NOx, CO2). Captures the allowance type, program name (CSAPR, RGGI, state carbon program), vintage year, quantity (tons), acquisition method (allocated, purchased, auctioned), acquisition date, acquisition cost, current holding status (active, surrendered, banked, transferred), and associated facility. Tracks the utilitys emission compliance inventory.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` (
    `rec_inventory_id` BIGINT COMMENT 'Primary key for rec_inventory',
    `employee_id` BIGINT COMMENT 'Identifier of the user who created the record.',
    `facility_id` BIGINT COMMENT 'Internal identifier of the generating facility.',
    `ot_asset_id` BIGINT COMMENT 'Foreign key linking to technology.ot_asset. Business justification: Each Renewable Energy Certificate is generated by a specific generation asset; linking REC records to OT assets supports tracking of source generation.',
    `meter_id` BIGINT COMMENT 'Meter that recorded the generation associated with the REC.',
    `acp_amount` DECIMAL(18,2) COMMENT 'Total monetary amount owed for any compliance shortfall.',
    `acquisition_date` DATE COMMENT 'Date the utility acquired or generated the REC.',
    `alternative_compliance_payment_rate` DECIMAL(18,2) COMMENT 'Regulatory monetary rate applied per MWh of shortfall.',
    `certification_program` STRING COMMENT 'Program under which the REC was issued (e.g., REC, GREC).. Valid values are `REC|GREC|SREC|EIA-RE|Other`',
    `compliance_category` STRING COMMENT 'RPS tier or carve‑out to which the REC applies.. Valid values are `Tier1|Tier2|SolarCarveOut`',
    `compliance_filing_date` DATE COMMENT 'Date the RPS compliance report was filed with the regulator.',
    `compliance_gap_mwh` DECIMAL(18,2) COMMENT 'Shortfall (or surplus) of RECs after accounting for retirements.',
    `compliance_status` STRING COMMENT 'Regulatory status of the utilitys RPS compliance for the year.. Valid values are `compliant|non_compliant|pending|exempt`',
    `compliance_year` STRING COMMENT 'Reporting year to which the REC is applied for RPS compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the REC inventory record was first created.',
    `current_owner` STRING COMMENT 'Entity that currently holds the REC.',
    `eligibility_status` STRING COMMENT 'Whether the REC meets eligibility criteria for RPS compliance.. Valid values are `eligible|ineligible`',
    `expiration_date` DATE COMMENT 'Date after which the REC can no longer be used for compliance.',
    `generation_source` STRING COMMENT 'Primary energy source that produced the renewable generation associated with the REC.. Valid values are `solar|wind|hydro|biomass|geothermal|other`',
    `is_duplicate` BOOLEAN COMMENT 'Indicates if the REC record is a duplicate entry.',
    `is_transferable` BOOLEAN COMMENT 'Indicates whether the REC can be transferred to another party.',
    `jurisdiction` STRING COMMENT 'State or regional jurisdiction governing the RECs compliance requirement.',
    `market_value_usd` DECIMAL(18,2) COMMENT 'Estimated market value of the REC in U.S. dollars.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the REC.',
    `original_owner` STRING COMMENT 'Entity that originally owned the REC before acquisition.',
    `quantity_mwh` DECIMAL(18,2) COMMENT 'Energy amount represented by the REC, expressed in megawatt‑hours.',
    `rec_category_code` STRING COMMENT 'Internal code classifying the REC (e.g., solar, wind).',
    `rec_inventory_status` STRING COMMENT 'Current lifecycle status of the REC.. Valid values are `active|retired|transferred|cancelled`',
    `rec_serial_number` STRING COMMENT 'Unique serial number assigned by the registry to the REC.',
    `rec_type` STRING COMMENT 'Classification of the certificate (e.g., REC, SREC, GREC).. Valid values are `REC|SREC|GREC`',
    `recs_retired_to_date` DECIMAL(18,2) COMMENT 'Cumulative quantity of RECs that have been retired against the obligation.',
    `registry_platform` STRING COMMENT 'Electronic registry where the REC is tracked (e.g., WREGIS, NEPOOL GIS).. Valid values are `WREGIS|NEPOOL_GIS|PJM_EIS|ISO-NE|M-RETS`',
    `required_rec_quantity` DECIMAL(18,2) COMMENT 'Calculated number of RECs required to satisfy the RPS obligation for the year.',
    `retirement_date` DATE COMMENT 'Date the REC was retired or otherwise removed from the inventory.',
    `rps_obligation_mwh` DECIMAL(18,2) COMMENT 'Total retail electricity sales (MWh) that determine the utilitys RPS requirement for the compliance year.',
    `rps_requirement_percentage` DECIMAL(18,2) COMMENT 'Statutory percentage of retail sales that must be met with renewable energy.',
    `source_meter_reading_mwh` DECIMAL(18,2) COMMENT 'Metered generation volume that underlies the REC.',
    `transfer_date` DATE COMMENT 'Date the REC was transferred, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the REC inventory record.',
    `vintage_year` STRING COMMENT 'Calendar year in which the renewable electricity was generated.',
    CONSTRAINT pk_rec_inventory PRIMARY KEY(`rec_inventory_id`)
) COMMENT 'Renewable energy compliance master tracking the utilitys complete RPS position: RECs held, generated, purchased, retired, or transferred, together with RPS obligation positions by compliance year and jurisdiction. Captures REC serial numbers, generation source (solar, wind, hydro, biomass), generating facility, vintage, registry platform (WREGIS, NEPOOL GIS, PJM-EIS), acquisition/retirement dates, and compliance year assignment. RPS obligation tracking: total retail sales (MWh), RPS percentage requirement by tier (Tier 1, Tier 2, solar carve-out), required RECs, RECs retired to date, compliance gap or surplus, alternative compliance payment (ACP) rate and amounts, compliance filing date, and compliance status by jurisdiction. SSOT for the utilitys complete renewable portfolio standard compliance position including both the certificate inventory and the obligation calculus.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` (
    `rps_obligation_id` BIGINT COMMENT 'Unique surrogate key for the RPS obligation record.',
    `asset_permit_compliance_document_id` BIGINT COMMENT 'Reference to supporting compliance evidence or documentation.',
    `compliance_document_id` BIGINT COMMENT 'Reference to supporting compliance evidence or documentation.',
    `filing_id` BIGINT COMMENT 'Identifier of the regulatory filing that documents the RPS obligation.',
    `ot_asset_id` BIGINT COMMENT 'Foreign key linking to technology.ot_asset. Business justification: RPS obligations are met by output from designated generation assets; the utility tracks which assets contribute toward meeting the obligation.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: RPS obligation is linked to the rate case that defines the requirement.',
    `acp_amount_paid` DECIMAL(18,2) COMMENT 'Total dollar amount paid under the alternative compliance payment mechanism for the year.',
    `alternative_compliance_payment_rate` DECIMAL(18,2) COMMENT 'Statutory monetary rate per MWh of compliance shortfall used to calculate alternative compliance payments.',
    `compliance_gap_mwh` DECIMAL(18,2) COMMENT 'Difference between required RECs and RECs retired; positive indicates deficit, negative indicates surplus.',
    `compliance_gap_type` STRING COMMENT 'Indicates whether the gap represents a surplus (excess RECs) or a deficit (shortfall).. Valid values are `surplus|deficit`',
    `compliance_status` STRING COMMENT 'Current status of the RPS obligation for the year.. Valid values are `compliant|non_compliant|partial|exempt|pending`',
    `compliance_year` STRING COMMENT 'Calendar year for which the RPS compliance is measured.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RPS obligation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for monetary amounts.. Valid values are `USD|EUR|CAD|GBP|JPY|AUD`',
    `effective_date` DATE COMMENT 'Date on which the RPS obligation becomes effective.',
    `expiration_date` DATE COMMENT 'Date on which the RPS obligation expires, if applicable.',
    `jurisdiction_state` STRING COMMENT 'Two‑letter abbreviation of the state or jurisdiction governing the RPS requirement.',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance review or audit.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the obligation.',
    `obligation_type` STRING COMMENT 'Classification of the RPS obligation based on jurisdictional scope.. Valid values are `state|federal|regional`',
    `recs_retired_mwh` DECIMAL(18,2) COMMENT 'Total RECs that have been retired (submitted) for the compliance year and jurisdiction.',
    `recs_retired_percentage` DECIMAL(18,2) COMMENT 'Percentage of required RECs that have been retired.',
    `recs_retired_source` STRING COMMENT 'Origin of the retired RECs (e.g., generated internally, purchased from market, or transferred).. Valid values are `internal|external|market`',
    `regulatory_body` STRING COMMENT 'Regulatory agency responsible for the RPS requirement.. Valid values are `FERC|NERC|PUC|EPA|PHMSA`',
    `required_recs_mwh` DECIMAL(18,2) COMMENT 'Quantity of Renewable Energy Certificates (RECs) required to satisfy the RPS percentage, expressed in MWh.',
    `rps_requirement_percent` DECIMAL(18,2) COMMENT 'Statutory percentage of retail sales that must be met with renewable energy.',
    `source_system` STRING COMMENT 'Originating operational system that supplied the RPS data (e.g., Oracle CC&B, SAP ERP).',
    `total_retail_sales_mwh` DECIMAL(18,2) COMMENT 'Total electricity retail sales in megawatt‑hours for the jurisdiction and year.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the RPS obligation record.',
    CONSTRAINT pk_rps_obligation PRIMARY KEY(`rps_obligation_id`)
) COMMENT 'Renewable Portfolio Standard (RPS) compliance obligation record for each compliance year and jurisdiction. Captures the compliance year, state jurisdiction, total retail sales (MWh), RPS percentage requirement, required RECs (MWh), RECs retired to date, compliance gap or surplus, alternative compliance payment (ACP) rate, ACP amount paid, and compliance status. Tracks the utilitys annual RPS compliance position.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` (
    `correspondence_id` BIGINT COMMENT 'Primary key for correspondence',
    `person_id` BIGINT COMMENT 'Identifier of the regulatory affairs staff member responsible for this correspondence.',
    `created_by_user_employee_id` BIGINT COMMENT 'System user who initially created the correspondence record.',
    `employee_id` BIGINT COMMENT 'Identifier of the regulatory affairs staff member responsible for this correspondence.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Correspondence often pertains to a specific filing.',
    `updated_by_user_employee_id` BIGINT COMMENT 'System user who performed the most recent update.',
    `attachment_uri` STRING COMMENT 'Link to any attached document or file associated with the correspondence.',
    `body_summary` STRING COMMENT 'Short excerpt or summary of the correspondence content.',
    `confidentiality_level` STRING COMMENT 'Classification of the correspondence content based on sensitivity.. Valid values are `restricted|confidential|public`',
    `correspondence_category` STRING COMMENT 'High‑level business domain the correspondence relates to.. Valid values are `compliance|financial|operational|legal|other`',
    `correspondence_status` STRING COMMENT 'Current processing status of the correspondence.. Valid values are `open|closed|pending|escalated|withdrawn`',
    `correspondence_type` STRING COMMENT 'Category of the regulatory correspondence.. Valid values are `data_request|deficiency|comment|protest|settlement|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the correspondence record was first created in the system.',
    `direction` STRING COMMENT 'Indicates whether the correspondence was received from or sent to the regulator.. Valid values are `inbound|outbound`',
    `docket_number` STRING COMMENT 'Official docket number assigned by the regulatory body for tracking the correspondence.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time the correspondence was sent or received.',
    `is_archived` BOOLEAN COMMENT 'Indicates whether the correspondence has been moved to archive storage.',
    `notes` STRING COMMENT 'Free‑form notes entered by staff during handling.',
    `priority` STRING COMMENT 'Business priority assigned to the correspondence handling.. Valid values are `high|medium|low`',
    `regulatory_body` STRING COMMENT 'Name of the regulatory agency (e.g., FERC, NERC, State PUC).',
    `response_date` DATE COMMENT 'Actual date the response was sent to the regulator.',
    `response_due_date` DATE COMMENT 'Date by which a response must be provided to the regulator.',
    `response_required` BOOLEAN COMMENT 'Indicates whether a formal response is required for this correspondence.',
    `response_time_days` STRING COMMENT 'Number of calendar days taken to respond, calculated from due date to actual response date.',
    `retention_end_date` DATE COMMENT 'Date after which the correspondence may be archived or deleted per policy.',
    `subject` STRING COMMENT 'Brief subject line summarizing the purpose of the correspondence.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the correspondence record.',
    CONSTRAINT pk_correspondence PRIMARY KEY(`correspondence_id`)
) COMMENT 'Formal correspondence record between the utility and a regulatory body, including data requests, information requests (IRs), deficiency letters, comment letters, protest filings, and settlement communications. Captures the correspondence type, direction (inbound/outbound), regulatory body, docket reference, subject, date sent/received, response due date, response date, and responsible regulatory affairs staff. Maintains the complete regulatory communication audit trail.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` (
    `rate_case_testimony_id` BIGINT COMMENT 'Unique system-generated identifier for each rate case testimony.',
    `employee_id` BIGINT COMMENT 'System user ID of the person who created the testimony entry.',
    `last_modified_by_user_employee_id` BIGINT COMMENT 'System user ID of the person who last updated the testimony entry.',
    `rate_case_id` BIGINT COMMENT 'Identifier of the rate case docket to which the testimony relates.',
    `approval_date` DATE COMMENT 'Date on which the testimony received regulatory approval.',
    `checksum_sha256` STRING COMMENT 'Cryptographic hash of the document for integrity checks.. Valid values are `^[A-Fa-f0-9]{64}$`',
    `comments` STRING COMMENT 'Supplemental remarks or notes about the testimony.',
    `confidentiality_level` STRING COMMENT 'Indicates the sensitivity classification of the testimony.. Valid values are `public|confidential|restricted`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the testimony record was initially entered into the system.',
    `document_format` STRING COMMENT 'File format of the testimony document.. Valid values are `pdf|docx|txt`',
    `document_size_bytes` BIGINT COMMENT 'File size of the testimony document.',
    `document_uri` STRING COMMENT 'Location (URL or path) of the stored testimony document.',
    `exhibit_numbers` STRING COMMENT 'Comma‑separated list of exhibit identifiers attached to the testimony.',
    `filing_date` DATE COMMENT 'Calendar date the testimony was officially filed.',
    `filing_method` STRING COMMENT 'Means by which the testimony was submitted to the regulator.. Valid values are `electronic|paper|fax`',
    `is_archived` BOOLEAN COMMENT 'True when the testimony has been moved to archival storage.',
    `is_exhibit` BOOLEAN COMMENT 'True if the testimony is submitted as an exhibit to the docket.',
    `language` STRING COMMENT 'Primary language in which the testimony is written.. Valid values are `en|es|fr|de|zh|other`',
    `page_count` STRING COMMENT 'Total number of pages in the testimony document.',
    `rate_case_testimony_status` STRING COMMENT 'Workflow status of the testimony within the regulatory filing process.. Valid values are `draft|submitted|approved|rejected`',
    `rejection_reason` STRING COMMENT 'Explanation for why a submitted testimony was rejected.',
    `related_docket_number` STRING COMMENT 'Identifier of the docket to which the testimony is linked.',
    `retention_end_date` DATE COMMENT 'Compliance‑driven date after which the testimony may be disposed.',
    `subject_area` STRING COMMENT 'Primary subject matter addressed by the testimony.. Valid values are `revenue_requirement|cost_of_capital|depreciation|rate_design|other`',
    `testimony_text` STRING COMMENT 'Complete narrative content of the testimony.',
    `testimony_type` STRING COMMENT 'Indicates whether the testimony is a direct statement, a rebuttal, or a surrebuttal.. Valid values are `direct|rebuttal|surrebuttal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the testimony record.',
    `version_number` STRING COMMENT 'Sequential version identifier for updates to the testimony.',
    `witness_affiliation` STRING COMMENT 'Affiliation of the witness (e.g., utility, intervenor, commission staff).',
    `witness_name` STRING COMMENT 'Full legal name of the witness providing the testimony.',
    CONSTRAINT pk_rate_case_testimony PRIMARY KEY(`rate_case_testimony_id`)
) COMMENT 'Expert witness testimony or workpaper submitted as part of a rate case or regulatory proceeding. Captures the testimony type (direct, rebuttal, surrebuttal), witness name, witness affiliation (utility, intervenor, commission staff), testimony subject area (revenue requirement, cost of capital, depreciation, rate design), filing date, exhibit numbers, and associated rate case or docket. Tracks the evidentiary record of rate proceedings.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`body` (
    `body_id` BIGINT COMMENT 'Surrogate primary key for the regulatory body record.',
    `acronym` STRING COMMENT 'Common abbreviation or acronym of the agency (e.g., FERC, NERC).. Valid values are `^[A-Z]{2,10}$`',
    `address_line1` STRING COMMENT 'First line of the agencys mailing address.',
    `address_line2` STRING COMMENT 'Second line of the agencys mailing address (optional).',
    `applicable_states` STRING COMMENT 'Comma‑separated list of U.S. states where the agency has regulatory authority.',
    `body_description` STRING COMMENT 'Free‑form description of the agencys role and responsibilities.',
    `body_name` STRING COMMENT 'Full legal name of the regulatory agency.',
    `body_status` STRING COMMENT 'Current operational status of the agency record.. Valid values are `active|inactive|suspended|pending`',
    `city` STRING COMMENT 'City of the agencys address.',
    `compliance_deadline` DATE COMMENT 'Latest date by which required compliance information must be submitted to the agency.',
    `contact_department` STRING COMMENT 'Department within the agency where the primary contact works.',
    `contact_title` STRING COMMENT 'Job title of the primary agency contact.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the agencys location.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agency record was first created in the system.',
    `data_retention_policy` STRING COMMENT 'Policy governing how long agency records are retained.',
    `effective_date` DATE COMMENT 'Date the agencys jurisdiction became effective for the utility.',
    `email_verified` BOOLEAN COMMENT 'Indicates whether the primary contact email has been validated.',
    `expiration_date` DATE COMMENT 'Date the agencys jurisdiction or agreement expires, if applicable.',
    `external_reference_code` STRING COMMENT 'Identifier used by external regulatory systems to reference this agency.',
    `filing_portal_url` STRING COMMENT 'URL of the agencys electronic filing portal used for submissions.',
    `is_federal` BOOLEAN COMMENT 'True if the agency operates at the federal level.',
    `is_regional` BOOLEAN COMMENT 'True if the agency operates at a regional or multi‑state level.',
    `is_state` BOOLEAN COMMENT 'True if the agency operates at the state level.',
    `jurisdiction_type` STRING COMMENT 'Level of jurisdiction the agency operates under.. Valid values are `federal|state|regional`',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance review of the agency record.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the agency.',
    `phone_verified` BOOLEAN COMMENT 'Indicates whether the primary contact phone number has been validated.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the agencys address.',
    `primary_contact_email` STRING COMMENT 'Email address for the primary agency contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary point of contact at the agency.',
    `primary_contact_phone` STRING COMMENT 'Phone number for the primary agency contact.. Valid values are `^+?[0-9-s]{7,15}$`',
    `regulatory_scope` STRING COMMENT 'Primary regulatory domains the agency oversees.. Valid values are `electric|gas|environmental|safety|financial|multiple`',
    `review_cycle_months` STRING COMMENT 'Planned interval in months between mandatory reviews of the agency record.',
    `source_system` STRING COMMENT 'Originating source system for the agency data (e.g., SAP, Oracle).',
    `state_province` STRING COMMENT 'State or province component of the agencys address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agency record.',
    `website_url` STRING COMMENT 'Public website URL of the regulatory agency.',
    CONSTRAINT pk_body PRIMARY KEY(`body_id`)
) COMMENT 'Reference master for regulatory bodies and agencies that have jurisdiction over the utilitys operations. Captures the agency name, agency acronym (FERC, NERC, PUC, EPA, PHMSA, DOE, OSHA), jurisdiction type (federal, state, regional), regulatory scope (electric, gas, environmental, safety, financial), primary contact information, filing portal URL, and applicable states or regions. Used across all regulatory filings and compliance records.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` (
    `violation_notice_id` BIGINT COMMENT 'Unique identifier for each violation notice record.',
    `employee_id` BIGINT COMMENT 'Internal party (e.g., compliance team) accountable for managing the violation.',
    `ot_asset_id` BIGINT COMMENT 'Foreign key linking to technology.ot_asset. Business justification: Violation notices often reference a specific asset (e.g., a generator) that caused the breach; linking enables root‑cause analysis and remediation.',
    `finance_capex_project_id` BIGINT COMMENT 'Foreign key to a capital project that may be impacted by the violation.',
    `responsible_employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Violation notices are assigned to an employee for investigation and remediation; the link records that responsibility.',
    `actual_completion_date` DATE COMMENT 'Date when remediation activities were actually finished.',
    `compliance_deadline` DATE COMMENT 'Final date by which the utility must complete all required corrective actions.',
    `corrective_action_status` STRING COMMENT 'Current execution status of the corrective actions.. Valid values are `not_started|in_progress|completed|failed`',
    `corrective_action_summary` STRING COMMENT 'High‑level description of the actions to remediate the violation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the violation notice record was initially loaded.',
    `currency_code` STRING COMMENT 'Three‑letter currency code for the penalty amount (e.g., USD).',
    `discovery_date` DATE COMMENT 'The date the utility became aware of the violation.',
    `docket_reference` STRING COMMENT 'Identifier linking the notice to the regulators docket or case file.',
    `effectiveness_verification_method` STRING COMMENT 'Technique or metric used to confirm that corrective actions resolved the issue.',
    `evidence_document_uri` STRING COMMENT 'Link to electronic files (PDF, XML) that provide evidence for the violation.',
    `is_critical` BOOLEAN COMMENT 'True when the violation poses a high risk to safety or reliability.',
    `lessons_learned` STRING COMMENT 'Key takeaways and process improvements identified after closure.',
    `mitigation_plan_approval_date` DATE COMMENT 'Date the regulatory body formally approved the submitted mitigation plan.',
    `mitigation_plan_title` STRING COMMENT 'Descriptive title of the corrective action plan.',
    `notes` STRING COMMENT 'Additional comments or observations related to the violation notice.',
    `notice_number` STRING COMMENT 'Business identifier assigned to the violation notice by the regulatory body.',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Financial penalty amount associated with the violation.',
    `penalty_assessed_date` DATE COMMENT 'Date the regulator issued the penalty amount.',
    `penalty_paid_amount` DECIMAL(18,2) COMMENT 'Monetary amount the utility has paid toward the assessed penalty.',
    `penalty_paid_date` DATE COMMENT 'Date the penalty payment was received by the regulator.',
    `plan_closure_date` DATE COMMENT 'Date the mitigation plan was marked closed after verification.',
    `regulatory_body` STRING COMMENT 'The regulatory organization that issued the violation notice.. Valid values are `FERC|NERC|PUC|EPA|PHMSA`',
    `root_cause_analysis` STRING COMMENT 'Detailed explanation of the underlying cause of the violation.',
    `severity_classification` STRING COMMENT 'Regulatory severity rating of the violation.. Valid values are `low|medium|high|critical`',
    `standard_violated` STRING COMMENT 'Reference to the specific regulation, standard, or rule that was violated.',
    `target_completion_date` DATE COMMENT 'Planned date by which all corrective actions should be finished.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the latest modification to the violation notice record.',
    `violation_date` DATE COMMENT 'The calendar date on which the violation took place.',
    `violation_notice_status` STRING COMMENT 'Current processing status of the violation notice.. Valid values are `open|in_progress|resolved|closed|rejected`',
    `violation_type` STRING COMMENT 'Indicates whether the notice is a Notice of Violation (NOV), Notice of Alleged Violation (NAV), or an enforcement action.. Valid values are `nov|nav|enforcement`',
    CONSTRAINT pk_violation_notice PRIMARY KEY(`violation_notice_id`)
) COMMENT 'Notice of violation (NOV), alleged violation (NAV), or enforcement action received from a regulatory body, together with the full mitigation plan and corrective action lifecycle through resolution. Captures violation type, issuing regulatory body, standard or rule violated, violation date, discovery date, severity classification, penalty amount proposed/assessed, and resolution status. Includes the complete corrective response: mitigation plan title, root cause analysis, corrective actions list with individual action status, responsible parties, implementation milestones, target and actual completion dates, regulatory body approval of mitigation plan, effectiveness verification method, plan closure date, and lessons learned. SSOT for the full enforcement-to-resolution lifecycle including all remediation commitments and their verification.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` (
    `mitigation_plan_id` BIGINT COMMENT 'Unique identifier for the mitigation plan.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Mitigation plans for regulatory violations are often tied to the responsible customer account.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal party accountable for executing the plan.',
    `responsible_owner_employee_id` BIGINT COMMENT 'Identifier of the internal party accountable for executing the plan.',
    `actual_completion_date` DATE COMMENT 'Date when the mitigation plan was officially completed.',
    `approval_date` DATE COMMENT 'Date when the regulatory body granted approval.',
    `approval_status` STRING COMMENT 'Status of the plans approval by the relevant regulatory body.. Valid values are `approved|pending|rejected`',
    `audit_status` STRING COMMENT 'Current status of any audit related to the mitigation plan.. Valid values are `not_started|in_progress|completed|failed`',
    `comments` STRING COMMENT 'Free‑form notes or remarks related to the plan.',
    `compliance_deadline` DATE COMMENT 'Date by which the mitigation actions must satisfy the regulatory requirement.',
    `corrective_actions` STRING COMMENT 'Structured list (e.g., JSON) of actions required to remediate the violation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the mitigation plan record was first created.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary amounts.. Valid values are `USD|EUR|CAD|GBP|JPY`',
    `effective_from` DATE COMMENT 'Date when the mitigation plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the mitigation plan expires or is superseded (nullable).',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected monetary cost to implement the mitigation actions.',
    `evidence_required` BOOLEAN COMMENT 'Indicates whether supporting evidence must be submitted for the plan.',
    `evidence_submission_date` DATE COMMENT 'Date when the supporting evidence was submitted.',
    `evidence_submitted` BOOLEAN COMMENT 'Indicates whether the required evidence has been provided.',
    `financial_impact_estimate` DECIMAL(18,2) COMMENT 'Estimated impact on the utilitys financial statements if the plan is not executed.',
    `mitigation_plan_description` STRING COMMENT 'Detailed narrative of the mitigation plan, including scope and objectives.',
    `mitigation_plan_status` STRING COMMENT 'Current lifecycle state of the mitigation plan.. Valid values are `draft|pending|approved|in_progress|completed|closed`',
    `next_audit_due` DATE COMMENT 'Planned date for the next compliance audit of the plan.',
    `plan_number` STRING COMMENT 'External reference number assigned to the mitigation plan by the regulatory filing system.',
    `plan_type` STRING COMMENT 'Classification of the plan based on its purpose.. Valid values are `corrective|preventive|remedial`',
    `plan_version` STRING COMMENT 'Version number of the mitigation plan, incremented on each revision.',
    `priority` STRING COMMENT 'Business priority assigned to the mitigation plan.. Valid values are `low|medium|high`',
    `regulatory_body` STRING COMMENT 'Regulatory agency overseeing the obligation.. Valid values are `FERC|NERC|PUC|EPA|PHMSA`',
    `responsible_owner_name` STRING COMMENT 'Display name of the responsible owner.',
    `risk_rating` STRING COMMENT 'Risk level associated with the violation and its remediation.. Valid values are `low|medium|high|critical`',
    `root_cause` STRING COMMENT 'Narrative description of the underlying cause that triggered the mitigation plan.',
    `target_completion_date` DATE COMMENT 'Planned date by which all corrective actions should be finished.',
    `title` STRING COMMENT 'Descriptive title of the mitigation plan.',
    `updated_by` STRING COMMENT 'User identifier who last updated the mitigation plan.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the mitigation plan record.',
    `verification_method` STRING COMMENT 'Methodology used to verify that the mitigation actions achieved the intended outcome.',
    `created_by` STRING COMMENT 'User identifier who initially created the mitigation plan.',
    CONSTRAINT pk_mitigation_plan PRIMARY KEY(`mitigation_plan_id`)
) COMMENT 'Mitigation plan or corrective action plan (CAP) developed in response to a regulatory violation notice or compliance gap. Captures the plan title, associated violation or obligation, root cause description, corrective actions list, responsible parties, implementation milestones, target completion date, actual completion date, regulatory body approval status, and effectiveness verification method. Tracks the utilitys remediation commitments to regulators.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` (
    `ferc_form_id` BIGINT COMMENT 'Unique system-generated identifier for each FERC form submission record.',
    `business_entity_id` BIGINT COMMENT 'Identifier of the utility company submitting the form.',
    `finance_capex_project_id` BIGINT COMMENT 'Identifier of the internal project associated with the filing, if any.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Sum of adjustments (taxes, fees, discounts) applied to the gross amount.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment to the original filing.',
    `approval_date` DATE COMMENT 'Date the filing was approved by the regulatory body.',
    `case_number` STRING COMMENT 'Reference number of the rate case or proceeding linked to the filing.',
    `comments` STRING COMMENT 'Additional remarks or notes provided by the filing team.',
    `compliance_deadline` DATE COMMENT 'Date by which the filing must be completed to meet regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the filing record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values (e.g., USD).',
    `docket_number` STRING COMMENT 'Identifier of the docket associated with the filing.',
    `effective_date` DATE COMMENT 'Date the information in the filing is considered effective.',
    `expiration_date` DATE COMMENT 'Date the filing expires or is superseded (nullable).',
    `file_url` STRING COMMENT 'Link to the stored electronic copy of the submitted form.',
    `filing_category` STRING COMMENT 'Business classification of the filing (e.g., annual report, special amendment).. Valid values are `annual|quarterly|special|amendment`',
    `filing_date` DATE COMMENT 'Date the filing became effective for reporting purposes.',
    `filing_priority` STRING COMMENT 'Internal priority assigned to the filing for processing.. Valid values are `high|medium|low`',
    `filing_status` STRING COMMENT 'Current lifecycle status of the filing.. Valid values are `draft|submitted|approved|rejected|withdrawn`',
    `filing_type` STRING COMMENT 'Category of the FERC form (electric, gas, transmission, etc.).. Valid values are `form1|form2|form714|form2gas|form3`',
    `form_number` STRING COMMENT 'Official form number assigned by the Federal Energy Regulatory Commission (e.g., "Form 1", "Form 714").',
    `form_title` STRING COMMENT 'Descriptive title of the FERC form (e.g., "Annual Report of Major Electric Utilities").',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross monetary amount reported on the form before adjustments.',
    `is_amendment` BOOLEAN COMMENT 'Indicates whether this filing is an amendment (true) or an original filing (false).',
    `net_amount` DECIMAL(18,2) COMMENT 'Final net monetary amount after adjustments.',
    `plant_in_service_mwh` DECIMAL(18,2) COMMENT 'Total megawatt‑hours of generation capacity reported as in service.',
    `regulatory_body` STRING COMMENT 'Regulatory agency overseeing the filing.. Valid values are `FERC|NERC|PUC|EPA`',
    `reporting_year` STRING COMMENT 'Fiscal year for which the form is filed.',
    `submission_date` DATE COMMENT 'Date the form was submitted to the regulator.',
    `total_pages` STRING COMMENT 'Number of pages in the submitted form package.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the filing record.',
    `version_number` STRING COMMENT 'Sequential version number for the filing record, incremented on each change.',
    CONSTRAINT pk_ferc_form PRIMARY KEY(`ferc_form_id`)
) COMMENT 'FERC annual or periodic regulatory report form submission record (e.g., FERC Form 1 for electric utilities, FERC Form 2 for gas utilities, FERC Form 714 for transmission planning). Captures the form number, form title, reporting year, submission date, filing status, total pages, financial data summary (revenues, expenses, plant in service), and any amendments filed. SSOT for FERC mandatory financial and operational reporting submissions.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` (
    `eia_report_id` BIGINT COMMENT 'System-generated unique identifier for the EIA report record.',
    `compliance_obligation_id` BIGINT COMMENT 'Identifier of the regulatory compliance obligation linked to this report.',
    `finance_capex_project_id` BIGINT COMMENT 'Identifier of the capital project associated with the report, if any.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment if the report is an amendment to a prior filing.',
    `approval_status` STRING COMMENT 'Current approval status of the report after review.. Valid values are `pending|approved|rejected`',
    `capacity_mw` DECIMAL(18,2) COMMENT 'Total installed generation capacity reported, measured in megawatts.',
    `comments` STRING COMMENT 'Free‑form comments or notes about the report.',
    `compliance_deadline` DATE COMMENT 'Regulatory deadline by which the report must be filed.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the report record was first created in the system.',
    `customers_served` STRING COMMENT 'Number of distinct customers served by the reported facilities.',
    `data_quality_flag` STRING COMMENT 'Overall data quality assessment for the report.. Valid values are `good|questionable|bad`',
    `data_quality_notes` STRING COMMENT 'Detailed notes explaining data quality issues, if any.',
    `eia_form_version` STRING COMMENT 'Version identifier of the EIA form used for the filing.',
    `eia_report_status` STRING COMMENT 'Current lifecycle status of the report.. Valid values are `draft|submitted|approved|rejected`',
    `file_url` STRING COMMENT 'Link to the electronic file (PDF/CSV) of the submitted report.',
    `form_number` STRING COMMENT 'Official EIA form identifier such as "EIA-860", "EIA-861", or "EIA-923".',
    `fuel_consumption_mmbtu` DECIMAL(18,2) COMMENT 'Total fuel consumption for the period, measured in million British thermal units.',
    `fuel_type` STRING COMMENT 'Primary fuel source for the generation assets reported. [ENUM-REF-CANDIDATE: coal|natural_gas|nuclear|wind|solar|hydro|biomass|other — 8 candidates stripped; promote to reference product]',
    `generation_mwh` DECIMAL(18,2) COMMENT 'Total electricity generated during the reporting period, measured in megawatt-hours.',
    `is_amendment` BOOLEAN COMMENT 'Indicates whether this filing is an amendment to a prior report.',
    `jurisdiction_state` STRING COMMENT 'Two‑letter state code for the jurisdiction of the report.',
    `last_review_date` DATE COMMENT 'Date the report was last reviewed for accuracy.',
    `net_generation_mwh` DECIMAL(18,2) COMMENT 'Net electricity generation after plant own use, measured in megawatt-hours.',
    `regulatory_body` STRING COMMENT 'Regulatory agency overseeing the filing.. Valid values are `FERC|NERC|PUC|EPA|DOE`',
    `report_approval_date` DATE COMMENT 'Date the report was approved for submission.',
    `report_author` STRING COMMENT 'Name of the internal employee or team that prepared the report.',
    `report_category` STRING COMMENT 'High‑level category of the report content.. Valid values are `generation|consumption|fuel|capacity|sales`',
    `report_period_quarter` STRING COMMENT 'Quarter of the reporting period, if applicable.. Valid values are `Q1|Q2|Q3|Q4`',
    `report_period_year` STRING COMMENT 'Calendar year of the reporting period.',
    `report_title` STRING COMMENT 'Descriptive title of the EIA report (e.g., "Annual Electric Generator Report").',
    `report_type` STRING COMMENT 'Specific EIA form type for the submission.. Valid values are `EIA-860|EIA-861|EIA-923`',
    `reporting_period_end` DATE COMMENT 'Last day of the reporting period covered by the report.',
    `reporting_period_start` DATE COMMENT 'First day of the reporting period covered by the report.',
    `reviewer_name` STRING COMMENT 'Name of the person who performed the most recent review.',
    `source_system` STRING COMMENT 'Originating system that supplied the report data (e.g., "EIA").',
    `submission_date` DATE COMMENT 'Date the report was submitted to the EIA.',
    `submission_method` STRING COMMENT 'Method used to submit the report to the EIA.. Valid values are `electronic|paper`',
    `total_sales_usd` DECIMAL(18,2) COMMENT 'Total revenue from electricity sales reported for the period, in U.S. dollars.',
    `unit_of_measure` STRING COMMENT 'Standard unit used for quantitative fields in the report.. Valid values are `MW|MWh|MMBtu|USD`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the report record.',
    `version_number` STRING COMMENT 'Version of the report record, incremented on each update.',
    CONSTRAINT pk_eia_report PRIMARY KEY(`eia_report_id`)
) COMMENT 'U.S. Energy Information Administration (EIA) mandatory survey or report submission record (e.g., EIA-860 Annual Electric Generator Report, EIA-861 Annual Electric Power Industry Report, EIA-923 Power Plant Operations Report). Captures the form number, reporting period, submission date, filing status, key reported metrics (capacity MW, generation MWh, fuel consumption, customers served), and amendment history. SSOT for EIA mandatory reporting compliance.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` (
    `regulatory_audit_id` BIGINT COMMENT 'Unique identifier for the regulatory audit record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Regulatory audits are performed on individual assets; audit records must reference the audited asset for findings and compliance status.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Regulatory audits may be performed on a specific customer’s facilities; linking audit to account enables audit tracking per customer.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Regulatory audits record which employee created the audit entry; this supports audit trail and internal control reporting.',
    `internal_order_id` BIGINT COMMENT 'Foreign key linking to finance.internal_order. Business justification: Audit work is managed as internal orders for cost allocation and financial control, required for audit expense accounting.',
    `docket_id` BIGINT COMMENT 'Identifier of the regulatory docket associated with the audit.',
    `filing_id` BIGINT COMMENT 'Identifier of the regulatory filing tied to the audit.',
    `rate_case_id` BIGINT COMMENT 'Identifier of the rate case linked to the audit, if applicable.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Regulatory audits frequently assess SCADA system controls; recording the audited system links audit findings to the relevant technology.',
    `audit_category` STRING COMMENT 'Broad classification of the audit focus area.. Valid values are `Financial|Operational|Safety|Compliance|Environmental`',
    `audit_scope` STRING COMMENT 'Narrative description of the audit scope, including systems, processes, and facilities examined.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit.. Valid values are `Planned|In Progress|Completed|Closed|Cancelled`',
    `audit_type` STRING COMMENT 'Classification of the audit based on the regulatory body or internal audit type.. Valid values are `NERC|FERC|PUC|EPA|State|Internal`',
    `compliance_gap_summary` STRING COMMENT 'Summary of identified compliance gaps.',
    `compliance_status` STRING COMMENT 'Overall compliance determination after the audit.. Valid values are `Compliant|Non-Compliant|Partial|Pending`',
    `conducting_body` STRING COMMENT 'Organization or agency that performed the audit.. Valid values are `NERC|FERC|PUC|EPA|State Agency|Internal Audit Team`',
    `confidentiality_level` STRING COMMENT 'Data sensitivity classification for the audit record.',
    `document_url` STRING COMMENT 'Link to the stored audit report or supporting documents.',
    `evidence_count` STRING COMMENT 'Number of evidence items attached to the audit.',
    `final_report_date` DATE COMMENT 'Date the final audit report was released.',
    `fines_currency` STRING COMMENT 'ISO 4217 currency code for fines.. Valid values are `^[A-Z]{3}$`',
    `fines_paid_amount` DECIMAL(18,2) COMMENT 'Portion of fines that have been paid to the regulator.',
    `fines_paid_date` DATE COMMENT 'Date when fines were paid.',
    `fines_total_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary penalties identified by the audit.',
    `followup_actions_count` STRING COMMENT 'Number of corrective actions or recommendations issued.',
    `followup_due_date` DATE COMMENT 'Deadline for completing all follow‑up actions.',
    `is_external` BOOLEAN COMMENT 'Indicates whether the audit was performed by an external third‑party auditor.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the primary audit site.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the primary audit site.',
    `notes` STRING COMMENT 'Free‑form notes captured by auditors.',
    `number_of_findings` STRING COMMENT 'Total count of distinct audit findings identified.',
    `number_of_violations` STRING COMMENT 'Count of findings that constitute regulatory violations.',
    `on_site_end_date` DATE COMMENT 'Date when on‑site audit activities concluded.',
    `on_site_start_date` DATE COMMENT 'Date when on‑site audit activities began.',
    `outcome_description` STRING COMMENT 'Narrative explanation of the overall outcome.',
    `overall_outcome` STRING COMMENT 'High‑level result of the audit.. Valid values are `Pass|Fail|Conditional|Pending`',
    `period_end` DATE COMMENT 'Last day of the audit coverage period.',
    `period_start` DATE COMMENT 'First day of the audit coverage period.',
    `preliminary_findings_date` DATE COMMENT 'Date the preliminary findings were issued to the audited entity.',
    `priority` STRING COMMENT 'Priority assigned to the audit based on risk and impact.. Valid values are `High|Medium|Low`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the audit record was first captured in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit record.',
    `review_date` DATE COMMENT 'Date the audit was formally reviewed.',
    `reviewed_by` STRING COMMENT 'Individual or team that performed the final review of the audit.',
    `risk_rating` STRING COMMENT 'Qualitative risk rating for the audit.. Valid values are `Critical|High|Medium|Low|Negligible`',
    `risk_score` DECIMAL(18,2) COMMENT 'Numeric risk score (0‑100) derived from risk assessment.',
    `status_reason` STRING COMMENT 'Reason or comment explaining the current audit status.',
    `updated_by` STRING COMMENT 'User or system that last modified the audit record.',
    CONSTRAINT pk_regulatory_audit PRIMARY KEY(`regulatory_audit_id`)
) COMMENT 'Regulatory audit or compliance review conducted by or on behalf of a regulatory body (NERC audit, FERC audit, PUC management audit, EPA inspection). Captures the audit type, conducting body, audit scope, audit period, on-site start date, on-site end date, preliminary findings date, final report date, number of findings, number of violations identified, and overall audit outcome. Tracks the utilitys regulatory examination history and audit readiness posture.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_body_id` FOREIGN KEY (`body_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`body`(`body_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_cpcn_application_id` FOREIGN KEY (`cpcn_application_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`cpcn_application`(`cpcn_application_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_eia_report_id` FOREIGN KEY (`eia_report_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`eia_report`(`eia_report_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_emission_allowance_id` FOREIGN KEY (`emission_allowance_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`emission_allowance`(`emission_allowance_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_ferc_form_id` FOREIGN KEY (`ferc_form_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`ferc_form`(`ferc_form_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_irp_submission_id` FOREIGN KEY (`irp_submission_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`irp_submission`(`irp_submission_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_mitigation_plan_id` FOREIGN KEY (`mitigation_plan_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`mitigation_plan`(`mitigation_plan_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_environmental_permit_id` FOREIGN KEY (`environmental_permit_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`environmental_permit`(`environmental_permit_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ADD CONSTRAINT `fk_regulatory_filing_violation_notice_id` FOREIGN KEY (`violation_notice_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`violation_notice`(`violation_notice_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ADD CONSTRAINT `fk_regulatory_tariff_schedule_superseded_by_schedule_tariff_schedule_id` FOREIGN KEY (`superseded_by_schedule_tariff_schedule_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ADD CONSTRAINT `fk_regulatory_regulatory_tariff_rider_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ADD CONSTRAINT `fk_regulatory_commission_order_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ADD CONSTRAINT `fk_regulatory_commission_order_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ADD CONSTRAINT `fk_regulatory_commission_order_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ADD CONSTRAINT `fk_regulatory_compliance_obligation_related_obligation_compliance_obligation_id` FOREIGN KEY (`related_obligation_compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ADD CONSTRAINT `fk_regulatory_compliance_evidence_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ADD CONSTRAINT `fk_regulatory_cip_standard_body_id` FOREIGN KEY (`body_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`body`(`body_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ADD CONSTRAINT `fk_regulatory_cip_asset_classification_body_id` FOREIGN KEY (`body_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`body`(`body_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ADD CONSTRAINT `fk_regulatory_irp_submission_body_id` FOREIGN KEY (`body_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`body`(`body_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ADD CONSTRAINT `fk_regulatory_cpcn_application_tariff_schedule_id` FOREIGN KEY (`tariff_schedule_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`tariff_schedule`(`tariff_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ADD CONSTRAINT `fk_regulatory_rab_asset_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ADD CONSTRAINT `fk_regulatory_rps_obligation_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ADD CONSTRAINT `fk_regulatory_rps_obligation_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ADD CONSTRAINT `fk_regulatory_correspondence_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ADD CONSTRAINT `fk_regulatory_rate_case_testimony_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ADD CONSTRAINT `fk_regulatory_eia_report_compliance_obligation_id` FOREIGN KEY (`compliance_obligation_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`compliance_obligation`(`compliance_obligation_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ADD CONSTRAINT `fk_regulatory_regulatory_audit_docket_id` FOREIGN KEY (`docket_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`docket`(`docket_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ADD CONSTRAINT `fk_regulatory_regulatory_audit_filing_id` FOREIGN KEY (`filing_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`filing`(`filing_id`);
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ADD CONSTRAINT `fk_regulatory_regulatory_audit_rate_case_id` FOREIGN KEY (`rate_case_id`) REFERENCES `power_and_utilities_v2`.`regulatory`.`rate_case`(`rate_case_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`regulatory` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `power_and_utilities_v2`.`regulatory` SET TAGS ('dbx_domain' = 'regulatory');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` SET TAGS ('dbx_subdomain' = 'regulatory_filings');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `body_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `cpcn_application_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Cpcn Application Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `eia_report_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Eia Report Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `emission_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Emission Allowance Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `ferc_form_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Ferc Form Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `irp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Irp Submission Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `large_customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Large Customer Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `mitigation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Mitigation Plan Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Regulatory Environmental Permit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Regulatory Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `asset_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `finance_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `responsible_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Violation Notice Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `file_url` SET TAGS ('dbx_business_glossary_term' = 'File URL');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `filing_category` SET TAGS ('dbx_business_glossary_term' = 'Filing Category');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `filing_category` SET TAGS ('dbx_value_regex' = 'compliance|rate_case|planning|environmental');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `filing_description` SET TAGS ('dbx_business_glossary_term' = 'Filing Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|portal');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `filing_number` SET TAGS ('dbx_business_glossary_term' = 'Filing Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|withdrawn|closed');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Is Amendment Flag');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Filing Priority');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `responsible_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Organizational Unit');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'web_portal|email|mail|fax');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`filing` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Filing Version');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` SET TAGS ('dbx_subdomain' = 'regulatory_filings');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Staff Identifier (ASSGN_STAFF_ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count (AMEND_CNT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date (CLOSURE_DT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (CONF_LVL)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|confidential|restricted');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `current_status` SET TAGS ('dbx_business_glossary_term' = 'Current Status (CURR_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `current_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|withdrawn|settled|appealed');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `decision_date` SET TAGS ('dbx_business_glossary_term' = 'Decision Date (DECISION_DT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `decision_summary` SET TAGS ('dbx_business_glossary_term' = 'Decision Summary (DECISION_SUM)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `docket_category` SET TAGS ('dbx_business_glossary_term' = 'Docket Category (DCKT_CAT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `docket_category` SET TAGS ('dbx_value_regex' = 'energy|gas|environment|safety|market');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `docket_description` SET TAGS ('dbx_business_glossary_term' = 'Docket Description (DCKT_DESC)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Docket Number (DCKT_NUM)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `expected_decision_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Decision Date (EXP_DEC_DT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date (FILING_DT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `is_appealed` SET TAGS ('dbx_business_glossary_term' = 'Is Appealed Flag (IS_APPEALED)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential Flag (IS_CONF)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `is_settled` SET TAGS ('dbx_business_glossary_term' = 'Is Settled Flag (IS_SETTLED)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JURISD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `last_response_date` SET TAGS ('dbx_business_glossary_term' = 'Last Response Date (LR_RESP_DT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `last_response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Last Response Due Date (LR_DUE_DT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `next_action_description` SET TAGS ('dbx_business_glossary_term' = 'Next Action Description (NEXT_ACT_DESC)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `next_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Due Date (NEXT_ACT_DUE_DT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `open_date` SET TAGS ('dbx_business_glossary_term' = 'Open Date (OPEN_DT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Docket Outcome (OUTCOME)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'approved|rejected|modified|pending|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `participant_count` SET TAGS ('dbx_business_glossary_term' = 'Participant Count (PARTICIPANT_CNT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `presiding_officer` SET TAGS ('dbx_business_glossary_term' = 'Presiding Officer (PRES_OFFICER)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `proceeding_type` SET TAGS ('dbx_business_glossary_term' = 'Proceeding Type (PROC_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `proceeding_type` SET TAGS ('dbx_value_regex' = 'rate_case|cpcn|grc|enforcement|rulemaking|complaint');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Record Source System (SRC_SYS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|State_PUC|EPA|PHMSA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `regulatory_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Fee Amount (REG_FEE_AMT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `related_case_number` SET TAGS ('dbx_business_glossary_term' = 'Related Case Number (REL_CASE_NUM)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason (STATUS_RSN)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Docket Title (DCKT_TITLE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`docket` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` SET TAGS ('dbx_subdomain' = 'regulatory_filings');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `authorized_revenue_requirement` SET TAGS ('dbx_business_glossary_term' = 'Authorized Revenue Requirement');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `authorized_roe` SET TAGS ('dbx_business_glossary_term' = 'Authorized Return on Equity (ROE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `capital_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `case_category` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Category');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `case_category` SET TAGS ('dbx_value_regex' = 'general|special|interim');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `case_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Case Closure Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `case_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `case_priority` SET TAGS ('dbx_business_glossary_term' = 'Case Priority');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `case_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `case_submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'Case Submission Deadline');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `case_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `case_type` SET TAGS ('dbx_value_regex' = 'electric|gas|combined');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `cost_of_capital` SET TAGS ('dbx_business_glossary_term' = 'Cost of Capital');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Method');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `depreciation_method` SET TAGS ('dbx_value_regex' = 'straight_line|declining_balance|units_of_production');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `exhibit_numbers` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Numbers');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `expert_witness_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Expert Witness Affiliation');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `expert_witness_name` SET TAGS ('dbx_business_glossary_term' = 'Expert Witness Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `expert_witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `expert_witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `final_order_date` SET TAGS ('dbx_business_glossary_term' = 'Final Order Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `operating_expenditure` SET TAGS ('dbx_business_glossary_term' = 'Operating Expenditure (OPEX)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Outcome');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'approved|denied|settled|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Outcome Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `rab_value` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Base (RAB) Value');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `rate_case_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `rate_case_status` SET TAGS ('dbx_value_regex' = 'draft|filed|pending|approved|denied|closed');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `rate_design` SET TAGS ('dbx_business_glossary_term' = 'Rate Design Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|PUC|NERC|EPA|PHMSA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `requested_revenue_requirement` SET TAGS ('dbx_business_glossary_term' = 'Requested Revenue Requirement');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `requested_roe` SET TAGS ('dbx_business_glossary_term' = 'Requested Return on Equity (ROE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `test_year` SET TAGS ('dbx_business_glossary_term' = 'Test Year');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `testimony_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Testimony Filing Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `testimony_subject_area` SET TAGS ('dbx_business_glossary_term' = 'Testimony Subject Area');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `testimony_subject_area` SET TAGS ('dbx_value_regex' = 'revenue_requirement|cost_of_capital|depreciation|rate_design|other');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `testimony_type` SET TAGS ('dbx_business_glossary_term' = 'Testimony Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `testimony_type` SET TAGS ('dbx_value_regex' = 'direct|rebuttal|surrebuttal');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `total_allowed_rate` SET TAGS ('dbx_business_glossary_term' = 'Total Allowed Rate');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` SET TAGS ('dbx_subdomain' = 'regulatory_filings');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `superseded_by_schedule_tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Schedule Identifier (SUPERSEDES_ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `authorizing_rate_case` SET TAGS ('dbx_business_glossary_term' = 'Authorizing Rate Case (RATE_CASE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `base_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Rate (BASE_RATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class (CLASS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `demand_charge` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge (DEMAND)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `energy_charge` SET TAGS ('dbx_business_glossary_term' = 'Energy Charge (ENERGY)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `fixed_charge` SET TAGS ('dbx_business_glossary_term' = 'Fixed Charge (FIXED)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JUR)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Tariff Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type (STRUCTURE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_value_regex' = 'flat|tou|cpp|rtp|tiered|demand');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date (APPROVAL_DATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (BODY)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|EPA|PHMSA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `revenue_allocation_percentages` SET TAGS ('dbx_business_glossary_term' = 'Revenue Allocation Percentages (REV_ALLOC)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'electric|gas|transmission|distribution');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `tariff_category` SET TAGS ('dbx_business_glossary_term' = 'Tariff Category (CATEGORY)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Tariff Code (CODE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `tariff_name` SET TAGS ('dbx_business_glossary_term' = 'Tariff Name (NAME)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `tariff_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Tariff Description (DESC)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `tariff_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Tariff Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `tariff_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|superseded|retired');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `tiered_blocks` SET TAGS ('dbx_business_glossary_term' = 'Tiered Blocks (TIERS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `time_of_use_periods` SET TAGS ('dbx_business_glossary_term' = 'Time‑of‑Use Periods (TOU_PERIODS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`tariff_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VER)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` SET TAGS ('dbx_subdomain' = 'regulatory_filings');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `regulatory_tariff_rider_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Tariff Rider Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Tariff Schedule Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `applicable_customer_class` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Class');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `applicable_customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `approval_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `calculation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Calculation Methodology');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Docket Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount (MONETARY)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'fixed|variable');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|EPA|PHMSA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `regulatory_tariff_rider_description` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rider Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `regulatory_tariff_rider_status` SET TAGS ('dbx_business_glossary_term' = 'Rider Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `regulatory_tariff_rider_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|withdrawn|expired');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `rider_code` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rider Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `rider_name` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rider Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `rider_type` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rider Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `rider_type` SET TAGS ('dbx_value_regex' = 'fuel_adjustment|infrastructure_surcharge|renewable_portfolio_standard|demand_response|low_income_assistance');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `sunset_date` SET TAGS ('dbx_business_glossary_term' = 'Sunset Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|MWh|therm|MCF');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_tariff_rider` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` SET TAGS ('dbx_subdomain' = 'stakeholder_communication');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `commission_order_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Order Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Rate Case ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Related Regulatory Filing ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `tariff_id` SET TAGS ('dbx_business_glossary_term' = 'Related Tariff ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Related Tariff ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `tech_project_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Project Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `appeal_deadline` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `commission_order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `commission_order_status` SET TAGS ('dbx_value_regex' = 'open|closed|in_progress|appealed|revoked');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `compliance_action_required` SET TAGS ('dbx_business_glossary_term' = 'Required Compliance Action');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `compliance_evidence_document` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence Document');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'pending|compliant|non_compliant|waived');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Docket Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Order Effective Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Order Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `is_appealed` SET TAGS ('dbx_business_glossary_term' = 'Appeal Flag');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Order Issue Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `issuing_body` SET TAGS ('dbx_business_glossary_term' = 'Issuing Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `order_category` SET TAGS ('dbx_business_glossary_term' = 'Order Category');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `order_category` SET TAGS ('dbx_value_regex' = 'rate|environment|safety|market|operational');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `order_document_url` SET TAGS ('dbx_business_glossary_term' = 'Order Document URL');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Order Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `order_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `order_summary` SET TAGS ('dbx_business_glossary_term' = 'Order Summary');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Order Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'final|interim|show_cause|consent_decree|compliance');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `regulatory_area` SET TAGS ('dbx_business_glossary_term' = 'Regulated Business Area');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `regulatory_area` SET TAGS ('dbx_value_regex' = 'transmission|generation|distribution|safety|market|environment');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`commission_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation ID (CO_ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Regulatory Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `related_obligation_compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Related Obligation ID (REL_OBL_ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `audit_findings_count` SET TAGS ('dbx_business_glossary_term' = 'Audit Findings Count (AUDIT_FIND_COUNT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `audit_readiness_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Readiness Status (AUDIT_RDY_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `audit_readiness_status` SET TAGS ('dbx_value_regex' = 'ready|not_ready|in_progress');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments (COMMENTS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline (COMP_DEADLINE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_evidence_last_updated` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence Last Updated Date (EVID_LAST_UPD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_evidence_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence Status (EVID_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_evidence_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_gap_analysis` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gap Analysis (GAP_ANALYSIS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_obligation_description` SET TAGS ('dbx_business_glossary_term' = 'Obligation Description (OBL_DESC)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_obligation_status` SET TAGS ('dbx_business_glossary_term' = 'Obligation Lifecycle Status (OBL_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_obligation_status` SET TAGS ('dbx_value_regex' = 'active|pending|completed|closed|non_compliant|exempt');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMP_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|exempt');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Due Date (DUE_DATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `evidence_count` SET TAGS ('dbx_business_glossary_term' = 'Evidence Count (EVID_COUNT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence Required Flag (EVID_REQ)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date (LAST_AUDIT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `last_evidence_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Last Evidence Submission Date (LAST_EVID_SUB_DATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `next_audit_due` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date (NEXT_AUDIT_DUE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_code` SET TAGS ('dbx_business_glossary_term' = 'Obligation Code (OBL_CODE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_title` SET TAGS ('dbx_business_glossary_term' = 'Obligation Title (OBL_TITLE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type (OBL_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'CIP|RPS|Safety|Environmental|Rate');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount (PENALTY_AMT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `penalty_currency` SET TAGS ('dbx_business_glossary_term' = 'Penalty Currency (PENALTY_CURR)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `regulation_source` SET TAGS ('dbx_business_glossary_term' = 'Regulation Source (REG_SRC)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `regulation_source` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|EPA|PHMSA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|EPA|PHMSA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `responsible_business_unit` SET TAGS ('dbx_business_glossary_term' = 'Responsible Business Unit (RESP_BUS_UNIT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RISK_RATING)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RISK_SCORE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `source_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Document Reference (SRC_DOC_REF)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `source_document_type` SET TAGS ('dbx_business_glossary_term' = 'Source Document Type (SRC_DOC_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `source_document_type` SET TAGS ('dbx_value_regex' = 'order|policy|regulation|notice');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_obligation` ALTER COLUMN `violation_count` SET TAGS ('dbx_business_glossary_term' = 'Violation Count (VIOL_COUNT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `compliance_evidence_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Evidence ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Obligation ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'SHA‑256 Checksum');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `collection_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `compliance_evidence_description` SET TAGS ('dbx_business_glossary_term' = 'Evidence Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `compliance_evidence_status` SET TAGS ('dbx_business_glossary_term' = 'Evidence Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `compliance_evidence_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|accepted|rejected|archived');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|internal|public');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `document_uri` SET TAGS ('dbx_business_glossary_term' = 'Document URI');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `evidence_number` SET TAGS ('dbx_business_glossary_term' = 'Evidence Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `evidence_subtype` SET TAGS ('dbx_business_glossary_term' = 'Evidence Subtype');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_business_glossary_term' = 'Evidence Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `evidence_type` SET TAGS ('dbx_value_regex' = 'document|test_result|inspection|attestation|log_file');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|xlsx|txt|csv');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Is Archived');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|EPA|PHMSA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `related_system` SET TAGS ('dbx_business_glossary_term' = 'Related System');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `submitting_party` SET TAGS ('dbx_business_glossary_term' = 'Submitting Party');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Evidence Title');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`compliance_evidence` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `cip_standard_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Standard ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `body_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Standard Regulatory Body Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `applicability_criteria` SET TAGS ('dbx_business_glossary_term' = 'Applicability Criteria');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `asset_impact_total` SET TAGS ('dbx_business_glossary_term' = 'Total Asset Impact Count');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `cip_standard_status` SET TAGS ('dbx_business_glossary_term' = 'Standard Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `cip_standard_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|pending|retired');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `classification_rationale` SET TAGS ('dbx_business_glossary_term' = 'Classification Rationale');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'mandatory|voluntary|informational');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `high_impact_asset_count` SET TAGS ('dbx_business_glossary_term' = 'High Impact Asset Count');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `low_impact_asset_count` SET TAGS ('dbx_business_glossary_term' = 'Low Impact Asset Count');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `medium_impact_asset_count` SET TAGS ('dbx_business_glossary_term' = 'Medium Impact Asset Count');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `requirement_count` SET TAGS ('dbx_business_glossary_term' = 'Requirement Count');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `review_cycle` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `review_cycle` SET TAGS ('dbx_value_regex' = 'annual|biennial|triennial');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Maximo|Custom');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `standard_code` SET TAGS ('dbx_business_glossary_term' = 'CIP Standard Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `standard_title` SET TAGS ('dbx_business_glossary_term' = 'CIP Standard Title');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_standard` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'CIP Standard Version');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `cip_asset_classification_id` SET TAGS ('dbx_business_glossary_term' = 'CIP Asset Classification ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `body_id` SET TAGS ('dbx_business_glossary_term' = 'Cip Asset Classification Regulatory Body Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `person_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `person_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `tertiary_cip_registry_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `asset_location` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `asset_name` SET TAGS ('dbx_business_glossary_term' = 'Asset Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Asset Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `asset_type` SET TAGS ('dbx_value_regex' = 'substation|control_center|generation_facility|transmission_line|distribution_transformer');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `cip_asset_classification_status` SET TAGS ('dbx_business_glossary_term' = 'Classification Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `cip_asset_classification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `cip_requirement` SET TAGS ('dbx_business_glossary_term' = 'CIP Requirement');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `cip_requirement` SET TAGS ('dbx_value_regex' = 'CIP-002|CIP-003|CIP-004|CIP-005|CIP-006|CIP-007');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `classification_date` SET TAGS ('dbx_business_glossary_term' = 'Classification Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `classification_rationale` SET TAGS ('dbx_business_glossary_term' = 'Classification Rationale');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `compliance_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Reference');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `impact_level` SET TAGS ('dbx_business_glossary_term' = 'Impact Level (CIP)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `impact_level` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `last_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Audit Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Degrees)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Degrees)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Region');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `regulatory_region` SET TAGS ('dbx_value_regex' = 'NERC|FERC|STATE|EPA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `responsible_engineer_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Engineer Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `responsible_engineer_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `responsible_engineer_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'sap|maximo|arcgis|mdm|etrm');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cip_asset_classification` ALTER COLUMN `voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` SET TAGS ('dbx_subdomain' = 'regulatory_filings');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `irp_submission_id` SET TAGS ('dbx_business_glossary_term' = 'Integrated Resource Plan (IRP) Submission ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `body_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `alternative_scenarios_description` SET TAGS ('dbx_business_glossary_term' = 'Alternative Scenarios Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `approval_body` SET TAGS ('dbx_business_glossary_term' = 'Approval Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'IRP Approval Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `approval_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Reference Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'IRP Approval Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `climate_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Climate Impact Assessment');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments or Notes');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `demand_response_program_included` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Program Included Flag');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'IRP Filing Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `filing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Filing Deadline Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `irp_document_url` SET TAGS ('dbx_business_glossary_term' = 'IRP Document URL');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `is_long_term_plan` SET TAGS ('dbx_business_glossary_term' = 'Is Long-Term Plan Flag');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified By');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `net_present_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Net Present Value (USD) (USD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `planned_demand_response_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Planned Demand Response Capacity (Megawatt) (MW)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `planned_fossil_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Planned Fossil Fuel Capacity (Megawatt) (MW)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `planned_nuclear_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Planned Nuclear Capacity (Megawatt) (MW)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `planned_renewable_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Planned Renewable Capacity (Megawatt) (MW)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `planned_retirements_mw` SET TAGS ('dbx_business_glossary_term' = 'Planned Retirements Capacity (Megawatt) (MW)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `planned_storage_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Planned Storage Capacity (Megawatt) (MW)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `planning_horizon_years` SET TAGS ('dbx_business_glossary_term' = 'Planning Horizon (Years)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `preferred_portfolio_description` SET TAGS ('dbx_business_glossary_term' = 'Preferred Portfolio Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (FERC, NERC, PUC, DOE, EPA)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|DOE|EPA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `regulatory_body_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `renewable_energy_certificate_target` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate Target');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `renewable_resource_mix` SET TAGS ('dbx_business_glossary_term' = 'Renewable Resource Mix Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `risk_assessment_summary` SET TAGS ('dbx_business_glossary_term' = 'Risk Assessment Summary');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `stakeholder_engagement_summary` SET TAGS ('dbx_business_glossary_term' = 'Stakeholder Engagement Summary');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `storage_technology_type` SET TAGS ('dbx_business_glossary_term' = 'Storage Technology Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `storage_technology_type` SET TAGS ('dbx_value_regex' = 'battery|pumped_hydro|compressed_air|flywheel');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `submission_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'IRP Cycle Year');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `submission_number` SET TAGS ('dbx_business_glossary_term' = 'IRP Submission Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_business_glossary_term' = 'IRP Submission Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `submission_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|finalized');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_business_glossary_term' = 'IRP Submission Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `submission_type` SET TAGS ('dbx_value_regex' = 'initial|update|supplemental');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `submitted_by` SET TAGS ('dbx_business_glossary_term' = 'Submitted By (User or Department)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `total_capital_expenditure_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Capital Expenditure (USD) (USD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `total_operating_expenditure_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Operating Expenditure (USD) (USD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `total_projected_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Projected Load (Megawatt) (MW)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'IRP Document Version Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`irp_submission` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` SET TAGS ('dbx_subdomain' = 'regulatory_filings');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `cpcn_application_id` SET TAGS ('dbx_business_glossary_term' = 'Certificate of Public Convenience and Necessity (CPCN) Application ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `applicant_organization_business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Organization ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Organization ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Project Manager ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Related Tariff Schedule ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Email');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `applicant_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `applicant_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `applicant_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `applicant_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Contact Phone');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `applicant_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `application_number` SET TAGS ('dbx_business_glossary_term' = 'CPCN Application Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `application_status` SET TAGS ('dbx_business_glossary_term' = 'Application Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `application_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|closed');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `business_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Business Event Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity (Megawatt)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `capex_currency` SET TAGS ('dbx_business_glossary_term' = 'CAPEX Currency Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `capex_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Additional Comments');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `conditions_of_approval` SET TAGS ('dbx_business_glossary_term' = 'Conditions of Approval');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `environmental_impact_assessment` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Assessment Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `environmental_impact_assessment` SET TAGS ('dbx_value_regex' = 'completed|pending|not_required');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `estimated_capex` SET TAGS ('dbx_business_glossary_term' = 'Estimated Capital Expenditure (CAPEX)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Funding Source');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'private|state|federal|bond');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Public Hearing Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `is_federal_funded` SET TAGS ('dbx_business_glossary_term' = 'Federal Funding Indicator');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `is_major_project` SET TAGS ('dbx_business_glossary_term' = 'Major Project Indicator');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `issuance_date` SET TAGS ('dbx_business_glossary_term' = 'Certificate Issuance Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `project_completion_estimated` SET TAGS ('dbx_business_glossary_term' = 'Estimated Project Completion Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `project_description` SET TAGS ('dbx_business_glossary_term' = 'Project Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `project_name` SET TAGS ('dbx_business_glossary_term' = 'Project Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `project_start_estimated` SET TAGS ('dbx_business_glossary_term' = 'Estimated Project Start Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `project_type` SET TAGS ('dbx_business_glossary_term' = 'Project Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `project_type` SET TAGS ('dbx_value_regex' = 'generation|transmission|substation|gas_pipeline|distribution_extension');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `public_hearing_outcome` SET TAGS ('dbx_business_glossary_term' = 'Public Hearing Outcome');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `public_hearing_outcome` SET TAGS ('dbx_value_regex' = 'favorable|unfavorable|neutral');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`cpcn_application` ALTER COLUMN `service_territory` SET TAGS ('dbx_business_glossary_term' = 'Service Territory');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `rab_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Rab Asset Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `regulatory_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `depreciation_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Schedule Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Rate Case Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `amortization_end_date` SET TAGS ('dbx_business_glossary_term' = 'Amortization End Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `amortization_method` SET TAGS ('dbx_business_glossary_term' = 'Amortization Method');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `amortization_method` SET TAGS ('dbx_value_regex' = 'straight_line|units_of_production|sum_of_years');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `amortization_period_years` SET TAGS ('dbx_business_glossary_term' = 'Amortization Period (Years)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `amortization_start_date` SET TAGS ('dbx_business_glossary_term' = 'Amortization Start Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `annual_amortization_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Amortization Amount');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `asset_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `asset_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `authorized_recovery_amount` SET TAGS ('dbx_business_glossary_term' = 'Authorized Recovery Amount');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `compliance_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Reference');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `is_deferred` SET TAGS ('dbx_business_glossary_term' = 'Deferred Asset Indicator');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `is_liability` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Liability Indicator');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `rab_asset_description` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `rab_asset_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `rab_asset_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Asset Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `rab_asset_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|pending|written_off');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|EPA|PHMSA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `regulatory_order_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Order Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `regulatory_order_type` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Order Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Unamortized Balance');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rab_asset` ALTER COLUMN `total_original_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Original Asset Amount');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `ot_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ot Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Method');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_value_regex' = 'allocated|purchased|auctioned');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `allowance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Allowance Quantity (tons)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Allowance Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'allocation|purchase|auction');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `allowance_units` SET TAGS ('dbx_business_glossary_term' = 'Allowance Units');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `allowance_units` SET TAGS ('dbx_value_regex' = 'tons');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `emission_limit` SET TAGS ('dbx_business_glossary_term' = 'Emission Limit (tons)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `emission_source` SET TAGS ('dbx_business_glossary_term' = 'Emission Source');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `emission_unit` SET TAGS ('dbx_business_glossary_term' = 'Emission Unit');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `emission_unit` SET TAGS ('dbx_value_regex' = 'tons|kg');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `holding_status` SET TAGS ('dbx_business_glossary_term' = 'Holding Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `holding_status` SET TAGS ('dbx_value_regex' = 'active|surrendered|banked|transferred');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|continuous');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `next_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `permit_category` SET TAGS ('dbx_business_glossary_term' = 'Permit Category');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `permit_description` SET TAGS ('dbx_business_glossary_term' = 'Permit Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|revoked|expired');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'air_quality|water_discharge|hazardous_waste|pipeline_safety|stormwater');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `regulatory_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reference');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_business_glossary_term' = 'Renewal Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `renewal_status` SET TAGS ('dbx_value_regex' = 'pending|renewed|not_required|expired');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `serial_number_range` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Range');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `transfer_history` SET TAGS ('dbx_business_glossary_term' = 'Transfer History');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^d{5}$');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`environmental_permit` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `emission_allowance_id` SET TAGS ('dbx_business_glossary_term' = 'Emission Allowance ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost (Currency)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Method');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `acquisition_method` SET TAGS ('dbx_value_regex' = 'allocated|purchased|auctioned|traded');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `allowance_number` SET TAGS ('dbx_business_glossary_term' = 'Emission Allowance Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_business_glossary_term' = 'Allowance Type (SO2, NOx, CO2, CH4, PM2.5)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `allowance_type` SET TAGS ('dbx_value_regex' = 'SO2|NOx|CO2|CH4|PM2.5');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `banked_quantity` SET TAGS ('dbx_business_glossary_term' = 'Banked Quantity (Tons)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `emission_allowance_status` SET TAGS ('dbx_business_glossary_term' = 'Allowance Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `emission_allowance_status` SET TAGS ('dbx_value_regex' = 'active|surrendered|banked|transferred|expired');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Allowance Notes');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `quantity_tons` SET TAGS ('dbx_business_glossary_term' = 'Allowance Quantity (Tons)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `regulatory_docket_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Docket Reference');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `remaining_quantity` SET TAGS ('dbx_business_glossary_term' = 'Remaining Quantity (Tons)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `source_agency` SET TAGS ('dbx_business_glossary_term' = 'Source Agency');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `source_agency` SET TAGS ('dbx_value_regex' = 'EPA|State');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `surrendered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Surrendered Quantity (Tons)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Transaction Reference');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `transferred_quantity` SET TAGS ('dbx_business_glossary_term' = 'Transferred Quantity (Tons)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`emission_allowance` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `rec_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Rec Inventory Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier (User ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Facility Identifier (Facility ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `ot_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ot Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Source Meter Identifier (Meter ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `acp_amount` SET TAGS ('dbx_business_glossary_term' = 'Alternative Compliance Payment Amount (ACP Amount)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'REC Acquisition Date (Acquisition Date)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `alternative_compliance_payment_rate` SET TAGS ('dbx_business_glossary_term' = 'Alternative Compliance Payment Rate (ACP Rate)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `certification_program` SET TAGS ('dbx_business_glossary_term' = 'Certification Program (Certification Program)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `certification_program` SET TAGS ('dbx_value_regex' = 'REC|GREC|SREC|EIA-RE|Other');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `compliance_category` SET TAGS ('dbx_business_glossary_term' = 'Compliance Category (Compliance Category)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `compliance_category` SET TAGS ('dbx_value_regex' = 'Tier1|Tier2|SolarCarveOut');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `compliance_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Filing Date (Filing Date)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `compliance_gap_mwh` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gap (Gap MWh)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (Compliance Status)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year (Compliance Year)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created Timestamp)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `current_owner` SET TAGS ('dbx_business_glossary_term' = 'Current Owner (Current Owner)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status (Eligibility Status)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'REC Expiration Date (Expiration Date)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `generation_source` SET TAGS ('dbx_business_glossary_term' = 'Generation Source (Generation Source)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `generation_source` SET TAGS ('dbx_value_regex' = 'solar|wind|hydro|biomass|geothermal|other');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `is_duplicate` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Flag (Is Duplicate)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `is_transferable` SET TAGS ('dbx_business_glossary_term' = 'Transferable Flag (Is Transferable)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction (Jurisdiction)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `market_value_usd` SET TAGS ('dbx_business_glossary_term' = 'REC Market Value (Market Value USD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Record Notes (Notes)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `original_owner` SET TAGS ('dbx_business_glossary_term' = 'Original Owner (Original Owner)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `quantity_mwh` SET TAGS ('dbx_business_glossary_term' = 'REC Quantity (Quantity MWh)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `rec_category_code` SET TAGS ('dbx_business_glossary_term' = 'REC Category Code (Category Code)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `rec_inventory_status` SET TAGS ('dbx_business_glossary_term' = 'REC Status (REC Status)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `rec_inventory_status` SET TAGS ('dbx_value_regex' = 'active|retired|transferred|cancelled');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `rec_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate Serial Number (REC Serial Number)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `rec_type` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate Type (REC Type)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `rec_type` SET TAGS ('dbx_value_regex' = 'REC|SREC|GREC');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `recs_retired_to_date` SET TAGS ('dbx_business_glossary_term' = 'RECs Retired To Date (Retired REC MWh)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `registry_platform` SET TAGS ('dbx_business_glossary_term' = 'REC Registry Platform (Registry Platform)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `registry_platform` SET TAGS ('dbx_value_regex' = 'WREGIS|NEPOOL_GIS|PJM_EIS|ISO-NE|M-RETS');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `required_rec_quantity` SET TAGS ('dbx_business_glossary_term' = 'Required REC Quantity (Required REC MWh)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `retirement_date` SET TAGS ('dbx_business_glossary_term' = 'REC Retirement Date (Retirement Date)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `rps_obligation_mwh` SET TAGS ('dbx_business_glossary_term' = 'RPS Obligation (Obligation MWh)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `rps_requirement_percentage` SET TAGS ('dbx_business_glossary_term' = 'RPS Requirement Percentage (Requirement %)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `source_meter_reading_mwh` SET TAGS ('dbx_business_glossary_term' = 'Source Meter Reading (Meter Reading MWh)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'REC Transfer Date (Transfer Date)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Updated Timestamp)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rec_inventory` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Vintage Year (Vintage Year)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `rps_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'RPS Obligation Identifier (RPS_OBL_ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `asset_permit_compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Identifier (DOC_ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Identifier (DOC_ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Identifier (FILING_ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `ot_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ot Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rps Obligation Regulatory Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `acp_amount_paid` SET TAGS ('dbx_business_glossary_term' = 'Alternative Compliance Payment Amount Paid (ACP Amount) (ACP_AMT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `alternative_compliance_payment_rate` SET TAGS ('dbx_business_glossary_term' = 'Alternative Compliance Payment Rate (ACP Rate) (ACP_RATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `compliance_gap_mwh` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gap (MWh) (COMPLIANCE_GAP)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `compliance_gap_type` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gap Type (GAP_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `compliance_gap_type` SET TAGS ('dbx_value_regex' = 'surplus|deficit');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|partial|exempt|pending');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year (CY)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State (US State Code)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LAST_REVIEW_DT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_business_glossary_term' = 'Obligation Type (OBL_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `obligation_type` SET TAGS ('dbx_value_regex' = 'state|federal|regional');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `recs_retired_mwh` SET TAGS ('dbx_business_glossary_term' = 'Retired Renewable Energy Certificates (MWh) (REC_RET)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `recs_retired_percentage` SET TAGS ('dbx_business_glossary_term' = 'Retired REC Percentage of Requirement (REC_RET_PCT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `recs_retired_source` SET TAGS ('dbx_business_glossary_term' = 'Source of Retired RECs (REC_SOURCE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `recs_retired_source` SET TAGS ('dbx_value_regex' = 'internal|external|market');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (REG_BODY)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|EPA|PHMSA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `required_recs_mwh` SET TAGS ('dbx_business_glossary_term' = 'Required Renewable Energy Certificates (MWh) (REC_REQ)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `rps_requirement_percent` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard Requirement Percentage (RPS%)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `total_retail_sales_mwh` SET TAGS ('dbx_business_glossary_term' = 'Total Retail Sales (MWh)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rps_obligation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` SET TAGS ('dbx_subdomain' = 'stakeholder_communication');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `correspondence_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff ID (STAFF_ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID (CRT_USR_ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `created_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Staff ID (STAFF_ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Updated By User ID (UPD_USR_ID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `updated_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `attachment_uri` SET TAGS ('dbx_business_glossary_term' = 'Attachment URI (ATT_URI)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `body_summary` SET TAGS ('dbx_business_glossary_term' = 'Body Summary (BODY_SUM)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level (CONF_LVL)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'restricted|confidential|public');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `correspondence_category` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Category (CAT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `correspondence_category` SET TAGS ('dbx_value_regex' = 'compliance|financial|operational|legal|other');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `correspondence_status` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Status (STAT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `correspondence_status` SET TAGS ('dbx_value_regex' = 'open|closed|pending|escalated|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `correspondence_type` SET TAGS ('dbx_value_regex' = 'data_request|deficiency|comment|protest|settlement|other');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CRT_TS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `direction` SET TAGS ('dbx_business_glossary_term' = 'Direction (DIR)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Docket Number (DCKT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp (TS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Is Archived (ARCHIVED)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority (PRIO)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body (RB)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `response_date` SET TAGS ('dbx_business_glossary_term' = 'Response Date (RESP_DT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `response_due_date` SET TAGS ('dbx_business_glossary_term' = 'Response Due Date (RESP_DUE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `response_required` SET TAGS ('dbx_business_glossary_term' = 'Response Required (RESP_REQ)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `response_time_days` SET TAGS ('dbx_business_glossary_term' = 'Response Time in Days (RESP_DAYS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date (RET_END)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Correspondence Subject (SUBJ)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`correspondence` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPD_TS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` SET TAGS ('dbx_subdomain' = 'stakeholder_communication');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `rate_case_testimony_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Testimony ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `last_modified_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Rate Case ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_business_glossary_term' = 'SHA‑256 Checksum');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `checksum_sha256` SET TAGS ('dbx_value_regex' = '^[A-Fa-f0-9]{64}$');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|confidential|restricted');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `document_format` SET TAGS ('dbx_business_glossary_term' = 'Document Format');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `document_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|txt');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `document_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'Document Size (Bytes)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `document_uri` SET TAGS ('dbx_business_glossary_term' = 'Document URI');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `exhibit_numbers` SET TAGS ('dbx_business_glossary_term' = 'Exhibit Numbers');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `filing_method` SET TAGS ('dbx_business_glossary_term' = 'Filing Method');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `filing_method` SET TAGS ('dbx_value_regex' = 'electronic|paper|fax');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `is_archived` SET TAGS ('dbx_business_glossary_term' = 'Is Archived Flag');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `is_exhibit` SET TAGS ('dbx_business_glossary_term' = 'Is Exhibit Flag');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `language` SET TAGS ('dbx_business_glossary_term' = 'Testimony Language');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|other');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `rate_case_testimony_status` SET TAGS ('dbx_business_glossary_term' = 'Testimony Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `rate_case_testimony_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `related_docket_number` SET TAGS ('dbx_business_glossary_term' = 'Related Docket Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `retention_end_date` SET TAGS ('dbx_business_glossary_term' = 'Retention End Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `subject_area` SET TAGS ('dbx_business_glossary_term' = 'Testimony Subject Area');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `subject_area` SET TAGS ('dbx_value_regex' = 'revenue_requirement|cost_of_capital|depreciation|rate_design|other');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `testimony_text` SET TAGS ('dbx_business_glossary_term' = 'Testimony Text');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `testimony_type` SET TAGS ('dbx_business_glossary_term' = 'Testimony Type (Direct, Rebuttal, Surrebuttal)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `testimony_type` SET TAGS ('dbx_value_regex' = 'direct|rebuttal|surrebuttal');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `witness_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Witness Affiliation');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `witness_name` SET TAGS ('dbx_business_glossary_term' = 'Witness Full Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `witness_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`rate_case_testimony` ALTER COLUMN `witness_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` SET TAGS ('dbx_subdomain' = 'stakeholder_communication');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `acronym` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Acronym (RAA)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `acronym` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,10}$');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR1)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR2)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `applicable_states` SET TAGS ('dbx_business_glossary_term' = 'Applicable States (AS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `body_description` SET TAGS ('dbx_business_glossary_term' = 'Description (DESC)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `body_name` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency Name (RA)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `body_status` SET TAGS ('dbx_business_glossary_term' = 'Status (STAT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `body_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline (CDL)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `contact_department` SET TAGS ('dbx_business_glossary_term' = 'Contact Department (CD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `contact_title` SET TAGS ('dbx_business_glossary_term' = 'Contact Title (CT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (CC)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `country_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `data_retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Data Retention Policy (DRP)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (ED)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `email_verified` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Verified (EMAIL_VERIFIED)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `email_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `email_verified` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID (ERID)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `filing_portal_url` SET TAGS ('dbx_business_glossary_term' = 'Filing Portal URL (FPU)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `is_federal` SET TAGS ('dbx_business_glossary_term' = 'Is Federal Jurisdiction (IS_FED)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `is_regional` SET TAGS ('dbx_business_glossary_term' = 'Is Regional Jurisdiction (IS_REG)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `is_state` SET TAGS ('dbx_business_glossary_term' = 'Is State Jurisdiction (IS_STATE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Type (JT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `jurisdiction_type` SET TAGS ('dbx_value_regex' = 'federal|state|regional');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LRD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `phone_verified` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Verified (PHONE_VERIFIED)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `phone_verified` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `phone_verified` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email (PCE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name (PCN)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone (PCP)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9-s]{7,15}$');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `regulatory_scope` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Scope (RS)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `regulatory_scope` SET TAGS ('dbx_value_regex' = 'electric|gas|environmental|safety|financial|multiple');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `review_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Review Cycle (Months) (RCM)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province (ST)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`body` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL (URL)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `ot_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Ot Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `finance_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `responsible_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `responsible_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `responsible_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `corrective_action_summary` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Summary');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `docket_reference` SET TAGS ('dbx_business_glossary_term' = 'Docket Reference');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `effectiveness_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Method');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `evidence_document_uri` SET TAGS ('dbx_business_glossary_term' = 'Evidence Document URI');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Violation Flag');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `lessons_learned` SET TAGS ('dbx_business_glossary_term' = 'Lessons Learned');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `mitigation_plan_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Approval Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `mitigation_plan_title` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Title');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `notice_number` SET TAGS ('dbx_business_glossary_term' = 'Notice Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `penalty_assessed_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Assessed Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `penalty_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Paid Amount');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `penalty_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Penalty Paid Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `plan_closure_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Closure Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|EPA|PHMSA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `root_cause_analysis` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Analysis');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `severity_classification` SET TAGS ('dbx_business_glossary_term' = 'Severity Classification');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `severity_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `standard_violated` SET TAGS ('dbx_business_glossary_term' = 'Standard Violated');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `violation_date` SET TAGS ('dbx_business_glossary_term' = 'Violation Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `violation_notice_status` SET TAGS ('dbx_business_glossary_term' = 'Notice Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `violation_notice_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|rejected');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `violation_type` SET TAGS ('dbx_business_glossary_term' = 'Violation Type (NOV/NAV/Enforcement)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`violation_notice` ALTER COLUMN `violation_type` SET TAGS ('dbx_value_regex' = 'nov|nav|enforcement');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `mitigation_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `responsible_owner_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Comments');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `corrective_actions` SET TAGS ('dbx_business_glossary_term' = 'Corrective Actions List');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP|JPY');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `evidence_required` SET TAGS ('dbx_business_glossary_term' = 'Evidence Required');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `evidence_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submission Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `evidence_submitted` SET TAGS ('dbx_business_glossary_term' = 'Evidence Submitted');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `financial_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'Financial Impact Estimate (USD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `mitigation_plan_description` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `mitigation_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `mitigation_plan_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|in_progress|completed|closed');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `next_audit_due` SET TAGS ('dbx_business_glossary_term' = 'Next Audit Due Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `plan_number` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'corrective|preventive|remedial');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `plan_version` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Version');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Priority');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|EPA|PHMSA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `responsible_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Owner Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `root_cause` SET TAGS ('dbx_business_glossary_term' = 'Root Cause Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `target_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Target Completion Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Mitigation Plan Title');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Verification Method');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`mitigation_plan` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` SET TAGS ('dbx_subdomain' = 'regulatory_filings');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `ferc_form_id` SET TAGS ('dbx_business_glossary_term' = 'FERC Form Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Entity Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `finance_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Case Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Docket Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `file_url` SET TAGS ('dbx_business_glossary_term' = 'File URL');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `filing_category` SET TAGS ('dbx_business_glossary_term' = 'Filing Category');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `filing_category` SET TAGS ('dbx_value_regex' = 'annual|quarterly|special|amendment');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `filing_priority` SET TAGS ('dbx_business_glossary_term' = 'Filing Priority');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `filing_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `filing_status` SET TAGS ('dbx_business_glossary_term' = 'Filing Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `filing_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `filing_type` SET TAGS ('dbx_business_glossary_term' = 'Filing Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `filing_type` SET TAGS ('dbx_value_regex' = 'form1|form2|form714|form2gas|form3');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `form_number` SET TAGS ('dbx_business_glossary_term' = 'Form Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `form_title` SET TAGS ('dbx_business_glossary_term' = 'Form Title');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Is Amendment Flag');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `plant_in_service_mwh` SET TAGS ('dbx_business_glossary_term' = 'Plant In‑Service (MWh)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|EPA');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `reporting_year` SET TAGS ('dbx_business_glossary_term' = 'Reporting Year');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Submission Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `total_pages` SET TAGS ('dbx_business_glossary_term' = 'Total Pages');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`ferc_form` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` SET TAGS ('dbx_subdomain' = 'regulatory_filings');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `eia_report_id` SET TAGS ('dbx_business_glossary_term' = 'EIA Report Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Related Compliance Obligation Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `finance_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project Identifier');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Installed Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `customers_served` SET TAGS ('dbx_business_glossary_term' = 'Customers Served');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Flag');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `data_quality_flag` SET TAGS ('dbx_value_regex' = 'good|questionable|bad');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `data_quality_notes` SET TAGS ('dbx_business_glossary_term' = 'Data Quality Notes');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `eia_form_version` SET TAGS ('dbx_business_glossary_term' = 'EIA Form Version');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `eia_report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `eia_report_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `file_url` SET TAGS ('dbx_business_glossary_term' = 'Report File URL');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `form_number` SET TAGS ('dbx_business_glossary_term' = 'Form Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `fuel_consumption_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Fuel Consumption (MMBtu)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Primary Fuel Type');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Electricity Generation (MWh)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `is_amendment` SET TAGS ('dbx_business_glossary_term' = 'Is Amendment Flag');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State Code');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `net_generation_mwh` SET TAGS ('dbx_business_glossary_term' = 'Net Generation (MWh)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|EPA|DOE');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `report_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Report Approval Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `report_author` SET TAGS ('dbx_business_glossary_term' = 'Report Author');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `report_category` SET TAGS ('dbx_business_glossary_term' = 'Report Category');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `report_category` SET TAGS ('dbx_value_regex' = 'generation|consumption|fuel|capacity|sales');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `report_period_quarter` SET TAGS ('dbx_business_glossary_term' = 'Report Period Quarter');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `report_period_quarter` SET TAGS ('dbx_value_regex' = 'Q1|Q2|Q3|Q4');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `report_period_year` SET TAGS ('dbx_business_glossary_term' = 'Report Period Year');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `report_title` SET TAGS ('dbx_business_glossary_term' = 'Report Title');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `report_type` SET TAGS ('dbx_business_glossary_term' = 'Report Type (Form)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `report_type` SET TAGS ('dbx_value_regex' = 'EIA-860|EIA-861|EIA-923');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `reporting_period_end` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period End Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `reporting_period_start` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `reviewer_name` SET TAGS ('dbx_business_glossary_term' = 'Reviewer Name');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_business_glossary_term' = 'Submission Method');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `submission_method` SET TAGS ('dbx_value_regex' = 'electronic|paper');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `total_sales_usd` SET TAGS ('dbx_business_glossary_term' = 'Total Sales (USD)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'MW|MWh|MMBtu|USD');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`eia_report` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` SET TAGS ('dbx_subdomain' = 'compliance_management');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `regulatory_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Audit ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Created By Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `internal_order_id` SET TAGS ('dbx_business_glossary_term' = 'Internal Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Related Docket ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Related Filing ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Related Rate Case ID');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `audit_category` SET TAGS ('dbx_business_glossary_term' = 'Audit Category');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `audit_category` SET TAGS ('dbx_value_regex' = 'Financial|Operational|Safety|Compliance|Environmental');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `audit_scope` SET TAGS ('dbx_business_glossary_term' = 'Audit Scope');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'Planned|In Progress|Completed|Closed|Cancelled');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'NERC|FERC|PUC|EPA|State|Internal');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `compliance_gap_summary` SET TAGS ('dbx_business_glossary_term' = 'Compliance Gap Summary');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'Compliant|Non-Compliant|Partial|Pending');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `conducting_body` SET TAGS ('dbx_business_glossary_term' = 'Conducting Body');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `conducting_body` SET TAGS ('dbx_value_regex' = 'NERC|FERC|PUC|EPA|State Agency|Internal Audit Team');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Document URL');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `evidence_count` SET TAGS ('dbx_business_glossary_term' = 'Evidence Count');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `final_report_date` SET TAGS ('dbx_business_glossary_term' = 'Final Report Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `fines_currency` SET TAGS ('dbx_business_glossary_term' = 'Fines Currency');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `fines_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `fines_paid_amount` SET TAGS ('dbx_business_glossary_term' = 'Fines Paid Amount');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `fines_paid_date` SET TAGS ('dbx_business_glossary_term' = 'Fines Paid Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `fines_total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Fines Amount');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `followup_actions_count` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Actions Count');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `followup_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Due Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `is_external` SET TAGS ('dbx_business_glossary_term' = 'Is External Audit');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Audit Latitude');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Audit Longitude');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `number_of_findings` SET TAGS ('dbx_business_glossary_term' = 'Number of Findings');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `number_of_violations` SET TAGS ('dbx_business_glossary_term' = 'Number of Violations');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `on_site_end_date` SET TAGS ('dbx_business_glossary_term' = 'On‑Site End Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `on_site_start_date` SET TAGS ('dbx_business_glossary_term' = 'On‑Site Start Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Outcome Description');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_business_glossary_term' = 'Overall Audit Outcome');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `overall_outcome` SET TAGS ('dbx_value_regex' = 'Pass|Fail|Conditional|Pending');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Audit Period End Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Audit Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `preliminary_findings_date` SET TAGS ('dbx_business_glossary_term' = 'Preliminary Findings Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Audit Priority');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'High|Medium|Low');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Review Date');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Audit Reviewed By');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Audit Risk Rating');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'Critical|High|Medium|Low|Negligible');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Audit Risk Score');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Audit Status Reason');
ALTER TABLE `power_and_utilities_v2`.`regulatory`.`regulatory_audit` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Audit Updated By');
