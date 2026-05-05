-- Schema for Domain: billing | Business: Power and Utilities | Version: v1_mvm
-- Generated on: 2026-04-29 23:12:54

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities`.`billing` COMMENT 'Authoritative source for the full revenue cycle — rate schedule application (TOU, CPP, tiered), invoice generation, payment processing, collections, dispute resolution, and revenue recognition for electric and gas services. Owns charge calculations incorporating FAC, CIAC adjustments, and regulatory riders. Integrates with CIS (Oracle CC&B / SAP IS-U) and ERP for GAAP revenue reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities`.`billing`.`rate_schedule` (
    `rate_schedule_id` BIGINT COMMENT 'Primary key for rate_schedule',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Rate schedules tie to cost centers for cost-of-service studies and rate case preparation. Required for regulatory cost allocation and revenue requirement calculations in rate proceedings.',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to market.ppa_contract. Business justification: Utilities design retail rate schedules (renewable energy riders, fuel adjustment clauses) that recover costs from specific PPA contracts. Essential for rate case filings, regulatory cost recovery, and',
    `pricing_node_id` BIGINT COMMENT 'Foreign key linking to market.pricing_node. Business justification: Utilities in restructured markets with nodal pricing or location-based rates tie rate schedules to specific pricing nodes for pass-through of locational marginal pricing. Essential for real-time prici',
    `superseded_by_rate_schedule_id` BIGINT COMMENT 'Foreign key reference to the rate schedule that supersedes this one. Nullable if this is the current active version. Used to maintain rate schedule lineage and support customer migration from old to new schedules.',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Rate schedules used for customer billing must be tied to formally approved regulatory tariff schedules. This FK formalizes the relationship between operational billing rates and regulatory tariff fili',
    `approval_date` DATE COMMENT 'Date the rate schedule was approved by the governing PUC or FERC. Must precede or match the effective date. Used for regulatory compliance reporting.',
    `base_energy_rate` DECIMAL(18,2) COMMENT 'Base rate per unit of energy consumption (dollars per kWh for electric, dollars per Therm or MCF for gas). Excludes riders, surcharges, and adjustments. Represents the foundational commodity charge before layering FAC and other regulatory adjustments.',
    `commodity_type` STRING COMMENT 'Type of utility service this rate schedule applies to: electric, gas, or dual (combined electric and gas).. Valid values are `electric|gas|dual`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was first created in the system. Represents the audit trail for data lineage.',
    `currency_code` STRING COMMENT 'ISO 4217 three-letter currency code for all monetary values in this rate schedule. Typically USD for U.S. utilities.. Valid values are `USD`',
    `customer_charge` DECIMAL(18,2) COMMENT 'Fixed monthly charge per customer account, independent of consumption. Covers meter reading, billing, and customer service costs. Expressed in dollars per month.',
    `customer_class` STRING COMMENT 'Customer classification segment this rate schedule applies to. Determines eligibility for the rate and drives cost allocation in rate case studies.. Valid values are `residential|commercial|industrial|agricultural|street_lighting|public_authority`',
    `demand_charge_rate` DECIMAL(18,2) COMMENT 'Rate per unit of peak demand (dollars per kW or MW). Applicable to commercial and industrial rate schedules with demand-based pricing. Nullable for residential and other non-demand schedules.',
    `demand_charge_uom` STRING COMMENT 'Unit of measure for the demand charge: kW (kilowatt) or MW (megawatt). Applicable only when demand_charge_rate is populated.. Valid values are `kw|mw`',
    `effective_date` DATE COMMENT 'Date when this rate schedule becomes active and available for customer enrollment and billing application. Must align with PUC approval date for new or modified tariffs.',
    `eligibility_criteria` STRING COMMENT 'Textual description of customer eligibility requirements for enrollment in this rate schedule. May include minimum/maximum usage thresholds, service type requirements, or geographic restrictions.',
    `energy_rate_uom` STRING COMMENT 'Unit of measure for the base energy rate: kWh (kilowatt-hour) or MWh (megawatt-hour) for electric, Therm or MCF (thousand cubic feet) or CCF (hundred cubic feet) for gas.. Valid values are `kwh|mwh|therm|mcf|ccf`',
    `expiration_date` DATE COMMENT 'Date when this rate schedule is no longer available for new enrollments. Nullable for open-ended schedules. Existing customers on expired schedules may be grandfathered until migrated.',
    `interruptible_flag` BOOLEAN COMMENT 'Indicates whether this rate schedule is for interruptible service, where the utility may curtail service during peak demand or emergencies in exchange for lower rates. True for interruptible schedules; False for firm service.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this rate schedule record was last updated. Used for change tracking and audit purposes.',
    `minimum_charge` DECIMAL(18,2) COMMENT 'Minimum total charge per billing cycle regardless of consumption. Ensures cost recovery for low-usage customers. Nullable if no minimum applies.',
    `net_metering_eligible_flag` BOOLEAN COMMENT 'Indicates whether customers on this rate schedule are eligible for Net Energy Metering (NEM) programs, allowing bidirectional energy flow and credit for excess generation from DER (Distributed Energy Resources) such as rooftop solar.',
    `rate_case_docket` STRING COMMENT 'PUC docket number of the rate case proceeding that established or last modified this rate schedule. Used to trace rate design back to cost-of-service studies and regulatory decisions.',
    `rate_code` STRING COMMENT 'Unique alphanumeric code identifying the rate schedule in the tariff book. Used as the business identifier for rate lookup in billing calculations. Examples: RES-TOU-1, COM-DEMAND-A, IND-SPECIAL-3.. Valid values are `^[A-Z0-9-]{2,20}$`',
    `rate_name` STRING COMMENT 'Human-readable name of the rate schedule as published in the tariff. Examples: Residential Time-of-Use Schedule A, Commercial Demand Rate, Industrial Interruptible Service.',
    `rate_schedule_description` STRING COMMENT 'Detailed textual description of the rate schedule, including eligibility criteria, service characteristics, and any special terms or conditions. Sourced from the tariff filing.',
    `rate_schedule_status` STRING COMMENT 'Current lifecycle status of the rate schedule. Active schedules are available for new enrollments and billing. Pending approval schedules await PUC approval. Superseded schedules have been replaced by newer versions. Retired schedules are no longer offered.. Valid values are `active|pending_approval|superseded|retired`',
    `rate_structure_type` STRING COMMENT 'Pricing structure methodology: flat (single rate), tiered (increasing block rates), TOU (Time-of-Use with period-based pricing), CPP (Critical Peak Pricing), demand (based on peak kW), real-time pricing (hourly market-based), or net metering (bidirectional energy credit). [ENUM-REF-CANDIDATE: flat|tiered|tou|cpp|demand|real_time_pricing|net_metering — 7 candidates stripped; promote to reference product]',
    `seasonal_definition` STRING COMMENT 'JSON or delimited string defining seasonal periods and associated rate adjustments. Example: Summer (June-September): base rate + $0.03/kWh; Winter (October-May): base rate. Nullable if seasonal_variation_flag is False.',
    `seasonal_variation_flag` BOOLEAN COMMENT 'Indicates whether this rate schedule has seasonal rate variations (e.g., summer vs. winter rates). True if rates vary by season; False if rates are constant year-round.',
    `special_contract_flag` BOOLEAN COMMENT 'Indicates whether this rate schedule is a special contract rate negotiated individually with a large customer (typically industrial or commercial) rather than a standard tariff rate. True for special contracts; False for standard tariff schedules.',
    `tariff_book_reference` STRING COMMENT 'Reference to the section, schedule, or page number in the published tariff book where this rate schedule is documented. Example: Schedule E-1, Page 12 of Electric Tariff Book.',
    `tier_structure_definition` STRING COMMENT 'JSON or delimited string defining tiered rate blocks for tiered rate structures. Example: Tier 1: 0-500 kWh at $0.10/kWh; Tier 2: 501-1000 kWh at $0.12/kWh; Tier 3: 1001+ kWh at $0.15/kWh. Nullable for non-tiered schedules.',
    `tou_period_definition` STRING COMMENT 'JSON or delimited string defining TOU pricing periods and rates. Example: On-Peak (2pm-8pm weekdays): $0.25/kWh; Off-Peak (all other hours): $0.08/kWh; Super Off-Peak (midnight-6am): $0.05/kWh. Nullable for non-TOU schedules.',
    `version_number` STRING COMMENT 'Sequential version number for this rate schedule. Increments with each tariff revision or rate case modification. Used to track rate schedule evolution over time.',
    `voltage_level` STRING COMMENT 'Voltage level at which service is delivered. Primary (distribution voltage), Secondary (customer voltage), Transmission (high voltage bulk), Sub-Transmission (intermediate voltage). Affects rate level due to cost-of-service differences.. Valid values are `primary|secondary|transmission|sub_transmission`',
    CONSTRAINT pk_rate_schedule PRIMARY KEY(`rate_schedule_id`)
) COMMENT 'Authoritative master catalog of all tariff rate schedules applicable to electric and gas service — TOU, CPP, tiered residential, commercial demand, and special contract rates. Defines rate code, commodity type (electric/gas), customer class (residential/commercial/industrial), effective and expiration dates, regulatory approval reference, rate structure type, and base rate values per tier/period. References applicable rider_charge records for surcharges layered on top of base rates. Sourced from PUC-approved tariff filings and maintained in Oracle CC&B / SAP IS-U rate engine. SSOT for all base rate definitions used in charge calculation. Distinct from rider_charge, which defines regulatory surcharges approved separately from base tariff rates.';

CREATE OR REPLACE TABLE `power_and_utilities`.`billing`.`invoice` (
    `invoice_id` BIGINT COMMENT 'Unique system identifier for the invoice record. Primary key for the invoice entity. Assigned by the billing system (Oracle CC&B or SAP IS-U) upon invoice generation.',
    `account_id` BIGINT COMMENT 'Reference to the customer account for which this invoice was generated. Links to the customer account master in the Customer Information System (CIS).',
    `bill_cycle_id` BIGINT COMMENT 'Foreign key linking to billing.bill_cycle. Business justification: Every invoice is generated as part of a specific billing cycle schedule. This FK allows tracking which cycle generated the invoice and supports operational reporting on billing cycle performance. The ',
    `rate_schedule_id` BIGINT COMMENT 'Code identifying the tariff rate schedule applied to calculate charges on this invoice. Examples include residential TOU (Time-of-Use), CPP (Critical Peak Pricing), tiered rates, commercial demand rates, and industrial interruptible rates. Approved by the Public Utility Commission (PUC).',
    `customer_service_agreement_id` BIGINT COMMENT 'Reference to the service agreement (contract) under which this invoice was issued. A customer account may have multiple service agreements for different service points or commodity types (electric vs gas).',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Revenue recognition requires mapping invoices to GL accounts for posting to general ledger. Core utility billing-to-finance integration for accounts receivable and revenue accounting.',
    `meter_id` BIGINT COMMENT 'FK to metering.meter.meter_id — Essential for billing-to-meter reconciliation — billing disputes and revenue assurance require tracing an invoice back to the specific meter and its interval reads.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: Invoices generated under rates approved in specific rate cases need traceability for revenue requirement validation, true-up calculations, and rate case reconciliation. Real business process: rate cas',
    `bill_period_end_date` DATE COMMENT 'End date of the billing period covered by this invoice. Represents the last day of consumption included in the bill. Typically corresponds to the meter read date.',
    `bill_period_start_date` DATE COMMENT 'Start date of the billing period covered by this invoice. Represents the first day of consumption included in the bill. Aligns with meter read cycle dates.',
    `billing_days` STRING COMMENT 'Number of days in the billing period, calculated as the difference between bill period end date and bill period start date. Used to normalize consumption for comparison across billing cycles of varying lengths.',
    `commodity_type` STRING COMMENT 'Type of utility service billed on this invoice. Electric-only, gas-only, or dual-commodity (combined electric and gas charges on a single invoice).. Valid values are `electric|gas|dual`',
    `consumption_kwh` DECIMAL(18,2) COMMENT 'Total electric energy consumption during the billing period, measured in kWh (Kilowatt-Hours). Derived from meter reads (actual or estimated) from AMI or AMR systems. Null for gas-only invoices.',
    `consumption_therms` DECIMAL(18,2) COMMENT 'Total gas consumption during the billing period, measured in Therms (unit of heat energy for gas billing). One Therm equals 100,000 BTU. Derived from meter reads. Null for electric-only invoices.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the invoice record was first created in the billing system. Used for audit trail and data lineage tracking.',
    `current_charges_amount` DECIMAL(18,2) COMMENT 'Total charges for the current billing period before taxes and regulatory riders. Includes energy charges (kWh or Therm), demand charges (kW or MW), customer charges, and any applicable FAC (Fuel Adjustment Clause) adjustments. Expressed in USD.',
    `customer_charge_amount` DECIMAL(18,2) COMMENT 'Fixed monthly charge for maintaining the customer account and service connection, independent of consumption. Covers meter reading, billing, customer service, and infrastructure maintenance costs. Approved by PUC tariff. Expressed in USD.',
    `delivery_method` STRING COMMENT 'Method by which the invoice was delivered to the customer. Paper invoices are mailed via postal service. Email invoices are sent as PDF attachments. Online portal invoices are available for download through the customer self-service portal.. Valid values are `paper|email|online_portal`',
    `demand_charge_amount` DECIMAL(18,2) COMMENT 'Charges for peak demand during the billing period, applicable to commercial and industrial customers. Based on the highest kW (Kilowatt) or MW (Megawatt) demand recorded during on-peak hours. Not applicable to most residential customers. Expressed in USD.',
    `disconnection_notice_flag` BOOLEAN COMMENT 'Indicates whether a disconnection notice has been issued for this invoice due to non-payment. True if the customer has been notified of pending service disconnection. Disconnection procedures are governed by PUC consumer protection rules.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the customer has disputed this invoice. True if a formal dispute has been filed with customer service or the PUC. Disputed invoices may be placed on hold for collections pending resolution.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for the invoice dispute, as provided by the customer or customer service representative. Common reasons include billing errors, meter read discrepancies, rate application issues, and service quality complaints.',
    `due_date` DATE COMMENT 'Date by which payment must be received to avoid late fees or service disconnection. Calculated based on invoice date plus payment terms (typically 15-21 days).',
    `energy_charge_amount` DECIMAL(18,2) COMMENT 'Charges for energy consumption during the billing period. For electric service, based on kWh (Kilowatt-Hours) consumed. For gas service, based on Therms or MCF (Thousand Cubic Feet) consumed. Calculated by applying the rate schedule energy rate to metered usage. Expressed in USD.',
    `fac_adjustment_amount` DECIMAL(18,2) COMMENT 'Adjustment to energy charges based on fluctuations in fuel costs for generation. FAC (Fuel Adjustment Clause) allows utilities to pass through fuel cost changes without a full rate case. Can be positive (surcharge) or negative (credit). Approved by PUC. Expressed in USD.',
    `gl_posting_date` DATE COMMENT 'Date the invoice was posted to the general ledger in the ERP system (SAP S/4HANA or Oracle ERP Cloud). Used for financial period closing and reconciliation between the CIS and ERP systems.',
    `invoice_date` DATE COMMENT 'Date the invoice was generated by the billing system. Used as the official invoice issuance date for revenue recognition and aging calculations.',
    `invoice_number` STRING COMMENT 'Human-readable, externally-visible invoice number printed on the customer bill. Unique within the billing system and used for customer inquiries, payment references, and dispute resolution.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the invoice. Tracks progression from generation through payment or write-off. Disputed status triggers collections workflow. Cancelled status applies to voided or reversed invoices. [ENUM-REF-CANDIDATE: generated|issued|mailed|paid|partially_paid|disputed|written_off|cancelled — 8 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice based on billing cycle context. Regular invoices are standard monthly/bi-monthly bills. Final invoices are issued upon account closure or move-out. Adjustment invoices correct prior billing errors. Estimated invoices are issued when actual meter reads are unavailable. Corrected invoices replace previously issued invoices.. Valid values are `regular|final|adjustment|estimated|corrected`',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Late payment fee assessed if payment is not received by the due date. Late fee rates and grace periods are defined in the PUC-approved tariff. Expressed in USD.',
    `meter_read_type` STRING COMMENT 'Indicates whether the invoice is based on an actual meter read from AMI (Advanced Metering Infrastructure) or AMR (Automated Meter Reading), an estimated read due to meter access issues, or a customer-provided read.. Valid values are `actual|estimated|customer_read`',
    `outstanding_balance_amount` DECIMAL(18,2) COMMENT 'Remaining unpaid balance on this invoice, calculated as total amount due minus payment received amount. Used for aging analysis and collections prioritization. Expressed in USD.',
    `payment_plan_flag` BOOLEAN COMMENT 'Indicates whether this invoice is part of a payment plan or installment agreement. True if the customer has arranged to pay the balance over multiple billing cycles. Payment plans are offered to customers facing financial hardship.',
    `payment_received_amount` DECIMAL(18,2) COMMENT 'Total payments received and applied to this invoice as of the current date. Updated as payments are posted from various channels (online, mail, phone, in-person). Expressed in USD.',
    `peak_demand_kw` DECIMAL(18,2) COMMENT 'Maximum electric demand recorded during the billing period, measured in kW (Kilowatts). Used to calculate demand charges for commercial and industrial customers. Captured from interval meter data (AMI). Null for residential customers without demand metering.',
    `previous_balance_amount` DECIMAL(18,2) COMMENT 'Outstanding balance carried forward from prior billing cycles. Includes unpaid charges, late fees, and any credits or adjustments from previous invoices. Expressed in USD.',
    `print_date` DATE COMMENT 'Date the invoice was printed or electronically delivered to the customer. May differ from invoice date if batch printing or electronic delivery is delayed.',
    `regulatory_rider_amount` DECIMAL(18,2) COMMENT 'Total charges or credits from regulatory riders approved by the PUC. Riders recover specific costs such as renewable energy programs (RPS - Renewable Portfolio Standard), energy efficiency (EE) programs, demand response (DR) programs, environmental compliance, and infrastructure investments. Expressed in USD.',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue from this invoice is recognized in the general ledger for GAAP financial reporting. Typically the invoice date or the bill period end date, depending on the utilitys revenue recognition policy.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total taxes applied to the invoice, including state sales tax, local utility taxes, franchise fees, and any other government-mandated taxes. Tax rates and applicability vary by jurisdiction and customer class. Expressed in USD.',
    `total_amount_due` DECIMAL(18,2) COMMENT 'Total amount the customer must pay, calculated as previous balance plus current charges plus taxes plus regulatory riders. This is the net amount due printed on the invoice. Expressed in USD.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the invoice record was last modified. Updated when invoice status changes, payments are applied, or adjustments are made. Used for audit trail and change tracking.',
    CONSTRAINT pk_invoice PRIMARY KEY(`invoice_id`)
) COMMENT 'Core billing document representing a single billing cycle statement issued to a customer account for electric and/or gas service. Captures bill period start/end dates, due date, total amount due, prior balance, current charges, taxes, regulatory riders, and net amount. Tracks invoice status (generated, mailed, paid, disputed, written-off). Links to the rate schedule applied, service agreement, and meter read period. Generated from Oracle CC&B / SAP IS-U billing engine and posted to SAP S/4HANA or Oracle ERP for GAAP revenue recognition. SSOT for all customer billing documents.';

