-- Schema for Domain: engagement | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`engagement` COMMENT 'Manages commercial and key account customer engagement, demand-side management (DSM) program participation, and Salesforce-driven CRM interactions for C&I customers. Owns opportunity tracking, energy audit records, DR enrollment agreements, and customer satisfaction data. Supports load management programs, VPP participation agreements, and large customer contract negotiations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`ci_account` (
    `ci_account_id` BIGINT COMMENT 'System-generated unique identifier for the C&I account record.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Regulatory load reporting requires associating each customer account with its balancing area to aggregate demand for market settlements.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to trading.counterparty. Business justification: Customer account credit and settlement processes require linking the account to its trading counterparty record.',
    `nem_account_id` BIGINT COMMENT 'Foreign key linking to der.nem_account. Business justification: Required for Net Energy Metering reporting: links each customer account to its NEM account for billing, compliance, and regulatory filings.',
    `key_account_manager_id` BIGINT COMMENT 'Identifier of the internal manager responsible for the account.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Required for Program Enrollment Tracking report; utility must know which customers are enrolled in each demand‑response or EE program for compliance and incentive payout.',
    `account_name` STRING COMMENT 'Legal name of the commercial or industrial customer organization.',
    `account_number` STRING COMMENT 'External account identifier used in billing and CRM systems.',
    `account_status` STRING COMMENT 'Current lifecycle status of the account.. Valid values are `active|inactive|suspended|closed|pending|prospect`',
    `account_type` STRING COMMENT 'Segment classification of the account, e.g., commercial, industrial, key account.',
    `address_line1` STRING COMMENT 'First line of the mailing address for the account.',
    `address_line2` STRING COMMENT 'Second line of the mailing address for the account (optional).',
    `annual_energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electricity consumption for the most recent 12‑month period, measured in megawatt‑hours.',
    `annual_gas_consumption_mcf` DECIMAL(18,2) COMMENT 'Total natural gas consumption for the most recent 12‑month period, measured in thousand cubic feet.',
    `billing_cycle` STRING COMMENT 'Frequency at which the account is billed.. Valid values are `monthly|quarterly|annual`',
    `city` STRING COMMENT 'City component of the accounts mailing address.',
    `contact_email` STRING COMMENT 'Primary email address for the accounts point of contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary telephone number for the accounts point of contact.',
    `contract_end_date` DATE COMMENT 'Date when the contract expires or is scheduled to be renewed.',
    `contract_number` STRING COMMENT 'Unique identifier for the primary service contract associated with the account.',
    `contract_start_date` DATE COMMENT 'Date when the contract terms become effective.',
    `contract_type` STRING COMMENT 'Classification of the contract pricing structure.. Valid values are `fixed|variable|index|hybrid|spot|custom`',
    `country` STRING COMMENT 'Three‑letter ISO country code for the accounts location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the account record was first created in the system.',
    `credit_rating` STRING COMMENT 'External credit rating assigned to the account (e.g., AAA, AA, A, BBB, etc.).',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code used for billing this account.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `dr_enrollment_flag` BOOLEAN COMMENT 'Indicates whether the account is enrolled in a demand‑response program.',
    `effective_end_date` DATE COMMENT 'Date when the account or contract is scheduled to terminate (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the account became active or the contract took effect.',
    `external_system_code` STRING COMMENT 'Identifier of the account in the originating CRM or ERP system.',
    `industry_code` STRING COMMENT 'Standard industry code describing the customers primary business activity.',
    `industry_description` STRING COMMENT 'Human‑readable description of the industry associated with the SIC/NAICS code.',
    `key_account_tier` STRING COMMENT 'Strategic tier assigned to the account for relationship management.. Valid values are `tier1|tier2|tier3|tier4|tier5|tier6`',
    `last_activity_date` DATE COMMENT 'Date of the most recent significant interaction or transaction with the account.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or observations about the account.',
    `payment_terms` STRING COMMENT 'Standard payment terms (e.g., Net 30, Net 45).',
    `peak_demand_kw` DECIMAL(18,2) COMMENT 'Maximum recorded electrical demand for the account in a billing period, expressed in kilowatts.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the accounts mailing address.',
    `preferred_contact_method` STRING COMMENT 'Customers preferred channel for communications.. Valid values are `email|phone|mail|portal|fax|sms`',
    `regulatory_classification` STRING COMMENT 'Regulatory category assigned to the account (e.g., residential‑like, large‑industrial).',
    `risk_score` STRING COMMENT 'Numerical risk rating derived from credit, usage volatility, and compliance history.',
    `state` STRING COMMENT 'State or province component of the accounts mailing address.',
    `status_reason` STRING COMMENT 'Free‑text explanation for the current account status.',
    `strategic_account_flag` BOOLEAN COMMENT 'Indicates whether the account is designated as a strategic priority.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the account is exempt from sales tax.',
    `termination_date` DATE COMMENT 'Actual date the account was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the account record.',
    `vpp_participation_flag` BOOLEAN COMMENT 'Indicates participation in a Virtual Power Plant aggregation.',
    CONSTRAINT pk_ci_account PRIMARY KEY(`ci_account_id`)
) COMMENT 'Master record for commercial and industrial (C&I) customer accounts managed through the utilitys commercial engagement program. Represents the primary business entity for large commercial, industrial, and key account customers. Captures account classification (C&I segment, key account tier, strategic account flag), assigned key account manager, SIC/NAICS industry code, peak demand (kW), annual energy consumption (MWh/MCF), credit rating, preferred contact method, account status, and external system account identifier. Serves as the SSOT for C&I account identity within the engagement domain, complementing the customer domains residential/general customer master.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` (
    `key_account_manager_id` BIGINT COMMENT 'System-generated unique identifier for the key account manager record.',
    `crew_member_id` BIGINT COMMENT 'Internal employee reference linking the manager to the workforce domain.',
    `employee_id` BIGINT COMMENT 'Internal employee reference linking the manager to the workforce domain.',
    `system_user_employee_id` BIGINT COMMENT 'Unique username or identifier for the manager in the CRM system.',
    `annual_salary_usd` DECIMAL(18,2) COMMENT 'Base annual salary for the manager, expressed in US dollars.',
    `bonus_eligible` BOOLEAN COMMENT 'Indicates if the manager is eligible for performance bonuses.',
    `certification_level` STRING COMMENT 'Professional certification tier held by the manager.. Valid values are `none|level1|level2|level3|expert`',
    `compliance_training_date` DATE COMMENT 'Date the manager completed mandatory compliance training.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the manager record was first created in the lakehouse.',
    `current_account_count` STRING COMMENT 'Number of active key accounts currently assigned to the manager.',
    `email_address` STRING COMMENT 'Primary business email address for the manager.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `employee_status` STRING COMMENT 'Employment type classification for the manager.. Valid values are `full_time|part_time|contractor|temp`',
    `external_certifications` STRING COMMENT 'List of industry certifications held by the manager outside the utility.',
    `first_name` STRING COMMENT 'Given name of the key account manager.',
    `hire_date` DATE COMMENT 'Date the manager was hired by the utility.',
    `is_remote` BOOLEAN COMMENT 'Indicates whether the manager primarily works remotely.',
    `key_account_manager_status` STRING COMMENT 'Current employment status of the manager within the engagement domain.. Valid values are `active|inactive|on_leave|terminated`',
    `last_name` STRING COMMENT 'Family name of the key account manager.',
    `last_performance_review_date` DATE COMMENT 'Date of the most recent performance review.',
    `last_performance_score` STRING COMMENT 'Numeric score (1‑5) from the latest performance review.',
    `manager_level` STRING COMMENT 'Organizational level of the manager within the engagement hierarchy.. Valid values are `associate|senior|lead|director|vp`',
    `max_account_capacity` STRING COMMENT 'Maximum number of key accounts the manager may be assigned.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the manager.',
    `office_location` STRING COMMENT 'Physical office address where the manager is based.',
    `performance_tier` STRING COMMENT 'Tier classification based on performance metrics and KPI achievement.. Valid values are `bronze|silver|gold|platinum`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the manager.. Valid values are `^+?[0-9]{7,15}$`',
    `portfolio_value_usd` DECIMAL(18,2) COMMENT 'Total annual revenue potential of the managers assigned accounts, expressed in US dollars.',
    `primary_language` STRING COMMENT 'Preferred language for communication with the manager.. Valid values are `en|es|fr|de|zh`',
    `region` STRING COMMENT 'Broad geographic region covering the managers territory.. Valid values are `north_america|europe|asia`',
    `specialization` STRING COMMENT 'Primary energy product focus of the manager.. Valid values are `electric|gas|industrial|municipal|renewable|mixed`',
    `termination_date` DATE COMMENT 'Date the managers employment ended, if applicable.',
    `territory_code` STRING COMMENT 'Geographic sales territory assigned to the manager.. Valid values are `NORTH|SOUTH|EAST|WEST|MIDWEST|WEST_COAST`',
    `training_completed` BOOLEAN COMMENT 'Indicates whether required compliance training has been completed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the manager record.',
    `work_phone` STRING COMMENT 'Office telephone number for the manager.. Valid values are `^+?[0-9]{7,15}$`',
    CONSTRAINT pk_key_account_manager PRIMARY KEY(`key_account_manager_id`)
) COMMENT 'Master record for utility Key Account Managers (KAMs) and commercial account representatives assigned to manage C&I customer relationships. Captures employee reference (linked to workforce domain), territory assignment, assigned account portfolio size, specialization (electric, gas, industrial, municipal), certification level, system user identifier, active status, performance tier, and maximum account capacity. Serves as the SSOT for KAM identity and portfolio assignments within the engagement domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`opportunity` (
    `opportunity_id` BIGINT COMMENT 'System-generated unique identifier for the sales opportunity record.',
    `assigned_kam_key_account_manager_id` BIGINT COMMENT 'Identifier of the internal account manager responsible for the opportunity.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: OPPORTUNITY execution often assigns a specific crew; linking enables crew utilization dashboards and labor costing.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer associated with the opportunity.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer associated with the opportunity.',
    `interconnection_request_id` BIGINT COMMENT 'Foreign key linking to der.interconnection_request. Business justification: Sales opportunity for DER installation must reference the filed interconnection request; used in opportunity pipeline reports and permitting status tracking.',
    `key_account_manager_id` BIGINT COMMENT 'Identifier of the internal account manager responsible for the opportunity.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Opportunity records often represent a proposed sale of a utility program; sales pipeline reports require linking the opportunity to the target program.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: OPPORTUNITY IMPLEMENTATION plan designates a lead technician to oversee field work; required for project scheduling and cost estimation.',
    `closed_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity was moved to a closed state (won or lost).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the opportunity record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values (e.g., USD).',
    `estimated_annual_revenue_usd` DECIMAL(18,2) COMMENT 'Projected annual revenue impact if the opportunity is won, expressed in U.S. dollars.',
    `estimated_demand_reduction_kw` DECIMAL(18,2) COMMENT 'Projected reduction in peak demand (kilowatts) attributable to the opportunity.',
    `estimated_energy_savings_kwh_per_year` DECIMAL(18,2) COMMENT 'Projected annual energy savings (kilowatt‑hours) from the opportunity.',
    `estimated_load_impact_kw` DECIMAL(18,2) COMMENT 'Projected additional electrical load (kilowatts) associated with the opportunity.',
    `estimated_savings_usd_per_year` DECIMAL(18,2) COMMENT 'Projected annual cost savings for the customer resulting from the proposed solution.',
    `expected_close_date` DATE COMMENT 'Target date by which the opportunity is expected to be closed.',
    `external_system_code` STRING COMMENT 'Identifier of the opportunity in an external system (e.g., partner CRM).',
    `opportunity_name` STRING COMMENT 'Descriptive name of the opportunity, typically reflecting the customer need or project.',
    `opportunity_number` STRING COMMENT 'External business identifier used by sales teams and external systems to reference the opportunity.',
    `opportunity_type` STRING COMMENT 'Category of the opportunity indicating the business initiative or program being pursued.. Valid values are `new_service|rate_change|dr_enrollment|der_program|vpp_participation|energy_efficiency`',
    `probability_of_close_pct` DECIMAL(18,2) COMMENT 'Sales team estimated likelihood (percentage) that the opportunity will be closed successfully.',
    `proposal_expiration_date` DATE COMMENT 'Date after which the proposal is no longer valid.',
    `proposal_status` STRING COMMENT 'Current status of the proposal document.. Valid values are `draft|submitted|under_review|accepted|rejected|expired`',
    `proposal_type` STRING COMMENT 'Classification of the proposal document (e.g., technical, financial, hybrid).',
    `proposal_version` STRING COMMENT 'Version identifier for the proposal, allowing tracking of revisions.',
    `proposed_incentive_amount_usd` DECIMAL(18,2) COMMENT 'Monetary incentive offered to the customer as part of the proposal.',
    `proposed_solution_description` STRING COMMENT 'Narrative description of the solution being offered to the customer.',
    `source` STRING COMMENT 'Origin of the opportunity (e.g., referral, marketing campaign, inbound inquiry).',
    `stage` STRING COMMENT 'Current lifecycle stage of the opportunity within the sales pipeline.. Valid values are `prospecting|qualification|proposal|negotiation|closed_won|closed_lost`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the opportunity record.',
    CONSTRAINT pk_opportunity PRIMARY KEY(`opportunity_id`)
) COMMENT 'Commercial opportunity record tracking sales and program enrollment opportunities for C&I customers through the full pipeline lifecycle from prospecting through close. Captures opportunity name, type (new service, rate change, DR enrollment, DER program, VPP participation, energy efficiency upgrade, NEM application, TOU migration), stage (prospecting, qualification, proposal, negotiation, closed-won, closed-lost), estimated annual revenue impact, estimated load impact (kW/kWh), probability of close, expected close date, opportunity source, assigned KAM, and external system opportunity identifier. Includes proposal-stage attributes: proposal type, version, proposed solution description, estimated savings ($/year), estimated demand reduction (kW), estimated energy savings (kWh/year), proposed incentive amount ($), proposal status (draft, submitted, under review, accepted, rejected, expired), and expiration date. Core entity for commercial pipeline management, load management program recruitment, KAM performance tracking, and contract negotiation workflow.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` (
    `energy_audit_id` BIGINT COMMENT 'Unique identifier for the energy audit record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer associated with the audit.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer associated with the audit.',
    `dsm_program_id` BIGINT COMMENT 'FK to engagement.dsm_program',
    `facility_id` BIGINT COMMENT 'Identifier of the facility (asset) audited.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Energy audits are performed to verify savings for a specific program; audit results must be tied to that program for compliance and reporting.',
    `resource_id` BIGINT COMMENT 'Foreign key linking to der.der_resource. Business justification: Energy audits often evaluate performance of a specific DER asset; linking enables audit reports to pull actual output and availability data.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Energy Audit Data Collection requires real‑time meter data from SCADA; auditors link each audit to the SCADA system used.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: ENERGY AUDIT PROCESS requires a qualified technician to perform the audit; linking audit to technician enables audit assignment reports.',
    `audit_date` DATE COMMENT 'Date when the audit was conducted.',
    `audit_name` STRING COMMENT 'Descriptive name for the audit, often includes customer name and date.',
    `audit_number` STRING COMMENT 'External audit reference number assigned by the audit team.',
    `audit_report_url` STRING COMMENT 'Link to the stored audit report document.',
    `audit_status` STRING COMMENT 'Current lifecycle status of the audit.. Valid values are `scheduled|in-progress|completed|report-delivered|canceled`',
    `audit_type` STRING COMMENT 'Type of audit performed, indicating depth and methodology.. Valid values are `walk-through|investment-grade|virtual|remote`',
    `audit_version` STRING COMMENT 'Version number of the audit record, incremented on revisions.',
    `auditor_name` STRING COMMENT 'Name of the auditor who performed the audit.',
    `baseline_consumption_unit` STRING COMMENT 'Unit of measurement for baseline consumption (kilowatt-hours or thousand cubic feet).. Valid values are `kWh|MCF`',
    `baseline_consumption_value` DECIMAL(18,2) COMMENT 'Annual baseline energy consumption measured during the audit (pre-improvement).',
    `baseline_consumption_year` STRING COMMENT 'Fiscal year for which the baseline consumption applies.',
    `completed_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit was completed and final report delivered.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the facility meets regulatory compliance requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the audit record was first created in the system.',
    `demand_reduction_kw` DECIMAL(18,2) COMMENT 'Estimated reduction in peak demand (kilowatts) achievable after implementing measures.',
    `estimated_co2_reduction_tons` DECIMAL(18,2) COMMENT 'Projected annual CO2 emissions reduction from implemented measures.',
    `estimated_energy_cost_savings_usd` DECIMAL(18,2) COMMENT 'Projected annual monetary savings from reduced energy consumption.',
    `estimated_implementation_cost` DECIMAL(18,2) COMMENT 'Projected cost to implement recommended measures, in USD.',
    `external_audit_reference` STRING COMMENT 'Identifier used by external audit firms or regulators.',
    `facility_address` STRING COMMENT 'Street address of the audited facility.',
    `facility_city` STRING COMMENT 'City where the audited facility is located.',
    `facility_state` STRING COMMENT 'State/Province of the audited facility.',
    `facility_zip` STRING COMMENT 'Postal code of the audited facility.',
    `identified_savings_unit` STRING COMMENT 'Unit for the identified savings (kWh or MCF).. Valid values are `kWh|MCF`',
    `identified_savings_value` DECIMAL(18,2) COMMENT 'Estimated annual energy savings potential identified by the audit.',
    `is_virtual_audit` BOOLEAN COMMENT 'Flag indicating if the audit was performed remotely/virtually.',
    `notes` STRING COMMENT 'Additional free-text notes captured by the auditor.',
    `recommended_measures` STRING COMMENT 'Text description of energy efficiency measures recommended.',
    `risk_level` STRING COMMENT 'Risk classification of the facility based on audit findings.. Valid values are `low|medium|high`',
    `simple_payback_years` DECIMAL(18,2) COMMENT 'Estimated payback period in years based on cost and savings.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the audit record.',
    CONSTRAINT pk_energy_audit PRIMARY KEY(`energy_audit_id`)
) COMMENT 'Record of energy audits conducted for C&I customers as part of demand-side management (DSM) and energy efficiency programs. Captures audit type (walk-through, investment-grade, virtual/remote), audit date, auditor name, facility address, baseline annual consumption (kWh/MCF), identified energy savings potential (kWh/MCF/year), estimated demand reduction (kW), recommended measures, estimated implementation cost, simple payback period (years), audit status (scheduled, in-progress, completed, report-delivered), and associated DSM program. Supports IRP and DSM portfolio planning.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` (
    `dsm_program_id` BIGINT COMMENT 'Unique identifier for the DSM program.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `dsm_program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|suspended|closed|draft|pending`',
    `effective_end_date` DATE COMMENT 'Date the program ends or is scheduled to terminate (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date the program becomes effective and participants may enroll.',
    `enrollment_capacity_unit` STRING COMMENT 'Unit of measure for enrollment capacity: megawatts (MW) or number of customers.. Valid values are `MW|customers`',
    `enrollment_capacity_value` DECIMAL(18,2) COMMENT 'Maximum capacity the program can accommodate, expressed in the unit defined by enrollment_capacity_unit.',
    `filing_reference` STRING COMMENT 'Reference identifier for the regulatory filing associated with the program.',
    `incentive_amount_per_mwh` DECIMAL(18,2) COMMENT 'Monetary incentive offered per MWh of load reduction or generation.',
    `incentive_structure_description` STRING COMMENT 'Narrative description of how incentives are calculated and applied.',
    `lcoe_impact` DECIMAL(18,2) COMMENT 'Estimated impact of the program on the utilitys LCOE.',
    `program_code` STRING COMMENT 'External code or identifier for the program used in regulatory filings and internal systems.',
    `program_description` STRING COMMENT 'Full narrative description of the programs purpose, eligibility, and mechanics.',
    `program_name` STRING COMMENT 'Human‑readable name of the DSM program.',
    `program_status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., reason for suspension).',
    `program_type` STRING COMMENT 'Category of the program: Energy Efficiency (EE), Demand Response (DR), Distributed Energy Resources (DER), Net Energy Metering (NEM), Time‑of‑Use (TOU), or Virtual Power Plant (VPP).. Valid values are `EE|DR|DER|NEM|TOU|VPP`',
    `puc_approved_budget_amount` DECIMAL(18,2) COMMENT 'Budget approved by the Public Utility Commission for program implementation.',
    `target_customer_segment` STRING COMMENT 'Customer segment the program is designed for.. Valid values are `residential|commercial|industrial|C&I`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the program record.',
    CONSTRAINT pk_dsm_program PRIMARY KEY(`dsm_program_id`)
) COMMENT 'Master catalog of demand-side management (DSM) programs offered by the utility including energy efficiency, demand response (DR), load management, DER incentive, NEM, TOU/CPP/RTP rate programs, and VPP participation programs. Captures program name, program code, program type (EE, DR, DER, NEM, TOU, VPP), target customer segment (residential, C&I, industrial), program status (active, suspended, closed), PUC-approved budget, incentive structure, enrollment capacity (MW or customer count), program start/end dates, FERC/PUC filing reference, and LCOE impact. Serves as the SSOT for DSM/DR program definitions within the engagement domain, complementing the product domains rate schedule catalog.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` (
    `dr_event_participation_id` BIGINT COMMENT 'System‑generated unique identifier for each participation record.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the commercial or industrial customer participating in the event.',
    `customer_customer_account_id` BIGINT COMMENT 'Unique identifier of the commercial or industrial customer participating in the event.',
    `distribution_service_point_id` BIGINT COMMENT 'Identifier of the metered service point (e.g., building or facility) where load is measured.',
    `dr_dispatch_event_id` BIGINT COMMENT 'Identifier of the DR or VPP dispatch event to which this participation belongs.',
    `enrollment_id` BIGINT COMMENT 'Reference to the customer’s enrollment record for the DR program.',
    `product_program_id` BIGINT COMMENT 'Identifier of the DR program (e.g., peak‑shave, emergency) under which the event was run.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: DR event dispatch uses SCADA to send load curtailment commands; participation records the SCADA system involved.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: DR EVENT PARTICIPATION tracking assigns a field technician responsible for load curtailment verification; needed for compliance reporting.',
    `actual_load_kw` DECIMAL(18,2) COMMENT 'Measured load (in kilowatts) during the DR event after any curtailment.',
    `baseline_load_kw` DECIMAL(18,2) COMMENT 'Estimated load (in kilowatts) the customer would have consumed during the event period without curtailment.',
    `compliance_flag` BOOLEAN COMMENT 'True if the participation meets all regulatory (NERC) reporting requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when this participation record was first created in the system.',
    `curtailment_performance_pct` DECIMAL(18,2) COMMENT 'Percentage of the promised curtailment that was achieved (curtailment / baseline * 100).',
    `customer_ack_timestamp` TIMESTAMP COMMENT 'Date‑time when the customer acknowledged receipt of the DR event notification.',
    `event_notification_timestamp` TIMESTAMP COMMENT 'Date‑time when the utility notified the customer of the upcoming DR event.',
    `incentive_earned_usd` DECIMAL(18,2) COMMENT 'Monetary incentive awarded to the customer for successful participation, expressed in U.S. dollars.',
    `measured_curtailment_kw` DECIMAL(18,2) COMMENT 'Difference between baseline load and actual load, representing the amount of load reduced.',
    `notes` STRING COMMENT 'Free‑form text for any additional remarks or explanations about the participation.',
    `participation_type` STRING COMMENT 'Indicates whether the customers involvement was voluntary or required by contract.. Valid values are `voluntary|mandatory`',
    `penalty_assessed_usd` DECIMAL(18,2) COMMENT 'Monetary penalty applied for non‑compliance or under‑performance, expressed in U.S. dollars.',
    `performance_status` STRING COMMENT 'Result of the participation audit: compliant, non‑compliant, excused, or no‑show.. Valid values are `compliant|non-compliant|excused|no-show`',
    `settlement_status` STRING COMMENT 'Current status of the financial settlement for this participation record.. Valid values are `pending|settled|rejected`',
    `settlement_timestamp` TIMESTAMP COMMENT 'Date‑time when the incentive/penalty settlement was processed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to this participation record.',
    CONSTRAINT pk_dr_event_participation PRIMARY KEY(`dr_event_participation_id`)
) COMMENT 'Transactional record capturing a C&I customers actual participation in a specific demand response (DR) or VPP dispatch event. Captures DR event reference (linked to gridops domain), enrollment ID, event notification timestamp, customer acknowledgment timestamp, baseline load (kW), actual load during event (kW), measured curtailment (kW), curtailment performance percentage, performance status (compliant, non-compliant, excused, no-show), incentive earned ($), and penalty assessed ($). Supports DR performance settlement, NERC compliance reporting, VPP performance tracking, and wholesale market settlement verification.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` (
    `vpp_agreement_id` BIGINT COMMENT 'Unique identifier for the VPP participation agreement.',
    `aggregator_id` BIGINT COMMENT 'Unique identifier of the aggregator entity.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: VPP participants are dispatched within a balancing area; linking contracts to the area supports dispatch scheduling and market settlement.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the commercial or industrial customer party.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the commercial or industrial customer party.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: VPP agreements bind an aggregator to the DER assets at a particular facility for dispatch and settlement reporting.',
    `agreement_number` STRING COMMENT 'External reference number for the agreement as used in contracts and filings.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the agreement.. Valid values are `draft|pending|active|suspended|terminated|expired`',
    `agreement_term_months` STRING COMMENT 'Duration of the agreement in months.',
    `agreement_type` STRING COMMENT 'Indicates whether the agreement is directly with the customer or mediated through an aggregator.. Valid values are `direct_customer|aggregator_mediated`',
    `capacity_payment_usd_per_kw_month` DECIMAL(18,2) COMMENT 'Compensation rate for committed capacity.',
    `compliance_status` STRING COMMENT 'Indicates compliance with regulatory filing requirements.. Valid values are `compliant|non_compliant|pending_review`',
    `contract_version` STRING COMMENT 'Version number of the agreement document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the agreement record was first created in the system.',
    `der_asset_types` STRING COMMENT 'Types of distributed energy resources included (e.g., battery storage, backup generation, HVAC load, EV charging).',
    `dispatch_protocol` STRING COMMENT 'Method by which the VPP operator dispatches resources.. Valid values are `automated_derms|manual_notification`',
    `dr_participation` BOOLEAN COMMENT 'Indicates whether the agreement includes demand response program participation.',
    `effective_end_date` DATE COMMENT 'Date when the agreement ends or expires; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date when the agreement becomes effective.',
    `energy_payment_usd_per_kwh` DECIMAL(18,2) COMMENT 'Compensation rate for actual energy dispatched.',
    `exclusive_flag` BOOLEAN COMMENT 'Indicates if the customer is prohibited from participating in other VPP programs.',
    `ferc_filing_reference` STRING COMMENT 'Reference identifier for the related FERC filing.',
    `geographic_region` STRING COMMENT 'Three‑letter ISO code representing the primary service region for the agreement.. Valid values are `[A-Z]{3}`',
    `max_dispatch_power_kw` DECIMAL(18,2) COMMENT 'Maximum power that can be dispatched from the aggregated resources.',
    `min_dispatch_power_kw` DECIMAL(18,2) COMMENT 'Minimum power that must be dispatched when called upon.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or special conditions.',
    `puc_filing_reference` STRING COMMENT 'Reference identifier for the state Public Utility Commission filing.',
    `rec_eligible` BOOLEAN COMMENT 'Flag indicating if the agreement qualifies for Renewable Energy Certificates.',
    `renewable_flag` BOOLEAN COMMENT 'Indicates if the DER assets are primarily renewable (e.g., solar, wind).',
    `response_time_minutes` STRING COMMENT 'Maximum time in minutes the resources must respond after dispatch signal.',
    `settlement_market` STRING COMMENT 'Wholesale market(s) where the VPP resources are settled.. Valid values are `day_ahead|real_time|both`',
    `signed_date` DATE COMMENT 'Date when the agreement was signed by all parties.',
    `termination_date` DATE COMMENT 'Date when the agreement was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Reason provided for early termination of the agreement.',
    `total_committed_capacity_kw` DECIMAL(18,2) COMMENT 'Total capacity in kilowatts that the customer/aggregator commits to provide to the VPP.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the agreement record.',
    `vpp_program_name` STRING COMMENT 'Name of the specific VPP program under which the agreement is executed.',
    CONSTRAINT pk_vpp_agreement PRIMARY KEY(`vpp_agreement_id`)
) COMMENT 'Virtual Power Plant (VPP) participation agreement master record for C&I customers and DER aggregators enrolled in the utilitys VPP program. Captures agreement type (direct customer, aggregator-mediated), aggregator name (if applicable), total committed capacity (kW), DER asset types included (battery storage, backup generation, HVAC load, EV charging), dispatch protocol (automated DERMS, manual notification), response time requirement (minutes), agreement term, compensation structure (capacity payment $/kW-month, energy payment $/kWh), FERC/PUC filing reference, and agreement status. Supports DERMS integration and wholesale market participation.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` (
    `large_customer_contract_id` BIGINT COMMENT 'System-generated unique identifier for the large customer contract record.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Large contracts are negotiated per balancing‑area jurisdiction; linking ensures compliance with regional reliability standards and market rules.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the commercial or industrial customer linked to this contract.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the commercial or industrial customer linked to this contract.',
    `distribution_service_point_id` BIGINT COMMENT 'Identifier of the service point (metered location) covered by the contract.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to trading.trading_portfolio. Business justification: Large‑customer contracts are aggregated in a trading portfolio for risk, VAR, and P&L reporting per regulatory requirements.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Contracts are priced on a specific rate schedule; billing system and regulatory filing need a FK to the exact rate_schedule used.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Large‑customer contracts are often site‑specific, defining demand‑response obligations and billing at the site level.',
    `amendment_count` STRING COMMENT 'Number of times the contract has been amended since inception.',
    `billing_cycle` STRING COMMENT 'Frequency at which the customer is billed under the contract.. Valid values are `monthly|quarterly|annually`',
    `confidentiality_clause_flag` BOOLEAN COMMENT 'Indicates whether the contract contains a confidentiality provision.',
    `contract_approved_date` DATE COMMENT 'Date the contract received internal approval to be executed.',
    `contract_document_url` STRING COMMENT 'Link to the stored electronic copy of the signed contract.',
    `contract_number` STRING COMMENT 'External contract identifier used in customer communications and regulatory filings.',
    `contract_signed_by` STRING COMMENT 'Name of the authorized individual who signed the contract on behalf of the utility.',
    `contract_signed_date` DATE COMMENT 'Date the contract was signed by all parties.',
    `contract_status_reason` STRING COMMENT 'Free‑text explanation for the current contract status (e.g., pending PUC approval).',
    `contract_term_years` STRING COMMENT 'Length of the contract term expressed in whole years.',
    `contract_termination_date` DATE COMMENT 'Date the contract was formally terminated prior to its scheduled end.',
    `contract_type` STRING COMMENT 'Category of the negotiated agreement (e.g., economic development rate, interruptible service).. Valid values are `economic_development|interruptible|standby|co_generation|custom`',
    `contract_value` DECIMAL(18,2) COMMENT 'Total monetary value of the contract as agreed, expressed in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit exposure the utility extends to the customer for this contract.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for contract pricing.',
    `demand_charge_structure` STRING COMMENT 'Description of how demand charges are calculated (e.g., kW peak, time‑of‑use tiers).',
    `discount_rate_percent` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base rates under the contract.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee payable by the customer for terminating the contract before the agreed end date.',
    `effective_end_date` DATE COMMENT 'Date the contract terminates or expires; null for open‑ended agreements.',
    `effective_start_date` DATE COMMENT 'Date the contract becomes binding and service obligations commence.',
    `energy_charge_structure` STRING COMMENT 'Description of the energy usage charge methodology (e.g., flat rate, tiered, TOU).',
    `escalation_clause_description` STRING COMMENT 'Text describing any price escalation mechanisms (e.g., CPI‑linked adjustments).',
    `ferc_filing_reference` STRING COMMENT 'Reference number of the associated FERC filing, if applicable.',
    `large_customer_contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `active|inactive|pending|terminated|draft`',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment.',
    `minimum_bill_commitment` DECIMAL(18,2) COMMENT 'Minimum monthly billing amount the customer must incur under the contract.',
    `notes` STRING COMMENT 'Additional free‑form remarks or comments about the contract.',
    `payment_terms` STRING COMMENT 'Standard payment terms agreed for invoice settlement.. Valid values are `net_30|net_60|net_90`',
    `puc_approval_status` STRING COMMENT 'Regulatory approval status from the Public Utility Commission.. Valid values are `approved|pending|rejected`',
    `regulatory_approval_date` DATE COMMENT 'Date the contract received all required regulatory approvals.',
    `regulatory_approval_status` STRING COMMENT 'Current status of the regulatory approval process.. Valid values are `approved|pending|rejected`',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the contract includes an automatic renewal provision.',
    `renewal_term_years` STRING COMMENT 'Length of the renewal period if the renewal option is exercised.',
    `special_conditions` STRING COMMENT 'Any non‑standard clauses, incentives, or obligations specific to the contract.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    CONSTRAINT pk_large_customer_contract PRIMARY KEY(`large_customer_contract_id`)
) COMMENT 'Master record for negotiated large customer service contracts and special contracts for C&I customers including economic development rates, interruptible service agreements, standby service contracts, and co-generation interconnection agreements. Captures contract type, negotiated rate schedule reference, contract term (start/end dates), minimum bill commitment, demand charge structure, energy charge structure, special conditions, PUC approval status, FERC filing reference (if applicable), contract value ($), and assigned KAM. Distinct from standard tariff service — these are individually negotiated agreements requiring regulatory approval.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` (
    `crm_interaction_id` BIGINT COMMENT 'System-generated unique identifier for each interaction record.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the commercial customer involved in the interaction.',
    `customer_customer_account_id` BIGINT COMMENT 'Unique identifier of the commercial customer involved in the interaction.',
    `employee_id` BIGINT COMMENT 'System identifier of the employee who recorded the interaction.',
    `filing_id` BIGINT COMMENT 'Identifier of the regulatory report generated from this interaction.',
    `gridops_outage_event_id` BIGINT COMMENT 'Foreign key linking to gridops.gridops_outage_event. Business justification: Customer service logs related to outages must reference the specific outage event to track resolution, compliance, and reporting.',
    `kam_key_account_manager_id` BIGINT COMMENT 'Identifier of the internal account manager responsible for the interaction.',
    `key_account_manager_id` BIGINT COMMENT 'Identifier of the internal account manager responsible for the interaction.',
    `opportunity_id` BIGINT COMMENT 'Identifier of the sales/opportunity record linked to this interaction.',
    `product_program_id` BIGINT COMMENT 'Identifier of the demand‑side‑management or VPP program associated with the interaction.',
    `complaint_id` BIGINT COMMENT 'Identifier of a service or compliance case linked to the interaction.',
    `resource_id` BIGINT COMMENT 'Foreign key linking to der.der_resource. Business justification: Customer service interactions (e.g., fault reports) are frequently about a particular DER asset; linking provides full service history per asset.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Field interactions (inspections, maintenance) are logged against the site to support compliance audits and operational tracking.',
    `trade_id` BIGINT COMMENT 'Foreign key linking to trading.trade. Business justification: CRM interactions (calls, meetings) are tied to specific trades to capture sales effort and support post‑trade relationship management.',
    `transmission_outage_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_outage. Business justification: Outage‑related CRM interactions must reference the transmission outage to capture customer communication and resolution steps.',
    `attachment_count` STRING COMMENT 'Number of files or documents attached to the interaction record.',
    `channel` STRING COMMENT 'Medium through which the interaction was delivered.. Valid values are `in_person|virtual|phone|email|other`',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the interaction triggers regulatory or compliance review.',
    `compliance_review_status` STRING COMMENT 'Current status of any compliance review associated with the interaction.. Valid values are `pending|completed|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the interaction record was first created in the system.',
    `escalation_reason` STRING COMMENT 'Reason provided for escalating the interaction.',
    `facility_area_inspected` STRING COMMENT 'Specific area or system within the facility that was examined during a site visit.',
    `feedback_comments` STRING COMMENT 'Free‑form comments accompanying the feedback score.',
    `feedback_score` STRING COMMENT 'Numeric rating (e.g., 1‑5) supplied by the customer after the interaction.',
    `follow_up_due_date` DATE COMMENT 'Date by which any required follow‑up must be completed.',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether a follow‑up action is needed after the interaction.',
    `interaction_duration_minutes` STRING COMMENT 'Length of the interaction measured in whole minutes.',
    `interaction_priority` STRING COMMENT 'Business priority assigned to the interaction for follow‑up handling.. Valid values are `high|medium|low`',
    `interaction_status` STRING COMMENT 'Current processing status of the interaction record.. Valid values are `logged|reviewed|closed`',
    `interaction_timestamp` TIMESTAMP COMMENT 'Date and time when the interaction actually occurred.',
    `interaction_type` STRING COMMENT 'Category of the interaction (e.g., site visit, phone call, email, webinar, trade show, executive briefing, field inspection). [ENUM-REF-CANDIDATE: site_visit|phone_call|email|webinar|trade_show|executive_briefing|field_inspection — promote to reference product]',
    `is_escalated` BOOLEAN COMMENT 'Indicates whether the interaction was escalated to higher‑level management or compliance.',
    `outcome` STRING COMMENT 'Result of the interaction from the perspective of the utility.. Valid values are `completed|pending|cancelled|no_response|rescheduled`',
    `recorded_by` STRING COMMENT 'Name of the employee who entered the interaction into the system.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'True if the interaction must be reported to a regulator (e.g., FERC, NERC).',
    `site_conditions_noted` STRING COMMENT 'Observations about site conditions (e.g., temperature, safety hazards) recorded during the visit.',
    `source_system` STRING COMMENT 'Originating system of the interaction record (e.g., Salesforce, ServiceNow).',
    `subject` STRING COMMENT 'Brief title or topic of the interaction.',
    `summary_notes` STRING COMMENT 'Free‑form notes capturing the content and outcomes of the interaction.',
    `system_activity_code` STRING COMMENT 'Unique identifier from the source system (e.g., Salesforce activity ID) for traceability.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the interaction record.',
    `visit_location` STRING COMMENT 'Physical address or site name where a site‑visit interaction took place.',
    CONSTRAINT pk_crm_interaction PRIMARY KEY(`crm_interaction_id`)
) COMMENT 'Interaction log capturing all touchpoints between utility commercial staff and C&I customers. Captures interaction type (site visit, phone call, email, webinar, trade show, executive briefing, field inspection), interaction date/time, channel, subject, summary notes, follow-up actions required, follow-up due date, interaction outcome, associated opportunity ID, associated program ID, system activity identifier, and KAM ID. For site visit interactions, additionally captures visit location, facility area inspected, and site conditions noted. Supports relationship management, account planning, and customer satisfaction tracking for the C&I segment.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` (
    `satisfaction_survey_id` BIGINT COMMENT 'Unique identifier for the satisfaction survey record.',
    `contact_id` BIGINT COMMENT 'System identifier for the survey respondent.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with the survey.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the C&I customer who received the survey.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: Surveys measure performance of specific IT services (e.g., outage handling); linking ties feedback to the service.',
    `person_id` BIGINT COMMENT 'System identifier for the survey respondent.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Surveys collect feedback on utility programs; linking each survey to the program enables program performance dashboards and regulatory satisfaction metrics.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Surveys measuring service reliability and satisfaction are tied to the specific site where service is delivered for regulatory reporting.',
    `billing_accuracy_rating` STRING COMMENT 'Customer rating of billing accuracy on a 1‑10 scale.',
    `comments` STRING COMMENT 'Open‑ended feedback provided by the respondent.',
    `confidentiality_flag` BOOLEAN COMMENT 'Indicates if the survey contains confidential information.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first created in the system.',
    `delivery_channel` STRING COMMENT 'Medium through which the survey was delivered to the respondent.. Valid values are `email|phone|online_portal|mail`',
    `follow_up_action_due_date` DATE COMMENT 'Target date by which any required follow‑up must be completed.',
    `follow_up_action_required` BOOLEAN COMMENT 'Indicates whether the survey response triggers a follow‑up action.',
    `kam_responsiveness_rating` STRING COMMENT 'Rating of the Key Account Managers responsiveness, 1‑10.',
    `nps_score` STRING COMMENT 'Standard NPS metric indicating likelihood to recommend the utility.',
    `overall_satisfaction_score` STRING COMMENT 'Overall rating of the utility service provided by the customer, on a 1‑10 scale.',
    `program_value_rating` STRING COMMENT 'Rating of the perceived value of demand‑side management or other programs.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the survey response must be included in PUC or FERC service quality reporting.',
    `respondent_name` STRING COMMENT 'Full legal name of the survey respondent.',
    `respondent_role` STRING COMMENT 'Role of the individual who completed the survey.. Valid values are `end_user|account_manager|technical_contact`',
    `response_time_minutes` STRING COMMENT 'Time taken by the respondent to complete the survey, measured in minutes.',
    `satisfaction_survey_status` STRING COMMENT 'Current lifecycle status of the survey.. Valid values are `pending|completed|reviewed|closed`',
    `service_reliability_rating` STRING COMMENT 'Customer rating of service reliability on a 1‑10 scale.',
    `survey_code` STRING COMMENT 'External reference code for the survey, used in reporting and tracking.. Valid values are `^SURV-d{6}$`',
    `survey_date` DATE COMMENT 'Calendar date of the survey (date portion of survey_timestamp).',
    `survey_language` STRING COMMENT 'Language in which the survey was presented.. Valid values are `en|es|fr`',
    `survey_timestamp` TIMESTAMP COMMENT 'Exact date and time when the survey was administered.',
    `survey_type` STRING COMMENT 'Category of the survey based on its purpose.. Valid values are `annual_key_account|post_interaction|post_outage|program_exit`',
    `survey_version` STRING COMMENT 'Version of the survey instrument used.. Valid values are `^vd+.d+$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the survey record.',
    CONSTRAINT pk_satisfaction_survey PRIMARY KEY(`satisfaction_survey_id`)
) COMMENT 'Customer satisfaction survey record capturing structured feedback from C&I customers on utility service quality, account management effectiveness, and program satisfaction. Captures survey type (annual key account survey, post-interaction survey, post-outage survey, program exit survey), survey date, delivery channel (email, phone, online portal), overall satisfaction score (1-10), NPS score, service reliability rating, billing accuracy rating, KAM responsiveness rating, program value rating, verbatim comments, and follow-up action required flag. Supports J.D. Power benchmarking and PUC service quality reporting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` (
    `engagement_account_plan_id` BIGINT COMMENT 'System-generated unique identifier for the account plan record.',
    `aggregation_group_id` BIGINT COMMENT 'Foreign key linking to der.aggregation_group. Business justification: Strategic account plans often target participation in a specific DER aggregation group for demand‑response or VPP programs; needed for planning dashboards.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Strategic account plans align with balancing‑area load growth and DR targets; linking enables area‑level performance tracking.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the commercial or industrial customer linked to the plan.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the commercial or industrial customer linked to the plan.',
    `employee_id` BIGINT COMMENT 'Identifier of the Key Account Manager responsible for the plan.',
    `key_account_manager_id` BIGINT COMMENT 'Identifier of the Key Account Manager responsible for the plan.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Account planning includes site‑level load growth, DR participation, and DER targets; linking plan to site enables accurate forecasting.',
    `account_tier` STRING COMMENT 'Strategic importance classification of the account.. Valid values are `strategic|key|mid|small`',
    `approval_status` STRING COMMENT 'Current status of the plan within the approval process.. Valid values are `draft|submitted|approved|rejected`',
    `approved_by` STRING COMMENT 'Name of the executive or manager who approved the plan.',
    `approved_date` DATE COMMENT 'Date on which the plan received final approval.',
    `budget_amount_usd` DECIMAL(18,2) COMMENT 'Total budget allocated for executing the plan activities.',
    `capital_investment_opportunities` STRING COMMENT 'Potential capital projects or investments identified for the account.',
    `competitive_threats` STRING COMMENT 'Summary of external competitive pressures relevant to the account.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values in the plan.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `der_participation_flag` BOOLEAN COMMENT 'Indicates whether the account is currently participating in a Distributed Energy Resources program.',
    `dr_participation_flag` BOOLEAN COMMENT 'Indicates whether the account is currently participating in a DR program.',
    `ee_participation_flag` BOOLEAN COMMENT 'Indicates whether the account is currently participating in an Energy Efficiency program.',
    `effective_from` DATE COMMENT 'Date when the plan becomes effective.',
    `effective_until` DATE COMMENT 'Date when the plan expires or is superseded; null for open‑ended plans.',
    `expected_annual_savings_usd` DECIMAL(18,2) COMMENT 'Projected annual cost savings resulting from plan initiatives.',
    `identified_risks` STRING COMMENT 'Narrative description of key risks associated with the account plan.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the plan.',
    `load_growth_target_kw` DECIMAL(18,2) COMMENT 'Projected increase in peak load (kilowatts) the account is expected to generate.',
    `load_reduction_target_kw` DECIMAL(18,2) COMMENT 'Targeted reduction in peak load (kilowatts) for the account.',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of the plan.',
    `notes` STRING COMMENT 'Free‑form comments or observations added by the plan owner.',
    `plan_status` STRING COMMENT 'Current operational status of the account plan.. Valid values are `active|inactive|on_hold|closed`',
    `plan_type` STRING COMMENT 'Category of the strategic plan (e.g., growth, retention).. Valid values are `growth|retention|new_business|risk_mitigation`',
    `plan_year` STRING COMMENT 'Fiscal year for which the account plan is applicable.',
    `planned_touchpoints` STRING COMMENT 'List of scheduled interactions (meetings, calls, site visits) with the account.',
    `program_enrollment_target_der` BOOLEAN COMMENT 'Flag indicating whether enrolling the account in a Distributed Energy Resources program is a target.',
    `program_enrollment_target_dr` BOOLEAN COMMENT 'Flag indicating whether enrolling the account in a Demand Response program is a target.',
    `program_enrollment_target_ee` BOOLEAN COMMENT 'Flag indicating whether enrolling the account in an Energy Efficiency program is a target.',
    `revenue_retention_target_usd` DECIMAL(18,2) COMMENT 'Target dollar amount of revenue to retain from the account during the plan period.',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the plan after assessment.. Valid values are `low|medium|high|critical`',
    `strategic_objectives` STRING COMMENT 'High‑level business goals the plan aims to achieve.',
    `target_customer_segment` STRING COMMENT 'Primary market segment the plan is designed for.. Valid values are `industrial|commercial|municipal|residential`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the plan record.',
    `version_number` STRING COMMENT 'Incremental version number for the plan to track revisions.',
    CONSTRAINT pk_engagement_account_plan PRIMARY KEY(`engagement_account_plan_id`)
) COMMENT 'Annual or multi-year strategic account plan developed by KAMs for key C&I accounts. Captures plan year, account tier, strategic objectives, revenue retention target ($), load growth/reduction target (kW), program enrollment targets (DR, EE, DER), identified risks, competitive threats (retail choice markets), planned touchpoints, capital investment opportunities, and plan approval status. Supports key account management discipline and commercial strategy execution for the C&I segment.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` (
    `dsm_incentive_payment_id` BIGINT COMMENT 'Unique system-generated identifier for the DSM incentive payment record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the commercial or industrial customer receiving the incentive.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the commercial or industrial customer receiving the incentive.',
    `enrollment_id` BIGINT COMMENT 'Identifier of the specific enrollment or audit record linked to this incentive payment.',
    `product_program_id` BIGINT COMMENT 'Identifier of the DSM program (e.g., energy efficiency, demand response) under which the incentive is issued.',
    `amount_adjustment` DECIMAL(18,2) COMMENT 'Sum of adjustments (taxes, fees, discounts) applied to the gross amount.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total incentive amount before any adjustments, taxes, or fees.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount paid to the customer after adjustments.',
    `calculation_basis` STRING COMMENT 'Metric used to calculate the incentive (e.g., kilowatt‑hour saved, kilowatt curtailed, or $ per kW‑month).. Valid values are `kwh_saved|kw_curtailed|usd_per_kw_month`',
    `calculation_value` DECIMAL(18,2) COMMENT 'Numeric value of the calculation basis (e.g., total kWh saved).',
    `cost_center_code` STRING COMMENT 'Internal cost center identifier for accounting and PUC reporting.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the payment (e.g., USD).',
    `dsm_incentive_payment_description` STRING COMMENT 'Free‑form text describing the purpose or notes for the incentive payment.',
    `external_payment_reference` STRING COMMENT 'Identifier of the payment in an external financial or banking system.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Any fee (e.g., processing fee) applied to the incentive payment.',
    `payment_batch_number` BIGINT COMMENT 'Identifier of the batch in which this payment was processed.',
    `payment_method` STRING COMMENT 'Mechanism used to deliver the incentive (bill credit, check, or ACH).. Valid values are `bill_credit|check|ach`',
    `payment_reference_number` STRING COMMENT 'External reference number assigned to the incentive payment for tracking and reporting.',
    `payment_status` STRING COMMENT 'Current processing state of the incentive payment.. Valid values are `pending|approved|issued|reversed`',
    `payment_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the payment was issued or recorded.',
    `payment_type` STRING COMMENT 'Category of incentive: rebate, performance incentive, capacity payment, or installation incentive.. Valid values are `rebate|performance|capacity|installation`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the incentive payment record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the incentive payment record.',
    `reporting_period` STRING COMMENT 'Fiscal or regulatory period associated with the payment (e.g., 2023-Q1).',
    `reversal_reason` STRING COMMENT 'Reason provided when a payment is reversed or voided.',
    `settlement_date` DATE COMMENT 'Date on which the payment was settled with the customer.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax portion included in the adjustment amount.',
    CONSTRAINT pk_dsm_incentive_payment PRIMARY KEY(`dsm_incentive_payment_id`)
) COMMENT 'Transactional record of incentive payments issued to C&I customers for participation in DSM programs including energy efficiency rebates, DR performance payments, DER installation incentives, and VPP capacity payments. Captures payment type (rebate, performance incentive, capacity payment, installation incentive), associated program, associated enrollment or audit record, payment calculation basis (kWh saved, kW curtailed, $/kW-month), calculated incentive amount ($), payment status (pending, approved, issued, reversed), payment method (bill credit, check, ACH), and payment date. Supports DSM cost recovery and PUC program reporting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` (
    `outreach_campaign_id` BIGINT COMMENT 'System-generated unique identifier for the outreach campaign.',
    `digital_platform_id` BIGINT COMMENT 'Foreign key linking to technology.digital_platform. Business justification: Campaigns are executed on a digital platform (web portal, mobile app); the platform ID is required for reporting and ROI analysis.',
    `key_account_manager_id` BIGINT COMMENT 'Identifier of the internal employee or manager responsible for the campaign.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Targeted outreach campaigns are directed at specific parcels for program enrollment and demand‑response recruitment.',
    `actual_spend_usd` DECIMAL(18,2) COMMENT 'Total amount actually spent on the campaign to date, in U.S. dollars.',
    `budget_usd` DECIMAL(18,2) COMMENT 'Approved monetary budget for the campaign expressed in U.S. dollars.',
    `campaign_code` STRING COMMENT 'Human‑readable external code or number used to reference the campaign in business processes.',
    `campaign_type` STRING COMMENT 'Category of the campaign indicating its business purpose.. Valid values are `dr_recruitment|energy_efficiency|tou_migration|vpp_enrollment|rate_change|executive_briefing`',
    `channel` STRING COMMENT 'Primary communication channel used for the outreach.. Valid values are `email|direct_mail|phone|event|digital|social_media`',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the campaign as required by FERC/NERC reporting.. Valid values are `compliant|non_compliant|pending_review`',
    `contacted_account_count` STRING COMMENT 'Number of accounts that were actually contacted during the campaign.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the campaign record was first created in the system.',
    `end_date` DATE COMMENT 'Date on which the campaign is scheduled to end.',
    `enrollment_conversion_count` STRING COMMENT 'Number of responses that resulted in enrollment into a demand‑side management program.',
    `external_system_code` STRING COMMENT 'Identifier of the campaign record in the source CRM system (e.g., Salesforce Campaign ID).',
    `is_test_campaign` BOOLEAN COMMENT 'Indicates whether the campaign is a pilot or test run (true) or a production campaign (false).',
    `outreach_campaign_description` STRING COMMENT 'Free‑form text describing the purpose, scope, and key messages of the campaign.',
    `outreach_campaign_name` STRING COMMENT 'Descriptive name of the outreach campaign.',
    `outreach_campaign_status` STRING COMMENT 'Current lifecycle status of the campaign.. Valid values are `planned|active|completed|cancelled|paused`',
    `regulatory_approval_date` DATE COMMENT 'Date on which the campaign received required regulatory approvals, if applicable.',
    `response_count` STRING COMMENT 'Total number of responses received from contacted accounts.',
    `segment_criteria` STRING COMMENT 'Business rules or filters that define the target customer segment for the campaign.',
    `start_date` DATE COMMENT 'Date on which the campaign is scheduled to begin.',
    `target_account_count` STRING COMMENT 'Number of customer accounts identified for outreach.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the campaign record.',
    CONSTRAINT pk_outreach_campaign PRIMARY KEY(`outreach_campaign_id`)
) COMMENT 'Commercial customer outreach campaign record managing targeted engagement campaigns for C&I customer segments. Captures campaign name, campaign type (DR recruitment, EE program launch, TOU migration, VPP enrollment, rate change notification, executive briefing series), target segment criteria, campaign channel (email, direct mail, phone, event, digital), campaign start/end dates, target account count, contacted account count, response count, enrollment conversions, campaign budget ($), actual spend ($), and campaign status. Includes account-level response tracking: response date, response type (interested, declined, enrolled, no-response), follow-up disposition, and conversion outcome. Supports DSM program recruitment, campaign ROI measurement, and commercial engagement strategy.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ADD CONSTRAINT `fk_engagement_ci_account_key_account_manager_id` FOREIGN KEY (`key_account_manager_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`key_account_manager`(`key_account_manager_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ADD CONSTRAINT `fk_engagement_opportunity_assigned_kam_key_account_manager_id` FOREIGN KEY (`assigned_kam_key_account_manager_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`key_account_manager`(`key_account_manager_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ADD CONSTRAINT `fk_engagement_opportunity_key_account_manager_id` FOREIGN KEY (`key_account_manager_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`key_account_manager`(`key_account_manager_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ADD CONSTRAINT `fk_engagement_energy_audit_dsm_program_id` FOREIGN KEY (`dsm_program_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`dsm_program`(`dsm_program_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_kam_key_account_manager_id` FOREIGN KEY (`kam_key_account_manager_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`key_account_manager`(`key_account_manager_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_key_account_manager_id` FOREIGN KEY (`key_account_manager_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`key_account_manager`(`key_account_manager_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ADD CONSTRAINT `fk_engagement_crm_interaction_opportunity_id` FOREIGN KEY (`opportunity_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`opportunity`(`opportunity_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ADD CONSTRAINT `fk_engagement_engagement_account_plan_key_account_manager_id` FOREIGN KEY (`key_account_manager_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`key_account_manager`(`key_account_manager_id`);
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ADD CONSTRAINT `fk_engagement_outreach_campaign_key_account_manager_id` FOREIGN KEY (`key_account_manager_id`) REFERENCES `power_and_utilities_v2`.`engagement`.`key_account_manager`(`key_account_manager_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`engagement` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `power_and_utilities_v2`.`engagement` SET TAGS ('dbx_domain' = 'engagement');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Commercial and Industrial Account ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Der Nem Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `key_account_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Key Account Manager ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `account_name` SET TAGS ('dbx_business_glossary_term' = 'Account Name (Legal Entity)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number (External)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending|prospect');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type (Segment)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `annual_energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Annual Energy Consumption (MWh)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `annual_gas_consumption_mcf` SET TAGS ('dbx_business_glossary_term' = 'Annual Gas Consumption (MCF)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fixed|variable|index|hybrid|spot|custom');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO‑3)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `dr_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Enrollment Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Identifier');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `industry_code` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification Code (SIC/NAICS)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `industry_description` SET TAGS ('dbx_business_glossary_term' = 'Industry Description');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `key_account_tier` SET TAGS ('dbx_business_glossary_term' = 'Key Account Tier');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `key_account_tier` SET TAGS ('dbx_value_regex' = 'tier1|tier2|tier3|tier4|tier5|tier6');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `last_activity_date` SET TAGS ('dbx_business_glossary_term' = 'Last Activity Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Account Notes');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `peak_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand (kW)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mail|portal|fax|sms');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Account Status Reason');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `strategic_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Strategic Account Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`ci_account` ALTER COLUMN `vpp_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'VPP Participation Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `key_account_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Key Account Manager Identifier');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `crew_member_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `crew_member_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `crew_member_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Employee Identifier');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `system_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'System User Identifier');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `system_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `system_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `annual_salary_usd` SET TAGS ('dbx_business_glossary_term' = 'Annual Salary (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `annual_salary_usd` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `annual_salary_usd` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `bonus_eligible` SET TAGS ('dbx_business_glossary_term' = 'Bonus Eligibility Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `certification_level` SET TAGS ('dbx_business_glossary_term' = 'Certification Level (CERT_LVL)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `certification_level` SET TAGS ('dbx_value_regex' = 'none|level1|level2|level3|expert');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `compliance_training_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Training Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `current_account_count` SET TAGS ('dbx_business_glossary_term' = 'Current Account Count');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `employee_status` SET TAGS ('dbx_business_glossary_term' = 'Employee Status (EMP_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `employee_status` SET TAGS ('dbx_value_regex' = 'full_time|part_time|contractor|temp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `external_certifications` SET TAGS ('dbx_business_glossary_term' = 'External Certifications');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name (FN)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `hire_date` SET TAGS ('dbx_business_glossary_term' = 'Hire Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `is_remote` SET TAGS ('dbx_business_glossary_term' = 'Remote Work Indicator');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `key_account_manager_status` SET TAGS ('dbx_business_glossary_term' = 'Employment Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `key_account_manager_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_leave|terminated');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (LN)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `last_performance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Review Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `last_performance_score` SET TAGS ('dbx_business_glossary_term' = 'Last Performance Score');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `manager_level` SET TAGS ('dbx_business_glossary_term' = 'Manager Level (LEVEL)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `manager_level` SET TAGS ('dbx_value_regex' = 'associate|senior|lead|director|vp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `max_account_capacity` SET TAGS ('dbx_business_glossary_term' = 'Maximum Account Capacity');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Manager Notes');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `office_location` SET TAGS ('dbx_business_glossary_term' = 'Office Location (ADDRESS)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `office_location` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `office_location` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `performance_tier` SET TAGS ('dbx_business_glossary_term' = 'Performance Tier (PERF_TIER)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `performance_tier` SET TAGS ('dbx_value_regex' = 'bronze|silver|gold|platinum');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PHONE)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `portfolio_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Value (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `portfolio_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `primary_language` SET TAGS ('dbx_business_glossary_term' = 'Primary Language (LANG)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `primary_language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Region (REG)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `region` SET TAGS ('dbx_value_regex' = 'north_america|europe|asia');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `specialization` SET TAGS ('dbx_business_glossary_term' = 'Specialization (SPEC)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `specialization` SET TAGS ('dbx_value_regex' = 'electric|gas|industrial|municipal|renewable|mixed');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code (TERR)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = 'NORTH|SOUTH|EAST|WEST|MIDWEST|WEST_COAST');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `training_completed` SET TAGS ('dbx_business_glossary_term' = 'Training Completion Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `work_phone` SET TAGS ('dbx_business_glossary_term' = 'Work Phone Number');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `work_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `work_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`key_account_manager` ALTER COLUMN `work_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `assigned_kam_key_account_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Key Account Manager ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `interconnection_request_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Request Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `key_account_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Key Account Manager ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Closed Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `estimated_annual_revenue_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Revenue (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `estimated_demand_reduction_kw` SET TAGS ('dbx_business_glossary_term' = 'Estimated Demand Reduction (kW)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `estimated_energy_savings_kwh_per_year` SET TAGS ('dbx_business_glossary_term' = 'Estimated Energy Savings (kWh per Year)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `estimated_load_impact_kw` SET TAGS ('dbx_business_glossary_term' = 'Estimated Load Impact (kW)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `estimated_savings_usd_per_year` SET TAGS ('dbx_business_glossary_term' = 'Estimated Savings (USD per Year)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `expected_close_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Close Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Opportunity ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `opportunity_name` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Name');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `opportunity_number` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Number');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `opportunity_type` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Type');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `opportunity_type` SET TAGS ('dbx_value_regex' = 'new_service|rate_change|dr_enrollment|der_program|vpp_participation|energy_efficiency');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `probability_of_close_pct` SET TAGS ('dbx_business_glossary_term' = 'Probability of Close (%)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `proposal_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Proposal Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `proposal_status` SET TAGS ('dbx_business_glossary_term' = 'Proposal Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `proposal_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|accepted|rejected|expired');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `proposal_type` SET TAGS ('dbx_business_glossary_term' = 'Proposal Type');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `proposal_version` SET TAGS ('dbx_business_glossary_term' = 'Proposal Version');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `proposed_incentive_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Proposed Incentive Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `proposed_solution_description` SET TAGS ('dbx_business_glossary_term' = 'Proposed Solution Description');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `source` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Source');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Stage');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `stage` SET TAGS ('dbx_value_regex' = 'prospecting|qualification|proposal|negotiation|closed_won|closed_lost');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`opportunity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` SET TAGS ('dbx_subdomain' = 'demand_programs');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `energy_audit_id` SET TAGS ('dbx_business_glossary_term' = 'Energy Audit ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `dsm_program_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Der Resource Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `audit_date` SET TAGS ('dbx_business_glossary_term' = 'Audit Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `audit_name` SET TAGS ('dbx_business_glossary_term' = 'Audit Name');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `audit_number` SET TAGS ('dbx_business_glossary_term' = 'Audit Number (Audit ID)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `audit_report_url` SET TAGS ('dbx_business_glossary_term' = 'Audit Report URL');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_business_glossary_term' = 'Audit Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `audit_status` SET TAGS ('dbx_value_regex' = 'scheduled|in-progress|completed|report-delivered|canceled');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_business_glossary_term' = 'Audit Type');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `audit_type` SET TAGS ('dbx_value_regex' = 'walk-through|investment-grade|virtual|remote');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `audit_version` SET TAGS ('dbx_business_glossary_term' = 'Audit Version');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_business_glossary_term' = 'Auditor Full Name');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `auditor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `baseline_consumption_unit` SET TAGS ('dbx_business_glossary_term' = 'Baseline Consumption Unit');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `baseline_consumption_unit` SET TAGS ('dbx_value_regex' = 'kWh|MCF');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `baseline_consumption_value` SET TAGS ('dbx_business_glossary_term' = 'Baseline Consumption Value');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `baseline_consumption_year` SET TAGS ('dbx_business_glossary_term' = 'Baseline Consumption Year');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `completed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Audit Completed Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `demand_reduction_kw` SET TAGS ('dbx_business_glossary_term' = 'Demand Reduction (kW)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `estimated_co2_reduction_tons` SET TAGS ('dbx_business_glossary_term' = 'Estimated CO2 Reduction (Tons)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `estimated_energy_cost_savings_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Energy Cost Savings (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `estimated_implementation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Implementation Cost');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `external_audit_reference` SET TAGS ('dbx_business_glossary_term' = 'External Audit ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `facility_address` SET TAGS ('dbx_business_glossary_term' = 'Facility Address');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `facility_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `facility_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `facility_city` SET TAGS ('dbx_business_glossary_term' = 'Facility City');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `facility_state` SET TAGS ('dbx_business_glossary_term' = 'Facility State');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `facility_zip` SET TAGS ('dbx_business_glossary_term' = 'Facility ZIP Code');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `identified_savings_unit` SET TAGS ('dbx_business_glossary_term' = 'Identified Savings Unit');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `identified_savings_unit` SET TAGS ('dbx_value_regex' = 'kWh|MCF');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `identified_savings_value` SET TAGS ('dbx_business_glossary_term' = 'Identified Savings Value');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `is_virtual_audit` SET TAGS ('dbx_business_glossary_term' = 'Is Virtual Audit');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Audit Notes');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `recommended_measures` SET TAGS ('dbx_business_glossary_term' = 'Recommended Measures');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_business_glossary_term' = 'Risk Level');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `risk_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `simple_payback_years` SET TAGS ('dbx_business_glossary_term' = 'Simple Payback (Years)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`energy_audit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` SET TAGS ('dbx_subdomain' = 'demand_programs');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `dsm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Demand-Side Management (DSM) Program ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `dsm_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `dsm_program_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|draft|pending');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Program Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `enrollment_capacity_unit` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity Unit (MW or Customer Count)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `enrollment_capacity_unit` SET TAGS ('dbx_value_regex' = 'MW|customers');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `enrollment_capacity_value` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity Value');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `filing_reference` SET TAGS ('dbx_business_glossary_term' = 'FERC/PUC Filing Reference');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `incentive_amount_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount per Megawatt‑Hour (USD/MWh)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `incentive_structure_description` SET TAGS ('dbx_business_glossary_term' = 'Incentive Structure Description');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `lcoe_impact` SET TAGS ('dbx_business_glossary_term' = 'Levelized Cost of Energy (LCOE) Impact (USD/MWh)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Detailed Description');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `program_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Program Status Reason');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type (EE, DR, DER, NEM, TOU, VPP)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'EE|DR|DER|NEM|TOU|VPP');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `puc_approved_budget_amount` SET TAGS ('dbx_business_glossary_term' = 'PUC‑Approved Budget Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|C&I');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` SET TAGS ('dbx_subdomain' = 'demand_programs');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `dr_event_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Event Participation ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `dr_dispatch_event_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Event ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Enrollment ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Program ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `actual_load_kw` SET TAGS ('dbx_business_glossary_term' = 'Actual Load (kW)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `baseline_load_kw` SET TAGS ('dbx_business_glossary_term' = 'Baseline Load (kW)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `curtailment_performance_pct` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Performance Percentage');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `customer_ack_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Acknowledgment Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `event_notification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Notification Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `incentive_earned_usd` SET TAGS ('dbx_business_glossary_term' = 'Incentive Earned (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `measured_curtailment_kw` SET TAGS ('dbx_business_glossary_term' = 'Measured Curtailment (kW)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Participation Notes');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `participation_type` SET TAGS ('dbx_business_glossary_term' = 'Participation Type');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `participation_type` SET TAGS ('dbx_value_regex' = 'voluntary|mandatory');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `penalty_assessed_usd` SET TAGS ('dbx_business_glossary_term' = 'Penalty Assessed (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `performance_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `performance_status` SET TAGS ('dbx_value_regex' = 'compliant|non-compliant|excused|no-show');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|settled|rejected');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dr_event_participation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` SET TAGS ('dbx_subdomain' = 'demand_programs');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `vpp_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Virtual Power Plant Agreement ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `aggregator_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregator ID (AGGREGATOR_ID)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUSTOMER_ID)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CUSTOMER_ID)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number (AGREEMENT_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status (AGREEMENT_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending|active|suspended|terminated|expired');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `agreement_term_months` SET TAGS ('dbx_business_glossary_term' = 'Agreement Term (AGREEMENT_TERM_MONTHS)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type (AGREEMENT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'direct_customer|aggregator_mediated');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `capacity_payment_usd_per_kw_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Payment (USD per kW‑month) (CAPACITY_PAYMENT_USD_PER_KW_MONTH)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version (CONTRACT_VERSION)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `der_asset_types` SET TAGS ('dbx_business_glossary_term' = 'DER Asset Types (DER_ASSET_TYPES)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `dispatch_protocol` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Protocol (DISPATCH_PROTOCOL)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `dispatch_protocol` SET TAGS ('dbx_value_regex' = 'automated_derms|manual_notification');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `dr_participation` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Participation (DR_PARTICIPATION)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_END_DATE)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START_DATE)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `energy_payment_usd_per_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Payment (USD per kWh) (ENERGY_PAYMENT_USD_PER_KWH)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `exclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Agreement Flag (EXCLUSIVE_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `ferc_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'FERC Filing Reference (FERC_FILING_REFERENCE)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (GEOGRAPHIC_REGION)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `geographic_region` SET TAGS ('dbx_value_regex' = '[A-Z]{3}');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `max_dispatch_power_kw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Dispatch Power (kW) (MAX_DISPATCH_POWER_KW)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `min_dispatch_power_kw` SET TAGS ('dbx_business_glossary_term' = 'Minimum Dispatch Power (kW) (MIN_DISPATCH_POWER_KW)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes (AGREEMENT_NOTES)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `puc_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'PUC Filing Reference (PUC_FILING_REFERENCE)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `rec_eligible` SET TAGS ('dbx_business_glossary_term' = 'REC Eligibility (REC_ELIGIBLE)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `renewable_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Resource Flag (RENEWABLE_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Time Requirement (RESPONSE_TIME_MINUTES)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `settlement_market` SET TAGS ('dbx_business_glossary_term' = 'Settlement Market (SETTLEMENT_MARKET)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `settlement_market` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|both');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date (SIGNED_DATE)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TERMINATION_DATE)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERMINATION_REASON)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `total_committed_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Total Committed Capacity (kW) (TOTAL_COMMITTED_CAPACITY_KW)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`vpp_agreement` ALTER COLUMN `vpp_program_name` SET TAGS ('dbx_business_glossary_term' = 'VPP Program Name (VPP_PROGRAM_NAME)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `large_customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Large Customer Contract ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Portfolio Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `confidentiality_clause_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Clause Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `contract_approved_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approved Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `contract_signed_by` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed By');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `contract_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Status Reason');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `contract_term_years` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Years)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `contract_termination_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Termination Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'economic_development|interruptible|standby|co_generation|custom');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_business_glossary_term' = 'Contract Value (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `demand_charge_structure` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Structure');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `discount_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate Percent');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `discount_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `energy_charge_structure` SET TAGS ('dbx_business_glossary_term' = 'Energy Charge Structure');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `escalation_clause_description` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause Description');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `ferc_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'FERC Filing Reference');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `large_customer_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `large_customer_contract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|draft');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `minimum_bill_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Bill Commitment (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `minimum_bill_commitment` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `puc_approval_status` SET TAGS ('dbx_business_glossary_term' = 'PUC Approval Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `puc_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `renewal_term_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Years)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `special_conditions` SET TAGS ('dbx_business_glossary_term' = 'Special Contract Conditions');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`large_customer_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `crm_interaction_id` SET TAGS ('dbx_business_glossary_term' = 'CRM Interaction ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Recorder Employee ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `gridops_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `kam_key_account_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Key Account Manager ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `key_account_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Key Account Manager ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Related Case ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Der Resource Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Outage Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Interaction Channel');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'in_person|virtual|phone|email|other');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `compliance_review_status` SET TAGS ('dbx_value_regex' = 'pending|completed|exempt');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `escalation_reason` SET TAGS ('dbx_business_glossary_term' = 'Escalation Reason');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `facility_area_inspected` SET TAGS ('dbx_business_glossary_term' = 'Facility Area Inspected');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `feedback_comments` SET TAGS ('dbx_business_glossary_term' = 'Feedback Comments');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `feedback_score` SET TAGS ('dbx_business_glossary_term' = 'Feedback Score');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Due Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `interaction_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `interaction_priority` SET TAGS ('dbx_business_glossary_term' = 'Interaction Priority');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `interaction_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'logged|reviewed|closed');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `is_escalated` SET TAGS ('dbx_business_glossary_term' = 'Escalated Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Interaction Outcome');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'completed|pending|cancelled|no_response|rescheduled');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `recorded_by` SET TAGS ('dbx_business_glossary_term' = 'Recorded By');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `site_conditions_noted` SET TAGS ('dbx_business_glossary_term' = 'Site Conditions Noted');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `summary_notes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Summary Notes');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `system_activity_code` SET TAGS ('dbx_business_glossary_term' = 'System Activity ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`crm_interaction` ALTER COLUMN `visit_location` SET TAGS ('dbx_business_glossary_term' = 'Visit Location');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Satisfaction Survey ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent Identifier');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Respondent Identifier');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `billing_accuracy_rating` SET TAGS ('dbx_business_glossary_term' = 'Billing Accuracy Rating (1-10)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Verbatim Comments');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `confidentiality_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_business_glossary_term' = 'Survey Delivery Channel');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `delivery_channel` SET TAGS ('dbx_value_regex' = 'email|phone|online_portal|mail');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `follow_up_action_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑up Action Due Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `follow_up_action_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑up Action Required Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `kam_responsiveness_rating` SET TAGS ('dbx_business_glossary_term' = 'Key Account Manager Responsiveness Rating (1-10)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `nps_score` SET TAGS ('dbx_business_glossary_term' = 'Net Promoter Score (NPS) (Scale -100 to 100)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `overall_satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Satisfaction Score (1-10)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `program_value_rating` SET TAGS ('dbx_business_glossary_term' = 'Program Value Rating (1-10)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Inclusion Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `respondent_name` SET TAGS ('dbx_business_glossary_term' = 'Respondent Full Name');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `respondent_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `respondent_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `respondent_role` SET TAGS ('dbx_business_glossary_term' = 'Respondent Role');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `respondent_role` SET TAGS ('dbx_value_regex' = 'end_user|account_manager|technical_contact');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `response_time_minutes` SET TAGS ('dbx_business_glossary_term' = 'Response Time (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `satisfaction_survey_status` SET TAGS ('dbx_value_regex' = 'pending|completed|reviewed|closed');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `service_reliability_rating` SET TAGS ('dbx_business_glossary_term' = 'Service Reliability Rating (1-10)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `survey_code` SET TAGS ('dbx_business_glossary_term' = 'Survey Code (SURV_CODE)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `survey_code` SET TAGS ('dbx_value_regex' = '^SURV-d{6}$');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `survey_language` SET TAGS ('dbx_business_glossary_term' = 'Survey Language');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `survey_language` SET TAGS ('dbx_value_regex' = 'en|es|fr');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `survey_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Conducted Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type (e.g., Annual Key Account, Post Interaction, Post Outage, Program Exit)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'annual_key_account|post_interaction|post_outage|program_exit');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `survey_version` SET TAGS ('dbx_business_glossary_term' = 'Survey Version Identifier');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `survey_version` SET TAGS ('dbx_value_regex' = '^vd+.d+$');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`satisfaction_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `engagement_account_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Account Plan Identifier (APID)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `aggregation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Identifier (PO_ID)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `key_account_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Plan Owner Identifier (PO_ID)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Tier (AT)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `account_tier` SET TAGS ('dbx_value_regex' = 'strategic|key|mid|small');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (AS)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (AB)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date (AD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `budget_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Budget Amount (USD) (BA_USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `capital_investment_opportunities` SET TAGS ('dbx_business_glossary_term' = 'Capital Investment Opportunities (CIO)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `competitive_threats` SET TAGS ('dbx_business_glossary_term' = 'Competitive Threats (CT)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CC)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `der_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'DER Participation Flag (DERPF)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `dr_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Participation Flag (DRPF)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `ee_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Participation Flag (EEPF)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `expected_annual_savings_usd` SET TAGS ('dbx_business_glossary_term' = 'Expected Annual Savings (USD) (EAS_USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `identified_risks` SET TAGS ('dbx_business_glossary_term' = 'Identified Risks (IR)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LRD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `load_growth_target_kw` SET TAGS ('dbx_business_glossary_term' = 'Load Growth Target (kW) (LGT_KW)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `load_reduction_target_kw` SET TAGS ('dbx_business_glossary_term' = 'Load Reduction Target (kW) (LRT_KW)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Review Date (NRD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes (PN)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status (PS)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|on_hold|closed');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type (PT)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'growth|retention|new_business|risk_mitigation');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Plan Year (PY)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `planned_touchpoints` SET TAGS ('dbx_business_glossary_term' = 'Planned Touchpoints (PT)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `program_enrollment_target_der` SET TAGS ('dbx_business_glossary_term' = 'DER Enrollment Target (DER_ET)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `program_enrollment_target_dr` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Enrollment Target (DR_ET)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `program_enrollment_target_ee` SET TAGS ('dbx_business_glossary_term' = 'Energy Efficiency Enrollment Target (EE_ET)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `revenue_retention_target_usd` SET TAGS ('dbx_business_glossary_term' = 'Revenue Retention Target (USD) (RRT_USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RR)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `strategic_objectives` SET TAGS ('dbx_business_glossary_term' = 'Strategic Objectives (SO)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment (TCS)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_value_regex' = 'industrial|commercial|municipal|residential');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`engagement_account_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VN)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` SET TAGS ('dbx_subdomain' = 'demand_programs');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `dsm_incentive_payment_id` SET TAGS ('dbx_business_glossary_term' = 'DSM Incentive Payment ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `amount_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Incentive Adjustment Amount');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Incentive Amount');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Incentive Amount');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'kwh_saved|kw_curtailed|usd_per_kw_month');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `calculation_value` SET TAGS ('dbx_business_glossary_term' = 'Calculation Value');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `dsm_incentive_payment_description` SET TAGS ('dbx_business_glossary_term' = 'Payment Description');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `external_payment_reference` SET TAGS ('dbx_business_glossary_term' = 'External Payment ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Fee Amount');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `payment_batch_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'bill_credit|check|ach');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|issued|reversed');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Type');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `payment_type` SET TAGS ('dbx_value_regex' = 'rebate|performance|capacity|installation');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `reporting_period` SET TAGS ('dbx_business_glossary_term' = 'Reporting Period');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`dsm_incentive_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` SET TAGS ('dbx_subdomain' = 'customer_engagement');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `outreach_campaign_id` SET TAGS ('dbx_business_glossary_term' = 'Outreach Campaign ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `digital_platform_id` SET TAGS ('dbx_business_glossary_term' = 'Digital Platform Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `key_account_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Campaign Owner ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `actual_spend_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Campaign Spend (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `budget_usd` SET TAGS ('dbx_business_glossary_term' = 'Campaign Budget (USD)');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `campaign_code` SET TAGS ('dbx_business_glossary_term' = 'Campaign Code');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_business_glossary_term' = 'Campaign Type');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `campaign_type` SET TAGS ('dbx_value_regex' = 'dr_recruitment|energy_efficiency|tou_migration|vpp_enrollment|rate_change|executive_briefing');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Campaign Channel');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'email|direct_mail|phone|event|digital|social_media');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `contacted_account_count` SET TAGS ('dbx_business_glossary_term' = 'Contacted Account Count');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign End Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `enrollment_conversion_count` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Conversion Count');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System ID');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `is_test_campaign` SET TAGS ('dbx_business_glossary_term' = 'Test Campaign Flag');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `outreach_campaign_description` SET TAGS ('dbx_business_glossary_term' = 'Campaign Description');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `outreach_campaign_name` SET TAGS ('dbx_business_glossary_term' = 'Campaign Name');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `outreach_campaign_status` SET TAGS ('dbx_business_glossary_term' = 'Campaign Status');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `outreach_campaign_status` SET TAGS ('dbx_value_regex' = 'planned|active|completed|cancelled|paused');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `response_count` SET TAGS ('dbx_business_glossary_term' = 'Response Count');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `segment_criteria` SET TAGS ('dbx_business_glossary_term' = 'Target Segment Criteria');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Campaign Start Date');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `target_account_count` SET TAGS ('dbx_business_glossary_term' = 'Target Account Count');
ALTER TABLE `power_and_utilities_v2`.`engagement`.`outreach_campaign` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
