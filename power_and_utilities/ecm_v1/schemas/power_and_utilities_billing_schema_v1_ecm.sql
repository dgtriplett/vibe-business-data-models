-- Schema for Domain: billing | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:13

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`billing` COMMENT 'Single source of truth for all revenue transactions including invoice generation, rate schedule application, payment processing, adjustments, deposits, disputes, and collections. Manages residential and commercial billing cycles, TOU/CPP/RTP rate calculations, and revenue recognition per FASB ASC 980. Supports GRC and ROE reporting. Integrates with Oracle CC&B and SAP FI/CO for revenue posting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`bill` (
    `bill_id` BIGINT COMMENT 'System-generated unique identifier for the bill record.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Required for Account Profitability Report linking each bill to the CI account it serves, a standard utility finance process.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account associated with the bill.',
    `customer_customer_account_id` BIGINT COMMENT 'Unique identifier of the customer billed.',
    `nem_account_id` BIGINT COMMENT 'Foreign key linking to der.nem_account. Business justification: REQUIRED: NEM customer bills need to be tied to the corresponding NEM account for settlement, export credit tracking, and regulatory filing.',
    `der_program_enrollment_id` BIGINT COMMENT 'Foreign key linking to der.program_enrollment. Business justification: REQUIRED: Bills that include incentive credits must reference the specific DER program enrollment to calculate and report incentive amounts.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Required for GL posting of each bills revenue; financial statements and FERC reporting need bill-to-GL mapping.',
    `gridops_outage_event_id` BIGINT COMMENT 'Foreign key linking to gridops.gridops_outage_event. Business justification: Outage Compensation Billing Adjustment: credits applied to a bill based on recorded outage events, required for regulatory compliance and customer fairness.',
    `meter_id` BIGINT COMMENT 'FK to metering.meter.meter_id — Bills are generated from meter readings. This FK enables bill-to-meter traceability for billing disputes and meter accuracy investigations.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to engagement.opportunity. Business justification: Supports Opportunity Revenue Attribution report, tying generated bills back to the sales opportunity that created the contract.',
    `person_id` BIGINT COMMENT 'Unique identifier of the customer billed.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Regulatory bill generation requires linking each bill to the exact rate schedule applied, enabling audit of rates per billing period.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: Each bill’s rates are derived from an approved rate case; linking provides traceability for rate case approvals and regulatory filings.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Regulatory reporting requires each bill to reference the SCADA system that supplied the usage data for data provenance.',
    `service_agreement_id` BIGINT COMMENT 'Foreign key linking to customer.service_agreement. Business justification: Bills are generated based on a specific service agreement; linking enables audit of charges against contract terms required for compliance reporting.',
    `settlement_id` BIGINT COMMENT 'Foreign key linking to trading.settlement. Business justification: Regulatory settlement allocation report requires linking each retail bill to the wholesale settlement that funded the electricity supply.',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Bills reference the tariff schedule that defines rates and fees; linking supports audit of rate applicability and regulatory compliance.',
    `transmission_outage_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_outage. Business justification: Outage Credit Bill: bills that include outage credits must reference the originating transmission outage for regulatory reporting.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment applied to the bill (e.g., billing error correction).',
    `arrears_balance` DECIMAL(18,2) COMMENT 'Outstanding balance carried forward from previous billing periods.',
    `bill_number` STRING COMMENT 'Business-visible invoice number assigned by the billing system.',
    `bill_status` STRING COMMENT 'Current lifecycle status of the bill.. Valid values are `draft|issued|paid|cancelled|void`',
    `bill_type` STRING COMMENT 'Classification of the bill (e.g., regular, final, corrected, adjustment).. Valid values are `regular|final|corrected|adjustment`',
    `billing_period_end` DATE COMMENT 'Last day of the consumption period covered by the bill.',
    `billing_period_start` DATE COMMENT 'First day of the consumption period covered by the bill.',
    `collection_status` STRING COMMENT 'Current status of the collection process for unpaid bills.. Valid values are `none|in_process|sent_to_agency|closed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the bill record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the bill amounts.',
    `cycle` STRING COMMENT 'Frequency of the billing cycle.. Valid values are `monthly|quarterly|annual`',
    `demand_charge` DECIMAL(18,2) COMMENT 'Charge based on peak demand during the billing period.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount granted on the bill.',
    `dispute_close_date` DATE COMMENT 'Date when the dispute was resolved or closed.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the bill is under a customer dispute.',
    `dispute_open_date` DATE COMMENT 'Date when the dispute was opened.',
    `dispute_reason` STRING COMMENT 'Reason provided by the customer for disputing the bill.',
    `due_date` DATE COMMENT 'Date by which payment is required.',
    `energy_charge` DECIMAL(18,2) COMMENT 'Charge for energy consumption based on the applicable rate.',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether the bill has been reconciled in the finance system.',
    `issue_timestamp` TIMESTAMP COMMENT 'Date and time when the bill was generated and issued to the customer.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for late payment, if applicable.',
    `late_fee_applied` BOOLEAN COMMENT 'Indicates whether a late fee has been applied to the bill.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount due after taxes, discounts, and adjustments.',
    `payment_date` DATE COMMENT 'Date on which the payment was received.',
    `payment_method` STRING COMMENT 'Method used by the customer to pay the bill.. Valid values are `credit_card|bank_transfer|check|cash|online|direct_debit`',
    `payment_status` STRING COMMENT 'Current status of payment for the bill.. Valid values are `unpaid|paid|partial|failed|refunded`',
    `rate_plan_name` STRING COMMENT 'Descriptive name of the rate plan used for billing.',
    `reconciliation_date` DATE COMMENT 'Date on which the bill was reconciled.',
    `regulatory_fee_amount` DECIMAL(18,2) COMMENT 'Amount of regulatory fees imposed by governing bodies.',
    `revenue_recognition_amount` DECIMAL(18,2) COMMENT 'Amount of revenue recognized for this bill.',
    `revenue_recognition_date` DATE COMMENT 'Date on which the bill revenue is recognized per FASB ASC 980.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax applied to the bill.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the bill is exempt from tax.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross amount before discounts, taxes, and adjustments.',
    `total_kwh` DECIMAL(18,2) COMMENT 'Total electricity consumption in kilowatt‑hours for the billing period.',
    `total_mcf` DECIMAL(18,2) COMMENT 'Total natural gas consumption in thousand cubic feet for the billing period.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the bill record.',
    `usage_type` STRING COMMENT 'Customer classification for usage (e.g., residential, commercial).. Valid values are `residential|commercial|industrial|government`',
    CONSTRAINT pk_bill PRIMARY KEY(`bill_id`)
) COMMENT 'Core billing document representing the periodic invoice issued to a residential or commercial customer for energy consumption (kWh, MCF, Therm) and applicable charges. Captures billing period, due date, total amount due, bill type (regular, final, corrected), bill status, and source system reference from Oracle CC&B. Serves as the SSOT for all customer-facing billing documents and is the anchor entity for revenue recognition per FASB ASC 980.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` (
    `bill_line_item_id` BIGINT COMMENT 'System-generated unique identifier for each bill line item record.',
    `bill_id` BIGINT COMMENT 'Identifier of the parent bill (transaction header) to which this line belongs.',
    `billing_rate_component_id` BIGINT COMMENT 'Identifier of the specific rate component (e.g., energy, demand, service) applied.',
    `dr_dispatch_event_id` BIGINT COMMENT 'Foreign key linking to gridops.dr_dispatch_event. Business justification: Demand‑Response Settlement: line items need to reference the DR dispatch event that generated the DR credit or charge for accurate settlement.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who performed the last audit action on the line.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each line item maps to a specific GL account (energy, demand, tax); needed for detailed revenue accounting.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Smart‑meter asset cost recovery requires each line item to be tied to the physical IT asset that generated the reading.',
    `meter_id` BIGINT COMMENT 'Meter whose reading contributed to the line item.',
    `metering_service_point_id` BIGINT COMMENT 'Foreign key linking to metering.metering_service_point. Business justification: Regulatory NEM eligibility and detailed consumption reporting require each bill line item to reference the metering service point that supplied the meter data.',
    `tou_period_id` BIGINT COMMENT 'Foreign key linking to product.tou_period. Business justification: Each line item’s time‑of‑use period must reference the defined TOU period for accurate rate application and compliance reporting.',
    `rate_schedule_id` BIGINT COMMENT 'FK to product.rate_schedule.rate_schedule_id — Each bill line item is calculated under a specific rate schedule. This FK enables billing-to-rate-catalog joins for rate validation and revenue analysis.',
    `resource_id` BIGINT COMMENT 'Foreign key linking to der.der_resource. Business justification: REQUIRED: Export‑credit line items must reference the specific DER unit; used in net‑metering settlement reports and incentive calculations.',
    `service_agreement_id` BIGINT COMMENT 'FK to customer.service_agreement.service_agreement_id — Bill line items must reference the service agreement to determine which rate schedule applies. Critical for rate application validation and billing accuracy.',
    `product_tariff_rider_id` BIGINT COMMENT 'FK to regulatory.tariff_rider.tariff_rider_id — Bill line items applying tariff riders must reference the regulatory-approved rider. With billing.tariff_rider not present as a separate entity, this FK to regulatory.tariff_rider enables rider charge',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Labor charge line items must attribute work to the performing technician for cost allocation, regulatory reporting, and crew performance analysis.',
    `trade_leg_id` BIGINT COMMENT 'Foreign key linking to trading.trade_leg. Business justification: Detailed compliance reporting links line items to specific trade legs for accurate cost breakdown.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Transmission Service Charge line items are tied to a specific transmission line, enabling accurate line‑usage billing and compliance with NERC reporting.',
    `work_order_id` BIGINT COMMENT 'Foreign key linking to asset.work_order. Business justification: Line items representing repair or service charges must reference the originating work order for audit trails and regulatory cost‑of‑service reporting.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary adjustment (positive or negative) applied to the line.',
    `bill_line_item_description` STRING COMMENT 'Free‑form text describing the charge or credit.',
    `bill_line_item_status` STRING COMMENT 'Current processing state of the line item.. Valid values are `pending|posted|reversed|void`',
    `billing_days` STRING COMMENT 'Number of days covered by the billing period for this line.',
    `charge_type` STRING COMMENT 'Category of the charge or credit applied on the line.. Valid values are `usage|demand|fixed|tax|credit|adjustment`',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the charge for allocation purposes.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line item record was created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values.. Valid values are `USD|CAD|EUR`',
    `demand_factor` DECIMAL(18,2) COMMENT 'Multiplier applied to demand‑based charges.',
    `determinant_type` STRING COMMENT 'Basis used to determine the charge amount (e.g., consumption, demand).. Valid values are `consumption|demand|capacity|service|other`',
    `discount_indicator` BOOLEAN COMMENT 'True if a discount is applied to this line.',
    `estimation_flag` BOOLEAN COMMENT 'True if the charge is based on estimated usage rather than actual meter reading.',
    `extended_amount` DECIMAL(18,2) COMMENT 'Calculated amount before taxes, discounts, or adjustments (quantity × unit_rate).',
    `invoice_number` STRING COMMENT 'Identifier of the invoice that contains this line item.',
    `is_legacy` BOOLEAN COMMENT 'True if the line originates from a legacy billing system.',
    `line_sequence` STRING COMMENT 'Sequential order of the line item within the bill.',
    `load_profile_type` STRING COMMENT 'Customer load classification used for rate application.. Valid values are `residential|commercial|industrial`',
    `market_region_code` STRING COMMENT 'Code representing the geographic market region (e.g., ISO‑NE, ERCOT).',
    `net_amount` DECIMAL(18,2) COMMENT 'Final amount after tax, discounts, and adjustments.',
    `peak_indicator` BOOLEAN COMMENT 'True if the consumption occurred during a peak period.',
    `quantity` DECIMAL(18,2) COMMENT 'Measured amount that the charge is based on (e.g., kWh, MCF).',
    `read_end_date` DATE COMMENT 'End date of the meter reading interval used for the charge.',
    `read_start_date` DATE COMMENT 'Start date of the meter reading interval used for the charge.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the line must be reported for regulatory compliance (e.g., GRC, FERC).',
    `revenue_recognition_date` DATE COMMENT 'Date on which revenue for this line is recognized per ASC 980.',
    `settlement_type` STRING COMMENT 'Market settlement category for the charge.. Valid values are `real_time|day_ahead|monthly`',
    `source_system` STRING COMMENT 'System of record that generated the line item.. Valid values are `ccnb|sap|mdm`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax monetary value applied to the line.',
    `tax_indicator` BOOLEAN COMMENT 'True if the line is subject to tax.',
    `unit_of_measure` STRING COMMENT 'Unit in which the quantity is expressed.. Valid values are `kWh|MCF|Therm|kW|USD_per_kWh|USD_per_MCF`',
    `unit_rate` DECIMAL(18,2) COMMENT 'Rate applied per unit of measure (e.g., $0.12 per kWh).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the line item.',
    CONSTRAINT pk_bill_line_item PRIMARY KEY(`bill_line_item_id`)
) COMMENT 'Individual charge or credit line on a customer bill, representing a specific rate component application with its calculated billing determinant. Captures charge type, rate schedule code, rate component reference, determinant type, quantity (kWh, MCF, Therm, kW demand), unit rate, extended amount, TOU period classification, estimation flag, read start/end dates, and number of billing days. Supports granular revenue decomposition, GRC rate case analysis, and bridges validated meter data to billed amounts.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`payment` (
    `payment_id` BIGINT COMMENT 'System-generated unique identifier for the payment transaction.',
    `bank_account_id` BIGINT COMMENT 'Foreign key linking to finance.bank_account. Business justification: Payments are deposited into bank accounts; linking enables cash reconciliation and treasury reporting.',
    `bill_id` BIGINT COMMENT 'Identifier of the invoice to which this payment is applied.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Payments are applied to a billing account for balance reconciliation; needed for accurate accounts‑receivable tracking and financial statements.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Needed for Payment Reconciliation per CI account, enabling finance to match payments against the correct customer account.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who made the payment.',
    `invoice_bill_id` BIGINT COMMENT 'Identifier of the invoice to which this payment is applied.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: Payments are processed by a specific IT service; linking enables financial audit of service performance and compliance.',
    `nem_true_up_id` BIGINT COMMENT 'Foreign key linking to der.nem_true_up. Business justification: REQUIRED: Payments for net‑metering true‑up settlements must be linked to the true‑up record for audit, reconciliation and regulatory compliance.',
    `person_id` BIGINT COMMENT 'Identifier of the customer who made the payment.',
    `amount_adjustments` DECIMAL(18,2) COMMENT 'Sum of discounts, fees, taxes, or other adjustments applied to the gross amount.',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount received before any adjustments, taxes, or fees.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount posted to the customers account after adjustments.',
    `bank_transaction_reference` STRING COMMENT 'Identifier returned by the banking institution for the transaction.',
    `channel` STRING COMMENT 'Channel through which the payment was submitted.. Valid values are `web|ivr|walk_in|lockbox|mobile_app|agent`',
    `check_number` STRING COMMENT 'Number of the paper check when payment_method is check.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the payment (e.g., USD, EUR).',
    `dispute_flag` BOOLEAN COMMENT 'True if the payment is currently under dispute.',
    `dispute_reason` STRING COMMENT 'Text description of the reason for the payment dispute.',
    `external_reference` STRING COMMENT 'Reference identifier from an external system (e.g., third‑party payment gateway).',
    `is_auto_pay` BOOLEAN COMMENT 'True if the payment was processed via an auto‑pay arrangement.',
    `is_refund` BOOLEAN COMMENT 'True if the transaction represents a refund to the customer.',
    `notes` STRING COMMENT 'Free‑form text notes entered by staff or the customer.',
    `payment_method` STRING COMMENT 'Instrument used to make the payment.. Valid values are `check|ach|credit_card|cash|auto_pay|other`',
    `payment_number` STRING COMMENT 'External business identifier assigned to the payment, used in customer communications and audit trails.',
    `payment_status` STRING COMMENT 'Current lifecycle state of the payment.. Valid values are `pending|posted|failed|reversed|cancelled`',
    `payment_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment was received or initiated.',
    `posting_status` STRING COMMENT 'Status of the payments posting to the general ledger.. Valid values are `not_posted|posted|error`',
    `posting_timestamp` TIMESTAMP COMMENT 'Timestamp when the payment was posted to the general ledger.',
    `receipt_number` STRING COMMENT 'Number of the receipt generated for the payment.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Amount finally settled after any reversals or adjustments.',
    `settlement_date` DATE COMMENT 'Date on which the payment was settled with the bank.',
    `source_detail` STRING COMMENT 'Additional detail about the source channel (e.g., terminal ID, agent name).',
    `tender_type` STRING COMMENT 'Classification of the payment tender (e.g., full payment, partial, deposit).. Valid values are `full|partial|deposit|advance`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the payment record.',
    CONSTRAINT pk_payment PRIMARY KEY(`payment_id`)
) COMMENT 'Record of a customer payment transaction applied against outstanding bill balances. Captures payment date, payment method (check, ACH, credit card, cash, auto-pay), payment amount, tender type, payment source channel (web, IVR, walk-in, lockbox), and posting status. Integrates with SAP FI/CO for revenue posting and Oracle CC&B for balance application. SSOT for all customer payment events.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` (
    `payment_arrangement_id` BIGINT COMMENT 'System-generated unique identifier for the payment arrangement.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Customer Service Arrangement Tracking ties each payment arrangement to the employee who created/approved it for accountability and regulatory oversight.',
    `billing_account_id` BIGINT COMMENT 'Identifier of the billing account associated with the arrangement.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who holds the payment arrangement.',
    `person_id` BIGINT COMMENT 'Identifier of the customer who holds the payment arrangement.',
    `arrangement_number` STRING COMMENT 'External business identifier or reference number for the arrangement, used in customer communications and billing.',
    `arrangement_type` STRING COMMENT 'Category of the arrangement: installment plan, deferred payment agreement, or budget billing.. Valid values are `installment|deferred|budget`',
    `breach_date` DATE COMMENT 'Date on which the arrangement entered breach status.',
    `breach_flag` BOOLEAN COMMENT 'True if the arrangement is in breach of its terms.',
    `budget_estimated_annual_usage` DECIMAL(18,2) COMMENT 'Projected annual energy usage (e.g., kWh) used to calculate budget billing amounts.',
    `budget_monthly_amount` DECIMAL(18,2) COMMENT 'Fixed monthly amount billed under a budget billing arrangement.',
    `collection_action_date` DATE COMMENT 'Date the most recent collection action was initiated.',
    `collection_action_status` STRING COMMENT 'Current status of any collection actions taken against the arrangement.. Valid values are `none|warning|legal|writeoff`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the arrangement record was first created in the system.',
    `cumulative_variance` DECIMAL(18,2) COMMENT 'Running total of the difference between budgeted and actual usage/charges.',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether the arrangement is under a customer dispute.',
    `dispute_reason` STRING COMMENT 'Free‑text description of the reason for the dispute.',
    `due_date` DATE COMMENT 'Next payment due date for the arrangement.',
    `effective_from` DATE COMMENT 'Date the payment arrangement becomes effective.',
    `effective_until` DATE COMMENT 'Date the payment arrangement ends or is scheduled to terminate (null for open‑ended).',
    `hardship_approval_date` DATE COMMENT 'Date the hardship program was approved for the arrangement.',
    `hardship_program_flag` BOOLEAN COMMENT 'Indicates whether the customer is enrolled in a hardship or affordability program.',
    `installment_count` STRING COMMENT 'Total number of installments defined in the arrangement.',
    `installment_number` STRING COMMENT 'Sequence number of the most recent installment paid.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the outstanding balance, expressed as a decimal (e.g., 0.0750 for 7.5%).',
    `last_payment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent payment.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment received under the arrangement.',
    `last_payment_method` STRING COMMENT 'Payment method used for the most recent payment.. Valid values are `credit_card|bank_transfer|check|cash|online`',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the arrangement.',
    `payment_arrangement_status` STRING COMMENT 'Current lifecycle status of the arrangement.. Valid values are `active|inactive|suspended|closed|pending`',
    `payment_channel` STRING COMMENT 'Channel through which the payment was made (e.g., web portal, mobile app).. Valid values are `web|mobile|call_center|mail`',
    `payment_method` STRING COMMENT 'Instrument used for payments under the arrangement.. Valid values are `credit_card|bank_transfer|check|cash|online`',
    `penalty_amount` DECIMAL(18,2) COMMENT 'Monetary penalty assessed for missed or late payments.',
    `penalty_applied` BOOLEAN COMMENT 'Indicates whether a penalty has been applied to the current installment.',
    `remaining_balance` DECIMAL(18,2) COMMENT 'Outstanding balance remaining on the arrangement.',
    `scheduled_payment_amount` DECIMAL(18,2) COMMENT 'Amount that is scheduled to be paid on each due date.',
    `scheduled_payment_date` DATE COMMENT 'Date on which the scheduled payment is due.',
    `status_reason` STRING COMMENT 'Explanation for the current status, such as reason for suspension or closure.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the payment arrangement at inception.',
    `true_up_date` DATE COMMENT 'Date of the most recent true‑up reconciliation.',
    `true_up_frequency` STRING COMMENT 'How often the budget billing is reconciled against actual usage.. Valid values are `monthly|quarterly|annually`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the arrangement record.',
    CONSTRAINT pk_payment_arrangement PRIMARY KEY(`payment_arrangement_id`)
) COMMENT 'Formal installment plan, deferred payment agreement, or budget billing (levelized billing) plan established for customers. Captures arrangement type (installment plan, deferred payment agreement, budget billing), scheduled amounts, due dates, total deferred or levelized balance, arrangement status, default/breach tracking, and for budget billing: estimated annual usage, monthly budget amount, true-up frequency, true-up date, and cumulative variance. Supports collections workflow, customer hardship program management, and residential affordability through payment smoothing.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`billing_account` (
    `billing_account_id` BIGINT COMMENT 'Unique surrogate key for the billing account.',
    `aggregation_group_id` BIGINT COMMENT 'Foreign key linking to der.aggregation_group. Business justification: REQUIRED: Accounts enrolled in aggregation programs need a link to the aggregation group for group‑level billing and market participation reporting.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer owning this billing account.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer owning this billing account.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: IT Service Management tracks which IT service (Billing Application) supports each account for cost allocation and SLA monitoring.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to trading.trading_portfolio. Business justification: Portfolio cost allocation reports assign wholesale portfolio costs to each billing account for rate recovery.',
    `premise_id` BIGINT COMMENT 'Identifier of the service location (meter point) associated with this account.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Account default rate schedule must be recorded to calculate future bills and satisfy rate‑schedule compliance reporting.',
    `location_id` BIGINT COMMENT 'Identifier of the service location (meter point) associated with this account.',
    `account_class` STRING COMMENT 'Classification of the account based on customer type.. Valid values are `residential|commercial|industrial|government|municipal`',
    `account_number` STRING COMMENT 'External account number assigned by the utility for billing purposes.',
    `arrears_balance` DECIMAL(18,2) COMMENT 'Outstanding amount past due, not yet paid.',
    `auto_pay_enrollment` BOOLEAN COMMENT 'Indicates whether the account is enrolled in automatic payment processing.',
    `billing_account_status` STRING COMMENT 'Current lifecycle status of the billing account.. Valid values are `active|inactive|suspended|closed|pending`',
    `billing_cycle_code` STRING COMMENT 'Code representing the assigned billing cycle (e.g., monthly, bi-monthly).',
    `budget_billing_enrollment` BOOLEAN COMMENT 'Indicates if the account participates in budget billing program.',
    `collection_agency` STRING COMMENT 'External agency handling collections for this account, if any.',
    `collection_status` STRING COMMENT 'Current status of collection activities for overdue balances.. Valid values are `not_started|in_progress|completed|failed`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the billing account record was created in the system.',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount allowed before service suspension.',
    `credit_score` STRING COMMENT 'Credit score of the account holder used for deposit and payment risk assessment.',
    `currency_code` STRING COMMENT 'ISO 4217 currency code for monetary amounts on the account.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `current_balance` DECIMAL(18,2) COMMENT 'Net amount due on the account after applying all charges and payments.',
    `deposit_balance` DECIMAL(18,2) COMMENT 'Current balance of any security deposit held for the account.',
    `effective_from` DATE COMMENT 'Date when the billing account became effective.',
    `effective_until` DATE COMMENT 'Date when the billing account is terminated or expected to end; null if open-ended.',
    `email_address` STRING COMMENT 'Primary email address for electronic billing communications.. Valid values are `^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$`',
    `enrollment_date` DATE COMMENT 'Date when the account was first enrolled in the billing system.',
    `is_suspended` BOOLEAN COMMENT 'Indicates if service is currently suspended due to non-payment.',
    `last_adjustment_amount` DECIMAL(18,2) COMMENT 'Amount of the most recent billing adjustment (credit or debit).',
    `last_collection_action_date` DATE COMMENT 'Date of the most recent collection activity.',
    `last_modified_by` STRING COMMENT 'User identifier who performed the most recent update.',
    `last_payment_date` DATE COMMENT 'Date of the most recent payment applied to the account.',
    `low_income_indicator` BOOLEAN COMMENT 'Flag indicating eligibility for low-income assistance programs.',
    `mailing_address` STRING COMMENT 'Postal address for paper billing (if not paperless).',
    `meter_number` STRING COMMENT 'Meter identifier that records consumption for this account.',
    `next_due_date` DATE COMMENT 'Date when the next invoice amount is due.',
    `paperless_enrollment` BOOLEAN COMMENT 'Indicates whether the account receives electronic invoices.',
    `payment_channel` STRING COMMENT 'Channel through which payments are typically submitted.. Valid values are `web|mobile_app|call_center|mail|in_person`',
    `payment_due_amount` DECIMAL(18,2) COMMENT 'Total amount due on the next invoice.',
    `payment_method` STRING COMMENT 'Preferred payment instrument for the account.. Valid values are `credit_card|bank_transfer|check|cash|online|direct_debit`',
    `phone_number` STRING COMMENT 'Primary contact phone number for the account.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates if the account is subject to special regulatory reporting (e.g., low-income assistance).',
    `suspension_reason` STRING COMMENT 'Reason code for account suspension.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the account is exempt from sales tax.',
    `tax_exempt_reason` STRING COMMENT 'Reason or code for tax exemption, if applicable.',
    `termination_date` DATE COMMENT 'Date when the account was terminated (if applicable).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the billing account record.',
    CONSTRAINT pk_billing_account PRIMARY KEY(`billing_account_id`)
) COMMENT 'Financial account entity representing the billable customer relationship for energy service delivery. Captures account number, account class (residential, commercial, industrial), billing cycle assignment, budget billing enrollment, paperless billing preference, auto-pay enrollment, credit score, deposit balance, current account balance, and current arrears balance. Serves as the SSOT for customer account balance and arrears tracking — all monetary movements (bills, payments, adjustments, deposits) update this entitys balance fields. Anchor for all billing transactions and the billing-domain counterpart to the customer master. One customer may have multiple billing accounts across service locations.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` (
    `billing_rate_component_id` BIGINT COMMENT 'System‑generated unique identifier for each rate component.',
    `product_rate_component_id` BIGINT COMMENT 'Foreign key linking to product.product_rate_component. Business justification: Billing components need to reference the master product rate component definition for regulatory audit and cost allocation.',
    `billing_rate_component_description` STRING COMMENT 'Narrative description providing context, regulatory references, or special conditions.',
    `billing_rate_component_name` STRING COMMENT 'Descriptive name of the pricing component (e.g., "On‑Peak Energy Charge").',
    `billing_rate_component_status` STRING COMMENT 'Operational status indicating whether the component is currently applied to customer bills.. Valid values are `active|inactive|retired|pending|draft|suspended`',
    `calculation_method` STRING COMMENT 'Logic applied to compute the charge (e.g., flat rate, block/tiered, time‑of‑use).. Valid values are `flat|block|step|time_of_use|critical_peak|real_time_pricing`',
    `component_type` STRING COMMENT 'Category of the component defining its billing purpose (e.g., energy usage, demand charge, fixed customer charge).. Valid values are `energy|demand|fixed|tax|rider|adjustment`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the rate component record was first created in the system.',
    `day_type` STRING COMMENT 'Calendar day classification for the component.. Valid values are `weekday|weekend|holiday`',
    `effective_end_date` DATE COMMENT 'Last calendar date on which the component may be applied; null indicates open‑ended.',
    `effective_start_date` DATE COMMENT 'First calendar date on which the component may be applied to billing.',
    `end_time` TIMESTAMP COMMENT 'Clock time when the components interval ends each day.',
    `is_eligible_for_abatement` BOOLEAN COMMENT 'True when the component may be reduced or waived under demand‑response programs.',
    `is_tax_exempt` BOOLEAN COMMENT 'True when the charge is not subject to sales or utility taxes.',
    `rate_amount` DECIMAL(18,2) COMMENT 'Charge amount associated with the component; may be a per‑unit price or a fixed fee.',
    `season` STRING COMMENT 'Season during which the component is applied.. Valid values are `summer|winter|spring|fall`',
    `start_time` TIMESTAMP COMMENT 'Clock time when the components interval begins each day.',
    `tier_end_quantity` DECIMAL(18,2) COMMENT 'Ending quantity threshold for a tiered pricing block; null indicates no upper limit.',
    `tier_start_quantity` DECIMAL(18,2) COMMENT 'Starting quantity threshold for a tiered pricing block.',
    `tou_period_name` STRING COMMENT 'Label for the TOU interval such as "On‑Peak", "Mid‑Peak", or "Off‑Peak".',
    `unit_of_measure` STRING COMMENT 'Measurement unit used for the component (e.g., kilowatt‑hour for energy, megawatt for demand).. Valid values are `kWh|kW|MCF|Therm|USD|percent`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the rate component record.',
    CONSTRAINT pk_billing_rate_component PRIMARY KEY(`billing_rate_component_id`)
) COMMENT 'Individual pricing component within a rate schedule, defining the specific charge calculation rules for energy (kWh), demand (kW), gas (MCF/Therm), fixed customer charges, taxes, and riders. Captures component type, unit of measure, block tier thresholds, seasonal applicability, rate amount, calculation algorithm reference, and TOU period classification (period name, season, day type, start/end times for on-peak, mid-peak, off-peak, super-peak, critical peak). Enables granular bill calculation, TOU/CPP/RTP interval billing, and rate case modeling.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`cycle` (
    `cycle_id` BIGINT COMMENT 'System-generated unique identifier for the billing cycle record.',
    `bill_due_date_offset` STRING COMMENT 'Number of days after bill generation that the payment due date is set.',
    `bill_generation_day` STRING COMMENT 'Day of month (1‑31) when the bill is generated for the cycle.',
    `billing_cycle_category` STRING COMMENT 'Indicates whether the cycle follows a standard template or a custom configuration.. Valid values are `standard|custom`',
    `billing_cycle_owner` STRING COMMENT 'Business unit or team responsible for managing this billing cycle.',
    `billing_cycle_priority` STRING COMMENT 'Numeric priority used when multiple cycles could apply to the same account.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the billing cycle record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for billing in this cycle.',
    `cycle_code` STRING COMMENT 'External business code used to reference the billing cycle in operational systems.',
    `cycle_description` STRING COMMENT 'Detailed free‑text description of the billing cycle, its scope and any special handling rules.',
    `cycle_name` STRING COMMENT 'Human‑readable name describing the purpose or grouping of the billing cycle.',
    `cycle_status` STRING COMMENT 'Current lifecycle status of the billing cycle.. Valid values are `active|inactive|suspended|pending|closed`',
    `cycle_type` STRING COMMENT 'Classification of the cycle based on customer segment or service offering.. Valid values are `residential|commercial|industrial|government|mixed`',
    `effective_end_date` DATE COMMENT 'Date when the billing cycle is retired; null for open‑ended cycles.',
    `effective_start_date` DATE COMMENT 'Date when the billing cycle becomes active and usable for processing.',
    `is_automated` BOOLEAN COMMENT 'Indicates whether the billing cycle runs are triggered automatically.',
    `is_default_cycle` BOOLEAN COMMENT 'True if this cycle is the default assignment for new accounts without explicit selection.',
    `last_run_accounts_processed` STRING COMMENT 'Count of customer accounts processed in the most recent run.',
    `last_run_bills_generated` STRING COMMENT 'Number of individual bills produced during the latest cycle execution.',
    `last_run_date` DATE COMMENT 'Date of the most recent batch execution for this billing cycle.',
    `last_run_error_count` STRING COMMENT 'Number of error records encountered during the last execution.',
    `last_run_status` STRING COMMENT 'Outcome status of the most recent billing cycle execution.. Valid values are `success|failure|partial|in_progress`',
    `notes` STRING COMMENT 'Free‑form comments or operational notes related to the cycle.',
    `number_of_accounts` STRING COMMENT 'Total number of customer accounts assigned to this billing cycle.',
    `read_frequency` STRING COMMENT 'How often meter data is collected for accounts in this cycle.. Valid values are `monthly|bi-monthly|quarterly|semi-annually|annually`',
    `regulatory_reporting_required` BOOLEAN COMMENT 'True if this cycle must be included in regulatory revenue or compliance reports.',
    `run_schedule_cron` STRING COMMENT 'Cron‑style expression defining the automated schedule for batch runs.',
    `scheduled_read_day` STRING COMMENT 'Day of month (1‑31) on which the meter reading is scheduled to occur.',
    `timezone` STRING COMMENT 'IANA time‑zone identifier applied to date calculations for the cycle.',
    `updated_by` STRING COMMENT 'Identifier of the user or process that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the most recent modification to the billing cycle record.',
    `version_number` STRING COMMENT 'Incremental version used for optimistic concurrency control.',
    `created_by` STRING COMMENT 'Identifier of the user or process that created the record.',
    CONSTRAINT pk_cycle PRIMARY KEY(`cycle_id`)
) COMMENT 'Definition and execution history of a billing cycle group that governs the schedule for meter reading, bill generation, and due date calculation for a set of accounts. Captures cycle code, cycle name, read frequency (monthly, bi-monthly), scheduled read date, bill generation date, bill due date offset (days), number of accounts in cycle, and batch run execution history (run date, accounts processed, bills generated, errors, run status). Used to orchestrate mass billing runs, manage billing workload distribution, and provide operational audit trail of billing execution.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`adjustment` (
    `adjustment_id` BIGINT COMMENT 'System-generated unique identifier for the adjustment transaction.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer account to which the adjustment applies.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer account to which the adjustment applies.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the adjustment.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Adjustments affect GL balances; linking ensures accurate posting to the correct revenue/expense account.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Billing adjustments often arise from safety incidents (damage compensation); linking adjustment to incident enables traceability for audit and regulatory reporting.',
    `person_id` BIGINT COMMENT 'Identifier of the employee who approved the adjustment.',
    `cycle_id` BIGINT COMMENT 'Identifier of the billing cycle to which the adjustment belongs.',
    `related_bill_cycle_id` BIGINT COMMENT 'Identifier of the billing cycle to which the adjustment belongs.',
    `bill_id` BIGINT COMMENT 'Identifier of the invoice that the adjustment offsets.',
    `related_invoice_bill_id` BIGINT COMMENT 'Identifier of the invoice that the adjustment offsets.',
    `reliability_event_id` BIGINT COMMENT 'Foreign key linking to gridops.reliability_event. Business justification: Reliability Event Settlement Adjustment: adjustments recorded on bills to reflect penalties or credits from reliability events per NERC reporting.',
    `transmission_outage_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_outage. Business justification: Outage Compensation Adjustments: adjustments are created to credit customers for transmission outages, requiring a link to the specific outage event.',
    `adjustment_category` STRING COMMENT 'High‑level category such as regulatory, customer service, or accounting.',
    `adjustment_number` STRING COMMENT 'Business-visible adjustment number assigned by the billing system.',
    `adjustment_status` STRING COMMENT 'Current lifecycle status of the adjustment.. Valid values are `pending|approved|rejected|posted|voided`',
    `adjustment_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was originally created in the business process.',
    `adjustment_type` STRING COMMENT 'Classification of the adjustment purpose: credit, debit, write‑off, rebate, goodwill, or bad debt.. Valid values are `credit|debit|write_off|rebate|goodwill|bad_debt`',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total monetary amount of the adjustment before taxes, fees, or other deductions.',
    `amount_net` DECIMAL(18,2) COMMENT 'Net monetary amount after taxes and fees; the amount that impacts the customer balance.',
    `amount_tax` DECIMAL(18,2) COMMENT 'Tax component associated with the adjustment, if applicable.',
    `approval_status` STRING COMMENT 'Current status of the adjustment approval workflow.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date and time when the adjustment was approved or rejected.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the adjustment record was first persisted in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code for the adjustment amounts.. Valid values are `^[A-Z]{3}$`',
    `delinquency_age` STRING COMMENT 'Number of days the account was delinquent at the time of write‑off.',
    `effective_date` DATE COMMENT 'Date on which the adjustment becomes effective for accounting purposes.',
    `expiration_date` DATE COMMENT 'Date after which the adjustment is no longer valid; null if indefinite.',
    `notes` STRING COMMENT 'Additional free‑form comments or internal remarks about the adjustment.',
    `prior_collection_actions` STRING COMMENT 'Summary of collection activities performed before the write‑off.',
    `reason_code` STRING COMMENT 'Standardized code representing the business reason for the adjustment.',
    `reason_description` STRING COMMENT 'Free‑text description of why the adjustment was applied.',
    `recovery_status` STRING COMMENT 'Indicates whether any amount was recovered after the write‑off.. Valid values are `recovered|unrecovered|partial`',
    `sap_bad_debt_reference` STRING COMMENT 'Reference key to the SAP FI/CO bad‑debt expense posting.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the adjustment record.',
    `write_off_date` DATE COMMENT 'Date on which a bad‑debt write‑off was recorded.',
    CONSTRAINT pk_adjustment PRIMARY KEY(`adjustment_id`)
) COMMENT 'Financial adjustment, write-off, or credit applied to a customer billing account to correct errors, apply credits, process bad debt write-offs, issue goodwill credits, or record rebates. Captures adjustment type (credit, debit, write-off, rebate, goodwill, bad_debt), reason code, amount, affected billing period, approval status, approver, and for write-offs: write-off date, delinquency age, prior collection actions taken, recovery status, and SAP FI/CO bad debt expense posting reference. Supports revenue correction workflows, bad debt reserve calculations for GRC filings, and FASB ASC 980 revenue recognition adjustments. Serves as the SSOT for all balance corrections including uncollectable account write-offs.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`deposit` (
    `deposit_id` BIGINT COMMENT 'System-generated unique identifier for the deposit record.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer who provided the deposit.',
    `customer_customer_account_id` BIGINT COMMENT 'Identifier of the customer who provided the deposit.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total interest or other adjustments accrued to the deposit.',
    `amount` DECIMAL(18,2) COMMENT 'Initial deposit amount received from the customer before any interest or adjustments.',
    `applied_to_bill_date` DATE COMMENT 'Date when the deposit was applied to a bill.',
    `applied_to_bill_flag` BOOLEAN COMMENT 'True if the deposit has been applied against a customer bill.',
    `balance` DECIMAL(18,2) COMMENT 'Current net balance of the deposit (original amount plus adjustments minus any applications).',
    `currency` STRING COMMENT 'Three‑letter ISO 4217 currency code of the deposit (e.g., USD, EUR).. Valid values are `^[A-Z]{3}$`',
    `deposit_date` DATE COMMENT 'Date the deposit was initially received from the customer.',
    `deposit_description` STRING COMMENT 'Free‑text description or notes about the deposit.',
    `deposit_number` STRING COMMENT 'External deposit reference number assigned by the utility for tracking and customer communication.',
    `deposit_status` STRING COMMENT 'Current lifecycle state of the deposit.. Valid values are `pending|active|released|refunded|cancelled|closed`',
    `deposit_type` STRING COMMENT 'Classification of the deposit based on its form.. Valid values are `cash|surety_bond|letter_of_credit`',
    `hold_expiration_date` DATE COMMENT 'Date when the hold on the deposit expires.',
    `hold_flag` BOOLEAN COMMENT 'Indicates whether the deposit is currently on hold.',
    `hold_reason` STRING COMMENT 'Reason for placing the deposit on hold (e.g., pending documentation).',
    `interest_accrual_end_date` DATE COMMENT 'Date when interest stopped accruing (e.g., when deposit is released).',
    `interest_accrual_frequency` STRING COMMENT 'How often interest is calculated and posted.. Valid values are `monthly|quarterly|annually`',
    `interest_accrual_method` STRING COMMENT 'Method used to calculate interest on the deposit.. Valid values are `simple|compound`',
    `interest_accrual_start_date` DATE COMMENT 'Date when interest began accruing on the deposit.',
    `interest_rate` DECIMAL(18,2) COMMENT 'Annual interest rate applied to the deposit (e.g., 0.0250 for 2.5%).',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the deposit record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the deposit record.',
    `refund_date` DATE COMMENT 'Date the deposit was actually refunded to the customer.',
    `refund_eligibility_date` DATE COMMENT 'Earliest date the deposit may be refunded to the customer per regulatory rules.',
    `refund_status` STRING COMMENT 'Current status of the refund process.. Valid values are `pending|processed|rejected|partial|full`',
    `regulatory_basis` STRING COMMENT 'Reference to the specific PUC or state regulation governing the deposit.',
    `release_date` DATE COMMENT 'Date the deposit was released or applied.',
    `release_reason` STRING COMMENT 'Reason for releasing or applying the deposit against a bill.',
    CONSTRAINT pk_deposit PRIMARY KEY(`deposit_id`)
) COMMENT 'Security deposit held by the utility against a customer account to mitigate credit risk. Captures deposit amount, deposit type (cash, surety bond, letter of credit), deposit date, interest accrual rate, interest accrual method, refund eligibility date, refund status, and regulatory basis (PUC deposit rules). Tracks the full lifecycle from collection through interest posting to refund or application against final bill.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`dispute` (
    `dispute_id` BIGINT COMMENT 'System-generated unique identifier for the billing dispute record.',
    `bill_id` BIGINT COMMENT 'Identifier of the specific invoice or bill that is being disputed.',
    `billing_account_id` BIGINT COMMENT 'Identifier of the customer account associated with the disputed bill.',
    `body_id` BIGINT COMMENT 'Foreign key linking to regulatory.regulatory_body. Business justification: Regulatory disputes must be filed with a specific regulatory body; linking enables compliance reporting and tracking of agency handling.',
    `customer_account_id` BIGINT COMMENT 'Unique identifier of the customer who raised the dispute.',
    `employee_id` BIGINT COMMENT 'Identifier of the internal agent handling the dispute.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Dispute amounts are recorded in GL for liability tracking and regulatory reporting.',
    `invoice_bill_id` BIGINT COMMENT 'Identifier of the specific invoice or bill that is being disputed.',
    `person_id` BIGINT COMMENT 'Unique identifier of the customer who raised the dispute.',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Monetary value of the adjustment applied.',
    `adjustment_reason` STRING COMMENT 'Reason for any monetary adjustment applied during resolution.',
    `adjustment_type` STRING COMMENT 'Type of monetary adjustment made to the account.. Valid values are `credit|debit|adjustment`',
    `attached_documents_flag` BOOLEAN COMMENT 'True if the customer attached supporting documents to the dispute.',
    `closed_timestamp` TIMESTAMP COMMENT 'Date‑time when the dispute record was marked closed.',
    `closure_reason` STRING COMMENT 'Reason why the dispute was closed (e.g., resolved, withdrawn, no response).',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the dispute record was created in the database.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the disputed amount.. Valid values are `^[A-Z]{3}$`',
    `dispute_category` STRING COMMENT 'High‑level classification used for reporting and analytics.. Valid values are `billing|meter_read|rate_application|payment|service`',
    `dispute_number` STRING COMMENT 'External reference number assigned to the dispute for customer communication.',
    `dispute_source` STRING COMMENT 'Channel through which the dispute was submitted.. Valid values are `customer_portal|call_center|email|mail`',
    `dispute_status` STRING COMMENT 'Current lifecycle status of the dispute.. Valid values are `open|in_review|resolved|closed|withdrawn`',
    `dispute_type` STRING COMMENT 'Category describing the nature of the dispute.. Valid values are `billing|meter_read|rate_application|payment|service`',
    `disputed_amount` DECIMAL(18,2) COMMENT 'Monetary amount the customer is contesting.',
    `due_date` DATE COMMENT 'Target date by which the dispute should be resolved.',
    `escalation_flag` BOOLEAN COMMENT 'Indicates whether the dispute was escalated to a regulatory body.',
    `last_activity_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent activity or comment on the dispute.',
    `notes` STRING COMMENT 'Internal free‑text notes captured by the dispute handling team.',
    `open_timestamp` TIMESTAMP COMMENT 'Date‑time when the dispute was initially filed by the customer.',
    `original_bill_amount` DECIMAL(18,2) COMMENT 'Total amount of the original invoice before any dispute.',
    `original_bill_date` DATE COMMENT 'Billing date of the invoice that is under dispute.',
    `original_bill_number` STRING COMMENT 'Invoice number of the original bill.',
    `original_bill_period` STRING COMMENT 'Billing period (e.g., 2023-01) of the disputed invoice.',
    `payment_method` STRING COMMENT 'Method used for any payment or credit issued in the resolution.. Valid values are `check|credit_card|bank_transfer|online|cash`',
    `payment_status` STRING COMMENT 'Payment status of the disputed amount after resolution.. Valid values are `paid|unpaid|partial`',
    `priority` STRING COMMENT 'Priority level assigned to the dispute for service level management.. Valid values are `low|medium|high|critical`',
    `reason` STRING COMMENT 'Free‑text description of why the customer is disputing the bill.',
    `regulatory_complaint_flag` BOOLEAN COMMENT 'True if the dispute resulted in a formal complaint to a public utility commission.',
    `resolution_amount` DECIMAL(18,2) COMMENT 'Monetary amount awarded or adjusted as a result of the dispute resolution.',
    `resolution_deadline` DATE COMMENT 'Regulatory or internal deadline for finalizing the dispute.',
    `resolution_notes` STRING COMMENT 'Detailed notes entered by the resolver describing the outcome and any actions taken.',
    `resolution_timestamp` TIMESTAMP COMMENT 'Date‑time when the dispute was formally resolved.',
    `resolution_type` STRING COMMENT 'Outcome classification of the dispute after review.. Valid values are `upheld|denied|partial_credit|adjusted`',
    `updated_by` STRING COMMENT 'User identifier of the employee or system that last updated the dispute record.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent update to the dispute record.',
    `created_by` STRING COMMENT 'User identifier of the employee or system that created the dispute record.',
    CONSTRAINT pk_dispute PRIMARY KEY(`dispute_id`)
) COMMENT 'Formal customer billing dispute record tracking a customers challenge to a billed amount, rate application, or meter read. Captures dispute type, disputed bill reference, disputed amount, dispute reason, dispute open date, resolution date, resolution type (upheld, denied, partial credit), resolution amount, and regulatory escalation flag (PUC complaint). Supports customer dispute resolution workflow and regulatory complaint tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`collection_action` (
    `collection_action_id` BIGINT COMMENT 'Primary key for collection_action',
    `billing_account_id` BIGINT COMMENT 'Identifier of the billing account to which the collection action applies.',
    `customer_account_id` BIGINT COMMENT 'Identifier of the customer associated with the delinquent account.',
    `cycle_id` BIGINT COMMENT 'Identifier of the billing cycle during which the delinquency originated.',
    `dispute_id` BIGINT COMMENT 'Identifier of the dispute record linked to this collection action.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Collection Action logs need the employee who performed the collection for audit trails, compliance reporting, and performance metrics.',
    `action_initiated_by` STRING COMMENT 'Origin of the action initiation: system, human agent, or automated process.. Valid values are `system|agent|automated`',
    `action_location` STRING COMMENT 'Physical location where the collection action (e.g., field disconnect) was performed.',
    `action_result` STRING COMMENT 'Outcome of the collection action.. Valid values are `successful|unsuccessful|partial`',
    `action_timestamp` TIMESTAMP COMMENT 'Date and time when the collection action was executed.',
    `action_type` STRING COMMENT 'Type of collection action taken (e.g., dunning letter, disconnect notice, field order, agency referral, service termination).. Valid values are `dunning_letter|disconnect_notice|field_order|agency_referral|service_termination`',
    `agency_referral_code` STRING COMMENT 'Code identifying the external agency to which the account was referred for collection.',
    `amount_collected` DECIMAL(18,2) COMMENT 'Monetary amount actually collected as a result of this action.',
    `amount_written_off` DECIMAL(18,2) COMMENT 'Portion of the delinquent amount written off during or after this action.',
    `collection_action_status` STRING COMMENT 'Current processing status of the collection action.. Valid values are `pending|completed|failed|escalated`',
    `collection_channel` STRING COMMENT 'Channel direction of the collection communication.. Valid values are `outbound|inbound`',
    `collection_event_reference` STRING COMMENT 'External reference number or code used by business users to locate the collection event.',
    `collection_method` STRING COMMENT 'Method used to deliver the collection action (e.g., phone, mail, email, in‑person, online portal).. Valid values are `phone|mail|email|in_person|online_portal`',
    `contact_method` STRING COMMENT 'Preferred method used for the most recent contact.. Valid values are `phone|email|mail|sms`',
    `covid_protection_flag` BOOLEAN COMMENT 'True if COVID‑19 related regulatory protections apply to the collection action.',
    `created_by_user` STRING COMMENT 'User identifier of the person or system that created the record.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the collection action record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code representing the currency of the monetary amounts.',
    `days_past_due` STRING COMMENT 'Number of days the account is past its due date at the moment the action is taken.',
    `delinquent_amount` DECIMAL(18,2) COMMENT 'Outstanding balance amount (in the account currency) at the time of the collection action.',
    `dispute_flag` BOOLEAN COMMENT 'True if the collection action is related to a customer dispute.',
    `is_legal_action_initiated` BOOLEAN COMMENT 'True if a formal legal collection action has been started.',
    `last_contact_date` DATE COMMENT 'Date of the most recent contact with the customer regarding this collection.',
    `legal_action_status` STRING COMMENT 'Current status of the legal action.. Valid values are `pending|filed|settled|dismissed`',
    `legal_action_type` STRING COMMENT 'Type of legal action taken, if any.. Valid values are `court|collection_agency|none`',
    `medical_certificate_hold_flag` BOOLEAN COMMENT 'True if a medical certificate exemption prevents service disconnection.',
    `next_action_date` DATE COMMENT 'Planned date for the subsequent collection activity if the current action does not resolve the delinquency.',
    `notes` STRING COMMENT 'Additional free‑form notes captured by the collector about the action.',
    `payment_arrangement_details` STRING COMMENT 'Free‑text description of any payment arrangement terms offered to the customer.',
    `payment_arrangement_offered_flag` BOOLEAN COMMENT 'Indicates whether a payment arrangement was offered during the collection interaction.',
    `regulatory_compliance_status` STRING COMMENT 'Indicates whether the action complies with applicable regulatory requirements.. Valid values are `compliant|non_compliant|exempt`',
    `response_received_date` DATE COMMENT 'Date on which a response from the customer was recorded, if any.',
    `response_received_flag` BOOLEAN COMMENT 'Indicates whether the customer responded to the collection action (true = response received).',
    `updated_by_user` STRING COMMENT 'User identifier of the person or system that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the collection action record.',
    `winter_moratorium_flag` BOOLEAN COMMENT 'True if the action is subject to a regulatory winter disconnect moratorium.',
    CONSTRAINT pk_collection_action PRIMARY KEY(`collection_action_id`)
) COMMENT 'Record of a collections action taken against a delinquent customer billing account, including dunning notices, disconnect warnings, field disconnect orders, payment arrangement offers, and agency referrals. Captures action type (dunning letter, disconnect notice, field order, agency referral, service termination), action date, delinquent amount at action time, days past due, response received flag, next action scheduled date, and regulatory compliance flags (winter moratorium, medical certificate hold, COVID protection). Supports the end-to-end collections lifecycle, regulatory disconnect moratorium compliance, and bad debt forecasting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`assistance` (
    `assistance_id` BIGINT COMMENT 'Primary key for assistance',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Assistance enrollment is tied to a billing account; linking enables account‑level reporting and eliminates the need to store duplicate account identifiers in assistance.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Assistance enrollments are tied to specific utility assistance programs; linking enables eligibility reporting and program performance tracking.',
    `assistance_type` STRING COMMENT 'Classification of the assistance offering (e.g., percentage discount, fixed credit, arrears forgiveness).. Valid values are `percentage_discount|fixed_credit|arrears_forgiveness|other`',
    `benefit_amount` DECIMAL(18,2) COMMENT 'Monetary value of the benefit applied to the customers bill.',
    `benefit_type` STRING COMMENT 'Category of benefit applied (e.g., discount, credit, payment forgiveness).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the enrollment record was first created in the system.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the bill (e.g., 15.00 for 15%).',
    `documentation_submitted` BOOLEAN COMMENT 'Indicates whether required eligibility documentation has been submitted.',
    `eligibility_criteria_description` STRING COMMENT 'Human‑readable description of the eligibility rules for the program.',
    `eligibility_criteria_reference` STRING COMMENT 'Reference code to the set of eligibility rules applied to this enrollment.',
    `enrollment_date` DATE COMMENT 'Date the customer was enrolled in the assistance program.',
    `enrollment_status` STRING COMMENT 'Current lifecycle status of the enrollment.. Valid values are `active|inactive|pending|terminated|suspended`',
    `expiration_date` DATE COMMENT 'Date the assistance enrollment expires or terminates.',
    `household_size` STRING COMMENT 'Number of individuals in the customers household used for eligibility calculations.',
    `income_verification_date` DATE COMMENT 'Date the income verification was completed.',
    `income_verification_status` STRING COMMENT 'Status of income verification for the enrollment.. Valid values are `verified|unverified|pending`',
    `notes` STRING COMMENT 'Free‑form notes related to the enrollment (e.g., special conditions, comments).',
    `recertification_due_date` DATE COMMENT 'Date by which the enrollment must be recertified to remain active.',
    `recertification_status` STRING COMMENT 'Current status of the recertification requirement.. Valid values are `required|completed|exempt|overdue`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the enrollment record.',
    CONSTRAINT pk_assistance PRIMARY KEY(`assistance_id`)
) COMMENT 'Customer enrollment record in a utility assistance program (LIHEAP, CARE, FERA, medical baseline, or utility-specific hardship programs). Captures program code, program name, eligibility criteria reference, enrollment date, expiration date, recertification due date, benefit type (percentage discount, fixed credit, arrears forgiveness), benefit amount or discount rate, enrollment status, income verification status, household size, and program-specific eligibility documentation flags. Tracks active participation of individual billing accounts in assistance programs, drives automated bill credit application, and supports PUC-mandated program participation reporting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`billing`.`billing_program_enrollment` (
    `billing_program_enrollment_id` BIGINT COMMENT 'Primary key for the program_enrollment association',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to the billing account',
    `compliance_status` STRING COMMENT 'Current compliance status of the account for the safety program (e.g., compliant, non‑compliant, pending)',
    `enrollment_date` DATE COMMENT 'Date the billing account began participation in the safety program',
    CONSTRAINT pk_billing_program_enrollment PRIMARY KEY(`billing_program_enrollment_id`)
) COMMENT 'This association captures the enrollment of a billing account in a safety program. Each record links one billing account to one safety program and stores attributes that are specific to the enrollment such as the start date and compliance status.. Existence Justification: A billing account (representing a customer’s service location) can be enrolled in multiple safety programs, and each safety program can be applied to many billing accounts. The enrollment is actively managed by safety staff, with start dates and compliance status tracked for each account-program pair.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_bill_id` FOREIGN KEY (`bill_id`) REFERENCES `power_and_utilities_v2`.`billing`.`bill`(`bill_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ADD CONSTRAINT `fk_billing_bill_line_item_billing_rate_component_id` FOREIGN KEY (`billing_rate_component_id`) REFERENCES `power_and_utilities_v2`.`billing`.`billing_rate_component`(`billing_rate_component_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_bill_id` FOREIGN KEY (`bill_id`) REFERENCES `power_and_utilities_v2`.`billing`.`bill`(`bill_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `power_and_utilities_v2`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ADD CONSTRAINT `fk_billing_payment_invoice_bill_id` FOREIGN KEY (`invoice_bill_id`) REFERENCES `power_and_utilities_v2`.`billing`.`bill`(`bill_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ADD CONSTRAINT `fk_billing_payment_arrangement_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `power_and_utilities_v2`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `power_and_utilities_v2`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_related_bill_cycle_id` FOREIGN KEY (`related_bill_cycle_id`) REFERENCES `power_and_utilities_v2`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_bill_id` FOREIGN KEY (`bill_id`) REFERENCES `power_and_utilities_v2`.`billing`.`bill`(`bill_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ADD CONSTRAINT `fk_billing_adjustment_related_invoice_bill_id` FOREIGN KEY (`related_invoice_bill_id`) REFERENCES `power_and_utilities_v2`.`billing`.`bill`(`bill_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_bill_id` FOREIGN KEY (`bill_id`) REFERENCES `power_and_utilities_v2`.`billing`.`bill`(`bill_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `power_and_utilities_v2`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ADD CONSTRAINT `fk_billing_dispute_invoice_bill_id` FOREIGN KEY (`invoice_bill_id`) REFERENCES `power_and_utilities_v2`.`billing`.`bill`(`bill_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `power_and_utilities_v2`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_cycle_id` FOREIGN KEY (`cycle_id`) REFERENCES `power_and_utilities_v2`.`billing`.`cycle`(`cycle_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ADD CONSTRAINT `fk_billing_collection_action_dispute_id` FOREIGN KEY (`dispute_id`) REFERENCES `power_and_utilities_v2`.`billing`.`dispute`(`dispute_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ADD CONSTRAINT `fk_billing_assistance_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `power_and_utilities_v2`.`billing`.`billing_account`(`billing_account_id`);
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_program_enrollment` ADD CONSTRAINT `fk_billing_billing_program_enrollment_billing_account_id` FOREIGN KEY (`billing_account_id`) REFERENCES `power_and_utilities_v2`.`billing`.`billing_account`(`billing_account_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`billing` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `power_and_utilities_v2`.`billing` SET TAGS ('dbx_domain' = 'billing');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `bill_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Identifier (BILL_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ACCOUNT_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUSTOMER_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Der Nem Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `der_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Der Enrollment Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `gridops_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUSTOMER_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `service_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Service Agreement Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (ADJ_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `arrears_balance` SET TAGS ('dbx_business_glossary_term' = 'Arrears Balance (ARREARS_BAL)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `bill_number` SET TAGS ('dbx_business_glossary_term' = 'Bill Number (BILL_NO)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `bill_status` SET TAGS ('dbx_business_glossary_term' = 'Bill Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `bill_status` SET TAGS ('dbx_value_regex' = 'draft|issued|paid|cancelled|void');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `bill_type` SET TAGS ('dbx_business_glossary_term' = 'Bill Type (BILL_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `bill_type` SET TAGS ('dbx_value_regex' = 'regular|final|corrected|adjustment');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `billing_period_end` SET TAGS ('dbx_business_glossary_term' = 'Billing Period End Date (BP_END_DT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `billing_period_start` SET TAGS ('dbx_business_glossary_term' = 'Billing Period Start Date (BP_START_DT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status (COLLECTION_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'none|in_process|sent_to_agency|closed');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `cycle` SET TAGS ('dbx_business_glossary_term' = 'Bill Cycle (CYCLE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `cycle` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `demand_charge` SET TAGS ('dbx_business_glossary_term' = 'Demand Charge Amount (DEMAND_CHG)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `dispute_close_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Close Date (DISPUTE_CLOSE_DT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag (DISPUTE_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `dispute_open_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Open Date (DISPUTE_OPEN_DT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason (DISPUTE_REASON)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Bill Due Date (DUE_DT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `energy_charge` SET TAGS ('dbx_business_glossary_term' = 'Energy Charge Amount (ENERGY_CHG)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `is_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Completed Flag (RECONCILED_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Bill Issue Timestamp (ISSUE_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount (LATE_FEE_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `late_fee_applied` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Applied Flag (LATE_FEE_APPLIED)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Bill Amount (NET_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date (PAYMENT_DT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAYMENT_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|cash|online|direct_debit');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAYMENT_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partial|failed|refunded');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `rate_plan_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Plan Name (RATE_PLAN_NAME)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date (RECONCILIATION_DT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `regulatory_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Fee Amount (REG_FEE_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `revenue_recognition_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Amount (REV_REC_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date (REV_REC_DATE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (TAX_EXEMPT_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Bill Amount (TOTAL_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `total_kwh` SET TAGS ('dbx_business_glossary_term' = 'Total Energy Consumption (kWh) (TOTAL_KWH)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `total_mcf` SET TAGS ('dbx_business_glossary_term' = 'Total Gas Consumption (MCF) (TOTAL_MCF)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `usage_type` SET TAGS ('dbx_business_glossary_term' = 'Usage Type (USAGE_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill` ALTER COLUMN `usage_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `bill_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Line Item Identifier (BLID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `bill_id` SET TAGS ('dbx_business_glossary_term' = 'Bill Identifier (BILL_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `billing_rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Identifier (RC_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `dr_dispatch_event_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Dispatch Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Audit User Identifier (AUD_USER_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Identifier (MTR_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `metering_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Metering Service Point Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `tou_period_id` SET TAGS ('dbx_business_glossary_term' = 'Product Tou Period Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Der Resource Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `trade_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Leg Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (ADJ_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `bill_line_item_description` SET TAGS ('dbx_business_glossary_term' = 'Line Description (DESC)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `bill_line_item_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status (STAT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `bill_line_item_status` SET TAGS ('dbx_value_regex' = 'pending|posted|reversed|void');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `billing_days` SET TAGS ('dbx_business_glossary_term' = 'Billing Days Count (BDAYS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `charge_type` SET TAGS ('dbx_business_glossary_term' = 'Charge Type (CT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `charge_type` SET TAGS ('dbx_value_regex' = 'usage|demand|fixed|tax|credit|adjustment');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code (CC_CODE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp (CRE_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CUR)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `demand_factor` SET TAGS ('dbx_business_glossary_term' = 'Demand Factor (DF)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `determinant_type` SET TAGS ('dbx_business_glossary_term' = 'Determinant Type (DT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `determinant_type` SET TAGS ('dbx_value_regex' = 'consumption|demand|capacity|service|other');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `discount_indicator` SET TAGS ('dbx_business_glossary_term' = 'Discount Applicable Indicator (DISC_IND)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `estimation_flag` SET TAGS ('dbx_business_glossary_term' = 'Estimation Indicator (EST_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `extended_amount` SET TAGS ('dbx_business_glossary_term' = 'Extended Amount (EXT_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number (INV_NO)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `is_legacy` SET TAGS ('dbx_business_glossary_term' = 'Legacy Record Indicator (LEGACY)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `line_sequence` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number (SEQ)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `load_profile_type` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Type (LPT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `load_profile_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `market_region_code` SET TAGS ('dbx_business_glossary_term' = 'Market Region Code (MRC)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `peak_indicator` SET TAGS ('dbx_business_glossary_term' = 'Peak Indicator (PEAK_IND)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity (QTY)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `read_end_date` SET TAGS ('dbx_business_glossary_term' = 'Read End Date (RED)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `read_start_date` SET TAGS ('dbx_business_glossary_term' = 'Read Start Date (RSD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Indicator (REG_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `revenue_recognition_date` SET TAGS ('dbx_business_glossary_term' = 'Revenue Recognition Date (RR_DATE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type (SETT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `settlement_type` SET TAGS ('dbx_value_regex' = 'real_time|day_ahead|monthly');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ccnb|sap|mdm');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `tax_indicator` SET TAGS ('dbx_business_glossary_term' = 'Tax Applicable Indicator (TAX_IND)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|MCF|Therm|kW|USD_per_kWh|USD_per_MCF');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `unit_rate` SET TAGS ('dbx_business_glossary_term' = 'Unit Rate (UR)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`bill_line_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp (UPD_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` SET TAGS ('dbx_subdomain' = 'payment_management');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `payment_id` SET TAGS ('dbx_business_glossary_term' = 'Payment ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `bank_account_id` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `bill_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `invoice_bill_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `nem_true_up_id` SET TAGS ('dbx_business_glossary_term' = 'Nem True Up Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `amount_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Payment Adjustments Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `amount_adjustments` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `amount_adjustments` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `amount_gross` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `amount_gross` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `amount_net` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `amount_net` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `bank_transaction_reference` SET TAGS ('dbx_business_glossary_term' = 'Bank Transaction Identifier');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `bank_transaction_reference` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel (Delivery Channel)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `channel` SET TAGS ('dbx_value_regex' = 'web|ivr|walk_in|lockbox|mobile_app|agent');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_business_glossary_term' = 'Check Number');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `check_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason Description');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `external_reference` SET TAGS ('dbx_business_glossary_term' = 'External System Reference');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `is_auto_pay` SET TAGS ('dbx_business_glossary_term' = 'Automatic Payment Indicator');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `is_refund` SET TAGS ('dbx_business_glossary_term' = 'Refund Indicator');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Payment Notes');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (Instrument)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|ach|credit_card|cash|auto_pay|other');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number (PRN)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|posted|failed|reversed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `payment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Payment Date and Time');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'GL Posting Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'not_posted|posted|error');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'GL Posting Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `receipt_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `source_detail` SET TAGS ('dbx_business_glossary_term' = 'Payment Source Detail');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `tender_type` SET TAGS ('dbx_business_glossary_term' = 'Tender Type (Payment Tender Classification)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `tender_type` SET TAGS ('dbx_value_regex' = 'full|partial|deposit|advance');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` SET TAGS ('dbx_subdomain' = 'payment_management');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `payment_arrangement_id` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Number');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Type');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `arrangement_type` SET TAGS ('dbx_value_regex' = 'installment|deferred|budget');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `breach_date` SET TAGS ('dbx_business_glossary_term' = 'Breach Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Breach Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `budget_estimated_annual_usage` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Usage (Budget Billing)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `budget_monthly_amount` SET TAGS ('dbx_business_glossary_term' = 'Monthly Budget Amount');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `collection_action_date` SET TAGS ('dbx_business_glossary_term' = 'Collection Action Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `collection_action_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Action Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `collection_action_status` SET TAGS ('dbx_value_regex' = 'none|warning|legal|writeoff');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `cumulative_variance` SET TAGS ('dbx_business_glossary_term' = 'Cumulative Variance');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Current Due Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `hardship_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Hardship Approval Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `hardship_program_flag` SET TAGS ('dbx_business_glossary_term' = 'Hardship Program Participation Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `installment_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Installments');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `installment_number` SET TAGS ('dbx_business_glossary_term' = 'Current Installment Number');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Interest Rate');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `last_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Amount');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `last_payment_method` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Method');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `last_payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|cash|online');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Arrangement Notes');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `payment_arrangement_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `payment_arrangement_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|call_center|mail');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|cash|online');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `penalty_amount` SET TAGS ('dbx_business_glossary_term' = 'Penalty Amount');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `penalty_applied` SET TAGS ('dbx_business_glossary_term' = 'Penalty Applied Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `remaining_balance` SET TAGS ('dbx_business_glossary_term' = 'Remaining Balance');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `scheduled_payment_amount` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Payment Amount');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `scheduled_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Payment Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Arrangement Amount');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `true_up_date` SET TAGS ('dbx_business_glossary_term' = 'True‑Up Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `true_up_frequency` SET TAGS ('dbx_business_glossary_term' = 'True‑Up Frequency');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `true_up_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `power_and_utilities_v2`.`billing`.`payment_arrangement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `aggregation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Portfolio Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Service Location ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `account_class` SET TAGS ('dbx_business_glossary_term' = 'Account Class (ACC_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `account_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government|municipal');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_business_glossary_term' = 'Account Number (ACC)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `arrears_balance` SET TAGS ('dbx_business_glossary_term' = 'Arrears Balance (ARREARS_BAL)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `arrears_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `arrears_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `auto_pay_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Auto-Pay Enrollment Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `billing_account_status` SET TAGS ('dbx_business_glossary_term' = 'Account Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `billing_account_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|closed|pending');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `billing_cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code (BILL_CYCLE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `budget_billing_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Budget Billing Enrollment Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `collection_agency` SET TAGS ('dbx_business_glossary_term' = 'Collection Agency');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `collection_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `collection_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|failed');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (CREDIT_LIM)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `credit_score` SET TAGS ('dbx_business_glossary_term' = 'Credit Score (CREDIT_SCORE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `credit_score` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `credit_score` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_business_glossary_term' = 'Current Account Balance (CURR_BAL)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `current_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `deposit_balance` SET TAGS ('dbx_business_glossary_term' = 'Deposit Balance (DEP_BAL)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `deposit_balance` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `deposit_balance` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `email_address` SET TAGS ('dbx_business_glossary_term' = 'Email Address (EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `email_address` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `email_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `email_address` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `is_suspended` SET TAGS ('dbx_business_glossary_term' = 'Suspended Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `last_adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Last Adjustment Amount');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `last_adjustment_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `last_adjustment_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `last_collection_action_date` SET TAGS ('dbx_business_glossary_term' = 'Last Collection Action Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `last_payment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Payment Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `low_income_indicator` SET TAGS ('dbx_business_glossary_term' = 'Low Income Indicator');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `mailing_address` SET TAGS ('dbx_business_glossary_term' = 'Mailing Address (ADDRESS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `mailing_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `mailing_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `meter_number` SET TAGS ('dbx_business_glossary_term' = 'Meter Number (METER_NBR)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `next_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Due Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `paperless_enrollment` SET TAGS ('dbx_business_glossary_term' = 'Paperless Billing Enrollment Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel (PAY_CHANNEL)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile_app|call_center|mail|in_person');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `payment_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Amount');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `payment_due_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `payment_due_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAY_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|bank_transfer|check|cash|online|direct_debit');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_business_glossary_term' = 'Phone Number (PHONE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `phone_number` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `suspension_reason` SET TAGS ('dbx_business_glossary_term' = 'Suspension Reason');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_account` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `billing_rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Identifier');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `product_rate_component_id` SET TAGS ('dbx_business_glossary_term' = 'Product Rate Component Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `billing_rate_component_description` SET TAGS ('dbx_business_glossary_term' = 'Component Description (Component Description)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `billing_rate_component_name` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Name');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `billing_rate_component_status` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `billing_rate_component_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|pending|draft|suspended');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Calculation Method (Calculation Method)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `calculation_method` SET TAGS ('dbx_value_regex' = 'flat|block|step|time_of_use|critical_peak|real_time_pricing');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `component_type` SET TAGS ('dbx_business_glossary_term' = 'Rate Component Type');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `component_type` SET TAGS ('dbx_value_regex' = 'energy|demand|fixed|tax|rider|adjustment');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (Record Creation Timestamp)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `day_type` SET TAGS ('dbx_business_glossary_term' = 'Day Type (Day Type)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `day_type` SET TAGS ('dbx_value_regex' = 'weekday|weekend|holiday');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (Effective End Date)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (Effective Start Date)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `end_time` SET TAGS ('dbx_business_glossary_term' = 'Period End Time (End Time)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `is_eligible_for_abatement` SET TAGS ('dbx_business_glossary_term' = 'Abatement Eligibility Flag (Abatement Eligibility Flag)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `is_tax_exempt` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (Tax Exempt Flag)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `rate_amount` SET TAGS ('dbx_business_glossary_term' = 'Rate Amount (Rate Amount)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `season` SET TAGS ('dbx_business_glossary_term' = 'Season (Season)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `season` SET TAGS ('dbx_value_regex' = 'summer|winter|spring|fall');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `start_time` SET TAGS ('dbx_business_glossary_term' = 'Period Start Time (Start Time)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `tier_end_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier End Quantity (Tier End Quantity)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `tier_start_quantity` SET TAGS ('dbx_business_glossary_term' = 'Tier Start Quantity (Tier Start Quantity)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `tou_period_name` SET TAGS ('dbx_business_glossary_term' = 'Time‑of‑Use Period Name (TOU Period Name)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kWh|kW|MCF|Therm|USD|percent');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_rate_component` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (Record Update Timestamp)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Identifier');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `bill_due_date_offset` SET TAGS ('dbx_business_glossary_term' = 'Bill Due Date Offset (Days)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `bill_generation_day` SET TAGS ('dbx_business_glossary_term' = 'Bill Generation Day');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `billing_cycle_category` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Category');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `billing_cycle_category` SET TAGS ('dbx_value_regex' = 'standard|custom');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `billing_cycle_owner` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Owner');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `billing_cycle_priority` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Priority');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `cycle_code` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Code');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `cycle_description` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Description');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `cycle_name` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Name');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `cycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|closed');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Type');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `cycle_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|government|mixed');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automation Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `is_default_cycle` SET TAGS ('dbx_business_glossary_term' = 'Default Cycle Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `last_run_accounts_processed` SET TAGS ('dbx_business_glossary_term' = 'Last Run Accounts Processed');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `last_run_bills_generated` SET TAGS ('dbx_business_glossary_term' = 'Last Run Bills Generated');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `last_run_date` SET TAGS ('dbx_business_glossary_term' = 'Last Run Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `last_run_error_count` SET TAGS ('dbx_business_glossary_term' = 'Last Run Error Count');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `last_run_status` SET TAGS ('dbx_business_glossary_term' = 'Last Run Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `last_run_status` SET TAGS ('dbx_value_regex' = 'success|failure|partial|in_progress');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle Notes');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `number_of_accounts` SET TAGS ('dbx_business_glossary_term' = 'Account Count');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `read_frequency` SET TAGS ('dbx_business_glossary_term' = 'Meter Read Frequency');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `read_frequency` SET TAGS ('dbx_value_regex' = 'monthly|bi-monthly|quarterly|semi-annually|annually');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `regulatory_reporting_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `run_schedule_cron` SET TAGS ('dbx_business_glossary_term' = 'Run Schedule Cron Expression');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `scheduled_read_day` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Read Day');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Time Zone');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Record Version Number');
ALTER TABLE `power_and_utilities_v2`.`billing`.`cycle` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` SET TAGS ('dbx_subdomain' = 'billing_operations');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `adjustment_id` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Identifier');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUST_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (APPROVER_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Approver Identifier (APPROVER_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Related Billing Cycle Identifier (BILL_CYCLE_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `related_bill_cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Related Billing Cycle Identifier (BILL_CYCLE_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `bill_id` SET TAGS ('dbx_business_glossary_term' = 'Related Invoice Identifier (INV_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `related_invoice_bill_id` SET TAGS ('dbx_business_glossary_term' = 'Related Invoice Identifier (INV_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `reliability_event_id` SET TAGS ('dbx_business_glossary_term' = 'Reliability Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `adjustment_category` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Category (ADJ_CAT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `adjustment_number` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Number (ADJ_NO)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Status (ADJ_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `adjustment_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected|posted|voided');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `adjustment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Event Timestamp (ADJ_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type (ADJ_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'credit|debit|write_off|rebate|goodwill|bad_debt');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Adjustment Amount (ADJ_GROSS_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Adjustment Amount (ADJ_NET_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `amount_tax` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Tax Amount (ADJ_TAX_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATE_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `delinquency_age` SET TAGS ('dbx_business_glossary_term' = 'Delinquency Age (DELINQ_AGE_DAYS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Effective Date (ADJ_EFF_DT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Expiration Date (ADJ_EXP_DT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Notes (ADJ_NOTES)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `prior_collection_actions` SET TAGS ('dbx_business_glossary_term' = 'Prior Collection Actions (COLL_ACTIONS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `reason_code` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Code (ADJ_REASON_CD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `reason_description` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason Description (ADJ_REASON_DESC)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `recovery_status` SET TAGS ('dbx_business_glossary_term' = 'Recovery Status (RECOVERY_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `recovery_status` SET TAGS ('dbx_value_regex' = 'recovered|unrecovered|partial');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `sap_bad_debt_reference` SET TAGS ('dbx_business_glossary_term' = 'SAP Bad Debt Reference (SAP_BAD_DEBT_REF)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATE_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`adjustment` ALTER COLUMN `write_off_date` SET TAGS ('dbx_business_glossary_term' = 'Write‑Off Date (WRITE_OFF_DT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` SET TAGS ('dbx_subdomain' = 'payment_management');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `deposit_id` SET TAGS ('dbx_business_glossary_term' = 'Deposit ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `customer_customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Adjustment Amount');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `amount` SET TAGS ('dbx_business_glossary_term' = 'Deposit Original Amount');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `applied_to_bill_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Applied To Bill Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `applied_to_bill_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Applied To Bill Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `balance` SET TAGS ('dbx_business_glossary_term' = 'Deposit Net Balance');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Deposit Currency');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `deposit_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `deposit_description` SET TAGS ('dbx_business_glossary_term' = 'Deposit Description');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `deposit_number` SET TAGS ('dbx_business_glossary_term' = 'Deposit Number');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `deposit_status` SET TAGS ('dbx_business_glossary_term' = 'Deposit Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `deposit_status` SET TAGS ('dbx_value_regex' = 'pending|active|released|refunded|cancelled|closed');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `deposit_type` SET TAGS ('dbx_business_glossary_term' = 'Deposit Type');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `deposit_type` SET TAGS ('dbx_value_regex' = 'cash|surety_bond|letter_of_credit');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `hold_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Hold Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Deposit Hold Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `hold_reason` SET TAGS ('dbx_business_glossary_term' = 'Deposit Hold Reason');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `interest_accrual_end_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual End Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `interest_accrual_frequency` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Frequency');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `interest_accrual_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `interest_accrual_method` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Method');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `interest_accrual_method` SET TAGS ('dbx_value_regex' = 'simple|compound');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `interest_accrual_start_date` SET TAGS ('dbx_business_glossary_term' = 'Interest Accrual Start Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `interest_rate` SET TAGS ('dbx_business_glossary_term' = 'Deposit Interest Rate');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `refund_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `refund_eligibility_date` SET TAGS ('dbx_business_glossary_term' = 'Refund Eligibility Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `refund_status` SET TAGS ('dbx_business_glossary_term' = 'Refund Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `refund_status` SET TAGS ('dbx_value_regex' = 'pending|processed|rejected|partial|full');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `regulatory_basis` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Basis');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `release_date` SET TAGS ('dbx_business_glossary_term' = 'Deposit Release Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`deposit` ALTER COLUMN `release_reason` SET TAGS ('dbx_business_glossary_term' = 'Deposit Release Reason');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` SET TAGS ('dbx_subdomain' = 'payment_management');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute Identifier');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `bill_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (INVOICE_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account Identifier (ACCOUNT_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `body_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUSTOMER_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Agent Identifier (AGENT_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `invoice_bill_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Identifier (INVOICE_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Identifier (CUSTOMER_ID)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (ADJ_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Reason (ADJ_REASON)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Type (ADJ_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `adjustment_type` SET TAGS ('dbx_value_regex' = 'credit|debit|adjustment');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `attached_documents_flag` SET TAGS ('dbx_business_glossary_term' = 'Attached Documents Flag (DOCS_ATTACHED_FLG)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `closed_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Closed Timestamp (DISPUTE_CLOSED_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Closure Reason (CLOSURE_REASON)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Record Created Timestamp (DISPUTE_CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `dispute_category` SET TAGS ('dbx_business_glossary_term' = 'Dispute Category (DISPUTE_CAT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `dispute_category` SET TAGS ('dbx_value_regex' = 'billing|meter_read|rate_application|payment|service');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `dispute_number` SET TAGS ('dbx_business_glossary_term' = 'Dispute Number (DISPUTE_NO)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `dispute_source` SET TAGS ('dbx_business_glossary_term' = 'Dispute Source (DISPUTE_SRC)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `dispute_source` SET TAGS ('dbx_value_regex' = 'customer_portal|call_center|email|mail');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_business_glossary_term' = 'Dispute Status (DISPUTE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `dispute_status` SET TAGS ('dbx_value_regex' = 'open|in_review|resolved|closed|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_business_glossary_term' = 'Dispute Type (DISPUTE_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `dispute_type` SET TAGS ('dbx_value_regex' = 'billing|meter_read|rate_application|payment|service');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `disputed_amount` SET TAGS ('dbx_business_glossary_term' = 'Disputed Amount (DISPUTED_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Dispute Due Date (DUE_DATE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `escalation_flag` SET TAGS ('dbx_business_glossary_term' = 'Escalation Flag (ESCALATION_FLG)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `last_activity_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Last Activity Timestamp (LAST_ACTIVITY_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Dispute Notes (DISPUTE_NOTES)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `open_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Open Timestamp (DISPUTE_OPEN_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `original_bill_amount` SET TAGS ('dbx_business_glossary_term' = 'Original Bill Amount (ORIG_BILL_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `original_bill_date` SET TAGS ('dbx_business_glossary_term' = 'Original Bill Date (ORIG_BILL_DATE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `original_bill_number` SET TAGS ('dbx_business_glossary_term' = 'Original Bill Number (ORIG_BILL_NO)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `original_bill_period` SET TAGS ('dbx_business_glossary_term' = 'Original Bill Period (ORIG_BILL_PERIOD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PAYMENT_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|credit_card|bank_transfer|online|cash');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PAYMENT_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'paid|unpaid|partial');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Dispute Priority (DISPUTE_PRIORITY)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason (DISPUTE_REASON)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `regulatory_complaint_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Complaint Flag (REG_COMPLAINT_FLG)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `resolution_amount` SET TAGS ('dbx_business_glossary_term' = 'Resolution Amount (RESOLUTION_AMT)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `resolution_deadline` SET TAGS ('dbx_business_glossary_term' = 'Resolution Deadline (RESOLUTION_DEADLINE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `resolution_notes` SET TAGS ('dbx_business_glossary_term' = 'Resolution Notes (RESOLUTION_NOTES)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `resolution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Resolution Timestamp (RESOLUTION_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type (RESOLUTION_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'upheld|denied|partial_credit|adjusted');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (UPDATED_BY)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Dispute Record Updated Timestamp (DISPUTE_UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`dispute` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` SET TAGS ('dbx_subdomain' = 'payment_management');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `collection_action_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Action Identifier');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Account ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `cycle_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Cycle ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `dispute_id` SET TAGS ('dbx_business_glossary_term' = 'Dispute ID');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Collection Agent Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `action_initiated_by` SET TAGS ('dbx_business_glossary_term' = 'Action Initiated By');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `action_initiated_by` SET TAGS ('dbx_value_regex' = 'system|agent|automated');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `action_location` SET TAGS ('dbx_business_glossary_term' = 'Action Location');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `action_result` SET TAGS ('dbx_business_glossary_term' = 'Action Result');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `action_result` SET TAGS ('dbx_value_regex' = 'successful|unsuccessful|partial');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `action_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Collection Action Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `action_type` SET TAGS ('dbx_business_glossary_term' = 'Collection Action Type');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `action_type` SET TAGS ('dbx_value_regex' = 'dunning_letter|disconnect_notice|field_order|agency_referral|service_termination');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `agency_referral_code` SET TAGS ('dbx_business_glossary_term' = 'Agency Referral Code');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `amount_collected` SET TAGS ('dbx_business_glossary_term' = 'Amount Collected');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `amount_written_off` SET TAGS ('dbx_business_glossary_term' = 'Amount Written Off');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `collection_action_status` SET TAGS ('dbx_business_glossary_term' = 'Collection Action Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `collection_action_status` SET TAGS ('dbx_value_regex' = 'pending|completed|failed|escalated');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `collection_channel` SET TAGS ('dbx_business_glossary_term' = 'Collection Channel');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `collection_channel` SET TAGS ('dbx_value_regex' = 'outbound|inbound');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `collection_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Collection Event Reference');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `collection_method` SET TAGS ('dbx_business_glossary_term' = 'Collection Method');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `collection_method` SET TAGS ('dbx_value_regex' = 'phone|mail|email|in_person|online_portal');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `contact_method` SET TAGS ('dbx_business_glossary_term' = 'Contact Method');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `contact_method` SET TAGS ('dbx_value_regex' = 'phone|email|mail|sms');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `covid_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'COVID‑19 Protection Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `created_by_user` SET TAGS ('dbx_business_glossary_term' = 'Created By User');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `days_past_due` SET TAGS ('dbx_business_glossary_term' = 'Days Past Due');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `delinquent_amount` SET TAGS ('dbx_business_glossary_term' = 'Delinquent Amount');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `is_legal_action_initiated` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Initiated Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `last_contact_date` SET TAGS ('dbx_business_glossary_term' = 'Last Contact Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `legal_action_status` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `legal_action_status` SET TAGS ('dbx_value_regex' = 'pending|filed|settled|dismissed');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `legal_action_type` SET TAGS ('dbx_business_glossary_term' = 'Legal Action Type');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `legal_action_type` SET TAGS ('dbx_value_regex' = 'court|collection_agency|none');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `medical_certificate_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Medical Certificate Hold Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `medical_certificate_hold_flag` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `medical_certificate_hold_flag` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `next_action_date` SET TAGS ('dbx_business_glossary_term' = 'Next Action Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Collection Action Notes');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `payment_arrangement_details` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Details');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `payment_arrangement_offered_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Arrangement Offered Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `response_received_date` SET TAGS ('dbx_business_glossary_term' = 'Response Received Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `response_received_flag` SET TAGS ('dbx_business_glossary_term' = 'Response Received Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `updated_by_user` SET TAGS ('dbx_business_glossary_term' = 'Updated By User');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`collection_action` ALTER COLUMN `winter_moratorium_flag` SET TAGS ('dbx_business_glossary_term' = 'Winter Moratorium Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` SET TAGS ('dbx_subdomain' = 'payment_management');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `assistance_id` SET TAGS ('dbx_business_glossary_term' = 'Assistance Identifier');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `assistance_type` SET TAGS ('dbx_business_glossary_term' = 'Assistance Type');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `assistance_type` SET TAGS ('dbx_value_regex' = 'percentage_discount|fixed_credit|arrears_forgiveness|other');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `benefit_amount` SET TAGS ('dbx_business_glossary_term' = 'Benefit Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `benefit_type` SET TAGS ('dbx_business_glossary_term' = 'Benefit Type');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate (Percent)');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `documentation_submitted` SET TAGS ('dbx_business_glossary_term' = 'Documentation Submitted Flag');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `eligibility_criteria_description` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Description');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `eligibility_criteria_reference` SET TAGS ('dbx_business_glossary_term' = 'Eligibility Criteria Reference');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `enrollment_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `household_size` SET TAGS ('dbx_business_glossary_term' = 'Household Size');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `income_verification_date` SET TAGS ('dbx_business_glossary_term' = 'Income Verification Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_business_glossary_term' = 'Income Verification Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `income_verification_status` SET TAGS ('dbx_value_regex' = 'verified|unverified|pending');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Notes');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `recertification_due_date` SET TAGS ('dbx_business_glossary_term' = 'Recertification Due Date');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `recertification_status` SET TAGS ('dbx_business_glossary_term' = 'Recertification Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `recertification_status` SET TAGS ('dbx_value_regex' = 'required|completed|exempt|overdue');
ALTER TABLE `power_and_utilities_v2`.`billing`.`assistance` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_program_enrollment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_program_enrollment` SET TAGS ('dbx_subdomain' = 'payment_management');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_program_enrollment` SET TAGS ('dbx_association_edges' = 'billing.billing_account,safety.safety_program');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_program_enrollment` ALTER COLUMN `billing_program_enrollment_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Program Enrollment Id');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_program_enrollment` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Program Enrollment - Billing Account Id');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_program_enrollment` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`billing`.`billing_program_enrollment` ALTER COLUMN `enrollment_date` SET TAGS ('dbx_business_glossary_term' = 'Enrollment Date');