CREATE OR REPLACE TABLE `power_and_utilities`.`billing`.`invoice_line` (
    `invoice_line_id` BIGINT COMMENT 'Unique system-generated identifier for each invoice line item. Primary key for the invoice line product.',
    `rate_schedule_id` BIGINT COMMENT 'Tariff rate schedule code applied to calculate this charge. References the approved rate structure filed with the Public Utility Commission (PUC). Examples: RES-1 (Residential Service), COM-2 (Small Commercial), IND-3 (Large Industrial), TOU-A (Time-of-Use Schedule A). Critical for rate case cost studies and regulatory compliance.',
    `invoice_id` BIGINT COMMENT 'Foreign key reference to the parent invoice header. Links this line item to the billing invoice document generated by Oracle CC&B or SAP IS-U.',
    `meter_id` BIGINT COMMENT 'Foreign key reference to the meter or Advanced Metering Infrastructure (AMI) endpoint that recorded the consumption data used to calculate this charge. Links billing charges back to metered usage data in the Meter Data Management System (MDMS). Null for non-metered charges such as fixed customer charges, taxes, or credits.',
    `ppa_contract_id` BIGINT COMMENT 'Foreign key linking to market.ppa_contract. Business justification: When utilities pass through PPA costs via specific line items (renewable energy charges, contract capacity charges), the invoice line must reference the source contract for regulatory compliance, cost',
    `service_point_id` BIGINT COMMENT 'Foreign key reference to the service point (delivery location) where the utility service is provided. Links the charge to the physical location on the distribution network. Critical for geographic revenue analysis and outage correlation.',
    `adjustment_reason_code` STRING COMMENT 'Reason code for billing adjustments or credits. BILLING_ERROR (correction of calculation error), METER_ADJUSTMENT (meter read correction or estimation adjustment), PAYMENT_REVERSAL (reversal of payment or credit), DISPUTE_RESOLUTION (customer dispute settlement), RATE_CHANGE (retroactive rate adjustment), PRORATION (partial period adjustment for move-in/move-out), LATE_FEE_WAIVER (penalty waiver), GOODWILL_CREDIT (customer service credit), OTHER (miscellaneous adjustments). Null for standard charges. Supports customer dispute tracking and audit trail requirements. [ENUM-REF-CANDIDATE: BILLING_ERROR|METER_ADJUSTMENT|PAYMENT_REVERSAL|DISPUTE_RESOLUTION|RATE_CHANGE|PRORATION|LATE_FEE_WAIVER|GOODWILL_CREDIT|OTHER — 9 candidates stripped; promote to reference product]',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period for which this charge applies. Defines the conclusion of the consumption or service period being billed. Format: yyyy-MM-dd.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period for which this charge applies. Defines the beginning of the consumption or service period being billed. Format: yyyy-MM-dd.',
    `charge_description` STRING COMMENT 'Human-readable description of the charge line item as it appears on the customer invoice. Provides detailed explanation of the charge component, rate schedule tier, Time-of-Use (TOU) period, or regulatory rider being applied. Examples: Residential Electric Service - Summer On-Peak Energy, Natural Gas Distribution Charge, Renewable Energy Surcharge, State Sales Tax.',
    `charge_type_code` STRING COMMENT 'Classification code identifying the nature of the billable charge. Common values include ENERGY (consumption charges in kWh or MCF), DEMAND (peak kW charges), CUSTOMER (fixed monthly service charge), DISTRIBUTION (delivery charges), TRANSMISSION (bulk transport charges), FAC (Fuel Adjustment Clause rider), CIAC (Contribution in Aid of Construction recovery), RPS (Renewable Portfolio Standard surcharge), TAX (sales tax, utility tax), CREDIT (bill adjustments, payment credits), LATE_FEE (penalty charges), RECONNECT (service restoration fee), DEPOSIT (security deposit), and OTHER (miscellaneous charges). [ENUM-REF-CANDIDATE: ENERGY|DEMAND|CUSTOMER|DISTRIBUTION|TRANSMISSION|FAC|CIAC|RPS|TAX|CREDIT|LATE_FEE|RECONNECT|DEPOSIT|OTHER — 14 candidates stripped; promote to reference product]',
    `cost_center_code` STRING COMMENT 'Cost center or profit center code for internal management accounting. Identifies the business unit, operating division, or service territory responsible for this revenue line. Supports Operations and Maintenance (O&M) cost allocation, performance-based ratemaking (PBR) analysis, and internal profitability reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was first created in the billing system. Represents the initial insertion into Oracle CC&B, SAP IS-U, or the data warehouse. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and data lineage.',
    `disputed_flag` BOOLEAN COMMENT 'Indicates whether this invoice line is under customer dispute. True if the customer has formally disputed this charge through the Customer Information System (CIS) or Customer Relationship Management (CRM) system. False if not disputed. Disputed charges may be held from collections pending resolution. Supports dispute management and regulatory compliance with customer rights provisions.',
    `gl_account_code` STRING COMMENT 'General Ledger account code for revenue recognition in the Enterprise Resource Planning (ERP) system (SAP S/4HANA or Oracle ERP Cloud). Maps the invoice line charge to the appropriate revenue account in the FERC Uniform System of Accounts chart of accounts. Examples: 440 (Electric Operating Revenues - Residential), 480 (Gas Operating Revenues - Commercial). Critical for financial close, GAAP revenue reporting, and regulatory compliance.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this invoice line record was last modified. Captures adjustments, corrections, or dispute resolution updates. Format: yyyy-MM-ddTHH:mm:ss.SSSXXX. Supports audit trail and change tracking.',
    `line_amount` DECIMAL(18,2) COMMENT 'Extended charge amount for this invoice line. Calculated as usage_quantity multiplied by unit_rate, or a fixed amount for non-usage-based charges. Represents the pre-tax charge value. Positive values indicate charges; negative values indicate credits or adjustments. Expressed in the invoice currency (typically USD for U.S. utilities).',
    `line_number` STRING COMMENT 'Sequential line number within the invoice. Determines the display order of charges on the customer bill. Typically starts at 1 and increments for each charge component.',
    `print_sequence` STRING COMMENT 'Display sequence number for printing this line on the customer invoice. Determines the order in which charges appear on the bill. Typically groups charges by type (energy, demand, fixed, taxes) and sorts within groups. Supports customer bill presentation and readability.',
    `proration_factor` DECIMAL(18,2) COMMENT 'Proration factor applied to calculate partial-period charges for move-in, move-out, or mid-cycle rate changes. Expressed as a decimal between 0 and 1 representing the fraction of the billing period for which the charge applies. Example: 0.5000 for a half-month charge. Null for full-period charges. Ensures accurate billing for partial service periods.',
    `rate_component_code` STRING COMMENT 'Specific component within the rate schedule being applied. Identifies the tier, block, or Time-of-Use (TOU) period for tiered or time-differentiated rates. Examples: TIER1 (first 500 kWh), TIER2 (501-1000 kWh), ON_PEAK (summer on-peak hours), OFF_PEAK (off-peak hours), SHOULDER (shoulder period). Enables granular revenue analysis by rate structure element.',
    `regulatory_rider_code` STRING COMMENT 'Code identifying the regulatory rider or surcharge applied to this line. Riders are PUC-approved rate adjustments for specific cost recovery mechanisms. Examples: FAC (Fuel Adjustment Clause for fuel cost pass-through), DSM (Demand-Side Management program cost recovery), RPS (Renewable Portfolio Standard compliance surcharge), CIAC (Contribution in Aid of Construction recovery), PBR (Performance-Based Ratemaking adjustment). Null if no rider applies. Critical for regulatory reporting and rate case reconciliation.',
    `revenue_class_code` STRING COMMENT 'Customer class or revenue category for regulatory reporting. RESIDENTIAL (single-family and multi-family homes), COMMERCIAL (small and medium businesses), INDUSTRIAL (large manufacturing and industrial customers), STREET_LIGHTING (municipal street and highway lighting), PUBLIC_AUTHORITY (government and public institutions), WHOLESALE (sales to other utilities or power marketers). Aligns with FERC Form 1 and state PUC reporting requirements.. Valid values are `RESIDENTIAL|COMMERCIAL|INDUSTRIAL|STREET_LIGHTING|PUBLIC_AUTHORITY|WHOLESALE`',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue for this invoice line is recognized in the General Ledger under GAAP ASC 606 (Revenue from Contracts with Customers). Typically the invoice date or service delivery date. Critical for financial close, revenue accrual, and GAAP compliance. Format: yyyy-MM-dd.',
    `service_type` STRING COMMENT 'Type of utility service being billed on this line. ELECTRIC for electric service charges (kWh, kW), GAS for natural gas service charges (MCF, Therm). Enables revenue decomposition by commodity type for regulatory reporting to PUCs and FERC.. Valid values are `ELECTRIC|GAS`',
    `source_system_code` STRING COMMENT 'Code identifying the operational system of record that generated this invoice line. CC&B (Oracle Customer Care and Billing), IS-U (SAP Industry Solution for Utilities), MDMS (Meter Data Management System for interval data charges), ERP (Enterprise Resource Planning for manual adjustments), MANUAL (manually entered adjustments). Supports data lineage, audit trail, and system integration reconciliation.. Valid values are `CC&B|IS-U|MDMS|ERP|MANUAL`',
    `source_transaction_reference` STRING COMMENT 'Unique transaction identifier from the source system (Oracle CC&B, SAP IS-U, or MDMS) that generated this invoice line. Enables traceability back to the originating billing calculation or charge engine transaction. Supports audit trail, dispute resolution, and system integration reconciliation.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applied to this invoice line. Includes sales tax, utility tax, franchise fees, or other regulatory taxes. Calculated based on applicable tax rates and jurisdictional rules. Null if the line item is non-taxable or represents a tax charge itself. Supports tax reporting and revenue recognition under GAAP.',
    `taxable_flag` BOOLEAN COMMENT 'Indicates whether this invoice line is subject to sales tax or utility tax. True if taxable, False if exempt. Determines whether tax_amount is calculated for this line. Tax exemption rules vary by jurisdiction, customer class, and charge type. Supports tax compliance and reporting.',
    `total_line_amount` DECIMAL(18,2) COMMENT 'Total amount for this invoice line including taxes. Calculated as line_amount plus tax_amount. Represents the final charge or credit amount for this line item. Positive values indicate charges; negative values indicate credits. Expressed in the invoice currency.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the usage quantity. KWH (kilowatt-hour) for electric energy consumption, MWH (megawatt-hour) for large commercial/industrial energy, KW (kilowatt) for electric demand, MW (megawatt) for large demand, MCF (thousand cubic feet) for natural gas volume, THERM (unit of heat energy) for gas billing, EACH for count-based charges (e.g., number of reconnections), PERCENT for percentage-based adjustments. [ENUM-REF-CANDIDATE: KWH|MWH|KW|MW|MCF|THERM|EACH|PERCENT — 8 candidates stripped; promote to reference product]',
    `unit_rate` DECIMAL(18,2) COMMENT 'Rate per unit of measure applied to calculate the charge amount. Expressed in currency per unit (e.g., dollars per kWh, dollars per MCF, dollars per kW). Derived from the approved tariff rate schedule filed with the PUC. Null for fixed charges or lump-sum adjustments. Critical for rate case analysis and revenue reconciliation.',
    `usage_quantity` DECIMAL(18,2) COMMENT 'Quantity of utility service consumed or delivered during the billing period. For energy charges, represents kilowatt-hours (kWh), Megawatt-hours (MWh), thousand cubic feet (MCF), or Therms. For demand charges, represents peak kilowatts (kW) or Megawatts (MW). Null for fixed charges, taxes, or credits that are not usage-based. Sourced from MDMS interval data aggregation or Automated Meter Reading (AMR) systems.',
    CONSTRAINT pk_invoice_line PRIMARY KEY(`invoice_line_id`)
) COMMENT 'Itemized charge line within a customer invoice representing a single billable component — energy consumption charges (kWh, MCF, Therm), demand charges (kW), fixed customer charges, distribution rider, FAC adjustment, CIAC recovery, RPS surcharge, taxes, or credits. Captures charge type code, unit of measure, quantity, unit rate, extended amount, and applicable rate schedule tier or TOU period. Enables granular revenue decomposition by charge category for regulatory reporting and customer dispute resolution. Sourced from Oracle CC&B / SAP IS-U charge calculation engine.';

