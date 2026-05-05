-- Schema for Domain: product | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`product` COMMENT 'Owns the utility rate and service product catalog including electric and gas rate schedules, tariff riders, demand response programs, DER/NEM offerings, energy efficiency programs, and commercial service plans. Serves as the SSOT for rate code definitions, eligibility rules, TOU/CPP/RTP pricing structures, and program terms filed with state PUCs. Feeds billing rate engine and customer enrollment.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`rate_schedule` (
    `rate_schedule_id` BIGINT COMMENT 'Primary key for rate_schedule',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Regulatory docket approval is required for each rate schedule; linking enables docket tracking for rate case filings.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue posting process requires each rate schedule to map to a GL account for monthly revenue statements; utility accountants expect this direct link.',
    `approval_status` STRING COMMENT 'State of regulatory filing and approval with the PUC.. Valid values are `approved|pending|rejected|under_review`',
    `cap_exempt_flag` BOOLEAN COMMENT 'True if the rate schedule is exempt from regulatory caps.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rate schedule record was first created in the system.',
    `customer_class` STRING COMMENT 'Customer segment for which the rate schedule is defined.. Valid values are `residential|commercial|industrial|municipal`',
    `demand_charge` DECIMAL(18,2) COMMENT 'Charge based on peak demand measured in the demand charge unit.',
    `demand_charge_unit` STRING COMMENT 'Unit for the demand charge measurement.. Valid values are `kW|MW`',
    `effective_date` DATE COMMENT 'Date when the rate schedule becomes legally effective.',
    `eligibility_criteria` STRING COMMENT 'Text describing any eligibility rules for the rate schedule (e.g., income‑based, load‑based).',
    `enrollment_deadline` DATE COMMENT 'Final date by which customers may enroll in the program.',
    `enrollment_required` BOOLEAN COMMENT 'Indicates whether customers must enroll to receive the rate.',
    `expiration_date` DATE COMMENT 'Date when the rate schedule expires; null if open‑ended.',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance or rate review.',
    `max_participation` STRING COMMENT 'Maximum number of customers allowed to enroll in the program.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum monthly charge regardless of usage.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Base price applied to each unit of the selected measure.',
    `program_name` STRING COMMENT 'Name of the associated program, if the rate schedule is part of a program.',
    `program_type` STRING COMMENT 'Category of the program linked to the rate schedule.. Valid values are `demand_response|energy_efficiency|net_metering|renewable_certificate`',
    `rate_category` STRING COMMENT 'Broad pricing model classification of the rate schedule.. Valid values are `TOU|CPP|RTP|Fixed|Tiered`',
    `rate_schedule_code` STRING COMMENT 'Official tariff code assigned by the utility and filed with the PUC.. Valid values are `^[A-Z0-9-]+$`',
    `rate_schedule_description` STRING COMMENT 'Narrative description of the rate schedule, including any special provisions.',
    `rate_schedule_status` STRING COMMENT 'Current operational status of the rate schedule.. Valid values are `active|inactive|pending|retired|draft`',
    `rate_structure` STRING COMMENT 'Technical classification of how the price is applied.. Valid values are `flat|tiered|block|time_of_use`',
    `regulatory_approval_date` DATE COMMENT 'Date the PUC formally approved the rate schedule.',
    `seasonal_end_date` DATE COMMENT 'Last calendar date of the seasonal period.',
    `seasonal_period` STRING COMMENT 'Seasonal grouping that may affect pricing.. Valid values are `summer|winter|shoulder|all_year`',
    `seasonal_start_date` DATE COMMENT 'First calendar date of the seasonal period.',
    `service_type` STRING COMMENT 'Indicates whether the rate schedule applies to electricity or natural gas service.. Valid values are `electric|gas`',
    `source_system` STRING COMMENT 'System where the rate schedule originated (e.g., Oracle CC&B, SAP ERP).. Valid values are `CC&B|SAP|MDM|ETRM|Other`',
    `time_of_use_end` STRING COMMENT 'End time of the defined TOU period (24‑hour clock).. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `time_of_use_period` STRING COMMENT 'Label for the TOU band to which the price applies.. Valid values are `peak|offpeak|midpeak|superpeak`',
    `time_of_use_start` STRING COMMENT 'Start time of the defined TOU period (24‑hour clock).. Valid values are `^([01]d|2[0-3]):[0-5]d$`',
    `unit_of_measure` STRING COMMENT 'Measurement unit used for the primary energy charge.. Valid values are `kWh|MCF|Therm|kW|MWh`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rate schedule record.',
    CONSTRAINT pk_rate_schedule PRIMARY KEY(`rate_schedule_id`)
) COMMENT 'Master catalog of all electric and gas rate schedules filed with state PUCs. Each record defines a tariff code (e.g., RS-1, GS-2, TOU-D), service type (electric/gas), customer class (residential, commercial, industrial), effective and expiration dates, regulatory approval status, and the PUC docket reference. Serves as the SSOT for rate code definitions consumed by the billing rate engine and customer enrollment systems.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` (
    `product_tariff_rider_id` BIGINT COMMENT 'Unique surrogate key for the tariff rider record.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Tariff riders are filed with the regulator; FK allows associating each rider with its filing record for compliance reporting.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Tariff riders supplement a base rate schedule; linking provides parent schedule context.',
    `calculation_method` STRING COMMENT 'Method used to calculate the rider charge.. Valid values are `per_kwh|per_therm|fixed|percentage`',
    `calculation_value` DECIMAL(18,2) COMMENT 'Numeric factor used in the calculation method (e.g., $0.02 per kWh).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rider record was created in the system.',
    `effective_end_date` DATE COMMENT 'Date the rider expires; null if the rider has no scheduled end.',
    `effective_start_date` DATE COMMENT 'Date the rider becomes effective and may be applied to customer bills.',
    `eligibility_criteria` STRING COMMENT 'Textual criteria that define which customers are eligible for the rider.',
    `eligibility_customer_type` STRING COMMENT 'Customer segment to which the rider applies.. Valid values are `residential|commercial|industrial|government|agricultural`',
    `eligibility_program` STRING COMMENT 'Name of the program or assistance (e.g., Low Income Assistance) that the rider supports.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this rider is the default option for its associated rate schedule.',
    `is_taxable` BOOLEAN COMMENT 'Flag indicating if the rider charge is subject to tax.',
    `notes` STRING COMMENT 'Free‑form notes or comments about the rider.',
    `product_tariff_rider_description` STRING COMMENT 'Full description of the rider, including purpose and application details.',
    `product_tariff_rider_status` STRING COMMENT 'Current lifecycle status of the rider.. Valid values are `active|inactive|retired|pending`',
    `regulatory_filing_date` DATE COMMENT 'Date the rider was filed with the regulator.',
    `rider_code` STRING COMMENT 'Unique code assigned to the tariff rider as defined in the rate schedule.',
    `rider_name` STRING COMMENT 'Human‑readable name of the tariff rider.',
    `rider_type` STRING COMMENT 'Category of the rider indicating its purpose or regulatory basis.. Valid values are `fuel_adjustment|renewable|infrastructure|low_income|transmission|demand_response`',
    `tax_rate` DECIMAL(18,2) COMMENT 'Applicable tax rate (e.g., 0.0750 for 7.5%) when the rider is taxable.',
    `unit_of_measure` STRING COMMENT 'Unit associated with the calculation value.. Valid values are `kwh|therm|kw|mwh|percent`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the rider record.',
    `version_number` STRING COMMENT 'Version number of the rider definition; increments on each change.',
    CONSTRAINT pk_product_tariff_rider PRIMARY KEY(`product_tariff_rider_id`)
) COMMENT 'Catalog of all tariff riders and surcharges that supplement base rate schedules, including fuel adjustment clauses (FAC), renewable portfolio standard (RPS) riders, infrastructure surcharges, low-income assistance riders, and transmission cost adjustment riders. Tracks rider code, description, applicable rate schedules, calculation method (per-kWh, per-therm, fixed), effective dates, and PUC filing reference. Riders are additive to base rates and must be versioned independently.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`product_rate_component` (
    `product_rate_component_id` BIGINT COMMENT 'System-generated unique identifier for the rate component record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Component‑level billing posts to specific GL accounts; regulatory reporting of component revenue/expense mandates this FK.',
    `rate_schedule_id` BIGINT COMMENT 'Identifier of the parent rate schedule to which this component belongs.',
    `accounting_code` STRING COMMENT 'General ledger accounting code for financial posting of this component.',
    `applicable_period` STRING COMMENT 'Time‑of‑use period to which the component applies.. Valid values are `on_peak|off_peak|all_day|mid_peak|shoulder`',
    `calculation_method` STRING COMMENT 'Indicates the complexity of the pricing calculation.. Valid values are `simple|complex|formula_based`',
    `charge_basis` STRING COMMENT 'Method used to calculate the charge.. Valid values are `per_unit|flat_fee|tiered|minimum|maximum`',
    `component_code` STRING COMMENT 'Business identifier code used in rate schedules and regulatory filings.',
    `component_name` STRING COMMENT 'Human‑readable name of the rate component, e.g., "Energy Charge" or "Demand Charge".',
    `component_type` STRING COMMENT 'Category of the charge component. [ENUM-REF-CANDIDATE: energy|demand|distribution|transmission|tax|fee|adjustment — 7 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'Internal cost‑center to which the components cost is allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the component record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the component ceases to be effective; null for open‑ended.',
    `effective_start_date` DATE COMMENT 'Date on which the component becomes effective for billing.',
    `eligibility_criteria` STRING COMMENT 'Business rules that determine which customers or service points may be charged by this component.',
    `is_default_component` BOOLEAN COMMENT 'Indicates whether this component is the default option for the schedule.',
    `last_modified_by` STRING COMMENT 'User identifier of the person who performed the last update.',
    `maximum_charge` DECIMAL(18,2) COMMENT 'Ceiling amount that will not be exceeded for this component.',
    `measurement_multiplier` DECIMAL(18,2) COMMENT 'Factor applied to the raw meter reading before pricing (e.g., conversion factor).',
    `metered_quantity_type` STRING COMMENT 'Specifies whether the component is based on consumption, demand, or capacity measurement.. Valid values are `consumption|demand|capacity`',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Floor amount that will be charged regardless of usage.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or operational comments.',
    `price_amount` DECIMAL(18,2) COMMENT 'Monetary amount associated with the component before taxes or fees.',
    `price_currency` STRING COMMENT 'Three‑letter ISO currency code for the price amount.. Valid values are `USD|CAD|EUR|GBP`',
    `product_rate_component_description` STRING COMMENT 'Narrative description of the component, including any special conditions.',
    `product_rate_component_status` STRING COMMENT 'Current lifecycle status of the component.. Valid values are `active|inactive|retired|pending`',
    `regulatory_approval_date` DATE COMMENT 'Date on which the component received regulatory approval, if required.',
    `regulatory_approval_status` STRING COMMENT 'Current status of regulatory approval.. Valid values are `approved|pending|rejected`',
    `regulatory_filing_code` STRING COMMENT 'Code used in filings with state PUCs or FERC for this component.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the component is exempt from applicable taxes.',
    `tier_lower_bound` DECIMAL(18,2) COMMENT 'Inclusive lower usage bound for the tier (in the unit of measure).',
    `tier_number` STRING COMMENT 'Ordinal number of the tier when the component uses tiered pricing.',
    `tier_upper_bound` DECIMAL(18,2) COMMENT 'Inclusive upper usage bound for the tier (in the unit of measure).',
    `unit_of_measure` STRING COMMENT 'Unit used to express the charge (e.g., kilowatt‑hour, kilowatt, therm).. Valid values are `kWh|MWh|kW|therm|USD|percent`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the component record.',
    `version_number` STRING COMMENT 'Version of the component record for change‑tracking.',
    CONSTRAINT pk_product_rate_component PRIMARY KEY(`product_rate_component_id`)
) COMMENT 'Granular decomposition of a rate schedule into its individual charge components: customer charge, energy charge (per kWh or therm), demand charge (per kW), distribution charge, transmission charge, taxes, and fees. Each component record specifies the component type, unit of measure, charge basis, and whether it applies to on-peak, off-peak, or all periods. Enables the billing engine to calculate line-item charges from interval meter data.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`tou_period` (
    `tou_period_id` BIGINT COMMENT 'Primary key for tou_period',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key to the parent rate schedule that includes this TOU period.',
    `rate_season_calendar_id` BIGINT COMMENT 'Foreign key to the season calendar that groups periods by season.',
    `season_rate_season_calendar_id` BIGINT COMMENT 'Foreign key to the season calendar that groups periods by season.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the period record was first created.',
    `day_type` STRING COMMENT 'Day category for which the period definition applies.. Valid values are `weekday|weekend|holiday`',
    `effective_from` DATE COMMENT 'Date when this period definition becomes effective.',
    `effective_until` DATE COMMENT 'Date when this period definition expires; null if indefinite.',
    `end_time` TIMESTAMP COMMENT 'Clock time (HH:MM, 24‑hour) when the period ends.',
    `is_critical_peak` BOOLEAN COMMENT 'Flag indicating if the period is designated as a critical‑peak period for CPP or RTP tariffs.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this period is the default when no other period matches.',
    `max_charge` DECIMAL(18,2) COMMENT 'Maximum monetary charge cap for usage within this period.',
    `min_charge` DECIMAL(18,2) COMMENT 'Minimum monetary charge that must be applied for usage within this period.',
    `peak_price_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to the base energy price during this period (e.g., 1.250).',
    `period_code` STRING COMMENT 'Business‑unique alphanumeric code used to reference the period in rate schedules.',
    `period_name` STRING COMMENT 'Human‑readable name of the TOU pricing period (e.g., "On‑Peak Morning").',
    `period_type` STRING COMMENT 'Classification of the period based on pricing tier.. Valid values are `on_peak|mid_peak|off_peak|super_off_peak|critical_peak`',
    `priority_order` STRING COMMENT 'Numeric order used to resolve overlapping periods; lower numbers have higher priority.',
    `start_time` TIMESTAMP COMMENT 'Clock time (HH:MM, 24‑hour) when the period begins.',
    `time_zone` STRING COMMENT 'Time‑zone identifier (e.g., "EST", "PST") that applies to the start and end times.',
    `tou_period_status` STRING COMMENT 'Current lifecycle status of the period definition.. Valid values are `active|inactive|retired|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the period record.',
    CONSTRAINT pk_tou_period PRIMARY KEY(`tou_period_id`)
) COMMENT 'Defines Time-of-Use (TOU) pricing period windows for rate schedules implementing time-differentiated pricing. Each record specifies period name (on-peak, mid-peak, off-peak, super-off-peak, critical-peak), applicable day types (weekday, weekend, holiday), start and end clock times, season assignment via rate_season_calendar, and the parent rate schedule. Supports TOU, CPP (Critical Peak Pricing), and RTP (Real-Time Pricing) tariff structures. Referenced by rate components to apply period-specific energy and demand charges.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`rate_tier` (
    `rate_tier_id` BIGINT COMMENT 'System-generated unique identifier for the rate tier record.',
    `billing_rate_component_id` BIGINT COMMENT 'Identifier of the parent rate component to which this tier belongs.',
    `product_rate_component_id` BIGINT COMMENT 'Foreign key linking to product.product_rate_component. Business justification: Rate tiers are defined per rate component; linking enables hierarchical pricing.',
    `baseline_method` STRING COMMENT 'Method used to calculate baseline allowances for the tier (e.g., average usage for the territory, household size, or a custom calculation).. Valid values are `territory_average|household_size|custom`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the tier record was first created in the system.',
    `discount_indicator` STRING COMMENT 'Flag indicating special discount eligibility for the tier (e.g., CARE, FERA, senior citizen).. Valid values are `none|care|fera|senior|veteran|low_income`',
    `effective_date` DATE COMMENT 'Date on which the tier becomes effective for billing.',
    `expiration_date` DATE COMMENT 'Date on which the tier ceases to be effective; null if open‑ended.',
    `lower_bound_kwh` DECIMAL(18,2) COMMENT 'Minimum consumption (in kilowatt‑hours) for which this tiers unit price applies.',
    `price_currency` STRING COMMENT 'Three‑letter ISO currency code for the unit_price; typically USD for US utilities.. Valid values are `USD`',
    `price_unit` STRING COMMENT 'Monetary unit combined with the energy unit that defines how the unit_price is expressed.. Valid values are `USD/kWh|USD/MWh|USD/therm|USD/MCF`',
    `rate_tier_status` STRING COMMENT 'Current lifecycle status of the tier definition.. Valid values are `active|inactive|retired|pending`',
    `regulatory_filing_code` STRING COMMENT 'Code of the filing (e.g., PUC docket number) that authorizes this tier structure.',
    `season_code` STRING COMMENT 'Season to which the tier applies; all indicates year‑round applicability.. Valid values are `summer|winter|spring|fall|all`',
    `tier_description` STRING COMMENT 'Human‑readable description of the tier, including any special conditions or notes.',
    `tier_number` STRING COMMENT 'Sequential number indicating the position of the tier within the rate component.',
    `tier_type` STRING COMMENT 'Indicates whether the tier price increases (inclining), decreases (declining), or remains constant (flat) across consumption blocks.. Valid values are `inclining|declining|flat`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price charged per unit of energy within this tier, expressed in the price unit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tier record.',
    `upper_bound_kwh` DECIMAL(18,2) COMMENT 'Maximum consumption (in kilowatt‑hours) for which this tiers unit price applies; null indicates no upper limit.',
    CONSTRAINT pk_rate_tier PRIMARY KEY(`rate_tier_id`)
) COMMENT 'Tiered (inclining or declining block) rate structure definitions subordinate to a rate component. Each tier specifies a consumption block boundary (e.g., first 500 kWh, 501-1000 kWh, above 1000 kWh), the unit price for that block, the baseline allocation method (territory average, household size), season applicability, and CARE/FERA discount tier indicators. Supports California-style baseline allowance structures, conservation-incentive pricing, and declining-block industrial rates. Contains 8+ business attributes: tier_number, lower_bound_kwh, upper_bound_kwh, unit_price, baseline_method, season_code, discount_indicator, effective_date, and price_unit. Subordinate to rate_component — accessed via parent FK for billing engine tier resolution.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` (
    `eligibility_rule_id` BIGINT COMMENT 'Unique identifier for the eligibility rule. _canonical_skip_reason: Entity does not fit standard role categories and is treated as a custom rule definition.',
    `application_id` BIGINT COMMENT 'Foreign key linking to technology.application. Business justification: Eligibility rules are executed by an Eligibility Engine Application; linking enables rule version control and audit.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Eligibility rules govern applicability of specific rate schedules.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: Eligibility rules are defined within a rate case filing; linking ensures rule applicability aligns with the case.',
    `annual_consumption_max_mwh` DECIMAL(18,2) COMMENT 'Maximum annual energy consumption in megawatt‑hours for eligibility.',
    `annual_consumption_min_mwh` DECIMAL(18,2) COMMENT 'Minimum annual energy consumption in megawatt‑hours for eligibility.',
    `applicable_customer_class` STRING COMMENT 'Customer class(es) to which the rule applies.. Valid values are `residential|commercial|industrial|government|nonprofit|agricultural`',
    `compliance_regulation` STRING COMMENT 'Regulatory or statutory reference governing the rule (e.g., FERC, NERC).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the rule record was first created in the system.',
    `demand_threshold_kw` DECIMAL(18,2) COMMENT 'Maximum demand threshold in kilowatts that a customer must not exceed to qualify.',
    `effective_from` DATE COMMENT 'Date when the rule becomes effective for eligibility evaluation.',
    `effective_until` DATE COMMENT 'Date when the rule expires; null if the rule has no planned end date.',
    `eligibility_criteria` STRING COMMENT 'Serialized logical expression (e.g., JSON or DSL) defining the rules AND/OR conditions.',
    `eligibility_rule_status` STRING COMMENT 'Current lifecycle status of the rule.. Valid values are `active|inactive|draft|retired`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether the rule must be satisfied for a rate schedule to be applied.',
    `last_review_date` DATE COMMENT 'Date when the rule was last reviewed for compliance or relevance.',
    `load_profile_type` STRING COMMENT 'Load profile classification used in the rule.. Valid values are `flat|time_of_use|demand_response`',
    `notes` STRING COMMENT 'Free‑form notes for auditors or business analysts.',
    `premise_type` STRING COMMENT 'Physical type of the service premise.. Valid values are `residential|commercial|industrial|agricultural`',
    `priority` STRING COMMENT 'Integer priority used to resolve conflicts when multiple rules apply; lower numbers indicate higher priority.',
    `reviewed_by` STRING COMMENT 'Identifier of the person or group that performed the last review.',
    `rule_description` STRING COMMENT 'Detailed description of the business purpose and scope of the rule.',
    `rule_logic` STRING COMMENT 'Human‑readable representation of the rule logic (e.g., pseudo‑code).',
    `rule_name` STRING COMMENT 'Human‑readable name of the rule used for identification in catalogs and UI.',
    `rule_type` STRING COMMENT 'Category of rule: eligibility (customer qualification), pricing (rate calculation), or assignment (territory mapping).. Valid values are `eligibility|pricing|assignment`',
    `service_territory_code` STRING COMMENT 'Code identifying the geographic service territory (e.g., utility service area).',
    `source_system` STRING COMMENT 'Originating operational system of record (e.g., Oracle CC&B, SAP ERP).',
    `special_condition` STRING COMMENT 'Any additional condition (e.g., medical baseline, EV ownership, solar interconnection).',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the rule.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the rule.',
    `version_number` STRING COMMENT 'Version identifier for change management.',
    `voltage_level` STRING COMMENT 'Voltage level category for the service point (low, medium, high).. Valid values are `low|medium|high`',
    `created_by` STRING COMMENT 'User identifier of the person who created the rule.',
    CONSTRAINT pk_eligibility_rule PRIMARY KEY(`eligibility_rule_id`)
) COMMENT 'Business rules governing customer qualification, applicability, and territory assignment for rate schedules, tariff riders, and utility programs. Each rule defines criteria including customer class, service territory, voltage level, load profile type, demand threshold (kW), annual consumption range, premise type, geographic zone, and special conditions (medical baseline, EV ownership, solar interconnection, income level). Also maps rate schedules to applicable service territories, voltage levels, and customer classes — specifying whether assignment is mandatory or optional. Rules are composable with AND/OR logic. Consumed by CIS enrollment validation, self-service portal eligibility checks, CSR rate recommendation tools, and territory-specific rate lookups. Serves as the single source of truth for all who qualifies for what and where does this rate apply logic in the product catalog.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`service_plan` (
    `service_plan_id` BIGINT COMMENT 'Unique surrogate key for the service plan record.',
    `body_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_body. Business justification: Service plans require regulatory body approval; FK enables plan compliance verification and reporting.',
    `compliance_document_id` BIGINT COMMENT 'Identifier of the compliance document associated with the plan (e.g., filing reference).',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Cost allocation reports assign plan delivery costs to internal cost centers; budgeting and performance tracking rely on this relationship.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: Business process: Service Plan Management uses the Billing IT Service to provision plans; linking enables automated provisioning and reporting.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Service plans reference the underlying rate schedule for pricing.',
    `carbon_intensity` DECIMAL(18,2) COMMENT 'Estimated carbon emissions per unit of energy delivered under the plan.',
    `classification_or_type` STRING COMMENT 'Secondary classification used for reporting and eligibility rules.. Valid values are `commercial|industrial|municipal|government|residential`',
    `contract_term_months` STRING COMMENT 'Length of the contractual commitment in months.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the plan record was first created in the system.',
    `demand_threshold_unit` STRING COMMENT 'Unit for the demand threshold value.. Valid values are `kW|MW`',
    `demand_threshold_value` DECIMAL(18,2) COMMENT 'Numeric threshold for demand‑related program triggers.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee charged if the customer terminates the plan before contract end.',
    `effective_from` DATE COMMENT 'Date the plan becomes legally binding for customers.',
    `effective_until` DATE COMMENT 'Date the plan expires or is superseded; null for open‑ended plans.',
    `enrollment_eligibility` STRING COMMENT 'Eligibility rule for customers to enroll in the plan.. Valid values are `open|qualified|restricted`',
    `fixed_rate` DECIMAL(18,2) COMMENT 'Base fixed price component per unit of measure.',
    `is_default_plan` BOOLEAN COMMENT 'True if this plan is the default offering for its category.',
    `is_published` BOOLEAN COMMENT 'True when the plan is active in sales and billing systems.',
    `max_demand_kw` DECIMAL(18,2) COMMENT 'Maximum demand allowed under the plan, expressed in kilowatts.',
    `min_demand_kw` DECIMAL(18,2) COMMENT 'Minimum demand threshold required for eligibility, expressed in kilowatts.',
    `notes` STRING COMMENT 'Free‑form field for internal comments or special conditions.',
    `plan_category` STRING COMMENT 'High‑level classification of the plan based on customer segment.. Valid values are `commercial|industrial|municipal|government|residential`',
    `plan_code` STRING COMMENT 'External business identifier for the service plan, used in billing and regulatory filings.',
    `plan_description` STRING COMMENT 'Detailed description of the plan, including marketing copy and key features.',
    `plan_name` STRING COMMENT 'Human‑readable name of the service plan displayed to customers and sales staff.',
    `plan_subcategory` STRING COMMENT 'More granular classification within the main category (e.g., large‑industrial, small‑municipal).',
    `pricing_currency` STRING COMMENT 'Three‑letter ISO currency code for the plans monetary values.',
    `pricing_structure` STRING COMMENT 'Methodology used to calculate charges under the plan.. Valid values are `fixed|indexed|blended|custom`',
    `program_participation_flag` BOOLEAN COMMENT 'Indicates whether the plan includes participation in demand‑response or other utility programs.',
    `regulatory_approval_date` DATE COMMENT 'Date the plan received final regulatory approval.',
    `regulatory_approval_status` STRING COMMENT 'Current status of required regulatory approvals for the plan.. Valid values are `approved|pending|rejected`',
    `renewable_energy_percentage` DECIMAL(18,2) COMMENT 'Portion of the plans energy supply sourced from renewable resources, expressed as a percent.',
    `renewal_option` STRING COMMENT 'How the contract renews at term end.. Valid values are `auto|manual|none`',
    `service_plan_status` STRING COMMENT 'Current lifecycle status of the plan.. Valid values are `active|inactive|suspended|pending|retired`',
    `unit_of_measure` STRING COMMENT 'Measurement unit for energy or gas consumption used by the plan.. Valid values are `kWh|MWh|therm|MCF`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the plan record.',
    `variable_rate` DECIMAL(18,2) COMMENT 'Variable component that may be indexed to market prices or fuel costs.',
    `version_effective_date` DATE COMMENT 'Date when this version of the plan becomes effective.',
    `version_expiration_date` DATE COMMENT 'Date when this version of the plan expires or is superseded.',
    `version_number` STRING COMMENT 'Sequential version of the plan for change management.',
    CONSTRAINT pk_service_plan PRIMARY KEY(`service_plan_id`)
) COMMENT 'Commercial and industrial bundled service plan catalog for large commercial, key account, and municipal customers. Each plan defines a named offering combining a base rate schedule, optional tariff riders, demand response participation terms, value-added services (energy audits, sustainability reporting, power quality monitoring), contract term structure, pricing methodology (fixed, indexed, blended, custom), minimum demand threshold, and account management tier. Plans are versioned and may require PUC approval for non-standard terms. Feeds Salesforce CPQ for commercial quoting and Oracle CC&B for enrollment.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`ee_measure` (
    `ee_measure_id` BIGINT COMMENT 'Primary key for ee_measure',
    `application_id` BIGINT COMMENT 'Foreign key linking to technology.application. Business justification: Energy‑efficiency measures are administered via an EE Incentive Application; link supports eligibility checks and reporting.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Energy efficiency measures must satisfy specific compliance obligations; FK supports obligation tracking and reporting.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Energy efficiency measures are offered within a specific program; program_code becomes redundant.',
    `baseline_efficiency` STRING COMMENT 'Reference efficiency standard used for baseline comparison.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the measure record was created.',
    `ee_measure_category` STRING COMMENT 'Broad classification of the measure type. [ENUM-REF-CANDIDATE: lighting|hvac|appliance|building_envelope|control_systems|renewable|other — 7 candidates stripped; promote to reference product]',
    `ee_measure_description` STRING COMMENT 'Detailed description of the measure, including functionality and benefits.',
    `ee_measure_name` STRING COMMENT 'Descriptive name of the energy efficiency measure.',
    `ee_measure_status` STRING COMMENT 'Current lifecycle status of the measure.. Valid values are `active|inactive|retired|draft|pending`',
    `effective_end_date` DATE COMMENT 'Date when the measure is no longer offered.',
    `effective_start_date` DATE COMMENT 'Date when the measure becomes effective for enrollment.',
    `eligible_customer_class` STRING COMMENT 'Customer class eligible for the measure.. Valid values are `residential|commercial|industrial|government`',
    `estimated_annual_energy_savings_kwh` DECIMAL(18,2) COMMENT 'Projected annual energy savings in kilowatt-hours.',
    `estimated_demand_reduction_kw` DECIMAL(18,2) COMMENT 'Projected reduction in peak demand in kilowatts.',
    `external_reference_code` STRING COMMENT 'Identifier used by external agencies or standards (e.g., ENERGY STAR ID).',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary value of the incentive per unit or per kWh saved.',
    `incentive_type` STRING COMMENT 'Method of incentive calculation.. Valid values are `per_unit|per_kwh_saved|fixed_amount`',
    `is_pilot` BOOLEAN COMMENT 'Indicates if the measure is part of a pilot program.',
    `measure_life_years` STRING COMMENT 'Expected useful life of the measure in years.',
    `pilot_end_date` DATE COMMENT 'End date of the pilot phase.',
    `pilot_start_date` DATE COMMENT 'Start date of the pilot phase for the measure.',
    `qualifying_specification` STRING COMMENT 'Minimum technical specification required for measure eligibility.',
    `source_system` STRING COMMENT 'Originating system of record for the measure data.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the measure record.',
    CONSTRAINT pk_ee_measure PRIMARY KEY(`ee_measure_id`)
) COMMENT 'Catalog of individual energy efficiency measures eligible for rebates or incentives within EE programs. Each measure record specifies the measure name (e.g., LED lighting, smart thermostat, HVAC upgrade, EV charger), measure category, eligible customer class, baseline efficiency standard, minimum qualifying specification, incentive amount ($/unit or $/kWh saved), estimated annual energy savings (kWh), estimated demand reduction (kW), and measure life (years). Sourced from PUC-approved deemed savings databases.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` (
    `rate_schedule_version_id` BIGINT COMMENT 'System-generated unique identifier for each version of a rate schedule.',
    `body_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_body. Business justification: Each schedule version is approved by a regulatory body; linking tracks approvals across versions.',
    `chart_of_accounts_id` BIGINT COMMENT 'Foreign key linking to finance.chart_of_accounts. Business justification: Regulatory filings track which chart of accounts version applies to each schedule version; this FK supports compliance reporting.',
    `rate_schedule_id` BIGINT COMMENT 'Identifier of the parent rate schedule that this version amends.',
    `approval_date` DATE COMMENT 'Date the regulatory body approved the rate schedule version.',
    `approved_by` STRING COMMENT 'Name or identifier of the official or system that recorded the approval.',
    `change_description` STRING COMMENT 'Narrative description of the changes introduced in this version.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `demand_charge_flag` BOOLEAN COMMENT 'Indicates whether the schedule includes a demand charge component.',
    `docket_number` STRING COMMENT 'Identifier of the regulatory docket (e.g., PUC case number) associated with the filing.',
    `effective_date` DATE COMMENT 'Date the rate schedule version becomes legally effective for billing.',
    `expiration_date` DATE COMMENT 'Date the rate schedule version expires or is superseded (null if open‑ended).',
    `filing_date` DATE COMMENT 'Date the version was filed with the applicable regulatory body.',
    `jurisdiction_state` STRING COMMENT 'Two‑letter state code where the rate schedule is applicable.. Valid values are `^[A-Z]{2}$`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information or comments.',
    `off_peak_rate` DECIMAL(18,2) COMMENT 'Monetary rate applied during off‑peak periods (per unit of measure).',
    `peak_rate` DECIMAL(18,2) COMMENT 'Monetary rate applied during peak periods (per unit of measure).',
    `rate_class` STRING COMMENT 'Customer class to which the rate schedule applies.. Valid values are `residential|commercial|industrial|agricultural`',
    `rate_schedule_version_status` STRING COMMENT 'Current lifecycle status of the rate schedule version.. Valid values are `filed|approved|rejected|withdrawn`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the version record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the version record.',
    `schedule_code` STRING COMMENT 'External code or number used to identify the rate schedule in regulatory filings and billing systems.',
    `schedule_name` STRING COMMENT 'Human‑readable name of the rate schedule (e.g., "Residential TOU Summer 2024").',
    `schedule_type` STRING COMMENT 'Indicates whether the schedule applies to electric service, gas service, or a combined offering.. Valid values are `electric|gas|dual`',
    `tariff_category` STRING COMMENT 'Broad tariff grouping such as Time‑of‑Use, Critical Peak Pricing, Real‑Time Pricing, or Flat Rate.. Valid values are `TOU|CPP|RTP|Flat|Demand|Time-of-Use`',
    `time_of_use_flag` BOOLEAN COMMENT 'Indicates whether the schedule uses time‑of‑use pricing tiers.',
    `unit_of_measure` STRING COMMENT 'Energy or volume unit used for the rates (e.g., kilowatt‑hour, thousand cubic feet).. Valid values are `kWh|MCF|Therm|MWh`',
    `version_number` STRING COMMENT 'Sequential version number assigned by the utility for each revision.',
    CONSTRAINT pk_rate_schedule_version PRIMARY KEY(`rate_schedule_version_id`)
) COMMENT 'Version history of rate schedule changes over time, capturing each filed revision as a distinct record. Each version record stores the version number, filing date, PUC docket number, effective date, expiration date, change description, approval status (filed, approved, rejected, withdrawn), and the rate schedule it amends. Enables point-in-time rate lookups for billing corrections, regulatory audits, and historical rate analysis. Critical for FERC and PUC compliance.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` (
    `rate_schedule_applicability_id` BIGINT COMMENT 'System-generated unique identifier for each rate schedule applicability record.',
    `body_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_body. Business justification: Applicability rules are subject to regulatory body jurisdiction; FK supports compliance audits.',
    `rate_schedule_id` BIGINT COMMENT 'Identifier of the rate schedule that is being applied.',
    `service_territory_id` BIGINT COMMENT 'Identifier of the geographic service territory or utility division where the rate schedule applies.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `customer_class_code` STRING COMMENT 'Code indicating the customer class for which the rate schedule is applicable.. Valid values are `RESIDENTIAL|SMALL_COMMERCIAL|LARGE_COMMERCIAL|INDUSTRIAL|AGRICULTURAL`',
    `effective_from` DATE COMMENT 'Date when the applicability record becomes effective.',
    `effective_until` DATE COMMENT 'Date when the applicability record expires; null if open‑ended.',
    `is_mandatory` BOOLEAN COMMENT 'True if the rate schedule must be applied to the specified combination; false if optional.',
    `last_review_date` DATE COMMENT 'Date when the applicability record was last reviewed for accuracy or regulatory compliance.',
    `notes` STRING COMMENT 'Free‑form comments or business rules related to the applicability.',
    `rate_schedule_applicability_status` STRING COMMENT 'Current lifecycle status of the applicability record.. Valid values are `active|inactive|pending|retired|draft|archived`',
    `reviewed_by` STRING COMMENT 'Identifier of the person or role that performed the last review.',
    `source_system` STRING COMMENT 'Operational system of record where the record originated.. Valid values are `SAP|CC&B|MDM|GIS`',
    `updated_by` STRING COMMENT 'User or process identifier that performed the last update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    `version_number` STRING COMMENT 'Incremental version number for concurrency control.',
    `voltage_level_code` STRING COMMENT 'Code representing the voltage level category (e.g., residential secondary, commercial primary, transmission).. Valid values are `RES_SEC|COM_PRIM|TRANSMISSION`',
    `created_by` STRING COMMENT 'User or process identifier that created the record.',
    CONSTRAINT pk_rate_schedule_applicability PRIMARY KEY(`rate_schedule_applicability_id`)
) COMMENT 'Association entity mapping rate schedules to the service territories, voltage levels, and customer classes where they are applicable. Each record specifies the rate schedule, applicable service territory (by utility division or geographic zone), voltage level (residential secondary, commercial primary, transmission), customer class (residential, small commercial, large commercial, industrial, agricultural), and whether the assignment is mandatory or optional. Enables enrollment validation and territory-specific rate lookups.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`special_contract` (
    `special_contract_id` BIGINT COMMENT 'Unique surrogate key for the special contract record.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account associated with the special contract.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Required for Special Contract Assignment Report linking each special contract to the specific parcel it serves for industrial customers.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Special contracts reference a rate schedule governing rates for the contract.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: Special contracts are often part of a regulatory rate case; FK allows linking contract terms to the governing case.',
    `annual_consumption_max_mwh` DECIMAL(18,2) COMMENT 'Maximum annual energy consumption allowed under the contract.',
    `annual_consumption_min_mwh` DECIMAL(18,2) COMMENT 'Minimum annual energy consumption required under the contract.',
    `capital_investment_threshold` DECIMAL(18,2) COMMENT 'Minimum capital investment amount the customer must commit to qualify for the incentive.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework or statute governing the contract (e.g., FERC, NERC).',
    `contract_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `contract_description` STRING COMMENT 'Free‑form description of the contract purpose and key terms.',
    `contract_number` STRING COMMENT 'External contract identifier used in regulatory filings and customer communications.',
    `contract_signed_date` DATE COMMENT 'Date the parties executed the contract.',
    `contract_type` STRING COMMENT 'Category of the special contract indicating its business purpose.. Valid values are `special|custom|development|municipal`',
    `contract_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    `contract_version_number` STRING COMMENT 'Sequential version identifier for contract amendments.',
    `curtailment_compensation_amount` DECIMAL(18,2) COMMENT 'Compensation paid to the customer for each MWh of curtailed load.',
    `demand_charge_rate` DECIMAL(18,2) COMMENT 'Rate applied to the contracted demand (kW) portion of the bill.',
    `demand_threshold_kw` DECIMAL(18,2) COMMENT 'Maximum demand level that triggers specific rate tiers.',
    `economic_development_incentive_type` STRING COMMENT 'Type of incentive tied to the contract (e.g., job creation, capital investment, tax credit).. Valid values are `job_creation|capital_investment|tax_credit`',
    `end_date` DATE COMMENT 'Date the contract expires or is scheduled to terminate (nullable for open‑ended).',
    `energy_charge_rate` DECIMAL(18,2) COMMENT 'Rate applied to the energy consumption portion of the bill.',
    `interruptibility_obligation` BOOLEAN COMMENT 'Specifies if the customer must allow load curtailment during grid emergencies.',
    `job_creation_threshold` STRING COMMENT 'Minimum number of new jobs the customer must create to qualify for the incentive.',
    `last_review_date` DATE COMMENT 'Date the contract was last reviewed for compliance or amendment.',
    `load_profile_type` STRING COMMENT 'Typical load shape category for the customer.. Valid values are `residential|commercial|industrial`',
    `minimum_annual_revenue` DECIMAL(18,2) COMMENT 'Minimum revenue the customer must generate annually under the contract.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or special conditions.',
    `premise_type` STRING COMMENT 'Classification of the service location (e.g., residential, commercial, industrial).',
    `puc_approval_docket_number` STRING COMMENT 'Regulatory docket identifier for Public Utility Commission approval.',
    `ratchet_provision_details` STRING COMMENT 'Narrative description of the ratchet mechanism and trigger conditions.',
    `ratchet_provision_flag` BOOLEAN COMMENT 'Indicates whether the contract includes a ratchet provision that can increase rates over time.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the contract includes an automatic renewal provision.',
    `renewal_term_months` STRING COMMENT 'Length of the renewal period in months if renewal is exercised.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the person who performed the last review.',
    `service_territory_code` STRING COMMENT 'Code representing the geographic service area for the contract.',
    `source_system` STRING COMMENT 'Originating operational system of record (e.g., SAP ERP, Oracle CC&B).',
    `special_condition` STRING COMMENT 'Any unique condition or clause specific to this contract.',
    `special_contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `active|inactive|terminated|pending|draft`',
    `start_date` DATE COMMENT 'Date the contract becomes legally binding.',
    `termination_notice_period_days` STRING COMMENT 'Number of days notice required to terminate the contract.',
    `voltage_level` STRING COMMENT 'Voltage classification of the service (e.g., low, medium, high).. Valid values are `low|medium|high`',
    CONSTRAINT pk_special_contract PRIMARY KEY(`special_contract_id`)
) COMMENT 'Individually negotiated service agreements with large industrial, municipal, or economic development customers that deviate from standard published tariff rates. Each record captures contract number, customer account reference, negotiated rate terms (demand charges, energy charges, ratchet provisions), contract duration, minimum annual revenue guarantee, interruptibility obligations, curtailment compensation, economic development incentive basis (job creation, capital investment thresholds), PUC approval docket, and renewal/termination provisions. These bespoke agreements require separate regulatory authorization and are tracked independently from standard rate schedules for revenue assurance and regulatory audit purposes.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`product_program` (
    `product_program_id` BIGINT COMMENT 'Unique system-generated identifier for the utility program record.',
    `application_id` BIGINT COMMENT 'Foreign key linking to technology.application. Business justification: Program Implementation Project tracks which Application supports the program; required for program performance dashboards.',
    `body_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_body. Business justification: Program approvals are granted by a specific regulatory body; linking supports program‑to‑body reporting and audit.',
    `budget_id` BIGINT COMMENT 'Foreign key linking to finance.budget. Business justification: Energy‑efficiency incentive programs are funded via annual budgets; the program‑budget link is required for financial planning and audit.',
    `umbrella_product_program_id` BIGINT COMMENT 'Self-referencing FK on product_program (umbrella_product_program_id)',
    `administrator` STRING COMMENT 'Internal department or external entity responsible for administering the program.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total monetary budget allocated to the program for the budget cycle.',
    `budget_currency` STRING COMMENT 'ISO 4217 currency code for the program budget (e.g., USD).',
    `budget_cycle_year` STRING COMMENT 'Fiscal year for which the program budget is allocated.',
    `cap_exempt_flag` BOOLEAN COMMENT 'True if the program is exempt from enrollment caps due to regulatory or policy reasons.',
    `contact_email` STRING COMMENT 'Primary email address for program inquiries.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary phone number for program inquiries.. Valid values are `^[0-9]{10}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the program record was first created in the system.',
    `current_enrollment` BIGINT COMMENT 'Number of customers currently enrolled in the program.',
    `demand_profile_type` STRING COMMENT 'Typical demand profile of eligible customers.. Valid values are `residential|commercial|industrial`',
    `effective_end_date` DATE COMMENT 'Date the program expires or is retired (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date the program becomes effective and available to customers.',
    `eligibility_criteria` STRING COMMENT 'Summary of the rules that determine customer eligibility for enrollment.',
    `enrollment_capacity` BIGINT COMMENT 'Maximum number of customers that may be enrolled in the program.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary or percentage value of the incentive.',
    `incentive_type` STRING COMMENT 'Type of financial incentive offered (rebate, discount, credit, or none).. Valid values are `rebate|discount|credit|none`',
    `incentive_unit` STRING COMMENT 'Unit of measure for the incentive amount.. Valid values are `dollar_per_kwh|dollar_per_mwh|percent|dollar`',
    `is_mandatory` BOOLEAN COMMENT 'Indicates whether participation in the program is mandatory for eligible customers.',
    `last_review_date` DATE COMMENT 'Date the program was last reviewed for compliance or performance.',
    `load_reduction_target_kw` DECIMAL(18,2) COMMENT 'Target kilowatt reduction per participant for demand response programs.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or internal comments.',
    `participation_fee` DECIMAL(18,2) COMMENT 'One‑time or recurring fee charged to participants for program enrollment.',
    `product_program_description` STRING COMMENT 'Detailed narrative describing the purpose, mechanics, and benefits of the program.',
    `product_program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|pending|suspended|retired`',
    `program_category` STRING COMMENT 'High‑level classification of the program (e.g., Demand Response, Net Energy Metering, Energy Efficiency, Low‑Income Assistance, Electric Vehicle, Green Tariff).. Valid values are `dr|nem|ee|low_income|ev|green`',
    `program_code` STRING COMMENT 'Business identifier code assigned to the program for external reference and regulatory filings.',
    `program_name` STRING COMMENT 'Human‑readable name of the program as presented to customers and regulators.',
    `puc_authorization_reference` STRING COMMENT 'Public Utility Commission docket or filing number authorizing the program.',
    `reviewed_by` STRING COMMENT 'Name or identifier of the person who performed the last review.',
    `savings_goal_kwh` DECIMAL(18,2) COMMENT 'Estimated annual energy savings a participant must achieve to qualify for the EE program.',
    `service_territory_code` STRING COMMENT 'Code representing the geographic service area where the program is offered.',
    `source_system` STRING COMMENT 'Name of the operational system of record that supplied the program data (e.g., Oracle CIS, SAP ERP).',
    `status_reason` STRING COMMENT 'Explanation for the current status, such as regulatory hold or budget exhaustion.',
    `subcategory` STRING COMMENT 'More specific classification within the main category, such as Critical Peak Pricing under Demand Response.',
    `system_size_cap_kw` DECIMAL(18,2) COMMENT 'Maximum allowable solar system size for enrollment in NEM programs.',
    `target_customer_segment` STRING COMMENT 'Customer segment(s) eligible for the program (e.g., residential, commercial).. Valid values are `residential|commercial|industrial|government`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the program record.',
    `url` STRING COMMENT 'Web address where customers can view program details and enroll.',
    `version` STRING COMMENT 'Version label for the program definition (e.g., v1.0, v2.1).',
    `version_effective_date` DATE COMMENT 'Date when this version of the program became effective.',
    `version_expiration_date` DATE COMMENT 'Date when this version of the program expires (null if current).',
    `voltage_level` STRING COMMENT 'Typical voltage level of the service territory for the program (low, medium, high).. Valid values are `low|medium|high`',
    CONSTRAINT pk_product_program PRIMARY KEY(`product_program_id`)
) COMMENT 'Unified master catalog of all utility-sponsored customer programs including Demand Response (DR), Net Energy Metering (NEM), Energy Efficiency (EE), low-income assistance (CARE/FERA/LIHEAP), electric vehicle (EV) charging, and voluntary green tariff programs. Each record specifies program name, program category (DR/NEM/EE/low-income/EV/green), target customer segment, enrollment capacity, incentive structure summary, PUC authorization reference, program administrator, budget cycle, effective and expiration dates, and current program status. Category-specific attributes (e.g., load reduction targets for DR, system size caps for NEM, savings goals for EE) are stored as structured metadata. Serves as the SSOT for all program definitions consumed by customer enrollment and billing systems.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`program_measure` (
    `program_measure_id` BIGINT COMMENT 'Unique system-generated identifier for the program measure record.',
    `application_id` BIGINT COMMENT 'Foreign key linking to technology.application. Business justification: Measure tracking relies on a specific Application; link needed for incentive calculation and compliance reporting.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Program measures are tied to compliance obligations; linking enables monitoring of obligation fulfillment.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Program measures belong to a program; linking removes duplicate program_code.',
    `bundled_with_program_measure_id` BIGINT COMMENT 'Self-referencing FK on program_measure (bundled_with_program_measure_id)',
    `baseline_efficiency` DECIMAL(18,2) COMMENT 'Baseline performance metric (e.g., SEER, U‑value) used to calculate savings.',
    `cap_exempt_flag` BOOLEAN COMMENT 'Indicates whether the measure is exempt from program participation caps.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time the measure record was first created.',
    `deemed_savings_source` STRING COMMENT 'Reference to the PUC‑approved deemed savings database or document.',
    `deemed_savings_value_kwh_per_year` DECIMAL(18,2) COMMENT 'Standardized annual savings value used when is_deemed_savings is true.',
    `effective_end_date` DATE COMMENT 'Date the measure ceases to be offered (null if open‑ended).',
    `effective_start_date` DATE COMMENT 'Date the measure becomes effective for program enrollment.',
    `eligibility_criteria` STRING COMMENT 'Textual rules that define which customers or sites qualify for the measure.',
    `eligibility_customer_class` STRING COMMENT 'Customer class(es) that may receive the incentive.. Valid values are `residential|commercial|industrial|government`',
    `eligibility_status` STRING COMMENT 'Current determination of whether the measure can be offered.. Valid values are `eligible|ineligible|pending`',
    `estimated_annual_energy_savings_kwh` DECIMAL(18,2) COMMENT 'Deemed annual electricity savings attributed to the measure.',
    `estimated_demand_reduction_kw` DECIMAL(18,2) COMMENT 'Projected reduction in peak demand when the measure is installed.',
    `external_reference_code` STRING COMMENT 'Identifier used by external regulatory or industry databases.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary value of the incentive per unit or per savings amount.',
    `incentive_method` STRING COMMENT 'Method used to calculate the incentive amount.. Valid values are `per_unit|per_kWh|flat`',
    `incentive_type` STRING COMMENT 'Category of financial incentive offered for the measure.. Valid values are `rebate|discount|credit|incentive`',
    `incentive_unit` STRING COMMENT 'Unit of measure for the incentive amount.. Valid values are `$/unit|$/kWh|$/kW`',
    `is_deemed_savings` BOOLEAN COMMENT 'True if the savings values are based on PUC‑approved deemed savings tables.',
    `is_pilot` BOOLEAN COMMENT 'Indicates whether the measure is part of a pilot rollout.',
    `measure_code` STRING COMMENT 'Unique alphanumeric code used to reference the measure in regulatory filings and internal systems.',
    `measure_life_years` STRING COMMENT 'Expected useful life of the measure for program accounting.',
    `minimum_qualifying_specification` STRING COMMENT 'Lowest acceptable technical spec for a product to be considered eligible.',
    `notes` STRING COMMENT 'Free‑form comments or special considerations for the measure.',
    `pilot_end_date` DATE COMMENT 'Date the pilot for the measure concluded.',
    `pilot_start_date` DATE COMMENT 'Date the pilot for the measure began.',
    `program_measure_category` STRING COMMENT 'High‑level classification of the measure (e.g., lighting, HVAC, insulation).',
    `program_measure_description` STRING COMMENT 'Detailed description of the measure, including technology and typical applications.',
    `program_measure_name` STRING COMMENT 'Human‑readable name of the eligible measure or technology.',
    `program_measure_status` STRING COMMENT 'Current lifecycle state of the measure record.. Valid values are `active|inactive|retired|draft`',
    `program_type` STRING COMMENT 'Broad type of program that governs the measure.. Valid values are `energy_efficiency|demand_response|net_energy_metering|electric_vehicle|renewable_incentive`',
    `qualifying_specification` STRING COMMENT 'Minimum technical specification a product must meet to be eligible.',
    `source_system` STRING COMMENT 'Originating operational system of record for the measure definition.. Valid values are `CC&B|MDM|Maximo|Allegro|Custom`',
    `subcategory` STRING COMMENT 'More specific classification within the main category (e.g., LED, CFL for lighting).',
    `unit_of_measure` STRING COMMENT 'Primary unit used for savings or incentive calculations.. Valid values are `kWh|kW|unit`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time the measure record was last modified.',
    CONSTRAINT pk_program_measure PRIMARY KEY(`program_measure_id`)
) COMMENT 'Catalog of eligible measures, technologies, or qualifying equipment within any utility program type. For EE programs: rebate-eligible measures (LED lighting, HVAC upgrades, smart thermostats, insulation) with deemed savings values (kWh/year), demand reduction (kW), measure life (years), and incentive amounts ($/unit or $/kWh saved) sourced from PUC-approved deemed savings databases. For NEM programs: eligible generation technologies (solar PV, wind, fuel cell) with system size caps. For DR programs: qualifying load control devices and communication protocols. For EV programs: eligible charging equipment (Level 1/2/DCFC) with make/model qualification. Each record specifies measure name, category, parent program, qualifying specifications, baseline efficiency standard, minimum qualifying specification, incentive method, estimated savings/capacity, measure life, and PUC-approved status.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` (
    `rate_season_calendar_id` BIGINT COMMENT 'Unique surrogate key for the rate season calendar record.',
    `superseded_rate_season_calendar_id` BIGINT COMMENT 'Self-referencing FK on rate_season_calendar (superseded_rate_season_calendar_id)',
    `applicable_customer_class` STRING COMMENT 'Customer class categories for which the calendar is valid.. Valid values are `residential|commercial|industrial|municipal`',
    `applicable_service_type` STRING COMMENT 'Utility service type(s) to which the calendar applies.. Valid values are `electric|gas|both`',
    `approval_date` DATE COMMENT 'Date the calendar received regulatory approval.',
    `approval_status` STRING COMMENT 'Regulatory approval status of the calendar.. Valid values are `approved|pending|rejected`',
    `calendar_category` STRING COMMENT 'High‑level category describing the pricing strategy the calendar supports.. Valid values are `TOU|CPP|RTP|Flat|Seasonal|Hybrid`',
    `calendar_code` STRING COMMENT 'External business identifier or code used in rate schedules and regulatory filings.',
    `calendar_name` STRING COMMENT 'Human‑readable name of the season calendar (e.g., "Summer 2024 TOU").',
    `calendar_type` STRING COMMENT 'Indicates whether the calendar is based on seasons, day‑types, or a combination.. Valid values are `seasonal|daytype|combined`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the calendar record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for monetary values.',
    `demand_charge_applicable` BOOLEAN COMMENT 'Indicates whether a demand charge is applied under this calendar.',
    `demand_charge_rate` DECIMAL(18,2) COMMENT 'Rate (per kW) used for demand charge calculations.',
    `effective_end_date` DATE COMMENT 'Date on which the calendar ceases to be effective (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the calendar becomes effective for rate application.',
    `holiday_dates` STRING COMMENT 'Comma‑separated list of calendar dates that are treated as holidays (format yyyy‑MM‑dd).',
    `holiday_names` STRING COMMENT 'Comma‑separated list of holiday names corresponding to holiday_dates.',
    `is_default_calendar` BOOLEAN COMMENT 'Indicates whether this calendar is the default for its service type.',
    `is_holiday_observed` BOOLEAN COMMENT 'Indicates whether holidays are observed for rate application (true) or ignored (false).',
    `last_review_date` DATE COMMENT 'Date of the most recent compliance or business review.',
    `notes` STRING COMMENT 'Free‑form comments or special instructions.',
    `off_peak_period_end_time` TIMESTAMP COMMENT 'End time of the off‑peak pricing window (HH:mm, 24‑hour).',
    `off_peak_period_start_time` TIMESTAMP COMMENT 'Start time of the off‑peak pricing window (HH:mm, 24‑hour).',
    `off_peak_price_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to the base rate during off‑peak periods.',
    `peak_period_end_time` TIMESTAMP COMMENT 'End time of the peak pricing window (HH:mm, 24‑hour).',
    `peak_period_start_time` TIMESTAMP COMMENT 'Start time of the peak pricing window (HH:mm, 24‑hour).',
    `peak_price_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to the base rate during peak periods.',
    `price_unit` STRING COMMENT 'Unit of measurement for energy pricing.. Valid values are `kWh|therm|MWh|MCF`',
    `rate_season_calendar_status` STRING COMMENT 'Current lifecycle status of the calendar.. Valid values are `active|inactive|retired|draft`',
    `regulatory_filing_number` STRING COMMENT 'PUC or FERC docket number associated with the calendar filing.',
    `reviewed_by` STRING COMMENT 'Identifier of the person or system that performed the last review.',
    `season_shoulder_end` DATE COMMENT 'Last calendar date of the shoulder season.',
    `season_shoulder_start` DATE COMMENT 'First calendar date of the shoulder (transitional) season.',
    `season_summer_end` DATE COMMENT 'Last calendar date of the summer season.',
    `season_summer_start` DATE COMMENT 'First calendar date of the summer season.',
    `season_winter_end` DATE COMMENT 'Last calendar date of the winter season.',
    `season_winter_start` DATE COMMENT 'First calendar date of the winter season.',
    `source_system` STRING COMMENT 'Originating operational system (e.g., CC&B, MDM).',
    `time_zone` STRING COMMENT 'IANA time‑zone identifier for the calendar (e.g., "America/Los_Angeles").',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the calendar record.',
    `version_number` STRING COMMENT 'Incremental version number for change management and audit.',
    CONSTRAINT pk_rate_season_calendar PRIMARY KEY(`rate_season_calendar_id`)
) COMMENT 'Defines the seasonal and day-type calendar used by rate schedules to determine which pricing periods, tiers, and components apply on any given date and time. Each record specifies the calendar name, season definitions (summer/winter/shoulder with start and end dates), day-type classifications (weekday, weekend, holiday), holiday list, and the rate schedules that reference this calendar. Critical for TOU rate application where the billing engine must determine the correct season and day-type for each meter interval.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ADD CONSTRAINT `fk_product_product_tariff_rider_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ADD CONSTRAINT `fk_product_product_rate_component_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ADD CONSTRAINT `fk_product_tou_period_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ADD CONSTRAINT `fk_product_tou_period_rate_season_calendar_id` FOREIGN KEY (`rate_season_calendar_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_season_calendar`(`rate_season_calendar_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ADD CONSTRAINT `fk_product_tou_period_season_rate_season_calendar_id` FOREIGN KEY (`season_rate_season_calendar_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_season_calendar`(`rate_season_calendar_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ADD CONSTRAINT `fk_product_rate_tier_product_rate_component_id` FOREIGN KEY (`product_rate_component_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_rate_component`(`product_rate_component_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ADD CONSTRAINT `fk_product_eligibility_rule_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ADD CONSTRAINT `fk_product_service_plan_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ADD CONSTRAINT `fk_product_ee_measure_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ADD CONSTRAINT `fk_product_rate_schedule_version_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ADD CONSTRAINT `fk_product_rate_schedule_applicability_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ADD CONSTRAINT `fk_product_special_contract_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ADD CONSTRAINT `fk_product_product_program_umbrella_product_program_id` FOREIGN KEY (`umbrella_product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ADD CONSTRAINT `fk_product_program_measure_product_program_id` FOREIGN KEY (`product_program_id`) REFERENCES `power_and_utilities_v2`.`product`.`product_program`(`product_program_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ADD CONSTRAINT `fk_product_program_measure_bundled_with_program_measure_id` FOREIGN KEY (`bundled_with_program_measure_id`) REFERENCES `power_and_utilities_v2`.`product`.`program_measure`(`program_measure_id`);
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ADD CONSTRAINT `fk_product_rate_season_calendar_superseded_rate_season_calendar_id` FOREIGN KEY (`superseded_rate_season_calendar_id`) REFERENCES `power_and_utilities_v2`.`product`.`rate_season_calendar`(`rate_season_calendar_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`product` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `power_and_utilities_v2`.`product` SET TAGS ('dbx_domain' = 'product');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|under_review');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `cap_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Cap Exempt Flag');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class (Residential, Commercial, Industrial, Municipal)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `demand_charge` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Amount');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `demand_charge_unit` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Unit (kW, MW)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `demand_charge_unit` SET TAGS ('dbx_value_regex' = 'kW|MW');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (Start of Rate Schedule Validity)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Description');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `enrollment_deadline` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Deadline Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `enrollment_required` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Required Flag');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (End of Rate Schedule Validity)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `max_participation` SET TAGS ('dbx_business_glossary_term' = 'Maximum Participation Count');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge Amount');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit (Monetary Amount per Unit of Measure)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name (e.g., Demand Response Program)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type (Demand Response, Energy Efficiency, Net Metering, Renewable Certificate)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'demand_response|energy_efficiency|net_metering|renewable_certificate');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `rate_category` SET TAGS ('dbx_business_glossary_term' = 'Rate Category (Time-of-Use, Critical Peak Pricing, Real-Time Pricing, Fixed, Tiered)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `rate_category` SET TAGS ('dbx_value_regex' = 'TOU|CPP|RTP|Fixed|Tiered');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code (RSC)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `rate_schedule_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]+$');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `rate_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Description');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `rate_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Status (Active, Inactive, Pending, Retired, Draft)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `rate_schedule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|draft');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `rate_structure` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type (Flat, Tiered, Block, Time-of-Use)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `rate_structure` SET TAGS ('dbx_value_regex' = 'flat|tiered|block|time_of_use');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `seasonal_end_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period End Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `seasonal_period` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period (Summer, Winter, Shoulder, All Year)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `seasonal_period` SET TAGS ('dbx_value_regex' = 'summer|winter|shoulder|all_year');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `seasonal_start_date` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type (Electricity or Gas)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'electric|gas');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System of Record');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'CC&B|SAP|MDM|ETRM|Other');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `time_of_use_end` SET TAGS ('dbx_business_glossary_term' = 'Time‑of‑Use Period End Time (HH:MM)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `time_of_use_end` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `time_of_use_period` SET TAGS ('dbx_business_glossary_term' = 'Time‑of‑Use Period (Peak, Off‑Peak, Mid‑Peak, Super‑Peak)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `time_of_use_period` SET TAGS ('dbx_value_regex' = 'peak|offpeak|midpeak|superpeak');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `time_of_use_start` SET TAGS ('dbx_business_glossary_term' = 'Time‑of‑Use Period Start Time (HH:MM)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `time_of_use_start` SET TAGS ('dbx_value_regex' = '^([01]d|2[0-3]):[0-5]d$');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (kWh, MCF, Therm, kW, MWh)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|MCF|Therm|kW|MWh');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `product_tariff_rider_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rider Surrogate ID (PRODUCT_TARIFF_RIDER_ID)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method (CALC_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'per_kwh|per_therm|fixed|percentage');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `calculation_value` SET TAGS ('dbx_business_glossary_term' = 'Calculation Value (CALC_VALUE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_END_DATE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START_DATE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (ELIGIBILITY_CRITERIA)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `eligibility_customer_type` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Customer Type (ELIG_CUST_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `eligibility_customer_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government|agricultural');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `eligibility_program` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Program (ELIG_PROGRAM)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Rider Flag (IS_DEFAULT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `is_taxable` SET TAGS ('dbx_business_glossary_term' = 'Taxable Rider Flag (IS_TAXABLE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rider Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `product_tariff_rider_description` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rider Description (RIDER_DESCRIPTION)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `product_tariff_rider_status` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rider Status (RIDER_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `product_tariff_rider_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `regulatory_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Date (REG_FILING_DATE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `rider_code` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rider Code (RIDER_CODE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `rider_name` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rider Name (RIDER_NAME)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `rider_type` SET TAGS ('dbx_business_glossary_term' = 'Tariff Rider Type (RIDER_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `rider_type` SET TAGS ('dbx_value_regex' = 'fuel_adjustment|renewable|infrastructure|low_income|transmission|demand_response');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `tax_rate` SET TAGS ('dbx_business_glossary_term' = 'Applicable Tax Rate (TAX_RATE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kwh|therm|kw|mwh|percent');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_tariff_rider` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `product_rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Component Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier (RATE_SCH_ID)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `accounting_code` SET TAGS ('dbx_business_glossary_term' = 'Accounting Code (ACCOUNTING_CD)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `applicable_period` SET TAGS ('dbx_business_glossary_term' = 'Applicable Period (APPL_PERIOD)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `applicable_period` SET TAGS ('dbx_value_regex' = 'on_peak|off_peak|all_day|mid_peak|shoulder');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method (CALC_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'simple|complex|formula_based');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `charge_basis` SET TAGS ('dbx_business_glossary_term' = 'Charge Basis (CHARGE_BASIS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `charge_basis` SET TAGS ('dbx_value_regex' = 'per_unit|flat_fee|tiered|minimum|maximum');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `component_code` SET TAGS ('dbx_business_glossary_term' = 'Component Code (COMPONENT_CODE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `component_name` SET TAGS ('dbx_business_glossary_term' = 'Component Name (COMPONENT_NAME)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Component Type (COMPONENT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (COST_CENTER_CD)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFF_END_DT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFF_START_DT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (ELIG_CRIT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `is_default_component` SET TAGS ('dbx_business_glossary_term' = 'Default Component Flag (IS_DEFAULT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (MOD_BY)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `maximum_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge (MAX_CHG)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `measurement_multiplier` SET TAGS ('dbx_business_glossary_term' = 'Measurement Multiplier (MEAS_MULT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `metered_quantity_type` SET TAGS ('dbx_business_glossary_term' = 'Metered Quantity Type (METER_QTY_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `metered_quantity_type` SET TAGS ('dbx_value_regex' = 'consumption|demand|capacity');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge (MIN_CHG)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `price_amount` SET TAGS ('dbx_business_glossary_term' = 'Price Amount (PRICE_AMT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency (PRICE_CURR)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `product_rate_component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description (COMP_DESC)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `product_rate_component_status` SET TAGS ('dbx_business_glossary_term' = 'Component Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `product_rate_component_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date (REG_APPROVAL_DT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (REG_APPROVAL_STS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `regulatory_filing_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Code (REG_FILING_CD)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (TAX_EXEMPT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `tier_lower_bound` SET TAGS ('dbx_business_glossary_term' = 'Tier Lower Bound (TIER_LOWER)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `tier_number` SET TAGS ('dbx_business_glossary_term' = 'Tier Number (TIER_NUM)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `tier_upper_bound` SET TAGS ('dbx_business_glossary_term' = 'Tier Upper Bound (TIER_UPPER)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|MWh|kW|therm|USD|percent');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_rate_component` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VERSION_NUM)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `tou_period_id` SET TAGS ('dbx_business_glossary_term' = 'Tou Period Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier (Rate Schedule ID)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `rate_season_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Season Identifier (Season ID)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `season_rate_season_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Season Identifier (Season ID)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Created Timestamp)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `day_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Day Type (Day Type)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `day_type` SET TAGS ('dbx_value_regex' = 'weekday|weekend|holiday');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (Effective From)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (Effective Until)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Period End Time (End Time)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `is_critical_peak` SET TAGS ('dbx_business_glossary_term' = 'Critical Peak Indicator (Critical Peak Flag)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `is_default` SET TAGS ('dbx_business_glossary_term' = 'Default Period Flag (Default Flag)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `max_charge` SET TAGS ('dbx_business_glossary_term' = 'Maximum Charge (Max Charge)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `min_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Charge (Min Charge)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `peak_price_factor` SET TAGS ('dbx_business_glossary_term' = 'Peak Price Multiplier (Peak Factor)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `period_code` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use Period Code (TOU Period Code)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `period_name` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use Period Name (TOU Period Name)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `period_type` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use Period Type (TOU Period Type)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `period_type` SET TAGS ('dbx_value_regex' = 'on_peak|mid_peak|off_peak|super_off_peak|critical_peak');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `priority_order` SET TAGS ('dbx_business_glossary_term' = 'Period Priority Order (Priority Order)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Period Start Time (Start Time)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone (Time Zone)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `tou_period_status` SET TAGS ('dbx_business_glossary_term' = 'Period Lifecycle Status (Status)');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `tou_period_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `power_and_utilities_v2`.`product`.`tou_period` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Updated Timestamp)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `rate_tier_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Tier Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `billing_rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `product_rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Component Product Rate Component Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `baseline_method` SET TAGS ('dbx_business_glossary_term' = 'Baseline Allocation Method');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `baseline_method` SET TAGS ('dbx_value_regex' = 'territory_average|household_size|custom');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `discount_indicator` SET TAGS ('dbx_business_glossary_term' = 'Discount Indicator');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `discount_indicator` SET TAGS ('dbx_value_regex' = 'none|care|fera|senior|veteran|low_income');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `lower_bound_kwh` SET TAGS ('dbx_business_glossary_term' = 'Lower Bound (kWh)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `price_currency` SET TAGS ('dbx_business_glossary_term' = 'Price Currency');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `price_currency` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `price_unit` SET TAGS ('dbx_value_regex' = 'USD/kWh|USD/MWh|USD/therm|USD/MCF');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `rate_tier_status` SET TAGS ('dbx_business_glossary_term' = 'Tier Status');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `rate_tier_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `regulatory_filing_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Code');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `season_code` SET TAGS ('dbx_business_glossary_term' = 'Season Code');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `season_code` SET TAGS ('dbx_value_regex' = 'summer|winter|spring|fall|all');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `tier_description` SET TAGS ('dbx_business_glossary_term' = 'Tier Description');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `tier_number` SET TAGS ('dbx_business_glossary_term' = 'Tier Number');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_business_glossary_term' = 'Tier Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `tier_type` SET TAGS ('dbx_value_regex' = 'inclining|declining|flat');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_tier` ALTER COLUMN `upper_bound_kwh` SET TAGS ('dbx_business_glossary_term' = 'Upper Bound (kWh)');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` SET TAGS ('dbx_subdomain' = 'program_administration');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `eligibility_rule_id` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule ID');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `annual_consumption_max_mwh` SET TAGS ('dbx_business_glossary_term' = 'Annual Consumption Maximum (MWh)');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `annual_consumption_min_mwh` SET TAGS ('dbx_business_glossary_term' = 'Annual Consumption Minimum (MWh)');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `applicable_customer_class` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Class');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `applicable_customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government|nonprofit|agricultural');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation Reference');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rule Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `demand_threshold_kw` SET TAGS ('dbx_business_glossary_term' = 'Demand Threshold (kW)');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Expression');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `eligibility_rule_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Status');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `eligibility_rule_status` SET TAGS ('dbx_value_regex' = 'active|inactive|draft|retired');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Rule Flag');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `load_profile_type` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `load_profile_type` SET TAGS ('dbx_value_regex' = 'flat|time_of_use|demand_response');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Rule Notes');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `premise_type` SET TAGS ('dbx_business_glossary_term' = 'Premise Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `premise_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Rule Priority');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `rule_description` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Description');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `rule_logic` SET TAGS ('dbx_business_glossary_term' = 'Rule Logic Definition');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `rule_name` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Name');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Rule Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `rule_type` SET TAGS ('dbx_value_regex' = 'eligibility|pricing|assignment');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `special_condition` SET TAGS ('dbx_business_glossary_term' = 'Special Condition');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Rule Updated By');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Rule Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rule Version Number');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `voltage_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `power_and_utilities_v2`.`product`.`eligibility_rule` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Rule Created By');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` SET TAGS ('dbx_subdomain' = 'program_administration');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `service_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Service Plan ID');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `carbon_intensity` SET TAGS ('dbx_business_glossary_term' = 'Carbon Intensity (kg CO2e per Unit)');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_business_glossary_term' = 'Plan Classification or Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `classification_or_type` SET TAGS ('dbx_value_regex' = 'commercial|industrial|municipal|government|residential');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `demand_threshold_unit` SET TAGS ('dbx_business_glossary_term' = 'Demand Threshold Unit');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `demand_threshold_unit` SET TAGS ('dbx_value_regex' = 'kW|MW');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `demand_threshold_value` SET TAGS ('dbx_business_glossary_term' = 'Demand Threshold Value');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee (USD)');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `enrollment_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Eligibility');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `enrollment_eligibility` SET TAGS ('dbx_value_regex' = 'open|qualified|restricted');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `fixed_rate` SET TAGS ('dbx_business_glossary_term' = 'Fixed Rate (USD per Unit)');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `is_default_plan` SET TAGS ('dbx_business_glossary_term' = 'Default Plan Indicator');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `is_published` SET TAGS ('dbx_business_glossary_term' = 'Published Indicator');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `max_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Demand (kW)');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `min_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Minimum Demand (kW)');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Plan Notes');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_business_glossary_term' = 'Service Plan Category');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `plan_category` SET TAGS ('dbx_value_regex' = 'commercial|industrial|municipal|government|residential');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `plan_code` SET TAGS ('dbx_business_glossary_term' = 'Service Plan Code');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `plan_description` SET TAGS ('dbx_business_glossary_term' = 'Service Plan Description');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `plan_name` SET TAGS ('dbx_business_glossary_term' = 'Service Plan Name');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `plan_subcategory` SET TAGS ('dbx_business_glossary_term' = 'Service Plan Subcategory');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `pricing_currency` SET TAGS ('dbx_business_glossary_term' = 'Pricing Currency (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `pricing_structure` SET TAGS ('dbx_business_glossary_term' = 'Pricing Structure');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `pricing_structure` SET TAGS ('dbx_value_regex' = 'fixed|indexed|blended|custom');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `program_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Program Participation Flag');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `regulatory_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `renewable_energy_percentage` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Percentage');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `service_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Service Plan Status');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `service_plan_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|retired');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|MWh|therm|MCF');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `variable_rate` SET TAGS ('dbx_business_glossary_term' = 'Variable Rate (USD per Unit)');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `version_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `version_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Version Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`service_plan` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` SET TAGS ('dbx_subdomain' = 'program_administration');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `ee_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Ee Measure Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `baseline_efficiency` SET TAGS ('dbx_business_glossary_term' = 'Baseline Efficiency Standard (BASELINE_EFF)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `ee_measure_category` SET TAGS ('dbx_business_glossary_term' = 'Measure Category (MEASURE_CATEGORY)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `ee_measure_description` SET TAGS ('dbx_business_glossary_term' = 'Measure Description (MEASURE_DESC)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `ee_measure_name` SET TAGS ('dbx_business_glossary_term' = 'Measure Name (MEASURE_NAME)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `ee_measure_status` SET TAGS ('dbx_business_glossary_term' = 'Measure Status (MEASURE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `ee_measure_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft|pending');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_END_DT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START_DT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `eligible_customer_class` SET TAGS ('dbx_business_glossary_term' = 'Eligible Customer Class (CUSTOMER_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `eligible_customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `estimated_annual_energy_savings_kwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Energy Savings (EST_ANNUAL_SAV_KWH)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `estimated_demand_reduction_kw` SET TAGS ('dbx_business_glossary_term' = 'Estimated Demand Reduction (EST_DEMAND_REDUCTION_KW)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID (EXT_REF_ID)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount (INCENTIVE_AMT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type (INCENTIVE_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'per_unit|per_kwh_saved|fixed_amount');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `is_pilot` SET TAGS ('dbx_business_glossary_term' = 'Pilot Measure Flag (IS_PILOT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `measure_life_years` SET TAGS ('dbx_business_glossary_term' = 'Measure Life (MEASURE_LIFE_YRS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `pilot_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pilot End Date (PILOT_END_DT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `pilot_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pilot Start Date (PILOT_START_DT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `qualifying_specification` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Specification (QUAL_SPEC)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE_SYS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`ee_measure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `rate_schedule_version_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Version ID');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `chart_of_accounts_id` SET TAGS ('dbx_business_glossary_term' = 'Chart Of Accounts Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule ID');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `change_description` SET TAGS ('dbx_business_glossary_term' = 'Change Description');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `demand_charge_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Flag');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `docket_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Docket Number');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `off_peak_rate` SET TAGS ('dbx_business_glossary_term' = 'Off‑Peak Rate');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `peak_rate` SET TAGS ('dbx_business_glossary_term' = 'Peak Rate');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `rate_class` SET TAGS ('dbx_business_glossary_term' = 'Rate Class');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `rate_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `rate_schedule_version_status` SET TAGS ('dbx_business_glossary_term' = 'Version Status');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `rate_schedule_version_status` SET TAGS ('dbx_value_regex' = 'filed|approved|rejected|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `schedule_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `schedule_type` SET TAGS ('dbx_business_glossary_term' = 'Schedule Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `schedule_type` SET TAGS ('dbx_value_regex' = 'electric|gas|dual');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `tariff_category` SET TAGS ('dbx_business_glossary_term' = 'Tariff Category');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `tariff_category` SET TAGS ('dbx_value_regex' = 'TOU|CPP|RTP|Flat|Demand|Time-of-Use');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `time_of_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Time‑of‑Use Flag');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|MCF|Therm|MWh');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_version` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `rate_schedule_applicability_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Applicability Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `customer_class_code` SET TAGS ('dbx_business_glossary_term' = 'Customer Class Code');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `customer_class_code` SET TAGS ('dbx_value_regex' = 'RESIDENTIAL|SMALL_COMMERCIAL|LARGE_COMMERCIAL|INDUSTRIAL|AGRICULTURAL');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Mandatory Applicability Flag');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Applicability Notes');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `rate_schedule_applicability_status` SET TAGS ('dbx_business_glossary_term' = 'Applicability Status');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `rate_schedule_applicability_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|draft|archived');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|CC&B|MDM|GIS');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `voltage_level_code` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level Code');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `voltage_level_code` SET TAGS ('dbx_value_regex' = 'RES_SEC|COM_PRIM|TRANSMISSION');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_schedule_applicability` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` SET TAGS ('dbx_subdomain' = 'program_administration');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `special_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Special Contract Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `annual_consumption_max_mwh` SET TAGS ('dbx_business_glossary_term' = 'Annual Consumption Maximum (MWh)');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `annual_consumption_min_mwh` SET TAGS ('dbx_business_glossary_term' = 'Annual Consumption Minimum (MWh)');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `capital_investment_threshold` SET TAGS ('dbx_business_glossary_term' = 'Capital Investment Threshold');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `contract_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contract Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `contract_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Description');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `contract_signed_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Signed Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'special|custom|development|municipal');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `contract_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Contract Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `contract_version_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Version Number');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `curtailment_compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Compensation Amount');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `curtailment_compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `curtailment_compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `demand_charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Rate (USD per kW)');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `demand_threshold_kw` SET TAGS ('dbx_business_glossary_term' = 'Demand Threshold (kW)');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `economic_development_incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Economic Development Incentive Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `economic_development_incentive_type` SET TAGS ('dbx_value_regex' = 'job_creation|capital_investment|tax_credit');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `energy_charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Energy Charge Rate (USD per kWh)');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `interruptibility_obligation` SET TAGS ('dbx_business_glossary_term' = 'Interruptibility Obligation');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `job_creation_threshold` SET TAGS ('dbx_business_glossary_term' = 'Job Creation Threshold');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `load_profile_type` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `load_profile_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `minimum_annual_revenue` SET TAGS ('dbx_business_glossary_term' = 'Minimum Annual Revenue Guarantee');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `premise_type` SET TAGS ('dbx_business_glossary_term' = 'Premise Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `puc_approval_docket_number` SET TAGS ('dbx_business_glossary_term' = 'PUC Approval Docket Number');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `ratchet_provision_details` SET TAGS ('dbx_business_glossary_term' = 'Ratchet Provision Details');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `ratchet_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Ratchet Provision Flag');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Months)');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `special_condition` SET TAGS ('dbx_business_glossary_term' = 'Special Condition');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `special_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `special_contract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending|draft');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (Days)');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level');
ALTER TABLE `power_and_utilities_v2`.`product`.`special_contract` ALTER COLUMN `voltage_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` SET TAGS ('dbx_subdomain' = 'program_administration');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `budget_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `umbrella_product_program_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `administrator` SET TAGS ('dbx_business_glossary_term' = 'Program Administrator (ADMIN)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Amount (BUDGET_AMT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Budget Currency (CURRENCY)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `budget_cycle_year` SET TAGS ('dbx_business_glossary_term' = 'Budget Cycle Year (BUDGET_YEAR)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `cap_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Cap Exempt Flag (CAP_EXEMPT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Email (EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Program Contact Phone (PHONE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^[0-9]{10}$');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `current_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count (ENROLL_COUNT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `demand_profile_type` SET TAGS ('dbx_business_glossary_term' = 'Demand Profile Type (DEMAND_PROFILE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `demand_profile_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (END_DATE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (START_DATE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (CRITERIA)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `enrollment_capacity` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity (CAPACITY)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount (INCENTIVE_AMT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type (INCENTIVE_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'rebate|discount|credit|none');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `incentive_unit` SET TAGS ('dbx_business_glossary_term' = 'Incentive Unit (UNIT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `incentive_unit` SET TAGS ('dbx_value_regex' = 'dollar_per_kwh|dollar_per_mwh|percent|dollar');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `is_mandatory` SET TAGS ('dbx_business_glossary_term' = 'Is Mandatory (MANDATORY)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (REVIEW_DATE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `load_reduction_target_kw` SET TAGS ('dbx_business_glossary_term' = 'Load Reduction Target (KW)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `participation_fee` SET TAGS ('dbx_business_glossary_term' = 'Participation Fee (FEE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `product_program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description (DESC)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `product_program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `product_program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|suspended|retired');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category (CATEGORY)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'dr|nem|ee|low_income|ev|green');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Program Code (CODE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name (NAME)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `puc_authorization_reference` SET TAGS ('dbx_business_glossary_term' = 'PUC Authorization Reference (PUC_REF)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By (REVIEWED_BY)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `savings_goal_kwh` SET TAGS ('dbx_business_glossary_term' = 'Savings Goal (KWH)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code (TERRITORY)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SOURCE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Program Status Reason (STATUS_REASON)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Program Subcategory (SUBCATEGORY)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `system_size_cap_kw` SET TAGS ('dbx_business_glossary_term' = 'System Size Cap (KW)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment (SEGMENT)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `url` SET TAGS ('dbx_business_glossary_term' = 'Program URL (URL)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Program Version (VERSION)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `version_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Version Effective Date (VER_EFF_DATE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `version_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Version Expiration Date (VER_EXP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (VOLTAGE)');
ALTER TABLE `power_and_utilities_v2`.`product`.`product_program` ALTER COLUMN `voltage_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` SET TAGS ('dbx_subdomain' = 'program_administration');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `program_measure_id` SET TAGS ('dbx_business_glossary_term' = 'Program Measure Identifier');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `bundled_with_program_measure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `baseline_efficiency` SET TAGS ('dbx_business_glossary_term' = 'Baseline Efficiency');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `cap_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Cap Exempt Indicator');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `deemed_savings_source` SET TAGS ('dbx_business_glossary_term' = 'Deemed Savings Source');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `deemed_savings_value_kwh_per_year` SET TAGS ('dbx_business_glossary_term' = 'Deemed Savings (kWh/Year)');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `eligibility_customer_class` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Customer Class');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `eligibility_customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Status');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `eligibility_status` SET TAGS ('dbx_value_regex' = 'eligible|ineligible|pending');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `estimated_annual_energy_savings_kwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Energy Savings (kWh)');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `estimated_demand_reduction_kw` SET TAGS ('dbx_business_glossary_term' = 'Estimated Demand Reduction (kW)');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `external_reference_code` SET TAGS ('dbx_business_glossary_term' = 'External Reference ID');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `incentive_method` SET TAGS ('dbx_business_glossary_term' = 'Incentive Method');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `incentive_method` SET TAGS ('dbx_value_regex' = 'per_unit|per_kWh|flat');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'rebate|discount|credit|incentive');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `incentive_unit` SET TAGS ('dbx_business_glossary_term' = 'Incentive Unit');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `incentive_unit` SET TAGS ('dbx_value_regex' = '$/unit|$/kWh|$/kW');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `is_deemed_savings` SET TAGS ('dbx_business_glossary_term' = 'Deemed Savings Indicator');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `is_pilot` SET TAGS ('dbx_business_glossary_term' = 'Pilot Indicator');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `measure_code` SET TAGS ('dbx_business_glossary_term' = 'Measure Code');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `measure_life_years` SET TAGS ('dbx_business_glossary_term' = 'Measure Life (Years)');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `minimum_qualifying_specification` SET TAGS ('dbx_business_glossary_term' = 'Minimum Qualifying Specification');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Measure Notes');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `pilot_end_date` SET TAGS ('dbx_business_glossary_term' = 'Pilot End Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `pilot_start_date` SET TAGS ('dbx_business_glossary_term' = 'Pilot Start Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `program_measure_category` SET TAGS ('dbx_business_glossary_term' = 'Measure Category');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `program_measure_description` SET TAGS ('dbx_business_glossary_term' = 'Measure Description');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `program_measure_name` SET TAGS ('dbx_business_glossary_term' = 'Measure Name');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `program_measure_status` SET TAGS ('dbx_business_glossary_term' = 'Measure Status');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `program_measure_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'energy_efficiency|demand_response|net_energy_metering|electric_vehicle|renewable_incentive');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `qualifying_specification` SET TAGS ('dbx_business_glossary_term' = 'Qualifying Specification');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'CC&B|MDM|Maximo|Allegro|Custom');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Measure Subcategory');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|kW|unit');
ALTER TABLE `power_and_utilities_v2`.`product`.`program_measure` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` SET TAGS ('dbx_subdomain' = 'rate_management');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `rate_season_calendar_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Season Calendar ID');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `superseded_rate_season_calendar_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `applicable_customer_class` SET TAGS ('dbx_business_glossary_term' = 'Applicable Customer Class');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `applicable_customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `applicable_service_type` SET TAGS ('dbx_business_glossary_term' = 'Applicable Service Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `applicable_service_type` SET TAGS ('dbx_value_regex' = 'electric|gas|both');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `calendar_category` SET TAGS ('dbx_business_glossary_term' = 'Calendar Category');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `calendar_category` SET TAGS ('dbx_value_regex' = 'TOU|CPP|RTP|Flat|Seasonal|Hybrid');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `calendar_code` SET TAGS ('dbx_business_glossary_term' = 'Calendar Code');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `calendar_name` SET TAGS ('dbx_business_glossary_term' = 'Calendar Name');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_business_glossary_term' = 'Calendar Type');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `calendar_type` SET TAGS ('dbx_value_regex' = 'seasonal|daytype|combined');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `demand_charge_applicable` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Applicable Flag');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `demand_charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Rate');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `holiday_dates` SET TAGS ('dbx_business_glossary_term' = 'Holiday Dates');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `holiday_names` SET TAGS ('dbx_business_glossary_term' = 'Holiday Names');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `is_default_calendar` SET TAGS ('dbx_business_glossary_term' = 'Default Calendar Flag');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `is_holiday_observed` SET TAGS ('dbx_business_glossary_term' = 'Holiday Observed Flag');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `off_peak_period_end_time` SET TAGS ('dbx_business_glossary_term' = 'Off‑Peak Period End Time');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `off_peak_period_start_time` SET TAGS ('dbx_business_glossary_term' = 'Off‑Peak Period Start Time');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `off_peak_price_factor` SET TAGS ('dbx_business_glossary_term' = 'Off‑Peak Price Factor');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `peak_period_end_time` SET TAGS ('dbx_business_glossary_term' = 'Peak Period End Time');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `peak_period_start_time` SET TAGS ('dbx_business_glossary_term' = 'Peak Period Start Time');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `peak_price_factor` SET TAGS ('dbx_business_glossary_term' = 'Peak Price Factor');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `price_unit` SET TAGS ('dbx_value_regex' = 'kWh|therm|MWh|MCF');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `rate_season_calendar_status` SET TAGS ('dbx_business_glossary_term' = 'Calendar Status');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `rate_season_calendar_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|draft');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `regulatory_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Number');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `reviewed_by` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `season_shoulder_end` SET TAGS ('dbx_business_glossary_term' = 'Shoulder Season End Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `season_shoulder_start` SET TAGS ('dbx_business_glossary_term' = 'Shoulder Season Start Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `season_summer_end` SET TAGS ('dbx_business_glossary_term' = 'Summer Season End Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `season_summer_start` SET TAGS ('dbx_business_glossary_term' = 'Summer Season Start Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `season_winter_end` SET TAGS ('dbx_business_glossary_term' = 'Winter Season End Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `season_winter_start` SET TAGS ('dbx_business_glossary_term' = 'Winter Season Start Date');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `time_zone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`product`.`rate_season_calendar` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
