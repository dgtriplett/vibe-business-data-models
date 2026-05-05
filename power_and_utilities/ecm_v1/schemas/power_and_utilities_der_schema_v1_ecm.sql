-- Schema for Domain: der | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:14

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`der` COMMENT 'Distributed energy resources management including rooftop solar, battery storage, EV charging infrastructure, microgrids, and customer-sited generation. Manages NEM programs, interconnection requests, DER aggregation, VPP coordination, and grid integration. Integrates with DERMS platforms for real-time DER visibility and dispatch optimization.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`resource` (
    `resource_id` BIGINT COMMENT 'Unique surrogate key for each DER asset record.',
    `aggregation_group_id` BIGINT COMMENT 'Foreign key linking to der.aggregation_group. Business justification: A DER resource belongs to an aggregation group; linking enables group‑level reporting and dispatch coordination.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Required for Asset Management of DER equipment; depreciation, compliance, and work order tracking need a link from each DER resource to its Asset Registry record.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: REQUIRED: Ownership of each DER asset by a customer account is needed for billing, net‑metering settlement and regulatory reporting.',
    `circuit_feeder_id` BIGINT COMMENT 'Identifier of the distribution circuit serving the DER.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Each DER must track specific compliance obligations (safety, environmental) for audit and reporting purposes.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to regulatory.environmental_permit. Business justification: Regulatory permits must be recorded for each DER installation; permits are required for compliance reporting and site approval.',
    `feeder_id` BIGINT COMMENT 'Identifier of the feeder line to which the DER connects.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Asset accounting requires linking each DER resource to its fixed asset record for depreciation, regulatory reporting, and capital cost tracking.',
    `generating_unit_id` BIGINT COMMENT 'Foreign key linking to generation.generating_unit. Business justification: Market participation treats DER as generating units; linking enables ISO/RTO scheduling and dispatch reporting.',
    `it_asset_id` BIGINT COMMENT 'Unique identifier of the inverter device associated with the DER.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Needed for GIS mapping and outage management; the site location of each DER must be tied to the utility’s master location record.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Required for DER generation reporting and net‑metering compliance; each DER resource must be linked to its generation meter for performance monitoring and regulatory reporting.',
    `metering_service_point_id` BIGINT COMMENT 'Foreign key linking to metering.metering_service_point. Business justification: Needed to map each DER to the service point where it interconnects, supporting grid impact studies, outage management, and location‑based planning.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Regulatory asset registry requires each DER to be tied to its parcel for location reporting, maintenance scheduling, and outage management.',
    `plant_id` BIGINT COMMENT 'Foreign key linking to generation.plant. Business justification: REC compliance requires associating each DER with its parent generation plant for regulator reporting.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Needed for site verification and permitting; each DER installation is linked to a physical premise address.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: CAPITAL ASSET TRACKING: Associates the DER asset with the PO that purchased it for cost allocation and audit.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Utility operations track DERs within larger generation sites for dispatch coordination and site‑level performance reporting.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: DER asset registration records the substation point of interconnection for dispatch, outage coordination, and regulatory reporting.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: PROCUREMENT/WARRANTY: Links each DER asset to its equipment vendor for warranty, service contracts, and compliance reporting.',
    `asset_tag` STRING COMMENT 'External identifier or tag used in field operations and asset registers.',
    `battery_storage_capacity_kwh` DECIMAL(18,2) COMMENT 'Energy storage capacity of battery‑based DERs.',
    `capacity_kw` DECIMAL(18,2) COMMENT 'Maximum continuous power output rating of the DER.',
    `commissioning_date` DATE COMMENT 'Date the DER became operational and was accepted by the utility.',
    `communication_protocol` STRING COMMENT 'Standard protocol used for DER‑to‑DERMS communication.. Valid values are `IEEE_2030_5|OpenADR|OCPP|Modbus`',
    `compliance_last_checked_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent compliance verification.',
    `compliance_status` STRING COMMENT 'Current compliance state with IEEE 1547 and regulatory requirements.. Valid values are `compliant|non_compliant|pending_review`',
    `configuration_approval_status` STRING COMMENT 'Current approval state of the DER configuration in DERMS.. Valid values are `approved|pending|rejected`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the DER record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date the DER was retired or removed from service (nullable).',
    `der_type` STRING COMMENT 'Technology category of the DER (e.g., rooftop solar, battery storage, EV charger).. Valid values are `solar|battery|ev_charger|fuel_cell|wind|generator`',
    `derms_device_code` STRING COMMENT 'Identifier of the DER within the Distributed Energy Resource Management System.',
    `ev_charging_power_kw` DECIMAL(18,2) COMMENT 'Maximum charging power of an EV charging station DER.',
    `export_limit_kw` DECIMAL(18,2) COMMENT 'Maximum power the DER may export to the grid.',
    `ieee_1547_category` STRING COMMENT 'IEEE 1547‑2018 compliance category for the inverter.. Valid values are `Category_A|Category_B|Category_C|Category_D`',
    `import_limit_kw` DECIMAL(18,2) COMMENT 'Maximum power the DER may import from the grid.',
    `installation_date` DATE COMMENT 'Date the DER was physically installed at the site.',
    `inverter_settings` STRING COMMENT 'Serialized inverter configuration (Volt‑VAR, Volt‑Watt, Frequency‑Watt curves).',
    `last_config_push_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent configuration push to the DER.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the DER.',
    `manufacturer` STRING COMMENT 'Company that manufactured the DER equipment.',
    `net_metering_eligibility` BOOLEAN COMMENT 'Indicates whether the DER participates in a Net Energy Metering program.',
    `net_metering_rate` DECIMAL(18,2) COMMENT 'Compensation rate applied to exported energy under NEM.',
    `ownership_type` STRING COMMENT 'Entity that owns the DER asset.. Valid values are `customer_owned|utility_owned|third_party`',
    `phase` STRING COMMENT 'Electrical phase configuration of the DER (single‑phase or three‑phase).. Valid values are `single|three`',
    `ramp_rate_kw_per_min` DECIMAL(18,2) COMMENT 'Maximum rate at which the DER can change output.',
    `resource_name` STRING COMMENT 'Human‑readable name or designation of the DER asset.',
    `resource_status` STRING COMMENT 'Current operational status of the DER asset.. Valid values are `active|inactive|retired|decommissioned|pending`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the DER record.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal line‑to‑line voltage at the point of interconnection.',
    `warranty_expiration_date` DATE COMMENT 'Date when the manufacturer warranty expires.',
    CONSTRAINT pk_resource PRIMARY KEY(`resource_id`)
) COMMENT 'Master record for each distributed energy resource (DER) asset — customer-sited or utility-owned — including rooftop solar PV, battery storage (BESS), EV charging stations, fuel cells, small wind, and backup generators. Captures nameplate capacity (kW/kWh), technology type, manufacturer/model, installation address, GPS coordinates, commissioning date, operational status, interconnection point (POI), serving circuit/feeder, DERMS asset ID, IEEE 1547 category, and complete technical configuration: inverter settings (Volt-VAR curve, Volt-Watt curve, frequency-watt response), export/import limits (kW), ramp rate limits (kW/min), communication protocol (IEEE 2030.5, OpenADR, OCPP, Modbus), DERMS device ID, firmware version, last configuration push timestamp, and configuration approval status. Serves as the single source of truth for all DER physical assets, their DERMS-registered configurations, and IEEE 1547-2018 advanced inverter function compliance within the utility service territory.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`interconnection_request` (
    `interconnection_request_id` BIGINT COMMENT 'System-generated unique identifier for the interconnection request.',
    `employee_id` BIGINT COMMENT 'Unique identifier of the party applying for interconnection.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to regulatory.environmental_permit. Business justification: Many interconnection projects require environmental permits; linking enables permit status tracking per request.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Interconnection requests are submitted as regulatory filings; the filing record captures submission, status, and approval.',
    `feeder_id` BIGINT COMMENT 'Identifier of the distribution feeder serving the POI.',
    `inspector_employee_id` BIGINT COMMENT 'Unique identifier of the inspector who performed the inspection.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Interconnection studies rely on precise GIS location; linking request to the master location enables planning, permitting, and regulatory reporting.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Interconnection requests require assigning a specific meter that will record the DERs output for compliance, billing, and post‑installation verification.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Interconnection studies and permits must reference the parcel where the new connection will be built, supporting planning and compliance.',
    `person_id` BIGINT COMMENT 'Unique identifier of the party applying for interconnection.',
    `technician_id` BIGINT COMMENT 'Unique identifier of the inspector who performed the inspection.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Required for FERC interconnection filing: the request must specify the transmission substation where the DER will interconnect.',
    `agreement_execution_date` DATE COMMENT 'Date the interconnection agreement was signed and executed.',
    `applicant_address` STRING COMMENT 'Physical mailing address of the applicant.',
    `applicant_email` STRING COMMENT 'Primary email address for applicant communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `applicant_name` STRING COMMENT 'Legal full name of the applicant.',
    `applicant_phone` STRING COMMENT 'Contact telephone number for the applicant.',
    `applicant_type` STRING COMMENT 'Classification of the applicant (e.g., residential customer, third‑party developer).. Valid values are `customer|third_party|developer`',
    `application_submitted_timestamp` TIMESTAMP COMMENT 'Date‑time when the interconnection application was initially submitted.',
    `approval_date` DATE COMMENT 'Date the interconnection request was formally approved.',
    `der_capacity_kw` DECIMAL(18,2) COMMENT 'Maximum generating or storage capacity of the DER in kilowatts.',
    `der_type` STRING COMMENT 'Technology category of the DER being interconnected.. Valid values are `rooftop_solar|battery_storage|ev_charging|microgrid|customer_sited`',
    `estimated_study_cost_usd` DECIMAL(18,2) COMMENT 'Projected total cost of all interconnection studies in U.S. dollars.',
    `facilities_study_completion_date` DATE COMMENT 'Date when the facilities study was completed.',
    `facilities_study_status` STRING COMMENT 'Current status of the facilities study phase.. Valid values are `pending|in_progress|completed|failed`',
    `feasibility_study_completion_date` DATE COMMENT 'Date when the feasibility study was completed.',
    `feasibility_study_status` STRING COMMENT 'Current status of the feasibility study phase.. Valid values are `pending|in_progress|completed|failed`',
    `ferc_order_2222_compliant` BOOLEAN COMMENT 'Indicates whether the interconnection complies with FERC Order 2222 requirements.',
    `indemnification_terms` STRING COMMENT 'Legal indemnity provisions included in the agreement.',
    `inspection_date` DATE COMMENT 'Date the inspection was performed.',
    `inspection_result` STRING COMMENT 'Outcome of the inspection (pass or fail).. Valid values are `pass|fail`',
    `inspection_type` STRING COMMENT 'Category of the interconnection inspection.. Valid values are `initial|final|reinspection`',
    `insurance_obligations` STRING COMMENT 'Required insurance coverage and limits for the interconnection.',
    `lifecycle_status` STRING COMMENT 'Current processing state of the interconnection request.. Valid values are `draft|submitted|under_review|approved|rejected|closed`',
    `max_export_capacity_kw` DECIMAL(18,2) COMMENT 'Maximum power the DER may export to the grid under the agreement.',
    `metering_requirements` STRING COMMENT 'Metering and data collection obligations for the DER.',
    `permit_approval_date` DATE COMMENT 'Date the permit was approved by the authority.',
    `permit_conditions` STRING COMMENT 'Specific conditions or requirements attached to the permit.',
    `permit_issuing_authority` STRING COMMENT 'Regulatory body or agency that issues the permit.',
    `permit_submission_date` DATE COMMENT 'Date the permit application was submitted.',
    `permit_type` STRING COMMENT 'Classification of the required permit (e.g., building, electrical).',
    `poi_location` STRING COMMENT 'Human‑readable description of the POI location (e.g., address or substation name).',
    `point_of_interconnection_reference` STRING COMMENT 'Utility‑assigned identifier for the point where the DER connects to the grid.',
    `protection_requirements` STRING COMMENT 'Technical protection and control specifications required for interconnection.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `request_number` STRING COMMENT 'External reference number assigned to the interconnection request.',
    `state_puc_tariff_code` STRING COMMENT 'Tariff code from the applicable state public utility commission governing the interconnection.',
    `study_queue_position` STRING COMMENT 'Numeric position of the request in the interconnection study queue.',
    `system_impact_study_completion_date` DATE COMMENT 'Date when the system impact study was completed.',
    `system_impact_study_status` STRING COMMENT 'Current status of the system impact study phase.. Valid values are `pending|in_progress|completed|failed`',
    `termination_conditions` STRING COMMENT 'Conditions under which the interconnection agreement may be terminated.',
    CONSTRAINT pk_interconnection_request PRIMARY KEY(`interconnection_request_id`)
) COMMENT 'Tracks the full lifecycle of a customer or third-party application to interconnect a DER to the utility distribution grid, from initial application through technical studies to executed interconnection agreement. Captures application date, applicant identity, proposed DER type and capacity (kW), point of interconnection (POI), study queue position, technical review phases (feasibility, system impact, facilities — with findings, costs, and engineer assignments), approval milestones, permit tracking (permit type, issuing authority, submission/approval dates, conditions), inspection records (inspection type, date, inspector, pass/fail, deficiency notes), and the executed interconnection agreement details (execution date, maximum export capacity, protection/control requirements, metering requirements, insurance obligations, indemnification terms, termination conditions). Aligns with FERC Order 2222 and state PUC interconnection tariff requirements. Single product owns the complete interconnection queue lifecycle from application through executed agreement.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`nem_account` (
    `nem_account_id` BIGINT COMMENT 'Primary key for nem_account',
    `aggregation_group_id` BIGINT COMMENT 'Identifier of the DER aggregation group the account participates in.',
    `asset_permit_compliance_document_id` BIGINT COMMENT 'Reference to the regulatory compliance document associated with the NEM account.',
    `document_id` BIGINT COMMENT 'Reference to the regulatory compliance document associated with the NEM account.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the utility service account linked to this NEM account.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: NEM account revenue and credit transactions flow through a designated GL account for proper revenue recognition and reporting.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to trading.trading_portfolio. Business justification: Net Energy Metering accounts are aggregated into a trading portfolio for settlement and financial reporting.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: NEM settlement uses a specific rate schedule to calculate export credits; linking NEM account to rate_schedule enables accurate regulatory reporting.',
    `annual_true_up_amount` DECIMAL(18,2) COMMENT 'Monetary amount resulting from the annual true‑up.',
    `annual_true_up_currency` STRING COMMENT 'Currency of the annual true‑up amount.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `annual_true_up_date` DATE COMMENT 'Date on which the annual net‑metering reconciliation is performed.',
    `annual_true_up_kwh` DECIMAL(18,2) COMMENT 'Net kilowatt‑hours calculated during the annual true‑up.',
    `annual_true_up_status` STRING COMMENT 'Processing status of the annual true‑up.. Valid values are `pending|completed|adjusted`',
    `approval_date` DATE COMMENT 'Date the interconnection was approved.',
    `approval_status` STRING COMMENT 'Regulatory approval status for the interconnection request.. Valid values are `pending|approved|rejected`',
    `banking_period_end` DATE COMMENT 'End date of the current net‑kWh banking period.',
    `banking_period_start` DATE COMMENT 'Start date of the current net‑kWh banking period.',
    `credit_balance` DECIMAL(18,2) COMMENT 'Monetary credit remaining from net‑metered exports.',
    `credit_currency` STRING COMMENT 'Currency of the NEM credit balance.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `credit_expiration_date` DATE COMMENT 'Date after which unclaimed credits expire.',
    `cumulative_net_kwh_banked` DECIMAL(18,2) COMMENT 'Total net kilowatt‑hours exported and banked to date.',
    `enrollment_date` DATE COMMENT 'Date the customer was enrolled in the NEM program.',
    `export_compensation_rate` DECIMAL(18,2) COMMENT 'Monetary rate paid to the customer for exported energy.',
    `interconnection_date` DATE COMMENT 'Date the customers generation system was interconnected to the grid.',
    `last_reading_date` DATE COMMENT 'Date of the most recent export meter reading.',
    `last_reading_kwh` DECIMAL(18,2) COMMENT 'Export kilowatt‑hours recorded in the most recent reading.',
    `last_reading_quality_flag` STRING COMMENT 'Quality indicator for the last meter reading.. Valid values are `good|estimated|missing`',
    `meter_reading_source` STRING COMMENT 'Source of the most recent meter reading.. Valid values are `automated|manual`',
    `meter_type` STRING COMMENT 'Technology type of the meter (Advanced Metering Infrastructure or legacy).. Valid values are `ami|non_ami`',
    `nem_account_number` STRING COMMENT 'External account number assigned to the customer for NEM program tracking.',
    `net_metering_capacity_kw` DECIMAL(18,2) COMMENT 'Maximum export capacity authorized for the customer.',
    `net_metering_status` STRING COMMENT 'Current operational status of the NEM account.. Valid values are `active|inactive|suspended|terminated`',
    `net_metering_type` STRING COMMENT 'Classification of the NEM account based on customer class.. Valid values are `residential|commercial|industrial`',
    `program_enrollment_status` STRING COMMENT 'Current enrollment state of the customer in the NEM program.. Valid values are `enrolled|withdrawn|suspended`',
    `program_version` STRING COMMENT 'Version of the Net Energy Metering program under which the account is enrolled.. Valid values are `NEM 1.0|NEM 2.0|NEM 3.0|NEM-A`',
    `rate_structure` STRING COMMENT 'Structure used to calculate export compensation (e.g., fixed, tiered, time‑of‑use).. Valid values are `fixed|tiered|time_of_use|dynamic`',
    `rate_type` STRING COMMENT 'Category of the export compensation rate.. Valid values are `fixed|tou|cpp|rtp`',
    `rate_units` STRING COMMENT 'Units for the export rate (e.g., USD per kWh).',
    `rate_value` DECIMAL(18,2) COMMENT 'Numeric value of the export compensation rate.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the NEM account record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the NEM account record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether the account is subject to additional regulatory reporting.',
    `tariff_schedule_code` STRING COMMENT 'Code of the tariff schedule governing the customers consumption rates.',
    `termination_date` DATE COMMENT 'Date the NEM account was terminated, if applicable.',
    `termination_reason` STRING COMMENT 'Reason for terminating the NEM agreement, if applicable.',
    `vpp_participation_flag` BOOLEAN COMMENT 'Indicates whether the account is part of a VPP program.',
    CONSTRAINT pk_nem_account PRIMARY KEY(`nem_account_id`)
) COMMENT 'Master record for each customer enrolled in a Net Energy Metering (NEM) program. Captures NEM program version (NEM 1.0, NEM 2.0, NEM 3.0/NEM-A), enrollment date, export compensation rate structure, annual true-up date, banking period, cumulative net kWh banked, associated service account, and applicable tariff schedule. Serves as the SSOT for NEM program participation and export credit entitlements.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`nem_true_up` (
    `nem_true_up_id` BIGINT COMMENT 'System-generated unique identifier for the NEM true‑up settlement record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer whose NEM true‑up is being settled.',
    `nem_account_id` BIGINT COMMENT 'Foreign key linking to der.nem_account. Business justification: A NEM true‑up settlement is performed per NEM account; linking provides direct access to account details and removes redundant customer reference.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: NEM true‑up settlements are reported via regulatory filings; linking records the filing reference.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Net Energy Metering true‑up settlements are posted to a specific GL account; the link ensures accurate financial posting and audit trails.',
    `person_id` BIGINT COMMENT 'Identifier of the customer whose NEM true‑up is being settled.',
    `adjustment_amount_usd` DECIMAL(18,2) COMMENT 'Any monetary adjustments (e.g., penalties, rebates) applied before final settlement.',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the settlement was approved for posting to the billing system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.',
    `export_credit_applied` BOOLEAN COMMENT 'Indicates whether the export credit was applied to this settlement.',
    `export_credit_value_usd` DECIMAL(18,2) COMMENT 'Monetary value of the exported energy credit applied to the settlement.',
    `nem_true_up_status` STRING COMMENT 'Current lifecycle status of the true‑up settlement.. Valid values are `pending|settled|reversed|cancelled`',
    `net_kwh_balance` DECIMAL(18,2) COMMENT 'Net energy balance (exported minus imported) for the period.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or explanations about the settlement.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the true‑up record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the true‑up record.',
    `regulatory_filing_status` STRING COMMENT 'Status of any required regulatory filing associated with this settlement.. Valid values are `not_filed|filed|approved|rejected`',
    `remaining_balance_usd` DECIMAL(18,2) COMMENT 'Outstanding amount owed to or by the customer after settlement.',
    `settlement_amount_usd` DECIMAL(18,2) COMMENT 'Final monetary amount settled after applying credits and adjustments.',
    `settlement_method` STRING COMMENT 'Process used to execute the settlement, either automatically by the system or manually by staff.. Valid values are `automatic|manual`',
    `settlement_number` STRING COMMENT 'External settlement reference number assigned by the settlement system.',
    `settlement_timestamp` TIMESTAMP COMMENT 'Date‑time when the settlement was executed.',
    `settlement_type` STRING COMMENT 'Indicates whether the true‑up is an annual or periodic settlement.. Valid values are `annual|periodic`',
    `total_exported_kwh` DECIMAL(18,2) COMMENT 'Cumulative kilowatt‑hours exported to the grid during the true‑up period.',
    `total_imported_kwh` DECIMAL(18,2) COMMENT 'Cumulative kilowatt‑hours imported from the grid during the true‑up period.',
    `true_up_period_end` DATE COMMENT 'Last day of the NEM banking period covered by this true‑up.',
    `true_up_period_start` DATE COMMENT 'First day of the NEM banking period covered by this true‑up.',
    CONSTRAINT pk_nem_true_up PRIMARY KEY(`nem_true_up_id`)
) COMMENT 'Annual or periodic NEM true-up settlement record reconciling a customers net energy exports against imports over the NEM banking period. Captures true-up period start/end dates, total kWh exported, total kWh imported, net kWh balance, export credit value applied, any remaining balance owed or credited, and settlement amount. Feeds into billing domain for final invoice generation.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` (
    `der_program_enrollment_id` BIGINT COMMENT 'Primary key for program_enrollment',
    `aggregator_id` BIGINT COMMENT 'Identifier of the third‑party aggregator managing the DER asset, if applicable.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Program enrollment reports require linking each enrollment record to the owning customer account.',
    `der_program_id` BIGINT COMMENT 'Foreign key linking to der.program. Business justification: Program enrollment records should reference the canonical program entity; this eliminates duplicated program descriptors.',
    `distribution_service_point_id` BIGINT COMMENT 'Identifier of the service point where the DER asset is connected.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Program enrollment expenses are charged to a cost center to support budgeting, cost allocation, and performance analysis.',
    `meter_id` BIGINT COMMENT 'Identifier of the meter associated with the DER asset.',
    `capacity_kw` DECIMAL(18,2) COMMENT 'Maximum capacity of the DER asset committed to the program, expressed in kilowatts.',
    `contractual_obligation` STRING COMMENT 'Text describing any contractual commitments or penalties associated with the enrollment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the lakehouse.',
    `effective_from` DATE COMMENT 'Date when the enrollment becomes operationally effective.',
    `effective_until` DATE COMMENT 'Date when the enrollment expires or is terminated (null if open‑ended).',
    `eligibility_criteria` STRING COMMENT 'Summary of the criteria the asset met to qualify for enrollment.',
    `enrollment_date` DATE COMMENT 'Date the asset was initially enrolled in the program.',
    `enrollment_number` STRING COMMENT 'Unique enrollment reference number assigned by the utility for tracking.',
    `enrollment_source` STRING COMMENT 'Channel through which the enrollment was captured.. Valid values are `online|call_center|field_agent|partner`',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment.. Valid values are `active|pending|suspended|terminated|opted_out`',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary incentive provided for the enrollment, expressed in USD.',
    `incentive_type` STRING COMMENT 'Classification of the incentive offered.. Valid values are `rebate|credit|payment|tax_credit`',
    `is_aggregated` BOOLEAN COMMENT 'Indicates whether the DER asset is part of an aggregated portfolio.',
    `opt_out_date` DATE COMMENT 'Date the participant elected to withdraw from the program.',
    `region_code` STRING COMMENT 'Three‑letter code representing the utility service region.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    `voltage_level` STRING COMMENT 'Voltage classification of the DER asset.. Valid values are `low|medium|high`',
    `created_by` STRING COMMENT 'User identifier of the person or system that created the record.',
    CONSTRAINT pk_der_program_enrollment PRIMARY KEY(`der_program_enrollment_id`)
) COMMENT 'Records a DER assets enrollment into a specific utility program such as demand response (DR), virtual power plant (VPP), grid services, or incentive programs. Captures enrollment date, program type, enrolled capacity (kW), aggregator identity if applicable, enrollment status, opt-out date, and contractual obligations. Distinct from NEM enrollment — covers operational grid services and incentive programs.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`aggregation_group` (
    `aggregation_group_id` BIGINT COMMENT 'System-generated unique identifier for the aggregation group.',
    `aggregator_id` BIGINT COMMENT 'System identifier of the managing aggregator entity.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Aggregation groups settle within a balancing area; market settlement and reporting need this association.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Aggregation groups aggregate DER assets; linking to a cost center consolidates financial reporting of grouped assets.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to trading.trading_portfolio. Business justification: Aggregation groups are represented in trading portfolios for market bidding, risk allocation, and regulatory reporting.',
    `primary_aggregation_aggregator_id` BIGINT COMMENT 'System identifier of the managing aggregator entity.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: Aggregation groups participate in specific rate cases; the FK supports rate‑case eligibility and reporting.',
    `aggregation_code` STRING COMMENT 'External business code or identifier used to reference the aggregation group in market filings and contracts.',
    `aggregation_group_description` STRING COMMENT 'Free‑form description providing additional context about the aggregation.',
    `aggregation_group_name` STRING COMMENT 'Human‑readable name of the aggregation group.',
    `aggregation_group_status` STRING COMMENT 'Current lifecycle status of the aggregation group.. Valid values are `forming|active|suspended|retired`',
    `aggregation_type` STRING COMMENT 'Category of the aggregation (e.g., Virtual Power Plant, DER fleet, microgrid, or third‑party aggregator).. Valid values are `vpp|fleet|microgrid|aggregator`',
    `aggregator_entity_name` STRING COMMENT 'Legal name of the entity that manages the aggregation.',
    `ancillary_service_type` STRING COMMENT 'Type of ancillary service the aggregation is authorized to provide.. Valid values are `regulation|spinning|non_spinning`',
    `capacity_reserve_mw` DECIMAL(18,2) COMMENT 'Reserved capacity held by the aggregation for reliability or ancillary services.',
    `compliance_status` STRING COMMENT 'Current compliance status of the aggregation with applicable market rules.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the aggregation group record was first created in the system.',
    `demand_response_capability` BOOLEAN COMMENT 'Indicates whether the aggregation can participate in demand‑response programs.',
    `demand_response_program` STRING COMMENT 'Identifier of the demand‑response program the aggregation is enrolled in.. Valid values are `dr|none|custom`',
    `dispatch_max_mw` DECIMAL(18,2) COMMENT 'Maximum MW the aggregation can be dispatched for a given market interval.',
    `dispatch_min_mw` DECIMAL(18,2) COMMENT 'Minimum MW the aggregation can be dispatched for a given market interval.',
    `effective_end_date` DATE COMMENT 'Date when the aggregation ceased to be effective (null if still active).',
    `effective_start_date` DATE COMMENT 'Date when the aggregation became effective for market participation.',
    `geographic_boundary_description` STRING COMMENT 'Textual description of the geographic area covered by the aggregation (e.g., county list, service territory).',
    `geographic_boundary_type` STRING COMMENT 'Classification of how the geographic boundary is defined.. Valid values are `zip|county|state|custom`',
    `is_virtual` BOOLEAN COMMENT 'Indicates whether the aggregation exists purely as a virtual construct (true) or includes physical assets (false).',
    `last_compliance_check_date` DATE COMMENT 'Date of the most recent compliance audit for the aggregation.',
    `market_participation_end_date` DATE COMMENT 'Date when the aggregation ceased market participation (null if ongoing).',
    `market_participation_start_date` DATE COMMENT 'Date when the aggregation first began participating in market operations.',
    `market_products_authorized` STRING COMMENT 'Comma‑separated list of market products the aggregation is authorized to provide.. Valid values are `energy|capacity|ancillary`',
    `market_registration_code` STRING COMMENT 'Unique identifier assigned by the RTO/ISO for market registration of the aggregation.',
    `net_energy_metering_enabled` BOOLEAN COMMENT 'True if the aggregation includes assets participating in a NEM program.',
    `net_energy_metering_program` STRING COMMENT 'Name of the NEM program associated with the aggregation.',
    `participation_mode` STRING COMMENT 'Mode of market participation for the aggregation.. Valid values are `centralized|decentralized`',
    `renewable_energy_certificate_quantity` DECIMAL(18,2) COMMENT 'Quantity of Renewable Energy Certificates generated by the aggregation, expressed in megawatt‑hours.',
    `renewable_energy_certificate_type` STRING COMMENT 'Type of Renewable Energy Certificate associated with the aggregation.. Valid values are `rec|none`',
    `resource_mix_ev_pct` DECIMAL(18,2) COMMENT 'Percentage of the aggregations capacity that is provided by electric‑vehicle charging infrastructure.',
    `resource_mix_solar_pct` DECIMAL(18,2) COMMENT 'Percentage of the aggregations capacity that is provided by solar generation assets.',
    `resource_mix_storage_pct` DECIMAL(18,2) COMMENT 'Percentage of the aggregations capacity that is provided by battery storage assets.',
    `rto_iso_market` STRING COMMENT 'Regional Transmission Organization or Independent System Operator market where the aggregation participates.',
    `settlement_account_number` STRING COMMENT 'Account number used for market settlement payments.',
    `total_capacity_mw` DECIMAL(18,2) COMMENT 'Sum of the nominal capacity of all DER assets in the aggregation, expressed in megawatts.',
    `updated_by` STRING COMMENT 'User or system identifier that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the aggregation group record.',
    `created_by` STRING COMMENT 'User or system identifier that created the aggregation record.',
    CONSTRAINT pk_aggregation_group PRIMARY KEY(`aggregation_group_id`)
) COMMENT 'Defines a logical grouping of DER assets aggregated for collective dispatch, VPP coordination, or wholesale market participation under FERC Order 2222. Captures aggregation name, managing aggregator entity, total enrolled capacity (MW), resource mix composition (solar %, storage %, EV %), geographic boundary, RTO/ISO market registration ID, market products authorized (energy, capacity, ancillary services), minimum/maximum dispatch range, and aggregation status (forming, active, suspended, retired). Enables fleet-level visibility, dispatch optimization, and market settlement in DERMS.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`dispatch_event` (
    `dispatch_event_id` BIGINT COMMENT 'Unique system-generated identifier for each dispatch event record.',
    `aggregation_group_id` BIGINT COMMENT 'Identifier of the VPP or DER aggregation group targeted by the dispatch.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Record safety incidents triggered by dispatch actions for post‑event analysis and regulatory incident reporting.',
    `resource_id` BIGINT COMMENT 'Identifier of the DER resource (e.g., solar inverter, battery, EV charger) receiving the dispatch.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Dispatch Origin Tracking; links each dispatch event to the SCADA system that issued the command for audit and compliance.',
    `actual_response` DECIMAL(18,2) COMMENT 'Measured power response actually delivered by the resource.',
    `bid_price` DECIMAL(18,2) COMMENT 'Price offered by the DER or aggregator for the dispatch, in USD.',
    `comments` STRING COMMENT 'Free‑form notes or operator remarks about the dispatch.',
    `compliance_flag` BOOLEAN COMMENT 'True if the dispatch complies with applicable FERC/NERC rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the dispatch event record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary fields.. Valid values are `USD|CAD|EUR`',
    `dispatch_event_status` STRING COMMENT 'Current lifecycle state of the dispatch event.. Valid values are `pending|approved|executed|cancelled|failed`',
    `dispatch_number` STRING COMMENT 'Human‑readable dispatch reference number used in operations and market filings.',
    `dispatch_reason` STRING COMMENT 'Business or operational rationale for the dispatch (e.g., frequency regulation, peak shave).',
    `dispatch_source` STRING COMMENT 'Origin of the dispatch instruction.. Valid values are `DERMS|Operator|Aggregator|ISO`',
    `dispatch_timestamp` TIMESTAMP COMMENT 'Exact time the dispatch instruction was issued to the resource or group.',
    `duration_minutes` STRING COMMENT 'Planned duration of the dispatch instruction in minutes.',
    `effective_date` DATE COMMENT 'Date on which the dispatch becomes effective for settlement purposes.',
    `expiry_date` DATE COMMENT 'Optional date when the dispatch ceases to be valid (used for provisional schedules).',
    `external_order_reference` STRING COMMENT 'Identifier of the corresponding order in the ISO/RTO market system.',
    `is_automated` BOOLEAN COMMENT 'True if the dispatch was generated automatically by DERMS logic.',
    `is_emergency` BOOLEAN COMMENT 'True if the dispatch was an emergency or reliability event.',
    `lmp_reference` DECIMAL(18,2) COMMENT 'Reference LMP at the resource location used for settlement calculations.',
    `market` STRING COMMENT 'Market context of the dispatch (Day‑Ahead Market, Real‑Time Market, etc.).. Valid values are `DAM|RTM|ISO|RTO`',
    `market_interval_end` TIMESTAMP COMMENT 'End of the market interval for the dispatch.',
    `market_interval_start` TIMESTAMP COMMENT 'Start of the market interval (e.g., hour) to which the dispatch belongs.',
    `market_product_type` STRING COMMENT 'Type of market product the dispatch fulfills.. Valid values are `energy|capacity|ancillary|frequency_regulation|peak_shaving|demand_response`',
    `market_region` STRING COMMENT 'Geographic market region or balancing authority (e.g., PJM, CAISO).',
    `offer_price` DECIMAL(18,2) COMMENT 'Price accepted by the market operator for the dispatch, in USD.',
    `performance_score` DECIMAL(18,2) COMMENT 'Percentage score (0‑100) reflecting how closely actual response matched the setpoint.',
    `regulatory_report_reference` BIGINT COMMENT 'Link to the regulatory filing that references this dispatch.',
    `schedule_confirmation_status` STRING COMMENT 'Result of the resources acknowledgment of the dispatch schedule.. Valid values are `confirmed|rejected|pending`',
    `setpoint_unit` STRING COMMENT 'Unit of measure for the setpoint value.. Valid values are `kW|MW`',
    `setpoint_value` DECIMAL(18,2) COMMENT 'Requested power setpoint (positive for generation, negative for load reduction) expressed in the chosen unit.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Monetary amount settled for the dispatch event.',
    `settlement_status` STRING COMMENT 'Current settlement state of the dispatch event with the market.. Valid values are `settled|unsettled|disputed`',
    `updated_by` STRING COMMENT 'User or system that last updated the dispatch record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the dispatch event record.',
    `version_number` STRING COMMENT 'Incremental version for optimistic concurrency control.',
    `created_by` STRING COMMENT 'User or system that created the dispatch record.',
    CONSTRAINT pk_dispatch_event PRIMARY KEY(`dispatch_event_id`)
) COMMENT 'Captures each dispatch instruction, activation, or market schedule — whether DERMS-initiated, operator-initiated, aggregator-submitted, or RTO/ISO market-scheduled (DAM/RTM) — sent to an individual DER resource or aggregation group. Covers demand response activation, VPP market dispatch, frequency regulation, peak shaving, emergency curtailment, day-ahead schedules, and real-time market intervals. Records dispatch timestamp, schedule date, target resource or aggregation group, requested setpoint (kW/MW), dispatch duration, market interval (hourly/sub-hourly), market product type (energy, capacity, ancillary services), dispatch reason, bid/offer price, LMP reference, schedule confirmation status, actual response delivered, performance score, and settlement status. Unified SSOT for all DER dispatch activity and VPP market schedules within the utility and wholesale market context.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`interconnection_study` (
    `interconnection_study_id` BIGINT COMMENT 'Unique system-generated identifier for the interconnection study record.',
    `circuit_feeder_id` BIGINT COMMENT 'Identifier of the transmission or distribution circuit under study.',
    `feeder_id` BIGINT COMMENT 'Identifier of the feeder line examined in the study.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Study results are filed with regulators; the filing FK ties the study to its official submission.',
    `interconnection_request_id` BIGINT COMMENT 'Foreign key linking to der.interconnection_request. Business justification: Each interconnection study is initiated by a specific interconnection request; linking preserves the request context.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Study reports cite the exact parcel impacted, enabling GIS integration and stakeholder communication.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Interconnection study assesses impact on a specific transmission line; linking enables compliance and planning reports.',
    `approval_date` DATE COMMENT 'Date the study was approved.',
    `approval_engineer` STRING COMMENT 'Engineer who signed off the approval.',
    `approval_status` STRING COMMENT 'Regulatory or internal approval outcome.. Valid values are `approved|rejected|pending`',
    `cost_allocation_method` STRING COMMENT 'Method used to allocate upgrade costs to participants.. Valid values are `pro_rata|fixed|usage_based`',
    `cost_sharing_agreement` STRING COMMENT 'Details of any cost‑sharing agreements with DER owners.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the study record was first created.',
    `data_source_system` STRING COMMENT 'Originating operational system for the study data (e.g., GE PowerOn DMS).',
    `engineer_assigned` STRING COMMENT 'Name of the engineer responsible for the study.',
    `estimated_upgrade_cost_usd` DECIMAL(18,2) COMMENT 'Projected cost of the recommended upgrades in US dollars.',
    `existing_der_capacity_kw` DECIMAL(18,2) COMMENT 'Total kilowatt capacity of DERs already connected on the circuit.',
    `geographic_region` STRING COMMENT 'Region code or name where the study is located.',
    `grid_impact_summary` STRING COMMENT 'High‑level summary of overall grid impacts.',
    `hosting_capacity_limit_kw` DECIMAL(18,2) COMMENT 'Maximum DER capacity the network can host without upgrades.',
    `identified_constraints` STRING COMMENT 'List of physical or regulatory constraints discovered.',
    `interconnection_point` STRING COMMENT 'Physical point on the network where the DER would connect.',
    `interconnection_study_status` STRING COMMENT 'Current lifecycle status of the study.. Valid values are `pending|in_progress|completed|approved|rejected|expired`',
    `load_impact_kw` DECIMAL(18,2) COMMENT 'Additional load on the network due to the proposed DER.',
    `methodology` STRING COMMENT 'Analytical approach used for the study.. Valid values are `deterministic|probabilistic`',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information.',
    `proposed_additional_capacity_kw` DECIMAL(18,2) COMMENT 'Requested new DER capacity in kilowatts.',
    `protection_coordination` STRING COMMENT 'Summary of protection scheme coordination results.',
    `protection_scheme` STRING COMMENT 'Description of the protection scheme applicable to the study point.',
    `recommended_upgrades` STRING COMMENT 'Suggested network upgrades to accommodate the DER.',
    `regulatory_review_date` DATE COMMENT 'Date the regulatory review was completed.',
    `regulatory_review_status` STRING COMMENT 'Status of the regulatory review process.. Valid values are `not_started|in_review|approved|rejected`',
    `study_description` STRING COMMENT 'Narrative description of the study scope and objectives.',
    `study_end_date` DATE COMMENT 'Date the study was completed.',
    `study_name` STRING COMMENT 'Human‑readable name or title of the interconnection study.',
    `study_number` STRING COMMENT 'External reference number assigned to the study by the utility.',
    `study_start_date` DATE COMMENT 'Date the study work began.',
    `study_type` STRING COMMENT 'Category of the study performed.. Valid values are `feasibility|system_impact|facilities|hosting_capacity`',
    `study_validity_period_months` STRING COMMENT 'Number of months the study results remain valid.',
    `study_version` STRING COMMENT 'Version number for revisions of the study.',
    `thermal_impact` STRING COMMENT 'Qualitative assessment of thermal loading impacts.. Valid values are `acceptable|minor|major`',
    `thermal_rating_exceeded` BOOLEAN COMMENT 'Indicates whether thermal ratings are exceeded (true/false).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the record.',
    `upgrade_requirements` STRING COMMENT 'Detailed technical requirements for each upgrade.',
    `validity_end_date` DATE COMMENT 'Date after which the study results expire.',
    `validity_start_date` DATE COMMENT 'Date from which the study results are considered valid.',
    `voltage_drop_percent` DECIMAL(18,2) COMMENT 'Projected voltage drop expressed as a percentage.',
    `voltage_impact` STRING COMMENT 'Qualitative assessment of voltage effects from the proposed DER.. Valid values are `acceptable|minor|major`',
    CONSTRAINT pk_interconnection_study PRIMARY KEY(`interconnection_study_id`)
) COMMENT 'Technical study record associated with an interconnection request or hosting capacity assessment, covering feasibility study, system impact study, facilities study, and hosting capacity analysis phases. Captures study type, study start/end dates, assigned engineer, circuit/feeder under study, study methodology (deterministic, probabilistic), existing DER penetration (kW), proposed additional capacity (kW), hosting capacity limit (kW), identified grid upgrade requirements, estimated upgrade cost ($), voltage and thermal impact findings, protection coordination requirements, identified constraints, recommended upgrades, study validity period, and study approval status. Supports interconnection queue management, DER siting decisions, cost allocation, and distribution planning. Single source of truth for all DER-related grid studies.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`bess_operation` (
    `bess_operation_id` BIGINT COMMENT 'Unique surrogate key for each BESS operation record.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Battery Energy Storage System operations are subject to specific compliance obligations; FK enables audit trails.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: BESS operation OPEX is allocated to a cost center for expense tracking, budgeting, and regulatory compliance.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator or automated system that initiated the BESS operation.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Battery Energy Storage System incident log needed for NERC reliability and fire safety regulatory filings.',
    `it_asset_id` BIGINT COMMENT 'Identifier of the BESS asset that generated the operation event.',
    `location_id` BIGINT COMMENT 'Reference to the geographic location (substation, site) of the BESS asset.',
    `resource_id` BIGINT COMMENT 'Identifier of the BESS asset that generated the operation event.',
    `technician_id` BIGINT COMMENT 'Identifier of the operator or automated system that initiated the BESS operation.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: MAINTENANCE CONTRACTS: Links BESS operation records to the service vendor responsible for battery upkeep, required for maintenance scheduling and regulatory compliance.',
    `battery_temperature_c` DECIMAL(18,2) COMMENT 'Measured temperature of the battery pack during the operation, in degrees Celsius.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the operation record was first ingested into the lakehouse.',
    `cycle_depth_pct` DECIMAL(18,2) COMMENT 'Depth of discharge for the cycle, calculated as (soc_start_pct - soc_end_pct) expressed as a percentage.',
    `cycle_duration_seconds` STRING COMMENT 'Total elapsed time of the operation cycle in seconds.',
    `degradation_estimate_pct` DECIMAL(18,2) COMMENT 'Projected remaining capacity loss percentage based on cumulative cycling.',
    `dispatch_event_reference` STRING COMMENT 'External identifier linking this BESS operation to the dispatch event that triggered it.',
    `energy_throughput_kwh` DECIMAL(18,2) COMMENT 'Actual energy transferred during the operation cycle, measured in kilowatt‑hours.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the BESS operation event occurred.',
    `event_type` STRING COMMENT 'Categorical type of the event; fixed value bess_operation for this table.. Valid values are `bess_operation`',
    `health_status` STRING COMMENT 'Current health condition of the BESS as assessed by the asset health system.. Valid values are `good|degraded|critical`',
    `maintenance_due_date` DATE COMMENT 'Planned date for the next scheduled maintenance of the BESS.',
    `operation_mode` STRING COMMENT 'Mode of the BESS during the event: charging, discharging, idle, or providing frequency regulation.. Valid values are `charge|discharge|idle|frequency_regulation`',
    `power_setpoint_kw` DECIMAL(18,2) COMMENT 'Target power level commanded for the BESS during the event, expressed in kilowatts.',
    `round_trip_efficiency_pct` DECIMAL(18,2) COMMENT 'Efficiency of the charge‑discharge cycle, expressed as a percentage of energy out divided by energy in.',
    `soc_end_pct` DECIMAL(18,2) COMMENT 'Battery state of charge at the end of the operation, expressed as a percentage.',
    `soc_start_pct` DECIMAL(18,2) COMMENT 'Battery state of charge at the beginning of the operation, expressed as a percentage.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the operation record.',
    `warranty_expiration_date` DATE COMMENT 'Date when the BESS warranty expires.',
    CONSTRAINT pk_bess_operation PRIMARY KEY(`bess_operation_id`)
) COMMENT 'Operational record for battery energy storage system (BESS) charge and discharge cycles. Captures cycle timestamp, BESS asset ID, operation mode (charge, discharge, idle, frequency regulation), power setpoint (kW), energy throughput (kWh), state of charge at start and end (%), cycle depth, round-trip efficiency, and triggering dispatch event reference. Supports BESS lifecycle management, warranty tracking, and degradation analysis.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` (
    `ev_charging_session_id` BIGINT COMMENT 'Unique identifier for the EV charging session record.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: EV charging sessions may be governed by demand‑response or incentive obligations; linking captures the applicable rule.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who owned the vehicle during the session.',
    `der_program_enrollment_id` BIGINT COMMENT 'Identifier of the DER program or incentive under which the session was recorded.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Capture EV charger safety incidents for incident reporting and liability management per UL and state regulations.',
    `it_asset_id` BIGINT COMMENT 'Identifier of the EV charger asset used for the session.',
    `location_id` BIGINT COMMENT 'Identifier of the geographic location or site where the charger is installed.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: EV charging sessions are billed and used for demand‑response programs; linking to the meter that measures energy delivered ensures accurate invoicing and grid impact analysis.',
    `person_id` BIGINT COMMENT 'Identifier of the customer who owned the vehicle during the session.',
    `service_plan_id` BIGINT COMMENT 'Foreign key linking to product.service_plan. Business justification: EV charging billing follows a defined service plan; the link supports invoicing, demand‑charge calculations, and compliance with EV charging tariffs.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: CHARGER WARRANTY: Connects charging session logs to the charger equipment vendor for warranty claims, performance reporting, and service management.',
    `charging_level` STRING COMMENT 'Standardized charging level of the session: Level 1, Level 2, or DC Fast Charge.. Valid values are `L1|L2|DCFC`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the session record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the transaction.. Valid values are `^[A-Z]{3}$`',
    `demand_response_flag` BOOLEAN COMMENT 'Indicates whether the session was curtailed or adjusted for demand response.',
    `end_timestamp` TIMESTAMP COMMENT 'Timestamp when the EV finished charging or the session was terminated.',
    `energy_delivered_kwh` DECIMAL(18,2) COMMENT 'Total electricity delivered to the vehicle during the session, measured in kilowatt-hours.',
    `ev_charging_session_status` STRING COMMENT 'Current lifecycle status of the charging session.. Valid values are `completed|in_progress|cancelled|failed|pending`',
    `grid_interconnection_flag` BOOLEAN COMMENT 'True if the session contributed energy back to the grid (vehicle‑to‑grid).',
    `peak_demand_kw` DECIMAL(18,2) COMMENT 'Maximum power draw recorded during the session, in kilowatts.',
    `session_cost_gross` DECIMAL(18,2) COMMENT 'Total cost before taxes or discounts, in the transaction currency.',
    `session_cost_net` DECIMAL(18,2) COMMENT 'Final amount charged to the customer after taxes and discounts.',
    `session_duration_minutes` STRING COMMENT 'Total length of the charging session in minutes.',
    `session_notes` STRING COMMENT 'Free‑form text notes captured by the operator or system for the session.',
    `session_number` STRING COMMENT 'Business identifier assigned to the charging session, used for external reference and reporting.',
    `session_tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the session cost.',
    `smart_charging_program_flag` BOOLEAN COMMENT 'True if the session was part of a managed or smart‑charging program.',
    `start_timestamp` TIMESTAMP COMMENT 'Timestamp when the EV began charging (business event time).',
    `tou_period` STRING COMMENT 'TOU pricing period applicable to the session.. Valid values are `off_peak|mid_peak|on_peak|super_peak`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the session record.',
    `vehicle_identifier` STRING COMMENT 'Anonymized or fleet identifier for the electric vehicle.',
    CONSTRAINT pk_ev_charging_session PRIMARY KEY(`ev_charging_session_id`)
) COMMENT 'Records each EV charging session at a utility-managed or utility-enrolled EV charging station. Captures session start/end timestamp, charger asset ID, vehicle identifier (anonymized or fleet ID), energy delivered (kWh), peak demand (kW), charging level (L1/L2/DCFC), TOU period, session cost, demand response curtailment flag, and smart charging program participation. Supports managed charging programs and grid impact analysis.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`microgrid` (
    `microgrid_id` BIGINT COMMENT 'Unique system-generated identifier for each microgrid.',
    `aggregation_group_id` BIGINT COMMENT 'Foreign key linking to der.aggregation_group. Business justification: Microgrids can be organized into aggregation groups for coordinated dispatch and market participation.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Microgrids must satisfy compliance obligations (e.g., reliability, safety); linking records the obligation reference.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to regulatory.environmental_permit. Business justification: Microgrid projects require environmental permits; the FK tracks permit lifecycle per microgrid.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Microgrid is a capital asset; linking enables depreciation schedules, asset lifecycle management, and compliance reporting in the finance system.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Microgrid customers are charged under special tariffs; associating the microgrid with its rate schedule is required for settlement and regulatory filing.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Microgrid Control Integration; SCADA system ID is required for real‑time monitoring and dispatch of microgrid resources.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Microgrid assets are managed as part of a physical site; linking to site consolidates operational data and compliance reporting.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: COMPONENT LIFECYCLE: Links microgrid installations to the primary vendor for component procurement, lifecycle tracking, and regulatory reporting.',
    `capacity_kw` DECIMAL(18,2) COMMENT 'Maximum generation capacity of the microgrid in kilowatts.',
    `commissioning_date` DATE COMMENT 'Date the microgrid became operational after testing.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the microgrid.. Valid values are `compliant|non_compliant|pending`',
    `control_system_type` STRING COMMENT 'Architecture of the microgrid control system.. Valid values are `centralized|decentralized|hierarchical`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the microgrid record was first created in the data lake.',
    `critical_load_kw` DECIMAL(18,2) COMMENT 'Maximum critical load that the microgrid can sustain during islanded operation.',
    `decommission_date` DATE COMMENT 'Date the microgrid was retired or removed from service, if applicable.',
    `frequency_hz` DECIMAL(18,2) COMMENT 'Nominal operating frequency of the microgrid.',
    `geographic_boundary_wkt` STRING COMMENT 'Well‑Known Text representation of the microgrids service area.',
    `grid_connection_capability` STRING COMMENT 'Capability of the microgrid to operate grid‑connected, islanded, or both.. Valid values are `grid_connected|islanded|both`',
    `installation_date` DATE COMMENT 'Date the microgrid was physically installed.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the microgrid serves critical infrastructure loads.',
    `islanding_protection_scheme` STRING COMMENT 'Protection scheme used to transition to islanded mode.. Valid values are `automatic|manual|hybrid`',
    `last_active_generation_sources` STRING COMMENT 'Comma‑separated list of generation resources active during the last islanded event.',
    `last_island_duration_minutes` STRING COMMENT 'Duration in minutes of the most recent islanded period.',
    `last_load_served_kw` DECIMAL(18,2) COMMENT 'Critical load served during the most recent islanded event.',
    `last_transition_cause` STRING COMMENT 'Trigger that caused the most recent transition.. Valid values are `utility_outage|scheduled_test|operator_command`',
    `last_transition_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent mode transition event.',
    `last_transition_type` STRING COMMENT 'Type of the most recent transition (e.g., grid‑to‑island).. Valid values are `grid_to_island|island_to_grid|resynchronization|test`',
    `microgrid_code` STRING COMMENT 'External business code or identifier used in operational systems.',
    `microgrid_name` STRING COMMENT 'Human‑readable name of the microgrid.',
    `microgrid_status` STRING COMMENT 'Current lifecycle state of the microgrid.. Valid values are `active|inactive|planned|decommissioned`',
    `microgrid_type` STRING COMMENT 'Classification of ownership: utility‑owned, customer‑owned, or community.. Valid values are `utility_owned|customer_owned|community`',
    `operational_status` STRING COMMENT 'Current operational condition of the microgrid.. Valid values are `operational|maintenance|outage`',
    `owner_contact_email` STRING COMMENT 'Primary email address for the owning organization.',
    `owner_contact_phone` STRING COMMENT 'Primary phone number for the owning organization.',
    `owner_organization` STRING COMMENT 'Name of the organization that owns the microgrid.',
    `pcc_point` STRING COMMENT 'Identifier of the point of common coupling where the microgrid connects to the utility grid.',
    `regulatory_reporting_required` BOOLEAN COMMENT 'Indicates whether the microgrid must be included in mandatory regulatory reports.',
    `resynchronization_outcome` STRING COMMENT 'Result of the most recent resynchronization attempt.. Valid values are `successful|failed|partial`',
    `saidi_impact_estimate_minutes` DECIMAL(18,2) COMMENT 'Estimated impact on System Average Interruption Duration Index (minutes) if the microgrid fails.',
    `saifi_impact_estimate` STRING COMMENT 'Estimated impact on System Average Interruption Frequency Index (number of customers) if the microgrid fails.',
    `storage_capacity_kwh` DECIMAL(18,2) COMMENT 'Total usable storage capacity of the microgrid in kilowatt‑hours.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the microgrid record.',
    CONSTRAINT pk_microgrid PRIMARY KEY(`microgrid_id`)
) COMMENT 'Master record and complete operational history for each microgrid system within the utility service territory — utility-owned, customer-owned, or community microgrids. Captures microgrid name, geographic boundary, total generation capacity (kW), storage capacity (kWh), critical load served (kW), grid-connected vs islanded capability, point of common coupling (PCC), control system type, islanding protection scheme, operational status, and full mode transition event log: event timestamps, transition types (grid-connected to islanded, resynchronization, planned test), trigger causes (utility outage, scheduled test, operator command), island duration, load served during island (kW), generation sources active during island, and resynchronization outcomes. Supports resilience planning, SAIDI/SAIFI impact assessment, reliability reporting, and DERMS integration. Single source of truth for microgrid assets and their operational events.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`performance_summary` (
    `performance_summary_id` BIGINT COMMENT 'Primary key for performance_summary',
    `der_asset_resource_id` BIGINT COMMENT 'Identifier of the Distributed Energy Resource asset to which this performance summary applies.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Performance summaries are submitted to regulators as filings for compliance and market reporting.',
    `resource_id` BIGINT COMMENT 'Identifier of the Distributed Energy Resource asset to which this performance summary applies.',
    `actual_output_kwh` DECIMAL(18,2) COMMENT 'Measured energy generated by the DER during the period, expressed in kilowatt‑hours.',
    `availability_factor_pct` DECIMAL(18,2) COMMENT 'Percentage of time the DER was available to generate power during the period.',
    `business_event_timestamp` TIMESTAMP COMMENT 'Timestamp representing the end of the reporting period; used for downstream time‑based analytics.',
    `capacity_factor_pct` DECIMAL(18,2) COMMENT 'Actual energy produced divided by the maximum possible output over the period, expressed as a percentage.',
    `compensation_eligible_flag` BOOLEAN COMMENT 'Indicates whether the curtailment event qualifies for incentive compensation under program rules.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the performance summary record was first created in the lakehouse.',
    `curtailment_authority` STRING COMMENT 'Entity that authorized the curtailment action.. Valid values are `utility|iso_rto|derms_auto|operator_directed`',
    `curtailment_energy_kwh` DECIMAL(18,2) COMMENT 'Total energy (kWh) not generated due to curtailments during the period.',
    `curtailment_event_count` STRING COMMENT 'Number of distinct curtailment events that occurred in the reporting period.',
    `curtailment_reason_code` STRING COMMENT 'Standardized code indicating why curtailment was applied.. Valid values are `voltage_violation|thermal_overload|overgeneration|operator_directed|grid_constraint|maintenance`',
    `expected_output_kwh` DECIMAL(18,2) COMMENT 'Projected energy generation for the period based on nameplate capacity and schedule, expressed in kilowatt‑hours.',
    `measurement_unit` STRING COMMENT 'Unit of energy measurement used for all kWh fields.. Valid values are `kwh`',
    `notes` STRING COMMENT 'Free‑form text for any additional comments or observations about the performance period.',
    `performance_period_type` STRING COMMENT 'Granularity of the performance summary; either daily or monthly.. Valid values are `daily|monthly`',
    `performance_ratio_pct` DECIMAL(18,2) COMMENT 'Ratio of actual to expected output expressed as a percentage.',
    `performance_record_number` STRING COMMENT 'Human‑readable identifier assigned to the performance summary for tracking and audit.',
    `performance_summary_status` STRING COMMENT 'Current processing status of the performance record.. Valid values are `pending|validated|rejected`',
    `period_end_date` DATE COMMENT 'Last calendar date of the reporting period (inclusive).',
    `period_start_date` DATE COMMENT 'First calendar date of the reporting period (inclusive).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the performance summary record.',
    CONSTRAINT pk_performance_summary PRIMARY KEY(`performance_summary_id`)
) COMMENT 'Periodic (daily/monthly) performance, availability, and curtailment record for each DER asset. Captures performance period, expected vs actual output (kWh/kW), performance ratio (%), availability factor (%), capacity factor, and all curtailment events within the period: curtailment start/end timestamps, reason codes (voltage violation, thermal overload, overgeneration, operator-directed), curtailment authority (utility, ISO/RTO, DERMS auto), curtailed energy (kWh), and compensation eligibility flag. Supports program compliance verification, CAISO Rule 21 curtailment reporting, FERC Order 2222 compliance, incentive payment calculations, and DER fleet performance analytics. Single source of truth for DER operational performance and curtailment history.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`der_program` (
    `der_program_id` BIGINT COMMENT 'Unique surrogate key for each Distributed Energy Resource (DER) program.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: DER incentive programs are defined within rate cases; linking enables program‑to‑rate‑case mapping.',
    `budget_amount` DECIMAL(18,2) COMMENT 'Total monetary budget allocated to the program for a given fiscal period.',
    `budget_currency` STRING COMMENT 'ISO 4217 currency code for the program budget.. Valid values are `USD|CAD|MXN`',
    `capacity_limit_mw` DECIMAL(18,2) COMMENT 'Maximum aggregate capacity (in megawatts) the program can accept.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the program record was first created in the system.',
    `current_enrollment_count` BIGINT COMMENT 'Number of distinct enrollments currently active in the program.',
    `effective_from` DATE COMMENT 'Date when the program terms become legally effective.',
    `effective_until` DATE COMMENT 'Date when the program terms expire or are superseded; null if open‑ended.',
    `eligibility_criteria` STRING COMMENT 'Business rules that define which customers or DER technologies may enroll.',
    `enrollment_cap_mw` DECIMAL(18,2) COMMENT 'Maximum capacity (in MW) that may be enrolled at any time.',
    `enrollment_close_date` DATE COMMENT 'Date after which no new enrollments are accepted.',
    `enrollment_open_date` DATE COMMENT 'Date when the program first allowed new enrollments.',
    `external_program_code` STRING COMMENT 'Identifier used by external regulatory or market systems to reference the program.',
    `funding_source` STRING COMMENT 'Entity or mechanism that provides financial support for the program.. Valid values are `utility|federal|state|private`',
    `incentive_rate` DECIMAL(18,2) COMMENT 'Monetary value of the incentive per unit (e.g., $/kWh).',
    `incentive_structure` STRING COMMENT 'Description of how incentives are calculated (e.g., flat rate, tiered, performance‑based).',
    `incentive_unit` STRING COMMENT 'Unit of measure for the incentive rate (e.g., $/kWh, $/MW).',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of the programs performance and terms.',
    `market` STRING COMMENT 'Market segment the program serves (retail customers or wholesale participants).. Valid values are `retail|wholesale`',
    `notes` STRING COMMENT 'Free‑form field for additional remarks, exceptions, or operational comments.',
    `program_category` STRING COMMENT 'High‑level classification of the program for reporting and analytics.. Valid values are `incentive|grid_service|customer_engagement`',
    `program_description` STRING COMMENT 'Detailed narrative describing the program, its objectives, and how it operates.',
    `program_name` STRING COMMENT 'Human‑readable name of the DER program as presented to customers.',
    `program_status` STRING COMMENT 'Current lifecycle status of the program.. Valid values are `active|inactive|pending|closed|draft`',
    `program_type` STRING COMMENT 'Category of the DER program indicating its primary purpose or mechanism.. Valid values are `demand_response|virtual_power_plant|battery_incentive|ev_charging|community_solar`',
    `region_code` STRING COMMENT 'Three‑letter ISO country code indicating the primary geographic region of the program.. Valid values are `USA|CAN|MEX`',
    `review_frequency` STRING COMMENT 'Scheduled frequency at which the program is reviewed.. Valid values are `annual|semiannual|quarterly|monthly`',
    `subcategory` STRING COMMENT 'More specific classification within the main category, if applicable.',
    `target_customer_segment` STRING COMMENT 'Customer segment(s) eligible for the program.. Valid values are `residential|commercial|industrial|municipal`',
    `target_der_technology` STRING COMMENT 'DER technology types the program is designed for.. Valid values are `solar|battery|ev|heat_pump|wind`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent update to the program record.',
    `version_number` STRING COMMENT 'Incremental version of the program definition for change management.',
    `voltage_level` STRING COMMENT 'Typical voltage tier of the DER assets targeted by the program.. Valid values are `low|medium|high`',
    CONSTRAINT pk_der_program PRIMARY KEY(`der_program_id`)
) COMMENT 'Reference catalog of utility DER programs available for customer enrollment including demand response, virtual power plant (VPP), battery storage incentives (SGIP), EV managed charging, community solar, and grid services programs. Captures program name, program type, eligibility criteria (customer segment, DER technology, capacity limits), incentive structure and rates, program capacity limit (MW), current enrollment count, enrollment open/close dates, regulatory approval reference, and program status. Excludes NEM programs which are administered through nem_account. Authoritative program catalog for all DER-specific operational offerings.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`aggregator` (
    `aggregator_id` BIGINT COMMENT 'Unique system-generated identifier for the DER aggregator.',
    `address_line1` STRING COMMENT 'First line of the aggregators primary business address.',
    `address_line2` STRING COMMENT 'Second line of the address (optional).',
    `aggregator_name` STRING COMMENT 'Legal name of the DER aggregator entity.',
    `aggregator_status` STRING COMMENT 'Overall operational status of the aggregator.. Valid values are `active|inactive|suspended|pending|terminated`',
    `aggregator_type` STRING COMMENT 'Classification of aggregator based on ownership and structure.. Valid values are `independent|utility_owned|community|municipal|other`',
    `city` STRING COMMENT 'City of the aggregators primary address.',
    `compliance_status` STRING COMMENT 'Current regulatory compliance status of the aggregator.. Valid values are `compliant|non_compliant|pending|suspended`',
    `contract_end_date` DATE COMMENT 'Date when the aggregators contract expires or is terminated; null if open‑ended.',
    `contract_start_date` DATE COMMENT 'Date when the aggregators contract with the utility becomes effective.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the aggregator record was first created in the system.',
    `ferc_registration_number` STRING COMMENT 'Federal Energy Regulatory Commission registration identifier for the aggregator.',
    `is_active` BOOLEAN COMMENT 'Flag indicating if the aggregator is currently active in the program.',
    `is_certified` BOOLEAN COMMENT 'Indicates whether the aggregator holds required certifications for market participation.',
    `market_products` STRING COMMENT 'Market products the aggregator is authorized to provide.. Valid values are `energy|capacity|ancillary|flexibility|revenue|other`',
    `notes` STRING COMMENT 'Free‑text field for additional remarks or notes about the aggregator.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary contact for the aggregator.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the primary contact person for the aggregator.',
    `primary_contact_phone` STRING COMMENT 'Phone number of the primary contact for the aggregator.',
    `puc_authorization_number` STRING COMMENT 'State Public Utility Commission authorization number granting the aggregator permission to operate.',
    `service_territory_code` STRING COMMENT 'State or jurisdiction code where the aggregator operates.. Valid values are `[A-Z]{2}`',
    `total_enrolled_capacity_mw` DECIMAL(18,2) COMMENT 'Total DER capacity enrolled with the aggregator, measured in megawatts (MW).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the aggregator record.',
    `website_url` STRING COMMENT 'Public website URL of the aggregator.',
    `zip_code` STRING COMMENT 'Postal ZIP code of the aggregators primary address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    CONSTRAINT pk_aggregator PRIMARY KEY(`aggregator_id`)
) COMMENT 'Master record for third-party DER aggregators authorized to aggregate customer DER assets for wholesale market participation or utility program delivery under FERC Order 2222. Captures aggregator legal name, FERC registration ID, state PUC authorization number, authorized market products (energy, capacity, ancillary services), service territory coverage, total enrolled capacity (MW), contract start/end dates, and compliance status. Distinct from the utilitys own VPP aggregation groups.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` (
    `community_solar_subscription_id` BIGINT COMMENT 'Unique system-generated identifier for the community solar subscription record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who holds the community solar subscription.',
    `der_program_id` BIGINT COMMENT 'Foreign key linking to der.program. Business justification: Community solar subscriptions are enrollments in a specific program; linking provides program details and avoids duplicated attributes.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Community solar subscriptions must be tied to a meter for net‑metering credit calculation and regulatory reporting of allocated generation.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Subscriptions must be allocated to the parcel where the community solar project resides for billing and regulatory tracking.',
    `person_id` BIGINT COMMENT 'Identifier of the customer who holds the community solar subscription.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Community solar subscriptions are billed according to a dedicated rate schedule; the link enables accurate credit allocation and compliance reporting.',
    `renewable_resource_id` BIGINT COMMENT 'Identifier of the remote solar facility to which the subscription is linked.',
    `allocated_energy_pct` DECIMAL(18,2) COMMENT 'Percentage of the projects generated energy that is allocated to this subscription.',
    `bill_credit_rate` DECIMAL(18,2) COMMENT 'Monetary credit applied to the customers bill for each kilowatt‑hour of allocated energy.',
    `billing_cycle` STRING COMMENT 'Frequency at which bill credits are applied to the customers account.. Valid values are `monthly|quarterly|annual`',
    `cancellation_date` DATE COMMENT 'Date the subscription was cancelled, if applicable.',
    `capacity_kw` DECIMAL(18,2) COMMENT 'Maximum kilowatt capacity allocated to the customer under this subscription.',
    `community_solar_subscription_status` STRING COMMENT 'Current lifecycle status of the subscription.. Valid values are `active|pending|suspended|cancelled|expired`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the subscription record was first created in the system.',
    `eligibility_criteria` STRING COMMENT 'Text describing the eligibility rules that the customer satisfied to join the program.',
    `enrollment_date` DATE COMMENT 'Date the customer enrolled in the community solar program.',
    `incentive_amount` DECIMAL(18,2) COMMENT 'Monetary incentive applied to the subscription (e.g., rebate or tax credit).',
    `incentive_type` STRING COMMENT 'Category of incentive associated with the subscription.. Valid values are `rebate|tax_credit|none`',
    `notes` STRING COMMENT 'Free‑form field for additional comments or special instructions.',
    `payment_method` STRING COMMENT 'Preferred method for processing any subscription‑related payments or fees.. Valid values are `auto_debit|check|credit_card`',
    `subscription_end_date` DATE COMMENT 'Date when the subscription terminates or expires; null for open‑ended agreements.',
    `subscription_number` STRING COMMENT 'External business identifier assigned to the subscription, used in customer communications and billing.',
    `subscription_start_date` DATE COMMENT 'Date when the subscription becomes effective.',
    `subscription_type` STRING COMMENT 'Classification of the subscription based on the solar asset configuration.. Valid values are `rooftop|ground|virtual`',
    `term_months` STRING COMMENT 'Length of the subscription agreement expressed in months.',
    `transfer_allowed` BOOLEAN COMMENT 'Indicates whether the subscription may be transferred to another eligible customer.',
    `transfer_date` DATE COMMENT 'Date the subscription was transferred to a new customer, if applicable.',
    `updated_by` STRING COMMENT 'User or system identifier that performed the most recent update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the subscription record.',
    `created_by` STRING COMMENT 'User or system identifier that created the subscription record.',
    CONSTRAINT pk_community_solar_subscription PRIMARY KEY(`community_solar_subscription_id`)
) COMMENT 'Customer subscription record for a community solar (shared renewables) project, representing a customers allocated share of a remote solar facilitys output. Captures subscription date, customer account reference, project ID, subscribed capacity (kW), allocated energy share (%), monthly bill credit rate ($/kWh), subscription term, subscription status, and transfer/cancellation history. Supports community solar program administration and billing credit pass-through.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`der`.`program_zone_assignment` (
    `program_zone_assignment_id` BIGINT COMMENT 'Primary key for the program_zone_assignment association',
    `control_zone_id` BIGINT COMMENT 'Foreign key linking to control_zone',
    `der_program_id` BIGINT COMMENT 'Foreign key linking to program',
    `effective_from` DATE COMMENT 'Date when the program becomes effective in the control zone',
    `effective_until` DATE COMMENT 'Date when the program ceases to be effective in the control zone',
    `program_zone_assignment_status` STRING COMMENT 'Current status of the program assignment (e.g., Active, Inactive, Pending)',
    CONSTRAINT pk_program_zone_assignment PRIMARY KEY(`program_zone_assignment_id`)
) COMMENT 'Represents the assignment of a DER program to a control zone, capturing the period of effectiveness and current status. Each record links one control zone to one program with attributes that exist only in the context of this relationship.. Existence Justification: DER programs are deployed to electrical control zones. Each control zone can host multiple DER programs simultaneously, and each DER program can be offered in multiple control zones. The utility records the effective start and end dates and the status of each zone‑program assignment.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ADD CONSTRAINT `fk_der_resource_aggregation_group_id` FOREIGN KEY (`aggregation_group_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregation_group`(`aggregation_group_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ADD CONSTRAINT `fk_der_nem_account_aggregation_group_id` FOREIGN KEY (`aggregation_group_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregation_group`(`aggregation_group_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ADD CONSTRAINT `fk_der_nem_true_up_nem_account_id` FOREIGN KEY (`nem_account_id`) REFERENCES `power_and_utilities_v2`.`der`.`nem_account`(`nem_account_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ADD CONSTRAINT `fk_der_der_program_enrollment_aggregator_id` FOREIGN KEY (`aggregator_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregator`(`aggregator_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ADD CONSTRAINT `fk_der_der_program_enrollment_der_program_id` FOREIGN KEY (`der_program_id`) REFERENCES `power_and_utilities_v2`.`der`.`der_program`(`der_program_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ADD CONSTRAINT `fk_der_aggregation_group_aggregator_id` FOREIGN KEY (`aggregator_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregator`(`aggregator_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ADD CONSTRAINT `fk_der_aggregation_group_primary_aggregation_aggregator_id` FOREIGN KEY (`primary_aggregation_aggregator_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregator`(`aggregator_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ADD CONSTRAINT `fk_der_dispatch_event_aggregation_group_id` FOREIGN KEY (`aggregation_group_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregation_group`(`aggregation_group_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ADD CONSTRAINT `fk_der_dispatch_event_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ADD CONSTRAINT `fk_der_interconnection_study_interconnection_request_id` FOREIGN KEY (`interconnection_request_id`) REFERENCES `power_and_utilities_v2`.`der`.`interconnection_request`(`interconnection_request_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ADD CONSTRAINT `fk_der_bess_operation_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ADD CONSTRAINT `fk_der_ev_charging_session_der_program_enrollment_id` FOREIGN KEY (`der_program_enrollment_id`) REFERENCES `power_and_utilities_v2`.`der`.`der_program_enrollment`(`der_program_enrollment_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ADD CONSTRAINT `fk_der_microgrid_aggregation_group_id` FOREIGN KEY (`aggregation_group_id`) REFERENCES `power_and_utilities_v2`.`der`.`aggregation_group`(`aggregation_group_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ADD CONSTRAINT `fk_der_performance_summary_der_asset_resource_id` FOREIGN KEY (`der_asset_resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ADD CONSTRAINT `fk_der_performance_summary_resource_id` FOREIGN KEY (`resource_id`) REFERENCES `power_and_utilities_v2`.`der`.`resource`(`resource_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ADD CONSTRAINT `fk_der_community_solar_subscription_der_program_id` FOREIGN KEY (`der_program_id`) REFERENCES `power_and_utilities_v2`.`der`.`der_program`(`der_program_id`);
ALTER TABLE `power_and_utilities_v2`.`der`.`program_zone_assignment` ADD CONSTRAINT `fk_der_program_zone_assignment_der_program_id` FOREIGN KEY (`der_program_id`) REFERENCES `power_and_utilities_v2`.`der`.`der_program`(`der_program_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`der` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities_v2`.`der` SET TAGS ('dbx_domain' = 'der');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource (DER) Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `aggregation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `circuit_feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Circuit Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Inverter Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `metering_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag (Business Identifier)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `battery_storage_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Battery Storage Capacity (kWh)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Nameplate Capacity (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_business_glossary_term' = 'Communication Protocol');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `communication_protocol` SET TAGS ('dbx_value_regex' = 'IEEE_2030_5|OpenADR|OCPP|Modbus');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `compliance_last_checked_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Compliance Last Checked Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `configuration_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Configuration Approval Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `configuration_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `der_type` SET TAGS ('dbx_business_glossary_term' = 'DER Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `der_type` SET TAGS ('dbx_value_regex' = 'solar|battery|ev_charger|fuel_cell|wind|generator');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `derms_device_code` SET TAGS ('dbx_business_glossary_term' = 'DERMS Device ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `derms_device_code` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `derms_device_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `ev_charging_power_kw` SET TAGS ('dbx_business_glossary_term' = 'EV Charging Power (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `export_limit_kw` SET TAGS ('dbx_business_glossary_term' = 'Export Power Limit (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `ieee_1547_category` SET TAGS ('dbx_business_glossary_term' = 'IEEE 1547 Category');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `ieee_1547_category` SET TAGS ('dbx_value_regex' = 'Category_A|Category_B|Category_C|Category_D');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `import_limit_kw` SET TAGS ('dbx_business_glossary_term' = 'Import Power Limit (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `inverter_settings` SET TAGS ('dbx_business_glossary_term' = 'Inverter Settings (JSON)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `last_config_push_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Configuration Push Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `manufacturer` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `net_metering_eligibility` SET TAGS ('dbx_business_glossary_term' = 'Net Metering Eligibility');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `net_metering_rate` SET TAGS ('dbx_business_glossary_term' = 'Net Metering Rate ($/kWh)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'customer_owned|utility_owned|third_party');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `phase` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `phase` SET TAGS ('dbx_value_regex' = 'single|three');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `ramp_rate_kw_per_min` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate (kW/min)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `resource_name` SET TAGS ('dbx_business_glossary_term' = 'DER Name');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `resource_status` SET TAGS ('dbx_business_glossary_term' = 'DER Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `resource_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|decommissioned|pending');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV)');
ALTER TABLE `power_and_utilities_v2`.`der`.`resource` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` SET TAGS ('dbx_subdomain' = 'interconnection_service');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `interconnection_request_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Request Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Grid Feeder Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `inspector_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Applicant Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Inspector Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `agreement_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Agreement Execution Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_address` SET TAGS ('dbx_business_glossary_term' = 'Applicant Mailing Address (ADDRESS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_email` SET TAGS ('dbx_business_glossary_term' = 'Applicant Email Address (EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_name` SET TAGS ('dbx_business_glossary_term' = 'Applicant Full Name (NAME)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_business_glossary_term' = 'Applicant Phone Number (PHONE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_type` SET TAGS ('dbx_business_glossary_term' = 'Applicant Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `applicant_type` SET TAGS ('dbx_value_regex' = 'customer|third_party|developer');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `application_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Application Submitted Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Approval Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `der_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'DER Capacity (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `der_type` SET TAGS ('dbx_business_glossary_term' = 'Distributed Energy Resource Type (DER TYPE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `der_type` SET TAGS ('dbx_value_regex' = 'rooftop_solar|battery_storage|ev_charging|microgrid|customer_sited');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `estimated_study_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Study Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `facilities_study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Facilities Study Completion Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `facilities_study_status` SET TAGS ('dbx_business_glossary_term' = 'Facilities Study Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `facilities_study_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `feasibility_study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Completion Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `feasibility_study_status` SET TAGS ('dbx_business_glossary_term' = 'Feasibility Study Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `feasibility_study_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `ferc_order_2222_compliant` SET TAGS ('dbx_business_glossary_term' = 'FERC Order 2222 Compliance');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `indemnification_terms` SET TAGS ('dbx_business_glossary_term' = 'Indemnification Terms');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Inspection Result');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'initial|final|reinspection');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `insurance_obligations` SET TAGS ('dbx_business_glossary_term' = 'Insurance Obligations');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Request Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|under_review|approved|rejected|closed');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `max_export_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Export Capacity (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `metering_requirements` SET TAGS ('dbx_business_glossary_term' = 'Metering Requirements');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `permit_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Approval Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `permit_conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `permit_issuing_authority` SET TAGS ('dbx_business_glossary_term' = 'Permit Issuing Authority');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `permit_submission_date` SET TAGS ('dbx_business_glossary_term' = 'Permit Submission Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `poi_location` SET TAGS ('dbx_business_glossary_term' = 'Point of Interconnection Location');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `point_of_interconnection_reference` SET TAGS ('dbx_business_glossary_term' = 'Point of Interconnection Identifier (POI ID)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `protection_requirements` SET TAGS ('dbx_business_glossary_term' = 'Protection Requirements');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `request_number` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Request Number');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `state_puc_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'State PUC Tariff Code');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `study_queue_position` SET TAGS ('dbx_business_glossary_term' = 'Study Queue Position');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `system_impact_study_completion_date` SET TAGS ('dbx_business_glossary_term' = 'System Impact Study Completion Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `system_impact_study_status` SET TAGS ('dbx_business_glossary_term' = 'System Impact Study Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `system_impact_study_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|failed');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_request` ALTER COLUMN `termination_conditions` SET TAGS ('dbx_business_glossary_term' = 'Termination Conditions');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` SET TAGS ('dbx_subdomain' = 'program_enrollment');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Account Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `aggregation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `asset_permit_compliance_document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Document ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Service Account ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nem Account Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Portfolio Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `annual_true_up_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual True‑Up Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `annual_true_up_currency` SET TAGS ('dbx_business_glossary_term' = 'Annual True‑Up Currency');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `annual_true_up_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `annual_true_up_date` SET TAGS ('dbx_business_glossary_term' = 'Annual True‑Up Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `annual_true_up_kwh` SET TAGS ('dbx_business_glossary_term' = 'Annual True‑Up Net kWh');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `annual_true_up_status` SET TAGS ('dbx_business_glossary_term' = 'Annual True‑Up Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `annual_true_up_status` SET TAGS ('dbx_value_regex' = 'pending|completed|adjusted');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Approval Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Approval Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `banking_period_end` SET TAGS ('dbx_business_glossary_term' = 'Banking Period End Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `banking_period_start` SET TAGS ('dbx_business_glossary_term' = 'Banking Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `credit_balance` SET TAGS ('dbx_business_glossary_term' = 'NEM Credit Balance (USD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `credit_currency` SET TAGS ('dbx_business_glossary_term' = 'Credit Currency');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `credit_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `credit_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `cumulative_net_kwh_banked` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Net kWh Banked');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'NEM Enrollment Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `export_compensation_rate` SET TAGS ('dbx_business_glossary_term' = 'Export Compensation Rate (USD per kWh)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `export_compensation_rate` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `export_compensation_rate` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `interconnection_date` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `last_reading_date` SET TAGS ('dbx_business_glossary_term' = 'Last Meter Reading Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `last_reading_kwh` SET TAGS ('dbx_business_glossary_term' = 'Last Meter Reading kWh');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `last_reading_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Quality Flag');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `last_reading_quality_flag` SET TAGS ('dbx_value_regex' = 'good|estimated|missing');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `meter_reading_source` SET TAGS ('dbx_business_glossary_term' = 'Meter Reading Source');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `meter_reading_source` SET TAGS ('dbx_value_regex' = 'automated|manual');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `meter_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `meter_type` SET TAGS ('dbx_value_regex' = 'ami|non_ami');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `nem_account_number` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Account Number');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `nem_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `nem_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `net_metering_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'NEM Capacity (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `net_metering_status` SET TAGS ('dbx_business_glossary_term' = 'NEM Account Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `net_metering_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|terminated');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `net_metering_type` SET TAGS ('dbx_business_glossary_term' = 'NEM Account Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `net_metering_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `program_enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `program_enrollment_status` SET TAGS ('dbx_value_regex' = 'enrolled|withdrawn|suspended');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `program_version` SET TAGS ('dbx_business_glossary_term' = 'NEM Program Version');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `program_version` SET TAGS ('dbx_value_regex' = 'NEM 1.0|NEM 2.0|NEM 3.0|NEM-A');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `rate_structure` SET TAGS ('dbx_business_glossary_term' = 'Export Compensation Rate Structure');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `rate_structure` SET TAGS ('dbx_value_regex' = 'fixed|tiered|time_of_use|dynamic');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `rate_type` SET TAGS ('dbx_business_glossary_term' = 'Export Rate Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `rate_type` SET TAGS ('dbx_value_regex' = 'fixed|tou|cpp|rtp');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `rate_units` SET TAGS ('dbx_business_glossary_term' = 'Export Rate Units');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `rate_value` SET TAGS ('dbx_business_glossary_term' = 'Export Rate Value');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `tariff_schedule_code` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Code');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'NEM Termination Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'NEM Termination Reason');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_account` ALTER COLUMN `vpp_participation_flag` SET TAGS ('dbx_business_glossary_term' = 'Virtual Power Plant Participation Flag');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `nem_true_up_id` SET TAGS ('dbx_business_glossary_term' = 'NEM True-Up Record ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Der Nem Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Nem True Up Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `adjustment_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVED_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `export_credit_applied` SET TAGS ('dbx_business_glossary_term' = 'Export Credit Applied Flag');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `export_credit_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Export Credit Value (USD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `nem_true_up_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `nem_true_up_status` SET TAGS ('dbx_value_regex' = 'pending|settled|reversed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `net_kwh_balance` SET TAGS ('dbx_business_glossary_term' = 'Net kWh Balance (NET_KWH)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Status (FILING_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_value_regex' = 'not_filed|filed|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `remaining_balance_usd` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance (USD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `settlement_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method (METHOD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'automatic|manual');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Number (SETTLEMENT_NO)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `settlement_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Settlement Timestamp (SETTLEMENT_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'annual|periodic');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `total_exported_kwh` SET TAGS ('dbx_business_glossary_term' = 'Total Exported Energy (kWh)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `total_imported_kwh` SET TAGS ('dbx_business_glossary_term' = 'Total Imported Energy (kWh)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `true_up_period_end` SET TAGS ('dbx_business_glossary_term' = 'True‑Up Period End Date (END_DATE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`nem_true_up` ALTER COLUMN `true_up_period_start` SET TAGS ('dbx_business_glossary_term' = 'True‑Up Period Start Date (START_DATE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` SET TAGS ('dbx_subdomain' = 'program_enrollment');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `der_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `aggregator_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregator ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `der_program_id` SET TAGS ('dbx_business_glossary_term' = 'Der Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Enrolled Capacity (KW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `contractual_obligation` SET TAGS ('dbx_business_glossary_term' = 'Contractual Obligation (CONTRACT_OBL)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria (ELIG_CRIT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date (ENROLL_DATE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `enrollment_number` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Number (ENROLL_NUM)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Source (ENROLL_SRC)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `enrollment_source` SET TAGS ('dbx_value_regex' = 'online|call_center|field_agent|partner');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status (ENROLL_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|terminated|opted_out');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount (INCENT_AMT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type (INCENT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'rebate|credit|payment|tax_credit');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `is_aggregated` SET TAGS ('dbx_business_glossary_term' = 'Is Aggregated Flag (AGG_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `opt_out_date` SET TAGS ('dbx_business_glossary_term' = 'Opt‑Out Date (OPT_OUT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (REG_CODE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (VOLT_LEVEL)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `voltage_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program_enrollment` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `aggregation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `aggregator_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregator Entity Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Portfolio Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `primary_aggregation_aggregator_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregator Entity Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `aggregation_code` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group Code');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `aggregation_group_description` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group Description');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `aggregation_group_name` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group Name');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `aggregation_group_status` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `aggregation_group_status` SET TAGS ('dbx_value_regex' = 'forming|active|suspended|retired');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `aggregation_type` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `aggregation_type` SET TAGS ('dbx_value_regex' = 'vpp|fleet|microgrid|aggregator');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `aggregator_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Aggregator Entity Name');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `ancillary_service_type` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `ancillary_service_type` SET TAGS ('dbx_value_regex' = 'regulation|spinning|non_spinning');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `capacity_reserve_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity Reserve (MW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `demand_response_capability` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Capability Flag');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `demand_response_program` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Program');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `demand_response_program` SET TAGS ('dbx_value_regex' = 'dr|none|custom');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `dispatch_max_mw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Dispatch Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `dispatch_min_mw` SET TAGS ('dbx_business_glossary_term' = 'Minimum Dispatch Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `geographic_boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary Description');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `geographic_boundary_type` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `geographic_boundary_type` SET TAGS ('dbx_value_regex' = 'zip|county|state|custom');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `is_virtual` SET TAGS ('dbx_business_glossary_term' = 'Virtual Aggregation Flag');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `last_compliance_check_date` SET TAGS ('dbx_business_glossary_term' = 'Last Compliance Check Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `market_participation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Market Participation End Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `market_participation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Market Participation Start Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `market_products_authorized` SET TAGS ('dbx_business_glossary_term' = 'Authorized Market Products');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `market_products_authorized` SET TAGS ('dbx_value_regex' = 'energy|capacity|ancillary');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `market_registration_code` SET TAGS ('dbx_business_glossary_term' = 'Market Registration Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `net_energy_metering_enabled` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering Enabled Flag');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `net_energy_metering_program` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering Program Name');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `participation_mode` SET TAGS ('dbx_business_glossary_term' = 'Participation Mode');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `participation_mode` SET TAGS ('dbx_value_regex' = 'centralized|decentralized');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `renewable_energy_certificate_quantity` SET TAGS ('dbx_business_glossary_term' = 'REC Quantity (MWh)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `renewable_energy_certificate_type` SET TAGS ('dbx_business_glossary_term' = 'REC Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `renewable_energy_certificate_type` SET TAGS ('dbx_value_regex' = 'rec|none');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `resource_mix_ev_pct` SET TAGS ('dbx_business_glossary_term' = 'EV Charging Resource Mix Percentage');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `resource_mix_solar_pct` SET TAGS ('dbx_business_glossary_term' = 'Solar Resource Mix Percentage');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `resource_mix_storage_pct` SET TAGS ('dbx_business_glossary_term' = 'Storage Resource Mix Percentage');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `rto_iso_market` SET TAGS ('dbx_business_glossary_term' = 'RTO/ISO Market Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Account Number');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `settlement_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `total_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Enrolled Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregation_group` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `dispatch_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Event Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `aggregation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `actual_response` SET TAGS ('dbx_business_glossary_term' = 'Actual Response Delivered');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `bid_price` SET TAGS ('dbx_business_glossary_term' = 'Bid Price (USD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Comments');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Indicator');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `dispatch_event_status` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `dispatch_event_status` SET TAGS ('dbx_value_regex' = 'pending|approved|executed|cancelled|failed');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `dispatch_number` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Number');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `dispatch_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Reason');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `dispatch_source` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Source');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `dispatch_source` SET TAGS ('dbx_value_regex' = 'DERMS|Operator|Aggregator|ISO');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `dispatch_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Expiry Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `external_order_reference` SET TAGS ('dbx_business_glossary_term' = 'External Market Order Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Dispatch Indicator');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Emergency Dispatch Indicator');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `lmp_reference` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price Reference');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `market` SET TAGS ('dbx_value_regex' = 'DAM|RTM|ISO|RTO');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `market_interval_end` SET TAGS ('dbx_business_glossary_term' = 'Market Interval End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `market_interval_start` SET TAGS ('dbx_business_glossary_term' = 'Market Interval Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `market_product_type` SET TAGS ('dbx_business_glossary_term' = 'Market Product Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `market_product_type` SET TAGS ('dbx_value_regex' = 'energy|capacity|ancillary|frequency_regulation|peak_shaving|demand_response');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `market_region` SET TAGS ('dbx_business_glossary_term' = 'Market Region Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `offer_price` SET TAGS ('dbx_business_glossary_term' = 'Offer Price (USD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Performance Score');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `regulatory_report_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Report Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `schedule_confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Confirmation Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `schedule_confirmation_status` SET TAGS ('dbx_value_regex' = 'confirmed|rejected|pending');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `setpoint_unit` SET TAGS ('dbx_business_glossary_term' = 'Setpoint Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `setpoint_unit` SET TAGS ('dbx_value_regex' = 'kW|MW');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `setpoint_value` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Setpoint Value');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'settled|unsettled|disputed');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `power_and_utilities_v2`.`der`.`dispatch_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` SET TAGS ('dbx_subdomain' = 'interconnection_service');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `interconnection_study_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Study Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `circuit_feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Circuit Identifier (CIR_ID)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Identifier (FEED_ID)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `interconnection_request_id` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Request Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPR_DT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `approval_engineer` SET TAGS ('dbx_business_glossary_term' = 'Approval Engineer (APPR_ENG)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPR_STS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Cost Allocation Method (COST_ALLOC_MTH)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `cost_allocation_method` SET TAGS ('dbx_value_regex' = 'pro_rata|fixed|usage_based');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `cost_sharing_agreement` SET TAGS ('dbx_business_glossary_term' = 'Cost Sharing Agreement (COST_SHARE_AGMT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRE_TSTMP)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System (SRC_SYS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `engineer_assigned` SET TAGS ('dbx_business_glossary_term' = 'Assigned Engineer (ENG_ASSGN)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `estimated_upgrade_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Upgrade Cost (USD) (EST_UPG_COST_USD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `existing_der_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Existing DER Capacity (KW) (EXIST_DER_CAP_KW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `geographic_region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (REGION)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `grid_impact_summary` SET TAGS ('dbx_business_glossary_term' = 'Grid Impact Summary (GRID_IMP_SUM)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `hosting_capacity_limit_kw` SET TAGS ('dbx_business_glossary_term' = 'Hosting Capacity Limit (KW) (HOST_CAP_LIMIT_KW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `identified_constraints` SET TAGS ('dbx_business_glossary_term' = 'Identified Constraints (CONST_ID)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `interconnection_point` SET TAGS ('dbx_business_glossary_term' = 'Interconnection Point (ICP)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `interconnection_study_status` SET TAGS ('dbx_business_glossary_term' = 'Study Status (STUDY_STS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `interconnection_study_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|approved|rejected|expired');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `load_impact_kw` SET TAGS ('dbx_business_glossary_term' = 'Load Impact (KW) (LOAD_IMP_KW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `methodology` SET TAGS ('dbx_business_glossary_term' = 'Methodology (METH)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `methodology` SET TAGS ('dbx_value_regex' = 'deterministic|probabilistic');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `proposed_additional_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Proposed Additional Capacity (KW) (PROP_ADD_CAP_KW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `protection_coordination` SET TAGS ('dbx_business_glossary_term' = 'Protection Coordination Findings (PROT_COORD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme (PROT_SCHEME)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `recommended_upgrades` SET TAGS ('dbx_business_glossary_term' = 'Recommended Upgrades (UPG_REC)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `regulatory_review_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Date (REG_REVIEW_DT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Review Status (REG_REVIEW_STS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `regulatory_review_status` SET TAGS ('dbx_value_regex' = 'not_started|in_review|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `study_description` SET TAGS ('dbx_business_glossary_term' = 'Study Description (STUDY_DESC)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `study_end_date` SET TAGS ('dbx_business_glossary_term' = 'Study End Date (STUDY_END_DT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `study_name` SET TAGS ('dbx_business_glossary_term' = 'Study Name (STUDY_NM)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `study_number` SET TAGS ('dbx_business_glossary_term' = 'Study Number (STUDY_NO)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `study_start_date` SET TAGS ('dbx_business_glossary_term' = 'Study Start Date (STUDY_START_DT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `study_type` SET TAGS ('dbx_business_glossary_term' = 'Study Type (STUDY_TP)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `study_type` SET TAGS ('dbx_value_regex' = 'feasibility|system_impact|facilities|hosting_capacity');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `study_validity_period_months` SET TAGS ('dbx_business_glossary_term' = 'Study Validity Period (Months) (VAL_PERIOD_MTH)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `study_version` SET TAGS ('dbx_business_glossary_term' = 'Study Version (STUDY_VER)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `thermal_impact` SET TAGS ('dbx_business_glossary_term' = 'Thermal Impact (THRM_IMP)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `thermal_impact` SET TAGS ('dbx_value_regex' = 'acceptable|minor|major');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `thermal_rating_exceeded` SET TAGS ('dbx_business_glossary_term' = 'Thermal Rating Exceeded Flag (THRM_EXCD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TSTMP)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `upgrade_requirements` SET TAGS ('dbx_business_glossary_term' = 'Upgrade Requirements (UPG_REQ)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Validity End Date (VAL_END_DT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Validity Start Date (VAL_START_DT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `voltage_drop_percent` SET TAGS ('dbx_business_glossary_term' = 'Voltage Drop Percent (VLT_DROP_PCT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `voltage_impact` SET TAGS ('dbx_business_glossary_term' = 'Voltage Impact (VLT_IMP)');
ALTER TABLE `power_and_utilities_v2`.`der`.`interconnection_study` ALTER COLUMN `voltage_impact` SET TAGS ('dbx_value_regex' = 'acceptable|minor|major');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `bess_operation_id` SET TAGS ('dbx_business_glossary_term' = 'Battery Energy Storage System (BESS) Operation ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Bess Operation Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'BESS Asset ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'BESS Asset ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Operator ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `battery_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Battery Temperature (°C)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `cycle_depth_pct` SET TAGS ('dbx_business_glossary_term' = 'Cycle Depth (%)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `cycle_duration_seconds` SET TAGS ('dbx_business_glossary_term' = 'Cycle Duration (seconds)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `degradation_estimate_pct` SET TAGS ('dbx_business_glossary_term' = 'Degradation Estimate (%)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `dispatch_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Dispatch Event Reference');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `energy_throughput_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Throughput (kWh)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `event_type` SET TAGS ('dbx_business_glossary_term' = 'Event Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `event_type` SET TAGS ('dbx_value_regex' = 'bess_operation');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `health_status` SET TAGS ('dbx_business_glossary_term' = 'Health Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `health_status` SET TAGS ('dbx_value_regex' = 'good|degraded|critical');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `health_status` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `health_status` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Due Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `operation_mode` SET TAGS ('dbx_business_glossary_term' = 'Operation Mode');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `operation_mode` SET TAGS ('dbx_value_regex' = 'charge|discharge|idle|frequency_regulation');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `power_setpoint_kw` SET TAGS ('dbx_business_glossary_term' = 'Power Setpoint (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `round_trip_efficiency_pct` SET TAGS ('dbx_business_glossary_term' = 'Round‑Trip Efficiency (%)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `soc_end_pct` SET TAGS ('dbx_business_glossary_term' = 'State of Charge End (%)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `soc_start_pct` SET TAGS ('dbx_business_glossary_term' = 'State of Charge Start (%)');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`bess_operation` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `ev_charging_session_id` SET TAGS ('dbx_business_glossary_term' = 'EV Charging Session ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `der_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Participation ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Charger Asset ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Charging Location ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `service_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Service Plan Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `charging_level` SET TAGS ('dbx_business_glossary_term' = 'Charging Level');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `charging_level` SET TAGS ('dbx_value_regex' = 'L1|L2|DCFC');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `demand_response_flag` SET TAGS ('dbx_business_glossary_term' = 'Demand Response Participation Flag');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `energy_delivered_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Delivered (kWh)');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `ev_charging_session_status` SET TAGS ('dbx_business_glossary_term' = 'Charging Session Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `ev_charging_session_status` SET TAGS ('dbx_value_regex' = 'completed|in_progress|cancelled|failed|pending');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `grid_interconnection_flag` SET TAGS ('dbx_business_glossary_term' = 'Grid Interconnection Flag');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `peak_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `session_cost_gross` SET TAGS ('dbx_business_glossary_term' = 'Session Gross Cost');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `session_cost_net` SET TAGS ('dbx_business_glossary_term' = 'Session Net Cost');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `session_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Session Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `session_notes` SET TAGS ('dbx_business_glossary_term' = 'Session Notes');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `session_number` SET TAGS ('dbx_business_glossary_term' = 'Charging Session Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `session_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Session Tax Amount');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `smart_charging_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Smart Charging Program Participation Flag');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Session Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `tou_period` SET TAGS ('dbx_business_glossary_term' = 'Time‑of‑Use Period');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `tou_period` SET TAGS ('dbx_value_regex' = 'off_peak|mid_peak|on_peak|super_peak');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`ev_charging_session` ALTER COLUMN `vehicle_identifier` SET TAGS ('dbx_business_glossary_term' = 'Vehicle Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `microgrid_id` SET TAGS ('dbx_business_glossary_term' = 'Microgrid Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `aggregation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Permit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Microgrid Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Generation Capacity (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date (CMN_DT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMP_STS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `control_system_type` SET TAGS ('dbx_business_glossary_term' = 'Control System Type (CST)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `control_system_type` SET TAGS ('dbx_value_regex' = 'centralized|decentralized|hierarchical');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRT_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `critical_load_kw` SET TAGS ('dbx_business_glossary_term' = 'Critical Load Served (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date (DECOM_DT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `frequency_hz` SET TAGS ('dbx_business_glossary_term' = 'Operating Frequency (Hz)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `geographic_boundary_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary (WKT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `grid_connection_capability` SET TAGS ('dbx_business_glossary_term' = 'Grid Connection Capability (GCC)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `grid_connection_capability` SET TAGS ('dbx_value_regex' = 'grid_connected|islanded|both');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date (INST_DT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Load Flag (CRIT_FLG)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `islanding_protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Islanding Protection Scheme (IPS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `islanding_protection_scheme` SET TAGS ('dbx_value_regex' = 'automatic|manual|hybrid');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `last_active_generation_sources` SET TAGS ('dbx_business_glossary_term' = 'Last Active Generation Sources (GEN_SRC)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `last_island_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Last Island Duration (MIN)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `last_load_served_kw` SET TAGS ('dbx_business_glossary_term' = 'Last Load Served (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `last_transition_cause` SET TAGS ('dbx_business_glossary_term' = 'Last Transition Cause (LST_TRN_CS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `last_transition_cause` SET TAGS ('dbx_value_regex' = 'utility_outage|scheduled_test|operator_command');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `last_transition_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Transition Timestamp (LST_TRN_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `last_transition_type` SET TAGS ('dbx_business_glossary_term' = 'Last Transition Type (LST_TRN_TP)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `last_transition_type` SET TAGS ('dbx_value_regex' = 'grid_to_island|island_to_grid|resynchronization|test');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `microgrid_code` SET TAGS ('dbx_business_glossary_term' = 'Microgrid Code');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `microgrid_name` SET TAGS ('dbx_business_glossary_term' = 'Microgrid Name');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `microgrid_status` SET TAGS ('dbx_business_glossary_term' = 'Microgrid Lifecycle Status (STS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `microgrid_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `microgrid_type` SET TAGS ('dbx_business_glossary_term' = 'Microgrid Ownership Type (OWN)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `microgrid_type` SET TAGS ('dbx_value_regex' = 'utility_owned|customer_owned|community');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status (OPS_STS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'operational|maintenance|outage');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Email (OWN_EM)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `owner_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Owner Contact Phone (OWN_PH)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `owner_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization (OWN_ORG)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `pcc_point` SET TAGS ('dbx_business_glossary_term' = 'Point of Common Coupling (PCC)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag (REG_RPT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `resynchronization_outcome` SET TAGS ('dbx_business_glossary_term' = 'Resynchronization Outcome (RSYNC_OUT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `resynchronization_outcome` SET TAGS ('dbx_value_regex' = 'successful|failed|partial');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `saidi_impact_estimate_minutes` SET TAGS ('dbx_business_glossary_term' = 'SAIDI Impact Estimate (MIN)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `saifi_impact_estimate` SET TAGS ('dbx_business_glossary_term' = 'SAIFI Impact Estimate (COUNT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `storage_capacity_kwh` SET TAGS ('dbx_business_glossary_term' = 'Energy Storage Capacity (kWh)');
ALTER TABLE `power_and_utilities_v2`.`der`.`microgrid` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` SET TAGS ('dbx_subdomain' = 'market_operations');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `performance_summary_id` SET TAGS ('dbx_business_glossary_term' = 'Performance Summary Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `der_asset_resource_id` SET TAGS ('dbx_business_glossary_term' = 'DER Asset ID (DER_ASSET_ID)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'DER Asset ID (DER_ASSET_ID)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `actual_output_kwh` SET TAGS ('dbx_business_glossary_term' = 'Actual Energy Output (ACTUAL_KWH)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `availability_factor_pct` SET TAGS ('dbx_business_glossary_term' = 'Availability Factor (AVAIL_FACTOR_PCT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `business_event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Business Event Timestamp (BUS_EVT_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `capacity_factor_pct` SET TAGS ('dbx_business_glossary_term' = 'Capacity Factor (CAPACITY_FACTOR_PCT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `compensation_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Compensation Eligibility Flag (COMP_ELIGIBLE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `compensation_eligible_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `compensation_eligible_flag` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `curtailment_authority` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Authority (CURTAIL_AUTH)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `curtailment_authority` SET TAGS ('dbx_value_regex' = 'utility|iso_rto|derms_auto|operator_directed');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `curtailment_energy_kwh` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Energy (CURTAIL_KWH)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `curtailment_event_count` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Event Count (CURTAIL_EVT_CNT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `curtailment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Reason Code (CURTAIL_REASON_CD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `curtailment_reason_code` SET TAGS ('dbx_value_regex' = 'voltage_violation|thermal_overload|overgeneration|operator_directed|grid_constraint|maintenance');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `expected_output_kwh` SET TAGS ('dbx_business_glossary_term' = 'Expected Energy Output (EXPECTED_KWH)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_business_glossary_term' = 'Measurement Unit (MEAS_UNIT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `measurement_unit` SET TAGS ('dbx_value_regex' = 'kwh');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `performance_period_type` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Type (PERF_PERIOD_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `performance_period_type` SET TAGS ('dbx_value_regex' = 'daily|monthly');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `performance_ratio_pct` SET TAGS ('dbx_business_glossary_term' = 'Performance Ratio (PERF_RATIO_PCT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `performance_record_number` SET TAGS ('dbx_business_glossary_term' = 'Performance Record Number (PERF_REC_NUM)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `performance_summary_status` SET TAGS ('dbx_business_glossary_term' = 'Performance Summary Status (PERF_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `performance_summary_status` SET TAGS ('dbx_value_regex' = 'pending|validated|rejected');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period End Date (PERF_END_DT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Performance Period Start Date (PERF_START_DT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`performance_summary` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` SET TAGS ('dbx_subdomain' = 'program_enrollment');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `der_program_id` SET TAGS ('dbx_business_glossary_term' = 'DER Program Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `budget_amount` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Amount');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `budget_currency` SET TAGS ('dbx_business_glossary_term' = 'Program Budget Currency');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `budget_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `capacity_limit_mw` SET TAGS ('dbx_business_glossary_term' = 'Program Capacity Limit (MW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Program Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `current_enrollment_count` SET TAGS ('dbx_business_glossary_term' = 'Current Enrollment Count');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `enrollment_cap_mw` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Capacity Limit (MW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `enrollment_close_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Close Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `enrollment_open_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Open Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `external_program_code` SET TAGS ('dbx_business_glossary_term' = 'Program External Identifier');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_business_glossary_term' = 'Program Funding Source');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `funding_source` SET TAGS ('dbx_value_regex' = 'utility|federal|state|private');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `incentive_rate` SET TAGS ('dbx_business_glossary_term' = 'Incentive Rate');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `incentive_structure` SET TAGS ('dbx_business_glossary_term' = 'Incentive Structure');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `incentive_unit` SET TAGS ('dbx_business_glossary_term' = 'Incentive Unit');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Program Last Review Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `market` SET TAGS ('dbx_business_glossary_term' = 'Program Market');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `market` SET TAGS ('dbx_value_regex' = 'retail|wholesale');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Program Notes');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `program_category` SET TAGS ('dbx_business_glossary_term' = 'Program Category');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `program_category` SET TAGS ('dbx_value_regex' = 'incentive|grid_service|customer_engagement');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `program_description` SET TAGS ('dbx_business_glossary_term' = 'Program Description');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Program Name');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Program Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|closed|draft');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `program_type` SET TAGS ('dbx_business_glossary_term' = 'Program Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `program_type` SET TAGS ('dbx_value_regex' = 'demand_response|virtual_power_plant|battery_incentive|ev_charging|community_solar');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Program Region Code');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `region_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Program Review Frequency');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly|monthly');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `subcategory` SET TAGS ('dbx_business_glossary_term' = 'Program Subcategory');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_business_glossary_term' = 'Target Customer Segment');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `target_customer_segment` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|municipal');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `target_der_technology` SET TAGS ('dbx_business_glossary_term' = 'Target DER Technology');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `target_der_technology` SET TAGS ('dbx_value_regex' = 'solar|battery|ev|heat_pump|wind');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Program Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Program Version Number');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Program Voltage Level');
ALTER TABLE `power_and_utilities_v2`.`der`.`der_program` ALTER COLUMN `voltage_level` SET TAGS ('dbx_value_regex' = 'low|medium|high');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `aggregator_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregator ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDR_LINE1)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2 (ADDR_LINE2)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `aggregator_name` SET TAGS ('dbx_business_glossary_term' = 'Aggregator Legal Name (AGG)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `aggregator_status` SET TAGS ('dbx_business_glossary_term' = 'Aggregator Status (AGG_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `aggregator_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `aggregator_type` SET TAGS ('dbx_business_glossary_term' = 'Aggregator Type (AGG_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `aggregator_type` SET TAGS ('dbx_value_regex' = 'independent|utility_owned|community|municipal|other');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMPLIANCE_STAT)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|suspended');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `contract_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract End Date (CONTRACT_END)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `contract_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Start Date (CONTRACT_START)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `ferc_registration_number` SET TAGS ('dbx_business_glossary_term' = 'FERC Registration ID (FERC_REG_ID)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `ferc_registration_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `ferc_registration_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Flag (ACTIVE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `is_certified` SET TAGS ('dbx_business_glossary_term' = 'Certified Flag (CERTIFIED)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `market_products` SET TAGS ('dbx_business_glossary_term' = 'Market Products (MARKET_PROD)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `market_products` SET TAGS ('dbx_value_regex' = 'energy|capacity|ancillary|flexibility|revenue|other');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email (CONTACT_EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name (CONTACT_NAME)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone (CONTACT_PHONE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `puc_authorization_number` SET TAGS ('dbx_business_glossary_term' = 'PUC Authorization Number (PUC_AUTH_NUM)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `puc_authorization_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `puc_authorization_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Code (TERR_CODE)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_value_regex' = '[A-Z]{2}');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `service_territory_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `total_enrolled_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Total Enrolled Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL (WEB_URL)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code (ZIP)');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `zip_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`aggregator` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` SET TAGS ('dbx_subdomain' = 'asset_registry');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `community_solar_subscription_id` SET TAGS ('dbx_business_glossary_term' = 'Community Solar Subscription ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `der_program_id` SET TAGS ('dbx_business_glossary_term' = 'Der Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `renewable_resource_id` SET TAGS ('dbx_business_glossary_term' = 'Community Solar Project ID');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `allocated_energy_pct` SET TAGS ('dbx_business_glossary_term' = 'Allocated Energy Share (%)');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `bill_credit_rate` SET TAGS ('dbx_business_glossary_term' = 'Bill Credit Rate ($/kWh)');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `billing_cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Subscribed Capacity (kW)');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `community_solar_subscription_status` SET TAGS ('dbx_business_glossary_term' = 'Subscription Status');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `community_solar_subscription_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|cancelled|expired');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `incentive_amount` SET TAGS ('dbx_business_glossary_term' = 'Incentive Amount ($)');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `incentive_type` SET TAGS ('dbx_business_glossary_term' = 'Incentive Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `incentive_type` SET TAGS ('dbx_value_regex' = 'rebate|tax_credit|none');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Subscription Notes');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'auto_debit|check|credit_card');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `subscription_end_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription End Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `subscription_number` SET TAGS ('dbx_business_glossary_term' = 'Subscription Number');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `subscription_start_date` SET TAGS ('dbx_business_glossary_term' = 'Subscription Start Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `subscription_type` SET TAGS ('dbx_business_glossary_term' = 'Subscription Type');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `subscription_type` SET TAGS ('dbx_value_regex' = 'rooftop|ground|virtual');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `term_months` SET TAGS ('dbx_business_glossary_term' = 'Subscription Term (Months)');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `transfer_allowed` SET TAGS ('dbx_business_glossary_term' = 'Transfer Allowed Flag');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Transfer Date');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`der`.`community_solar_subscription` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `power_and_utilities_v2`.`der`.`program_zone_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`der`.`program_zone_assignment` SET TAGS ('dbx_subdomain' = 'interconnection_service');
ALTER TABLE `power_and_utilities_v2`.`der`.`program_zone_assignment` SET TAGS ('dbx_association_edges' = 'gridops.control_zone,der.program');
ALTER TABLE `power_and_utilities_v2`.`der`.`program_zone_assignment` ALTER COLUMN `program_zone_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Zone Assignment - Program Zone Assignment Id');
ALTER TABLE `power_and_utilities_v2`.`der`.`program_zone_assignment` ALTER COLUMN `control_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Program Zone Assignment - Control Zone Id');
ALTER TABLE `power_and_utilities_v2`.`der`.`program_zone_assignment` ALTER COLUMN `der_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Zone Assignment - Der Program Id');
ALTER TABLE `power_and_utilities_v2`.`der`.`program_zone_assignment` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Program Zone Assignment - Effective From');
ALTER TABLE `power_and_utilities_v2`.`der`.`program_zone_assignment` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Program Zone Assignment - Effective Until');
ALTER TABLE `power_and_utilities_v2`.`der`.`program_zone_assignment` ALTER COLUMN `program_zone_assignment_status` SET TAGS ('dbx_business_glossary_term' = 'Program Zone Assignment - Status');