CREATE OR REPLACE TABLE `power_and_utilities`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'Unique system-generated identifier for the payment transaction record. Primary key for the payment entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account against which this payment is applied. Links payment to the billing account in the Customer Information System (CIS).',
    `collections_case_id` BIGINT COMMENT 'Foreign key linking to billing.collections_case. Business justification: When a customer makes a payment on a delinquent account that is under active collections, that payment must be linked to the collections case to track total_recovered_amount, update case status, and s',
    `invoice_id` BIGINT COMMENT 'Reference to the specific bill or invoice that this payment is intended to satisfy. May be null for advance payments or account credits.',
    `payment_arrangement_id` BIGINT COMMENT 'Foreign key linking to billing.payment_arrangement. Business justification: When a customer makes an installment payment under a deferred payment plan, that payment must be linked to the arrangement to track compliance, count installments paid, and update remaining balance. T',
    `allocation_method` STRING COMMENT 'Business rule or algorithm used to allocate the payment amount across multiple outstanding bills or charges on the customer account. Common methods include First-In-First-Out (FIFO), Last-In-First-Out (LIFO), pro-rata distribution, or customer-directed allocation.. Valid values are `fifo|lifo|pro_rata|customer_directed|oldest_first`',
    `amount` DECIMAL(18,2) COMMENT 'Total monetary value of the payment transaction in the utilitys functional currency. Represents the gross amount tendered by the customer before any adjustments or fees.',
    `applied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that was successfully applied to reduce the customer account balance. May differ from payment_amount if payment was partially applied, held in suspense, or subject to fees.',
    `auto_pay_flag` BOOLEAN COMMENT 'Boolean indicator denoting whether this payment was automatically initiated through a recurring payment arrangement (auto-pay or budget billing). True if auto-pay, False if manually submitted by customer.',
    `bank_account_number_last_four` STRING COMMENT 'Last four digits of the customers bank account number, stored for customer service reference and payment verification. Full account number is tokenized and stored in secure vault per PCI DSS requirements.. Valid values are `^[0-9]{4}$`',
    `bank_routing_number` STRING COMMENT 'Nine-digit American Bankers Association (ABA) routing transit number identifying the financial institution for ACH or EFT payments. Confidential financial data subject to PCI DSS controls.. Valid values are `^[0-9]{9}$`',
    `batch_reference` STRING COMMENT 'Identifier for the payment processing batch or lockbox deposit in which this payment was grouped for posting and reconciliation. Used for audit trail and batch balancing.',
    `budget_billing_flag` BOOLEAN COMMENT 'Boolean indicator denoting whether this payment is part of a budget billing or levelized payment plan, where the customer pays a fixed monthly amount based on projected annual usage. True if budget billing installment, False otherwise.',
    `channel` STRING COMMENT 'The customer-facing interface or channel through which the payment was submitted. Includes web portal, mobile application, Interactive Voice Response (IVR) system, walk-in payment center, mail, lockbox, third-party payment agency, or automated recurring payment (auto-pay). [ENUM-REF-CANDIDATE: web_portal|mobile_app|ivr|walk_in|mail|lockbox|third_party_agency|auto_pay — 8 candidates stripped; promote to reference product]',
    `check_number` STRING COMMENT 'The sequential number printed on the customers check. Captured for check payments to support reconciliation and returned check processing. Null for non-check payment methods.. Valid values are `^[0-9]{1,10}$`',
    `cleared_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was confirmed as cleared by the financial institution or payment processor. Applicable to checks, ACH, and credit card transactions. Null for cash payments.',
    `confirmation_number` STRING COMMENT 'Externally visible confirmation or receipt number provided to the customer upon successful payment submission. Used for customer service inquiries and dispute resolution.. Valid values are `^[A-Z0-9]{8,20}$`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this payment record was first inserted into the data platform. Used for data lineage and audit trail purposes.',
    `credit_card_last_four` STRING COMMENT 'Last four digits of the customers credit or debit card number, retained for customer service and dispute resolution. Full card number is tokenized per PCI DSS requirements and not stored in this system.. Valid values are `^[0-9]{4}$`',
    `credit_card_type` STRING COMMENT 'Brand or network of the credit or debit card used for payment. Common values include Visa, MasterCard, American Express, and Discover.. Valid values are `visa|mastercard|amex|discover`',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code indicating the currency in which the payment was tendered. Typically USD for U.S. utilities; supports multi-currency operations for international utilities.. Valid values are `^[A-Z]{3}$`',
    `gl_account_code` STRING COMMENT 'The General Ledger account code to which the payment revenue was posted in the Enterprise Resource Planning (ERP) system. Aligns with the utilitys chart of accounts and FERC Uniform System of Accounts.. Valid values are `^[0-9]{4,10}$`',
    `gl_posting_date` DATE COMMENT 'The accounting period date on which the payment transaction was posted to the General Ledger (GL) for financial reporting and revenue recognition. May differ from payment_date due to batch processing or period-end cutoffs.',
    `method_type` STRING COMMENT 'The financial instrument or tender type used by the customer to remit payment. Distinguishes between check, electronic funds transfer (EFT), Automated Clearing House (ACH), credit card, debit card, cash, or money order. [ENUM-REF-CANDIDATE: check|ach|eft|credit_card|debit_card|cash|money_order — 7 candidates stripped; promote to reference product]',
    `notes` STRING COMMENT 'Free-text field for customer service representatives or payment processors to record additional context, special handling instructions, or dispute details related to the payment transaction.',
    `nsf_fee_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed to the customer account when a payment is returned due to Non-Sufficient Funds. Fee amount is governed by tariff and Public Utility Commission (PUC) regulations. Null if no NSF fee applies.',
    `payment_date` DATE COMMENT 'The business date on which the payment was received or initiated by the customer. This is the authoritative date for revenue recognition and aging calculations, distinct from posting or clearing dates.',
    `payment_status` STRING COMMENT 'Current lifecycle state of the payment transaction. Tracks progression from initial receipt through posting to general ledger, including exception states such as NSF (Non-Sufficient Funds) returns or reversals. [ENUM-REF-CANDIDATE: received|posted|cleared|returned|reversed|pending|failed — 7 candidates stripped; promote to reference product]',
    `posted_timestamp` TIMESTAMP COMMENT 'Date and time when the payment was successfully posted to the customer account balance and general ledger. Null if payment has not yet been posted.',
    `processor_name` STRING COMMENT 'Name of the third-party payment processor or financial institution that handled the electronic payment transaction. Applicable to credit card, ACH, and EFT payments.',
    `processor_transaction_reference` STRING COMMENT 'Unique transaction identifier assigned by the external payment processor or gateway. Used for reconciliation, dispute resolution, and chargeback processing.',
    `received_timestamp` TIMESTAMP COMMENT 'Precise date and time when the payment transaction was received by the utility system, including time zone offset. Used for audit trail and SLA compliance tracking.',
    `reversal_date` DATE COMMENT 'Business date on which the payment was reversed or returned by the financial institution or payment processor. Null if payment has not been reversed.',
    `reversal_reason` STRING COMMENT 'Free-text or coded explanation for why a payment was reversed or returned. Common reasons include Non-Sufficient Funds (NSF), account closed, stop payment, unauthorized transaction, or administrative error. Null if payment has not been reversed.',
    `source_system` STRING COMMENT 'Name or identifier of the originating system or application that captured and transmitted the payment transaction. Examples include Oracle CC&B, SAP IS-U, third-party payment gateway, or lockbox processor.',
    `third_party_agency_name` STRING COMMENT 'Name of the external agency or authorized payment location that accepted the payment on behalf of the utility. Examples include retail payment centers, community action agencies, or government assistance programs. Null for direct payments.',
    `token` STRING COMMENT 'Tokenized representation of sensitive payment instrument data (credit card number, bank account number) issued by the payment processor or tokenization service. Used for recurring payments and PCI DSS compliance.',
    `unapplied_amount` DECIMAL(18,2) COMMENT 'The portion of the payment amount that remains unapplied or held in suspense, typically due to account discrepancies, overpayment, or pending dispute resolution. Zero if payment is fully applied.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp indicating when this payment record was last modified in the data platform. Used for change data capture and audit trail purposes.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of a financial payment transaction applied against a customer account balance — check, ACH/EFT, credit card, cash, auto-pay, budget billing installment, or third-party agency payment. Captures payment date, amount, payment method type, tender type, confirmation number, processing status (received, posted, returned/NSF, reversed), and source channel (web portal, IVR, walk-in, lockbox). Integrates with SAP S/4HANA or Oracle ERP for cash receipts posting and GAAP revenue recognition. SSOT for all customer payment transactions.';

CREATE OR REPLACE TABLE `power_and_utilities`.`billing`.`payment_arrangement` (
    `payment_arrangement_id` BIGINT COMMENT 'Unique system identifier for the payment arrangement record. Primary key.',
    `account_id` BIGINT COMMENT 'Reference to the customer account for which this payment arrangement was established. Links to the billing account in Oracle CC&B or SAP IS-U.',
    `collections_action_id` BIGINT COMMENT 'Reference to the collections action or case that prompted this payment arrangement. Null if arrangement was proactively requested by customer rather than initiated through collections workflow.',
    `actual_completion_date` DATE COMMENT 'Actual date when the arrangement was fully satisfied and all deferred amounts paid. Null if arrangement is still active, broken, or cancelled. May differ from arrangement_end_date if customer paid early or late.',
    `approval_date` DATE COMMENT 'Date when the payment arrangement was formally approved by the utility. May differ from arrangement_start_date if down payment is required before activation.',
    `approved_by_user_code` STRING COMMENT 'User ID of the customer service representative, supervisor, or automated system that approved the payment arrangement. Used for audit trail and quality assurance.',
    `arrangement_end_date` DATE COMMENT 'Scheduled date when the final installment is due and the arrangement is expected to be completed. Calculated from start date plus (number_of_installments * installment_frequency).',
    `arrangement_notes` STRING COMMENT 'Free-text field for customer service representatives to document special terms, customer circumstances, or other contextual information relevant to the arrangement. Not displayed to customer.',
    `arrangement_number` STRING COMMENT 'Externally visible unique business identifier for the payment arrangement, typically displayed on customer correspondence and used in customer service interactions.. Valid values are `^PA-[0-9]{8,12}$`',
    `arrangement_start_date` DATE COMMENT 'Effective date when the payment arrangement becomes active and the first installment is due. Typically the date down payment is received or arrangement is approved.',
    `arrangement_status` STRING COMMENT 'Current lifecycle state of the payment arrangement. Pending: awaiting approval or down payment. Active: in good standing with payments current. Broken: customer missed payment(s) per terms. Completed: all installments paid. Cancelled: arrangement terminated by utility or customer. Suspended: temporarily paused.. Valid values are `pending|active|broken|completed|cancelled|suspended`',
    `arrangement_type` STRING COMMENT 'Classification of the payment arrangement plan. Budget billing spreads annual costs evenly; levelized payment smooths seasonal variation; low-income assistance provides subsidized payment terms; collections installment addresses past-due balances; deferred payment postpones a portion of charges; custom represents negotiated terms.. Valid values are `budget_billing|levelized_payment|low_income_assistance|collections_installment|deferred_payment|custom`',
    `auto_pay_enrolled` BOOLEAN COMMENT 'Indicates whether the customer has enrolled in automatic payment for installments via bank draft or credit card. Auto-pay enrollment often reduces the risk of arrangement default.',
    `broken_date` DATE COMMENT 'Date when the arrangement was marked as broken due to non-compliance with payment terms. Triggers collections workflow and potential service disconnection per tariff rules.',
    `cancellation_reason` STRING COMMENT 'Reason code explaining why the arrangement was cancelled before completion. Used for reporting and policy analysis.. Valid values are `customer_request|account_closed|service_disconnected|refinanced|policy_violation|administrative`',
    `cancelled_date` DATE COMMENT 'Date when the arrangement was cancelled by the utility or customer before completion. Remaining balance typically becomes immediately due.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the payment arrangement record was first created in Oracle CC&B or SAP IS-U. Used for audit trail and data lineage.',
    `down_payment_amount` DECIMAL(18,2) COMMENT 'Initial payment required to establish the arrangement, typically a percentage of the total deferred amount as mandated by state Public Utility Commission (PUC) rules or utility policy. Expressed in USD.',
    `grace_period_days` STRING COMMENT 'Number of days after installment due date before a missed payment is counted against the arrangement. Typically 5-15 days per utility policy or PUC regulation.',
    `installment_amount` DECIMAL(18,2) COMMENT 'Fixed amount due per installment period, calculated as (total_deferred_amount - down_payment_amount) / number_of_installments. May be adjusted for final installment to account for rounding. Expressed in USD.',
    `installment_frequency` STRING COMMENT 'Cadence at which installment payments are due. Monthly is most common for residential customers; other frequencies may be used for commercial accounts or special assistance programs.. Valid values are `weekly|biweekly|monthly|quarterly`',
    `installments_missed` STRING COMMENT 'Count of scheduled installment payments that were not received by the due date. Exceeding the allowed threshold (typically 1-2 missed payments) triggers arrangement_status transition to broken.',
    `installments_paid` STRING COMMENT 'Count of installment payments successfully received and applied to the arrangement. Used to track compliance with payment schedule.',
    `interest_accrued` DECIMAL(18,2) COMMENT 'Total interest charges accrued on the deferred balance to date. Zero if interest_rate is zero. Expressed in USD.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the deferred balance, if any. Expressed as a decimal (e.g., 0.0500 for 5%). Many jurisdictions prohibit interest on residential payment arrangements; commercial arrangements may include interest per tariff.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when the payment arrangement record was last updated. Tracks changes to status, payments applied, or other arrangement attributes.',
    `next_installment_due_date` DATE COMMENT 'Date when the next scheduled installment payment is due. Updated after each payment is received. Null when arrangement is completed, broken, or cancelled.',
    `notification_preference` STRING COMMENT 'Customers preferred channel for receiving payment reminders and arrangement status notifications. Used by Customer Information System (CIS) to trigger communications.. Valid values are `email|sms|mail|phone|none`',
    `number_of_installments` STRING COMMENT 'Total count of scheduled installment payments over the life of the arrangement. Typically ranges from 3 to 24 months depending on arrangement type and regulatory constraints.',
    `program_code` STRING COMMENT 'Code identifying the low-income assistance program, demand-side management (DSM) program, or special rate program under which this arrangement was established. Examples: LIHEAP, CARE, FERA. Null for standard arrangements.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Current outstanding balance under the arrangement after applying all payments received to date. Decreases with each installment payment. Zero when arrangement is completed. Expressed in USD.',
    `total_deferred_amount` DECIMAL(18,2) COMMENT 'Total outstanding balance being deferred under this arrangement at the time of establishment, including principal charges, late fees, and any applicable interest. Expressed in USD.',
    CONSTRAINT pk_payment_arrangement PRIMARY KEY(`payment_arrangement_id`)
) COMMENT 'Formal deferred payment plan or installment agreement established for a customer account with past-due balance — budget billing plan, levelized payment plan, low-income assistance plan, or collections payment arrangement. Captures arrangement type, total deferred amount, number of installments, installment amount, start date, end date, down payment amount, arrangement status (active, broken, completed, cancelled), and associated collections action. Tracks compliance with arrangement terms to support collections workflow in Oracle CC&B / SAP IS-U. Distinct from a single payment transaction — represents an ongoing multi-period commitment.';

CREATE OR REPLACE TABLE `power_and_utilities`.`billing`.`collections_case` (
    `collections_case_id` BIGINT COMMENT 'Unique identifier for the collections case record. Primary key for tracking the full lifecycle of a delinquent account from initial past-due notice through resolution.',
    `account_id` BIGINT COMMENT 'Reference to the customer account under collections. Links to the CIS account master record in Oracle CC&B or SAP IS-U.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Collections practices are governed by regulatory obligations (disconnection notice requirements, moratorium rules, low-income protections). Real business process: regulatory collections compliance and',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Write-offs and bad debt expense from collections cases must post to GL allowance for doubtful accounts. Required for accurate AR valuation and expense recognition.',
    `party_id` BIGINT COMMENT 'Reference to the customer entity associated with the delinquent account. Links to customer master data.',
    `payment_arrangement_id` BIGINT COMMENT 'Reference to the payment arrangement or installment plan established for this collections case. Links to payment arrangement master record.',
    `actual_disconnect_date` DATE COMMENT 'Date when service was physically disconnected by field crews. Marks the point where customer loses electric or gas service.',
    `agency_referral_date` DATE COMMENT 'Date when the delinquent account was referred to an external collections agency for third-party debt recovery.',
    `assigned_collections_agent` STRING COMMENT 'Name or identifier of the internal collections agent responsible for managing this case. Used for workload balancing and performance tracking.',
    `bankruptcy_case_number` STRING COMMENT 'Court-assigned bankruptcy case number. Used for tracking bankruptcy proceedings and proof of claim filings.',
    `bankruptcy_filing_date` DATE COMMENT 'Date when the customer filed for bankruptcy. Triggers automatic stay of collections activity per federal bankruptcy law.',
    `bankruptcy_flag` BOOLEAN COMMENT 'Indicates whether the customer has filed for bankruptcy protection. True if bankruptcy filing has been recorded, which typically suspends collections activity.',
    `case_closed_date` DATE COMMENT 'Date when the collections case was closed. Populated upon successful payment, write-off, or other resolution outcome.',
    `case_number` STRING COMMENT 'Business-facing unique identifier for the collections case. Used in customer communications, agent tracking, and external collections agency referrals.',
    `case_opened_date` DATE COMMENT 'Date when the collections case was first opened. Typically triggered when an account becomes past due beyond the grace period threshold.',
    `case_status` STRING COMMENT 'Current lifecycle status of the collections case. Tracks progression from initial dunning through final resolution or write-off. [ENUM-REF-CANDIDATE: open|pending_payment|payment_arrangement|field_collection|agency_referral|legal_action|suspended|closed|written_off|bankruptcy — 10 candidates stripped; promote to reference product]',
    `collections_agency_name` STRING COMMENT 'Name of the external collections agency assigned to recover the debt. Used for tracking agency performance and commission calculations.',
    `collections_cost` DECIMAL(18,2) COMMENT 'Total cost incurred for collections activity including agency fees, legal fees, and internal labor. Used for cost-benefit analysis of collections efforts. Denominated in USD.',
    `collections_stage` STRING COMMENT 'Current escalation stage in the collections process. Defines the severity level and action type being pursued for debt recovery.. Valid values are `dunning_notice|disconnect_warning|field_disconnect_order|collections_agency|legal_collections|write_off`',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the collections case record was first created in the database. Used for audit trail and data lineage tracking.',
    `customer_contact_email` STRING COMMENT 'Primary email address for collections correspondence. Used for electronic dunning notices and payment reminders.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `customer_contact_phone` STRING COMMENT 'Primary phone number for contacting the customer regarding collections. Used by collections agents for outbound calling campaigns.',
    `days_past_due` STRING COMMENT 'Number of days the account balance has been overdue. Calculated from the original invoice due date to the current date or case closure date.',
    `disconnect_order_date` DATE COMMENT 'Date when a field disconnect order was issued to terminate service for non-payment. Triggers field crew dispatch for physical disconnection.',
    `disconnect_warning_sent_date` DATE COMMENT 'Date when the service disconnection warning notice was sent. Escalated collections action notifying customer of imminent service termination.',
    `dunning_notice_sent_date` DATE COMMENT 'Date when the initial past-due notice was sent to the customer. First formal collections communication in the escalation process.',
    `last_contact_date` DATE COMMENT 'Date of the most recent contact attempt with the customer. Used to track collections agent activity and ensure compliance with contact frequency regulations.',
    `last_contact_method` STRING COMMENT 'Communication channel used for the most recent customer contact. Tracks effectiveness of different outreach methods.. Valid values are `phone|email|mail|in_person|sms`',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment received. Helps evaluate partial payment patterns and customer financial capacity. Denominated in USD.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received on the delinquent account. Used to assess customer payment behavior and willingness to pay.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'System timestamp when the collections case record was most recently modified. Used for change tracking and data synchronization.',
    `legal_action_date` DATE COMMENT 'Date when legal proceedings were initiated for debt recovery. Marks escalation to court filings, liens, or judgments.',
    `legal_action_flag` BOOLEAN COMMENT 'Indicates whether legal action has been initiated to recover the debt. True if case has been escalated to legal collections or court proceedings.',
    `notes` STRING COMMENT 'Free-text notes documenting collections activity, customer interactions, payment commitments, and case-specific details. Used by collections agents for case management.',
    `original_debt_amount` DECIMAL(18,2) COMMENT 'Initial past-due balance at the time the collections case was opened. Used to track debt reduction progress and recovery rate. Denominated in USD.',
    `past_due_amount` DECIMAL(18,2) COMMENT 'Total outstanding balance that is past due and subject to collections activity. Includes principal charges, late fees, and accrued interest. Denominated in USD for single-currency utility operations.',
    `payment_arrangement_flag` BOOLEAN COMMENT 'Indicates whether the customer has entered into a payment arrangement or installment plan to resolve the debt. True if active arrangement exists.',
    `resolution_outcome` STRING COMMENT 'Final outcome of the collections case. Captures how the delinquency was resolved for performance tracking and recovery rate analysis. [ENUM-REF-CANDIDATE: paid_in_full|payment_arrangement|partial_payment|written_off|bankruptcy_discharge|account_transferred|other — 7 candidates stripped; promote to reference product]',
    `service_type` STRING COMMENT 'Type of utility service associated with the delinquent account. Indicates whether collections case is for electric, gas, or combined service.. Valid values are `electric|gas|electric_and_gas`',
    `total_recovered_amount` DECIMAL(18,2) COMMENT 'Total amount recovered through collections activity. Includes all payments received after case opening. Used to calculate recovery rate and collections effectiveness. Denominated in USD.',
    `write_off_amount` DECIMAL(18,2) COMMENT 'Total amount written off as uncollectible bad debt. Flows to SAP S/4HANA for bad debt expense accounting and regulatory reporting. Denominated in USD.',
    `write_off_date` DATE COMMENT 'Date when the debt was written off. Triggers bad debt expense recognition in SAP S/4HANA for GAAP financial reporting.',
    `write_off_flag` BOOLEAN COMMENT 'Indicates whether the debt has been written off as uncollectible. True if the utility has recognized the bad debt expense and removed the receivable from active collections.',
    `write_off_reason` STRING COMMENT 'Business reason for writing off the debt. Used for bad debt analysis and collections process improvement.. Valid values are `uncollectible|bankruptcy_discharge|deceased_customer|account_closed|statute_of_limitations|other`',
    CONSTRAINT pk_collections_case PRIMARY KEY(`collections_case_id`)
) COMMENT 'Operational record tracking the full collections lifecycle for a delinquent customer account — from initial past-due notice through final write-off or debt recovery. Captures collections stage (dunning notice, disconnect warning, field disconnect order, collections agency referral, write-off, bankruptcy), days past due, past-due amount, collections action dates, assigned collections agent or agency, and resolution outcome. Integrates with Oracle CC&B / SAP IS-U collections process and SAP S/4HANA for bad debt accounting. SSOT for all collections activity against customer accounts.';

CREATE OR REPLACE TABLE `power_and_utilities`.`billing`.`bill_dispute` (
    `bill_dispute_id` BIGINT COMMENT 'Unique identifier for the bill dispute record. Primary key for the bill dispute entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account that initiated the dispute. Links to the customer account master record in the Customer Information System (CIS).',
    `rate_schedule_id` BIGINT COMMENT 'Tariff rate schedule code applied to the disputed bill. Used to verify correct rate application and identify rate misapplication disputes.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Bill disputes escalated to PUC become formal docket proceedings. Real business process: customer complaint escalation to regulatory commission. The existing puc_complaint_number field signals this rel',
    `invoice_id` BIGINT COMMENT 'Reference to the specific invoice or bill being disputed. Links to the bill master record.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Customer disputes are often about specific line-item charges (e.g., disputing a demand charge calculation or a regulatory rider amount), not the entire invoice. Adding this FK allows precise tracking ',
    `adjustment_reason_code` STRING COMMENT 'Standardized code identifying the specific reason for any billing adjustment or credit issued. Required for financial audit and regulatory reporting.. Valid values are `^[A-Z]{2,4}-[0-9]{2,4}$`',
    `assigned_analyst_code` BIGINT COMMENT 'Reference to the customer service analyst or dispute resolution specialist assigned to investigate and resolve this case.',
    `assigned_department` STRING COMMENT 'Department or functional area responsible for investigating and resolving the dispute. Determines escalation path and subject matter expertise.. Valid values are `customer_service|billing_operations|meter_services|revenue_protection|regulatory_affairs`',
    `billing_period_end_date` DATE COMMENT 'End date of the billing period for the disputed bill. Defines the service period under dispute.',
    `billing_period_start_date` DATE COMMENT 'Start date of the billing period for the disputed bill. Defines the service period under dispute.',
    `closed_date` DATE COMMENT 'Date when the dispute case was formally closed in the system after resolution and all follow-up actions were completed.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this dispute record was first created in the database. Used for audit trail and data lineage tracking.',
    `credit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of credit issued to the customer account as part of the dispute resolution. Zero if no credit was granted.',
    `customer_contact_email` STRING COMMENT 'Email address for the customer contact regarding this dispute. Used for written communication and resolution documentation.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `customer_contact_name` STRING COMMENT 'Name of the customer or authorized representative who initiated the dispute. May differ from the account holder name.',
    `customer_contact_phone` STRING COMMENT 'Primary phone number for the customer contact regarding this dispute. Used for follow-up communication and resolution coordination.',
    `customer_satisfaction_rating` STRING COMMENT 'Post-resolution customer satisfaction score on a scale of 1 to 5. Used for service quality monitoring and process improvement.',
    `dispute_description` STRING COMMENT 'Detailed narrative description of the customer complaint and the specific issues being disputed. Captures customer-provided context and concerns.',
    `dispute_number` STRING COMMENT 'Externally visible unique business identifier for the dispute case. Used for customer communication and case tracking across systems.. Valid values are `^DSP-[0-9]{8,12}$`',
    `dispute_open_date` DATE COMMENT 'Date when the dispute was formally opened in the system. Marks the start of the SLA clock for regulatory compliance tracking.',
    `dispute_open_timestamp` TIMESTAMP COMMENT 'Precise date and time when the dispute case was created in the system. Used for detailed SLA tracking and audit trails.',
    `dispute_reason_code` STRING COMMENT 'Standardized code categorizing the specific reason for the dispute. Used for root cause analysis and process improvement tracking.. Valid values are `^[A-Z]{2,4}-[0-9]{2,4}$`',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the dispute case. Tracks progression through investigation, resolution, and closure workflows. [ENUM-REF-CANDIDATE: open|under_investigation|pending_customer_response|pending_meter_test|resolved|closed|escalated — 7 candidates stripped; promote to reference product]',
    `dispute_type` STRING COMMENT 'Classification of the dispute based on the nature of the customer complaint. Determines routing, investigation procedures, and resolution workflows. [ENUM-REF-CANDIDATE: billing_error|rate_misapplication|estimated_read|meter_malfunction|high_bill_complaint|unauthorized_charge|regulatory_complaint — 7 candidates stripped; promote to reference product]',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Total dollar amount being disputed by the customer. May represent full bill amount or specific line item charges.',
    `disputed_kwh` DECIMAL(18,2) COMMENT 'Quantity of electric energy consumption in kilowatt-hours being disputed. Applicable for electric service disputes involving usage discrepancies.',
    `disputed_mcf` DECIMAL(18,2) COMMENT 'Quantity of natural gas consumption in thousand cubic feet being disputed. Applicable for gas service disputes involving usage discrepancies.',
    `escalation_date` DATE COMMENT 'Date when the dispute was escalated to a higher tier or specialized team. Used for tracking escalation patterns and resolution complexity.',
    `escalation_level` STRING COMMENT 'Current escalation tier of the dispute case. Indicates the level of management or specialized expertise involved in resolution.. Valid values are `tier_1|tier_2|tier_3|management|executive|regulatory`',
    `investigation_notes` STRING COMMENT 'Detailed internal notes documenting the investigation process, findings, evidence reviewed, and decision rationale. Used for audit trail and knowledge management.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this dispute record was last updated. Used for audit trail and change tracking.',
    `meter_read_type` STRING COMMENT 'Method used to obtain the meter reading for the disputed billing period. Critical for estimated read disputes and meter malfunction investigations.. Valid values are `actual|estimated|customer_read|remote|ami`',
    `puc_complaint_flag` BOOLEAN COMMENT 'Indicator whether this dispute was escalated to or originated from a formal complaint filed with the state Public Utility Commission. Triggers enhanced regulatory reporting and tracking requirements.',
    `puc_complaint_number` STRING COMMENT 'Official complaint case number assigned by the state Public Utility Commission if the dispute was escalated to regulatory level. Used for regulatory correspondence and reporting.. Valid values are `^PUC-[A-Z]{2}-[0-9]{6,10}$`',
    `resolution_date` DATE COMMENT 'Date when the dispute was formally resolved and a final determination was communicated to the customer. Marks the end of the SLA clock.',
    `resolution_description` STRING COMMENT 'Detailed narrative explanation of the investigation findings and the rationale for the resolution decision. Provides audit trail and customer communication content.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Precise date and time when the dispute resolution was finalized in the system. Used for detailed SLA compliance reporting.',
    `resolution_type` STRING COMMENT 'Classification of the final resolution action taken to close the dispute. Determines financial adjustments and follow-up actions required. [ENUM-REF-CANDIDATE: credit_issued|bill_upheld|rate_correction|re_read_ordered|meter_test_ordered|payment_plan_offered|partial_credit|no_action — 8 candidates stripped; promote to reference product]',
    `service_type` STRING COMMENT 'Type of utility service associated with the disputed bill. Determines applicable rate schedules, regulatory requirements, and investigation procedures.. Valid values are `electric|gas|dual_fuel`',
    `sla_actual_days` STRING COMMENT 'Actual number of calendar days elapsed from dispute open date to resolution date. Used for SLA compliance tracking and performance reporting.',
    `sla_compliance_flag` BOOLEAN COMMENT 'Indicator whether the dispute was resolved within the target SLA timeframe. Used for regulatory reporting and internal performance management.',
    `sla_target_days` STRING COMMENT 'Number of calendar days allowed for dispute resolution per regulatory or internal service level agreement. Varies by dispute type and jurisdiction.',
    CONSTRAINT pk_bill_dispute PRIMARY KEY(`bill_dispute_id`)
) COMMENT 'Customer-initiated formal dispute or inquiry against a specific invoice or charge — billing error claim, rate misapplication complaint, estimated read dispute, or regulatory complaint escalation. Captures dispute type, disputed invoice reference, disputed amount, dispute open date, resolution date, resolution type (credit issued, bill upheld, rate correction, re-read ordered), assigned analyst, and PUC complaint flag. Tracks SLA compliance for dispute resolution per regulatory requirements. Managed within Oracle CC&B / SAP IS-U case management or Salesforce Energy & Utilities Cloud.';

