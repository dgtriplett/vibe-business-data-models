-- Schema for Domain: customer | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`customer` COMMENT 'Single source of truth for all customer identities serving residential, commercial, and industrial (RCI) segments. Manages customer profiles, service addresses, account relationships, premise and service point associations, enrollment lifecycle, contact preferences, and customer segmentation. Integrates with Oracle CC&B (CIS) and Salesforce CRM. Supports NEM, TOU, and DR program enrollment.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`customer_account` (
    `customer_account_id` BIGINT COMMENT 'Primary key for account',
    `it_asset_id` BIGINT COMMENT 'System-generated unique identifier for the customer account record.',
    `segment_id` BIGINT COMMENT 'Foreign key linking to customer.segment. Business justification: Customer account is classified by a segment; using a foreign key enables consistent segment taxonomy and eliminates the free‑text segment column.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Supports Account Management process; each account is assigned an employee manager for billing and service oversight.',
    `parent_account_customer_account_id` BIGINT COMMENT 'Identifier of the parent (master) account for corporate or group accounts.',
    `rate_case_id` BIGINT COMMENT 'Identifier of the rate case or filing that governs the accounts tariffs.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Billing process assigns a default rate schedule to each account for tariff calculation; utility experts expect an account-level rate_schedule_id to drive billing and regulatory reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue GL account needed for posting account‑level sales revenue in monthly financial statements; utility accountants require this link for accurate revenue recognition.',
    `account_number` STRING COMMENT 'External account number assigned by the CIS system for billing and service operations.',
    `account_type` STRING COMMENT 'Indicates whether the account is for electric service, gas service, or dual‑fuel.. Valid values are `electric|gas|dual_fuel`',
    `billing_address_line1` STRING COMMENT 'First line of the billing address associated with the account.',
    `billing_address_line2` STRING COMMENT 'Second line of the billing address (if applicable).',
    `billing_city` STRING COMMENT 'City component of the billing address.',
    `billing_country` STRING COMMENT 'ISO‑3 country code of the billing address.',
    `billing_state` STRING COMMENT 'State or province component of the billing address.',
    `billing_zip` STRING COMMENT 'Postal code of the billing address.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the account record was first created in the system.',
    `credit_class` STRING COMMENT 'Credit classification used for billing risk and payment terms.. Valid values are `A|B|C|D|E`',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount authorized for the account.',
    `current_balance` DECIMAL(18,2) COMMENT 'Outstanding monetary balance as of the most recent billing cycle.',
    `customer_account_status` STRING COMMENT 'Current lifecycle status of the account as defined by regulatory and business rules.. Valid values are `active|inactive|suspended|closed|pending`',
    `delinquency_status` STRING COMMENT 'Indicator of the accounts delinquency level for collections.. Valid values are `none|late|serious|collections`',
    `demand_response_enrolled` BOOLEAN COMMENT 'True if the account is enrolled in a demand‑response program.',
    `effective_from` DATE COMMENT 'Date the account became effective for service delivery.',
    `effective_until` DATE COMMENT 'Date the account is scheduled to terminate or be de‑activated (null if open‑ended).',
    `language_preference` STRING COMMENT 'Preferred language for communications and billing.. Valid values are `en|es|fr|de|zh|other`',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received for the account.',
    `net_metering_flag` BOOLEAN COMMENT 'Indicates if the account participates in a net‑metering program.',
    `payment_method` STRING COMMENT 'Default method used for paying the account balance.. Valid values are `credit_card|bank_transfer|check|cash|online|other`',
    `payment_status` STRING COMMENT 'Current status of the most recent payment transaction.. Valid values are `paid|unpaid|partial|failed|pending`',
    `preferred_contact_method` STRING COMMENT 'Channel the customer prefers for receiving notifications.. Valid values are `email|phone|mail|sms|portal|other`',
    `primary_contact_name` STRING COMMENT 'Legal name of the primary contact person for the account.',
    `primary_email` STRING COMMENT 'Email address used for primary communications with the account holder.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_phone` STRING COMMENT 'Primary telephone number for the account holder.',
    `regulatory_account_flag` BOOLEAN COMMENT 'Indicates the account is subject to special regulatory reporting (e.g., rate case).',
    `tax_exempt_flag` BOOLEAN COMMENT 'True if the account is exempt from sales tax per regulatory rules.',
    `time_of_use_enrolled` BOOLEAN COMMENT 'True if the account is on a time‑of‑use rate schedule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the account record.',
    CONSTRAINT pk_customer_account PRIMARY KEY(`customer_account_id`)
) COMMENT 'Core master entity representing a customer account in Oracle CC&B (CIS). Serves as the SSOT for all customer account identities and relationships across residential, commercial, and industrial (RCI) segments. Captures account type (electric, gas, dual-fuel), account status lifecycle (active, pending, suspended, closed, written-off), credit class, account open/close dates, CIS account number, Salesforce account ID, and billing address of record. The primary anchor entity for billing, metering, service delivery, and collections relationships. Supports account status history tracking for regulatory audit trails required by state PUC rules.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`person` (
    `person_id` BIGINT COMMENT 'Unique surrogate key for the person record.',
    `address_line1` STRING COMMENT 'First line of the persons primary mailing address.',
    `address_line2` STRING COMMENT 'Second line of the mailing address, if applicable.',
    `city` STRING COMMENT 'City component of the primary address.',
    `country_code` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code for the primary address.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the person record was first created in the system.',
    `customer_segment` STRING COMMENT 'Market segment the person belongs to based on the accounts they are linked to.. Valid values are `residential|commercial|industrial`',
    `date_of_birth` DATE COMMENT 'Birth date of the individual, used for age verification and regulatory compliance.',
    `do_not_call_flag` BOOLEAN COMMENT 'Indicates whether the person has opted out of telephonic marketing.',
    `email_address` STRING COMMENT 'Primary email address for electronic communication with the person.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `first_name` STRING COMMENT 'Given name of the individual.',
    `full_name` STRING COMMENT 'Complete legal name of the person as it appears on official documents.',
    `gender` STRING COMMENT 'Self‑identified gender of the person.. Valid values are `male|female|nonbinary|unspecified`',
    `government_id_number` STRING COMMENT 'Masked value of the government‑issued identifier (e.g., SSN, passport number).. Valid values are `^[A-Z0-9]{5,20}$`',
    `government_id_type` STRING COMMENT 'Type of government‑issued identifier supplied by the person.. Valid values are `SSN|TIN|Passport|DriverLicense`',
    `language_preference` STRING COMMENT 'Preferred language for communications.. Valid values are `en|es|fr|de|zh`',
    `last_name` STRING COMMENT 'Family name (surname) of the individual.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the person record.',
    `marketing_opt_in` BOOLEAN COMMENT 'Indicates whether the person has consented to receive marketing communications.',
    `middle_name` STRING COMMENT 'Middle name or initial of the individual, if any.',
    `mobile_number` STRING COMMENT 'Mobile/cell phone number for SMS or voice contact.. Valid values are `^+?[0-9]{10,15}$`',
    `person_status` STRING COMMENT 'Current lifecycle status of the person record.. Valid values are `active|inactive|suspended|deceased|pending`',
    `person_type` STRING COMMENT 'Classification of the person relative to the utility (e.g., customer, authorized contact).. Valid values are `customer|authorized_contact|guarantor|employee|vendor`',
    `phone_number` STRING COMMENT 'Primary landline phone number.. Valid values are `^+?[0-9]{10,15}$`',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the primary address.',
    `preferred_contact_method` STRING COMMENT 'Persons preferred channel for outreach.. Valid values are `email|phone|mail|sms`',
    `privacy_consent_timestamp` TIMESTAMP COMMENT 'When the person provided consent for data processing under privacy regulations.',
    `state_province` STRING COMMENT 'State or province component of the primary address.',
    `tax_identifier` STRING COMMENT 'Taxpayer identification number (e.g., SSN, EIN) used for billing and regulatory reporting.. Valid values are `^[A-Z0-9]{5,20}$`',
    `verification_method` STRING COMMENT 'Method used to verify the persons identity.. Valid values are `document|knowledge_based|biometric`',
    `verification_status` STRING COMMENT 'Result of identity verification processes.. Valid values are `unverified|verified|pending`',
    `verification_timestamp` TIMESTAMP COMMENT 'Date and time when verification was completed.',
    CONSTRAINT pk_person PRIMARY KEY(`person_id`)
) COMMENT 'Master identity record for individual persons associated with customer accounts, including residential customers, authorized contacts, and guarantors. Captures legal name, date of birth, government ID type and masked number, language preference, and identity verification status. Distinct from the account entity — a single person may hold multiple accounts. Sourced from Oracle CC&B and Salesforce CRM.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`business_entity` (
    `business_entity_id` BIGINT COMMENT 'System-generated unique identifier for the business entity record.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Linking corporate entity to its chart of accounts supports consolidated financial statement generation and audit trail required by SEC and FERC reporting.',
    `parent_company_business_entity_id` BIGINT COMMENT 'Identifier of the parent organization, if this entity is a subsidiary.',
    `annual_revenue` DECIMAL(18,2) COMMENT 'Reported annual revenue of the organization in USD.',
    `business_entity_status` STRING COMMENT 'Current operational status of the business entity.. Valid values are `active|inactive|suspended|pending|closed`',
    `business_type` STRING COMMENT 'Legal structure of the organization.. Valid values are `corporation|llc|government|nonprofit|partnership`',
    `city` STRING COMMENT 'City of the primary address.',
    `compliance_status` STRING COMMENT 'Current compliance standing with regulatory requirements.. Valid values are `compliant|non_compliant|under_review`',
    `country` STRING COMMENT 'Country code of the primary address.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the record was first created in the system.',
    `credit_rating` STRING COMMENT 'External credit rating assigned to the organization. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — promote to reference product]',
    `dba_name` STRING COMMENT 'Trade name under which the organization operates, if different from the legal name.',
    `duns_number` STRING COMMENT 'Nine‑digit unique identifier for the organization in the D&B database.. Valid values are `^d{9}$`',
    `effective_end_date` DATE COMMENT 'Date when the entity ceased to be effective; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the entity became effective for business purposes.',
    `external_reference_code` STRING COMMENT 'Identifier used in external partner systems to reference this entity.',
    `industry_classification` STRING COMMENT 'Textual description of the industry segment, often mirroring NAICS.',
    `is_key_account` BOOLEAN COMMENT 'Flag indicating whether the organization is a strategic key account.',
    `is_tax_exempt` BOOLEAN COMMENT 'Indicates whether the organization is exempt from sales tax.',
    `last_annual_review_date` DATE COMMENT 'Date of the most recent annual business review.',
    `last_compliance_audit_date` DATE COMMENT 'Date of the most recent compliance audit.',
    `legal_name` STRING COMMENT 'Full legal name of the commercial or industrial organization as registered with the state.',
    `lifecycle_stage` STRING COMMENT 'Stage of the entity within its relationship lifecycle.. Valid values are `prospect|active|terminated|archived`',
    `market_region` STRING COMMENT 'Primary geographic market region where the organization operates.. Valid values are `northeast|midwest|south|west`',
    `naics_code` STRING COMMENT 'Primary NAICS code describing the industry sector of the organization.',
    `notes` STRING COMMENT 'Additional remarks or comments about the entity.',
    `number_of_employees` STRING COMMENT 'Total headcount of the organization.',
    `oracle_cis_account_code` STRING COMMENT 'Unique account identifier from Oracle Customer Care and Billing.',
    `postal_code` STRING COMMENT 'ZIP or postal code of the primary address.. Valid values are `^d{5}(-d{4})?$`',
    `preferred_contact_method` STRING COMMENT 'Preferred channel for contacting the organization.. Valid values are `email|phone|mail|portal`',
    `preferred_language` STRING COMMENT 'Language preferred for communications.. Valid values are `en|es|fr|de|zh`',
    `primary_address_line1` STRING COMMENT 'First line of the organization’s primary mailing address.',
    `primary_address_line2` STRING COMMENT 'Second line of the organization’s primary mailing address, if applicable.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the main point of contact for the organization.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact.. Valid values are `^+?[0-9]{7,15}$`',
    `registration_date` DATE COMMENT 'Date the organization was first registered in the utility’s system.',
    `risk_score` STRING COMMENT 'Internal risk rating assigned to the organization (higher = higher risk).',
    `salesforce_account_code` STRING COMMENT 'Unique account identifier from Salesforce CRM.',
    `state` STRING COMMENT 'State or province of the primary address.',
    `subsidiary_count` STRING COMMENT 'Number of subsidiary entities owned by this organization.',
    `tax_exempt_reason` STRING COMMENT 'Reason or statutory basis for tax exemption, if applicable.',
    `tax_id_ein` STRING COMMENT 'Federal tax identification number assigned to the organization by the IRS.. Valid values are `^d{2}-d{7}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the record.',
    CONSTRAINT pk_business_entity PRIMARY KEY(`business_entity_id`)
) COMMENT 'Master record for commercial and industrial (C&I) customer organizations including corporations, LLCs, government agencies, and non-profits. Captures legal business name, DBA name, federal tax ID (EIN), NAICS industry code, business type, Dun & Bradstreet number, Salesforce account ID, and credit rating. Supports large commercial and key account management workflows distinct from residential person records.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`premise` (
    `premise_id` BIGINT COMMENT 'Unique system-generated identifier for the premise (service location).',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Regulatory service‑location reporting requires linking each premise to its land parcel for tax, compliance, and outage management.',
    `address_line1` STRING COMMENT 'Primary street address of the premise.',
    `address_line2` STRING COMMENT 'Secondary address information (apartment, suite, etc.).',
    `census_tract` STRING COMMENT 'Census tract identifier for demographic and regulatory reporting.',
    `city` STRING COMMENT 'Municipality where the premise is located.',
    `construction_type` STRING COMMENT 'Physical construction classification of the building.. Valid values are `new|existing|renovated|modular|prefab`',
    `county` STRING COMMENT 'County name or code for the premise location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the premise record was first created in the system.',
    `dwelling_units` STRING COMMENT 'Count of separate residential units on the premise.',
    `effective_from` DATE COMMENT 'Date when the premise became active for service.',
    `effective_until` DATE COMMENT 'Date when the premise service is scheduled to end or be retired (null if open‑ended).',
    `gis_feature_code` BIGINT COMMENT 'Unique identifier for the premise feature in the ArcGIS spatial database.',
    `installation_date` DATE COMMENT 'Date the meter was installed at the premise.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the premise.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the premise in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the premise in decimal degrees.',
    `lot_size_sqft` DECIMAL(18,2) COMMENT 'Total land area of the premise in square feet.',
    `meter_installed_flag` BOOLEAN COMMENT 'True if an electric/gas meter is installed at the premise.',
    `meter_serial_number` STRING COMMENT 'Manufacturer serial number of the installed meter.',
    `meter_type` STRING COMMENT 'Classification of the meter technology.. Valid values are `electric|gas|dual|none`',
    `premise_status` STRING COMMENT 'Current operational status of the premise.. Valid values are `active|inactive|pending|decommissioned`',
    `premise_type` STRING COMMENT 'Classification of the premise by usage category.. Valid values are `residential|commercial|industrial|agricultural`',
    `property_owner_name` STRING COMMENT 'Legal name of the individual or organization that owns the property.',
    `regulatory_zone` STRING COMMENT 'Regulatory service zone or jurisdiction applicable to the premise.',
    `service_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the premise is eligible for utility service (true) or excluded (false).',
    `state` STRING COMMENT 'Two‑letter US state abbreviation for the premise location. [ENUM-REF-CANDIDATE: AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY — promote to reference product]',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the premise record.',
    `zip_plus4` STRING COMMENT 'Postal code (ZIP+4) for the premise.. Valid values are `^d{5}(-d{4})?$`',
    CONSTRAINT pk_premise PRIMARY KEY(`premise_id`)
) COMMENT 'Physical location (property) at which utility service is delivered. Represents the geographic and structural unit of service delivery — a building, parcel, or metered location. Captures street address, city, state, ZIP+4, county, census tract, GIS coordinates (latitude/longitude), premise type (residential, commercial, industrial, agricultural), construction type, lot size, number of dwelling units, and ArcGIS feature ID. Serves as the SSOT for service location geography shared with the distribution and metering domains. Supports service territory eligibility validation and regulatory reporting by geographic boundary.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` (
    `customer_service_point_id` BIGINT COMMENT 'Unique identifier for the service point.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Outage Management requires mapping each service point to its primary distribution asset (transformer/pole) for impact analysis and maintenance planning.',
    `circuit_feeder_id` BIGINT COMMENT 'Identifier of the distribution circuit serving the service point.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Assigning each service point to a cost center enables allocation of maintenance and operation expenses to the correct cost center for regulatory cost‑of‑service reporting.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Required for Service Point Maintenance Assignment; dispatch uses primary crew per service point for outage response and scheduled work.',
    `feeder_id` BIGINT COMMENT 'Identifier of the feeder line within the circuit.',
    `meter_id` BIGINT COMMENT 'Identifier of the current meter associated with the service point.',
    `ot_asset_id` BIGINT COMMENT 'Foreign key linking to technology.ot_asset. Business justification: OT Asset Maintenance process requires associating each operational asset with the service point it serves for outage response.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Service point belongs to a physical premise; linking provides a single source of address data and removes duplicated address columns from service_point.',
    `service_plan_id` BIGINT COMMENT 'Foreign key linking to product.service_plan. Business justification: Operations track which service plan (pricing structure, contract terms) applies to each service point; required for outage management, demand response enrollment, and compliance reporting.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Needed for assigning a primary field technician for meter reading and service visits; utility schedules technicians per service point.',
    `vpp_agreement_id` BIGINT COMMENT 'Foreign key linking to engagement.vpp_agreement. Business justification: Virtual Power Plant agreements are executed per service point where DER assets are connected; the link supports dispatch and settlement reporting.',
    `asset_tag` STRING COMMENT 'Internal asset tag used for maintenance tracking.',
    `commodity_type` STRING COMMENT 'Indicates whether the service point provides electricity or natural gas.. Valid values are `electric|gas`',
    `connection_type` STRING COMMENT 'Physical method of connecting the service point to the distribution network.. Valid values are `overhead|underground|subterranean`',
    `country_code` STRING COMMENT 'Three-letter ISO country code of the service point location.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service point record was created in the system.',
    `enrollment_dr` BOOLEAN COMMENT 'Indicates participation in Demand Response programs.',
    `enrollment_nem` BOOLEAN COMMENT 'Indicates participation in Net Energy Metering program.',
    `enrollment_tou` BOOLEAN COMMENT 'Indicates participation in Time-of-Use pricing program.',
    `estimated_annual_consumption_kwh` DECIMAL(18,2) COMMENT 'Projected annual electricity consumption for planning.',
    `estimated_annual_consumption_mcf` DECIMAL(18,2) COMMENT 'Projected annual natural gas consumption.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the service point.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the service point.',
    `load_profile_type` STRING COMMENT 'Load shape used for billing and demand response.. Valid values are `flat|time_of_use|critical_peak|real_time_pricing`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the service point.',
    `meter_installation_date` DATE COMMENT 'Date the current meter was installed at the service point.',
    `meter_serial_number` STRING COMMENT 'Serial number of the meter device.',
    `notes` STRING COMMENT 'Free-text field for additional remarks about the service point.',
    `outage_history_flag` BOOLEAN COMMENT 'Indicates if outage history is recorded for this service point.',
    `phase_configuration` STRING COMMENT 'Electrical phase configuration of the service point.. Valid values are `single|split|three`',
    `rate_schedule_code` STRING COMMENT 'Code of the rate schedule applied to the service point.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates if the service point meets current regulatory requirements.',
    `service_class` STRING COMMENT 'Classification of the service point based on customer segment.. Valid values are `residential|commercial|industrial`',
    `service_end_date` DATE COMMENT 'Date the service point was disconnected or decommissioned.',
    `service_point_number` STRING COMMENT 'External reference number for the service point used in CIS.',
    `service_start_date` DATE COMMENT 'Date the service point was first energized for the customer.',
    `service_status` STRING COMMENT 'Current operational status of the service point.. Valid values are `active|inactive|suspended|pending|decommissioned`',
    `status_effective_date` DATE COMMENT 'Date when the current service status became effective.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the service point record.',
    `voltage_class` STRING COMMENT 'Voltage level of the service point connection.. Valid values are `low|medium|high|extra_high`',
    CONSTRAINT pk_customer_service_point PRIMARY KEY(`customer_service_point_id`)
) COMMENT 'Logical utility service delivery point at a premise representing the connection between the distribution network and the customer. Each service point is associated with a commodity type (electric or gas), service voltage class, load profile type, and distribution circuit. Links the premise to the meter and to the rate schedule. Sourced from Oracle CC&B and GE PowerOn DMS. Distinct from the meter device itself — a service point may have multiple meters over its lifetime. The anchor entity for usage measurement and service delivery at a specific physical connection.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`service_agreement` (
    `service_agreement_id` BIGINT COMMENT 'Primary key for service_agreement',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with the agreement.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer (person or organization) owning the agreement.',
    `distribution_service_point_id` BIGINT COMMENT 'Identifier of the physical service point (meter location) linked to the agreement.',
    `meter_id` BIGINT COMMENT 'FK to metering.meter',
    `person_id` BIGINT COMMENT 'Identifier of the customer (person or organization) owning the agreement.',
    `rate_schedule_id` BIGINT COMMENT 'FK to product.rate_schedule',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Service agreements must reference the approved regulatory tariff schedule that governs rates; this link enables rate compliance reporting.',
    `customer_service_point_id` BIGINT COMMENT 'FK to distribution.service_point.service_point_id — Customer service agreements are delivered at a physical service point on the distribution network. This FK links customer contracts to physical infrastructure for outage impact analysis.',
    `agreement_number` STRING COMMENT 'External contract number assigned by the utility for the service agreement.',
    `agreement_type` STRING COMMENT 'Classification of the agreement based on customer segment or purpose.. Valid values are `residential|commercial|industrial|government|other`',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether the agreement automatically renews at the end of its term.',
    `billing_cycle` STRING COMMENT 'Frequency at which the customer is billed.. Valid values are `monthly|bimonthly|quarterly|semiannual|annual`',
    `billing_method` STRING COMMENT 'Preferred method for delivering bills and receiving payments.. Valid values are `paper|e_bill|auto_debit|direct_deposit`',
    `commodity_type` STRING COMMENT 'Energy commodity supplied under the agreement.. Valid values are `electric|gas|dual`',
    `contract_end_date` DATE COMMENT 'Date the service agreement terminates or expires; null for open‑ended contracts.',
    `contract_start_date` DATE COMMENT 'Date the service agreement becomes effective.',
    `contract_term_months` STRING COMMENT 'Length of the contract in months.',
    `contract_term_years` STRING COMMENT 'Length of the contract in years.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the service agreement record was first created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit extended to the customer under this agreement.',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Security deposit required for the agreement, if any.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee charged if the agreement is terminated before the contractual end date.',
    `enrollment_programs` STRING COMMENT 'Pipe‑separated list of demand‑side programs the customer is enrolled in.. Valid values are `NEM|TOU|DR|None`',
    `estimated_annual_usage_mwh` DECIMAL(18,2) COMMENT 'Projected annual electricity consumption, expressed in megawatt‑hours.',
    `estimated_monthly_usage_kwh` DECIMAL(18,2) COMMENT 'Projected electricity consumption for the agreement period, expressed in kilowatt‑hours.',
    `is_primary_agreement` BOOLEAN COMMENT 'True if this agreement is the primary contract for the customer at the service point.',
    `last_bill_date` DATE COMMENT 'Date of the most recent bill issued under this agreement.',
    `meter_read_cycle_days` STRING COMMENT 'Number of days between successive meter reads.',
    `meter_type` STRING COMMENT 'Technology type of the meter.. Valid values are `analog|digital|ami`',
    `net_metering_flag` BOOLEAN COMMENT 'True if the customer participates in net‑metering arrangements.',
    `next_bill_date` DATE COMMENT 'Scheduled date for the next billing cycle.',
    `notes` STRING COMMENT 'Free‑form text for internal comments or special conditions.',
    `payment_terms` STRING COMMENT 'Standard payment terms for invoicing.. Valid values are `net30|net45|net60|due_upon_receipt`',
    `rate_category` STRING COMMENT 'Category of the rate schedule (e.g., fixed, variable, TOU).. Valid values are `fixed|variable|time_of_use|demand_response|tiered`',
    `regulatory_rate_code` STRING COMMENT 'Code used for regulatory reporting of the rate applied.',
    `service_agreement_status` STRING COMMENT 'Current lifecycle status of the service agreement.. Valid values are `active|pending|suspended|terminated|closed`',
    `service_class` STRING COMMENT 'Classification of the service based on customer segment.. Valid values are `residential|commercial|industrial|government|other`',
    `service_location_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the service point location.',
    `service_location_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the service point location.',
    `service_status` STRING COMMENT 'Current operational status of the service point.. Valid values are `in_service|out_of_service|planned|decommissioned`',
    `source_system` STRING COMMENT 'System of record that originated the agreement record (e.g., CC&B, Salesforce).',
    `termination_reason` STRING COMMENT 'Reason provided for terminating the agreement, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the service agreement record.',
    `version_number` STRING COMMENT 'Incremental version of the agreement record for change tracking.',
    CONSTRAINT pk_service_agreement PRIMARY KEY(`service_agreement_id`)
) COMMENT 'Active contractual relationship between a customer account and a utility service at a specific service point under a defined rate schedule. Captures service agreement start and end dates, commodity type (electric/gas), rate schedule code, billing cycle, deposit amount, service agreement status (active, pending, stopped), and CIS service agreement ID. Represents the enrollment instance — the binding of account + service point + rate. Distinct from the rate schedule catalog owned by the product domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`contact` (
    `contact_id` BIGINT COMMENT 'Unique identifier for the contact record.',
    `alternate_email` STRING COMMENT 'Secondary email address for the contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `alternate_phone` STRING COMMENT 'Secondary telephone number for the contact.',
    `city` STRING COMMENT 'City component of the mailing address.',
    `consent_bill_ready_email` BOOLEAN COMMENT 'Indicates if the contact has opted‑in to receive bill‑ready notifications via email.',
    `consent_bill_ready_email_timestamp` TIMESTAMP COMMENT 'Timestamp when email consent for bill‑ready notifications was recorded.',
    `consent_dr_event_push` BOOLEAN COMMENT 'Indicates if the contact has opted‑in to receive demand‑response event notifications via mobile push.',
    `consent_dr_event_push_timestamp` TIMESTAMP COMMENT 'Timestamp when push‑notification consent for demand‑response events was recorded.',
    `consent_marketing_email` BOOLEAN COMMENT 'Indicates if the contact has opted‑in to receive marketing communications via email.',
    `consent_marketing_email_timestamp` TIMESTAMP COMMENT 'Timestamp when email consent for marketing communications was recorded.',
    `consent_outage_alert_sms` BOOLEAN COMMENT 'Indicates if the contact has opted‑in to receive outage alerts via SMS.',
    `consent_outage_alert_sms_timestamp` TIMESTAMP COMMENT 'Timestamp when SMS consent for outage alerts was recorded.',
    `consent_payment_confirmation_email` BOOLEAN COMMENT 'Indicates if the contact has opted‑in to receive payment confirmations via email.',
    `consent_payment_confirmation_email_timestamp` TIMESTAMP COMMENT 'Timestamp when email consent for payment confirmations was recorded.',
    `consent_regulatory_notice_mail` BOOLEAN COMMENT 'Indicates if the contact has opted‑in to receive regulatory notices via paper mail.',
    `consent_regulatory_notice_mail_timestamp` TIMESTAMP COMMENT 'Timestamp when mail consent for regulatory notices was recorded.',
    `contact_role` STRING COMMENT 'Business role of the contact relative to the customer account.. Valid values are `primary_holder|co_applicant|authorized_rep|emergency_contact|billing_contact|service_contact`',
    `contact_status` STRING COMMENT 'Current lifecycle status of the contact record.. Valid values are `active|inactive|suspended|pending|deceased`',
    `country_code` STRING COMMENT 'Three‑letter ISO country code for the mailing address.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contact record was first created.',
    `date_of_birth` DATE COMMENT 'Birth date of the individual.',
    `effective_end_date` DATE COMMENT 'Date when the contact ceased to be active; null if still active.',
    `effective_start_date` DATE COMMENT 'Date when the contact became active for the associated account.',
    `email_address` STRING COMMENT 'Primary email address for electronic communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `external_system_code` STRING COMMENT 'Identifier of the contact in an external system such as Salesforce or Oracle CC&B.',
    `first_name` STRING COMMENT 'Given name of the individual.',
    `full_name` STRING COMMENT 'Complete legal name of the individual.',
    `gender` STRING COMMENT 'Self‑identified gender of the individual.. Valid values are `male|female|other|unknown`',
    `language_preference` STRING COMMENT 'Preferred language for communications.. Valid values are `en|es|fr|de|zh|other`',
    `last_name` STRING COMMENT 'Family name (surname) of the individual.',
    `mailing_address_line1` STRING COMMENT 'First line of the mailing address.',
    `mailing_address_line2` STRING COMMENT 'Second line of the mailing address, if needed.',
    `middle_name` STRING COMMENT 'Middle name or initial of the individual, if applicable.',
    `mobile_number` STRING COMMENT 'Mobile telephone number for SMS or push notifications.',
    `notes` STRING COMMENT 'Additional free‑form information about the contact.',
    `phone_number` STRING COMMENT 'Primary telephone number for voice contact.',
    `postal_code` STRING COMMENT 'Postal or ZIP code of the mailing address.',
    `preferred_name` STRING COMMENT 'Name the individual prefers to be called.',
    `primary_contact_method` STRING COMMENT 'Preferred channel for primary communications.. Valid values are `email|phone|mail|sms|mobile_push`',
    `puc_notification_opt_in` BOOLEAN COMMENT 'Indicates if the contact has opted‑in to receive notifications required by the Public Utility Commission.',
    `record_status` STRING COMMENT 'Indicates whether the record is current, historical, or archived.. Valid values are `current|historical|archived`',
    `source_system` STRING COMMENT 'System of record where the contact originated.. Valid values are `oracle_ccb|salesforce|mdm`',
    `state_province` STRING COMMENT 'State or province component of the mailing address.',
    `tcp_a_compliance_flag` BOOLEAN COMMENT 'True if the contacts communication consent complies with the Telephone Consumer Protection Act.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contact record.',
    CONSTRAINT pk_contact PRIMARY KEY(`contact_id`)
) COMMENT 'Master record for individuals associated with a customer account or business entity, encompassing identity, contact methods, communication preferences, and consent management. Captures contact role (primary holder, co-applicant, authorized representative, emergency contact), preferred contact method, phone numbers, email address, mailing address, preferred language, and Salesforce contact ID. Includes per-channel communication preferences and opt-in/opt-out consent flags for each notification category (bill ready, outage alert, payment confirmation, DR event, regulatory notice) across channels (email, SMS, IVR, paper mail, mobile push), with consent timestamps. Supports TCPA compliance, PUC-mandated customer notification requirements, and CRM-driven outreach.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`enrollment` (
    `enrollment_id` BIGINT COMMENT 'System-generated unique identifier for the enrollment record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the account linked to the enrollment.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer associated with the enrollment.',
    `distribution_service_point_id` BIGINT COMMENT 'Identifier of the service point (meter) associated with the enrollment.',
    `person_id` BIGINT COMMENT 'Identifier of the customer associated with the enrollment.',
    `service_agreement_id` BIGINT COMMENT 'Reference to the underlying service agreement governing the enrollment.',
    `annual_true_up_date` DATE COMMENT 'Date of the annual reconciliation for NEM participants.',
    `auto_pay_flag` BOOLEAN COMMENT 'Indicates whether the enrollment includes automatic payment.',
    `auto_pay_method` STRING COMMENT 'Payment method used for auto‑pay enrollments.. Valid values are `credit_card|bank_debit|ach`',
    `calculation_basis` STRING COMMENT 'Method used to calculate the budget billing payment.. Valid values are `fixed|usage_based|tiered`',
    `cancellation_reason` STRING COMMENT 'Reason provided when an enrollment is cancelled.',
    `care_fera_eligibility_flag` BOOLEAN COMMENT 'Indicates eligibility for low‑income assistance programs (CARE/FERA).',
    `care_fera_program_code` STRING COMMENT 'Code of the specific CARE or FERA assistance program.',
    `channel` STRING COMMENT 'Channel through which the customer enrolled.. Valid values are `web|call_center|field|mobile_app`',
    `control_method` STRING COMMENT 'Method used to control load curtailment in DR.. Valid values are `manual|automated|third_party`',
    `cpp_rate_type` STRING COMMENT 'Indicates whether the rate applies to critical or non‑critical periods.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `critical_peak_window` STRING COMMENT 'Time window during which critical peak pricing is in effect.',
    `curtailment_obligation_kw` DECIMAL(18,2) COMMENT 'Obligated reduction capacity for DR events.',
    `effective_date` DATE COMMENT 'Date the enrollment becomes effective and binding.',
    `enrolled_load_kw` DECIMAL(18,2) COMMENT 'Maximum load the customer agrees to curtail under a Demand Response program.',
    `enrollment_date` DATE COMMENT 'Date the enrollment request was received.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment.. Valid values are `active|inactive|cancelled|pending|suspended`',
    `export_limit_kw` DECIMAL(18,2) COMMENT 'Maximum power the system may export to the grid under NEM rules.',
    `inverter_type` STRING COMMENT 'Technology type of the inverter used in the NEM system (e.g., string, micro).',
    `iso_rto_registration_ref` STRING COMMENT 'Reference number for the customers registration with the relevant ISO/RTO.',
    `liheap_assistance_flag` BOOLEAN COMMENT 'Indicates participation in the Low Income Home Energy Assistance Program.',
    `liheap_program_code` STRING COMMENT 'Identifier for the specific LIHEAP assistance program.',
    `monthly_payment_amount` DECIMAL(18,2) COMMENT 'Fixed monthly payment amount for Budget Billing enrollments.',
    `nem_version` STRING COMMENT 'Version of the Net Energy Metering program (e.g., 2.0, 3.0).',
    `notes` STRING COMMENT 'Free-text field for additional remarks or comments.',
    `notification_lead_time_hours` STRING COMMENT 'Minimum notice period required before a DR event dispatch.',
    `offpeak_hours` STRING COMMENT 'Definition of off‑peak time windows for TOU pricing.',
    `paperless_flag` BOOLEAN COMMENT 'Indicates whether the customer opted for paperless billing.',
    `peak_hours` STRING COMMENT 'Definition of peak time windows for TOU pricing (e.g., 16:00‑20:00).',
    `program_code` STRING COMMENT 'External code or identifier for the utility program or tariff rider.',
    `program_description` STRING COMMENT 'Narrative description of the program or tariff rider.',
    `program_type` STRING COMMENT 'Discriminator indicating which program category the enrollment belongs to. [ENUM-REF-CANDIDATE: NEM|DR|BudgetBilling|TOU|CPP|AutoPay|Paperless|CARE|LIHEAP — 9 candidates stripped; promote to reference product]',
    `system_capacity_kw` DECIMAL(18,2) COMMENT 'Installed generation capacity of the customers net‑energy system, applicable to NEM enrollments.',
    `termination_date` DATE COMMENT 'Date the enrollment was terminated or expired, if applicable.',
    `tou_rate_plan_code` STRING COMMENT 'Code identifying the Time‑of‑Use rate plan.',
    `true_up_balance` DECIMAL(18,2) COMMENT 'Outstanding balance after annual true‑up for Budget Billing.',
    `true_up_period_months` STRING COMMENT 'Length of the annual true‑up cycle for NEM settlements.',
    `true_up_review_date` DATE COMMENT 'Date when the true‑up balance is reviewed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    CONSTRAINT pk_enrollment PRIMARY KEY(`enrollment_id`)
) COMMENT 'Unified transactional and master record capturing a customers enrollment, participation, and disenrollment lifecycle in any utility program, tariff rider, or special service offering. Program types include: NEM (Net Energy Metering) with interconnection attributes (system capacity kW-DC, inverter type, export limit, NEM version, true-up period, annual true-up date); DR (Demand Response) with dispatch attributes (enrolled load kW, curtailment obligation, control method, notification lead time, ISO/RTO registration reference); budget billing with levelized payment attributes (monthly amount, true-up balance, review date, calculation basis); TOU, CPP, auto-pay, paperless billing, CARE/FERA, and LIHEAP assistance programs. Core attributes across all types: enrollment date, effective date, program code, program type discriminator, enrollment channel (web, call center, field), enrollment status lifecycle, cancellation reason, and associated service agreement reference. Distinct from the program catalog owned by the product domain. Supports polymorphic conditional attributes by program type.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`move_order` (
    `move_order_id` BIGINT COMMENT 'System-generated unique identifier for the move order record.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Facilitates Move Order Execution; a crew is designated to perform the service move and associated tasks.',
    `customer_account_id` BIGINT COMMENT 'Account associated with the move order.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer who requested the move.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal user who approved the move order.',
    `person_id` BIGINT COMMENT 'Identifier of the customer who requested the move.',
    `customer_service_point_id` BIGINT COMMENT 'Identifier of the service point being discontinued.',
    `actual_end_date` DATE COMMENT 'Date service was actually de‑activated at the old service point.',
    `actual_start_date` DATE COMMENT 'Date service was actually activated at the new service point.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the move order was approved.',
    `cancellation_reason` STRING COMMENT 'Reason provided when a move order is cancelled.',
    `compliance_status` STRING COMMENT 'Current compliance state of the move order with applicable regulations.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the move order record was first persisted.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the move fee.',
    `is_meter_read_required` BOOLEAN COMMENT 'Indicates whether a meter read order must be generated as part of the move.',
    `meter_read_scheduled_date` DATE COMMENT 'Date on which the meter read is scheduled to occur for the new service point.',
    `move_fee_amount` DECIMAL(18,2) COMMENT 'Base fee charged for processing the move order.',
    `move_fee_tax` DECIMAL(18,2) COMMENT 'Tax component applied to the move service fee.',
    `move_fee_total` DECIMAL(18,2) COMMENT 'Total amount payable for the move order (fee plus tax).',
    `move_type` STRING COMMENT 'Indicates whether the request is a move‑in, move‑out, or intra‑service‑point transfer.. Valid values are `move_in|move_out|move_within`',
    `notes` STRING COMMENT 'Free‑form text for additional information or special instructions.',
    `order_number` STRING COMMENT 'External business reference number assigned to the move order.',
    `order_status` STRING COMMENT 'Current lifecycle status of the move order.. Valid values are `draft|submitted|approved|rejected|completed|cancelled`',
    `order_timestamp` TIMESTAMP COMMENT 'Timestamp when the move order was created in the system (business event time).',
    `processing_channel` STRING COMMENT 'Channel through which the move order was submitted.. Valid values are `online|call_center|branch|salesforce`',
    `regulatory_flag` BOOLEAN COMMENT 'True if the move order requires regulatory review or filing.',
    `requested_end_date` DATE COMMENT 'Date the customer requests service to be terminated at the old location.',
    `requested_start_date` DATE COMMENT 'Date the customer requests service to begin at the new location.',
    `service_classification` STRING COMMENT 'Customer segment classification for the service (residential, commercial, or industrial).. Valid values are `residential|commercial|industrial`',
    `service_type` STRING COMMENT 'Type of utility service involved in the move.. Valid values are `electric|gas|dual`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the move order record.',
    CONSTRAINT pk_move_order PRIMARY KEY(`move_order_id`)
) COMMENT 'Transactional record representing a customer-initiated move-in, move-out, or transfer-of-service event. Captures requested start/stop date, old and new service point references, move type (move-in, move-out, move-within), order status, final read date, and processing channel. Drives the start/stop service workflow in Oracle CC&B and triggers meter read orders in the MDM system. A key lifecycle event in the customer enrollment process.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`account_relationship` (
    `account_relationship_id` BIGINT COMMENT 'Surrogate primary key uniquely identifying each account relationship record.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer account involved in the relationship.',
    `party_person_id` BIGINT COMMENT 'Unique identifier of the person or organization (party) linked to the account.',
    `person_id` BIGINT COMMENT 'Unique identifier of the person or organization (party) linked to the account.',
    `authorization_level` STRING COMMENT 'Level of authority granted to the party for actions on the account.. Valid values are `full|limited|view_only`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the relationship record was first created in the system.',
    `deposit_waiver_flag` BOOLEAN COMMENT 'True if the landlord has waived the security deposit requirement.',
    `effective_end_date` DATE COMMENT 'Date when the relationship ends or is scheduled to terminate (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date when the relationship becomes effective.',
    `is_primary_contact` BOOLEAN COMMENT 'True if this party is the primary contact for the account.',
    `landlord_reversion_date` DATE COMMENT 'Date on which landlord rights revert to the property owner, applicable for landlord relationships.',
    `notes` STRING COMMENT 'Free‑form text for additional information or comments about the relationship.',
    `notification_preference` STRING COMMENT 'Preferred channel for relationship‑related notifications.. Valid values are `email|sms|mail|none`',
    `relationship_status` STRING COMMENT 'Current lifecycle status of the relationship.. Valid values are `active|inactive|pending|terminated`',
    `relationship_type` STRING COMMENT 'Classification of the relationship between the account and the party.. Valid values are `account_holder|co_applicant|guarantor|third_party_notification|landlord|authorized_representative`',
    `termination_reason` STRING COMMENT 'Reason why the relationship was terminated, if applicable.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the relationship record.',
    CONSTRAINT pk_account_relationship PRIMARY KEY(`account_relationship_id`)
) COMMENT 'Association entity capturing structured relationships between customer accounts and persons or business entities, including account holder, co-applicant, guarantor, third-party notification, landlord-tenant (with reversion terms and blanket deposit waiver), and authorized representative relationships. Captures relationship type, effective start and end dates, authorization level, notification preferences, and relationship-specific attributes (e.g., landlord reversion date, deposit waiver flag). Supports complex household hierarchies, commercial account structures, and multi-family property management workflows. Carries its own business attributes beyond a simple FK, justifying standalone entity status.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`segment` (
    `segment_id` BIGINT COMMENT 'Primary key for segment',
    `ami_eligibility_flag` BOOLEAN COMMENT 'Indicates whether customers in this segment are eligible for AMI meters.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the segment record was first created in the system.',
    `dr_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the segment can be enrolled in demand‑response programs.',
    `effective_from` DATE COMMENT 'First date the segment definition is valid for new accounts.',
    `effective_until` DATE COMMENT 'Last date the segment definition is valid; null for open‑ended.',
    `load_profile_class` STRING COMMENT 'Classification of typical consumption pattern for the segment.. Valid values are `baseline|peak|offpeak|critical`',
    `segment_code` STRING COMMENT 'Short alphanumeric code that uniquely identifies the segment within the utility.. Valid values are `^[A-Z0-9]{3,6}$`',
    `segment_description` STRING COMMENT 'Narrative description providing business context, usage rules, and any special characteristics.',
    `segment_name` STRING COMMENT 'Descriptive name of the market segment, e.g., "Small Commercial".',
    `segment_status` STRING COMMENT 'Operational status of the segment record.. Valid values are `active|inactive|retired`',
    `segment_tier` STRING COMMENT 'Broad classification of the segment by customer type: Residential, Commercial, or Industrial.. Valid values are `residential|commercial|industrial`',
    `sub_segment` STRING COMMENT 'Specific sub‑category such as "Small Commercial", "Large Industrial", or "Agricultural". [ENUM-REF-CANDIDATE: small_commercial|large_commercial|small_industrial|large_industrial|agricultural|government] ',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the segment record.',
    CONSTRAINT pk_segment PRIMARY KEY(`segment_id`)
) COMMENT 'Classification entity defining the market segmentation taxonomy applied to customer accounts for rate design, demand-side management targeting, and regulatory reporting. Captures segment code, segment name, segment tier (RCI: residential, commercial, industrial), sub-segment (e.g., small commercial, large industrial, agricultural), load profile class, AMI eligibility flag, and DR program eligibility. Used by billing, product, and engagement domains for targeted program delivery.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`communication_preference` (
    `communication_preference_id` BIGINT COMMENT 'Unique identifier for the communication preference record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer to whom these communication preferences apply.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer to whom these communication preferences apply.',
    `bill_ready_channel` STRING COMMENT 'Channel the customer prefers for receiving bill‑ready notifications.. Valid values are `email|sms|ivr|paper_mail|mobile_app_push`',
    `bill_ready_opt_in` BOOLEAN COMMENT 'Indicates whether the customer has opted in to receive bill‑ready notifications via the selected channel.',
    `communication_preference_source` STRING COMMENT 'Source system where the preference was captured.. Valid values are `cisc|salesforce|self_service_portal`',
    `communication_preference_status` STRING COMMENT 'Current lifecycle status of the communication preference record.. Valid values are `active|inactive|pending|suspended`',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer provided consent for the recorded communication preferences.',
    `consent_version` STRING COMMENT 'Version identifier of the consent policy under which the preferences were recorded.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the communication preference record was initially created.',
    `do_not_contact` BOOLEAN COMMENT 'Flag indicating the customer has requested no communications (Do‑Not‑Call/Do‑Not‑Email).',
    `dr_event_notification_channel` STRING COMMENT 'Channel the customer prefers for demand‑response event notifications.. Valid values are `email|sms|ivr|paper_mail|mobile_app_push`',
    `dr_event_opt_in` BOOLEAN COMMENT 'Indicates whether the customer has opted in to receive demand‑response event notifications.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the communication preference record.',
    `opt_out_all` BOOLEAN COMMENT 'Flag indicating the customer has opted out of all communications, overriding individual channel opt‑ins.',
    `outage_alert_channel` STRING COMMENT 'Channel the customer prefers for outage alerts.. Valid values are `email|sms|ivr|paper_mail|mobile_app_push`',
    `outage_alert_opt_in` BOOLEAN COMMENT 'Indicates whether the customer has opted in to receive outage alerts.',
    `payment_confirmation_channel` STRING COMMENT 'Channel the customer prefers for payment confirmation messages.. Valid values are `email|sms|ivr|paper_mail|mobile_app_push`',
    `payment_confirmation_opt_in` BOOLEAN COMMENT 'Indicates whether the customer has opted in to receive payment confirmation messages.',
    `preference_effective_date` DATE COMMENT 'Date when the recorded communication preferences become effective.',
    `preference_expiration_date` DATE COMMENT 'Date when the communication preferences expire or need re‑validation.',
    `preference_last_verified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent verification of the customers contact preferences.',
    `preference_notes` STRING COMMENT 'Free‑form notes captured by the contact center or self‑service portal regarding the customers preferences.',
    `preference_update_reason` STRING COMMENT 'Reason code or description for why the preference record was updated.',
    `preference_verification_method` STRING COMMENT 'Method used to verify the customers contact preferences.. Valid values are `email|sms|phone|in_person`',
    `preferred_contact_time_end` STRING COMMENT 'Preferred end of daily contact window (24‑hour format HH:MM).',
    `preferred_contact_time_start` STRING COMMENT 'Preferred start of daily contact window (24‑hour format HH:MM).',
    `preferred_language` STRING COMMENT 'Preferred language for all communications, using ISO 639-1 codes (e.g., en, es).',
    `regulatory_notice_channel` STRING COMMENT 'Channel the customer prefers for regulatory notices required by PUC/FERC.. Valid values are `email|sms|ivr|paper_mail|mobile_app_push`',
    `regulatory_notice_opt_in` BOOLEAN COMMENT 'Indicates whether the customer has opted in to receive regulatory notices.',
    CONSTRAINT pk_communication_preference PRIMARY KEY(`communication_preference_id`)
) COMMENT 'Master record of a customers explicit communication channel preferences and consent flags for each notification category. Captures preferred language, preferred channel per notification type (bill ready, outage alert, payment confirmation, DR event notification, regulatory notice), opt-in/opt-out status per channel (email, SMS, IVR, paper mail, mobile app push), and consent timestamp. Supports TCPA compliance and PUC-mandated customer notification requirements.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`credit_profile` (
    `credit_profile_id` BIGINT COMMENT 'Unique surrogate key for the credit profile record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer to whom this credit profile belongs.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer to whom this credit profile belongs.',
    `collections_status_flag` BOOLEAN COMMENT 'Indicates whether the account is currently under collection actions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit profile record was first created.',
    `credit_class` STRING COMMENT 'Risk classification assigned to the customer based on credit evaluation.. Valid values are `A|B|C|D|E`',
    `credit_limit_amount` DECIMAL(18,2) COMMENT 'Maximum credit amount the utility is willing to extend to the customer.',
    `credit_review_date` DATE COMMENT 'Date of the most recent credit review for the customer.',
    `credit_score_band` STRING COMMENT 'Band representing the customers credit score range.. Valid values are `excellent|good|fair|poor|bad`',
    `credit_status` STRING COMMENT 'Current lifecycle status of the credit profile.. Valid values are `active|inactive|suspended|closed|pending`',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Monetary deposit held as security for service provision.',
    `deposit_type` STRING COMMENT 'Form of deposit provided by the customer.. Valid values are `cash|surety_bond|letter_of_credit`',
    `deposit_waiver_reason` STRING COMMENT 'Reason why a deposit requirement was waived for the customer.',
    `effective_from` DATE COMMENT 'Date when the credit profile became effective.',
    `effective_until` DATE COMMENT 'Date when the credit profile expires or is superseded; null if open-ended.',
    `last_collection_attempt_date` DATE COMMENT 'Date of the most recent collection attempt for the account.',
    `notes` STRING COMMENT 'Free-text field for additional remarks or exceptions related to the credit profile.',
    `payment_history_score` DECIMAL(18,2) COMMENT 'Score reflecting the customers historical payment performance.',
    `risk_rating` STRING COMMENT 'Overall risk rating derived from credit and payment data.. Valid values are `low|medium|high`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the credit profile.',
    CONSTRAINT pk_credit_profile PRIMARY KEY(`credit_profile_id`)
) COMMENT 'Master record of a customers credit standing and deposit management data as maintained in Oracle CC&B. Captures credit class, credit score band, deposit amount on file, deposit type (cash, surety bond, letter of credit), deposit waiver reason, credit review date, payment history score, and collections status flag. Supports credit risk assessment for new service applications and annual deposit review workflows mandated by state PUC tariff rules.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` (
    `medical_baseline_id` BIGINT COMMENT 'Unique identifier for the medical baseline enrollment record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer associated with the medical baseline enrollment.',
    `person_id` BIGINT COMMENT 'Identifier of the customer associated with the medical baseline enrollment.',
    `certification_date` DATE COMMENT 'Date when the medical baseline certification was issued.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `disconnection_protection_expiration_date` DATE COMMENT 'Date when the protection expires, if applicable.',
    `disconnection_protection_status` STRING COMMENT 'Current status of disconnection protection for the customer.. Valid values are `protected|not_protected|pending`',
    `eligibility_flag` BOOLEAN COMMENT 'Indicates whether the customer currently meets eligibility criteria for the program.',
    `enrollment_end_date` DATE COMMENT 'Date when the enrollment ended or is scheduled to end; null if ongoing.',
    `enrollment_start_date` DATE COMMENT 'Date when the customer’s enrollment in the program began.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the medical baseline enrollment.. Valid values are `active|inactive|suspended|terminated`',
    `equipment_last_inspection_date` DATE COMMENT 'Date of the most recent inspection of the equipment.',
    `equipment_maintenance_required_flag` BOOLEAN COMMENT 'Indicates whether the equipment requires maintenance.',
    `equipment_serial_number` STRING COMMENT 'Manufacturer serial number of the equipment.',
    `equipment_type` STRING COMMENT 'Type of life‑support equipment associated with the enrollment.. Valid values are `oxygen_concentrator|dialysis|ventilator|other`',
    `exemption_reason` STRING COMMENT 'Reason provided for any exemption from standard disconnection rules.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or observations.',
    `physician_certified_flag` BOOLEAN COMMENT 'True if a physician has certified the medical baseline eligibility.',
    `physician_name` STRING COMMENT 'Full name of the certifying physician.',
    `physician_npi` STRING COMMENT 'Unique identifier for the certifying physician.',
    `program_code` STRING COMMENT 'Internal code used to identify the medical baseline program.',
    `program_name` STRING COMMENT 'Descriptive name of the medical baseline program.',
    `program_type` STRING COMMENT 'Type of medical baseline program the customer is enrolled in.. Valid values are `medical_baseline_allowance|life_support_equipment|serious_illness`',
    `rate_discount_amount` DECIMAL(18,2) COMMENT 'Monetary discount applied to the customers rate under the program.',
    `rate_discount_code` STRING COMMENT 'Code representing the specific discount tier or policy.',
    `recertification_completed_flag` BOOLEAN COMMENT 'Indicates whether the required recertification has been completed.',
    `recertification_due_date` DATE COMMENT 'Date by which the medical baseline must be recertified.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_medical_baseline PRIMARY KEY(`medical_baseline_id`)
) COMMENT 'Master record tracking customers enrolled in medical baseline or life support programs that entitle them to reduced rates or special service protections under state PUC rules. Captures program type (medical baseline allowance, life support equipment, serious illness), certification date, recertification due date, physician certification flag, equipment type (oxygen concentrator, dialysis, etc.), and disconnection protection status. Critical for regulatory compliance with PUC disconnection moratorium rules.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`third_party_access` (
    `third_party_access_id` BIGINT COMMENT 'System-generated unique identifier for each third‑party access authorization record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the utility account associated with the customer for which access is granted.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer who granted the third‑party access.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Regulatory compliance requires tracking which vendor is authorized to access a specific customer account; vendor_id replaces denormalized third_party_name.',
    `access_category` STRING COMMENT 'Permission level granted to the third‑party (read‑only, write‑only, or both).. Valid values are `read|write|read_write`',
    `access_reference_code` STRING COMMENT 'External reference number or code used by business processes to identify the authorization.',
    `authorization_scope` STRING COMMENT 'Scope of data the third‑party is permitted to access (e.g., usage data, billing data, account data, or all).. Valid values are `usage|billing|account|all`',
    `consent_channel` STRING COMMENT 'Channel through which the customer gave consent (e.g., web portal, mobile app, phone call, email, in‑person).. Valid values are `web|mobile|phone|email|in_person`',
    `consent_timestamp` TIMESTAMP COMMENT 'Timestamp when the customer provided consent for third‑party data sharing.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the access record was initially created in the system.',
    `data_types_shared` STRING COMMENT 'Comma‑separated list of data categories shared with the third‑party (e.g., "usage, billing, account").',
    `effective_from` DATE COMMENT 'Date on which the third‑party access authorization becomes effective.',
    `effective_until` DATE COMMENT 'Date on which the third‑party access authorization expires (null if open‑ended).',
    `notes` STRING COMMENT 'Free‑form notes or comments regarding the authorization (e.g., special conditions, auditor remarks).',
    `privacy_policy_url` STRING COMMENT 'Link to the third‑partys privacy policy governing data use.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the third‑party meets all applicable regulatory requirements (e.g., FERC Order 2222, NERC standards).',
    `revocation_status` STRING COMMENT 'Current revocation state of the access authorization.. Valid values are `active|revoked|expired`',
    `revocation_timestamp` TIMESTAMP COMMENT 'Timestamp when the access was revoked or automatically expired.',
    `third_party_access_status` STRING COMMENT 'Overall lifecycle status of the third‑party access record.. Valid values are `pending|active|suspended|terminated|expired`',
    `third_party_type` STRING COMMENT 'Category describing the business role of the third‑party entity.. Valid values are `energy_advisor|solar_installer|ev_charging|der_aggregator|retail_marketer|other`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the access record.',
    CONSTRAINT pk_third_party_access PRIMARY KEY(`third_party_access_id`)
) COMMENT 'Master record governing authorized third-party access to customer account data and usage information, including energy advisors, solar installers, EV charging providers, DERMS aggregators, and retail energy marketers. Captures third-party entity name, authorization scope (usage data, billing data, account data), data sharing start and end dates, customer consent timestamp, consent channel, and revocation status. Supports Green Button Connect My Data (CMD) and FERC Order 2222 DER aggregator access requirements.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` (
    `nem_agreement_id` BIGINT COMMENT 'Unique surrogate key for each NEM agreement record.',
    `asset_permit_compliance_document_id` BIGINT COMMENT 'Identifier of the compliance document associated with the agreement.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Net Metering agreements must reference the specific customer‑owned generation asset (e.g., rooftop solar) for compliance reporting and credit allocation.',
    `document_id` BIGINT COMMENT 'Identifier of the compliance document associated with the agreement.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer party to whom the NEM agreement applies.',
    `customer_customer_account_id` BIGINT COMMENT 'Unique identifier of the customer party to whom the NEM agreement applies.',
    `distribution_service_point_id` BIGINT COMMENT 'Identifier of the service point (metered location) associated with the NEM agreement.',
    `agreement_number` STRING COMMENT 'External reference number assigned to the NEM agreement by the utility.',
    `agreement_type` STRING COMMENT 'Specifies the version or variant of the NEM program applicable to the agreement.. Valid values are `NEM|NEM_2_0|NEM_3_0|Other`',
    `annual_true_up_date` DATE COMMENT 'Date each year when net export/export reconciliation is performed.',
    `application_date` DATE COMMENT 'Date the customer submitted the interconnection application.',
    `approval_date` DATE COMMENT 'Date the utility approved the interconnection and NEM agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the NEM agreement record was first created in the system.',
    `effective_from` DATE COMMENT 'Date on which the NEM agreement becomes binding.',
    `effective_until` DATE COMMENT 'Date on which the NEM agreement ends or is terminated; null for open‑ended agreements.',
    `eligibility_flag` BOOLEAN COMMENT 'Indicates whether the customer meets eligibility criteria for NEM participation.',
    `export_limit_kw` DECIMAL(18,2) COMMENT 'Maximum allowable export power to the grid under the NEM agreement.',
    `interconnection_date` DATE COMMENT 'Date the interconnection was placed into service.',
    `interconnection_status` STRING COMMENT 'Current status of the interconnection process for the customer‑sited generation system.. Valid values are `applied|approved|installed|operational|decommissioned`',
    `inverter_type` STRING COMMENT 'Technology type of the inverter (e.g., string, micro‑inverter, central).',
    `metered_export_kwh_year` DECIMAL(18,2) COMMENT 'Total kilowatt‑hours exported to the grid in the most recent calendar year.',
    `metered_import_kwh_year` DECIMAL(18,2) COMMENT 'Total kilowatt‑hours imported from the grid in the most recent calendar year.',
    `nem_agreement_status` STRING COMMENT 'Current lifecycle state of the agreement.. Valid values are `draft|pending|active|suspended|terminated|closed`',
    `net_metering_cap_kwh` DECIMAL(18,2) COMMENT 'Maximum kilowatt‑hours eligible for credit in a given period.',
    `net_metering_credits` DECIMAL(18,2) COMMENT 'Total monetary credits accrued for net export during the current true‑up period.',
    `net_metering_enrollment_flag` BOOLEAN COMMENT 'True if the customer is actively enrolled in the NEM program.',
    `net_metering_program_code` STRING COMMENT 'Internal code representing the specific NEM program variant.',
    `net_metering_rate` DECIMAL(18,2) COMMENT 'Compensation rate applied to exported kilowatt‑hours.',
    `program_version` STRING COMMENT 'Version of the Net Energy Metering program (e.g., NEM 1.0, NEM 2.0, NEM 3.0).',
    `regulatory_filing_date` DATE COMMENT 'Date the required filing was submitted to the regulator.',
    `regulatory_filing_status` STRING COMMENT 'Status of required regulatory filings for the interconnection.. Valid values are `not_filed|filed|approved|rejected`',
    `system_capacity_kw` DECIMAL(18,2) COMMENT 'Rated DC capacity of the customer‑sited generation system in kilowatts.',
    `termination_date` DATE COMMENT 'Date the NEM agreement was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Reason provided for terminating the NEM agreement.',
    `true_up_period_months` STRING COMMENT 'Length of the annual true‑up cycle in months.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the NEM agreement record.',
    `version_number` STRING COMMENT 'Sequential version of the agreement record for change tracking.',
    CONSTRAINT pk_nem_agreement PRIMARY KEY(`nem_agreement_id`)
) COMMENT 'Master record for Net Energy Metering (NEM) interconnection agreements between the utility and customers with customer-sited generation (rooftop solar, small wind, fuel cells). Captures NEM program version (NEM 1.0, NEM 2.0, NEM 3.0/NEM-ST), interconnection application date, approval date, system capacity (kW-DC), inverter type, export limit (kW), true-up period, annual true-up date, and interconnection agreement status. Distinct from the general enrollment entity — NEM carries unique interconnection and export attributes.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` (
    `dr_enrollment_id` BIGINT COMMENT 'Unique surrogate key for each demand response enrollment record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Demand‑Response programs track the controllable equipment assigned to each enrollment; linking to the asset registry enables program administration and performance reporting.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account linked to the enrollment.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer associated with the enrollment.',
    `distribution_service_point_id` BIGINT COMMENT 'Identifier of the service point (meter) where DR participation applies.',
    `control_method` STRING COMMENT 'Method used to achieve load reduction for the enrollment.. Valid values are `direct_switch|smart_thermostat|customer_controlled|automated|manual`',
    `curtailment_obligation_kw` DECIMAL(18,2) COMMENT 'Obligated curtailment capacity (kW) per DR event.',
    `demand_response_category` STRING COMMENT 'Category of DR program (capacity, energy, price, ancillary services).. Valid values are `capacity|energy|price|ancillary`',
    `effective_date` DATE COMMENT 'Date when the DR enrollment becomes active.',
    `enrollment_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was initially created.',
    `enrollment_notes` STRING COMMENT 'Free‑text notes regarding the enrollment (e.g., special conditions or comments).',
    `enrollment_source` STRING COMMENT 'System or process through which the enrollment was created.. Valid values are `cisc|salesforce|manual|api`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment.. Valid values are `active|suspended|terminated|pending|withdrawn`',
    `enrollment_type` STRING COMMENT 'Type of DR enrollment indicating the control method category.. Valid values are `interruptible|direct_load_control|auto_dr|vpp_participation`',
    `enrollment_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    `enrollment_version` STRING COMMENT 'Version number of the enrollment record for change‑tracking purposes.',
    `is_test_enrollment` BOOLEAN COMMENT 'Flag indicating if the enrollment record is for testing or pilot purposes.',
    `iso_rto_registration_ref` STRING COMMENT 'Reference number for registration with the ISO/RTO for DR resources.',
    `last_dispatch_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent DR dispatch event for this enrollment.',
    `load_enrolled_kw` DECIMAL(18,2) COMMENT 'Maximum load (in kilowatts) the customer agrees to curtail.',
    `notification_lead_time_min` STRING COMMENT 'Required notice time before a curtailment event, expressed in minutes.',
    `participation_flag` BOOLEAN COMMENT 'Indicates whether the customer is currently participating in the DR program.',
    `program_code` STRING COMMENT 'Code identifying the DR program (e.g., DR-001).',
    `program_name` STRING COMMENT 'Descriptive name of the DR program.',
    `termination_date` DATE COMMENT 'Date when the DR enrollment ends or is cancelled.',
    CONSTRAINT pk_dr_enrollment PRIMARY KEY(`dr_enrollment_id`)
) COMMENT 'Master record for a customers active enrollment in a Demand Response (DR) or load management program, including interruptible service, direct load control, automated demand response (Auto-DR), and virtual power plant (VPP) participation. Captures DR program code, enrolled load (kW), curtailment obligation (kW), notification lead time (minutes), control method (direct switch, smart thermostat, customer-controlled), enrollment effective date, and ISO/RTO registration reference. Distinct from the general enrollment entity due to operational dispatch attributes.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` (
    `budget_billing_plan_id` BIGINT COMMENT 'Primary key for budget_billing_plan',
    `customer_account_id` BIGINT COMMENT 'Identifier of the billing account associated with the plan.',
    `customer_customer_account_id` BIGINT COMMENT 'Unique identifier of the customer who is enrolled in the budget billing plan.',
    `person_id` BIGINT COMMENT 'Unique identifier of the customer who is enrolled in the budget billing plan.',
    `auto_renew_flag` BOOLEAN COMMENT 'Indicates whether the plan automatically renews after the end date.',
    `billing_cycle` STRING COMMENT 'Frequency at which the customer receives a bill under the plan.. Valid values are `monthly|quarterly|annual`',
    `budget_amount` DECIMAL(18,2) COMMENT 'Planned monthly payment amount for the customer under the plan.',
    `budget_billing_plan_status` STRING COMMENT 'Current lifecycle status of the budget billing plan.. Valid values are `active|suspended|cancelled|pending|closed`',
    `calculation_basis` STRING COMMENT 'Method used to calculate the monthly budget amount.. Valid values are `prior_12_month_average|forecasted|custom`',
    `cancellation_reason` STRING COMMENT 'Reason why the budget billing plan was cancelled.. Valid values are `customer_request|non_payment|regulatory|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the budget billing plan record was first created.',
    `cumulative_true_up_balance` DECIMAL(18,2) COMMENT 'Running balance of over‑ or under‑payments that will be settled at the true‑up month.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Monetary value of any discount applied to the monthly budget amount.',
    `discount_flag` BOOLEAN COMMENT 'True if a discount is applied to the budget amount.',
    `enrollment_programs` STRING COMMENT 'Comma‑separated list of demand‑response, TOU, or other programs linked to the plan.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent plan review action.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special conditions.',
    `payment_method` STRING COMMENT 'Primary method used to collect the budgeted payment from the customer.. Valid values are `auto_debit|check|credit_card|online|other`',
    `plan_end_date` DATE COMMENT 'Date the budget billing plan terminates (null for open‑ended).',
    `plan_review_date` DATE COMMENT 'Scheduled date for periodic review and possible adjustment of the plan.',
    `plan_start_date` DATE COMMENT 'Date the budget billing plan becomes effective.',
    `plan_type` STRING COMMENT 'Classification of the budget billing plan (e.g., budget, levelized, fixed, variable).. Valid values are `budget|levelized|fixed|variable`',
    `rate_schedule_code` STRING COMMENT 'Code of the rate schedule applied to the budget billing plan.',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the plan complies with current FERC/NERC regulations.',
    `suspension_flag` BOOLEAN COMMENT 'True if the plan is temporarily suspended (e.g., for non‑payment).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the monthly budget amount.',
    `true_up_month` DATE COMMENT 'Month in which the cumulative true‑up balance is reconciled with actual usage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the budget billing plan record.',
    `usage_average_12_month_kwh` DECIMAL(18,2) COMMENT 'Average electricity consumption over the prior 12 months used to compute the budget amount.',
    CONSTRAINT pk_budget_billing_plan PRIMARY KEY(`budget_billing_plan_id`)
) COMMENT 'Master record for customers enrolled in a budget billing (levelized payment) plan that smooths monthly bill amounts over a 12-month period. Captures monthly budget amount, plan start date, plan review date, cumulative true-up balance (over/under), true-up month, plan status (active, suspended, cancelled), and the calculation basis (prior 12-month average usage). Supports billing domain workflows and customer financial assistance program tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`service_territory` (
    `service_territory_id` BIGINT COMMENT 'Primary key for service_territory',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Service territory is assigned to a specific customer account; linking provides clear ownership and enables territory‑based reporting.',
    `area_sq_mi` DECIMAL(18,2) COMMENT 'Geographic area of the territory in square miles.',
    `commodity_type` STRING COMMENT 'Type of commodity the territory serves (electric or gas).. Valid values are `electric|gas`',
    `county_list` STRING COMMENT 'Comma‑separated list of counties included in the territory.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the territory record was first created in the system.',
    `effective_date` DATE COMMENT 'Date the territory definition became effective.',
    `expiration_date` DATE COMMENT 'Date the territory definition expires or is superseded; null if still active.',
    `gis_polygon_code` STRING COMMENT 'Identifier of the GIS polygon stored in the ArcGIS system representing the territory boundary.',
    `is_cross_state` BOOLEAN COMMENT 'Indicates if the territory spans more than one state.',
    `is_dr_eligible` BOOLEAN COMMENT 'Flag indicating eligibility for Demand Response programs.',
    `is_nem_eligible` BOOLEAN COMMENT 'Flag indicating whether customers in the territory are eligible for Net Energy Metering programs.',
    `is_tou_eligible` BOOLEAN COMMENT 'Flag indicating eligibility for Time‑of‑Use rate structures.',
    `jurisdiction_puc` STRING COMMENT 'Public Utility Commission (PUC) or Public Service Commission (PSC) docket reference governing the territory.',
    `jurisdiction_state` STRING COMMENT 'Two‑letter state abbreviation where the territory is located. [ENUM-REF-CANDIDATE: AL|AK|AZ|AR|CA|CO|CT|DE|FL|GA|HI|ID|IL|IN|IA|KS|KY|LA|ME|MD|MA|MI|MN|MS|MO|MT|NE|NV|NH|NJ|NM|NY|NC|ND|OH|OK|OR|PA|RI|SC|SD|TN|TX|UT|VT|VA|WA|WV|WI|WY — promote to reference product]',
    `last_regulatory_review_date` DATE COMMENT 'Date of the most recent regulatory review or filing for the territory.',
    `municipality_list` STRING COMMENT 'Comma‑separated list of municipalities included in the territory.',
    `primary_rate_schedule_code` STRING COMMENT 'Default rate schedule code applied to customers in this territory.',
    `rate_zone` STRING COMMENT 'Rate zone designation used for billing and tariff calculations. [ENUM-REF-CANDIDATE: multiple zones — promote to reference product]',
    `regulatory_docket_url` STRING COMMENT 'Web URL to the regulatory docket or filing document.',
    `regulatory_jurisdiction` STRING COMMENT 'Regulatory body (e.g., FERC, NERC, state PUC) that has authority over the territory.',
    `service_territory_description` STRING COMMENT 'Free‑form description of the territory, including any special characteristics.',
    `service_territory_status` STRING COMMENT 'Current lifecycle status of the territory record.. Valid values are `active|inactive|pending|retired`',
    `service_type` STRING COMMENT 'Primary customer segment(s) the territory serves.. Valid values are `residential|commercial|industrial|mixed`',
    `source_system` STRING COMMENT 'Source system that supplied the territory data (e.g., ArcGIS, CC&B).',
    `territory_code` STRING COMMENT 'Unique code assigned to the service territory by the utility.',
    `territory_name` STRING COMMENT 'Human‑readable name of the service territory.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the territory record.',
    `version_number` STRING COMMENT 'Version of the territory definition for change‑management tracking.',
    CONSTRAINT pk_service_territory PRIMARY KEY(`service_territory_id`)
) COMMENT 'Reference entity defining the utilitys certificated service territory boundaries including electric and gas franchise areas, county and municipal boundaries, rate zone designations, and regulatory jurisdiction assignments. Captures territory code, territory name, commodity type (electric/gas), state jurisdiction, PUC/PSC docket reference, effective date, and GIS polygon reference. Used for customer enrollment eligibility validation, service application processing, and regulatory reporting boundary definitions. Domain ownership under review — may relocate to shared reference domain in future iterations.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`interaction` (
    `interaction_id` BIGINT COMMENT 'System-generated unique identifier for the interaction record.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Supports Customer Interaction handling; support calls are routed to a specific technician for field assistance.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account linked to the interaction.',
    `customer_customer_account_id` BIGINT COMMENT 'Unique identifier of the customer associated with the interaction.',
    `distribution_service_point_id` BIGINT COMMENT 'Identifier of the service point (metered location) relevant to the interaction.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or representative who handled the interaction.',
    `person_id` BIGINT COMMENT 'Unique identifier of the customer associated with the interaction.',
    `followup_to_interaction_id` BIGINT COMMENT 'Self-referencing FK on interaction (followup_to_interaction_id)',
    `agent_name` STRING COMMENT 'Full name of the agent handling the interaction.',
    `channel` STRING COMMENT 'Communication channel used for the interaction.. Valid values are `phone|web|ivr|chat|in_person`',
    `cost_gross_amount` DECIMAL(18,2) COMMENT 'Total cost associated with the interaction before any adjustments.',
    `cost_net_amount` DECIMAL(18,2) COMMENT 'Final cost after tax and any discounts.',
    `cost_tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the interaction cost, if applicable.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the interaction record was first created in the system.',
    `currency_code` STRING COMMENT 'ISO 4217 three‑letter currency code for monetary values (e.g., USD, EUR).',
    `duration_seconds` STRING COMMENT 'Length of the interaction measured in seconds.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the interaction was escalated to a higher‑level support tier.',
    `escalation_timestamp` TIMESTAMP COMMENT 'Date‑time when the escalation occurred, if applicable.',
    `follow_up_due_date` DATE COMMENT 'Date by which the required follow‑up must be completed.',
    `follow_up_required_flag` BOOLEAN COMMENT 'True if a follow‑up action is required after the interaction.',
    `interaction_description` STRING COMMENT 'Detailed free‑text notes captured during the interaction.',
    `interaction_number` STRING COMMENT 'Human‑readable reference number assigned to the interaction for tracking and customer communication.',
    `interaction_status` STRING COMMENT 'Current lifecycle status of the interaction.. Valid values are `open|resolved|closed|pending`',
    `interaction_timestamp` TIMESTAMP COMMENT 'Date‑time when the interaction actually occurred.',
    `interaction_type` STRING COMMENT 'Indicates whether the contact was initiated by the customer (inbound) or by the utility (outbound).. Valid values are `inbound|outbound`',
    `is_chargeable_flag` BOOLEAN COMMENT 'True if the interaction incurs a charge to the customer.',
    `language_preference` STRING COMMENT 'Preferred language of the customer for communication.',
    `notes` STRING COMMENT 'Additional free‑form notes captured by the agent.',
    `outcome_code` STRING COMMENT 'Standardized code representing the result of the interaction (e.g., RESOLVED, TRANSFERRED, NO_RESPONSE).',
    `outcome_description` STRING COMMENT 'Human‑readable description of the interaction outcome.',
    `resolution_status` STRING COMMENT 'Outcome of the interaction resolution process.. Valid values are `resolved|unresolved|escalated`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date‑time when the interaction was resolved or closed.',
    `satisfaction_score` STRING COMMENT 'Numeric rating (1‑5) provided by the customer after the interaction.',
    `subject` STRING COMMENT 'Brief title or subject describing the purpose of the interaction.',
    `survey_completed_flag` BOOLEAN COMMENT 'Indicates whether a post‑interaction survey was completed.',
    `survey_timestamp` TIMESTAMP COMMENT 'Date‑time when the satisfaction survey was submitted.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the interaction record.',
    CONSTRAINT pk_interaction PRIMARY KEY(`interaction_id`)
) COMMENT 'Customer service interaction record capturing inbound and outbound contacts across all channels (phone, web, IVR, chat, in-person) with resolution tracking';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`complaint` (
    `complaint_id` BIGINT COMMENT 'Unique system-generated identifier for the complaint record.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Enables Complaint Resolution workflow; a field technician is assigned to resolve the complaint and track work.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with the complaint.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer who lodged the complaint.',
    `distribution_service_point_id` BIGINT COMMENT 'Identifier of the service point (metered location) related to the complaint.',
    `move_order_id` BIGINT COMMENT 'Identifier of an order associated with the complaint, if applicable.',
    `escalated_from_complaint_id` BIGINT COMMENT 'Self-referencing FK on complaint (escalated_from_complaint_id)',
    `actual_resolution_date` DATE COMMENT 'Date on which the complaint was actually resolved.',
    `attached_document_count` STRING COMMENT 'Count of supporting documents attached to the complaint.',
    `channel` STRING COMMENT 'Channel through which the complaint was submitted.. Valid values are `phone|email|web|in_person|mail`',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Monetary compensation awarded to the customer, if any.',
    `compensation_currency` STRING COMMENT 'Three‑letter ISO currency code for the compensation amount.',
    `complaint_category` STRING COMMENT 'High‑level business category of the complaint.. Valid values are `billing|operations|safety|regulatory|customer_service`',
    `complaint_description` STRING COMMENT 'Detailed narrative provided by the complainant describing the issue.',
    `complaint_number` STRING COMMENT 'External reference number assigned to the complaint for tracking across systems.',
    `complaint_status` STRING COMMENT 'Current lifecycle status of the complaint.. Valid values are `open|in_progress|resolved|closed|rejected`',
    `complaint_type` STRING COMMENT 'Classification of the complaint based on the underlying issue.. Valid values are `billing|service_quality|safety|regulatory|other`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the complaint record was first created in the system.',
    `escalated_to_department` STRING COMMENT 'Name of the department or team to which the complaint was escalated.',
    `escalation_flag` BOOLEAN COMMENT 'True if the complaint has been escalated to a higher authority or department.',
    `internal_notes` STRING COMMENT 'Internal comments and observations made by staff handling the complaint.',
    `priority` STRING COMMENT 'Priority level indicating the urgency of handling the complaint.. Valid values are `low|medium|high|critical`',
    `received_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was initially received.',
    `regulatory_filing_flag` BOOLEAN COMMENT 'Indicates whether the complaint was filed with a regulatory body (e.g., PUC, FERC).',
    `regulatory_filing_reference` STRING COMMENT 'Reference number assigned by the regulator for the filed complaint.',
    `resolution_status` STRING COMMENT 'Current status of the complaint resolution process.. Valid values are `pending|resolved|closed|escalated|withdrawn`',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date and time when the complaint was formally resolved.',
    `source_system` STRING COMMENT 'Originating system where the complaint was first recorded.. Valid values are `CC&B|Salesforce|Other`',
    `target_resolution_date` DATE COMMENT 'Target date by which the complaint is expected to be resolved.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the complaint record.',
    CONSTRAINT pk_complaint PRIMARY KEY(`complaint_id`)
) COMMENT 'Formal customer complaint record filed through PUC, internal channels, or regulatory bodies requiring tracking, investigation, and resolution within mandated timeframes';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` (
    `customer_account_plan_id` BIGINT COMMENT 'Primary key for the account_plan association',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to the ci_account master',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to the customer_account master',
    `key_account_manager_id` BIGINT COMMENT 'ID of the key account manager responsible for the plan',
    `account_tier` STRING COMMENT 'Tier classification of the CI account within the plan',
    `approval_status` STRING COMMENT 'Current approval status of the plan',
    `approved_by` BIGINT COMMENT 'Identifier of the approver',
    `approved_date` DATE COMMENT 'Date the plan was approved',
    `budget_amount_usd` DECIMAL(18,2) COMMENT 'Total budget allocated for the plan in USD',
    `capital_investment_opportunities` STRING COMMENT 'Identified capital investment opportunities',
    `competitive_threats` STRING COMMENT 'Competitive threats relevant to the plan',
    `dr_participation_flag` BOOLEAN COMMENT 'Indicates if demand‑response participation is part of the plan',
    `effective_from` DATE COMMENT 'Start date of the plans effectiveness',
    `effective_until` DATE COMMENT 'End date of the plans effectiveness',
    `identified_risks` STRING COMMENT 'Risks identified for the plan',
    `load_growth_target_kw` DECIMAL(18,2) COMMENT 'Target load growth in kilowatts',
    `plan_status` STRING COMMENT 'Current status of the plan (e.g., Active, Completed)',
    `plan_type` STRING COMMENT 'Type of strategic plan (e.g., growth, retention)',
    `plan_year` BIGINT COMMENT 'Fiscal year of the plan',
    `planned_touchpoints` STRING COMMENT 'Planned customer engagement touchpoints',
    `program_enrollment_target_dr` STRING COMMENT 'Target for demand‑response program enrollment',
    `revenue_retention_target_usd` DECIMAL(18,2) COMMENT 'Target revenue to retain in USD',
    `risk_rating` STRING COMMENT 'Overall risk rating (e.g., High, Medium, Low)',
    `strategic_objectives` STRING COMMENT 'High‑level objectives for the plan',
    CONSTRAINT pk_customer_account_plan PRIMARY KEY(`customer_account_plan_id`)
) COMMENT 'This association product represents the strategic planning relationship between a customer_account and a ci_account. It captures planning attributes such as targets, budgets, risk assessments, and effective dates that belong to the plan itself, not to either account individually.. Existence Justification: A corporate C&I account (ci_account) can be linked to multiple individual customer accounts for strategic planning, and a single customer account may participate in multiple plans over time. The link is actively managed as an Account Plan and carries its own attributes such as targets, budgets, risk ratings, and effective dates.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_segment_id` FOREIGN KEY (`segment_id`) REFERENCES `power_and_utilities_v2`.`customer`.`segment`(`segment_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ADD CONSTRAINT `fk_customer_customer_account_parent_account_customer_account_id` FOREIGN KEY (`parent_account_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ADD CONSTRAINT `fk_customer_business_entity_parent_company_business_entity_id` FOREIGN KEY (`parent_company_business_entity_id`) REFERENCES `power_and_utilities_v2`.`customer`.`business_entity`(`business_entity_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ADD CONSTRAINT `fk_customer_customer_service_point_premise_id` FOREIGN KEY (`premise_id`) REFERENCES `power_and_utilities_v2`.`customer`.`premise`(`premise_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ADD CONSTRAINT `fk_customer_service_agreement_customer_service_point_id` FOREIGN KEY (`customer_service_point_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_service_point`(`customer_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ADD CONSTRAINT `fk_customer_enrollment_service_agreement_id` FOREIGN KEY (`service_agreement_id`) REFERENCES `power_and_utilities_v2`.`customer`.`service_agreement`(`service_agreement_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ADD CONSTRAINT `fk_customer_move_order_customer_service_point_id` FOREIGN KEY (`customer_service_point_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_service_point`(`customer_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_party_person_id` FOREIGN KEY (`party_person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ADD CONSTRAINT `fk_customer_account_relationship_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ADD CONSTRAINT `fk_customer_communication_preference_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ADD CONSTRAINT `fk_customer_communication_preference_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ADD CONSTRAINT `fk_customer_credit_profile_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ADD CONSTRAINT `fk_customer_medical_baseline_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ADD CONSTRAINT `fk_customer_medical_baseline_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ADD CONSTRAINT `fk_customer_third_party_access_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ADD CONSTRAINT `fk_customer_third_party_access_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ADD CONSTRAINT `fk_customer_nem_agreement_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ADD CONSTRAINT `fk_customer_nem_agreement_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ADD CONSTRAINT `fk_customer_dr_enrollment_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ADD CONSTRAINT `fk_customer_dr_enrollment_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ADD CONSTRAINT `fk_customer_budget_billing_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ADD CONSTRAINT `fk_customer_budget_billing_plan_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ADD CONSTRAINT `fk_customer_budget_billing_plan_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ADD CONSTRAINT `fk_customer_service_territory_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_person_id` FOREIGN KEY (`person_id`) REFERENCES `power_and_utilities_v2`.`customer`.`person`(`person_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ADD CONSTRAINT `fk_customer_interaction_followup_to_interaction_id` FOREIGN KEY (`followup_to_interaction_id`) REFERENCES `power_and_utilities_v2`.`customer`.`interaction`(`interaction_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_customer_customer_account_id` FOREIGN KEY (`customer_customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_move_order_id` FOREIGN KEY (`move_order_id`) REFERENCES `power_and_utilities_v2`.`customer`.`move_order`(`move_order_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ADD CONSTRAINT `fk_customer_complaint_escalated_from_complaint_id` FOREIGN KEY (`escalated_from_complaint_id`) REFERENCES `power_and_utilities_v2`.`customer`.`complaint`(`complaint_id`);
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ADD CONSTRAINT `fk_customer_customer_account_plan_customer_account_id` FOREIGN KEY (`customer_account_id`) REFERENCES `power_and_utilities_v2`.`customer`.`customer_account`(`customer_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`customer` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `power_and_utilities_v2`.`customer` SET TAGS ('dbx_domain' = 'customer');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Account Manager Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `parent_account_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Account Identifier (PARENT_ACCOUNT_ID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Identifier (RATE_CASE_ID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number (ACCOUNT_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `account_type` SET TAGS ('dbx_business_glossary_term' = 'Account Type (ACCOUNT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `account_type` SET TAGS ('dbx_value_regex' = 'electric|gas|dual_fuel');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 1 (BILLING_ADDRESS_LINE1)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Billing Address Line 2 (BILLING_ADDRESS_LINE2)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_business_glossary_term' = 'Billing City (BILLING_CITY)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_country` SET TAGS ('dbx_business_glossary_term' = 'Billing Country (BILLING_COUNTRY)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_business_glossary_term' = 'Billing State/Province (BILLING_STATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_zip` SET TAGS ('dbx_business_glossary_term' = 'Billing ZIP/Postal Code (BILLING_ZIP)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_zip` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `billing_zip` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `credit_class` SET TAGS ('dbx_business_glossary_term' = 'Credit Class (CREDIT_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `credit_class` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (CREDIT_LIMIT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance (CURRENT_BALANCE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `customer_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `customer_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `delinquency_status` SET TAGS ('dbx_business_glossary_term' = 'Delinquency Status (DELINQUENCY_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `delinquency_status` SET TAGS ('dbx_value_regex' = 'none|late|serious|collections');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `demand_response_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Enrollment Flag (DEMAND_RESPONSE_ENROLLED)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_FROM)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_UNTIL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANGUAGE_PREFERENCE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date (LAST_PAYMENT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `net_metering_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Metering Enrollment Flag (NET_METERING_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method (PAYMENT_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|cash|online|other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAYMENT_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'paid|unpaid|partial|failed|pending');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method (PREFERRED_CONTACT_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mail|sms|portal|other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name (PRIMARY_CONTACT_NAME)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `primary_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Email Address (PRIMARY_EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `primary_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `primary_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `primary_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number (PRIMARY_PHONE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `primary_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `regulatory_account_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Account Flag (REGULATORY_ACCOUNT_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (TAX_EXEMPT_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `time_of_use_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Time‑of‑Use Enrollment Flag (TIME_OF_USE_ENROLLED)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Person ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 1 (ADDR_LINE1)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR_LINE2)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (COUNTRY)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Customer Segment (CUST_SEG)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `customer_segment` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `do_not_call_flag` SET TAGS ('dbx_business_glossary_term' = 'Do Not Call Flag (DNC_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name (FN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Legal Name (FLN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender (GENDER)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|nonbinary|unspecified');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `government_id_number` SET TAGS ('dbx_business_glossary_term' = 'Government ID Number (GOV_ID_NUM)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `government_id_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,20}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `government_id_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `government_id_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `government_id_type` SET TAGS ('dbx_business_glossary_term' = 'Government ID Type (GOV_ID_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `government_id_type` SET TAGS ('dbx_value_regex' = 'SSN|TIN|Passport|DriverLicense');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANG_PREF)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (LN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `marketing_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Marketing Opt-In Flag (MKT_OPT_IN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name (MN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number (MOBILE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `mobile_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `person_status` SET TAGS ('dbx_business_glossary_term' = 'Person Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `person_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|deceased|pending');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `person_type` SET TAGS ('dbx_business_glossary_term' = 'Person Type (PERSON_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `person_type` SET TAGS ('dbx_value_regex' = 'customer|authorized_contact|guarantor|employee|vendor');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PHONE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `phone_number` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (POSTAL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method (PREF_CONTACT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mail|sms');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `privacy_consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Privacy Consent Timestamp (PRIV_CONSENT_TS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identifier (TAX_ID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{5,20}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `verification_method` SET TAGS ('dbx_business_glossary_term' = 'Verification Method (VERIF_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `verification_method` SET TAGS ('dbx_value_regex' = 'document|knowledge_based|biometric');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status (VERIF_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'unverified|verified|pending');
ALTER TABLE `power_and_utilities_v2`.`customer`.`person` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp (VERIF_TS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Business Entity ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `parent_company_business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Parent Company ID (PCI)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Annual Revenue (AR)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `annual_revenue` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `business_entity_status` SET TAGS ('dbx_business_glossary_term' = 'Entity Status (EST)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `business_entity_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `business_type` SET TAGS ('dbx_business_glossary_term' = 'Business Type (BT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `business_type` SET TAGS ('dbx_value_regex' = 'corporation|llc|government|nonprofit|partnership');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CTY)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|under_review');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country (CTRY)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating (CR)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `credit_rating` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing‑Business‑As Name (DBA)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Dun & Bradstreet Number (DUNS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^d{9}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EED)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (ESD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID (ERI)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `industry_classification` SET TAGS ('dbx_business_glossary_term' = 'Industry Classification (IC)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `is_key_account` SET TAGS ('dbx_business_glossary_term' = 'Key Account Flag (KAF)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `is_tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (TEF)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `last_annual_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Annual Review Date (LARD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `last_compliance_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Audit Date (LCAD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Business Name (LBN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Stage (LST)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `lifecycle_stage` SET TAGS ('dbx_value_regex' = 'prospect|active|terminated|archived');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region (MR)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `market_region` SET TAGS ('dbx_value_regex' = 'northeast|midwest|south|west');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `naics_code` SET TAGS ('dbx_business_glossary_term' = 'North American Industry Classification System Code (NAICS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Free‑Form Notes (NF)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `number_of_employees` SET TAGS ('dbx_business_glossary_term' = 'Number of Employees (NOE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `oracle_cis_account_code` SET TAGS ('dbx_business_glossary_term' = 'Oracle CIS Account ID (OCID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Method (PCM)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `preferred_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mail|portal');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language (PL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `preferred_language` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 1 (PAL1)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Primary Address Line 2 (PAL2)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email (PCE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name (PCN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone (PCP)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{7,15}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `registration_date` SET TAGS ('dbx_business_glossary_term' = 'Registration Date (RGD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `risk_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `salesforce_account_code` SET TAGS ('dbx_business_glossary_term' = 'Salesforce Account ID (SAID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (ST)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `subsidiary_count` SET TAGS ('dbx_business_glossary_term' = 'Subsidiary Count (SC)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason (TER)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_value_regex' = '^d{2}-d{7}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `tax_id_ein` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`business_entity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `census_tract` SET TAGS ('dbx_business_glossary_term' = 'Census Tract');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `construction_type` SET TAGS ('dbx_business_glossary_term' = 'Construction Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `construction_type` SET TAGS ('dbx_value_regex' = 'new|existing|renovated|modular|prefab');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `county` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `county` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `dwelling_units` SET TAGS ('dbx_business_glossary_term' = 'Number of Dwelling Units');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `gis_feature_code` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Degrees)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Degrees)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `lot_size_sqft` SET TAGS ('dbx_business_glossary_term' = 'Lot Size (Square Feet)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `meter_installed_flag` SET TAGS ('dbx_business_glossary_term' = 'Meter Installed Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `meter_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Serial Number');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `meter_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `meter_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'electric|gas|dual|none');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `premise_status` SET TAGS ('dbx_business_glossary_term' = 'Premise Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `premise_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `premise_type` SET TAGS ('dbx_business_glossary_term' = 'Premise Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `premise_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `property_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Property Owner Name');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `property_owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `property_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `regulatory_zone` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Zone');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `service_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Eligibility Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `zip_plus4` SET TAGS ('dbx_business_glossary_term' = 'ZIP+4 Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `zip_plus4` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `zip_plus4` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`premise` ALTER COLUMN `zip_plus4` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `customer_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Point ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `circuit_feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Circuit ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `ot_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `service_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Service Plan Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `vpp_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vpp Agreement Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type (Electricity or Gas)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'electric|gas');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `connection_type` SET TAGS ('dbx_business_glossary_term' = 'Connection Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `connection_type` SET TAGS ('dbx_value_regex' = 'overhead|underground|subterranean');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `enrollment_dr` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Enrollment Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `enrollment_nem` SET TAGS ('dbx_business_glossary_term' = 'NEM Enrollment Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `enrollment_tou` SET TAGS ('dbx_business_glossary_term' = 'TOU Enrollment Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `estimated_annual_consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Consumption (kWh)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `estimated_annual_consumption_mcf` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Consumption (MCF)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `load_profile_type` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `load_profile_type` SET TAGS ('dbx_value_regex' = 'flat|time_of_use|critical_peak|real_time_pricing');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `meter_installation_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Installation Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `meter_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Serial Number');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `outage_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Outage History Available');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_value_regex' = 'single|split|three');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `service_class` SET TAGS ('dbx_business_glossary_term' = 'Service Class');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `service_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `service_point_number` SET TAGS ('dbx_business_glossary_term' = 'Service Point Number');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Status Effective Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `voltage_class` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_service_point` ALTER COLUMN `voltage_class` SET TAGS ('dbx_value_regex' = 'low|medium|high|extra_high');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ACCOUNT_ID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUSTOMER_ID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (SERVICE_POINT_ID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `meter_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUSTOMER_ID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Number (AGREEMENT_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Agreement Type (AGREEMENT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government|other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renew Flag (AUTO_RENEW_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle (BILLING_CYCLE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'monthly|bimonthly|quarterly|semiannual|annual');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `billing_method` SET TAGS ('dbx_business_glossary_term' = 'Billing Method (BILLING_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `billing_method` SET TAGS ('dbx_value_regex' = 'paper|e_bill|auto_debit|direct_deposit');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type (COMMODITY_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'electric|gas|dual');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date (CONTRACT_END_DATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date (CONTRACT_START_DATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (MONTHS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `contract_term_years` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (YEARS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (CREDIT_LIMIT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount (DEPOSIT_AMOUNT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee (EARLY_TERMINATION_FEE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `enrollment_programs` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Programs (ENROLLMENT_PROGRAMS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `enrollment_programs` SET TAGS ('dbx_value_regex' = 'NEM|TOU|DR|None');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `estimated_annual_usage_mwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Usage (MWH)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `estimated_monthly_usage_kwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Monthly Usage (KWH)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `is_primary_agreement` SET TAGS ('dbx_business_glossary_term' = 'Primary Agreement Flag (IS_PRIMARY_AGREEMENT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `last_bill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bill Date (LAST_BILL_DATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `meter_read_cycle_days` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Cycle (READ_CYCLE_DAYS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type (METER_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'analog|digital|ami');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `net_metering_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Metering Flag (NET_METERING_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `next_bill_date` SET TAGS ('dbx_business_glossary_term' = 'Next Bill Date (NEXT_BILL_DATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Agreement Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms (PAYMENT_TERMS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net30|net45|net60|due_upon_receipt');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `rate_category` SET TAGS ('dbx_business_glossary_term' = 'Rate Category (RATE_CATEGORY)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `rate_category` SET TAGS ('dbx_value_regex' = 'fixed|variable|time_of_use|demand_response|tiered');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `regulatory_rate_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rate Code (REGULATORY_RATE_CODE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Agreement Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_agreement_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|closed');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_class` SET TAGS ('dbx_business_glossary_term' = 'Service Class (SERVICE_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government|other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Service Location Latitude (LATITUDE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Service Location Longitude (LONGITUDE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_status` SET TAGS ('dbx_business_glossary_term' = 'Service Status (SERVICE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `service_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|planned|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason (TERMINATION_REASON)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `contact_id` SET TAGS ('dbx_business_glossary_term' = 'Contact ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `alternate_email` SET TAGS ('dbx_business_glossary_term' = 'Alternate Email Address (ALT_EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `alternate_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `alternate_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `alternate_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `alternate_phone` SET TAGS ('dbx_business_glossary_term' = 'Alternate Phone Number (ALT_PHONE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `alternate_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `alternate_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Mailing City (CITY)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_bill_ready_email` SET TAGS ('dbx_business_glossary_term' = 'Consent for Bill Ready Email (CONSENT_BILL_EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_bill_ready_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_bill_ready_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_bill_ready_email_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bill Ready Email Consent Timestamp (CONSENT_BILL_EMAIL_TS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_bill_ready_email_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_bill_ready_email_timestamp` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_dr_event_push` SET TAGS ('dbx_business_glossary_term' = 'Consent for Demand‑Response Push Notification (CONSENT_DR_PUSH)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_dr_event_push_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Demand‑Response Push Consent Timestamp (CONSENT_DR_PUSH_TS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_marketing_email` SET TAGS ('dbx_business_glossary_term' = 'Consent for Marketing Email (CONSENT_MKT_EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_marketing_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_marketing_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_marketing_email_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Marketing Email Consent Timestamp (CONSENT_MKT_EMAIL_TS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_marketing_email_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_marketing_email_timestamp` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_outage_alert_sms` SET TAGS ('dbx_business_glossary_term' = 'Consent for Outage Alert SMS (CONSENT_OUTAGE_SMS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_outage_alert_sms_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage Alert SMS Consent Timestamp (CONSENT_OUTAGE_SMS_TS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_payment_confirmation_email` SET TAGS ('dbx_business_glossary_term' = 'Consent for Payment Confirmation Email (CONSENT_PAY_EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_payment_confirmation_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_payment_confirmation_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_payment_confirmation_email_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Confirmation Email Consent Timestamp (CONSENT_PAY_EMAIL_TS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_payment_confirmation_email_timestamp` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_payment_confirmation_email_timestamp` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_regulatory_notice_mail` SET TAGS ('dbx_business_glossary_term' = 'Consent for Regulatory Notice Mail (CONSENT_REG_MAIL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `consent_regulatory_notice_mail_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notice Mail Consent Timestamp (CONSENT_REG_MAIL_TS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_business_glossary_term' = 'Contact Role (ROLE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `contact_role` SET TAGS ('dbx_value_regex' = 'primary_holder|co_applicant|authorized_rep|emergency_contact|billing_contact|service_contact');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_business_glossary_term' = 'Contact Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `contact_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|deceased');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Country Code (CCODE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `country_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_business_glossary_term' = 'Date of Birth (DOB)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `date_of_birth` SET TAGS ('dbx_pii_dob' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `external_system_code` SET TAGS ('dbx_business_glossary_term' = 'External System Identifier (EXT_ID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_business_glossary_term' = 'First Name (FN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `first_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_business_glossary_term' = 'Full Legal Name (FLN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `full_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `gender` SET TAGS ('dbx_business_glossary_term' = 'Gender (GDR)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `gender` SET TAGS ('dbx_value_regex' = 'male|female|other|unknown');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `gender` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `gender` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference (LANG)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `language_preference` SET TAGS ('dbx_value_regex' = 'en|es|fr|de|zh|other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_business_glossary_term' = 'Last Name (LN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `last_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 1 (ADDR1)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `mailing_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address Line 2 (ADDR2)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `mailing_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_business_glossary_term' = 'Middle Name (MN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `middle_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_business_glossary_term' = 'Mobile Phone Number (MOBILE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `mobile_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Free‑Form Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Primary Phone Number (PHONE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Mailing Postal Code (ZIP)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_business_glossary_term' = 'Preferred Name (PN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `preferred_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Method (PCM)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `primary_contact_method` SET TAGS ('dbx_value_regex' = 'email|phone|mail|sms|mobile_push');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `puc_notification_opt_in` SET TAGS ('dbx_business_glossary_term' = 'PUC Notification Opt‑In (PUC_OPT_IN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status (REC_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'current|historical|archived');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'oracle_ccb|salesforce|mdm');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'Mailing State/Province (STATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `tcp_a_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'TCPA Compliance Flag (TCPA_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`contact` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` SET TAGS ('dbx_subdomain' = 'program_enrollment');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `annual_true_up_date` SET TAGS ('dbx_business_glossary_term' = 'Annual True‑Up Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `auto_pay_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Pay Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `auto_pay_method` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Pay Method');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `auto_pay_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_debit|ach');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'fixed|usage_based|tiered');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `care_fera_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'CARE/FERA Eligibility Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `care_fera_program_code` SET TAGS ('dbx_business_glossary_term' = 'CARE/FERA Program Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Channel');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|call_center|field|mobile_app');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `control_method` SET TAGS ('dbx_business_glossary_term' = 'Control Method');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `control_method` SET TAGS ('dbx_value_regex' = 'manual|automated|third_party');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `cpp_rate_type` SET TAGS ('dbx_business_glossary_term' = 'Critical Peak Pricing Rate Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `critical_peak_window` SET TAGS ('dbx_business_glossary_term' = 'Critical Peak Window');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `curtailment_obligation_kw` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Obligation (kW)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `enrolled_load_kw` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Load (kW)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|cancelled|pending|suspended');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `export_limit_kw` SET TAGS ('dbx_business_glossary_term' = 'Export Limit (kW)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `inverter_type` SET TAGS ('dbx_business_glossary_term' = 'Inverter Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `iso_rto_registration_ref` SET TAGS ('dbx_business_glossary_term' = 'ISO/RTO Registration Reference');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `liheap_assistance_flag` SET TAGS ('dbx_business_glossary_term' = 'LIHEAP Assistance Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `liheap_program_code` SET TAGS ('dbx_business_glossary_term' = 'LIHEAP Program Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `monthly_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Payment Amount');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `nem_version` SET TAGS ('dbx_business_glossary_term' = 'NEM Version');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `notification_lead_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Time (Hours)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `offpeak_hours` SET TAGS ('dbx_business_glossary_term' = 'Off‑Peak Hours');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `paperless_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `peak_hours` SET TAGS ('dbx_business_glossary_term' = 'Peak Hours');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `system_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'System Capacity (kW)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `tou_rate_plan_code` SET TAGS ('dbx_business_glossary_term' = 'TOU Rate Plan Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `true_up_balance` SET TAGS ('dbx_business_glossary_term' = 'True‑Up Balance');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `true_up_period_months` SET TAGS ('dbx_business_glossary_term' = 'True‑Up Period (Months)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `true_up_review_date` SET TAGS ('dbx_business_glossary_term' = 'True‑Up Review Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `move_order_id` SET TAGS ('dbx_business_glossary_term' = 'Move Order ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approval User ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `customer_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Old Service Point ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `actual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Service End Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `actual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Service Start Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `is_meter_read_required` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Required Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `meter_read_scheduled_date` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Scheduled Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `move_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Move Service Fee Amount');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `move_fee_tax` SET TAGS ('dbx_business_glossary_term' = 'Move Service Fee Tax');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `move_fee_total` SET TAGS ('dbx_business_glossary_term' = 'Move Service Fee Total');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `move_type` SET TAGS ('dbx_business_glossary_term' = 'Move Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `move_type` SET TAGS ('dbx_value_regex' = 'move_in|move_out|move_within');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Move Order Notes');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Move Order Number');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Move Order Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|completed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `order_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Move Order Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `processing_channel` SET TAGS ('dbx_business_glossary_term' = 'Processing Channel');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `processing_channel` SET TAGS ('dbx_value_regex' = 'online|call_center|branch|salesforce');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `regulatory_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `requested_end_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service End Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `requested_start_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Start Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `service_classification` SET TAGS ('dbx_business_glossary_term' = 'Service Classification');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `service_classification` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'electric|gas|dual');
ALTER TABLE `power_and_utilities_v2`.`customer`.`move_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `account_relationship_id` SET TAGS ('dbx_business_glossary_term' = 'Account Relationship Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `party_person_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Party Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level (AUTH_LEVEL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `authorization_level` SET TAGS ('dbx_value_regex' = 'full|limited|view_only');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `deposit_waiver_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Waiver Indicator');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `is_primary_contact` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Indicator');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `landlord_reversion_date` SET TAGS ('dbx_business_glossary_term' = 'Landlord Reversion Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Relationship Notes');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Notification Preference (NOTIF_PREF)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'email|sms|mail|none');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_business_glossary_term' = 'Relationship Status (REL_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `relationship_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_business_glossary_term' = 'Relationship Type (ACCOUNT_RELATIONSHIP_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `relationship_type` SET TAGS ('dbx_value_regex' = 'account_holder|co_applicant|guarantor|third_party_notification|landlord|authorized_representative');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `power_and_utilities_v2`.`customer`.`account_relationship` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `segment_id` SET TAGS ('dbx_business_glossary_term' = 'Segment Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `ami_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'AMI Eligibility Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `dr_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Eligibility Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `load_profile_class` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Class (LPC)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `load_profile_class` SET TAGS ('dbx_value_regex' = 'baseline|peak|offpeak|critical');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_business_glossary_term' = 'Segment Code (SEG)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `segment_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `segment_description` SET TAGS ('dbx_business_glossary_term' = 'Segment Description');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `segment_name` SET TAGS ('dbx_business_glossary_term' = 'Segment Name (SEG)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_business_glossary_term' = 'Segment Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `segment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_business_glossary_term' = 'Segment Tier (RCI)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `segment_tier` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `sub_segment` SET TAGS ('dbx_business_glossary_term' = 'Sub‑Segment (SUB)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`segment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `communication_preference_id` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `bill_ready_channel` SET TAGS ('dbx_business_glossary_term' = 'Bill Ready Notification Channel');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `bill_ready_channel` SET TAGS ('dbx_value_regex' = 'email|sms|ivr|paper_mail|mobile_app_push');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `bill_ready_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Bill Ready Opt‑In Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `communication_preference_source` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference Source System');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `communication_preference_source` SET TAGS ('dbx_value_regex' = 'cisc|salesforce|self_service_portal');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `communication_preference_status` SET TAGS ('dbx_business_glossary_term' = 'Communication Preference Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `communication_preference_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Consent Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `consent_version` SET TAGS ('dbx_business_glossary_term' = 'Consent Policy Version');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `do_not_contact` SET TAGS ('dbx_business_glossary_term' = 'Do‑Not‑Contact Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `dr_event_notification_channel` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Event Notification Channel');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `dr_event_notification_channel` SET TAGS ('dbx_value_regex' = 'email|sms|ivr|paper_mail|mobile_app_push');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `dr_event_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Event Opt‑In Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `opt_out_all` SET TAGS ('dbx_business_glossary_term' = 'Opt‑Out All Communications Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `outage_alert_channel` SET TAGS ('dbx_business_glossary_term' = 'Outage Alert Notification Channel');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `outage_alert_channel` SET TAGS ('dbx_value_regex' = 'email|sms|ivr|paper_mail|mobile_app_push');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `outage_alert_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Outage Alert Opt‑In Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `payment_confirmation_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Confirmation Notification Channel');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `payment_confirmation_channel` SET TAGS ('dbx_value_regex' = 'email|sms|ivr|paper_mail|mobile_app_push');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `payment_confirmation_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Payment Confirmation Opt‑In Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `preference_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Preference Effective Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `preference_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Preference Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `preference_last_verified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Preference Last Verified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `preference_notes` SET TAGS ('dbx_business_glossary_term' = 'Preference Notes');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `preference_update_reason` SET TAGS ('dbx_business_glossary_term' = 'Preference Update Reason');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `preference_verification_method` SET TAGS ('dbx_business_glossary_term' = 'Preference Verification Method');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `preference_verification_method` SET TAGS ('dbx_value_regex' = 'email|sms|phone|in_person');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `preferred_contact_time_end` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Time End');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `preferred_contact_time_start` SET TAGS ('dbx_business_glossary_term' = 'Preferred Contact Time Start');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `preferred_language` SET TAGS ('dbx_business_glossary_term' = 'Preferred Language');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `regulatory_notice_channel` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notice Notification Channel');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `regulatory_notice_channel` SET TAGS ('dbx_value_regex' = 'email|sms|ivr|paper_mail|mobile_app_push');
ALTER TABLE `power_and_utilities_v2`.`customer`.`communication_preference` ALTER COLUMN `regulatory_notice_opt_in` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notice Opt‑In Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `credit_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `collections_status_flag` SET TAGS ('dbx_business_glossary_term' = 'Collections Status Flag (CSF)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `credit_class` SET TAGS ('dbx_business_glossary_term' = 'Credit Class (CCL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `credit_class` SET TAGS ('dbx_value_regex' = 'A|B|C|D|E');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `credit_limit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Amount (CLA)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Review Date (CRD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `credit_score_band` SET TAGS ('dbx_business_glossary_term' = 'Credit Score Band (CSB)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `credit_score_band` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|bad');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Profile Status (CPS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Amount (DEP)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `deposit_type` SET TAGS ('dbx_business_glossary_term' = 'Deposit Type (DEP_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `deposit_type` SET TAGS ('dbx_value_regex' = 'cash|surety_bond|letter_of_credit');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `deposit_waiver_reason` SET TAGS ('dbx_business_glossary_term' = 'Deposit Waiver Reason (DEP_WVR)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `last_collection_attempt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Collection Attempt Date (LCAD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NTS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `payment_history_score` SET TAGS ('dbx_business_glossary_term' = 'Payment History Score (PHS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating (RR)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `power_and_utilities_v2`.`customer`.`credit_profile` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` SET TAGS ('dbx_subdomain' = 'program_enrollment');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `medical_baseline_id` SET TAGS ('dbx_business_glossary_term' = 'Medical Baseline Record ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `medical_baseline_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `medical_baseline_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `certification_date` SET TAGS ('dbx_business_glossary_term' = 'Certification Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `disconnection_protection_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Disconnection Protection Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `disconnection_protection_status` SET TAGS ('dbx_business_glossary_term' = 'Disconnection Protection Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `disconnection_protection_status` SET TAGS ('dbx_value_regex' = 'protected|not_protected|pending');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `enrollment_end_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment End Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `enrollment_start_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Start Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `equipment_last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Equipment Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `equipment_maintenance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Equipment Maintenance Required Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_business_glossary_term' = 'Equipment Serial Number');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `equipment_serial_number` SET TAGS ('dbx_pii_device' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `equipment_type` SET TAGS ('dbx_business_glossary_term' = 'Equipment Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `equipment_type` SET TAGS ('dbx_value_regex' = 'oxygen_concentrator|dialysis|ventilator|other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `exemption_reason` SET TAGS ('dbx_business_glossary_term' = 'Exemption Reason');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `physician_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Physician Certified Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `physician_name` SET TAGS ('dbx_business_glossary_term' = 'Physician Name');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `physician_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `physician_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `physician_npi` SET TAGS ('dbx_business_glossary_term' = 'Physician NPI (National Provider Identifier)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `physician_npi` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `physician_npi` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type (Medical Baseline Allowance, Life Support Equipment, Serious Illness)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'medical_baseline_allowance|life_support_equipment|serious_illness');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `rate_discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Discount Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `rate_discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `rate_discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `rate_discount_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Discount Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `recertification_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Recertification Completed Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`medical_baseline` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `third_party_access_id` SET TAGS ('dbx_business_glossary_term' = 'Third Party Access ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `access_category` SET TAGS ('dbx_business_glossary_term' = 'Access Category');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `access_category` SET TAGS ('dbx_value_regex' = 'read|write|read_write');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `access_reference_code` SET TAGS ('dbx_business_glossary_term' = 'Access Reference Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `authorization_scope` SET TAGS ('dbx_business_glossary_term' = 'Authorization Scope');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `authorization_scope` SET TAGS ('dbx_value_regex' = 'usage|billing|account|all');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `consent_channel` SET TAGS ('dbx_business_glossary_term' = 'Consent Channel');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `consent_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|phone|email|in_person');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `consent_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Customer Consent Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `data_types_shared` SET TAGS ('dbx_business_glossary_term' = 'Data Types Shared');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Access Notes');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `privacy_policy_url` SET TAGS ('dbx_business_glossary_term' = 'Privacy Policy URL');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `revocation_status` SET TAGS ('dbx_business_glossary_term' = 'Revocation Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `revocation_status` SET TAGS ('dbx_value_regex' = 'active|revoked|expired');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `revocation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Revocation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `third_party_access_status` SET TAGS ('dbx_business_glossary_term' = 'Access Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `third_party_access_status` SET TAGS ('dbx_value_regex' = 'pending|active|suspended|terminated|expired');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `third_party_type` SET TAGS ('dbx_business_glossary_term' = 'Third Party Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `third_party_type` SET TAGS ('dbx_value_regex' = 'energy_advisor|solar_installer|ev_charging|der_aggregator|retail_marketer|other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`third_party_access` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` SET TAGS ('dbx_subdomain' = 'program_enrollment');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `nem_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Agreement Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `asset_permit_compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'NEM Agreement Number');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'NEM Agreement Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'NEM|NEM_2_0|NEM_3_0|Other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `annual_true_up_date` SET TAGS ('dbx_business_glossary_term' = 'Annual True‑Up Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `application_date` SET TAGS ('dbx_business_glossary_term' = 'NEM Application Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'NEM Approval Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Agreement Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'NEM Eligibility Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `export_limit_kw` SET TAGS ('dbx_business_glossary_term' = 'Export Limit (kW)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `interconnection_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `interconnection_status` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `interconnection_status` SET TAGS ('dbx_value_regex' = 'applied|approved|installed|operational|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `inverter_type` SET TAGS ('dbx_business_glossary_term' = 'Inverter Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `metered_export_kwh_year` SET TAGS ('dbx_business_glossary_term' = 'Annual Exported Energy (kWh)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `metered_import_kwh_year` SET TAGS ('dbx_business_glossary_term' = 'Annual Imported Energy (kWh)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `nem_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'NEM Agreement Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `nem_agreement_status` SET TAGS ('dbx_value_regex' = 'draft|pending|active|suspended|terminated|closed');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `net_metering_cap_kwh` SET TAGS ('dbx_business_glossary_term' = 'Net Metering Cap (kWh)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `net_metering_credits` SET TAGS ('dbx_business_glossary_term' = 'Net Metering Credits ($)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `net_metering_enrollment_flag` SET TAGS ('dbx_business_glossary_term' = 'NEM Enrollment Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `net_metering_program_code` SET TAGS ('dbx_business_glossary_term' = 'NEM Program Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `net_metering_rate` SET TAGS ('dbx_business_glossary_term' = 'Net Metering Rate ($/kWh)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `program_version` SET TAGS ('dbx_business_glossary_term' = 'NEM Program Version');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `system_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'System Capacity (kW)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Agreement Termination Reason');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `true_up_period_months` SET TAGS ('dbx_business_glossary_term' = 'True‑Up Period (Months)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`nem_agreement` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Version Number');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` SET TAGS ('dbx_subdomain' = 'program_enrollment');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `dr_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Enrollment ID (DREID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID (AID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID (CID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID (SPID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `control_method` SET TAGS ('dbx_business_glossary_term' = 'Control Method (CM)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `control_method` SET TAGS ('dbx_value_regex' = 'direct_switch|smart_thermostat|customer_controlled|automated|manual');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `curtailment_obligation_kw` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Obligation (kW) (COKW)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `demand_response_category` SET TAGS ('dbx_business_glossary_term' = 'DR Category (DRC)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `demand_response_category` SET TAGS ('dbx_value_regex' = 'capacity|energy|price|ancillary');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Effective Date (EED)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `enrollment_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Creation Timestamp (ERCT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `enrollment_notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes (EN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source (ESRC)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'cisc|salesforce|manual|api');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ES)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|suspended|terminated|pending|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Type (ET)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `enrollment_type` SET TAGS ('dbx_value_regex' = 'interruptible|direct_load_control|auto_dr|vpp_participation');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `enrollment_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Record Update Timestamp (ERUT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `enrollment_version` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Version (EV)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `is_test_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Test Enrollment Indicator (TEI)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `iso_rto_registration_ref` SET TAGS ('dbx_business_glossary_term' = 'ISO/RTO Registration Reference (IRR)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `last_dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Dispatch Timestamp (LDT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `load_enrolled_kw` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Load (kW) (ELKW)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `notification_lead_time_min` SET TAGS ('dbx_business_glossary_term' = 'Notification Lead Time (minutes) (NLT)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Participation Flag (PF)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Program Code (DRPC)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Program Name (DRPN)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`dr_enrollment` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Termination Date (ETD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` SET TAGS ('dbx_subdomain' = 'program_enrollment');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `budget_billing_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Plan Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `auto_renew_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto‑Renew Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Budget Amount');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `budget_billing_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Plan Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `budget_billing_plan_status` SET TAGS ('dbx_value_regex' = 'active|suspended|cancelled|pending|closed');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_business_glossary_term' = 'Calculation Basis');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `calculation_basis` SET TAGS ('dbx_value_regex' = 'prior_12_month_average|forecasted|custom');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'customer_request|non_payment|regulatory|other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `cumulative_true_up_balance` SET TAGS ('dbx_business_glossary_term' = 'Cumulative True‑Up Balance');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `discount_flag` SET TAGS ('dbx_business_glossary_term' = 'Discount Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `enrollment_programs` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Programs');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'auto_debit|check|credit_card|online|other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `plan_end_date` SET TAGS ('dbx_business_glossary_term' = 'Plan End Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `plan_review_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Review Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `plan_start_date` SET TAGS ('dbx_business_glossary_term' = 'Plan Start Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_value_regex' = 'budget|levelized|fixed|variable');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `suspension_flag` SET TAGS ('dbx_business_glossary_term' = 'Suspension Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `true_up_month` SET TAGS ('dbx_business_glossary_term' = 'True‑Up Month');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`budget_billing_plan` ALTER COLUMN `usage_average_12_month_kwh` SET TAGS ('dbx_business_glossary_term' = '12‑Month Average Usage (kWh)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` SET TAGS ('dbx_subdomain' = 'service_delivery');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `area_sq_mi` SET TAGS ('dbx_business_glossary_term' = 'Territory Area (AREA_SQ_MI)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type (COMMODITY_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'electric|gas');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `county_list` SET TAGS ('dbx_business_glossary_term' = 'County List (COUNTY_LIST)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRATION_DATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `gis_polygon_code` SET TAGS ('dbx_business_glossary_term' = 'GIS Polygon Identifier (GIS_POLYGON_ID)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `is_cross_state` SET TAGS ('dbx_business_glossary_term' = 'Cross‑State Flag (IS_CROSS_STATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `is_dr_eligible` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Eligibility Flag (IS_DR_ELIGIBLE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `is_nem_eligible` SET TAGS ('dbx_business_glossary_term' = 'NEM Eligibility Flag (IS_NEM_ELIGIBLE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `is_tou_eligible` SET TAGS ('dbx_business_glossary_term' = 'TOU Eligibility Flag (IS_TOU_ELIGIBLE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `jurisdiction_puc` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction PUC Docket (JURISDICTION_PUC)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State (JURISDICTION_STATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `last_regulatory_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Review Date (LAST_REGULATORY_REVIEW_DATE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `municipality_list` SET TAGS ('dbx_business_glossary_term' = 'Municipality List (MUNICIPALITY_LIST)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `primary_rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Primary Rate Schedule Code (PRIMARY_RATE_SCHEDULE_CODE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `rate_zone` SET TAGS ('dbx_business_glossary_term' = 'Rate Zone (RATE_ZONE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `regulatory_docket_url` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Docket URL (REGULATORY_DOCKET_URL)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `regulatory_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction (REGULATORY_JURISDICTION)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `service_territory_description` SET TAGS ('dbx_business_glossary_term' = 'Territory Description (DESCRIPTION)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `service_territory_status` SET TAGS ('dbx_business_glossary_term' = 'Territory Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `service_territory_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type (SERVICE_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|mixed');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYSTEM)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code (TERRITORY_CODE)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `territory_name` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Name (TERRITORY_NAME)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`service_territory` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `interaction_id` SET TAGS ('dbx_business_glossary_term' = 'Interaction ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Agent ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `followup_to_interaction_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `agent_name` SET TAGS ('dbx_business_glossary_term' = 'Agent Name');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Contact Channel');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|web|ivr|chat|in_person');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `cost_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Interaction Cost');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `cost_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Interaction Cost');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `cost_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Interaction Tax Amount');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Interaction Duration (Seconds)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `escalation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Escalation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `follow_up_due_date` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Due Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `interaction_description` SET TAGS ('dbx_business_glossary_term' = 'Interaction Description');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `interaction_number` SET TAGS ('dbx_business_glossary_term' = 'Interaction Number');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_business_glossary_term' = 'Interaction Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `interaction_status` SET TAGS ('dbx_value_regex' = 'open|resolved|closed|pending');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `interaction_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Interaction Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_business_glossary_term' = 'Interaction Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `interaction_type` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `is_chargeable_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeable Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `language_preference` SET TAGS ('dbx_business_glossary_term' = 'Language Preference');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Interaction Notes');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `outcome_code` SET TAGS ('dbx_business_glossary_term' = 'Outcome Code');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `outcome_description` SET TAGS ('dbx_business_glossary_term' = 'Outcome Description');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'resolved|unresolved|escalated');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `satisfaction_score` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Score');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `subject` SET TAGS ('dbx_business_glossary_term' = 'Interaction Subject');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `survey_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Survey Completed Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `survey_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`interaction` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` SET TAGS ('dbx_subdomain' = 'customer_interaction');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `complaint_id` SET TAGS ('dbx_business_glossary_term' = 'Complaint Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `move_order_id` SET TAGS ('dbx_business_glossary_term' = 'Related Order Identifier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `escalated_from_complaint_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `actual_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Resolution Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `attached_document_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Attached Documents');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Complaint Submission Channel');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'phone|email|web|in_person|mail');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency Code (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_business_glossary_term' = 'Complaint Category');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `complaint_category` SET TAGS ('dbx_value_regex' = 'billing|operations|safety|regulatory|customer_service');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `complaint_description` SET TAGS ('dbx_business_glossary_term' = 'Complaint Description');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Complaint Number (COMPLAINT_NO)');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_business_glossary_term' = 'Complaint Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `complaint_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|resolved|closed|rejected');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `complaint_type` SET TAGS ('dbx_business_glossary_term' = 'Complaint Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `complaint_type` SET TAGS ('dbx_value_regex' = 'billing|service_quality|safety|regulatory|other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `escalated_to_department` SET TAGS ('dbx_business_glossary_term' = 'Escalated To Department');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Indicator');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `internal_notes` SET TAGS ('dbx_business_glossary_term' = 'Internal Notes');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Complaint Priority');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Complaint Received Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `regulatory_filing_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Indicator');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `regulatory_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Reference Number');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `resolution_status` SET TAGS ('dbx_business_glossary_term' = 'Resolution Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `resolution_status` SET TAGS ('dbx_value_regex' = 'pending|resolved|closed|escalated|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Completion Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'CC&B|Salesforce|Other');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `target_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Target Resolution Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`complaint` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` SET TAGS ('dbx_subdomain' = 'account_management');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` SET TAGS ('dbx_association_edges' = 'customer.customer_account,engagement.ci_account');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `customer_account_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Account Plan Id');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Ci Account Id');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Customer Account Id');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `key_account_manager_id` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Key Account Manager Id');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `account_tier` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Account Tier');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Approval Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Approved By');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Approved Date');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `budget_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Budget Amount Usd');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `capital_investment_opportunities` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Capital Investment Opportunities');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `competitive_threats` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Competitive Threats');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `dr_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Dr Participation Flag');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Effective From');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Effective Until');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `identified_risks` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Identified Risks');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `load_growth_target_kw` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Load Growth Target Kw');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `plan_status` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Plan Status');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `plan_type` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Plan Type');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `plan_year` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Plan Year');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `planned_touchpoints` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Planned Touchpoints');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `program_enrollment_target_dr` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Program Enrollment Target Dr');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `revenue_retention_target_usd` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Revenue Retention Target Usd');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Risk Rating');
ALTER TABLE `power_and_utilities_v2`.`customer`.`customer_account_plan` ALTER COLUMN `strategic_objectives` SET TAGS ('dbx_business_glossary_term' = 'Account Plan - Strategic Objectives');