CREATE OR REPLACE TABLE `power_and_utilities`.`billing`.`credit_adjustment` (
    `credit_adjustment_id` BIGINT COMMENT 'Unique identifier for the credit adjustment record. Primary key for the credit adjustment entity.',
    `account_id` BIGINT COMMENT 'Reference to the customer account to which this credit adjustment is applied. Links to the customer account master record in the Customer Information System (CIS).',
    `bill_dispute_id` BIGINT COMMENT 'Reference to the originating customer dispute or complaint case that triggered this adjustment. Nullable for adjustments not resulting from customer disputes. Links to the Customer Relationship Management (CRM) case management system.',
    `rate_schedule_id` BIGINT COMMENT 'Rate schedule or tariff code associated with this adjustment. Relevant for rate correction adjustments, Time-of-Use (TOU) rate adjustments, Critical Peak Pricing (CPP) adjustments, and tiered rate corrections. References the approved tariff schedule filed with the Public Utility Commission (PUC).',
    `collections_case_id` BIGINT COMMENT 'Reference to the collections case associated with this adjustment. Relevant for bad debt write-offs, payment plan adjustments, and settlement agreements. Nullable for non-collections-related adjustments.',
    `commission_order_id` BIGINT COMMENT 'Foreign key linking to regulatory.commission_order. Business justification: Credits issued as result of commission orders or settlement agreements in regulatory proceedings require traceability. Real business process: commission-ordered refunds, rate case settlements, and reg',
    `distribution_outage_event_id` BIGINT COMMENT 'Reference to the specific outage event that triggered this service credit. Relevant for outage performance credits based on System Average Interruption Duration Index (SAIDI) or System Average Interruption Frequency Index (SAIFI) thresholds. Nullable for non-outage-related adjustments.',
    `invoice_id` BIGINT COMMENT 'Reference to the specific bill or invoice against which this adjustment is applied. Nullable for account-level adjustments not tied to a specific bill.',
    `invoice_line_id` BIGINT COMMENT 'Foreign key linking to billing.invoice_line. Business justification: Credit adjustments are frequently applied to specific line-item charges (e.g., correcting a meter read error that affects energy charges, or reversing a specific regulatory rider). Adding this FK allo',
    `primary_reversal_of_adjustment_credit_adjustment_id` BIGINT COMMENT 'Reference to the original credit adjustment that this record reverses. Nullable for original adjustments. Used to maintain audit trail for adjustment corrections and reversals.',
    `settlement_statement_id` BIGINT COMMENT 'Foreign key linking to market.settlement_statement. Business justification: Market settlement errors or RTO resettlements trigger billing adjustments to retail customers. Real process: when wholesale market disputes are resolved or statements are reissued, utilities must cred',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary value of the credit adjustment in US dollars. Positive values represent credits to the customer (reducing account balance); negative values represent debits (increasing account balance). Includes the net impact on customer account receivable.',
    `adjustment_number` STRING COMMENT 'Externally visible business identifier for the credit adjustment. Unique human-readable reference number used in customer communications and dispute resolution tracking.. Valid values are `^ADJ-[0-9]{10}$`',
    `adjustment_status` STRING COMMENT 'Current lifecycle status of the credit adjustment. Tracks the adjustment from initial creation through approval, posting to the General Ledger (GL), and potential reversal or cancellation.. Valid values are `pending|approved|posted|reversed|rejected|cancelled`',
    `adjustment_type` STRING COMMENT 'Classification of the credit adjustment by business purpose. Includes rate correction credits, outage performance credits (SAIDI/SAIFI-related), low-income program discounts (LIHEAP, PIPP), returned payment fees, late payment charges, deposit interest credits, bad debt write-offs, billing error corrections, meter error adjustments, estimated bill corrections, Fuel Adjustment Clause (FAC) adjustments, Contribution in Aid of Construction (CIAC) adjustments, regulatory rider adjustments, dispute resolution credits, customer service credits, payment reversals, and other miscellaneous adjustments. [ENUM-REF-CANDIDATE: rate_correction|service_credit|outage_credit|regulatory_refund|low_income_discount|returned_payment_fee|late_payment_charge|deposit_interest|bad_debt_writeoff|billing_error_correction|meter_error_adjustment|estimated_bill_correction|fac_adjustment|ciac_adjustment|rider_adjustment|dispute_resolution_credit|customer_service_credit|payment_reversal|other — 19 candidates stripped; promote to reference product]',
    `approved_by_user_code` STRING COMMENT 'System user identifier of the employee who authorized and approved this adjustment. Nullable for system-automated adjustments. Used for audit trail and SOX compliance reporting.',
    `approved_by_user_name` STRING COMMENT 'Full name of the employee who authorized and approved this adjustment. Denormalized for reporting convenience and audit trail readability.',
    `authorization_level` STRING COMMENT 'Approval authority level required for this adjustment based on amount thresholds and adjustment type. System-automated adjustments (e.g., FAC riders) require no manual approval; large or sensitive adjustments require supervisor, manager, director, or executive approval per internal controls and Sarbanes-Oxley (SOX) compliance requirements. [ENUM-REF-CANDIDATE: system_auto|csr_tier1|csr_tier2|supervisor|manager|director|executive — 7 candidates stripped; promote to reference product]',
    `comments` STRING COMMENT 'Additional free-text comments or notes related to this credit adjustment. Captures internal operational notes, customer service representative observations, supporting documentation references, and any other contextual information not captured in structured fields.',
    `created_by_user_code` STRING COMMENT 'System user identifier of the employee or automated process that created this adjustment record. Used for audit trail and SOX compliance reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit adjustment record was first created in the system. Represents the initial capture of the adjustment request or system-generated adjustment event. Used for audit trail and lifecycle tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the adjustment amount. Utility operates exclusively in US dollars (USD).. Valid values are `USD`',
    `customer_notification_sent` BOOLEAN COMMENT 'Flag indicating whether the customer has been notified of this adjustment via bill message, email, or other communication channel. Used for customer service tracking and regulatory compliance with customer notification requirements.',
    `effective_date` DATE COMMENT 'Business date on which the adjustment becomes effective for billing and revenue recognition purposes. May differ from the posting date for backdated corrections or future-dated adjustments. Used for GAAP revenue recognition timing and regulatory reporting period assignment.',
    `gl_account_code` STRING COMMENT 'General Ledger (GL) account code to which this adjustment is posted in the ERP system. Maps to the FERC Uniform System of Accounts chart of accounts for regulatory financial reporting. Examples include revenue accounts (400-series), bad debt expense accounts, and regulatory asset/liability accounts.. Valid values are `^[0-9]{4,10}$`',
    `gl_posting_status` STRING COMMENT 'Status of the adjustment posting to the General Ledger (GL) in the Enterprise Resource Planning (ERP) system. Tracks whether the adjustment has been successfully integrated into financial accounting records for GAAP revenue reporting and reconciliation.. Valid values are `not_posted|posted|posting_failed|reversed`',
    `last_modified_by_user_code` STRING COMMENT 'System user identifier of the employee or automated process that last modified this adjustment record. Used for audit trail and SOX compliance reporting.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit adjustment record was last updated. Tracks the most recent change to any field in the record for audit trail and data quality monitoring.',
    `notification_date` DATE COMMENT 'Date on which the customer was notified of this adjustment. Nullable if customer notification has not been sent. Used for regulatory compliance tracking and customer service audit trail.',
    `posting_date` DATE COMMENT 'Date on which the adjustment was posted to the General Ledger (GL) and applied to the customer account balance. Represents the accounting transaction date for financial reporting and reconciliation.',
    `reason_code` STRING COMMENT 'Standardized code indicating the specific business reason for the adjustment. Maps to internal reason code taxonomy used for regulatory reporting and financial analysis. Examples include OUTAGE (outage credit), RATEFIX (rate correction), LIHEAP (low-income assistance), BDWRT (bad debt write-off), METERERR (meter error), ESTCORR (estimated bill correction).. Valid values are `^[A-Z0-9]{2,10}$`',
    `reason_description` STRING COMMENT 'Free-text narrative explanation of the business reason for the adjustment. Provides additional context beyond the reason code, including customer-facing explanation, internal notes, and supporting documentation references.',
    `regulatory_program_code` STRING COMMENT 'Code identifying the regulatory program or mandate associated with this adjustment. Examples include LIHEAP (Low Income Home Energy Assistance Program), PIPP (Percentage of Income Payment Plan), Renewable Portfolio Standard (RPS) credits, Energy Efficiency (EE) program rebates, and Demand Response (DR) incentive payments. Used for regulatory compliance reporting to the Public Utility Commission (PUC) and Federal Energy Regulatory Commission (FERC).',
    `service_type` STRING COMMENT 'Type of utility service to which this adjustment applies. Electric-only, gas-only, or both services for dual-fuel customers. Used for service-specific revenue reporting and regulatory compliance.. Valid values are `electric|gas|both`',
    `source_system` STRING COMMENT 'Operational system of record that originated this credit adjustment. Identifies whether the adjustment was created in Oracle CC&B, SAP IS-U, Salesforce CRM, Meter Data Management System (MDMS), ERP, or manually entered. Used for data lineage tracking and system integration reconciliation.. Valid values are `CC&B|SAP_IS_U|CRM|MDMS|ERP|MANUAL`',
    `source_transaction_reference` STRING COMMENT 'Unique transaction identifier from the source system of record. Maintains traceability back to the originating system transaction for audit and reconciliation purposes.',
    `tax_impact_amount` DECIMAL(18,2) COMMENT 'Tax amount adjustment associated with this credit adjustment. Represents the change in sales tax, utility tax, or other regulatory taxes resulting from the adjustment. Used for tax reconciliation and regulatory tax reporting.',
    CONSTRAINT pk_credit_adjustment PRIMARY KEY(`credit_adjustment_id`)
) COMMENT 'Financial adjustment record applied to a customer account post-billing to correct errors, issue service credits, apply regulatory refunds, or process write-offs. Includes rate correction credits, outage performance credits (SAIDI/SAIFI), low-income program discounts (LIHEAP, PIPP), returned payment fees, late payment charges, deposit interest credits, and bad debt write-offs. Captures adjustment type, amount (positive credit or negative debit), reason code, authorization level, approving user, effective date, GL posting status, and originating dispute or collections case reference. Distinct from a payment (no cash received) and from an invoice line (post-bill correction applied after invoice finalization). Sourced from Oracle CC&B / SAP IS-U adjustment processing.';

CREATE OR REPLACE TABLE `power_and_utilities`.`billing`.`billing_service_agreement` (
    `billing_service_agreement_id` BIGINT COMMENT 'Unique identifier for the billing service agreement. Primary key for this entity.',
    `account_id` BIGINT COMMENT 'Foreign key linking to customer.account. Business justification: Billing service agreements must link to billing accounts for payment processing, credit management, collections tracking, and account-level billing preferences. Currently has party_id but missing acco',
    `bill_cycle_id` BIGINT COMMENT 'Code identifying the monthly billing cycle schedule for this agreement. Determines meter read date and invoice generation timing.',
    `rate_schedule_id` BIGINT COMMENT 'Tariff rate schedule code governing charge calculation for this agreement. Examples include residential TOU, commercial demand, CPP, tiered rates. Approved by PUC.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Service agreements tie to cost centers for revenue allocation by service territory and cost-of-service analysis in rate cases. Supports regulatory cost allocation requirements.',
    `party_id` BIGINT COMMENT 'Identifier of the customer party to this service agreement. Links to the customer master entity.',
    `payment_arrangement_id` BIGINT COMMENT 'Identifier of the active payment arrangement or installment plan for past-due balances. Null if no arrangement in place.',
    `service_point_id` BIGINT COMMENT 'Identifier of the physical service point (meter location) where electric or gas service is delivered under this agreement.',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Service agreements must reference the approved tariff schedule governing service terms, conditions, and rates. Real business process: tariff compliance in customer contracts and regulatory audit suppo',
    `activated_timestamp` TIMESTAMP COMMENT 'Timestamp when service delivery under this agreement was activated and billing commenced.',
    `agreement_number` STRING COMMENT 'Externally visible business identifier for the service agreement. Used in customer communications and billing statements.',
    `agreement_status` STRING COMMENT 'Current lifecycle status of the service agreement. Active = service in delivery; Pending = awaiting activation; Suspended = temporarily halted; Final = closed with final bill issued; Cancelled = terminated before activation.. Valid values are `active|pending|suspended|final|cancelled`',
    `agreement_type` STRING COMMENT 'Type of utility service provided under this agreement: electric only, gas only, or dual fuel (both electric and gas).. Valid values are `electric|gas|dual_fuel`',
    `auto_pay_flag` BOOLEAN COMMENT 'Indicates whether automatic payment is enabled for this service agreement. True = auto-pay active; False = manual payment.',
    `average_monthly_usage_kwh` DECIMAL(18,2) COMMENT 'Rolling 12-month average monthly electric consumption in kilowatt-hours for this service agreement. Used for budget billing calculation and load forecasting.',
    `average_monthly_usage_mcf` DECIMAL(18,2) COMMENT 'Rolling 12-month average monthly gas consumption in thousand cubic feet for this service agreement. Used for budget billing calculation and load forecasting.',
    `budget_billing_flag` BOOLEAN COMMENT 'Indicates whether this service agreement is enrolled in budget billing (levelized monthly payment plan). True = enrolled; False = standard billing.',
    `collection_status` STRING COMMENT 'Current collections status for this service agreement. Current = no arrears; Past Due = overdue balance; Collection = active collections; Payment Plan = installment arrangement; Suspended = service disconnected; Write Off = uncollectible.. Valid values are `current|past_due|collection|payment_plan|suspended|write_off`',
    `commodity_type` STRING COMMENT 'Primary commodity delivered under this agreement: electric (kWh) or gas (MCF/Therm).. Valid values are `electric|gas`',
    `contract_demand_kw` DECIMAL(18,2) COMMENT 'Contracted demand level in kilowatts for commercial and industrial customers with demand-based rate schedules. Used for demand charge calculation and capacity reservation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this service agreement record was first created in the CIS system.',
    `credit_rating` STRING COMMENT 'Credit assessment of the customer for deposit and payment term determination. Excellent/Good = no deposit; Fair/Poor = deposit required.. Valid values are `excellent|good|fair|poor|no_rating`',
    `current_balance` DECIMAL(18,2) COMMENT 'Current outstanding balance for this service agreement. Positive = amount owed by customer; Negative = credit balance.',
    `customer_class` STRING COMMENT 'Regulatory customer classification for rate and service eligibility: residential, commercial, industrial, agricultural, or public authority.. Valid values are `residential|commercial|industrial|agricultural|public_authority`',
    `deposit_amount` DECIMAL(18,2) COMMENT 'Dollar amount of security deposit held for this service agreement. Required for customers with poor credit or payment history. Null if no deposit required.',
    `deposit_held_date` DATE COMMENT 'Date when the security deposit was collected and held. Used for interest accrual calculation per PUC rules.',
    `end_date` DATE COMMENT 'Date when service delivery and billing under this agreement ended or is scheduled to end. Null for open-ended active agreements. Corresponds to move-out or service termination date.',
    `last_bill_date` DATE COMMENT 'Date of the most recent invoice generated for this service agreement.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this service agreement record was last updated in the CIS system.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received for this service agreement.',
    `life_support_flag` BOOLEAN COMMENT 'Indicates whether the premise has registered life-support medical equipment requiring uninterrupted electric service. True = life support present; False = none. Affects disconnection rules.',
    `load_profile_code` STRING COMMENT 'Code identifying the typical consumption pattern profile for this service agreement. Used for demand forecasting and rate design.',
    `low_income_qualified_flag` BOOLEAN COMMENT 'Indicates whether the customer qualifies for low-income assistance programs and discounted rates. True = qualified; False = not qualified.',
    `nem_enrolled_flag` BOOLEAN COMMENT 'Indicates whether this service agreement is enrolled in a Net Energy Metering program for distributed generation (solar, wind). True = enrolled; False = not enrolled.',
    `notes` STRING COMMENT 'Free-text notes and comments regarding special circumstances, customer requests, or operational considerations for this service agreement.',
    `paperless_billing_flag` BOOLEAN COMMENT 'Indicates whether the customer has opted for electronic billing statements instead of paper. True = paperless; False = paper billing.',
    `premise_type` STRING COMMENT 'Classification of the physical premise receiving service: single-family home, multi-family dwelling, commercial office, retail, industrial facility, agricultural facility, or public building. [ENUM-REF-CANDIDATE: single_family|multi_family|commercial_office|retail|industrial_facility|agricultural_facility|public_building — 7 candidates stripped; promote to reference product]',
    `service_voltage_level` STRING COMMENT 'Voltage level at which electric service is delivered. Secondary = low voltage residential/small commercial; Primary = medium voltage large commercial; Transmission = high voltage industrial.. Valid values are `secondary|primary|transmission`',
    `special_rate_rider_codes` STRING COMMENT 'Comma-separated list of special rate rider codes applied to this agreement. Examples: FAC (Fuel Adjustment Clause), renewable energy surcharge, low-income discount, energy efficiency incentive.',
    `start_date` DATE COMMENT 'Date when service delivery and billing under this agreement became effective. Corresponds to move-in or service initiation date.',
    `terminated_timestamp` TIMESTAMP COMMENT 'Timestamp when service delivery under this agreement was terminated. Null for active agreements.',
    `termination_reason` STRING COMMENT 'Reason code for service agreement termination. Customer Request = voluntary disconnect; Move Out = customer relocation; Non Payment = involuntary disconnect; Property Demolition = premise no longer exists; Service Transfer = agreement superseded by new agreement.. Valid values are `customer_request|move_out|non_payment|property_demolition|service_transfer|other`',
    `third_party_notification_flag` BOOLEAN COMMENT 'Indicates whether a third party (family member, social service agency) is registered to receive billing and disconnection notices. True = third party registered; False = none.',
    CONSTRAINT pk_billing_service_agreement PRIMARY KEY(`billing_service_agreement_id`)
) COMMENT 'Active contractual service agreement between the utility and a customer for delivery of electric or gas service at a specific premise under a specific rate schedule — the billing contract that governs charge calculation. Captures commodity type (electric/gas), service point identifier, rate schedule code, contract start and end dates, customer class, demand contract level (kW for commercial/industrial), NEM enrollment flag, budget billing enrollment flag, and agreement status (active, pending, final, cancelled). The billing domains view of the service agreement — the customer domain owns the customer identity; this entity owns the rate and billing terms. Sourced from Oracle CC&B / SAP IS-U service agreement.';

CREATE OR REPLACE TABLE `power_and_utilities`.`billing`.`bill_cycle` (
    `bill_cycle_id` BIGINT COMMENT 'Unique identifier for the billing cycle schedule. Primary key for the bill cycle entity.',
    `superseded_by_bill_cycle_id` BIGINT COMMENT 'Reference to the billing cycle that replaced this cycle when it was retired or restructured. Null for active cycles. Supports historical lineage tracking.',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Bill cycles are defined in approved tariff schedules with specific meter reading timelines, billing frequencies, and due date rules. Real business process: tariff-mandated billing cycle administration',
    `auto_pay_eligible_flag` BOOLEAN COMMENT 'Indicates whether accounts in this cycle are eligible for automatic payment enrollment. May be restricted for certain customer classes or cycle types.',
    `bill_date` STRING COMMENT 'Target day of the month (1-31) when invoices for this cycle are generated and dated. Used for revenue recognition and aging calculations.',
    `bill_generation_offset_days` STRING COMMENT 'Number of days after meter read completion when bill calculation and invoice generation runs are scheduled. Allows time for data validation and rate application.',
    `budget_billing_eligible_flag` BOOLEAN COMMENT 'Indicates whether accounts in this cycle are eligible for budget billing programs, which spread annual costs evenly across monthly payments.',
    `commodity_type` STRING COMMENT 'Type of utility service covered by this billing cycle: electric, gas, or dual (combined electric and gas).. Valid values are `electric|gas|dual`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing cycle record was first created in the Customer Information System (CIS). Used for audit and data lineage tracking.',
    `customer_class` STRING COMMENT 'Customer class or segment served by this billing cycle. Determines rate schedule eligibility and billing complexity.. Valid values are `residential|commercial|industrial|agricultural|municipal|wholesale`',
    `cycle_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the billing cycle within the billing system. Used as the business identifier for cycle assignment and batch scheduling.. Valid values are `^[A-Z0-9]{2,10}$`',
    `cycle_description` STRING COMMENT 'Detailed description of the billing cycle purpose, coverage area, and operational notes. May include territory, route grouping, or special handling instructions.',
    `cycle_frequency` STRING COMMENT 'Frequency at which accounts in this cycle are billed. Monthly is standard for residential; bi-monthly, quarterly, or special cycles may apply to large Commercial and Industrial (C&I) accounts.. Valid values are `monthly|bi-monthly|quarterly|annual|on-demand|special`',
    `cycle_name` STRING COMMENT 'Human-readable descriptive name of the billing cycle, such as Monthly Residential Cycle 01 or Bi-Monthly Commercial Cycle A.',
    `cycle_status` STRING COMMENT 'Current operational status of the billing cycle. Active cycles are used for new account assignments and ongoing billing operations. Inactive cycles are retained for historical reference.. Valid values are `active|inactive|suspended|pending`',
    `effective_date` DATE COMMENT 'Date when this billing cycle configuration became or will become effective. Supports versioning and regulatory compliance for cycle changes.',
    `estimated_account_count` STRING COMMENT 'Approximate number of customer accounts assigned to this billing cycle. Used for capacity planning, batch sizing, and workload balancing across cycles.',
    `estimated_billing_flag` BOOLEAN COMMENT 'Indicates whether estimated billing is permitted for accounts in this cycle when actual meter reads are unavailable. Subject to regulatory limits on consecutive estimated bills.',
    `expiration_date` DATE COMMENT 'Date when this billing cycle configuration expires or was superseded. Null for currently active cycles. Used for historical tracking and regulatory audit.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this billing cycle record was last updated. Tracks configuration changes and supports change management processes.',
    `meter_read_end_day` STRING COMMENT 'Day of the month (1-31) when the meter reading window closes for accounts in this cycle. All meter reads must be completed by this day to support timely bill generation.',
    `meter_read_start_day` STRING COMMENT 'Day of the month (1-31) when the meter reading window opens for accounts in this cycle. Drives Advanced Metering Infrastructure (AMI) or Automated Meter Reading (AMR) batch scheduling.',
    `paperless_billing_eligible_flag` BOOLEAN COMMENT 'Indicates whether accounts in this cycle are eligible for paperless billing and electronic invoice delivery. Supports cost reduction and environmental initiatives.',
    `payment_due_day` STRING COMMENT 'Target day of the month (1-31) when payment is due for invoices in this cycle. Calculated as bill_date plus payment_due_offset_days.',
    `payment_due_offset_days` STRING COMMENT 'Number of days after bill date when payment is due. Typically 15-30 days for residential accounts; may vary by customer class and regulatory requirements.',
    `regulatory_approval_reference` STRING COMMENT 'Reference to the Public Utility Commission (PUC) docket, order, or tariff filing that approved this billing cycle configuration. Required for regulatory compliance and audit.',
    `route_grouping` STRING COMMENT 'Meter reading route or grouping identifier used to organize field meter readers or AMI collection schedules. May represent physical routes or logical batches.',
    `special_handling_flag` BOOLEAN COMMENT 'Indicates whether this cycle requires special processing, such as manual review, custom rate application, or non-standard billing rules. True for large C&I or wholesale accounts.',
    `tariff_book_reference` STRING COMMENT 'Reference to the section of the utility tariff book that governs billing cycle assignment and payment terms for this cycle. Used for regulatory compliance and customer dispute resolution.',
    `territory_code` STRING COMMENT 'Geographic territory or service area code associated with this billing cycle. Aligns with Geographic Information System (GIS) boundaries and operational districts.. Valid values are `^[A-Z0-9]{2,10}$`',
    `version_number` STRING COMMENT 'Version number of this billing cycle configuration. Incremented when cycle parameters are modified. Supports change tracking and regulatory audit.',
    CONSTRAINT pk_bill_cycle PRIMARY KEY(`bill_cycle_id`)
) COMMENT 'Master definition of billing cycle schedules governing when customer accounts are meter-read and billed — monthly, bi-monthly, quarterly, and special cycles for large C&I accounts. Captures cycle code, cycle description, scheduled meter read window (start day, end day), bill generation date offset from read completion, payment due date offset from bill date, estimated account count per cycle, cycle territory/route grouping, and active/inactive status. Drives batch scheduling of meter reads, bill calculation runs, and payment due date assignment across the billing engine. Referenced by service agreements to assign billing cadence and by invoices to record which cycle generated the bill. Sourced from Oracle CC&B / SAP IS-U billing cycle configuration.';

CREATE OR REPLACE TABLE `power_and_utilities`.`billing`.`collections_action` (
    `collections_action_id` BIGINT COMMENT 'Primary key for collections_action',
    `associated_collections_action_id` BIGINT COMMENT 'Self-referencing FK on collections_action (associated_collections_action_id)',
    `action_category` STRING COMMENT 'High-level classification of the collections action type. Notification includes letters and notices; contact_attempt includes calls and visits; payment_arrangement includes plans and extensions; legal_action includes liens and judgments; service_action includes disconnection and reconnection; account_adjustment includes write-offs and settlements; escalation includes agency referrals; resolution includes payment received and account closure.',
    `action_code` STRING COMMENT 'Standardized code representing the type of collections action (e.g., NOTICE_1, CALL_ATTEMPT, PAYMENT_PLAN, DISCONNECT_WARN, SERVICE_SUSPEND). Used as a business identifier for integration with Customer Information System (CIS) and billing workflows.',
    `action_name` STRING COMMENT 'Human-readable name of the collections action (e.g., First Delinquency Notice, Payment Arrangement Offer, Service Disconnection Warning, Final Notice Before Shutoff).',
    `action_sequence` STRING COMMENT 'Numeric ordering of this action within a standard collections workflow. Lower numbers represent earlier actions in the escalation path (e.g., 1 for first notice, 5 for final notice, 10 for disconnection).',
    `applicable_customer_class` STRING COMMENT 'Customer segment(s) to which this collections action applies. Residential for household customers; commercial for small/medium business; industrial for large commercial and manufacturing; all for universal actions. Different customer classes may have different regulatory protections and collections workflows.',
    `auto_trigger_enabled` BOOLEAN COMMENT 'Indicates whether this collections action can be automatically triggered by the billing or collections system based on predefined rules (e.g., days past due, balance threshold). True for system-automated actions; false for manual-only actions requiring human review.',
    `auto_trigger_rule` STRING COMMENT 'Business rule or condition that automatically triggers this collections action. Examples: Balance > $100 AND Days Past Due >= 30, Second missed payment on payment plan, No response to prior notice within 15 days. Null if action is manual-only.',
    `cost_amount` DECIMAL(18,2) COMMENT 'Standard cost or fee associated with executing this collections action, charged to the customer account. Includes costs such as certified mail fees, field visit charges, reconnection fees, or collection agency commissions. Null if no cost is assessed.',
    `cost_recoverable` BOOLEAN COMMENT 'Indicates whether the cost of this collections action can be billed to and recovered from the customer account. True if cost is customer-billable; false if cost is absorbed by the utility as a business expense.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this collections action record was first created in the system. Used for audit trail and data lineage tracking.',
    `credit_reporting_impact` STRING COMMENT 'Indicates the impact of this collections action on customer credit bureau reporting. None for actions with no credit impact; negative_report for delinquency or charge-off reporting; positive_report for successful payment plan completion; dispute_flag for contested accounts.',
    `delivery_method` STRING COMMENT 'The channel or medium through which the collections action is delivered to the customer. Mail for standard postal delivery; certified_mail for proof-of-delivery requirements; email and sms for electronic notifications; phone_call for voice contact; in_person for field visits; portal_notification for customer self-service alerts.',
    `collections_action_description` STRING COMMENT 'Detailed business description of the collections action, including purpose, typical use cases, and any special handling instructions. Provides context for collections staff and system administrators.',
    `dispute_eligible` BOOLEAN COMMENT 'Indicates whether the customer has the right to dispute or appeal this collections action. True for actions subject to customer dispute rights; false for non-disputable administrative actions.',
    `effective_end_date` DATE COMMENT 'Date on which this collections action definition is retired or superseded. Null for currently active actions. Used for historical analysis and regulatory audit trails.',
    `effective_start_date` DATE COMMENT 'Date from which this collections action definition becomes active and available for use in collections workflows. Used for version control and regulatory compliance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this collections action record was most recently updated. Used for change tracking and audit compliance.',
    `legal_action_indicator` BOOLEAN COMMENT 'Indicates whether this collections action involves or initiates legal proceedings (e.g., filing a lien, initiating small claims, referring to attorney). True for legal actions; false for operational collections activities.',
    `minimum_notice_days` STRING COMMENT 'Minimum number of days required by regulation between this action and any subsequent service disconnection or legal action. Null if no regulatory minimum applies. Varies by jurisdiction and customer class (residential vs. commercial).',
    `modified_by_user` STRING COMMENT 'User identifier or name of the person who last modified this collections action definition. Used for accountability and audit trail purposes.',
    `payment_plan_eligible` BOOLEAN COMMENT 'Indicates whether customers receiving this collections action are eligible to enter into a payment arrangement or installment plan to avoid further escalation. True if payment plan option is available; false if account is past payment plan eligibility.',
    `protected_customer_exempt` BOOLEAN COMMENT 'Indicates whether this collections action is prohibited for protected customer categories (e.g., medical necessity customers, low-income assistance participants, elderly or disabled customers with special protections). True if action cannot be applied to protected customers; false if action is universally applicable.',
    `regulatory_notice_required` BOOLEAN COMMENT 'Indicates whether this collections action must comply with state or federal regulatory notice requirements (e.g., minimum notice periods before disconnection, specific language mandates, customer rights disclosures). True for actions subject to Public Utility Commission (PUC) or Federal Energy Regulatory Commission (FERC) rules.',
    `regulatory_reference` STRING COMMENT 'Citation of the specific state Public Utility Commission (PUC) rule, tariff section, or federal regulation that governs this collections action. Examples: PUC Rule 25.483, Tariff Section 6.2.1, FERC Order 2222. Null if no specific regulatory mandate applies.',
    `requires_customer_response` BOOLEAN COMMENT 'Indicates whether this collections action requires an explicit response or action from the customer (e.g., payment, contact, dispute filing). True for actions requiring customer engagement; false for informational or system-driven actions.',
    `requires_supervisor_approval` BOOLEAN COMMENT 'Indicates whether this collections action requires managerial or supervisory approval before execution. True for high-impact actions such as disconnection, legal referral, or large write-offs; false for routine automated actions.',
    `response_due_days` STRING COMMENT 'Number of days from action delivery date by which the customer must respond or take action. Null if no response deadline applies. Used to calculate follow-up action triggers and compliance with regulatory notice periods.',
    `seasonal_restriction_applies` BOOLEAN COMMENT 'Indicates whether this collections action is subject to seasonal restrictions (e.g., winter moratorium on disconnections, extreme weather protections). True if action is restricted during certain months or weather conditions; false if action can be taken year-round.',
    `service_action_type` STRING COMMENT 'Specifies the type of field service action triggered by this collections action. Disconnect for service termination; reconnect for service restoration; meter_lock for physical access prevention; meter_removal for complete meter extraction; limiter_install for reduced service capacity; none if no service action is triggered.',
    `severity_level` STRING COMMENT 'Indicates the urgency and escalation level of the collections action. Informational for early reminders; low for initial notices; medium for follow-up actions; high for pre-disconnection warnings; critical for imminent service termination; final for last action before legal or agency referral.',
    `collections_action_status` STRING COMMENT 'Current lifecycle status of this collections action definition. Active for in-use actions; inactive for temporarily disabled actions; suspended for actions under regulatory review; retired for obsolete actions retained for historical reference.',
    `template_document_code` STRING COMMENT 'Reference identifier for the standard letter, notice, or script template used for this collections action. Links to document management system for content retrieval and version control. Null if no template is used (e.g., for system-automated actions).',
    `third_party_agency_eligible` BOOLEAN COMMENT 'Indicates whether accounts subject to this collections action are eligible for referral to external collection agencies. True if action can trigger agency placement; false if action must remain internal.',
    `triggers_service_action` BOOLEAN COMMENT 'Indicates whether this collections action directly triggers a field service action such as disconnection, reconnection, or meter lock. True for actions that initiate service orders; false for administrative or notification-only actions.',
    CONSTRAINT pk_collections_action PRIMARY KEY(`collections_action_id`)
) COMMENT 'Master reference table for collections_action. Referenced by associated_collections_action_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ADD CONSTRAINT `fk_billing_rate_schedule_superseded_by_rate_schedule_id` FOREIGN KEY (`superseded_by_rate_schedule_id`) REFERENCES `power_and_utilities`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_bill_cycle_id` FOREIGN KEY (`bill_cycle_id`) REFERENCES `power_and_utilities`.`billing`.`bill_cycle`(`bill_cycle_id`);
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ADD CONSTRAINT `fk_billing_invoice_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ADD CONSTRAINT `fk_billing_invoice_line_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `power_and_utilities`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `power_and_utilities`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_collections_case_id` FOREIGN KEY (`collections_case_id`) REFERENCES `power_and_utilities`.`billing`.`collections_case`(`collections_case_id`);
ALTER TABLE `power_and_utilities`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `power_and_utilities`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `power_and_utilities`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_payment_arrangement_id` FOREIGN KEY (`payment_arrangement_id`) REFERENCES `power_and_utilities`.`billing`.`payment_arrangement`(`payment_arrangement_id`);
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_collections_action_id` FOREIGN KEY (`collections_action_id`) REFERENCES `power_and_utilities`.`billing`.`collections_action`(`collections_action_id`);
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ADD CONSTRAINT `fk_billing_collections_case_payment_arrangement_id` FOREIGN KEY (`payment_arrangement_id`) REFERENCES `power_and_utilities`.`billing`.`payment_arrangement`(`payment_arrangement_id`);
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ADD CONSTRAINT `fk_billing_bill_dispute_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ADD CONSTRAINT `fk_billing_bill_dispute_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `power_and_utilities`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ADD CONSTRAINT `fk_billing_bill_dispute_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `power_and_utilities`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ADD CONSTRAINT `fk_billing_credit_adjustment_bill_dispute_id` FOREIGN KEY (`bill_dispute_id`) REFERENCES `power_and_utilities`.`billing`.`bill_dispute`(`bill_dispute_id`);
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ADD CONSTRAINT `fk_billing_credit_adjustment_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ADD CONSTRAINT `fk_billing_credit_adjustment_collections_case_id` FOREIGN KEY (`collections_case_id`) REFERENCES `power_and_utilities`.`billing`.`collections_case`(`collections_case_id`);
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ADD CONSTRAINT `fk_billing_credit_adjustment_invoice_id` FOREIGN KEY (`invoice_id`) REFERENCES `power_and_utilities`.`billing`.`invoice`(`invoice_id`);
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ADD CONSTRAINT `fk_billing_credit_adjustment_invoice_line_id` FOREIGN KEY (`invoice_line_id`) REFERENCES `power_and_utilities`.`billing`.`invoice_line`(`invoice_line_id`);
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ADD CONSTRAINT `fk_billing_credit_adjustment_primary_reversal_of_adjustment_credit_adjustment_id` FOREIGN KEY (`primary_reversal_of_adjustment_credit_adjustment_id`) REFERENCES `power_and_utilities`.`billing`.`credit_adjustment`(`credit_adjustment_id`);
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_bill_cycle_id` FOREIGN KEY (`bill_cycle_id`) REFERENCES `power_and_utilities`.`billing`.`bill_cycle`(`bill_cycle_id`);
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_rate_schedule_id` FOREIGN KEY (`rate_schedule_id`) REFERENCES `power_and_utilities`.`billing`.`rate_schedule`(`rate_schedule_id`);
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ADD CONSTRAINT `fk_billing_billing_service_agreement_payment_arrangement_id` FOREIGN KEY (`payment_arrangement_id`) REFERENCES `power_and_utilities`.`billing`.`payment_arrangement`(`payment_arrangement_id`);
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ADD CONSTRAINT `fk_billing_bill_cycle_superseded_by_bill_cycle_id` FOREIGN KEY (`superseded_by_bill_cycle_id`) REFERENCES `power_and_utilities`.`billing`.`bill_cycle`(`bill_cycle_id`);
ALTER TABLE `power_and_utilities`.`billing`.`collections_action` ADD CONSTRAINT `fk_billing_collections_action_associated_collections_action_id` FOREIGN KEY (`associated_collections_action_id`) REFERENCES `power_and_utilities`.`billing`.`collections_action`(`collections_action_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `power_and_utilities`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Identifier');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `superseded_by_rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Rate Schedule ID');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Date');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `base_energy_rate` SET TAGS ('dbx_business_glossary_term' = 'Base Energy Rate');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'electric|gas|dual');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `customer_charge` SET TAGS ('dbx_business_glossary_term' = 'Customer Charge');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|street_lighting|public_authority');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `demand_charge_rate` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Rate');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `demand_charge_uom` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `demand_charge_uom` SET TAGS ('dbx_value_regex' = 'kw|mw');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `eligibility_criteria` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `energy_rate_uom` SET TAGS ('dbx_business_glossary_term' = 'Energy Rate Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `energy_rate_uom` SET TAGS ('dbx_value_regex' = 'kwh|mwh|therm|mcf|ccf');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `interruptible_flag` SET TAGS ('dbx_business_glossary_term' = 'Interruptible Service Flag');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `minimum_charge` SET TAGS ('dbx_business_glossary_term' = 'Minimum Monthly Charge');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `net_metering_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Eligible Flag');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `rate_case_docket` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Docket Number');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `rate_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Code');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `rate_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{2,20}$');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `rate_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Name');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_description` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Description');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Status');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `rate_schedule_status` SET TAGS ('dbx_value_regex' = 'active|pending_approval|superseded|retired');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `rate_structure_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Structure Type');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `seasonal_definition` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Definition');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `seasonal_variation_flag` SET TAGS ('dbx_business_glossary_term' = 'Seasonal Variation Flag');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `special_contract_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Contract Flag');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `tariff_book_reference` SET TAGS ('dbx_business_glossary_term' = 'Tariff Book Reference');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `tier_structure_definition` SET TAGS ('dbx_business_glossary_term' = 'Tier Structure Definition');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `tou_period_definition` SET TAGS ('dbx_business_glossary_term' = 'Time-of-Use (TOU) Period Definition');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Version Number');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level');
ALTER TABLE `power_and_utilities`.`billing`.`rate_schedule` ALTER COLUMN `voltage_level` SET TAGS ('dbx_value_regex' = 'primary|secondary|transmission|sub_transmission');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Identifier');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `bill_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Cycle Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `customer_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Identifier');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `bill_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Bill Period End Date');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `bill_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Bill Period Start Date');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `billing_days` SET TAGS ('dbx_business_glossary_term' = 'Billing Days');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'electric|gas|dual');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `consumption_kwh` SET TAGS ('dbx_business_glossary_term' = 'Consumption Kilowatt-Hours (kWh)');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `consumption_therms` SET TAGS ('dbx_business_glossary_term' = 'Consumption Therms');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `current_charges_amount` SET TAGS ('dbx_business_glossary_term' = 'Current Charges Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `customer_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Customer Charge Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'Delivery Method');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'paper|email|online_portal');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `demand_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `disconnection_notice_flag` SET TAGS ('dbx_business_glossary_term' = 'Disconnection Notice Flag');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `energy_charge_amount` SET TAGS ('dbx_business_glossary_term' = 'Energy Charge Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `fac_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Fuel Adjustment Clause (FAC) Adjustment Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'regular|final|adjustment|estimated|corrected');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `meter_read_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Type');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `meter_read_type` SET TAGS ('dbx_value_regex' = 'actual|estimated|customer_read');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `outstanding_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Outstanding Balance Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `payment_plan_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Plan Flag');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `payment_received_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `peak_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Peak Demand Kilowatts (kW)');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `previous_balance_amount` SET TAGS ('dbx_business_glossary_term' = 'Previous Balance Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `print_date` SET TAGS ('dbx_business_glossary_term' = 'Print Date');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `regulatory_rider_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rider Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `total_amount_due` SET TAGS ('dbx_business_glossary_term' = 'Total Amount Due');
ALTER TABLE `power_and_utilities`.`billing`.`invoice` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `charge_description` SET TAGS ('dbx_business_glossary_term' = 'Charge Description');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `charge_type_code` SET TAGS ('dbx_business_glossary_term' = 'Charge Type Code');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `disputed_flag` SET TAGS ('dbx_business_glossary_term' = 'Disputed Flag');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Number');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `print_sequence` SET TAGS ('dbx_business_glossary_term' = 'Print Sequence');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `proration_factor` SET TAGS ('dbx_business_glossary_term' = 'Proration Factor');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `rate_component_code` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Code');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `regulatory_rider_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rider Code');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `revenue_class_code` SET TAGS ('dbx_business_glossary_term' = 'Revenue Class Code');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `revenue_class_code` SET TAGS ('dbx_value_regex' = 'RESIDENTIAL|COMMERCIAL|INDUSTRIAL|STREET_LIGHTING|PUBLIC_AUTHORITY|WHOLESALE');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'ELECTRIC|GAS');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Code');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = 'CC&B|IS-U|MDMS|ERP|MANUAL');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `taxable_flag` SET TAGS ('dbx_business_glossary_term' = 'Taxable Flag');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `total_line_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Line Amount');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate');
ALTER TABLE `power_and_utilities`.`billing`.`invoice_line` ALTER COLUMN `usage_quantity` SET TAGS ('dbx_business_glossary_term' = 'Usage Quantity');
ALTER TABLE `power_and_utilities`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'account_settlement');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `collections_case_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `payment_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `allocation_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Allocation Method');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `allocation_method` SET TAGS ('dbx_value_regex' = 'fifo|lifo|pro_rata|customer_directed|oldest_first');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Amount');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `applied_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Applied Amount');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `auto_pay_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto-Pay Flag');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `bank_account_number_last_four` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number Last Four Digits');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `bank_account_number_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `bank_account_number_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `bank_account_number_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `batch_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Batch Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `budget_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Flag');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_value_regex' = '^[0-9]{1,10}$');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `cleared_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Cleared Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Confirmation Number');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Last Four Digits');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `credit_card_last_four` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_business_glossary_term' = 'Credit Card Type');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_value_regex' = 'visa|mastercard|amex|discover');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `credit_card_type` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Currency Code');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `gl_posting_date` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Date');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `method_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Method Type');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `nsf_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Non-Sufficient Funds (NSF) Fee Amount');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Transaction Date');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Processing Status');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `posted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Posted Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `processor_name` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Name');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `processor_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Payment Processor Transaction Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `received_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Received Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `reversal_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Reversal Date');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `reversal_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Reversal Reason');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Payment Source System');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `third_party_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Third-Party Payment Agency Name');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `token` SET TAGS ('dbx_business_glossary_term' = 'Payment Token');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `token` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `token` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `unapplied_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Unapplied Amount');
ALTER TABLE `power_and_utilities`.`billing`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` SET TAGS ('dbx_subdomain' = 'account_settlement');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `payment_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `collections_action_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Collections Action Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `actual_completion_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Completion Date');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Approval Date');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_end_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement End Date');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Notes');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Number');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_value_regex' = '^PA-[0-9]{8,12}$');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_start_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Start Date');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Status');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_status` SET TAGS ('dbx_value_regex' = 'pending|active|broken|completed|cancelled|suspended');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Type');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_value_regex' = 'budget_billing|levelized_payment|low_income_assistance|collections_installment|deferred_payment|custom');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `auto_pay_enrolled` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Enrollment Flag');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `broken_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Broken Date');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason Code');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_value_regex' = 'customer_request|account_closed|service_disconnected|refinanced|policy_violation|administrative');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `cancelled_date` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Cancelled Date');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `down_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Down Payment Amount');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `grace_period_days` SET TAGS ('dbx_business_glossary_term' = 'Grace Period Days');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `installment_amount` SET TAGS ('dbx_business_glossary_term' = 'Installment Payment Amount');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Installment Payment Frequency');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `installment_frequency` SET TAGS ('dbx_value_regex' = 'weekly|biweekly|monthly|quarterly');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `installments_missed` SET TAGS ('dbx_business_glossary_term' = 'Installments Missed Count');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `installments_paid` SET TAGS ('dbx_business_glossary_term' = 'Installments Paid Count');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `interest_accrued` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrued Amount');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `next_installment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Installment Due Date');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `notification_preference` SET TAGS ('dbx_business_glossary_term' = 'Payment Reminder Notification Preference');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `notification_preference` SET TAGS ('dbx_value_regex' = 'email|sms|mail|phone|none');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `number_of_installments` SET TAGS ('dbx_business_glossary_term' = 'Number of Installments');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Assistance Program Code');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `power_and_utilities`.`billing`.`payment_arrangement` ALTER COLUMN `total_deferred_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Deferred Amount');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` SET TAGS ('dbx_subdomain' = 'account_settlement');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `collections_case_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Case ID');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `payment_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement ID');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `actual_disconnect_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Disconnect Date');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `agency_referral_date` SET TAGS ('dbx_business_glossary_term' = 'Collections Agency Referral Date');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `assigned_collections_agent` SET TAGS ('dbx_business_glossary_term' = 'Assigned Collections Agent');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `bankruptcy_case_number` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Case Number');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `bankruptcy_filing_date` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Filing Date');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `bankruptcy_flag` SET TAGS ('dbx_business_glossary_term' = 'Bankruptcy Flag');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `case_closed_date` SET TAGS ('dbx_business_glossary_term' = 'Collections Case Closed Date');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `case_number` SET TAGS ('dbx_business_glossary_term' = 'Collections Case Number');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `case_opened_date` SET TAGS ('dbx_business_glossary_term' = 'Collections Case Opened Date');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `case_status` SET TAGS ('dbx_business_glossary_term' = 'Collections Case Status');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `collections_agency_name` SET TAGS ('dbx_business_glossary_term' = 'Collections Agency Name');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `collections_cost` SET TAGS ('dbx_business_glossary_term' = 'Collections Cost');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `collections_stage` SET TAGS ('dbx_business_glossary_term' = 'Collections Stage');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `collections_stage` SET TAGS ('dbx_value_regex' = 'dunning_notice|disconnect_warning|field_disconnect_order|collections_agency|legal_collections|write_off');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Email Address');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone Number');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `disconnect_order_date` SET TAGS ('dbx_business_glossary_term' = 'Disconnect Order Date');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `disconnect_warning_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Disconnect Warning Sent Date');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `dunning_notice_sent_date` SET TAGS ('dbx_business_glossary_term' = 'Dunning Notice Sent Date');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `last_contact_method` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Method');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `last_contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|mail|in_person|sms');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `legal_action_date` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Date');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `legal_action_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Flag');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Collections Case Notes');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `original_debt_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Debt Amount');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `past_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Past Due Amount');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `payment_arrangement_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Flag');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `resolution_outcome` SET TAGS ('dbx_business_glossary_term' = 'Collections Resolution Outcome');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'electric|gas|electric_and_gas');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `total_recovered_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Recovered Amount');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `write_off_amount` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Amount');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Date');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `write_off_flag` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Flag');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_business_glossary_term' = 'Write-Off Reason');
ALTER TABLE `power_and_utilities`.`billing`.`collections_case` ALTER COLUMN `write_off_reason` SET TAGS ('dbx_value_regex' = 'uncollectible|bankruptcy_discharge|deceased_customer|account_closed|statute_of_limitations|other');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `bill_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Dispute Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `adjustment_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{2,4}$');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `assigned_analyst_code` SET TAGS ('dbx_business_glossary_term' = 'Assigned Analyst Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `assigned_department` SET TAGS ('dbx_business_glossary_term' = 'Assigned Department');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `assigned_department` SET TAGS ('dbx_value_regex' = 'customer_service|billing_operations|meter_services|revenue_protection|regulatory_affairs');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `billing_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `billing_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Closed Date');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `credit_amount` SET TAGS ('dbx_business_glossary_term' = 'Credit Amount');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Email Address');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `customer_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Name');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `customer_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Customer Contact Phone Number');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `customer_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `customer_satisfaction_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Satisfaction Rating');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `dispute_description` SET TAGS ('dbx_business_glossary_term' = 'Dispute Description');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_value_regex' = '^DSP-[0-9]{8,12}$');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `dispute_open_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Open Date');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `dispute_open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Open Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Code');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `dispute_reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,4}-[0-9]{2,4}$');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `disputed_kwh` SET TAGS ('dbx_business_glossary_term' = 'Disputed Kilowatt-Hours (kWh)');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `disputed_mcf` SET TAGS ('dbx_business_glossary_term' = 'Disputed Thousand Cubic Feet (MCF)');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `escalation_date` SET TAGS ('dbx_business_glossary_term' = 'Escalation Date');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_business_glossary_term' = 'Escalation Level');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `escalation_level` SET TAGS ('dbx_value_regex' = 'tier_1|tier_2|tier_3|management|executive|regulatory');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `investigation_notes` SET TAGS ('dbx_business_glossary_term' = 'Investigation Notes');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `meter_read_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Type');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `meter_read_type` SET TAGS ('dbx_value_regex' = 'actual|estimated|customer_read|remote|ami');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `puc_complaint_flag` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Complaint Flag');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `puc_complaint_number` SET TAGS ('dbx_business_glossary_term' = 'Public Utility Commission (PUC) Complaint Number');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `puc_complaint_number` SET TAGS ('dbx_value_regex' = '^PUC-[A-Z]{2}-[0-9]{6,10}$');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `resolution_description` SET TAGS ('dbx_business_glossary_term' = 'Resolution Description');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'electric|gas|dual_fuel');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `sla_actual_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Actual Days');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `sla_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Compliance Flag');
ALTER TABLE `power_and_utilities`.`billing`.`bill_dispute` ALTER COLUMN `sla_target_days` SET TAGS ('dbx_business_glossary_term' = 'Service Level Agreement (SLA) Target Days');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` SET TAGS ('dbx_subdomain' = 'account_settlement');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `credit_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Adjustment ID');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `bill_dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Case ID');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `collections_case_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Case ID');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `commission_order_id` SET TAGS ('dbx_business_glossary_term' = 'Commission Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `distribution_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event ID');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Bill ID');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `invoice_line_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `primary_reversal_of_adjustment_credit_adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Reversal of Adjustment ID');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `settlement_statement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Statement Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_value_regex' = '^ADJ-[0-9]{10}$');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|posted|reversed|rejected|cancelled');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Approved By User ID');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `approved_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By User Name');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `approved_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `authorization_level` SET TAGS ('dbx_business_glossary_term' = 'Authorization Level');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Created By User ID');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `created_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `customer_notification_sent` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Sent');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Posting Status');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `gl_posting_status` SET TAGS ('dbx_value_regex' = 'not_posted|posted|posting_failed|reversed');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `last_modified_by_user_code` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By User ID');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `last_modified_by_user_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `last_modified_by_user_code` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Notification Date');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reason Code');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Reason Description');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `regulatory_program_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Program Code');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'electric|gas|both');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'CC&B|SAP_IS_U|CRM|MDMS|ERP|MANUAL');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `source_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Source Transaction ID');
ALTER TABLE `power_and_utilities`.`billing`.`credit_adjustment` ALTER COLUMN `tax_impact_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Impact Amount');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `billing_service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Service Agreement ID');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `bill_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Code');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `party_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `payment_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement ID');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `activated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Activated Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Number');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Status');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `agreement_status` SET TAGS ('dbx_value_regex' = 'active|pending|suspended|final|cancelled');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Type');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `agreement_type` SET TAGS ('dbx_value_regex' = 'electric|gas|dual_fuel');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `auto_pay_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Enrolled Flag');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `average_monthly_usage_kwh` SET TAGS ('dbx_business_glossary_term' = 'Average Monthly Usage (kWh)');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `average_monthly_usage_mcf` SET TAGS ('dbx_business_glossary_term' = 'Average Monthly Usage (MCF)');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `budget_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Enrolled Flag');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'current|past_due|collection|payment_plan|suspended|write_off');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'electric|gas');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `contract_demand_kw` SET TAGS ('dbx_business_glossary_term' = 'Contract Demand (kW)');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Customer Credit Rating');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `credit_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|no_rating');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `credit_rating` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `current_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|public_authority');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `deposit_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `deposit_held_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Held Date');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `end_date` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement End Date');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `last_bill_date` SET TAGS ('dbx_business_glossary_term' = 'Last Bill Date');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `life_support_flag` SET TAGS ('dbx_business_glossary_term' = 'Life Support Equipment Flag');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `life_support_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `load_profile_code` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Code');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `low_income_qualified_flag` SET TAGS ('dbx_business_glossary_term' = 'Low Income Qualified Flag');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `low_income_qualified_flag` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `nem_enrolled_flag` SET TAGS ('dbx_business_glossary_term' = 'Net Energy Metering (NEM) Enrolled Flag');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Notes');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `paperless_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Enrolled Flag');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `premise_type` SET TAGS ('dbx_business_glossary_term' = 'Premise Type');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `service_voltage_level` SET TAGS ('dbx_business_glossary_term' = 'Service Voltage Level');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `service_voltage_level` SET TAGS ('dbx_value_regex' = 'secondary|primary|transmission');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `special_rate_rider_codes` SET TAGS ('dbx_business_glossary_term' = 'Special Rate Rider Codes');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Start Date');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `terminated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Service Terminated Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Service Termination Reason');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `termination_reason` SET TAGS ('dbx_value_regex' = 'customer_request|move_out|non_payment|property_demolition|service_transfer|other');
ALTER TABLE `power_and_utilities`.`billing`.`billing_service_agreement` ALTER COLUMN `third_party_notification_flag` SET TAGS ('dbx_business_glossary_term' = 'Third Party Notification Flag');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` SET TAGS ('dbx_subdomain' = 'revenue_pricing');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `bill_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Cycle Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `superseded_by_bill_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Superseded By Bill Cycle Identifier (ID)');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `auto_pay_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Auto Pay Eligible Flag');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `bill_date` SET TAGS ('dbx_business_glossary_term' = 'Bill Date Day of Month');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `bill_generation_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Bill Generation Offset Days');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `budget_billing_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Eligible Flag');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'electric|gas|dual');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `customer_class` SET TAGS ('dbx_business_glossary_term' = 'Customer Class');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `customer_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|municipal|wholesale');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Description');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `cycle_frequency` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Frequency');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `cycle_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi-monthly|quarterly|annual|on-demand|special');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Name');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Status');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `estimated_account_count` SET TAGS ('dbx_business_glossary_term' = 'Estimated Account Count');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `estimated_billing_flag` SET TAGS ('dbx_business_glossary_term' = 'Estimated Billing Allowed Flag');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `meter_read_end_day` SET TAGS ('dbx_business_glossary_term' = 'Meter Read End Day');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `meter_read_start_day` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Start Day');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `paperless_billing_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Eligible Flag');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `payment_due_day` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Day of Month');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `payment_due_offset_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Offset Days');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `route_grouping` SET TAGS ('dbx_business_glossary_term' = 'Route Grouping');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `special_handling_flag` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Flag');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `tariff_book_reference` SET TAGS ('dbx_business_glossary_term' = 'Tariff Book Reference');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `territory_code` SET TAGS ('dbx_business_glossary_term' = 'Territory Code');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `territory_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{2,10}$');
ALTER TABLE `power_and_utilities`.`billing`.`bill_cycle` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities`.`billing`.`collections_action` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`billing`.`collections_action` SET TAGS ('dbx_subdomain' = 'account_settlement');
ALTER TABLE `power_and_utilities`.`billing`.`collections_action` ALTER COLUMN `collections_action_id` SET TAGS ('dbx_business_glossary_term' = 'Collections Action Identifier');
ALTER TABLE `power_and_utilities`.`billing`.`collections_action` ALTER COLUMN `associated_collections_action_id` SET TAGS ('dbx_self_ref_fk' = 'true');
