-- Schema for Domain: trading | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:21

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`trading` COMMENT 'Energy trading and risk management including wholesale power purchases, PPAs, REC transactions, DAM and RTM market participation, hedging strategies, portfolio optimization, and ancillary services. Manages trading positions, counterparty contracts, LMP-based settlements, mark-to-market valuations, and market exposure. Integrates with Allegro ETRM for position management and risk reporting.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`counterparty` (
    `counterparty_id` BIGINT COMMENT 'Unique identifier for the trading counterparty. Primary key for the counterparty master record.',
    `approved_credit_limit_usd` DECIMAL(18,2) COMMENT 'Maximum unsecured credit exposure approved for this counterparty in US dollars, representing the aggregate mark-to-market value of open positions before collateral posting is required.',
    `collateral_held_usd` DECIMAL(18,2) COMMENT 'Total value of collateral (cash, letters of credit, guarantees) currently held from this counterparty to secure trading obligations, denominated in US dollars.',
    `collateral_posted_usd` DECIMAL(18,2) COMMENT 'Total value of collateral posted by the utility to this counterparty to secure trading obligations, denominated in US dollars.',
    `counterparty_status` STRING COMMENT 'Current lifecycle status of the counterparty relationship: active (approved for trading), suspended (temporarily restricted), inactive (no current trading), credit_watch (under credit review), terminated (relationship ended).. Valid values are `active|suspended|inactive|credit_watch|terminated`',
    `counterparty_type` STRING COMMENT 'Classification of the counterparty based on their role in energy markets: utility (regulated electric/gas utility), marketer (wholesale power/gas marketer), financial_institution (bank or trading firm), iso_rto (Independent System Operator or Regional Transmission Organization), generator (power generation company), fuel_supplier (coal, natural gas, uranium supplier).. Valid values are `utility|marketer|financial_institution|iso_rto|generator|fuel_supplier`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this counterparty record was first created in the system, used for audit trail and data lineage tracking.',
    `credit_contact_email` STRING COMMENT 'Email address of the credit contact for credit-related communications, margin calls, and collateral requests.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `credit_contact_name` STRING COMMENT 'Full name of the credit department contact responsible for credit limit negotiations, collateral management, and exposure monitoring.',
    `credit_watch_status` STRING COMMENT 'Current credit monitoring status indicating whether the counterparty is under special credit surveillance: none (normal monitoring), positive_watch (potential upgrade), negative_watch (potential downgrade), under_review (active credit assessment in progress).. Valid values are `none|positive_watch|negative_watch|under_review`',
    `csa_effective_date` DATE COMMENT 'Date on which the Credit Support Annex (collateral agreement) with this counterparty became effective, governing margin and collateral posting requirements.',
    `csa_minimum_transfer_amount_usd` DECIMAL(18,2) COMMENT 'Minimum dollar amount for any single collateral transfer under the Credit Support Annex, used to avoid administrative burden of small transfers.',
    `csa_threshold_amount_usd` DECIMAL(18,2) COMMENT 'Threshold amount in US dollars below which no collateral posting is required under the Credit Support Annex terms.',
    `current_credit_exposure_usd` DECIMAL(18,2) COMMENT 'Current mark-to-market credit exposure to this counterparty in US dollars, calculated as the net present value of all open trading positions.',
    `dba_name` STRING COMMENT 'Trade name or doing-business-as name used by the counterparty in commercial transactions, if different from legal entity name.',
    `duns_number` STRING COMMENT 'Nine-digit unique identifier assigned by Dun & Bradstreet for business entity identification and credit assessment.. Valid values are `^[0-9]{9}$`',
    `ferc_registration_number` STRING COMMENT 'FERC-assigned registration identifier for entities authorized to participate in wholesale energy markets under FERC jurisdiction.',
    `fitch_credit_rating` STRING COMMENT 'Current long-term issuer credit rating assigned by Fitch Ratings used for counterparty credit risk assessment.',
    `guarantee_amount_usd` DECIMAL(18,2) COMMENT 'Maximum amount in US dollars guaranteed by the parent or third-party guarantor for this counterpartys obligations.',
    `headquarters_address_line1` STRING COMMENT 'Primary street address line of the counterpartys corporate headquarters for legal notices and correspondence.',
    `headquarters_address_line2` STRING COMMENT 'Secondary address line (suite, floor, building) of the counterpartys corporate headquarters.',
    `headquarters_city` STRING COMMENT 'City where the counterpartys corporate headquarters is located.',
    `headquarters_country_code` STRING COMMENT 'Three-letter ISO country code for the counterpartys headquarters location, typically USA, CAN (Canada), or MEX (Mexico) for North American energy markets.. Valid values are `USA|CAN|MEX`',
    `headquarters_postal_code` STRING COMMENT 'Postal or ZIP code of the counterpartys corporate headquarters address.',
    `headquarters_state_province` STRING COMMENT 'State or province code where the counterpartys corporate headquarters is located.',
    `internal_credit_rating` STRING COMMENT 'Internally assigned credit rating based on the utilitys proprietary credit scoring model and risk assessment framework.',
    `jurisdiction` STRING COMMENT 'Primary regulatory jurisdiction governing the counterpartys operations (e.g., state public utility commission, FERC, provincial regulator).',
    `last_credit_review_date` DATE COMMENT 'Date of the most recent comprehensive credit review and risk assessment performed for this counterparty.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this counterparty record, used for change tracking and audit purposes.',
    `legal_entity_name` STRING COMMENT 'Full legal name of the counterparty as registered with regulatory authorities and used in master trading agreements.',
    `master_agreement_effective_date` DATE COMMENT 'Date on which the master trading agreement with this counterparty became legally effective and binding.',
    `master_agreement_reference_number` STRING COMMENT 'Unique reference number or identifier assigned to the master trading agreement for contract management and trade confirmation purposes.',
    `master_agreement_type` STRING COMMENT 'Type of master trading agreement governing transactions with this counterparty: ISDA (International Swaps and Derivatives Association for financial derivatives), NAESB (North American Energy Standards Board for physical gas), EEI (Edison Electric Institute for physical power), WSPP (Western Systems Power Pool), or custom bilateral agreement.. Valid values are `ISDA|NAESB|EEI|WSPP|custom`',
    `moodys_credit_rating` STRING COMMENT 'Current long-term issuer credit rating assigned by Moodys Investors Service (e.g., Aaa, Baa2, etc.) used for counterparty credit risk assessment.',
    `nerc_registration_code` STRING COMMENT 'NERC-assigned identifier for registered entities subject to Critical Infrastructure Protection (CIP) standards and reliability compliance.',
    `netting_agreement_flag` BOOLEAN COMMENT 'Boolean indicator of whether a payment netting agreement is in place allowing offsetting of amounts owed between parties (True = netting agreement exists, False = gross settlement required).',
    `next_credit_review_date` DATE COMMENT 'Scheduled date for the next periodic credit review and risk reassessment of this counterparty.',
    `onboarding_date` DATE COMMENT 'Date when the counterparty was initially onboarded and approved for trading activity, marking the start of the business relationship.',
    `parent_guarantor_name` STRING COMMENT 'Legal name of the parent company or third-party entity providing a guarantee for this counterpartys trading obligations, if applicable.',
    `primary_contact_email` STRING COMMENT 'Email address of the primary business contact for trade confirmations, scheduling notifications, and operational communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact for trading operations and contract administration at the counterparty organization.',
    `primary_contact_phone` STRING COMMENT 'Business telephone number of the primary contact for urgent trading and operational matters.',
    `sp_credit_rating` STRING COMMENT 'Current long-term issuer credit rating assigned by Standard & Poors (e.g., AAA, AA+, BBB-, etc.) used for counterparty credit risk assessment.',
    `tax_identification_number` STRING COMMENT 'Federal tax identification number (EIN for corporations, SSN for sole proprietors) used for tax reporting and IRS Form 1099 issuance.',
    `termination_date` DATE COMMENT 'Date when the trading relationship with this counterparty was terminated or the master agreement expired, if applicable.',
    CONSTRAINT pk_counterparty PRIMARY KEY(`counterparty_id`)
) COMMENT 'Master record for all trading counterparties including wholesale power buyers/sellers, financial institutions, ISOs/RTOs, PPA offtakers, and fuel suppliers. Captures legal entity details, credit ratings (S&P/Moodys), FERC/NERC registration status, DUNS number, jurisdiction, counterparty type (utility, marketer, financial, ISO, generator), approved credit limit, current credit exposure, collateral requirements (CSA terms), netting agreement flag, master agreement references (ISDA/NAESB/EEI), and credit watch status. Serves as the SSOT for counterparty identity, credit profile, and exposure management within the trading domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`trade` (
    `trade_id` BIGINT COMMENT 'Unique identifier for the energy trade transaction. Primary key for the trade entity.',
    `application_id` BIGINT COMMENT 'Foreign key linking to technology.application. Business justification: Regulatory audit requires linking each trade to the trading application that originated it for traceability and system performance monitoring.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Required for Trade Delivery Allocation Report linking each trade to the physical asset delivering electricity, a FERC regulatory need.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Settlement & market reporting require associating each trade with the balancing area it impacts for FERC compliance and load balancing.',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty entity with whom the trade was executed. May be a wholesale supplier, another utility, a power marketer, or an organized market operator.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: REQUIRED: Large industrial customers have direct wholesale trades; the link supports the Customer Trade Allocation Report and regulatory cost allocation per account.',
    `customer_service_point_id` BIGINT COMMENT 'Foreign key linking to customer.service_point. Business justification: REQUIRED: Certain trades are location‑specific; associating a trade with the service point allows settlement and pricing reports by physical delivery point.',
    `employee_id` BIGINT COMMENT 'Reference to the employee or trader who executed this trade on behalf of the utility.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Regulatory Trade Reporting: each trade must be linked to the specific filing (e.g., FERC Form) that reports it for compliance.',
    `fuel_supply_schedule_id` BIGINT COMMENT 'Foreign key linking to supply.fuel_supply_schedule. Business justification: Generation scheduling uses the Fuel Supply Schedule tied to a specific trade; reconciliation reports need this FK.',
    `generating_unit_id` BIGINT COMMENT 'Foreign key linking to generation.generating_unit. Business justification: Physical trade scheduling requires assigning a specific generating unit to fulfill the contract; this is core to dispatch and settlement processes.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Regulatory trade reporting requires linking each trade to the generating facility for generation scheduling and settlement.',
    `metering_service_point_id` BIGINT COMMENT 'Foreign key linking to metering.metering_service_point. Business justification: Trade execution and regulatory settlement need the service point identifier to align trade deliveries with metered consumption.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to engagement.opportunity. Business justification: Required for Trade Execution Report linking each trade to the originating sales opportunity, enabling revenue attribution and compliance tracking.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to trading.portfolio. Business justification: Trade belongs to a portfolio; linking via portfolio_id enables portfolio‑level reporting and eliminates the free‑text portfolio_book column.',
    `pricing_node_id` BIGINT COMMENT 'Foreign key linking to trading.pricing_node. Business justification: Trade references a pricing node by name; adding pricing_node_id creates a proper FK to the pricing_node master.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: Fuel Procurement‑Trade Mapping Report requires each trade to reference its underlying procurement contract for cost allocation and regulatory compliance.',
    `resource_id` BIGINT COMMENT 'Foreign key linking to der.der_resource. Business justification: ISO Generation Trade Attribution report requires mapping each trade to the specific DER asset that produced the electricity.',
    `trader_employee_id` BIGINT COMMENT 'Reference to the employee or trader who executed this trade on behalf of the utility.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Transmission Service Allocation: each trade is assigned a specific transmission line for delivery, required for NERC reporting and congestion cost calculation.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Trade Delivery Point: regulatory filings require the delivery substation for each trade, used in settlement and market reporting.',
    `amendment_date` DATE COMMENT 'The date of the most recent amendment to the trade terms. Null if no amendments have been made.',
    `amendment_version` STRING COMMENT 'Version number tracking amendments to the original trade. 0 = original trade, incremented for each amendment or modification.',
    `broker_reference` STRING COMMENT 'Reference to the broker or intermediary who facilitated the trade, if applicable. Null for direct bilateral trades or exchange-executed trades.',
    `buy_sell_indicator` STRING COMMENT 'Indicates whether the utility is buying or selling the commodity in this trade. Buy = utility is purchasing, Sell = utility is selling.. Valid values are `buy|sell`',
    `commodity_type` STRING COMMENT 'The type of energy commodity being traded. Power = electricity, Natural Gas = gas supply, REC = Renewable Energy Certificate, Capacity = generation capacity rights, FTR/ARR/CRR = Financial/Auction/Congestion Revenue Rights for transmission hedging, Ancillary Services = grid support services. [ENUM-REF-CANDIDATE: power|natural_gas|rec|capacity|ftr|arr|crr|ancillary_services — 8 candidates stripped; promote to reference product]',
    `confirmation_date` DATE COMMENT 'The date on which the trade was confirmed by both parties.',
    `confirmation_method` STRING COMMENT 'The method by which the trade was confirmed with the counterparty. Electronic = automated system confirmation, Exchange Matched = automatically matched on exchange platform.. Valid values are `electronic|email|phone|fax|exchange_matched`',
    `confirmation_status` STRING COMMENT 'The current status of trade confirmation with the counterparty. Pending = awaiting counterparty confirmation, Confirmed = both parties have confirmed terms, Disputed = discrepancy identified, Cancelled = trade cancelled before settlement.. Valid values are `pending|confirmed|disputed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this trade record was first created in the ETRM system.',
    `credit_limit_check` BOOLEAN COMMENT 'Indicates whether the trade passed credit limit validation at time of execution. True = credit approved, False = credit limit exceeded or waived.',
    `delivery_end_date` DATE COMMENT 'The last date of the delivery period when the commodity will be delivered or the contract expires.',
    `delivery_start_date` DATE COMMENT 'The first date of the delivery period when the commodity will be delivered or the contract becomes effective.',
    `etrm_trade_number` STRING COMMENT 'The unique trade number assigned by the Allegro ETRM system. This is the business identifier used by traders and risk managers to reference the trade.',
    `execution_venue` STRING COMMENT 'The market or platform where the trade was executed. Bilateral = over-the-counter direct negotiation, DAM = Day-Ahead Market, RTM = Real-Time Market, ICE = Intercontinental Exchange, CME = Chicago Mercantile Exchange, NYMEX = New York Mercantile Exchange. [ENUM-REF-CANDIDATE: bilateral|dam|rtm|ice|cme|nymex|other_exchange — 7 candidates stripped; promote to reference product]',
    `hedge_designation` STRING COMMENT 'The hedge accounting designation under ASC 815 for financial reporting purposes. Cash Flow Hedge = hedges exposure to variability in cash flows, Fair Value Hedge = hedges exposure to changes in fair value, Net Investment Hedge = hedges foreign currency exposure in foreign operations, Not Designated = derivative not designated for hedge accounting.. Valid values are `cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated`',
    `hedge_program_reference` STRING COMMENT 'Reference to the specific hedging program or strategy this trade supports, if designated as a hedge. Used for tracking hedge effectiveness and regulatory compliance.',
    `instrument_type` STRING COMMENT 'The financial instrument structure of the trade. Spot = immediate delivery, Forward = future delivery bilateral contract, Future = exchange-traded standardized contract, Swap = exchange of cash flows, Option = right but not obligation to transact, PPA = Power Purchase Agreement long-term contract.. Valid values are `spot|forward|future|swap|option|ppa`',
    `mark_to_market_value` DECIMAL(18,2) COMMENT 'The current fair value of the trade based on current market prices. Updated daily for risk management and financial reporting. Expressed in USD.',
    `market_type` STRING COMMENT 'The temporal market structure in which the trade was executed. Day-Ahead = next-day commitment market, Real-Time = same-hour balancing market, Bilateral = negotiated outside organized markets, Forward = future delivery beyond day-ahead.. Valid values are `day_ahead|real_time|bilateral|forward`',
    `master_agreement_reference` STRING COMMENT 'Reference to the master trading agreement (e.g., ISDA, EEI, NAESB) that governs the legal terms of this trade with the counterparty.',
    `modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this trade record was last modified in the ETRM system.',
    `mtm_valuation_date` DATE COMMENT 'The date as of which the mark-to-market value was calculated.',
    `novation_flag` BOOLEAN COMMENT 'Indicates whether this trade has been novated (transferred to a new counterparty). True = trade has been novated, False = original counterparty remains.',
    `original_trade_reference` STRING COMMENT 'Reference to the original trade if this trade is an amendment, novation, or related transaction. Used to maintain audit trail of trade modifications.',
    `price` DECIMAL(18,2) COMMENT 'The agreed-upon price per unit for the commodity. For power typically in $/MWh, for gas in $/MMBtu or $/MCF, for RECs in $/certificate. For LMP-based trades this may be the fixed price or the LMP reference.',
    `price_unit` STRING COMMENT 'The unit of measure for the trade price, indicating the currency and commodity unit basis.. Valid values are `usd_per_mwh|usd_per_mw_day|usd_per_mmbtu|usd_per_mcf|usd_per_certificate`',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this trade must be reported to regulatory authorities (FERC EQR, CFTC, etc.). True = reporting required, False = exempt from reporting.',
    `rto_iso_market` STRING COMMENT 'The RTO or ISO market in which the trade was executed, if applicable. Examples: PJM, MISO, CAISO, ERCOT, NYISO, ISO-NE, SPP.',
    `settlement_status` STRING COMMENT 'The current status of financial settlement for the trade. Pending = awaiting settlement period, In Progress = settlement calculations underway, Settled = payment completed, Failed = settlement issue requiring resolution.. Valid values are `pending|in_progress|settled|failed`',
    `total_contract_value` DECIMAL(18,2) COMMENT 'The total notional value of the trade contract, calculated as volume multiplied by price. Expressed in USD.',
    `trade_date` DATE COMMENT 'The date on which the trade was executed and agreed upon by both parties.',
    `trade_status` STRING COMMENT 'The current lifecycle status of the trade. Active = trade is live and in delivery period, Completed = delivery and settlement finished, Cancelled = trade cancelled before delivery, Terminated = trade ended early by mutual agreement.. Valid values are `active|completed|cancelled|terminated`',
    `trade_timestamp` TIMESTAMP COMMENT 'The precise date and time when the trade was executed, including timezone information. Critical for Day-Ahead Market (DAM) and Real-Time Market (RTM) reconciliation.',
    `trade_type` STRING COMMENT 'Classification of the trade structure. Physical = actual delivery of commodity, Financial = cash-settled derivative with no physical delivery, Exchange = traded on organized exchange (ICE, CME), Virtual = virtual bid/offer in DAM/RTM with no physical asset.. Valid values are `physical|financial|exchange|virtual`',
    `transmission_service_type` STRING COMMENT 'The type of transmission service associated with power delivery for this trade. Firm = guaranteed delivery, Non-Firm = interruptible, Network = integrated network service, Point-to-Point = specific path reservation, Not Applicable = no transmission component (e.g., gas trade).. Valid values are `firm|non_firm|network|point_to_point|not_applicable`',
    `unrealized_gain_loss` DECIMAL(18,2) COMMENT 'The unrealized profit or loss on the trade based on current mark-to-market valuation versus original contract value. Positive = gain, Negative = loss. Expressed in USD.',
    `volume_quantity` DECIMAL(18,2) COMMENT 'The total quantity of the commodity being traded. Units depend on commodity type: MWh for power, MCF or MMBtu for natural gas, MW for capacity, number of certificates for RECs.',
    `volume_unit_of_measure` STRING COMMENT 'The unit of measure for the volume quantity. MWh = Megawatt-Hour (energy), MW = Megawatt (capacity), MCF = Thousand Cubic Feet (gas volume), MMBtu = Million British Thermal Units (gas energy), Therm = 100,000 BTU, REC Certificate = individual renewable energy certificate.. Valid values are `mwh|mw|mcf|mmbtu|therm|rec_certificate`',
    CONSTRAINT pk_trade PRIMARY KEY(`trade_id`)
) COMMENT 'Core transactional record for every executed energy trade including wholesale power purchases/sales, natural gas trades, financial swaps, options, forwards, futures, FTRs/ARRs/CRRs (congestion revenue rights), and hedge instruments. Captures ETRM system trade number, trade date/time, commodity type (power, gas, REC, capacity, FTR), trade type (physical, financial, exchange), buy/sell indicator, volume (MWh/MCF/MW), price, delivery period start/end, delivery point, counterparty reference, trader ID, portfolio/book reference, hedge program reference (if designated), ASC 815 hedge designation, confirmation status, confirmation method, execution venue (bilateral, DAM, RTM, ICE, CME), broker reference, and amendment/novation history. Primary transactional anchor for the trading domain encompassing all instrument types including virtual transactions and congestion hedges.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`trade_leg` (
    `trade_leg_id` BIGINT COMMENT 'Unique identifier for the individual trade leg or settlement leg within a multi-leg structured product or complex trade instrument.',
    `counterparty_id` BIGINT COMMENT 'Reference to the trading counterparty for this leg. Links to counterparty master data for credit management, settlement, and regulatory reporting.',
    `metering_service_point_id` BIGINT COMMENT 'Foreign key linking to metering.metering_service_point. Business justification: Each leg of a trade may be delivered to a specific service point; linking enables precise measurement and settlement per leg.',
    `trade_id` BIGINT COMMENT 'Reference to the parent trade transaction that this leg belongs to. Links this leg to the overall trade structure in the ETRM system.',
    `ancillary_services_included_flag` BOOLEAN COMMENT 'Indicates whether ancillary services (regulation, reserves, reactive power) are bundled with this leg. True if ancillary services are included in the transaction, false if energy-only.',
    `buy_sell_indicator` STRING COMMENT 'Indicates whether this leg represents a purchase (buy) or sale (sell) position from the utilitys perspective. Critical for position management and risk exposure calculation.. Valid values are `buy|sell`',
    `collateral_required_flag` BOOLEAN COMMENT 'Indicates whether collateral posting is required for this leg based on credit terms and current exposure. True if collateral is required, false otherwise.',
    `commodity_type` STRING COMMENT 'Type of energy commodity or product being traded in this leg. Includes physical power, natural gas, RECs, capacity rights, ancillary services, and emissions allowances.. Valid values are `electricity|natural_gas|renewable_energy_certificate|capacity|ancillary_services|emissions_allowance`',
    `confirmation_date` DATE COMMENT 'Date when this leg was confirmed with the counterparty. Critical for regulatory compliance and audit trail of trade execution.',
    `confirmation_status` STRING COMMENT 'Status of trade confirmation with the counterparty for this specific leg. Independent confirmation may be required for each leg in multi-leg structures.. Valid values are `unconfirmed|confirmed|disputed|amended`',
    `contract_price` DECIMAL(18,2) COMMENT 'Agreed price per unit for this leg. May be a fixed price, floating price indexed to market, or formula-based price. Currency specified in settlement_currency field.',
    `contract_quantity` DECIMAL(18,2) COMMENT 'Contracted volume or quantity for this leg. Represents the notional amount of the commodity to be delivered or settled. Unit of measure specified in quantity_unit_of_measure field.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when this trade leg record was first created in the lakehouse. Used for data lineage and audit purposes.',
    `credit_exposure` DECIMAL(18,2) COMMENT 'Current credit exposure to the counterparty for this leg. Calculated based on mark-to-market value and potential future exposure. Used for credit limit monitoring and collateral management.',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'Actual quantity physically delivered or financially settled for this leg. Used for final settlement reconciliation and variance analysis against contract and scheduled quantities.',
    `delivery_end_date` DATE COMMENT 'End date of the delivery or settlement period for this leg. Defines when physical delivery or financial settlement obligations conclude.',
    `delivery_point_name` STRING COMMENT 'Human-readable name of the delivery location such as PJM Western Hub, Henry Hub, or specific substation or pipeline interconnection point.',
    `delivery_start_date` DATE COMMENT 'Start date of the delivery or settlement period for this leg. Defines when physical delivery or financial settlement obligations begin.',
    `hedge_designation` STRING COMMENT 'Accounting designation of this leg for hedge accounting purposes under FASB ASC 815. Distinguishes between cash flow hedges, fair value hedges, economic hedges without hedge accounting, and speculative positions.. Valid values are `cash_flow_hedge|fair_value_hedge|economic_hedge|speculative`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'System timestamp when this trade leg record was most recently updated. Tracks data currency and supports change data capture processes.',
    `leg_sequence_number` STRING COMMENT 'Sequential ordering of this leg within the parent trade structure. Used to maintain the chronological or logical order of delivery or settlement legs in multi-period instruments.',
    `leg_status` STRING COMMENT 'Current lifecycle status of this trade leg. Tracks progression from initial booking through confirmation, scheduling, physical delivery or financial settlement, and final closure.. Valid values are `pending|confirmed|scheduled|delivered|settled|cancelled`',
    `leg_type` STRING COMMENT 'Classification of the leg type within the structured product. Distinguishes between physical delivery legs, financial settlement legs, option exercise legs, swap components, and basis differential legs.. Valid values are `delivery|settlement|option|swap|basis`',
    `mark_to_market_value` DECIMAL(18,2) COMMENT 'Current market valuation of this leg based on prevailing market prices. Updated regularly for risk management and financial reporting. Represents unrealized gain or loss.',
    `market_type` STRING COMMENT 'Classification of the market in which this leg is transacted. Distinguishes between Day-Ahead Market (DAM), Real-Time Market (RTM), bilateral over-the-counter, forward contracts, and exchange-traded futures.. Valid values are `day_ahead|real_time|bilateral|forward|futures`',
    `mtm_valuation_date` DATE COMMENT 'Date of the most recent mark-to-market valuation for this leg. Used to track valuation currency and support daily risk reporting.',
    `notes` STRING COMMENT 'Free-form text field for trader notes, special instructions, or additional context specific to this leg. May include operational constraints, scheduling instructions, or settlement clarifications.',
    `price_unit_of_measure` STRING COMMENT 'Unit of measure for the contract price. Defines the pricing basis such as dollars per MWh, dollars per MW-day for capacity, dollars per MMBtu for gas, or dollars per REC.. Valid values are `USD_per_MWh|USD_per_MW_day|USD_per_MMBtu|USD_per_REC|USD_per_ton`',
    `pricing_formula` STRING COMMENT 'Mathematical formula or algorithm used to calculate the final settlement price for this leg. May include heat rate calculations, basis adjustments, escalation factors, or complex option payoff structures.',
    `pricing_index` STRING COMMENT 'Market pricing index or benchmark used for floating price legs. Examples include Day-Ahead LMP at specific node, Real-Time LMP, Henry Hub gas index, or bilateral index agreements.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for the contract quantity. Common units include MWh (Megawatt-Hour) for electricity energy, MW (Megawatt) for capacity, MMBtu or Dth for natural gas, REC for renewable certificates, and ton CO2 for emissions.. Valid values are `MWh|MW|MMBtu|Dth|REC|ton_CO2`',
    `renewable_attribute_flag` BOOLEAN COMMENT 'Indicates whether this leg includes renewable energy attributes or Renewable Energy Certificates (RECs). True if renewable attributes are part of the transaction, false for conventional energy.',
    `rto_iso_market` STRING COMMENT 'Identifies the RTO or ISO market where this leg is executed for organized market transactions. Null for bilateral trades outside organized markets. [ENUM-REF-CANDIDATE: PJM|CAISO|ERCOT|MISO|NYISO|ISO_NE|SPP — 7 candidates stripped; promote to reference product]',
    `scheduled_quantity` DECIMAL(18,2) COMMENT 'Actual quantity scheduled or nominated for physical delivery for this leg. May differ from contract quantity due to operational constraints, curtailments, or market conditions.',
    `scheduling_status` STRING COMMENT 'Status of physical scheduling or nomination for this leg. Tracks whether the leg has been scheduled with the RTO/ISO or pipeline operator, and any curtailments or adjustments.. Valid values are `not_scheduled|scheduled|nominated|curtailed|adjusted`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Final financial settlement amount for this leg in the settlement currency. Calculated based on delivered quantity, final price, and any adjustments or penalties.',
    `settlement_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for financial settlement of this leg. Predominantly USD for North American energy markets.. Valid values are `USD|CAD|EUR`',
    `settlement_date` DATE COMMENT 'Date when financial settlement for this leg is completed. May differ from delivery end date based on market settlement cycles and payment terms.',
    `source_system` STRING COMMENT 'Identifier of the source system from which this trade leg data originated. Typically Allegro ETRM but may include other trading platforms or manual entry systems.',
    `source_system_leg_reference` STRING COMMENT 'Original leg identifier from the source ETRM system. Maintained for traceability and reconciliation with upstream trading systems.',
    `trade_execution_timestamp` TIMESTAMP COMMENT 'Precise date and time when this leg was executed or booked in the ETRM system. Critical for regulatory reporting and audit trail.',
    `transmission_rights_required_flag` BOOLEAN COMMENT 'Indicates whether firm transmission rights or Financial Transmission Rights (FTRs) are required to support physical delivery for this leg. True if transmission rights are needed, false otherwise.',
    CONSTRAINT pk_trade_leg PRIMARY KEY(`trade_leg_id`)
) COMMENT 'Individual delivery leg or settlement leg of a multi-leg trade or structured product, existing as a first-class entity because each leg has independent delivery terms, settlement cycles, and confirmation status. Captures leg sequence, commodity, volume, price, delivery period, delivery point, buy/sell indicator, settlement currency, leg-level confirmation status, and leg-specific scheduling/nomination data. Supports complex instruments such as heat rate options, spark spread trades, basis swaps, tolling agreements, and multi-period PPAs where each leg settles independently and may have different counterparty credit treatment.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`portfolio` (
    `portfolio_id` BIGINT COMMENT 'Unique identifier for the trading portfolio. Primary key.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `vpp_agreement_id` BIGINT COMMENT 'Foreign key linking to engagement.vpp_agreement. Business justification: Portfolio‑level VPP contract tracking needed for dispatch scheduling, financial settlement, and regulatory reporting.',
    `board_approval_date` DATE COMMENT 'Date on which the board of directors or authorized governance committee approved the establishment of this portfolio and its risk limits.',
    `board_approval_resolution_number` STRING COMMENT 'Reference number of the board resolution or governance document that approved this portfolio.',
    `business_unit` STRING COMMENT 'High-level business unit or division to which this portfolio belongs (e.g., Wholesale Power, Gas Supply, Renewable Energy).',
    `closure_date` DATE COMMENT 'Date on which this trading portfolio was permanently closed. Null if the portfolio is still active or suspended.',
    `closure_reason` STRING COMMENT 'Business reason for closing the portfolio (e.g., strategic realignment, regulatory change, market exit, consolidation with another portfolio).',
    `commodity_scope` STRING COMMENT 'Primary commodity or commodities traded within this portfolio: power (electricity), gas (natural gas), coal, fuel oil, renewable (RECs and renewable energy), or multi-commodity (mixed).. Valid values are `power|gas|coal|fuel_oil|renewable|multi_commodity`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio record was first created in the system.',
    `credit_exposure_limit_usd` DECIMAL(18,2) COMMENT 'Maximum approved credit exposure limit for counterparty risk within this portfolio, expressed in US dollars. Represents the aggregate mark-to-market exposure to all counterparties.',
    `current_credit_utilization_percent` DECIMAL(18,2) COMMENT 'Current credit exposure utilization as a percentage of the approved credit limit. Calculated as (current credit exposure / credit limit) * 100.',
    `current_position_utilization_percent` DECIMAL(18,2) COMMENT 'Current open position utilization as a percentage of the approved position limit. Calculated as (current net position / position limit) * 100.',
    `current_var_utilization_percent` DECIMAL(18,2) COMMENT 'Current VaR utilization as a percentage of the approved VaR limit. Calculated as (current VaR / VaR limit) * 100.',
    `etrm_system_book_reference` STRING COMMENT 'Unique book identifier in the Allegro ETRM system corresponding to this portfolio. Used for system integration and position reconciliation.',
    `hedge_accounting_designation` STRING COMMENT 'Accounting treatment designation under FASB ASC 815: cash flow hedge (hedging variability in cash flows), fair value hedge (hedging changes in fair value), net investment hedge (hedging foreign currency exposure), or not designated (mark-to-market through earnings).. Valid values are `cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated`',
    `hedge_effectiveness_test_method` STRING COMMENT 'Method used to assess hedge effectiveness for accounting purposes: dollar offset (change in hedge value vs hedged item), regression (statistical correlation), var reduction (reduction in portfolio VaR), or not applicable (no hedge accounting).. Valid values are `dollar_offset|regression|var_reduction|not_applicable`',
    `inception_date` DATE COMMENT 'Date on which this trading portfolio was first established and became operational.',
    `last_limit_review_date` DATE COMMENT 'Date of the most recent periodic review of risk limits for this portfolio. Risk limits are typically reviewed quarterly or annually.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this portfolio record was last modified in the system.',
    `limit_breach_action` STRING COMMENT 'Automated or procedural action taken when a risk limit is breached: alert (notify trader and risk manager), block (prevent new trades), escalate (escalate to senior management), or auto liquidate (automatically close positions).. Valid values are `alert|block|escalate|auto_liquidate`',
    `mark_to_market_methodology` STRING COMMENT 'Valuation methodology used for mark-to-market calculations: forward curve (market forward prices), LMP-based (locational marginal pricing), broker quote (third-party broker quotes), model derived (internal pricing model), or cost basis (historical cost).. Valid values are `forward_curve|lmp_based|broker_quote|model_derived|cost_basis`',
    `next_limit_review_date` DATE COMMENT 'Scheduled date for the next periodic review of risk limits for this portfolio.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special instructions related to the portfolio management, risk limits, or operational considerations.',
    `open_position_limit_mmbtu` DECIMAL(18,2) COMMENT 'Maximum approved open position limit for gas portfolios expressed in million British thermal units. Represents the maximum net long or short position allowed.',
    `open_position_limit_mwh` DECIMAL(18,2) COMMENT 'Maximum approved open position limit for power portfolios expressed in megawatt-hours. Represents the maximum net long or short position allowed.',
    `pnl_attribution_method` STRING COMMENT 'Method used to attribute profit and loss: trade level (P&L calculated and attributed at individual trade level), portfolio level (P&L calculated at aggregate portfolio level), or blended (combination of both).. Valid values are `trade_level|portfolio_level|blended`',
    `portfolio_code` STRING COMMENT 'Short alphanumeric code used as the business identifier for the portfolio in trading systems and reports.. Valid values are `^[A-Z0-9]{4,12}$`',
    `portfolio_name` STRING COMMENT 'Business name of the trading portfolio used for identification and reporting purposes.',
    `portfolio_status` STRING COMMENT 'Current lifecycle status of the trading portfolio: active (operational and accepting new positions), suspended (temporarily inactive), closed (permanently closed), or pending approval (awaiting board or management approval).. Valid values are `active|suspended|closed|pending_approval`',
    `portfolio_type` STRING COMMENT 'Classification of the portfolio by its primary business purpose: generation hedge (hedging generation output), load hedge (hedging customer load obligations), proprietary (speculative trading), ancillary (ancillary services), fuel (fuel procurement hedging), or renewable (renewable energy and REC trading).. Valid values are `generation_hedge|load_hedge|proprietary|ancillary|fuel|renewable`',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the portfolio: merchant (unregulated competitive trading), utility (regulated utility hedging activities subject to PUC oversight), or hybrid (mixed activities).. Valid values are `merchant|utility|hybrid`',
    `rto_iso_market` STRING COMMENT 'Primary RTO or ISO market in which this portfolio operates (e.g., PJM, CAISO, ERCOT, MISO, NYISO, ISO-NE, SPP). Relevant for power portfolios participating in organized wholesale markets.',
    `stop_loss_limit_usd` DECIMAL(18,2) COMMENT 'Maximum approved cumulative loss threshold in US dollars. When exceeded, triggers mandatory position reduction or closure actions.',
    `tenor_limit_months` STRING COMMENT 'Maximum approved tenor (time to maturity) for positions within this portfolio, expressed in months. Limits how far forward positions can be taken.',
    `trading_desk` STRING COMMENT 'Name of the trading desk or organizational unit to which this portfolio is assigned (e.g., Power Trading Desk, Gas Trading Desk, Renewables Desk).',
    `var_confidence_level_percent` DECIMAL(18,2) COMMENT 'Confidence level used for VaR calculation, typically expressed as a percentage (e.g., 95.00, 99.00).',
    `var_limit_usd` DECIMAL(18,2) COMMENT 'Maximum approved Value at Risk limit for this portfolio expressed in US dollars. Represents the maximum potential loss at a specified confidence level over a defined time horizon.',
    `var_time_horizon_days` STRING COMMENT 'Time horizon in days over which VaR is calculated (e.g., 1 day, 10 days).',
    CONSTRAINT pk_portfolio PRIMARY KEY(`portfolio_id`)
) COMMENT 'Master record defining trading books and portfolios used to organize positions, attribute P&L, and enforce risk governance. Captures portfolio name, portfolio type (generation hedge, load hedge, proprietary, ancillary, fuel), commodity scope, responsible trader/desk, regulatory classification (merchant vs. utility), mark-to-market methodology, approved risk limits (VaR limit, open position limit, stop-loss limit, tenor limit, credit exposure limit), limit breach actions (alert, block, escalate), current limit utilization, board approval date, and ETRM system book ID. Serves as the organizational unit for position aggregation, risk limit enforcement, and P&L attribution.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`position` (
    `position_id` BIGINT COMMENT 'Unique identifier for the trading position snapshot record.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Position statements are aggregated by balancing area for reliability and RTO reporting; linking provides required geographic context.',
    `market_id` BIGINT COMMENT 'Foreign key linking to trading.market. Business justification: Positions are reported for a market; adding market_id provides direct market context without redundant market_segment column.',
    `person_id` BIGINT COMMENT 'Reference to the trader or trading desk responsible for managing this position.',
    `portfolio_id` BIGINT COMMENT 'Reference to the trading portfolio that holds this position.',
    `resource_id` BIGINT COMMENT 'Foreign key linking to der.der_resource. Business justification: Position statements for trading portfolios need to attribute volumes to individual DER resources for risk and capacity reporting.',
    `rps_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.rps_obligation. Business justification: RPS Compliance: positions are tied to Renewable Portfolio Standard obligations; linking enables RPS reporting and gap analysis.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Needed for Position Management Dashboard to attribute each position to the trader employee responsible for that position.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Position reporting at delivery substation: physical delivery positions are tied to a substation for market compliance and reporting.',
    `average_long_price` DECIMAL(18,2) COMMENT 'The volume-weighted average price of all long positions in this snapshot, in USD per unit.',
    `average_net_price` DECIMAL(18,2) COMMENT 'The volume-weighted average price of the net open position, in USD per unit.',
    `average_short_price` DECIMAL(18,2) COMMENT 'The volume-weighted average price of all short positions in this snapshot, in USD per unit.',
    `capacity_obligation_mw` DECIMAL(18,2) COMMENT 'For capacity commodity type, the total capacity obligation in Megawatts (MW) that must be delivered or procured to meet resource adequacy requirements.',
    `change_value` DECIMAL(18,2) COMMENT 'The change in mark-to-market value from the prior valuation date, in USD.',
    `change_volume` DECIMAL(18,2) COMMENT 'The change in net volume from the prior valuation date, measured in the same units as net_volume.',
    `commodity_type` STRING COMMENT 'The type of energy commodity for this position (power, natural gas, capacity, Renewable Energy Certificate, or ancillary services).. Valid values are `power|natural_gas|capacity|rec|ancillary_services`',
    `counterparty_exposure` DECIMAL(18,2) COMMENT 'The total credit exposure to counterparties for this position, representing the potential loss if all counterparties default, in USD.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this position snapshot record was first created in the system.',
    `delivery_period_end` DATE COMMENT 'The end date of the delivery period for which this position applies.',
    `delivery_period_start` DATE COMMENT 'The start date of the delivery period for which this position applies.',
    `delta_equivalent` DECIMAL(18,2) COMMENT 'The delta-adjusted equivalent volume for options and structured products, representing the linear price risk exposure in the same units as net_volume.',
    `hedge_designation` STRING COMMENT 'The accounting hedge designation for this position under FASB ASC 815 (cash flow hedge, fair value hedge, net investment hedge, or undesignated).. Valid values are `cash_flow_hedge|fair_value_hedge|net_investment_hedge|undesignated`',
    `hedge_effectiveness_percent` DECIMAL(18,2) COMMENT 'The percentage effectiveness of the hedge relationship, used to determine hedge accounting treatment eligibility (typically 80-125% range for highly effective hedges).',
    `long_volume` DECIMAL(18,2) COMMENT 'The total volume of long (buy) positions held, measured in MWh for power, MCF for gas, MW for capacity, or REC count for renewable certificates.',
    `mark_to_market_value` DECIMAL(18,2) COMMENT 'The fair value of the net open position calculated using current market prices, in USD.',
    `market_price` DECIMAL(18,2) COMMENT 'The current market price (LMP for power, index price for gas, or market clearing price for capacity/RECs) used for mark-to-market valuation as of the valuation date, in USD per unit.',
    `market_segment` STRING COMMENT 'The market segment in which this position was established (Day-Ahead Market, Real-Time Market, bilateral contract, futures exchange, or options exchange).. Valid values are `day_ahead|real_time|bilateral|futures|options`',
    `net_volume` DECIMAL(18,2) COMMENT 'The net open position volume (long minus short), measured in MWh for power, MCF for gas, MW for capacity, or REC count for renewable certificates.',
    `notes` STRING COMMENT 'Free-text notes or comments regarding this position snapshot, including any manual adjustments, special circumstances, or trader annotations.',
    `position_source` STRING COMMENT 'Indicates whether the position is derived from physical contracts, financial derivatives, or the net of both.. Valid values are `physical|financial|net`',
    `position_status` STRING COMMENT 'The current lifecycle status of the position (open, closed, expired, or settled).. Valid values are `open|closed|expired|settled`',
    `rec_inventory_balance` DECIMAL(18,2) COMMENT 'For REC commodity type, the current inventory balance of Renewable Energy Certificates held in the portfolio, measured in certificate count.',
    `rec_vintage_year` STRING COMMENT 'For REC commodity type, the vintage year of the renewable energy generation that created the certificates.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this position must be included in regulatory filings such as FERC EQR or state PUC reports.',
    `rps_compliance_flag` BOOLEAN COMMENT 'Indicates whether this position (particularly REC positions) contributes to state Renewable Portfolio Standard compliance obligations.',
    `settlement_status` STRING COMMENT 'The settlement status for positions in or past their delivery period (pending, partial, complete, or disputed).. Valid values are `pending|partial|complete|disputed`',
    `short_volume` DECIMAL(18,2) COMMENT 'The total volume of short (sell) positions held, measured in MWh for power, MCF for gas, MW for capacity, or REC count for renewable certificates.',
    `source_system` STRING COMMENT 'The name of the source system from which this position data was extracted (typically Allegro ETRM).',
    `source_system_code` STRING COMMENT 'The unique identifier for this position record in the source system (Allegro ETRM position key).',
    `trading_book` STRING COMMENT 'The trading book or sub-portfolio classification for internal risk management and P&L attribution.',
    `unrealized_pnl` DECIMAL(18,2) COMMENT 'The unrealized profit or loss on the net open position, calculated as the difference between mark-to-market value and book value, in USD.',
    `updated_timestamp` TIMESTAMP COMMENT 'The timestamp when this position snapshot record was last modified.',
    `valuation_date` DATE COMMENT 'The business date as of which this position snapshot was calculated.',
    `var_95` DECIMAL(18,2) COMMENT 'The Value at Risk (VaR) for this position at 95% confidence level, representing the maximum expected loss over a one-day holding period, in USD.',
    `volume_unit` STRING COMMENT 'The unit of measure for the position volume (Megawatt-Hour, Thousand Cubic Feet, Megawatt, Renewable Energy Certificate, or Million British Thermal Units).. Valid values are `MWh|MCF|MW|REC|MMBTU`',
    CONSTRAINT pk_position PRIMARY KEY(`position_id`)
) COMMENT 'Daily snapshot of the net open trading position for a given portfolio, commodity, delivery period, and delivery point as of a specific valuation date. Captures long/short volume (MWh/MCF/RECs/MW), average price, mark-to-market value, unrealized P&L, delta equivalent, position source (physical, financial, net), capacity obligations (for capacity commodity type), REC inventory balances (for REC commodity type), and position change from prior day. Updated daily from the ETRM position management module. Supports risk reporting, regulatory position disclosure, RPS compliance planning, and resource adequacy tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` (
    `ppa_contract_id` BIGINT COMMENT 'Primary key for ppa_contract',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: PPA contracts must reference the generation asset supplying power for compliance and accounting of contracted capacity.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Renewable PPAs must be tied to a balancing area to satisfy Renewable Portfolio Standard tracking and regional compliance.',
    `business_entity_id` BIGINT COMMENT 'Foreign key linking to customer.business_entity. Business justification: REQUIRED: PPA contracts are signed with corporate customers; linking enables billing, compliance, and reporting of contract obligations to the specific business entity.',
    `employee_id` BIGINT COMMENT 'Identifier for the internal employee responsible for managing and administering this PPA.',
    `counterparty_id` BIGINT COMMENT 'Identifier for the counterparty entity (generator, IPP, or wholesale supplier) with whom the PPA is executed.',
    `pricing_node_id` BIGINT COMMENT 'The ISO/RTO pricing node identifier for the delivery point, used for LMP-based settlement.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: PPA contracts are executed with a specific generation facility; accounting and compliance reports need the facility reference.',
    `generating_unit_id` BIGINT COMMENT 'Foreign key linking to generation.generating_unit. Business justification: PPAs are executed for particular generating units; the contract stores pricing, delivery point, and term details tied to that unit.',
    `metering_service_point_id` BIGINT COMMENT 'Foreign key linking to metering.metering_service_point. Business justification: PPA contracts specify a delivery point; linking to the service point allows compliance reporting and meter‑based verification of renewable deliveries.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Required for Renewable Energy Incentive Program reporting linking PPAs to the program they support.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: Rate Case Approval: PPAs often require approval in a rate case; linking tracks which rate case governs each contract.',
    `resource_id` BIGINT COMMENT 'Foreign key linking to der.der_resource. Business justification: PPA contract management tracks which DER asset is the source of contracted power for compliance and performance reporting.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: PPA performance monitoring and FERC reporting require associating each contract with the SCADA system that records generation at the contracted facility.',
    `business_unit` STRING COMMENT 'The internal business unit or division responsible for this PPA (e.g., Wholesale Power, Renewable Procurement).',
    `capacity_payment_per_mw_month` DECIMAL(18,2) COMMENT 'The monthly capacity payment in USD per MW of contracted capacity, applicable when pricing structure includes separate capacity payments.',
    `collateral_requirement_usd` DECIMAL(18,2) COMMENT 'The amount of collateral in USD that the counterparty must post to secure performance under the PPA.',
    `contract_amendment_count` STRING COMMENT 'The number of amendments or modifications made to the original PPA since execution.',
    `contract_execution_date` DATE COMMENT 'The date on which the PPA was signed by both parties and became legally binding.',
    `contract_name` STRING COMMENT 'Descriptive name of the Power Purchase Agreement, often including counterparty and resource type for easy identification.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the Power Purchase Agreement, typically used in legal documents and FERC filings.. Valid values are `^PPA-[A-Z0-9]{8,12}$`',
    `contract_status` STRING COMMENT 'Current lifecycle status of the Power Purchase Agreement: draft (under negotiation), pending approval (awaiting internal or regulatory approval), active (in force), suspended (temporarily halted), terminated (ended early), or expired (reached natural end date).. Valid values are `draft|pending_approval|active|suspended|terminated|expired`',
    `contract_term_end_date` DATE COMMENT 'The date on which the Power Purchase Agreement expires and energy delivery obligations cease, unless extended or terminated early.',
    `contract_term_start_date` DATE COMMENT 'The date on which the Power Purchase Agreement becomes effective and energy delivery obligations begin.',
    `contract_term_years` STRING COMMENT 'The duration of the PPA in years, calculated from start date to end date.',
    `contract_type` STRING COMMENT 'Classification of the Power Purchase Agreement structure: bilateral (fixed delivery), tolling (fuel provided by buyer), unit contingent (delivery subject to unit availability), baseload, peaking, or renewable-specific.. Valid values are `bilateral|tolling|unit_contingent|baseload|peaking|renewable`',
    `contract_value_usd` DECIMAL(18,2) COMMENT 'The estimated total value of the PPA in USD over its full term, calculated from contracted volumes and pricing.',
    `contracted_capacity_mw` DECIMAL(18,2) COMMENT 'The nameplate capacity in megawatts (MW) that the seller commits to make available under the PPA.',
    `contracted_energy_mwh_annual` DECIMAL(18,2) COMMENT 'The annual energy volume in megawatt-hours (MWh) that the seller is expected to deliver under the PPA, often used for renewable PPAs with production estimates.',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this PPA contract record was first created in the system.',
    `credit_rating_requirement` STRING COMMENT 'Minimum credit rating required for the counterparty under the PPA, if specified (e.g., BBB- or higher).',
    `curtailment_compensation_terms` STRING COMMENT 'Description of compensation terms when energy delivery is curtailed, such as payment for lost generation or no compensation.',
    `curtailment_provision_flag` BOOLEAN COMMENT 'Indicates whether the PPA includes provisions allowing the buyer to curtail (reduce or stop) energy delivery under certain conditions (True) or not (False).',
    `ferc_filing_reference` STRING COMMENT 'Reference number or docket number for the FERC filing associated with this PPA, if applicable for jurisdictional contracts.',
    `fixed_price_per_mwh` DECIMAL(18,2) COMMENT 'The fixed price in USD per megawatt-hour for energy delivered under the PPA, applicable when pricing structure is fixed.',
    `force_majeure_terms` STRING COMMENT 'Summary of force majeure provisions that excuse performance due to unforeseeable events (natural disasters, war, regulatory changes, etc.).',
    `last_amendment_date` DATE COMMENT 'The date of the most recent amendment to the PPA, if any amendments have been made.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this PPA contract record was last updated in the system.',
    `notes` STRING COMMENT 'Free-text field for additional notes, comments, or special conditions related to the PPA.',
    `payment_terms_days` STRING COMMENT 'Number of days after invoice date within which payment is due under the PPA (e.g., 30 days).',
    `price_escalation_rate_percent` DECIMAL(18,2) COMMENT 'The annual percentage rate at which the PPA price escalates over the contract term, if applicable.',
    `price_index_reference` STRING COMMENT 'The market index or benchmark to which the PPA price is tied (e.g., Henry Hub Natural Gas, PJM Day-Ahead LMP), applicable when pricing structure is indexed.',
    `pricing_structure` STRING COMMENT 'The pricing mechanism for the PPA: fixed (flat rate per MWh), indexed (tied to market index or fuel cost), tolling (buyer provides fuel), hybrid (combination), or capacity and energy (separate capacity and energy payments).. Valid values are `fixed|indexed|tolling|hybrid|capacity_energy`',
    `rec_inclusion_flag` BOOLEAN COMMENT 'Indicates whether Renewable Energy Certificates (RECs) are included in the PPA and transferred to the buyer (True) or retained by the seller (False).',
    `rec_transfer_mechanism` STRING COMMENT 'Mechanism for REC transfer: bundled (RECs delivered with energy), unbundled (RECs delivered separately), or retained by seller.. Valid values are `bundled|unbundled|retained_by_seller`',
    `regulatory_approval_status` STRING COMMENT 'Status of regulatory approval for the PPA: not required (non-jurisdictional), pending (submitted awaiting decision), approved (accepted by regulator), or rejected.. Valid values are `not_required|pending|approved|rejected`',
    `renewable_portfolio_standard_eligible_flag` BOOLEAN COMMENT 'Indicates whether energy from this PPA qualifies for state Renewable Portfolio Standard (RPS) compliance (True) or not (False).',
    `settlement_frequency` STRING COMMENT 'Frequency at which energy deliveries and payments are settled under the PPA: monthly, quarterly, or annual.. Valid values are `monthly|quarterly|annual`',
    `termination_provisions` STRING COMMENT 'Summary of conditions under which either party may terminate the PPA early, including notice periods and penalties.',
    CONSTRAINT pk_ppa_contract PRIMARY KEY(`ppa_contract_id`)
) COMMENT 'Master record for Power Purchase Agreements (PPAs) including long-term bilateral contracts for renewable and conventional generation. Captures PPA contract number, counterparty, resource type (solar, wind, hydro, gas), contracted capacity (MW), energy volume (MWh), contract term start/end, pricing structure (fixed, indexed, tolling), delivery point, REC inclusion flag, curtailment provisions, force majeure terms, FERC filing reference, and contract status. Distinct from short-term wholesale trades.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`market_bid` (
    `market_bid_id` BIGINT COMMENT 'Unique identifier for the market bid record. Primary key for the market bid entity.',
    `application_id` BIGINT COMMENT 'Foreign key linking to technology.application. Business justification: ISO market bid submissions are made via a bidding application; linking enables bid audit, compliance reporting, and performance analysis.',
    `registry_id` BIGINT COMMENT 'Identifier of the generation or demand response resource submitting the bid. Links to the resource registry in the generation or demand response domain.',
    `counterparty_id` BIGINT COMMENT 'Identifier of the market participant or trading counterparty submitting the bid. Used for credit management and settlement.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Market bids are submitted by generating facilities; market participation reports require facility identification.',
    `pricing_node_id` BIGINT COMMENT 'The pricing node or location identifier where the resource is electrically connected and where LMP is calculated. Used for settlement and congestion analysis.',
    `market_id` BIGINT COMMENT 'Foreign key linking to trading.market. Business justification: Market bids are submitted to a specific market; linking to market_id normalizes market reference and removes duplicate market code fields.',
    `person_id` BIGINT COMMENT 'Identifier of the individual trader or automated trading system that submitted the bid. Used for audit trails and performance analysis.',
    `portfolio_id` BIGINT COMMENT 'Identifier of the trading portfolio or book to which this bid is assigned. Used for position management and risk aggregation.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Demand‑Response market bids must reference the enrolled DR program for eligibility and performance reporting.',
    `resource_id` BIGINT COMMENT 'Foreign key linking to der.der_resource. Business justification: DER owners submit market bids; each bid must be linked to the DER resource providing the capacity for market‑bid reporting.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Required for Market Bid Execution Report linking each bid to the responsible trader employee; traders are employees who submit bids.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Market Bid location: bids are submitted for a physical line corridor; ISO market rules require line identification for congestion pricing.',
    `acceptance_timestamp` TIMESTAMP COMMENT 'The date and time when the bid was accepted by the ISO/RTO market clearing engine. Null if the bid was rejected or is still pending.',
    `bid_curve_segment_number` STRING COMMENT 'The segment number within a multi-part bid curve. Used when a resource submits multiple price-quantity pairs to represent a non-linear supply or demand curve.',
    `bid_price_per_mwh` DECIMAL(18,2) COMMENT 'The price offered or requested for energy delivery, expressed in dollars per megawatt-hour. For supply bids, this is the minimum acceptable price; for demand bids, this is the maximum willingness to pay.',
    `bid_quantity_mw` DECIMAL(18,2) COMMENT 'The quantity of energy or capacity offered or requested in the bid, expressed in megawatts. Represents the resource capability or demand flexibility.',
    `bid_reference_number` STRING COMMENT 'External business identifier for the bid as submitted to the ISO/RTO market system. Used for reconciliation and audit trails.. Valid values are `^[A-Z0-9]{8,20}$`',
    `bid_status` STRING COMMENT 'Current lifecycle status of the bid in the market clearing process. Tracks whether the bid has been accepted, rejected, or partially cleared by the ISO/RTO.. Valid values are `submitted|accepted|rejected|partially_cleared|withdrawn|expired`',
    `bid_type` STRING COMMENT 'The product type for which the bid is submitted. Energy bids are for MWh delivery; ancillary service bids are for reserves and regulation. [ENUM-REF-CANDIDATE: energy|capacity|regulation_up|regulation_down|spinning_reserve|non_spinning_reserve|supplemental_reserve — 7 candidates stripped; promote to reference product]',
    `block_bid_flag` BOOLEAN COMMENT 'Indicates whether the bid is an all-or-nothing block bid that must be accepted in its entirety or not at all. Used for resources with inflexible operating constraints.',
    `cleared_price_per_mwh` DECIMAL(18,2) COMMENT 'The market clearing price at which the bid was accepted, expressed in dollars per megawatt-hour. This is the Locational Marginal Price (LMP) at the resource node.',
    `cleared_quantity_mw` DECIMAL(18,2) COMMENT 'The actual quantity of energy or capacity that was accepted and cleared by the market. Null if the bid was not accepted or is still pending.',
    `congestion_component` DECIMAL(18,2) COMMENT 'The portion of the LMP attributable to transmission congestion. Represents the cost of delivering power through constrained transmission paths.',
    `created_timestamp` TIMESTAMP COMMENT 'The date and time when this record was first created in the data platform. Used for audit trails and data lineage.',
    `currency_code` STRING COMMENT 'The currency in which bid prices and settlement amounts are denominated. Typically USD for North American markets.. Valid values are `USD`',
    `energy_component` DECIMAL(18,2) COMMENT 'The base energy component of the LMP, representing the marginal cost of generation before congestion and losses.',
    `hedge_designation` STRING COMMENT 'Indicates whether the bid is part of a hedging strategy (physical or financial) or is speculative. Used for risk management and accounting treatment under ASC 815.. Valid values are `physical_hedge|financial_hedge|speculative|none`',
    `loss_component` DECIMAL(18,2) COMMENT 'The portion of the LMP attributable to marginal transmission losses. Represents the incremental cost of electrical losses in the transmission system.',
    `maximum_quantity_mw` DECIMAL(18,2) COMMENT 'The maximum quantity that can be delivered or consumed, representing the upper bound of the resource capability or demand flexibility.',
    `minimum_down_time_hours` STRING COMMENT 'The minimum number of consecutive hours the resource must remain offline after shutdown. Reflects cooling and maintenance requirements.',
    `minimum_quantity_mw` DECIMAL(18,2) COMMENT 'The minimum quantity that must be accepted for the bid to be economically viable. Used for resources with minimum run constraints or block bids.',
    `minimum_run_time_hours` STRING COMMENT 'The minimum number of consecutive hours the resource must operate once started. Reflects operational constraints of thermal generating units.',
    `no_load_cost` DECIMAL(18,2) COMMENT 'The fixed hourly cost of keeping the generating unit online at minimum output, expressed in dollars per hour. Used in unit commitment optimization.',
    `operating_day` DATE COMMENT 'The operating day for which energy delivery is scheduled. In day-ahead markets, this is the next day; in real-time markets, this is the current day.',
    `price_taker_flag` BOOLEAN COMMENT 'Indicates whether the bid is submitted as a price taker (willing to accept any market clearing price). Common for renewable resources with zero marginal cost.',
    `ramp_rate_mw_per_minute` DECIMAL(18,2) COMMENT 'The maximum rate at which the resource can increase or decrease output, expressed in megawatts per minute. Critical for real-time dispatch and frequency regulation.',
    `rejection_reason` STRING COMMENT 'Explanation provided by the ISO/RTO for why the bid was rejected. Includes validation errors, credit issues, or market rule violations.',
    `self_schedule_flag` BOOLEAN COMMENT 'Indicates whether the bid is a self-schedule (must-run) rather than an economic bid. Self-schedules are committed regardless of economics, often for reliability or contractual obligations.',
    `settlement_amount` DECIMAL(18,2) COMMENT 'The total dollar amount settled for this bid, calculated as cleared quantity multiplied by cleared price, plus any uplift payments or penalties.',
    `source_system` STRING COMMENT 'The system from which the bid record originated (e.g., Allegro ETRM, ISO market interface, manual entry). Used for data lineage and reconciliation.',
    `start_up_cost` DECIMAL(18,2) COMMENT 'The cost incurred to start the generating unit from an offline state, expressed in dollars. Used in commitment decisions for thermal units.',
    `submission_timestamp` TIMESTAMP COMMENT 'The date and time when the bid was submitted to the ISO/RTO market system. Critical for determining bid acceptance and market timeline compliance.',
    `trading_hour` STRING COMMENT 'The hour of the operating day for which the bid applies (1-24 in HE format, Hour Ending). Used for hourly market products.',
    `trading_interval` STRING COMMENT 'The sub-hourly interval within the trading hour (e.g., 5-minute or 15-minute intervals). Null for hourly products. Used in real-time markets with sub-hourly dispatch.',
    `updated_timestamp` TIMESTAMP COMMENT 'The date and time when this record was last modified in the data platform. Used for change tracking and incremental processing.',
    CONSTRAINT pk_market_bid PRIMARY KEY(`market_bid_id`)
) COMMENT 'Record of energy bids and offers submitted to ISO/RTO day-ahead (DAM) and real-time (RTM) markets. Captures bid ID, market (MISO, PJM, CAISO, SPP), market type (DAM/RTM), operating day, hour/interval, resource ID, bid type (energy, capacity, ancillary), bid price ($/MWh), bid quantity (MW), bid curve segments, acceptance status, cleared quantity, and cleared price. Sourced from ISO market interface and ETRM system.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`lmp_price` (
    `lmp_price_id` BIGINT COMMENT 'Unique identifier for the LMP price record.',
    `registry_id` BIGINT COMMENT 'Reference to the pricing node where this LMP applies.',
    `market_id` BIGINT COMMENT 'Reference to the ISO/RTO market (MISO, PJM, CAISO, SPP, ERCOT, NYISO, ISO-NE).',
    `commodity_type` STRING COMMENT 'Type of energy commodity for which this price applies: power (energy), capacity, ancillary services, Financial Transmission Rights (FTR), Renewable Energy Certificates (REC), or natural gas.. Valid values are `power|capacity|ancillary_services|ftr|rec|natural_gas`',
    `confidence_interval_lower` DECIMAL(18,2) COMMENT 'For forward curves: lower bound of the confidence interval for the forward price, used for risk assessment.',
    `confidence_interval_upper` DECIMAL(18,2) COMMENT 'For forward curves: upper bound of the confidence interval for the forward price, used for risk assessment.',
    `congestion_component` DECIMAL(18,2) COMMENT 'Congestion component of the LMP representing the cost of transmission constraints binding at this location.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts. Utility operates exclusively in USD.. Valid values are `USD`',
    `curve_date` DATE COMMENT 'For forward prices: the date on which the forward curve was published or captured. Null for spot prices.',
    `curve_source` STRING COMMENT 'Source of the forward curve data: ICE (Intercontinental Exchange), CME (Chicago Mercantile Exchange), broker quote, internal model, ISO-published, or third-party vendor.. Valid values are `ice|cme|broker|internal|iso_published|third_party`',
    `data_source_system` STRING COMMENT 'Name of the source system or market data feed from which this price was obtained (e.g., PJM eMKT, MISO Market Portal, Allegro ETRM).',
    `delivery_hub` STRING COMMENT 'For forward curves: the standardized delivery hub or zone for the forward contract (e.g., PJM West Hub, MISO Indiana Hub).',
    `energy_component` DECIMAL(18,2) COMMENT 'Energy component of the LMP representing the system marginal energy cost, excluding congestion and losses.',
    `forward_price` DECIMAL(18,2) COMMENT 'For forward curves: the forward price for the specified tenor and delivery hub in dollars per megawatt-hour.',
    `geographic_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the pricing node location in decimal degrees, used for spatial analysis and mapping.',
    `geographic_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the pricing node location in decimal degrees, used for spatial analysis and mapping.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Timestamp when this price record was ingested into the enterprise data lakehouse.',
    `interval_duration_minutes` STRING COMMENT 'Duration of the market interval in minutes (typically 5, 15, or 60 depending on market and ISO).',
    `is_active` BOOLEAN COMMENT 'Boolean flag indicating whether this price record is currently active (True) and should be used for valuation and settlement, or superseded (False) by a later settlement run.',
    `lmp_total` DECIMAL(18,2) COMMENT 'Total Locational Marginal Price in dollars per megawatt-hour ($/MWh), representing the marginal cost of serving the next increment of load at this location.',
    `loss_component` DECIMAL(18,2) COMMENT 'Marginal loss component of the LMP representing the cost of electrical losses from the reference bus to this location.',
    `market_interval_end` TIMESTAMP COMMENT 'Precise end timestamp of the market interval.',
    `market_interval_start` TIMESTAMP COMMENT 'Precise start timestamp of the market interval (5-minute, 15-minute, or hourly depending on ISO/RTO).',
    `market_type` STRING COMMENT 'Type of market for which this LMP applies: Day-Ahead Market (DAM), Real-Time Market (RTM), Hour-Ahead, or Ancillary Services.. Valid values are `day_ahead|real_time|hour_ahead|ancillary_services`',
    `negative_price_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether the LMP is negative (True), which can occur during periods of excess renewable generation or transmission constraints.',
    `node_type` STRING COMMENT 'Classification of the pricing node indicating its role in the market topology.. Valid values are `generator_bus|load_zone|hub|interface|trading_hub|aggregate_zone`',
    `operating_date` DATE COMMENT 'The operating day for which this LMP price applies, representing the delivery date in the market.',
    `operating_hour` STRING COMMENT 'The hour-ending (HE) of the operating day (1-24 or 1-25 for DST transitions) for which this price applies.',
    `price_quality_flag` STRING COMMENT 'Data quality indicator for the price: valid (normal), estimated (interpolated), missing (no data), anomaly (outlier detected), or corrected (manually adjusted).. Valid values are `valid|estimated|missing|anomaly|corrected`',
    `price_spike_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this price represents a price spike event (True) or normal market conditions (False), based on threshold rules.',
    `price_type` STRING COMMENT 'Classification of the price record: spot (actual market clearing), forward (future delivery curve), forecast (predicted), or settlement (final reconciled).. Valid values are `spot|forward|forecast|settlement`',
    `pricing_zone` STRING COMMENT 'Aggregated pricing zone or load zone to which this node belongs, used for zonal pricing and settlement.',
    `publication_timestamp` TIMESTAMP COMMENT 'Timestamp when the price was officially published or made available by the ISO/RTO or market data provider.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was first created in the data lakehouse.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when this record was last updated in the data lakehouse, supporting audit trail and change tracking.',
    `settlement_run_number` STRING COMMENT 'Sequential number of the settlement run that produced this price (e.g., initial, T+3, T+55 resettlement).',
    `settlement_status` STRING COMMENT 'Status of the price in the settlement process: preliminary (initial posting), final (after settlement run), resettlement (corrected), or disputed (under review).. Valid values are `preliminary|final|resettlement|disputed`',
    `tenor` STRING COMMENT 'For forward curves: the delivery period or tenor of the forward price (e.g., Month-1, Quarter-2, Cal-2025, Peak, Off-Peak).',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Voltage level in kilovolts (kV) at which the pricing node operates, relevant for transmission-level pricing nodes.',
    CONSTRAINT pk_lmp_price PRIMARY KEY(`lmp_price_id`)
) COMMENT 'Market price records covering both spot Locational Marginal Prices (LMP) and forward price curves for all relevant pricing nodes, hubs, and zones across ISO/RTO markets. For spot prices: captures pricing node ID/name, node type (generator bus, load zone, hub, interface, trading hub), market (MISO/PJM/CAISO/SPP), market interval (hourly/5-min), operating date/hour, LMP ($/MWh), energy/congestion/loss components, and market type (DAM/RTM). For forward curves: captures curve date, commodity (power, gas, RECs, capacity, FTRs), delivery hub, tenor, forward price, curve source (ICE, CME, broker, internal), and confidence interval. Also serves as the master reference for pricing node identity (node ID, name, type, ISO, voltage level, geographic coordinates). Unified reference price source for trade settlement, MTM valuation, FTR valuation, and hedging analysis.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`settlement` (
    `settlement_id` BIGINT COMMENT 'Unique identifier for the financial settlement record. Primary key for the settlement entity.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Settlement calculations and regulatory filings aggregate by balancing area; the link enables accurate area‑level financial reporting.',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty entity involved in the settlement. Identifies the other party in the transaction (buyer or seller).',
    `dr_event_participation_id` BIGINT COMMENT 'Foreign key linking to engagement.dr_event_participation. Business justification: Financial settlement of DR events requires linking settlement records to the participation record for accurate payment and penalty processing.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Settlement Reporting: settlements are disclosed in regulatory filings; linking enables audit of reported settlement amounts.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: Settlement processing is executed by a specific IT service; linking supports audit trails, cost allocation, and service‑level reporting.',
    `portfolio_id` BIGINT COMMENT 'Reference to the trading portfolio or book to which this settlement is allocated. Used for position management and profit and loss (P&L) attribution.',
    `ppa_contract_id` BIGINT COMMENT 'Reference to the master contract or Power Purchase Agreement (PPA) under which this settlement occurs. Used for long-term bilateral agreements.',
    `trade_id` BIGINT COMMENT 'Reference to the originating trade transaction that this settlement resolves. Links to the trade execution record in the ETRM system.',
    `transmission_outage_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_outage. Business justification: Outage‑Impact Settlement: settlements reference the specific transmission outage that generated transmission and congestion charges.',
    `ancillary_services_charge` DECIMAL(18,2) COMMENT 'Charges for ancillary services including regulation, spinning reserves, non-spinning reserves, and voltage support required to maintain grid reliability.',
    `collateral_applied` DECIMAL(18,2) COMMENT 'Amount of collateral (cash, letter of credit, or other security) applied against this settlement to reduce credit exposure.',
    `commodity` STRING COMMENT 'Type of energy commodity or service being settled. Determines unit of measure and pricing conventions.. Valid values are `electricity|natural_gas|rec|capacity|ancillary_services|transmission_rights`',
    `congestion_charge` DECIMAL(18,2) COMMENT 'Congestion cost component of the settlement, reflecting transmission constraints and locational price differences in the market.',
    `cost_center_code` STRING COMMENT 'Cost center to which this settlement is allocated for internal management reporting and cost tracking.. Valid values are `^CC-[A-Z0-9]{4,8}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this settlement record was first created in the system. Used for audit trails and data lineage tracking.',
    `currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the settlement. Typically USD for US markets, CAD for Canadian markets, MXN for Mexican markets.. Valid values are `USD|CAD|MXN`',
    `dispute_flag` BOOLEAN COMMENT 'Indicates whether this settlement is under dispute. True if either party has raised a dispute regarding pricing, volume, or charges.',
    `dispute_reason` STRING COMMENT 'Free-text description of the reason for dispute if dispute_flag is true. Captures the nature of the disagreement for resolution tracking.',
    `etrm_system_deal_reference` STRING COMMENT 'Unique deal identifier in the Allegro ETRM system. Used for reconciliation between settlement records and the source trading system.',
    `gl_account_code` STRING COMMENT 'General ledger account code to which this settlement will be posted in the financial system. Determines the accounting treatment and financial statement classification.. Valid values are `^[0-9]{4,10}$`',
    `gross_settlement_amount` DECIMAL(18,2) COMMENT 'Total settlement value before adjustments, calculated as settled volume multiplied by settlement price. Represents the base transaction value.',
    `hedge_designation` STRING COMMENT 'Hedge accounting designation for this settlement under FASB ASC 815. Determines whether hedge accounting treatment applies and the method of gain/loss recognition.. Valid values are `cash_flow_hedge|fair_value_hedge|economic_hedge|not_designated`',
    `imbalance_charge` DECIMAL(18,2) COMMENT 'Penalty or credit for deviations between scheduled and actual delivery volumes. Calculated based on real-time imbalance pricing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this settlement record. Tracks when adjustments, status changes, or corrections were made.',
    `loss_charge` DECIMAL(18,2) COMMENT 'Marginal loss charge reflecting energy losses during transmission from generation to load. Based on loss factors published by the ISO/RTO.',
    `net_settlement_amount` DECIMAL(18,2) COMMENT 'Final settlement amount after all adjustments, charges, taxes, netting, and collateral. This is the actual payable or receivable amount.',
    `netting_adjustment` DECIMAL(18,2) COMMENT 'Adjustment amount applied when multiple settlements with the same counterparty are netted together under a master netting agreement.',
    `notes` STRING COMMENT 'Free-text field for additional comments, special instructions, or contextual information about the settlement. Used for audit trails and operational communication.',
    `payment_date` DATE COMMENT 'Actual date on which payment was made or received. Null until payment is completed.',
    `payment_direction` STRING COMMENT 'Indicates whether this settlement results in a payment obligation (payable) or an amount to be received (receivable) from the counterparty perspective.. Valid values are `payable|receivable`',
    `payment_due_date` DATE COMMENT 'Date by which payment must be made or received according to the contract terms or market rules. Used for cash flow planning and credit monitoring.',
    `payment_status` STRING COMMENT 'Current status of the payment obligation. Tracks whether the settlement has been paid, received, or is in default.. Valid values are `pending|scheduled|paid|received|overdue|defaulted`',
    `period_end` TIMESTAMP COMMENT 'Ending timestamp of the delivery or performance period covered by this settlement. Defines the end of the energy delivery window.',
    `period_start` TIMESTAMP COMMENT 'Beginning timestamp of the delivery or performance period covered by this settlement. Defines the start of the energy delivery window.',
    `price` DECIMAL(18,2) COMMENT 'Unit price applied to the settled volume. May be a fixed contract price, Locational Marginal Price (LMP), or market clearing price depending on transaction type.',
    `price_unit_of_measure` STRING COMMENT 'Unit of measure for the settlement price. Typically USD per MWh for electricity, USD per MMBtu for gas, USD per REC for certificates, USD per MW-day for capacity.. Valid values are `USD_per_MWh|USD_per_MMBtu|USD_per_REC|USD_per_MW_day`',
    `profit_center_code` STRING COMMENT 'Profit center to which this settlement is allocated for profitability analysis and business unit performance tracking.. Valid values are `^PC-[A-Z0-9]{4,8}$`',
    `rto_iso_market` STRING COMMENT 'Identifies the RTO or ISO market in which this settlement occurred. Determines applicable market rules, pricing methodology, and settlement procedures. [ENUM-REF-CANDIDATE: CAISO|ERCOT|MISO|PJM|NYISO|ISO_NE|SPP — 7 candidates stripped; promote to reference product]',
    `run_reference` STRING COMMENT 'Identifier for the batch settlement run that produced this settlement record. Used to group settlements processed together and track settlement versions.. Valid values are `^SR-[0-9]{8}-[0-9]{4}$`',
    `scheduling_charge` DECIMAL(18,2) COMMENT 'Administrative fees for scheduling and dispatch services provided by the ISO/RTO or balancing authority.',
    `settled_volume` DECIMAL(18,2) COMMENT 'Quantity of commodity delivered or service provided during the settlement period. Measured in units appropriate to the commodity type (MWh for electricity, MMBtu for gas, RECs for certificates).',
    `settlement_number` STRING COMMENT 'Business-facing unique settlement identifier used for external communication, invoicing, and audit trails. Format: STL-YYYYMMDD-XXXXXX.. Valid values are `^STL-[0-9]{8}-[A-Z0-9]{6}$`',
    `settlement_status` STRING COMMENT 'Current lifecycle status of the settlement. Preliminary settlements are subject to revision; final settlements are locked for payment processing.. Valid values are `preliminary|final|disputed|adjusted|voided|paid`',
    `settlement_type` STRING COMMENT 'Classification of the settlement based on the underlying transaction type. Determines settlement rules, pricing methodology, and accounting treatment. [ENUM-REF-CANDIDATE: spot_market|day_ahead_market|real_time_market|ppa_delivery|bilateral_trade|ancillary_services|rec_transaction|capacity_payment|congestion_charge|transmission_charge — 10 candidates stripped; promote to reference product]',
    `transmission_charge` DECIMAL(18,2) COMMENT 'Transmission and distribution charges allocated to this settlement. Includes wheeling fees, congestion charges, and ancillary service costs.',
    `version` STRING COMMENT 'Version number of the settlement. Increments when settlements are recalculated or adjusted. Version 1 is preliminary, higher versions reflect true-ups and final settlements.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for the settled volume. MWh (Megawatt-Hour) for electricity, MMBtu (Million British Thermal Units) or Dth (Dekatherm) for natural gas, REC for renewable energy certificates, MW (Megawatt) for capacity.. Valid values are `MWh|kWh|MMBtu|Dth|REC|MW`',
    CONSTRAINT pk_settlement PRIMARY KEY(`settlement_id`)
) COMMENT 'Financial settlement record for completed trades, market transactions, and PPA deliveries. Captures settlement ID, settlement period, trade/contract reference, counterparty, commodity, settled volume, settlement price, gross settlement amount, netting adjustments, collateral applied, net payable/receivable, settlement status (preliminary, final, disputed), and payment due date. Integrates with SAP FI for accounts payable/receivable posting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` (
    `mtm_valuation_id` BIGINT COMMENT 'Unique identifier for the mark-to-market valuation record.',
    `counterparty_id` BIGINT COMMENT 'FK to trading.counterparty',
    `market_id` BIGINT COMMENT 'Foreign key linking to trading.market. Business justification: MTM valuations are market‑specific; linking to market_id removes the duplicated market_type attribute.',
    `portfolio_id` BIGINT COMMENT 'Reference to the trading portfolio being valued.',
    `approval_timestamp` TIMESTAMP COMMENT 'The timestamp when the valuation was approved.',
    `approved_by` STRING COMMENT 'The name or identifier of the person who approved the final valuation.',
    `commodity_type` STRING COMMENT 'The type of energy commodity being valued (power, natural gas, coal, REC, capacity, ancillary services).. Valid values are `power|natural_gas|coal|renewable_energy_certificate|capacity|ancillary_services`',
    `contract_price_per_unit` DECIMAL(18,2) COMMENT 'The original contract price per unit ($/MWh or $/MMBtu) at which the position was entered.',
    `contract_type` STRING COMMENT 'The type of trading contract (physical delivery, financial swap, option, futures).. Valid values are `physical|financial|swap|option|futures`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation record was first created in the system.',
    `deal_number` STRING COMMENT 'The unique deal or transaction number from the ETRM system (Allegro) for the underlying position.',
    `delivery_period_end` DATE COMMENT 'The end date of the delivery period for the open position being valued.',
    `delivery_period_start` DATE COMMENT 'The start date of the delivery period for the open position being valued.',
    `delivery_point` STRING COMMENT 'The physical or financial delivery point or hub where the commodity is delivered (e.g., PJM West Hub, Henry Hub).',
    `etrm_book_reference` STRING COMMENT 'The book identifier in the Allegro ETRM system where the position is recorded.',
    `fair_value_hierarchy_level` STRING COMMENT 'The ASC 820 fair value hierarchy level (Level 1: quoted prices, Level 2: observable inputs, Level 3: unobservable inputs).. Valid values are `level_1|level_2|level_3`',
    `forward_curve_source` STRING COMMENT 'The source of the forward price curve used for valuation (e.g., ICE, NYMEX, Bloomberg, internal model).',
    `forward_price_per_unit` DECIMAL(18,2) COMMENT 'The forward market price per unit ($/MWh or $/MMBtu) used for mark-to-market valuation as of the valuation date.',
    `hedge_designation` STRING COMMENT 'The hedge accounting designation under ASC 815 (cash flow hedge, fair value hedge, net investment hedge, or not designated).. Valid values are `cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this valuation record was last modified.',
    `lmp_node` STRING COMMENT 'The specific LMP node or pricing point used for valuation in nodal markets.',
    `mtm_total_value_usd` DECIMAL(18,2) COMMENT 'The total mark-to-market value in US dollars, calculated as open volume multiplied by MTM value per unit.',
    `mtm_value_per_unit` DECIMAL(18,2) COMMENT 'The mark-to-market value per unit ($/MWh or $/MMBtu), calculated as the difference between forward price and contract price.',
    `notes` STRING COMMENT 'Additional notes or comments regarding the valuation, including any special circumstances or assumptions.',
    `open_volume_mmbtu` DECIMAL(18,2) COMMENT 'The open volume of the position in million British thermal units (MMBtu) for natural gas commodities.',
    `open_volume_mwh` DECIMAL(18,2) COMMENT 'The open volume of the position in megawatt-hours (MWh) for power commodities.',
    `position_type` STRING COMMENT 'Indicates whether the position is long (buy) or short (sell).. Valid values are `long|short`',
    `price_volatility_percent` DECIMAL(18,2) COMMENT 'The implied or historical price volatility percentage used in the valuation model.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this valuation record must be included in regulatory reporting (FERC EQR, market-based rate filings).',
    `risk_category` STRING COMMENT 'The primary risk category associated with this position (market risk, credit risk, operational risk, basis risk, volumetric risk).. Valid values are `market_risk|credit_risk|operational_risk|basis_risk|volumetric_risk`',
    `rto_iso_market` STRING COMMENT 'The RTO or ISO market in which the position is held (PJM, MISO, ERCOT, CAISO, NYISO, ISO-NE, SPP). [ENUM-REF-CANDIDATE: PJM|MISO|ERCOT|CAISO|NYISO|ISO_NE|SPP — 7 candidates stripped; promote to reference product]',
    `settlement_method` STRING COMMENT 'The settlement method for the contract (physical delivery, financial settlement, cash settlement).. Valid values are `physical|financial|cash`',
    `tenor_months` STRING COMMENT 'The tenor or duration of the position in months from the valuation date to the delivery period end.',
    `unrealized_gain_loss_usd` DECIMAL(18,2) COMMENT 'The unrealized gain or loss in US dollars for the open position, representing the change in MTM value since the prior valuation date.',
    `valuation_adjustment_reason` STRING COMMENT 'The reason for any manual adjustment to the valuation, if applicable.',
    `valuation_date` DATE COMMENT 'The business date as of which the mark-to-market valuation is calculated.',
    `valuation_methodology` STRING COMMENT 'The methodology used to determine the forward price for MTM valuation (forward curve, model-based, broker quote, exchange settlement, internal estimate).. Valid values are `forward_curve|model_based|broker_quote|exchange_settlement|internal_estimate`',
    `valuation_run_reference` STRING COMMENT 'The identifier for the batch valuation run that produced this record, used for audit and reconciliation.',
    `valuation_status` STRING COMMENT 'The status of the valuation record (preliminary, final, adjusted, cancelled).. Valid values are `preliminary|final|adjusted|cancelled`',
    `valuation_timestamp` TIMESTAMP COMMENT 'The precise timestamp when the valuation was performed, including time zone.',
    `var_contribution_usd` DECIMAL(18,2) COMMENT 'The contribution of this position to the portfolios overall Value at Risk (VaR) in US dollars.',
    CONSTRAINT pk_mtm_valuation PRIMARY KEY(`mtm_valuation_id`)
) COMMENT 'Mark-to-market (MTM) valuation record capturing the fair value of open trading positions as of a specific valuation date. Captures valuation date, portfolio, commodity, delivery period, delivery point, open volume, forward price used, contract price, MTM value ($/MWh and total $), unrealized gain/loss, valuation methodology (forward curve, model), and curve source. Supports daily risk reporting, financial disclosure under ASC 815, and FERC market-based rate compliance.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`risk_limit` (
    `risk_limit_id` BIGINT COMMENT 'Unique identifier for the risk limit record. Primary key for the risk limit entity.',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to trading.trading_portfolio. Business justification: Risk limits are defined per trading portfolio; adding trading_portfolio_id links limits to their portfolio and eliminates siloing.',
    `approval_authority` STRING COMMENT 'Organizational role or body that approved this risk limit. Board indicates board of directors approval for enterprise-level limits, CRO (Chief Risk Officer) for portfolio-level limits, CFO (Chief Financial Officer) for financial exposure limits, risk committee for cross-functional limits, desk head for trader-level limits, and trading director for desk-level limits.. Valid values are `board|cro|cfo|risk_committee|desk_head|trading_director`',
    `approval_date` DATE COMMENT 'Date on which the approval authority formally approved this risk limit. Required for regulatory audit trail and governance documentation.',
    `approval_resolution_number` STRING COMMENT 'Reference number of the board resolution, committee decision, or executive approval document that authorized this risk limit. Used for audit trail and regulatory examination.',
    `breach_action` STRING COMMENT 'Automated or procedural action to be taken when this risk limit is breached. Alert generates notification to risk management, block prevents new trades that would increase exposure, escalate triggers management review, auto_hedge initiates automated hedging transactions, manual_review requires trader or desk head intervention before proceeding.. Valid values are `alert|block|escalate|auto_hedge|manual_review`',
    `breach_count` STRING COMMENT 'Total number of times this risk limit has been breached since its effective_date. Incremented each time current_exposure_value exceeds limit_value. Used for risk reporting and limit effectiveness analysis.',
    `business_unit` STRING COMMENT 'Business unit or division responsible for managing activities subject to this risk limit. Examples include Power Trading, Gas Supply, Renewable Energy, or Commercial Operations. Used for organizational reporting and accountability.',
    `commodity` STRING COMMENT 'Energy commodity or product type to which this risk limit applies. Power includes wholesale electricity, natural gas includes pipeline gas and LNG, RECs are renewable energy certificates, capacity represents generation capacity rights, ancillary services include frequency regulation and reserves, emissions cover carbon credits and allowances. [ENUM-REF-CANDIDATE: power|natural_gas|coal|renewable_energy_certificate|capacity|ancillary_services|emissions|multi_commodity — 8 candidates stripped; promote to reference product]',
    `confidence_level_percent` DECIMAL(18,2) COMMENT 'Statistical confidence level used for VaR calculation when limit_type is var. Typical values are 95% or 99%. Represents the probability that losses will not exceed the VaR limit over the specified time horizon. Nullable for non-VaR limit types.',
    `cost_center_code` STRING COMMENT 'SAP ERP cost center code associated with the organizational unit responsible for this risk limit. Used for financial reporting and cost allocation of risk management activities.',
    `counterparty_credit_rating_threshold` STRING COMMENT 'Minimum credit rating required for counterparties when this limit applies to credit exposure. Expressed using standard rating agency notation (e.g., BBB-, A+, AA). Used to enforce credit quality standards in trading relationships. Nullable for non-credit-related limits.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this risk limit record was first created in the system. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX. Part of audit trail for regulatory compliance and data lineage.',
    `current_exposure_value` DECIMAL(18,2) COMMENT 'Current absolute exposure value being monitored against this limit, expressed in the same units as limit_value. Sourced from Allegro ETRM mark-to-market valuations, position reports, or credit exposure calculations depending on limit_type.',
    `current_utilization_percent` DECIMAL(18,2) COMMENT 'Current utilization of this risk limit expressed as a percentage of the limit_value. Calculated as (current_exposure / limit_value) * 100. Updated in near real-time from Allegro ETRM position data. Values approaching 100% trigger breach alerts.',
    `effective_date` DATE COMMENT 'Date on which this risk limit becomes active and enforceable. Limits are monitored and enforced starting from this date.',
    `etrm_system_limit_reference` STRING COMMENT 'Unique identifier for this risk limit in the Allegro ETRM system. Used for system integration, real-time monitoring, and automated breach detection. Enables bidirectional synchronization between lakehouse and operational ETRM platform.',
    `expiry_date` DATE COMMENT 'Date on which this risk limit expires and is no longer enforced. Nullable for evergreen limits that remain in effect until explicitly revised or terminated.',
    `last_breach_date` DATE COMMENT 'Most recent date on which this risk limit was breached. Nullable if the limit has never been breached. Used for breach pattern analysis and regulatory reporting.',
    `last_breach_value` DECIMAL(18,2) COMMENT 'Exposure value at the time of the most recent breach, expressed in limit_unit. Captures the magnitude of the breach for severity analysis and escalation decisions.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this risk limit record. Follows format yyyy-MM-ddTHH:mm:ss.SSSXXX. Updated whenever any field value changes. Essential for change tracking and audit trail.',
    `last_review_date` DATE COMMENT 'Date of the most recent formal review of this risk limit by the approval_authority. Used to track compliance with review_frequency requirements and ensure limits remain appropriate for current market conditions and business strategy.',
    `limit_code` STRING COMMENT 'Unique alphanumeric code assigned to this risk limit for system identification and cross-reference with Allegro ETRM.',
    `limit_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for monetary limit values. Typically USD for US-based utility operations, but may include CAD for cross-border transactions or other currencies for international hedging activities.. Valid values are `^[A-Z]{3}$`',
    `limit_name` STRING COMMENT 'Business-friendly name or title assigned to this risk limit for identification and reporting purposes.',
    `limit_scope` STRING COMMENT 'Organizational or business dimension to which this risk limit applies, defining whether the limit governs a portfolio, trading desk, individual trader, counterparty relationship, commodity type, geographic region, or ETRM book. [ENUM-REF-CANDIDATE: portfolio|desk|trader|counterparty|commodity|region|book — 7 candidates stripped; promote to reference product]',
    `limit_type` STRING COMMENT 'Classification of the risk limit defining the type of exposure being controlled. VaR (Value at Risk) measures potential loss, open position limits maximum volume exposure, stop-loss caps realized losses, credit exposure limits counterparty risk, tenor limits time-based exposure, Greeks measure option sensitivities, concentration limits single-asset exposure, and liquidity limits market depth constraints. [ENUM-REF-CANDIDATE: var|open_position|stop_loss|credit_exposure|tenor|greeks|concentration|liquidity — 8 candidates stripped; promote to reference product]',
    `limit_unit` STRING COMMENT 'Unit of measure for the limit_value field. USD for monetary limits, MWh (Megawatt-Hour) for electric energy volume, MMBtu for gas volume, MW (Megawatt) for capacity, MCF (Thousand Cubic Feet) for gas volume, days for tenor limits, percent for concentration limits, and Greek letters (delta, gamma, vega, theta) for option sensitivity limits. [ENUM-REF-CANDIDATE: usd|mwh|mmbtu|mw|mcf|days|percent|delta|gamma|vega|theta — 11 candidates stripped; promote to reference product]',
    `limit_value` DECIMAL(18,2) COMMENT 'Numeric threshold value defining the maximum allowable exposure for this risk limit. Interpretation depends on limit_type: for VaR and stop-loss this is a monetary amount, for open position this is a volume (MWh or MMBtu), for credit exposure this is a dollar amount, for tenor this is a time period in days.',
    `market_segment` STRING COMMENT 'Specific energy market segment to which this risk limit applies. DAM (Day-Ahead Market) for forward commitments, RTM (Real-Time Market) for spot transactions, bilateral for over-the-counter contracts, financial for purely financial hedges, physical for delivery obligations, ancillary services for frequency regulation and reserves.. Valid values are `dam|rtm|bilateral|financial|physical|ancillary_services`',
    `monitoring_frequency` STRING COMMENT 'Frequency at which this risk limit is evaluated and current_utilization_percent is updated. Real-time for critical limits monitored continuously via ETRM, intraday for multiple checks per day, daily for end-of-day position reports, weekly or monthly for strategic limits reviewed in periodic risk committee meetings.. Valid values are `real_time|intraday|daily|weekly|monthly`',
    `next_review_date` DATE COMMENT 'Scheduled date for the next formal review of this risk limit. Calculated based on last_review_date and review_frequency. Triggers workflow notifications to risk management and approval_authority as the date approaches.',
    `notes` STRING COMMENT 'Free-form text field for additional context, special conditions, or explanatory notes about this risk limit. May include rationale for limit level, historical context, or special handling instructions.',
    `profit_center_code` STRING COMMENT 'SAP ERP profit center code for the business segment whose profitability is impacted by activities governed by this risk limit. Used for segment reporting and performance attribution.',
    `regulatory_mandate_reference` STRING COMMENT 'Citation of the regulatory requirement, order, or mandate that necessitates this risk limit. Examples include FERC Order 741, state PUC (Public Utility Commission) directives, NERC (North American Electric Reliability Corporation) standards, or internal policy references. Nullable for discretionary limits not driven by regulatory mandate.',
    `review_frequency` STRING COMMENT 'Scheduled frequency for formal review and potential revision of this risk limit by the approval_authority. Quarterly for dynamic trading limits, annual for strategic enterprise limits, ad-hoc for event-driven reviews triggered by market changes or regulatory updates.. Valid values are `quarterly|semi_annual|annual|ad_hoc`',
    `risk_limit_status` STRING COMMENT 'Current lifecycle status of this risk limit. Active limits are enforced, suspended limits are temporarily not enforced but remain on record, expired limits have passed their expiry_date, pending_approval limits await formal authorization, superseded limits have been replaced by newer versions.. Valid values are `active|suspended|expired|pending_approval|superseded`',
    `rto_iso_market` STRING COMMENT 'RTO or ISO market to which this risk limit applies when the limit is market-specific. Examples include PJM, CAISO, ERCOT, MISO, ISO-NE, NYISO, SPP. Nullable for limits that span multiple markets or apply to bilateral transactions outside organized markets.',
    `scope_identifier` STRING COMMENT 'Specific identifier of the entity to which this limit applies (e.g., portfolio code, desk name, trader ID, counterparty code). Used in conjunction with limit_scope to define the exact boundary of the limit.',
    `time_horizon_days` STRING COMMENT 'Time period in days over which the risk limit is measured. For VaR limits, this is the holding period (typically 1 day for trading portfolios). For tenor limits, this is the maximum forward duration allowed. Nullable for instantaneous limits like stop-loss.',
    CONSTRAINT pk_risk_limit PRIMARY KEY(`risk_limit_id`)
) COMMENT 'Approved risk limit records defining maximum allowable exposure thresholds that are monitored independently of the portfolios they govern. Captures limit type (VaR, open position, stop-loss, credit exposure, tenor, Greeks), portfolio/desk/trader scope, commodity, limit value, limit currency, effective date, expiry date, approval authority (board, CRO, desk head), breach action (alert, block, escalate), current utilization percentage, breach history, and regulatory mandate reference (FERC, state PUC). Distinct from trading_portfolio because limits have their own approval lifecycle, can span multiple portfolios, and require independent audit trail for regulatory examination.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`hedge_program` (
    `hedge_program_id` BIGINT COMMENT 'Unique identifier for the hedge program. Primary key.',
    `cost_center_id` BIGINT COMMENT 'FK to finance.cost_center',
    `portfolio_id` BIGINT COMMENT 'Foreign key linking to trading.trading_portfolio. Business justification: Hedge programs are scoped to a trading portfolio; adding trading_portfolio_id provides the necessary relationship and prevents the hedge_program table from being isolated.',
    `profit_center_id` BIGINT COMMENT 'FK to finance.profit_center',
    `approved_volume_max` DECIMAL(18,2) COMMENT 'Maximum volume approved for hedging under this program, expressed in the commoditys standard unit (MWh for electricity, MMBtu for natural gas, tons for coal). Defines the upper bound of the hedging range.',
    `approved_volume_min` DECIMAL(18,2) COMMENT 'Minimum volume approved for hedging under this program, expressed in the commoditys standard unit (MWh for electricity, MMBtu for natural gas, tons for coal). Defines the lower bound of the hedging range.',
    `asc_815_hedge_designation` STRING COMMENT 'Hedge accounting designation under ASC 815 (formerly FAS 133): cash flow hedge (hedging variability in future cash flows), fair value hedge (hedging changes in fair value of recognized asset/liability), net investment hedge (hedging foreign currency exposure), or not designated (mark-to-market through earnings).. Valid values are `cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated`',
    `board_approval_date` DATE COMMENT 'Date on which the board of directors or risk committee formally approved this hedge program. Required for governance and regulatory compliance.',
    `board_approval_resolution_number` STRING COMMENT 'Official resolution or motion number from the board meeting that approved this hedge program. Used for audit trail and regulatory filings.',
    `business_unit` STRING COMMENT 'High-level business unit or division that owns this hedge program (e.g., Generation, Supply, Retail Energy Services).',
    `closure_date` DATE COMMENT 'Date on which the hedge program was formally closed and all positions were unwound or transferred. Null for active programs.',
    `closure_reason` STRING COMMENT 'Business reason for closing the hedge program (e.g., Strategy change, Asset divestiture, Market conditions, Regulatory change). Null for active programs.',
    `commodity` STRING COMMENT 'Primary commodity being hedged: electricity (power), natural gas, coal, uranium (nuclear fuel), renewable energy certificate (REC), or emissions allowance (carbon credits).. Valid values are `electricity|natural_gas|coal|uranium|renewable_energy_certificate|emissions_allowance`',
    `cost_recovery_eligible_flag` BOOLEAN COMMENT 'Indicates whether costs and gains/losses from this hedge program are eligible for recovery through regulated rates (True) or must be absorbed by shareholders (False). Critical for regulatory accounting and rate case filings.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this hedge program record was first created in the system. Used for audit trail and data lineage.',
    `credit_exposure_limit_usd` DECIMAL(18,2) COMMENT 'Maximum credit exposure limit in USD for counterparty risk under this hedge program. Defines the aggregate mark-to-market exposure allowed across all counterparties.',
    `effective_end_date` DATE COMMENT 'Date on which the hedge program parameters expire or are scheduled to be reviewed. Null for open-ended programs.',
    `effective_start_date` DATE COMMENT 'Date from which the hedge program parameters (limits, ratios, instruments) are effective. May differ from inception date if program was amended.',
    `effectiveness_test_frequency` STRING COMMENT 'Frequency at which hedge effectiveness testing is performed: monthly, quarterly, annually, or at inception only. Defines the ongoing compliance monitoring schedule.. Valid values are `monthly|quarterly|annually|at_inception_only`',
    `etrm_system_book_reference` STRING COMMENT 'Unique identifier of the trading book in the Allegro ETRM system that corresponds to this hedge program. Used for system integration and position reconciliation.',
    `hedge_effectiveness_test_method` STRING COMMENT 'Method used to assess hedge effectiveness for ASC 815 compliance: dollar offset method, regression analysis, variance reduction analysis, or critical terms match. Required for qualifying hedge accounting treatment.. Valid values are `dollar_offset|regression_analysis|variance_reduction|critical_terms_match`',
    `hedge_horizon_months` STRING COMMENT 'Time horizon for the hedge program expressed in months (e.g., 12 for one-year forward, 24 for two-year forward). Defines how far into the future the utility will hedge its exposure.',
    `hedge_ratio_target_percent` DECIMAL(18,2) COMMENT 'Target hedge ratio expressed as a percentage of the underlying exposure to be hedged (e.g., 75.00 means hedge 75% of generation output or fuel requirements). Defines the strategic hedging level approved by the board.',
    `hedge_type` STRING COMMENT 'Classification of the hedge strategy: generation output hedge (hedging power sales), fuel cost hedge (hedging fuel procurement costs), load hedge (hedging customer load obligations), basis hedge (hedging location basis risk), volumetric hedge (hedging quantity risk), or price hedge (hedging price risk).. Valid values are `generation_output_hedge|fuel_cost_hedge|load_hedge|basis_hedge|volumetric_hedge|price_hedge`',
    `inception_date` DATE COMMENT 'Date on which the hedge program was first established and became operational. Marks the beginning of the program lifecycle.',
    `instrument_types_allowed` STRING COMMENT 'Comma-separated list of derivative instrument types permitted under this hedge program (e.g., swap,option,forward,futures,collar). Defines the trading strategies and products the desk may use.',
    `last_limit_review_date` DATE COMMENT 'Date of the most recent formal review of hedge program limits and parameters by the risk committee or board. Used for governance tracking.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this hedge program record was last modified. Used for audit trail and change tracking.',
    `limit_breach_action` STRING COMMENT 'Prescribed action to be taken when a risk limit is breached (e.g., Immediate position reduction, Escalate to CRO, Suspend new trades). Defines the operational response protocol.',
    `next_limit_review_date` DATE COMMENT 'Scheduled date for the next formal review of hedge program limits and parameters. Used for governance planning and compliance monitoring.',
    `notes` STRING COMMENT 'Free-text field for additional context, special instructions, or operational notes about the hedge program. Used for documentation and knowledge transfer.',
    `program_code` STRING COMMENT 'Short alphanumeric code uniquely identifying the hedge program for operational reference and reporting (e.g., HP-2024-GEN-01).',
    `program_name` STRING COMMENT 'Business name of the hedge program (e.g., FY2024 Generation Output Hedge, Natural Gas Procurement Hedge Q1-Q4).',
    `program_status` STRING COMMENT 'Current lifecycle status of the hedge program: active (currently executing trades), suspended (temporarily halted), closed (program ended), or pending approval (awaiting board authorization).. Valid values are `active|suspended|closed|pending_approval`',
    `regulatory_classification` STRING COMMENT 'Regulatory classification of the hedge program: utility hedging (prudent hedging for regulated operations), merchant trading (competitive market activities), speculative (non-hedging trading), or proprietary (firm capital trading). Determines regulatory treatment and cost recovery eligibility.. Valid values are `utility_hedging|merchant_trading|speculative|proprietary`',
    `responsible_trader_name` STRING COMMENT 'Name of the lead trader or portfolio manager responsible for executing this hedge program.',
    `rto_iso_market` STRING COMMENT 'Primary RTO/ISO market in which this hedge program operates (e.g., PJM, ERCOT, CAISO, MISO, NYISO, ISO-NE, SPP). Defines the geographic and regulatory market context.',
    `stop_loss_limit_usd` DECIMAL(18,2) COMMENT 'Maximum cumulative loss threshold in USD that triggers mandatory position closure or escalation. Used for downside risk protection and loss containment.',
    `tenor_limit_months` STRING COMMENT 'Maximum tenor (time to maturity) allowed for derivative contracts under this hedge program, expressed in months. Defines how far forward the utility may transact.',
    `trading_desk` STRING COMMENT 'Name of the trading desk or business unit responsible for this hedge program (e.g., Power Trading, Gas Supply, Fuel Procurement).',
    `var_confidence_level_percent` DECIMAL(18,2) COMMENT 'Confidence level for VaR calculation expressed as a percentage (e.g., 95.00 or 99.00). Defines the statistical confidence interval for the VaR limit.',
    `var_limit_usd` DECIMAL(18,2) COMMENT 'Maximum Value at Risk (VaR) limit for this hedge program expressed in USD. Defines the maximum potential loss at the specified confidence level and time horizon. Used for risk monitoring and limit compliance.',
    `var_time_horizon_days` STRING COMMENT 'Time horizon for VaR calculation expressed in days (e.g., 1 for daily VaR, 10 for 10-day VaR). Defines the holding period assumption for the risk measure.',
    `volume_unit_of_measure` STRING COMMENT 'Unit of measure for approved volumes: MWh (megawatt-hour for electricity), MMBtu (million British thermal units for gas), tons (for coal), GJ (gigajoules), or therms.. Valid values are `MWh|MMBtu|tons|GJ|therms`',
    CONSTRAINT pk_hedge_program PRIMARY KEY(`hedge_program_id`)
) COMMENT 'Master record for formal hedging programs defining the utilitys hedging strategy for generation output, fuel procurement, and load obligations. Captures program name, hedge type (generation output hedge, fuel cost hedge, load hedge, basis hedge), commodity, hedge ratio target (%), hedge horizon (months), approved volume range, instrument types allowed (swap, option, forward, futures), board approval date, and ASC 815 hedge designation (cash flow hedge, fair value hedge). Governs hedge execution and accounting treatment.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` (
    `rec_transaction_id` BIGINT COMMENT 'Unique identifier for the REC transaction record. Primary key.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: REC transactions must be tied to the generating asset for renewable credit tracking and compliance reporting.',
    `counterparty_id` BIGINT COMMENT 'Unique identifier for the counterparty organization in the trading system or master data repository.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: REQUIRED: REC sales are billed to specific customer accounts; linking enables REC Sales to Customer reporting for compliance and invoicing.',
    `dsm_program_id` BIGINT COMMENT 'Foreign key linking to engagement.dsm_program. Business justification: REC transaction reporting must attribute each transaction to the DSM program that generated it for compliance and incentive calculations.',
    `facility_id` BIGINT COMMENT 'Unique identifier for the generation facility in the registry system or EIA database. May be EIA plant code or registry-specific facility ID.',
    `portfolio_id` BIGINT COMMENT 'Identifier of the trading portfolio or book to which this REC transaction is assigned for risk management and P&L attribution.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Needed to associate REC transactions with the specific incentive program for compliance and tracking.',
    `rec_certificate_id` BIGINT COMMENT 'Foreign key linking to generation.generation_rec_certificate. Business justification: REC transactions settle specific renewable energy certificates generated by units; linking to the certificate record enables audit and compliance reporting.',
    `rec_inventory_id` BIGINT COMMENT 'Foreign key linking to regulatory.rec_inventory. Business justification: REC Transaction Tracking: each REC transaction must reference the specific REC registry entry it affects for compliance and tracking.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: REC validation depends on SCADA generation data; linking the transaction to the SCADA system ensures traceability for compliance.',
    `broker_name` STRING COMMENT 'Name of the broker or intermediary that facilitated the REC transaction, if applicable. Null if transaction was direct between parties.',
    `compliance_program` STRING COMMENT 'The regulatory compliance program or voluntary program for which the RECs are intended: state RPS (Renewable Portfolio Standard), voluntary green power program, carbon offset program, or corporate sustainability commitment. Free-text to accommodate various state and voluntary programs.',
    `compliance_year` STRING COMMENT 'The compliance year for which the RECs will be applied or retired. May differ from vintage year due to banking or forward purchase provisions.',
    `confirmation_date` DATE COMMENT 'Date when the REC transaction was confirmed by the counterparty or broker, validating the transaction terms.',
    `confirmation_number` STRING COMMENT 'Confirmation number or reference provided by the counterparty or broker confirming the REC transaction details.',
    `contract_reference` STRING COMMENT 'Reference number or identifier of the master agreement, PPA, or specific contract under which this REC transaction was executed.',
    `cost_center_code` STRING COMMENT 'Cost center code in the financial system (SAP FI/CO) to which the REC transaction costs or revenues are allocated.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this REC transaction record was first created in the system. Used for audit trail and data lineage.',
    `delivery_method` STRING COMMENT 'Method by which RECs are delivered: registry transfer (electronic transfer within tracking system), physical certificate (paper certificate delivery), or electronic transfer (outside registry system).. Valid values are `registry_transfer|physical_certificate|electronic_transfer`',
    `eligibility_flags` STRING COMMENT 'Comma-separated list of eligibility attributes or certifications for the RECs: new_renewable, solar_carve_out, offshore_wind, community_solar, low_income_eligible, etc. Used for state-specific RPS tier compliance.',
    `etrm_system_deal_reference` STRING COMMENT 'Unique deal or transaction identifier in the Allegro ETRM system or other energy trading platform. Used for reconciliation between lakehouse and source system.',
    `facility_state` STRING COMMENT 'U.S. state or Canadian province where the renewable generation facility is located. Important for state-specific RPS compliance.',
    `gl_account_code` STRING COMMENT 'General ledger account code in the chart of accounts where the REC transaction is recorded for financial reporting.',
    `green_e_certified_flag` BOOLEAN COMMENT 'Indicates whether the RECs are certified under the Green-e voluntary renewable energy certification program. True if Green-e certified, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this REC transaction record was last updated or modified. Used for audit trail and change tracking.',
    `modified_by_user` STRING COMMENT 'Username or identifier of the user who last modified this REC transaction record. Used for audit and accountability.',
    `notes` STRING COMMENT 'Free-text notes or comments about the REC transaction, including special terms, conditions, or operational details.',
    `payment_date` DATE COMMENT 'Date when payment for the REC transaction was made or received. Null if payment is still pending.',
    `payment_status` STRING COMMENT 'Current status of payment for the REC transaction: pending (awaiting payment), paid (payment completed), overdue (payment past due date), disputed (payment under dispute), or waived (payment not required).. Valid values are `pending|paid|overdue|disputed|waived`',
    `payment_terms` STRING COMMENT 'Payment terms for the REC transaction: net 30, net 60, payment on delivery, advance payment, or other negotiated terms.',
    `price_per_rec` DECIMAL(18,2) COMMENT 'Unit price paid or received per REC certificate, typically expressed in dollars per REC ($/REC). Used to calculate total transaction value.',
    `quantity_mwh` DECIMAL(18,2) COMMENT 'Quantity of renewable energy certificates in megawatt-hours (MWh). Each REC typically represents 1 MWh of renewable energy generation.',
    `registry_system` STRING COMMENT 'The renewable energy certificate tracking system or registry where the RECs are registered: WREGIS (Western), NEPOOL-GIS (New England), PJM-GATS (PJM), M-RETS (Midwest), NAR (North American Renewables), ERCOT, or MIRECS (Michigan). [ENUM-REF-CANDIDATE: WREGIS|NEPOOL-GIS|PJM-GATS|M-RETS|NAR|ERCOT|MIRECS — 7 candidates stripped; promote to reference product]',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'Indicates whether this REC transaction must be included in regulatory compliance reporting to state PUC, FERC, or EPA. True if reportable, False otherwise.',
    `retirement_account` STRING COMMENT 'Registry account name or identifier where RECs were retired, if applicable. Used for audit trail and compliance verification.',
    `retirement_reason` STRING COMMENT 'Reason for retiring the RECs if transaction type is retirement: RPS compliance, voluntary green power claim, carbon neutrality goal, corporate sustainability reporting, or other specific purpose. Null for non-retirement transactions.',
    `settlement_date` DATE COMMENT 'Date when the REC transaction was settled and recorded in the registry system, completing the transfer of ownership or retirement.',
    `technology_type` STRING COMMENT 'Type of renewable energy technology that generated the RECs: solar (photovoltaic or thermal), wind (onshore or offshore), hydro (hydroelectric), biomass (organic matter combustion), geothermal (earth heat), or landfill gas (methane capture).. Valid values are `solar|wind|hydro|biomass|geothermal|landfill_gas`',
    `total_transaction_value` DECIMAL(18,2) COMMENT 'Total monetary value of the REC transaction in USD, calculated as quantity multiplied by price per REC. Represents the gross transaction amount before fees or adjustments.',
    `trader_name` STRING COMMENT 'Name of the trader or trading desk personnel responsible for executing this REC transaction.',
    `transaction_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for the transaction. Typically USD for U.S. transactions or CAD for Canadian transactions.. Valid values are `USD|CAD`',
    `transaction_date` DATE COMMENT 'Date when the REC transaction was executed or agreed upon between parties. This is the business event date for the transaction.',
    `transaction_number` STRING COMMENT 'Business-facing unique transaction number or reference code for the REC transaction, used for external communication and audit trails.',
    `transaction_status` STRING COMMENT 'Current lifecycle status of the REC transaction: pending (awaiting confirmation), confirmed (counterparty confirmed), settled (completed and recorded in registry), cancelled (voided before settlement), failed (transaction did not complete), or reversed (settled transaction reversed).. Valid values are `pending|confirmed|settled|cancelled|failed|reversed`',
    `transaction_type` STRING COMMENT 'Type of REC transaction: purchase (acquiring RECs from market or counterparty), sale (selling RECs to counterparty), retirement (retiring RECs for compliance or voluntary purposes), transfer (moving RECs between accounts or registries), issuance (initial creation of RECs from generation), or cancellation (voiding RECs).. Valid values are `purchase|sale|retirement|transfer|issuance|cancellation`',
    `vintage_year` STRING COMMENT 'The year in which the renewable energy was generated that corresponds to these RECs. Vintage year is critical for compliance programs with specific vintage requirements.',
    CONSTRAINT pk_rec_transaction PRIMARY KEY(`rec_transaction_id`)
) COMMENT 'Renewable Energy Certificate (REC) transaction record capturing purchases, sales, retirements, and transfers of RECs. Captures REC transaction ID, transaction type (purchase, sale, retirement, transfer), REC vintage year, technology type (solar, wind, hydro, biomass), generation facility, state registry (WREGIS, NEPOOL-GIS, PJM-GATS), certificate serial numbers, quantity (MWh), price ($/REC), counterparty, transaction date, compliance program (RPS, voluntary), and retirement reason. Supports renewable portfolio standard (RPS) compliance tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` (
    `ancillary_award_id` BIGINT COMMENT 'Unique identifier for the ancillary services award record. Primary key for the ancillary award entity.',
    `registry_id` BIGINT COMMENT 'Reference to the generation or demand response resource that received the ancillary services award.',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty entity (resource owner or scheduling coordinator) that holds the ancillary services award.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Ancillary Service Reporting: awards are reported in regulatory filings; linking provides traceability for compliance audits.',
    `market_id` BIGINT COMMENT 'Reference to the ISO/RTO market in which the ancillary service was awarded.',
    `portfolio_id` BIGINT COMMENT 'Reference to the internal trading portfolio or book to which this ancillary services award is allocated for risk management and P&L tracking.',
    `pricing_node_id` BIGINT COMMENT 'Reference to the locational marginal pricing (LMP) node or zone where the resource is located and the ancillary service price applies.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Ancillary service awards are tied to specific program participation; linking enables program‑level award tracking.',
    `line_id` BIGINT COMMENT 'Foreign key linking to transmission.line. Business justification: Ancillary Service Award tied to a specific transmission line for frequency regulation or voltage support, needed for award verification.',
    `actual_delivery_mw` DECIMAL(18,2) COMMENT 'Actual capacity in megawatts delivered by the resource when called upon to provide the ancillary service. May differ from awarded capacity.',
    `award_amount_usd` DECIMAL(18,2) COMMENT 'Total dollar amount of the ancillary services award, calculated as awarded capacity multiplied by clearing price.',
    `award_number` STRING COMMENT 'External business identifier for the ancillary services award assigned by the ISO/RTO market system.',
    `award_status` STRING COMMENT 'Current lifecycle status of the ancillary services award: awarded (initial), confirmed (accepted by resource), deployed (actively providing service), settled (financially settled), cancelled, or expired.. Valid values are `awarded|confirmed|deployed|settled|cancelled|expired`',
    `award_timestamp` TIMESTAMP COMMENT 'Timestamp when the ISO/RTO issued the ancillary services award to the resource.',
    `awarded_capacity_mw` DECIMAL(18,2) COMMENT 'The capacity in megawatts (MW) that was awarded to the resource for providing the ancillary service during the specified interval.',
    `clearing_price_per_mw` DECIMAL(18,2) COMMENT 'The market clearing price in dollars per megawatt ($/MW) for the ancillary service capacity awarded.',
    `confirmation_timestamp` TIMESTAMP COMMENT 'Timestamp when the resource owner or scheduling coordinator confirmed acceptance of the ancillary services award.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this ancillary award record was first created in the data platform.',
    `data_source_system` STRING COMMENT 'Name of the source system from which the ancillary award data was ingested (e.g., ISO/RTO market system, Allegro ETRM).',
    `deployment_duration_minutes` STRING COMMENT 'Total duration in minutes that the ancillary service was actively deployed during the interval.',
    `deployment_flag` BOOLEAN COMMENT 'Indicates whether the ancillary service was actually deployed (called upon) during the interval. True if deployed, False if only capacity payment applies.',
    `energy_payment_usd` DECIMAL(18,2) COMMENT 'Additional payment in dollars for energy delivered when the ancillary service was deployed, separate from the capacity award amount.',
    `etrm_deal_number` STRING COMMENT 'Deal or transaction number in the Allegro ETRM system associated with this ancillary services award.',
    `ingestion_timestamp` TIMESTAMP COMMENT 'Timestamp when the ancillary award record was ingested into the utilitys data platform from the source system.',
    `interval_duration_minutes` STRING COMMENT 'Duration of the market interval in minutes (e.g., 5, 15, 60) for which the award applies.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this ancillary award record was last modified in the data platform.',
    `market_interval_end` TIMESTAMP COMMENT 'End timestamp of the market interval for which the ancillary service award applies.',
    `market_interval_start` TIMESTAMP COMMENT 'Start timestamp of the market interval for which the ancillary service award applies, typically in 5-minute or 15-minute increments.',
    `market_type` STRING COMMENT 'Type of market in which the ancillary service was awarded: day-ahead market (DAM), real-time market (RTM), or supplemental procurement.. Valid values are `day_ahead|real_time|supplemental`',
    `notes` STRING COMMENT 'Free-text notes or comments regarding the ancillary services award, including any special conditions, adjustments, or operational remarks.',
    `obligation_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the resources obligation to provide the ancillary service ends.',
    `obligation_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the resources obligation to provide the ancillary service begins.',
    `operating_date` DATE COMMENT 'The operating day for which the ancillary service capacity was awarded and must be available.',
    `operating_hour` STRING COMMENT 'The hour-ending (HE) of the operating day for which the award applies, typically 1-24 or 0-23 depending on ISO/RTO convention.',
    `performance_score` DECIMAL(18,2) COMMENT 'Performance score as a percentage (0-100) measuring how well the resource met its ancillary service obligation during the interval. Used for settlement adjustments and future market qualification.',
    `pricing_zone` STRING COMMENT 'Name of the pricing zone or load zone where the ancillary service award applies.',
    `publication_timestamp` TIMESTAMP COMMENT 'Timestamp when the ISO/RTO published the ancillary services award results to market participants.',
    `resource_type` STRING COMMENT 'Type of resource providing the ancillary service (e.g., thermal generation, hydro, battery storage, demand response, wind, solar).',
    `rto_iso_market` STRING COMMENT 'Name of the RTO or ISO market operator that issued the award (e.g., PJM, CAISO, ERCOT, MISO, NYISO, ISO-NE, SPP).',
    `service_category` STRING COMMENT 'Broader category of ancillary service: frequency regulation, contingency reserve, voltage control, or black start capability.. Valid values are `frequency_regulation|contingency_reserve|voltage_control|black_start`',
    `service_type` STRING COMMENT 'Type of ancillary service awarded: regulation up, regulation down, spinning reserve, non-spinning reserve, supplemental reserve, reactive power, or voltage support. [ENUM-REF-CANDIDATE: regulation_up|regulation_down|spinning_reserve|non_spinning_reserve|supplemental_reserve|reactive_power|voltage_support — 7 candidates stripped; promote to reference product]',
    `settlement_amount_usd` DECIMAL(18,2) COMMENT 'Final settlement amount in dollars after applying performance adjustments, penalties, and energy payments. May differ from initial award amount.',
    `settlement_date` DATE COMMENT 'Date when the ancillary services award was financially settled by the ISO/RTO.',
    `settlement_run_number` STRING COMMENT 'Sequential number of the settlement run (initial, resettlement, final) in which this award was settled. ISO/RTOs may perform multiple settlement passes.',
    CONSTRAINT pk_ancillary_award PRIMARY KEY(`ancillary_award_id`)
) COMMENT 'ISO/RTO ancillary services award record for capacity cleared in regulation, spinning reserve, non-spinning reserve, and voltage support markets. Captures award ID, market, operating day, hour/interval, service type (regulation up/down, spinning reserve, non-spin, reactive), resource ID, awarded MW, clearing price ($/MW), obligation start/end, performance score, and settlement amount. Supports ancillary revenue tracking and NERC reliability compliance.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` (
    `credit_exposure_id` BIGINT COMMENT 'Unique identifier for the credit exposure record. Primary key for time-series credit exposure tracking.',
    `counterparty_id` BIGINT COMMENT 'Reference to the counterparty entity for which credit exposure is being tracked. Links to the master counterparty record.',
    `portfolio_id` BIGINT COMMENT 'Reference to the trading portfolio associated with this credit exposure calculation.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit exposure record or status change was approved by the credit officer.',
    `approved_by` STRING COMMENT 'Name or identifier of the credit officer or risk manager who approved the credit exposure calculation or status change.',
    `approved_credit_limit_usd` DECIMAL(18,2) COMMENT 'Maximum credit exposure limit approved for this counterparty in US Dollars. Represents the total authorized exposure threshold.',
    `breach_amount_usd` DECIMAL(18,2) COMMENT 'Amount by which the current exposure exceeds the approved credit limit in US Dollars. Null if no breach exists.',
    `collateral_posted_usd` DECIMAL(18,2) COMMENT 'Total value of collateral posted by the utility to the counterparty in US Dollars. Includes cash, letters of credit, and other eligible collateral forms.',
    `collateral_received_usd` DECIMAL(18,2) COMMENT 'Total value of collateral received from the counterparty in US Dollars. Includes cash, letters of credit, and other eligible collateral forms.',
    `collateral_type_posted` STRING COMMENT 'Type of collateral posted by the utility to the counterparty (e.g., cash, letter of credit, parent guarantee).. Valid values are `Cash|Letter of Credit|Parent Guarantee|Surety Bond|Securities|None`',
    `collateral_type_received` STRING COMMENT 'Type of collateral received from the counterparty (e.g., cash, letter of credit, parent guarantee).. Valid values are `Cash|Letter of Credit|Parent Guarantee|Surety Bond|Securities|None`',
    `commodity_concentration_risk_flag` BOOLEAN COMMENT 'Indicates whether the exposure to this counterparty represents a concentration risk in a specific commodity (power, gas, RECs). True if concentration risk exists, False otherwise.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit exposure record was first created in the lakehouse silver layer.',
    `credit_rating` STRING COMMENT 'Credit rating of the counterparty as of the exposure date. Snapshot value from the specified rating agency (e.g., AAA, BBB+, Ba2).',
    `credit_rating_agency` STRING COMMENT 'The rating agency providing the credit rating snapshot as of the exposure date.. Valid values are `S&P|Moodys|Fitch|Internal|Not Rated`',
    `credit_rating_effective_date` DATE COMMENT 'Date when the credit rating became effective or was last updated by the rating agency.',
    `credit_status` STRING COMMENT 'Current credit status classification for the counterparty. Determines trading restrictions and approval requirements.. Valid values are `Normal|Watch|Restricted|Suspended|Default`',
    `credit_status_effective_date` DATE COMMENT 'Date when the current credit status became effective.',
    `credit_status_reason` STRING COMMENT 'Business reason or justification for the current credit status classification (e.g., rating downgrade, payment default, limit breach).',
    `credit_utilization_percent` DECIMAL(18,2) COMMENT 'Percentage of the approved credit limit currently utilized. Calculated as (net exposure / approved credit limit) * 100.',
    `credit_valuation_adjustment_usd` DECIMAL(18,2) COMMENT 'Credit valuation adjustment representing the market value of counterparty credit risk. Calculated as the difference between risk-free portfolio value and value adjusted for counterparty default risk.',
    `current_exposure_usd` DECIMAL(18,2) COMMENT 'Current mark-to-market exposure to the counterparty in US Dollars. Represents the replacement cost if the counterparty defaults today.',
    `days_to_margin_call` STRING COMMENT 'Number of days until a margin call is required based on current exposure trajectory and contractual terms. Null if no margin call is anticipated.',
    `etrm_system_exposure_reference` STRING COMMENT 'Unique identifier for this credit exposure record in the source Allegro ETRM system. Used for data lineage and reconciliation.',
    `expected_credit_loss_usd` DECIMAL(18,2) COMMENT 'Expected credit loss calculated per IFRS 9 or CECL accounting standards. Represents the probability-weighted estimate of credit losses.',
    `exposure_at_default_usd` DECIMAL(18,2) COMMENT 'Estimated exposure amount at the time of counterparty default in US Dollars. Used in expected credit loss calculations.',
    `exposure_breach_flag` BOOLEAN COMMENT 'Indicates whether the current exposure exceeds the approved credit limit. True if in breach, False otherwise.',
    `exposure_calculation_timestamp` TIMESTAMP COMMENT 'Timestamp when the credit exposure calculation was performed by the ETRM system.',
    `exposure_date` DATE COMMENT 'Business date for which the credit exposure is calculated. Represents the snapshot date for this time-series record.',
    `geographic_concentration_risk_flag` BOOLEAN COMMENT 'Indicates whether the exposure to this counterparty represents a concentration risk in a specific geographic region or RTO/ISO market. True if concentration risk exists, False otherwise.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this credit exposure record was last updated in the lakehouse silver layer.',
    `loss_given_default_percent` DECIMAL(18,2) COMMENT 'Estimated percentage of exposure that will be lost if the counterparty defaults, after accounting for recovery.',
    `margin_call_status` STRING COMMENT 'Current status of margin call activity for this counterparty as of the exposure date.. Valid values are `No Call Required|Call Issued|Call Pending|Call Satisfied|Call Disputed`',
    `margin_call_threshold_usd` DECIMAL(18,2) COMMENT 'Exposure threshold in US Dollars at which a margin call is triggered per the credit agreement or ISDA CSA.',
    `net_exposure_usd` DECIMAL(18,2) COMMENT 'Net credit exposure after accounting for collateral posted and received. Calculated as current exposure plus potential future exposure minus net collateral.',
    `netting_agreement_flag` BOOLEAN COMMENT 'Indicates whether a legally enforceable netting agreement (e.g., ISDA Master Agreement) is in place with the counterparty. True if netting is allowed, False otherwise.',
    `netting_set_code` STRING COMMENT 'Identifier for the netting set under which trades with this counterparty are grouped for exposure calculation purposes.',
    `notes` STRING COMMENT 'Free-form text field for additional comments, observations, or context regarding the credit exposure calculation or counterparty credit status.',
    `pfe_calculation_method` STRING COMMENT 'Methodology used to calculate the potential future exposure (e.g., Monte Carlo simulation, parametric VaR, historical simulation).. Valid values are `Monte Carlo|Parametric|Historical Simulation|Standardized Approach|Internal Model`',
    `pfe_confidence_level_percent` DECIMAL(18,2) COMMENT 'Confidence level used in the PFE calculation expressed as a percentage (e.g., 95.00, 99.00). Represents the statistical confidence interval for the exposure estimate.',
    `pfe_time_horizon_days` STRING COMMENT 'Time horizon in days over which the potential future exposure is calculated (e.g., 10 days, 30 days, 365 days).',
    `potential_future_exposure_usd` DECIMAL(18,2) COMMENT 'Potential future exposure calculated using Monte Carlo or parametric methods. Represents the maximum expected exposure over the life of the contracts at a specified confidence level.',
    `probability_of_default_percent` DECIMAL(18,2) COMMENT 'Estimated probability that the counterparty will default within a specified time horizon, expressed as a percentage.',
    `regulatory_capital_charge_usd` DECIMAL(18,2) COMMENT 'Regulatory capital charge required for this credit exposure per Basel III or applicable regulatory framework in US Dollars.',
    `risk_weighted_asset_usd` DECIMAL(18,2) COMMENT 'Risk-weighted asset value for this credit exposure calculated per Basel III standardized or internal ratings-based approach in US Dollars.',
    CONSTRAINT pk_credit_exposure PRIMARY KEY(`credit_exposure_id`)
) COMMENT 'Time-series counterparty credit exposure record tracking daily current and potential future credit exposure calculations, distinct from the static credit profile on counterparty. Captures exposure date, counterparty, credit rating snapshot (S&P/Moodys as of date), approved credit limit, current mark-to-market exposure, potential future exposure (PFE) using Monte Carlo or parametric methods, collateral posted (cash/LC) and received, net exposure after collateral, credit utilization percentage, margin call threshold, days to margin call, and credit status (normal, watch, restricted, suspended). Serves as the time-series audit trail for credit decisions while counterparty holds the static credit profile.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`market` (
    `market_id` BIGINT COMMENT 'Primary key for market',
    `parent_market_id` BIGINT COMMENT 'Self-referencing FK on market (parent_market_id)',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the market record was first created in the system.',
    `currency` STRING COMMENT 'Currency used for pricing and settlement in the market.',
    `market_description` STRING COMMENT 'Detailed textual description of the markets purpose and characteristics.',
    `effective_from` DATE COMMENT 'Date when the market definition becomes effective.',
    `effective_until` DATE COMMENT 'Date when the market definition expires or is superseded; null if indefinite.',
    `is_active` BOOLEAN COMMENT 'Indicates whether the market is currently active for trading.',
    `market_category` STRING COMMENT 'High-level category grouping markets by function.',
    `market_code` STRING COMMENT 'Short alphanumeric code representing the market (e.g., DAM for Day-Ahead Market).',
    `market_data_refresh_rate_minutes` STRING COMMENT 'Frequency, in minutes, at which market data is refreshed.',
    `market_data_source` STRING COMMENT 'System or vendor providing market data feeds.',
    `market_is_financial` BOOLEAN COMMENT 'True if the market is purely financial (e.g., futures, swaps).',
    `market_is_hedgeable` BOOLEAN COMMENT 'Indicates whether positions in this market can be used for hedging.',
    `market_is_physical` BOOLEAN COMMENT 'True if the market involves physical delivery of electricity or gas.',
    `market_lmp_basis` STRING COMMENT 'Locational marginal pricing basis used for settlement.',
    `market_name` STRING COMMENT 'Full descriptive name of the market.',
    `market_notes` STRING COMMENT 'Free-form notes or comments about the market.',
    `market_operator` STRING COMMENT 'Organization responsible for operating the market.',
    `market_price_precision` STRING COMMENT 'Number of decimal places used for market price values.',
    `market_price_unit` STRING COMMENT 'Unit of measure for market prices (e.g., USD/MWh).',
    `market_regulation` STRING COMMENT 'Regulatory authority governing the market.',
    `market_settlement_period` STRING COMMENT 'Standard settlement interval for the market.',
    `market_subtype` STRING COMMENT 'More granular classification within the market category.',
    `market_timezone` STRING COMMENT 'Time zone identifier for market operating hours (e.g., America/New_York).',
    `market_type` STRING COMMENT 'Classification of the market based on trading horizon or service.',
    `market_volatility_index` DECIMAL(18,2) COMMENT 'Numeric indicator of price volatility for the market.',
    `market_website` STRING COMMENT 'Public-facing website URL for the market.',
    `region` STRING COMMENT 'Geographic region or ISO country code where the market operates.',
    `settlement_rule` STRING COMMENT 'Rule defining how market settlements are calculated.',
    `market_status` STRING COMMENT 'Current lifecycle status of the market record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the market record.',
    CONSTRAINT pk_market PRIMARY KEY(`market_id`)
) COMMENT 'Master reference table for market. Referenced by market_id.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`trading`.`pricing_node` (
    `pricing_node_id` BIGINT COMMENT 'Primary key for pricing_node',
    `aggregate_pricing_node_id` BIGINT COMMENT 'Self-referencing FK on pricing_node (aggregate_pricing_node_id)',
    `pricing_node_code` STRING COMMENT 'Business code used to reference the pricing node in trading systems.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pricing node record was first created in the lakehouse.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the price.',
    `pricing_node_description` STRING COMMENT 'Free‑form description of the pricing nodes purpose or characteristics.',
    `effective_from` DATE COMMENT 'Date when the pricing node becomes effective for trading.',
    `effective_until` DATE COMMENT 'Date when the pricing node ceases to be effective; null if open‑ended.',
    `is_default` BOOLEAN COMMENT 'Indicates whether this node is the default pricing node for its market segment.',
    `last_price_update` TIMESTAMP COMMENT 'Timestamp of the most recent price refresh for the node.',
    `market` STRING COMMENT 'Electricity market or ISO region to which the pricing node belongs.',
    `pricing_node_name` STRING COMMENT 'Human‑readable name of the pricing node.',
    `node_type` STRING COMMENT 'Classification of the pricing node within the network topology.',
    `notes` STRING COMMENT 'Free‑form field for any supplemental information about the pricing node.',
    `price` DECIMAL(18,2) COMMENT 'Current price associated with the node (e.g., $/MWh).',
    `price_cap` DECIMAL(18,2) COMMENT 'Maximum allowable price for the node in risk‑management calculations.',
    `price_floor` DECIMAL(18,2) COMMENT 'Minimum allowable price for the node in risk‑management calculations.',
    `price_source` STRING COMMENT 'Origin of the price data for this node.',
    `settlement_type` STRING COMMENT 'Method used to settle transactions at this node.',
    `pricing_node_status` STRING COMMENT 'Current lifecycle status of the pricing node.',
    `unit_of_measure` STRING COMMENT 'Unit in which the price is expressed.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the pricing node record.',
    CONSTRAINT pk_pricing_node PRIMARY KEY(`pricing_node_id`)
) COMMENT 'Master reference table for pricing_node. Referenced by pricing_node_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `power_and_utilities_v2`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ADD CONSTRAINT `fk_trading_trade_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities_v2`.`trading`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ADD CONSTRAINT `fk_trading_trade_leg_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `power_and_utilities_v2`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ADD CONSTRAINT `fk_trading_trade_leg_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `power_and_utilities_v2`.`trading`.`trade`(`trade_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_market_id` FOREIGN KEY (`market_id`) REFERENCES `power_and_utilities_v2`.`trading`.`market`(`market_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ADD CONSTRAINT `fk_trading_position_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `power_and_utilities_v2`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ADD CONSTRAINT `fk_trading_ppa_contract_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities_v2`.`trading`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `power_and_utilities_v2`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities_v2`.`trading`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_market_id` FOREIGN KEY (`market_id`) REFERENCES `power_and_utilities_v2`.`trading`.`market`(`market_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ADD CONSTRAINT `fk_trading_market_bid_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ADD CONSTRAINT `fk_trading_lmp_price_market_id` FOREIGN KEY (`market_id`) REFERENCES `power_and_utilities_v2`.`trading`.`market`(`market_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ADD CONSTRAINT `fk_trading_settlement_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `power_and_utilities_v2`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ADD CONSTRAINT `fk_trading_settlement_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ADD CONSTRAINT `fk_trading_settlement_ppa_contract_id` FOREIGN KEY (`ppa_contract_id`) REFERENCES `power_and_utilities_v2`.`trading`.`ppa_contract`(`ppa_contract_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ADD CONSTRAINT `fk_trading_settlement_trade_id` FOREIGN KEY (`trade_id`) REFERENCES `power_and_utilities_v2`.`trading`.`trade`(`trade_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ADD CONSTRAINT `fk_trading_mtm_valuation_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `power_and_utilities_v2`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ADD CONSTRAINT `fk_trading_mtm_valuation_market_id` FOREIGN KEY (`market_id`) REFERENCES `power_and_utilities_v2`.`trading`.`market`(`market_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ADD CONSTRAINT `fk_trading_mtm_valuation_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ADD CONSTRAINT `fk_trading_risk_limit_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ADD CONSTRAINT `fk_trading_hedge_program_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ADD CONSTRAINT `fk_trading_rec_transaction_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `power_and_utilities_v2`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ADD CONSTRAINT `fk_trading_rec_transaction_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ADD CONSTRAINT `fk_trading_ancillary_award_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `power_and_utilities_v2`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ADD CONSTRAINT `fk_trading_ancillary_award_market_id` FOREIGN KEY (`market_id`) REFERENCES `power_and_utilities_v2`.`trading`.`market`(`market_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ADD CONSTRAINT `fk_trading_ancillary_award_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ADD CONSTRAINT `fk_trading_ancillary_award_pricing_node_id` FOREIGN KEY (`pricing_node_id`) REFERENCES `power_and_utilities_v2`.`trading`.`pricing_node`(`pricing_node_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ADD CONSTRAINT `fk_trading_credit_exposure_counterparty_id` FOREIGN KEY (`counterparty_id`) REFERENCES `power_and_utilities_v2`.`trading`.`counterparty`(`counterparty_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ADD CONSTRAINT `fk_trading_credit_exposure_portfolio_id` FOREIGN KEY (`portfolio_id`) REFERENCES `power_and_utilities_v2`.`trading`.`portfolio`(`portfolio_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`market` ADD CONSTRAINT `fk_trading_market_parent_market_id` FOREIGN KEY (`parent_market_id`) REFERENCES `power_and_utilities_v2`.`trading`.`market`(`market_id`);
ALTER TABLE `power_and_utilities_v2`.`trading`.`pricing_node` ADD CONSTRAINT `fk_trading_pricing_node_aggregate_pricing_node_id` FOREIGN KEY (`aggregate_pricing_node_id`) REFERENCES `power_and_utilities_v2`.`trading`.`pricing_node`(`pricing_node_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`trading` SET TAGS ('dbx_division' = 'business');
ALTER SCHEMA `power_and_utilities_v2`.`trading` SET TAGS ('dbx_domain' = 'trading');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` SET TAGS ('dbx_subdomain' = 'portfolio_analytics');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `approved_credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Credit Limit (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `approved_credit_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `collateral_held_usd` SET TAGS ('dbx_business_glossary_term' = 'Collateral Held (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `collateral_held_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `collateral_posted_usd` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `collateral_posted_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `counterparty_status` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `counterparty_status` SET TAGS ('dbx_value_regex' = 'active|suspended|inactive|credit_watch|terminated');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_value_regex' = 'utility|marketer|financial_institution|iso_rto|generator|fuel_supplier');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `credit_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Credit Contact Email Address');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `credit_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `credit_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `credit_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `credit_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Credit Contact Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `credit_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `credit_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `credit_watch_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Watch Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `credit_watch_status` SET TAGS ('dbx_value_regex' = 'none|positive_watch|negative_watch|under_review');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `csa_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Effective Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `csa_minimum_transfer_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Minimum Transfer Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `csa_minimum_transfer_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `csa_threshold_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Support Annex (CSA) Threshold Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `csa_threshold_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `current_credit_exposure_usd` SET TAGS ('dbx_business_glossary_term' = 'Current Credit Exposure (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `current_credit_exposure_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `duns_number` SET TAGS ('dbx_value_regex' = '^[0-9]{9}$');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `ferc_registration_number` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Registration Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `fitch_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Fitch Credit Rating');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `guarantee_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Guarantee Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `guarantee_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 1');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Address Line 2');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_business_glossary_term' = 'Headquarters City');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Country Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Headquarters Postal Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_business_glossary_term' = 'Headquarters State or Province');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `headquarters_state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `internal_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Internal Credit Rating');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Jurisdiction');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `last_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Credit Review Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `legal_entity_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `master_agreement_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Master Agreement Effective Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `master_agreement_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Master Agreement Reference Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `master_agreement_type` SET TAGS ('dbx_business_glossary_term' = 'Master Agreement Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `master_agreement_type` SET TAGS ('dbx_value_regex' = 'ISDA|NAESB|EEI|WSPP|custom');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `moodys_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Moodys Credit Rating');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `nerc_registration_code` SET TAGS ('dbx_business_glossary_term' = 'North American Electric Reliability Corporation (NERC) Registration Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `netting_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `next_credit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Credit Review Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `onboarding_date` SET TAGS ('dbx_business_glossary_term' = 'Onboarding Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `parent_guarantor_name` SET TAGS ('dbx_business_glossary_term' = 'Parent Guarantor Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `sp_credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Standard & Poors (S&P) Credit Rating');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `tax_identification_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`counterparty` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `customer_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Service Point Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `fuel_supply_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Supply Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `metering_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Der Resource Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `trader_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `amendment_version` SET TAGS ('dbx_business_glossary_term' = 'Amendment Version Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `broker_reference` SET TAGS ('dbx_business_glossary_term' = 'Broker Reference');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `buy_sell_indicator` SET TAGS ('dbx_business_glossary_term' = 'Buy or Sell Indicator');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `buy_sell_indicator` SET TAGS ('dbx_value_regex' = 'buy|sell');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `confirmation_method` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Method');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `confirmation_method` SET TAGS ('dbx_value_regex' = 'electronic|email|phone|fax|exchange_matched');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|disputed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `credit_limit_check` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit Check Passed');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period End Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `etrm_trade_number` SET TAGS ('dbx_business_glossary_term' = 'Energy Trading and Risk Management (ETRM) Trade Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `execution_venue` SET TAGS ('dbx_business_glossary_term' = 'Execution Venue');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standards Codification (ASC) 815 Hedge Designation');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `hedge_program_reference` SET TAGS ('dbx_business_glossary_term' = 'Hedge Program Reference');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'spot|forward|future|swap|option|ppa');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `mark_to_market_value` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Value');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|bilateral|forward');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `master_agreement_reference` SET TAGS ('dbx_business_glossary_term' = 'Master Agreement Reference');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `mtm_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `novation_flag` SET TAGS ('dbx_business_glossary_term' = 'Novation Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `original_trade_reference` SET TAGS ('dbx_business_glossary_term' = 'Original Trade Reference');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Trade Price');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `price_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Unit');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `price_unit` SET TAGS ('dbx_value_regex' = 'usd_per_mwh|usd_per_mw_day|usd_per_mmbtu|usd_per_mcf|usd_per_certificate');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Required Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `rto_iso_market` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) Market');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|settled|failed');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `trade_date` SET TAGS ('dbx_business_glossary_term' = 'Trade Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `trade_status` SET TAGS ('dbx_business_glossary_term' = 'Trade Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `trade_status` SET TAGS ('dbx_value_regex' = 'active|completed|cancelled|terminated');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `trade_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Trade Execution Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `trade_type` SET TAGS ('dbx_business_glossary_term' = 'Trade Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `trade_type` SET TAGS ('dbx_value_regex' = 'physical|financial|exchange|virtual');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `transmission_service_type` SET TAGS ('dbx_business_glossary_term' = 'Transmission Service Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `transmission_service_type` SET TAGS ('dbx_value_regex' = 'firm|non_firm|network|point_to_point|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `unrealized_gain_loss` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `volume_quantity` SET TAGS ('dbx_business_glossary_term' = 'Volume Quantity');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'mwh|mw|mcf|mmbtu|therm|rec_certificate');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `trade_leg_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Leg Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `metering_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `ancillary_services_included_flag` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Included Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `buy_sell_indicator` SET TAGS ('dbx_business_glossary_term' = 'Buy/Sell Indicator');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `buy_sell_indicator` SET TAGS ('dbx_value_regex' = 'buy|sell');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `collateral_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Collateral Required Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'electricity|natural_gas|renewable_energy_certificate|capacity|ancillary_services|emissions_allowance');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'unconfirmed|confirmed|disputed|amended');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `contract_price` SET TAGS ('dbx_business_glossary_term' = 'Contract Price');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `contract_quantity` SET TAGS ('dbx_business_glossary_term' = 'Contract Quantity');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `credit_exposure` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `delivery_end_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery End Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `delivery_point_name` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `delivery_start_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Start Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'cash_flow_hedge|fair_value_hedge|economic_hedge|speculative');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `leg_sequence_number` SET TAGS ('dbx_business_glossary_term' = 'Leg Sequence Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `leg_status` SET TAGS ('dbx_business_glossary_term' = 'Leg Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `leg_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|scheduled|delivered|settled|cancelled');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `leg_type` SET TAGS ('dbx_business_glossary_term' = 'Leg Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `leg_type` SET TAGS ('dbx_value_regex' = 'delivery|settlement|option|swap|basis');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `mark_to_market_value` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Value');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|bilateral|forward|futures');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `mtm_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Leg Notes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_value_regex' = 'USD_per_MWh|USD_per_MW_day|USD_per_MMBtu|USD_per_REC|USD_per_ton');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `pricing_formula` SET TAGS ('dbx_business_glossary_term' = 'Pricing Formula');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `pricing_index` SET TAGS ('dbx_business_glossary_term' = 'Pricing Index');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_value_regex' = 'MWh|MW|MMBtu|Dth|REC|ton_CO2');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `renewable_attribute_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Attribute Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `rto_iso_market` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Market');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `scheduled_quantity` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Quantity');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `scheduling_status` SET TAGS ('dbx_value_regex' = 'not_scheduled|scheduled|nominated|curtailed|adjusted');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `settlement_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `source_system_leg_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Leg Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `trade_execution_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Trade Execution Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`trade_leg` ALTER COLUMN `transmission_rights_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Transmission Rights Required Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` SET TAGS ('dbx_subdomain' = 'portfolio_analytics');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Portfolio ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `vpp_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'Vpp Agreement Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `board_approval_resolution_number` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Resolution Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Closure Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `commodity_scope` SET TAGS ('dbx_business_glossary_term' = 'Commodity Scope');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `commodity_scope` SET TAGS ('dbx_value_regex' = 'power|gas|coal|fuel_oil|renewable|multi_commodity');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `credit_exposure_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Limit (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `credit_exposure_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `current_credit_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Current Credit Utilization (Percent)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `current_position_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Current Position Utilization (Percent)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `current_var_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Current Value at Risk (VaR) Utilization (Percent)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `etrm_system_book_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Trading and Risk Management (ETRM) System Book ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `hedge_accounting_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Accounting Designation');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `hedge_accounting_designation` SET TAGS ('dbx_value_regex' = 'cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `hedge_effectiveness_test_method` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Test Method');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `hedge_effectiveness_test_method` SET TAGS ('dbx_value_regex' = 'dollar_offset|regression|var_reduction|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Inception Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `last_limit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Limit Review Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `limit_breach_action` SET TAGS ('dbx_business_glossary_term' = 'Limit Breach Action');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `limit_breach_action` SET TAGS ('dbx_value_regex' = 'alert|block|escalate|auto_liquidate');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `mark_to_market_methodology` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Methodology');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `mark_to_market_methodology` SET TAGS ('dbx_value_regex' = 'forward_curve|lmp_based|broker_quote|model_derived|cost_basis');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `next_limit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Limit Review Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Notes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `open_position_limit_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Open Position Limit (MMBtu)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `open_position_limit_mmbtu` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `open_position_limit_mwh` SET TAGS ('dbx_business_glossary_term' = 'Open Position Limit (MWh)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `open_position_limit_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `pnl_attribution_method` SET TAGS ('dbx_business_glossary_term' = 'Profit and Loss (P&L) Attribution Method');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `pnl_attribution_method` SET TAGS ('dbx_value_regex' = 'trade_level|portfolio_level|blended');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `portfolio_code` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `portfolio_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `portfolio_name` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `portfolio_status` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `portfolio_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_approval');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `portfolio_type` SET TAGS ('dbx_value_regex' = 'generation_hedge|load_hedge|proprietary|ancillary|fuel|renewable');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'merchant|utility|hybrid');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `rto_iso_market` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Market');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `stop_loss_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Stop-Loss Limit (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `stop_loss_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `tenor_limit_months` SET TAGS ('dbx_business_glossary_term' = 'Tenor Limit (Months)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `trading_desk` SET TAGS ('dbx_business_glossary_term' = 'Trading Desk');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `var_confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Confidence Level (Percent)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `var_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Limit (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `var_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`portfolio` ALTER COLUMN `var_time_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Time Horizon (Days)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` SET TAGS ('dbx_subdomain' = 'portfolio_analytics');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `position_id` SET TAGS ('dbx_business_glossary_term' = 'Position Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Der Resource Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `rps_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Rps Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `average_long_price` SET TAGS ('dbx_business_glossary_term' = 'Average Long Price');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `average_net_price` SET TAGS ('dbx_business_glossary_term' = 'Average Net Price');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `average_short_price` SET TAGS ('dbx_business_glossary_term' = 'Average Short Price');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `capacity_obligation_mw` SET TAGS ('dbx_business_glossary_term' = 'Capacity Obligation (MW)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `change_value` SET TAGS ('dbx_business_glossary_term' = 'Position Change Value');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `change_volume` SET TAGS ('dbx_business_glossary_term' = 'Position Change Volume');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'power|natural_gas|capacity|rec|ancillary_services');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `counterparty_exposure` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Exposure');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `delivery_period_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period End Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `delivery_period_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `delta_equivalent` SET TAGS ('dbx_business_glossary_term' = 'Delta Equivalent');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'cash_flow_hedge|fair_value_hedge|net_investment_hedge|undesignated');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `hedge_effectiveness_percent` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Percentage');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `long_volume` SET TAGS ('dbx_business_glossary_term' = 'Long Volume');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `mark_to_market_value` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Value');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `market_price` SET TAGS ('dbx_business_glossary_term' = 'Market Price');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Market Segment');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|bilateral|futures|options');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `net_volume` SET TAGS ('dbx_business_glossary_term' = 'Net Volume');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Position Notes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `position_source` SET TAGS ('dbx_business_glossary_term' = 'Position Source');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `position_source` SET TAGS ('dbx_value_regex' = 'physical|financial|net');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_business_glossary_term' = 'Position Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `position_status` SET TAGS ('dbx_value_regex' = 'open|closed|expired|settled');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `rec_inventory_balance` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Inventory Balance');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `rec_vintage_year` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Vintage Year');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `rps_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'pending|partial|complete|disputed');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `short_volume` SET TAGS ('dbx_business_glossary_term' = 'Short Volume');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `trading_book` SET TAGS ('dbx_business_glossary_term' = 'Trading Book');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `unrealized_pnl` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Profit and Loss (P&L)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `var_95` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) 95% Confidence');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`position` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'MWh|MCF|MW|REC|MMBTU');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` SET TAGS ('dbx_subdomain' = 'portfolio_analytics');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Ppa Contract Identifier');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Business Entity Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner Employee ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Node ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `generating_unit_id` SET TAGS ('dbx_business_glossary_term' = 'Generating Unit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `metering_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Der Resource Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `capacity_payment_per_mw_month` SET TAGS ('dbx_business_glossary_term' = 'Capacity Payment Per Megawatt (MW) Month');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `capacity_payment_per_mw_month` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `collateral_requirement_usd` SET TAGS ('dbx_business_glossary_term' = 'Collateral Requirement United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `collateral_requirement_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Contract Amendment Count');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_name` SET TAGS ('dbx_business_glossary_term' = 'PPA Contract Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'PPA Contract Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_value_regex' = '^PPA-[A-Z0-9]{8,12}$');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'PPA Contract Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_value_regex' = 'draft|pending_approval|active|suspended|terminated|expired');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_term_end_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Term End Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_term_start_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Start Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_term_years` SET TAGS ('dbx_business_glossary_term' = 'Contract Term Years');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'PPA Contract Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'bilateral|tolling|unit_contingent|baseload|peaking|renewable');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Contract Value United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contract_value_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contracted_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Contracted Capacity Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `contracted_energy_mwh_annual` SET TAGS ('dbx_business_glossary_term' = 'Contracted Energy Megawatt-Hours (MWh) Annual');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `credit_rating_requirement` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Requirement');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `curtailment_compensation_terms` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Compensation Terms');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `curtailment_compensation_terms` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `curtailment_compensation_terms` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `curtailment_provision_flag` SET TAGS ('dbx_business_glossary_term' = 'Curtailment Provision Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `ferc_filing_reference` SET TAGS ('dbx_business_glossary_term' = 'Federal Energy Regulatory Commission (FERC) Filing Reference');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `fixed_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Fixed Price Per Megawatt-Hour (MWh)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `fixed_price_per_mwh` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `force_majeure_terms` SET TAGS ('dbx_business_glossary_term' = 'Force Majeure Terms');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `payment_terms_days` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Days');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `price_escalation_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Rate Percent');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `price_escalation_rate_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `price_index_reference` SET TAGS ('dbx_business_glossary_term' = 'Price Index Reference');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `pricing_structure` SET TAGS ('dbx_business_glossary_term' = 'Pricing Structure');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `pricing_structure` SET TAGS ('dbx_value_regex' = 'fixed|indexed|tolling|hybrid|capacity_energy');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `rec_inclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Inclusion Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `rec_transfer_mechanism` SET TAGS ('dbx_business_glossary_term' = 'REC Transfer Mechanism');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `rec_transfer_mechanism` SET TAGS ('dbx_value_regex' = 'bundled|unbundled|retained_by_seller');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `renewable_portfolio_standard_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Portfolio Standard (RPS) Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Frequency');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `settlement_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ppa_contract` ALTER COLUMN `termination_provisions` SET TAGS ('dbx_business_glossary_term' = 'Termination Provisions');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `market_bid_id` SET TAGS ('dbx_business_glossary_term' = 'Market Bid Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `application_id` SET TAGS ('dbx_business_glossary_term' = 'Application Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Node Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Portfolio Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Der Resource Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Trader Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `acceptance_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `bid_curve_segment_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Curve Segment Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `bid_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Bid Price per Megawatt-Hour (MWh)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `bid_quantity_mw` SET TAGS ('dbx_business_glossary_term' = 'Bid Quantity in Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `bid_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Bid Reference Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `bid_reference_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `bid_status` SET TAGS ('dbx_business_glossary_term' = 'Bid Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `bid_status` SET TAGS ('dbx_value_regex' = 'submitted|accepted|rejected|partially_cleared|withdrawn|expired');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `bid_type` SET TAGS ('dbx_business_glossary_term' = 'Bid Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `block_bid_flag` SET TAGS ('dbx_business_glossary_term' = 'Block Bid Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `cleared_price_per_mwh` SET TAGS ('dbx_business_glossary_term' = 'Cleared Price per Megawatt-Hour (MWh)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `cleared_quantity_mw` SET TAGS ('dbx_business_glossary_term' = 'Cleared Quantity in Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `congestion_component` SET TAGS ('dbx_business_glossary_term' = 'Congestion Component of Locational Marginal Price (LMP)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `energy_component` SET TAGS ('dbx_business_glossary_term' = 'Energy Component of Locational Marginal Price (LMP)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'physical_hedge|financial_hedge|speculative|none');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `loss_component` SET TAGS ('dbx_business_glossary_term' = 'Loss Component of Locational Marginal Price (LMP)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `maximum_quantity_mw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity in Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `minimum_down_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Down Time in Hours');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `minimum_quantity_mw` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity in Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `minimum_run_time_hours` SET TAGS ('dbx_business_glossary_term' = 'Minimum Run Time in Hours');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `no_load_cost` SET TAGS ('dbx_business_glossary_term' = 'No-Load Cost');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `operating_day` SET TAGS ('dbx_business_glossary_term' = 'Operating Day');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `price_taker_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Taker Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `ramp_rate_mw_per_minute` SET TAGS ('dbx_business_glossary_term' = 'Ramp Rate in Megawatts (MW) per Minute');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `self_schedule_flag` SET TAGS ('dbx_business_glossary_term' = 'Self-Schedule Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `start_up_cost` SET TAGS ('dbx_business_glossary_term' = 'Start-Up Cost');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `submission_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Submission Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `trading_hour` SET TAGS ('dbx_business_glossary_term' = 'Trading Hour');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `trading_interval` SET TAGS ('dbx_business_glossary_term' = 'Trading Interval');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market_bid` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` SET TAGS ('dbx_subdomain' = 'portfolio_analytics');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `lmp_price_id` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Price ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'power|capacity|ancillary_services|ftr|rec|natural_gas');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `confidence_interval_lower` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Lower Bound ($/MWh)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `confidence_interval_upper` SET TAGS ('dbx_business_glossary_term' = 'Confidence Interval Upper Bound ($/MWh)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `congestion_component` SET TAGS ('dbx_business_glossary_term' = 'Congestion Component ($/MWh)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `curve_date` SET TAGS ('dbx_business_glossary_term' = 'Forward Curve Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `curve_source` SET TAGS ('dbx_business_glossary_term' = 'Curve Source');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `curve_source` SET TAGS ('dbx_value_regex' = 'ice|cme|broker|internal|iso_published|third_party');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `delivery_hub` SET TAGS ('dbx_business_glossary_term' = 'Delivery Hub');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `energy_component` SET TAGS ('dbx_business_glossary_term' = 'Energy Component ($/MWh)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `forward_price` SET TAGS ('dbx_business_glossary_term' = 'Forward Price ($/MWh)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Data Ingestion Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `is_active` SET TAGS ('dbx_business_glossary_term' = 'Active Record Indicator');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `lmp_total` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Total');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `loss_component` SET TAGS ('dbx_business_glossary_term' = 'Loss Component ($/MWh)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `market_interval_end` SET TAGS ('dbx_business_glossary_term' = 'Market Interval End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `market_interval_start` SET TAGS ('dbx_business_glossary_term' = 'Market Interval Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|hour_ahead|ancillary_services');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `negative_price_indicator` SET TAGS ('dbx_business_glossary_term' = 'Negative Price Indicator');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `node_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `node_type` SET TAGS ('dbx_value_regex' = 'generator_bus|load_zone|hub|interface|trading_hub|aggregate_zone');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `operating_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `operating_hour` SET TAGS ('dbx_business_glossary_term' = 'Operating Hour');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `price_quality_flag` SET TAGS ('dbx_business_glossary_term' = 'Price Quality Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `price_quality_flag` SET TAGS ('dbx_value_regex' = 'valid|estimated|missing|anomaly|corrected');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `price_spike_indicator` SET TAGS ('dbx_business_glossary_term' = 'Price Spike Indicator');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `price_type` SET TAGS ('dbx_business_glossary_term' = 'Price Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `price_type` SET TAGS ('dbx_value_regex' = 'spot|forward|forecast|settlement');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `pricing_zone` SET TAGS ('dbx_business_glossary_term' = 'Pricing Zone');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publication Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `settlement_run_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Run Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|resettlement|disputed');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `tenor` SET TAGS ('dbx_business_glossary_term' = 'Forward Curve Tenor');
ALTER TABLE `power_and_utilities_v2`.`trading`.`lmp_price` ALTER COLUMN `voltage_level_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Level (kV)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `settlement_id` SET TAGS ('dbx_business_glossary_term' = 'Settlement ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `dr_event_participation_id` SET TAGS ('dbx_business_glossary_term' = 'Dr Event Participation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Portfolio ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `ppa_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `trade_id` SET TAGS ('dbx_business_glossary_term' = 'Trade ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `transmission_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `ancillary_services_charge` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Services Charge');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `collateral_applied` SET TAGS ('dbx_business_glossary_term' = 'Collateral Applied');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `commodity` SET TAGS ('dbx_value_regex' = 'electricity|natural_gas|rec|capacity|ancillary_services|transmission_rights');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `congestion_charge` SET TAGS ('dbx_business_glossary_term' = 'Congestion Charge');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^CC-[A-Z0-9]{4,8}$');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `currency` SET TAGS ('dbx_business_glossary_term' = 'Settlement Currency');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `dispute_flag` SET TAGS ('dbx_business_glossary_term' = 'Dispute Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `etrm_system_deal_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Trading and Risk Management (ETRM) System Deal ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_value_regex' = '^[0-9]{4,10}$');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `gross_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Settlement Amount');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'cash_flow_hedge|fair_value_hedge|economic_hedge|not_designated');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `imbalance_charge` SET TAGS ('dbx_business_glossary_term' = 'Imbalance Charge');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `loss_charge` SET TAGS ('dbx_business_glossary_term' = 'Loss Charge');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `net_settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Settlement Amount');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `netting_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Netting Adjustment');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Settlement Notes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `payment_direction` SET TAGS ('dbx_business_glossary_term' = 'Payment Direction');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `payment_direction` SET TAGS ('dbx_value_regex' = 'payable|receivable');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|scheduled|paid|received|overdue|defaulted');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `period_end` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period End');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `period_start` SET TAGS ('dbx_business_glossary_term' = 'Settlement Period Start');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `price` SET TAGS ('dbx_business_glossary_term' = 'Settlement Price');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_value_regex' = 'USD_per_MWh|USD_per_MMBtu|USD_per_REC|USD_per_MW_day');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_value_regex' = '^PC-[A-Z0-9]{4,8}$');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `rto_iso_market` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Market');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `run_reference` SET TAGS ('dbx_business_glossary_term' = 'Settlement Run ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `run_reference` SET TAGS ('dbx_value_regex' = '^SR-[0-9]{8}-[0-9]{4}$');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `scheduling_charge` SET TAGS ('dbx_business_glossary_term' = 'Scheduling Charge');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `settled_volume` SET TAGS ('dbx_business_glossary_term' = 'Settled Volume');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `settlement_number` SET TAGS ('dbx_value_regex' = '^STL-[0-9]{8}-[A-Z0-9]{6}$');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_business_glossary_term' = 'Settlement Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `settlement_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|disputed|adjusted|voided|paid');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `settlement_type` SET TAGS ('dbx_business_glossary_term' = 'Settlement Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `transmission_charge` SET TAGS ('dbx_business_glossary_term' = 'Transmission Charge');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'Settlement Version');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`trading`.`settlement` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'MWh|kWh|MMBtu|Dth|REC|MW');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `mtm_valuation_id` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Valuation ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Portfolio ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'power|natural_gas|coal|renewable_energy_certificate|capacity|ancillary_services');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `contract_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Contract Price Per Unit');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'physical|financial|swap|option|futures');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `deal_number` SET TAGS ('dbx_business_glossary_term' = 'Deal Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `delivery_period_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period End Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `delivery_period_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `delivery_point` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `etrm_book_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Trading and Risk Management (ETRM) Book ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_business_glossary_term' = 'Fair Value Hierarchy Level');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `fair_value_hierarchy_level` SET TAGS ('dbx_value_regex' = 'level_1|level_2|level_3');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `forward_curve_source` SET TAGS ('dbx_business_glossary_term' = 'Forward Curve Source');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `forward_price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Forward Price Per Unit');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Hedge Designation');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `hedge_designation` SET TAGS ('dbx_value_regex' = 'cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `lmp_node` SET TAGS ('dbx_business_glossary_term' = 'Locational Marginal Price (LMP) Node');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `mtm_total_value_usd` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Total Value United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `mtm_value_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Mark-to-Market (MTM) Value Per Unit');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `open_volume_mmbtu` SET TAGS ('dbx_business_glossary_term' = 'Open Volume Million British Thermal Units (MMBtu)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `open_volume_mwh` SET TAGS ('dbx_business_glossary_term' = 'Open Volume Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `position_type` SET TAGS ('dbx_business_glossary_term' = 'Position Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `position_type` SET TAGS ('dbx_value_regex' = 'long|short');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `price_volatility_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Volatility Percent');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `risk_category` SET TAGS ('dbx_business_glossary_term' = 'Risk Category');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `risk_category` SET TAGS ('dbx_value_regex' = 'market_risk|credit_risk|operational_risk|basis_risk|volumetric_risk');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `rto_iso_market` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Market');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `settlement_method` SET TAGS ('dbx_business_glossary_term' = 'Settlement Method');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `settlement_method` SET TAGS ('dbx_value_regex' = 'physical|financial|cash');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `tenor_months` SET TAGS ('dbx_business_glossary_term' = 'Tenor Months');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `unrealized_gain_loss_usd` SET TAGS ('dbx_business_glossary_term' = 'Unrealized Gain or Loss United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `valuation_adjustment_reason` SET TAGS ('dbx_business_glossary_term' = 'Valuation Adjustment Reason');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `valuation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Valuation Methodology');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `valuation_methodology` SET TAGS ('dbx_value_regex' = 'forward_curve|model_based|broker_quote|exchange_settlement|internal_estimate');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `valuation_run_reference` SET TAGS ('dbx_business_glossary_term' = 'Valuation Run ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_business_glossary_term' = 'Valuation Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `valuation_status` SET TAGS ('dbx_value_regex' = 'preliminary|final|adjusted|cancelled');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `valuation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Valuation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`mtm_valuation` ALTER COLUMN `var_contribution_usd` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Contribution United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `risk_limit_id` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Portfolio Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `approval_authority` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Approval Authority');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `approval_authority` SET TAGS ('dbx_value_regex' = 'board|cro|cfo|risk_committee|desk_head|trading_director');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Approval Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `approval_resolution_number` SET TAGS ('dbx_business_glossary_term' = 'Approval Resolution Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `breach_action` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Breach Action');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `breach_action` SET TAGS ('dbx_value_regex' = 'alert|block|escalate|auto_hedge|manual_review');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `breach_count` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Breach Count');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Confidence Level Percentage');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `counterparty_credit_rating_threshold` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Credit Rating Threshold');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `current_exposure_value` SET TAGS ('dbx_business_glossary_term' = 'Current Exposure Value');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `current_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Current Risk Limit Utilization Percentage');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Effective Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `etrm_system_limit_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Trading and Risk Management (ETRM) System Limit ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Expiry Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `last_breach_date` SET TAGS ('dbx_business_glossary_term' = 'Last Risk Limit Breach Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `last_breach_value` SET TAGS ('dbx_business_glossary_term' = 'Last Breach Exposure Value');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Risk Limit Review Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `limit_code` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `limit_currency` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Currency Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `limit_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `limit_name` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `limit_scope` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Scope');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `limit_type` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `limit_unit` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `limit_value` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Value');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `market_segment` SET TAGS ('dbx_business_glossary_term' = 'Energy Market Segment');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `market_segment` SET TAGS ('dbx_value_regex' = 'dam|rtm|bilateral|financial|physical|ancillary_services');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Monitoring Frequency');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'real_time|intraday|daily|weekly|monthly');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `next_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Scheduled Risk Limit Review Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Notes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `profit_center_code` SET TAGS ('dbx_business_glossary_term' = 'Profit Center Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `regulatory_mandate_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Mandate Reference');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `review_frequency` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Review Frequency');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `review_frequency` SET TAGS ('dbx_value_regex' = 'quarterly|semi_annual|annual|ad_hoc');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `risk_limit_status` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `risk_limit_status` SET TAGS ('dbx_value_regex' = 'active|suspended|expired|pending_approval|superseded');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `rto_iso_market` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) or Independent System Operator (ISO) Market');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `scope_identifier` SET TAGS ('dbx_business_glossary_term' = 'Scope Identifier');
ALTER TABLE `power_and_utilities_v2`.`trading`.`risk_limit` ALTER COLUMN `time_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Risk Limit Time Horizon in Days');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `hedge_program_id` SET TAGS ('dbx_business_glossary_term' = 'Hedge Program Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Portfolio Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `profit_center_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `approved_volume_max` SET TAGS ('dbx_business_glossary_term' = 'Approved Maximum Volume');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `approved_volume_min` SET TAGS ('dbx_business_glossary_term' = 'Approved Minimum Volume');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `asc_815_hedge_designation` SET TAGS ('dbx_business_glossary_term' = 'Accounting Standards Codification (ASC) 815 Hedge Designation');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `asc_815_hedge_designation` SET TAGS ('dbx_value_regex' = 'cash_flow_hedge|fair_value_hedge|net_investment_hedge|not_designated');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `board_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `board_approval_resolution_number` SET TAGS ('dbx_business_glossary_term' = 'Board Approval Resolution Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `business_unit` SET TAGS ('dbx_business_glossary_term' = 'Business Unit');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `closure_date` SET TAGS ('dbx_business_glossary_term' = 'Hedge Program Closure Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `closure_reason` SET TAGS ('dbx_business_glossary_term' = 'Closure Reason');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `commodity` SET TAGS ('dbx_value_regex' = 'electricity|natural_gas|coal|uranium|renewable_energy_certificate|emissions_allowance');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `cost_recovery_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Cost Recovery Eligible Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `credit_exposure_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure Limit in United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `effectiveness_test_frequency` SET TAGS ('dbx_business_glossary_term' = 'Effectiveness Test Frequency');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `effectiveness_test_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|at_inception_only');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `etrm_system_book_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Trading and Risk Management (ETRM) System Book Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `hedge_effectiveness_test_method` SET TAGS ('dbx_business_glossary_term' = 'Hedge Effectiveness Test Method');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `hedge_effectiveness_test_method` SET TAGS ('dbx_value_regex' = 'dollar_offset|regression_analysis|variance_reduction|critical_terms_match');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `hedge_horizon_months` SET TAGS ('dbx_business_glossary_term' = 'Hedge Horizon in Months');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `hedge_ratio_target_percent` SET TAGS ('dbx_business_glossary_term' = 'Hedge Ratio Target Percentage');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `hedge_type` SET TAGS ('dbx_business_glossary_term' = 'Hedge Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `hedge_type` SET TAGS ('dbx_value_regex' = 'generation_output_hedge|fuel_cost_hedge|load_hedge|basis_hedge|volumetric_hedge|price_hedge');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `inception_date` SET TAGS ('dbx_business_glossary_term' = 'Hedge Program Inception Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `instrument_types_allowed` SET TAGS ('dbx_business_glossary_term' = 'Allowed Instrument Types');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `last_limit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Limit Review Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `limit_breach_action` SET TAGS ('dbx_business_glossary_term' = 'Limit Breach Action');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `next_limit_review_date` SET TAGS ('dbx_business_glossary_term' = 'Next Limit Review Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Hedge Program Notes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `program_code` SET TAGS ('dbx_business_glossary_term' = 'Hedge Program Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `program_name` SET TAGS ('dbx_business_glossary_term' = 'Hedge Program Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `program_status` SET TAGS ('dbx_business_glossary_term' = 'Hedge Program Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `program_status` SET TAGS ('dbx_value_regex' = 'active|suspended|closed|pending_approval');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Classification');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `regulatory_classification` SET TAGS ('dbx_value_regex' = 'utility_hedging|merchant_trading|speculative|proprietary');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `responsible_trader_name` SET TAGS ('dbx_business_glossary_term' = 'Responsible Trader Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `rto_iso_market` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Market');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `stop_loss_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Stop Loss Limit in United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `tenor_limit_months` SET TAGS ('dbx_business_glossary_term' = 'Tenor Limit in Months');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `trading_desk` SET TAGS ('dbx_business_glossary_term' = 'Trading Desk');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `var_confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Confidence Level Percentage');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `var_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Limit in United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `var_time_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Value at Risk (VaR) Time Horizon in Days');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`trading`.`hedge_program` ALTER COLUMN `volume_unit_of_measure` SET TAGS ('dbx_value_regex' = 'MWh|MMBtu|tons|GJ|therms');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` SET TAGS ('dbx_subdomain' = 'portfolio_analytics');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `rec_transaction_id` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Certificate (REC) Transaction ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `dsm_program_id` SET TAGS ('dbx_business_glossary_term' = 'Dsm Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Facility Identifier');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Portfolio Identifier');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `rec_certificate_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Rec Certificate Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `rec_inventory_id` SET TAGS ('dbx_business_glossary_term' = 'Rec Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `broker_name` SET TAGS ('dbx_business_glossary_term' = 'Broker Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `compliance_program` SET TAGS ('dbx_business_glossary_term' = 'Compliance Program');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `compliance_year` SET TAGS ('dbx_business_glossary_term' = 'Compliance Year');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `confirmation_date` SET TAGS ('dbx_business_glossary_term' = 'Transaction Confirmation Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `confirmation_number` SET TAGS ('dbx_business_glossary_term' = 'Transaction Confirmation Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `delivery_method` SET TAGS ('dbx_business_glossary_term' = 'REC Delivery Method');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `delivery_method` SET TAGS ('dbx_value_regex' = 'registry_transfer|physical_certificate|electronic_transfer');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `eligibility_flags` SET TAGS ('dbx_business_glossary_term' = 'REC Eligibility Flags');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `etrm_system_deal_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Trading and Risk Management (ETRM) System Deal ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `facility_state` SET TAGS ('dbx_business_glossary_term' = 'Facility State Location');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `green_e_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Green-e Certified Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Transaction Notes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'pending|paid|overdue|disputed|waived');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `price_per_rec` SET TAGS ('dbx_business_glossary_term' = 'Price Per REC');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `quantity_mwh` SET TAGS ('dbx_business_glossary_term' = 'REC Quantity Megawatt-Hours (MWh)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `registry_system` SET TAGS ('dbx_business_glossary_term' = 'REC Registry System');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `retirement_account` SET TAGS ('dbx_business_glossary_term' = 'Retirement Account');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'REC Retirement Reason');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'REC Settlement Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `technology_type` SET TAGS ('dbx_business_glossary_term' = 'Renewable Technology Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `technology_type` SET TAGS ('dbx_value_regex' = 'solar|wind|hydro|biomass|geothermal|landfill_gas');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `total_transaction_value` SET TAGS ('dbx_business_glossary_term' = 'Total REC Transaction Value');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `trader_name` SET TAGS ('dbx_business_glossary_term' = 'Trader Name');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_business_glossary_term' = 'Transaction Currency Code');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `transaction_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `transaction_date` SET TAGS ('dbx_business_glossary_term' = 'REC Transaction Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `transaction_number` SET TAGS ('dbx_business_glossary_term' = 'REC Transaction Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_business_glossary_term' = 'REC Transaction Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `transaction_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|settled|cancelled|failed|reversed');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_business_glossary_term' = 'REC Transaction Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `transaction_type` SET TAGS ('dbx_value_regex' = 'purchase|sale|retirement|transfer|issuance|cancellation');
ALTER TABLE `power_and_utilities_v2`.`trading`.`rec_transaction` ALTER COLUMN `vintage_year` SET TAGS ('dbx_business_glossary_term' = 'REC Vintage Year');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` SET TAGS ('dbx_subdomain' = 'trade_operations');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `ancillary_award_id` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Award Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Resource Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Portfolio Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Product Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `line_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Line Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `actual_delivery_mw` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery in Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `award_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Award Amount in United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `award_number` SET TAGS ('dbx_business_glossary_term' = 'Award Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'awarded|confirmed|deployed|settled|cancelled|expired');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `award_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Award Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `awarded_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Awarded Capacity in Megawatts (MW)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `clearing_price_per_mw` SET TAGS ('dbx_business_glossary_term' = 'Clearing Price per Megawatt (MW)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `confirmation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `deployment_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Deployment Duration in Minutes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `deployment_flag` SET TAGS ('dbx_business_glossary_term' = 'Deployment Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `energy_payment_usd` SET TAGS ('dbx_business_glossary_term' = 'Energy Payment in United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `etrm_deal_number` SET TAGS ('dbx_business_glossary_term' = 'Energy Trading and Risk Management (ETRM) Deal Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `ingestion_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Ingestion Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `interval_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Interval Duration in Minutes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `market_interval_end` SET TAGS ('dbx_business_glossary_term' = 'Market Interval End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `market_interval_start` SET TAGS ('dbx_business_glossary_term' = 'Market Interval Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `market_type` SET TAGS ('dbx_business_glossary_term' = 'Market Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `market_type` SET TAGS ('dbx_value_regex' = 'day_ahead|real_time|supplemental');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `obligation_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Obligation End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `obligation_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Obligation Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `operating_date` SET TAGS ('dbx_business_glossary_term' = 'Operating Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `operating_hour` SET TAGS ('dbx_business_glossary_term' = 'Operating Hour');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `performance_score` SET TAGS ('dbx_business_glossary_term' = 'Performance Score Percentage');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `pricing_zone` SET TAGS ('dbx_business_glossary_term' = 'Pricing Zone');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `publication_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Publication Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `resource_type` SET TAGS ('dbx_business_glossary_term' = 'Resource Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `rto_iso_market` SET TAGS ('dbx_business_glossary_term' = 'Regional Transmission Organization (RTO) / Independent System Operator (ISO) Market');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Category');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `service_category` SET TAGS ('dbx_value_regex' = 'frequency_regulation|contingency_reserve|voltage_control|black_start');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Ancillary Service Type');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `settlement_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount in United States Dollars (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`ancillary_award` ALTER COLUMN `settlement_run_number` SET TAGS ('dbx_business_glossary_term' = 'Settlement Run Number');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` SET TAGS ('dbx_subdomain' = 'risk_governance');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_exposure_id` SET TAGS ('dbx_business_glossary_term' = 'Credit Exposure ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `portfolio_id` SET TAGS ('dbx_business_glossary_term' = 'Trading Portfolio ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `approved_credit_limit_usd` SET TAGS ('dbx_business_glossary_term' = 'Approved Credit Limit (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `approved_credit_limit_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `breach_amount_usd` SET TAGS ('dbx_business_glossary_term' = 'Breach Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `breach_amount_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `collateral_posted_usd` SET TAGS ('dbx_business_glossary_term' = 'Collateral Posted (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `collateral_posted_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `collateral_received_usd` SET TAGS ('dbx_business_glossary_term' = 'Collateral Received (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `collateral_received_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `collateral_type_posted` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type Posted');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `collateral_type_posted` SET TAGS ('dbx_value_regex' = 'Cash|Letter of Credit|Parent Guarantee|Surety Bond|Securities|None');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `collateral_type_received` SET TAGS ('dbx_business_glossary_term' = 'Collateral Type Received');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `collateral_type_received` SET TAGS ('dbx_value_regex' = 'Cash|Letter of Credit|Parent Guarantee|Surety Bond|Securities|None');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `commodity_concentration_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Commodity Concentration Risk Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_rating` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Agency');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_rating_agency` SET TAGS ('dbx_value_regex' = 'S&P|Moodys|Fitch|Internal|Not Rated');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_rating_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Rating Effective Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_status` SET TAGS ('dbx_business_glossary_term' = 'Credit Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_status` SET TAGS ('dbx_value_regex' = 'Normal|Watch|Restricted|Suspended|Default');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_status_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Credit Status Effective Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Credit Status Reason');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_utilization_percent` SET TAGS ('dbx_business_glossary_term' = 'Credit Utilization Percent');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_utilization_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_valuation_adjustment_usd` SET TAGS ('dbx_business_glossary_term' = 'Credit Valuation Adjustment (CVA) (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `credit_valuation_adjustment_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `current_exposure_usd` SET TAGS ('dbx_business_glossary_term' = 'Current Exposure (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `current_exposure_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `days_to_margin_call` SET TAGS ('dbx_business_glossary_term' = 'Days to Margin Call');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `etrm_system_exposure_reference` SET TAGS ('dbx_business_glossary_term' = 'Energy Trading and Risk Management (ETRM) System Exposure ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `expected_credit_loss_usd` SET TAGS ('dbx_business_glossary_term' = 'Expected Credit Loss (ECL) (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `expected_credit_loss_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `exposure_at_default_usd` SET TAGS ('dbx_business_glossary_term' = 'Exposure at Default (EAD) (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `exposure_at_default_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `exposure_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Exposure Breach Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `exposure_calculation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Exposure Calculation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `exposure_date` SET TAGS ('dbx_business_glossary_term' = 'Exposure Date');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `geographic_concentration_risk_flag` SET TAGS ('dbx_business_glossary_term' = 'Geographic Concentration Risk Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `loss_given_default_percent` SET TAGS ('dbx_business_glossary_term' = 'Loss Given Default (LGD) Percent');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `loss_given_default_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `margin_call_status` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Status');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `margin_call_status` SET TAGS ('dbx_value_regex' = 'No Call Required|Call Issued|Call Pending|Call Satisfied|Call Disputed');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `margin_call_threshold_usd` SET TAGS ('dbx_business_glossary_term' = 'Margin Call Threshold (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `margin_call_threshold_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `net_exposure_usd` SET TAGS ('dbx_business_glossary_term' = 'Net Exposure (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `net_exposure_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `netting_agreement_flag` SET TAGS ('dbx_business_glossary_term' = 'Netting Agreement Flag');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `netting_set_code` SET TAGS ('dbx_business_glossary_term' = 'Netting Set ID');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `pfe_calculation_method` SET TAGS ('dbx_business_glossary_term' = 'Potential Future Exposure (PFE) Calculation Method');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `pfe_calculation_method` SET TAGS ('dbx_value_regex' = 'Monte Carlo|Parametric|Historical Simulation|Standardized Approach|Internal Model');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `pfe_confidence_level_percent` SET TAGS ('dbx_business_glossary_term' = 'Potential Future Exposure (PFE) Confidence Level Percent');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `pfe_time_horizon_days` SET TAGS ('dbx_business_glossary_term' = 'Potential Future Exposure (PFE) Time Horizon Days');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `potential_future_exposure_usd` SET TAGS ('dbx_business_glossary_term' = 'Potential Future Exposure (PFE) (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `potential_future_exposure_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `probability_of_default_percent` SET TAGS ('dbx_business_glossary_term' = 'Probability of Default (PD) Percent');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `probability_of_default_percent` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `regulatory_capital_charge_usd` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Capital Charge (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `regulatory_capital_charge_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `risk_weighted_asset_usd` SET TAGS ('dbx_business_glossary_term' = 'Risk Weighted Asset (RWA) (USD)');
ALTER TABLE `power_and_utilities_v2`.`trading`.`credit_exposure` ALTER COLUMN `risk_weighted_asset_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market` SET TAGS ('dbx_subdomain' = 'portfolio_analytics');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market` ALTER COLUMN `market_id` SET TAGS ('dbx_business_glossary_term' = 'Market Identifier');
ALTER TABLE `power_and_utilities_v2`.`trading`.`market` ALTER COLUMN `parent_market_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`trading`.`pricing_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`trading`.`pricing_node` SET TAGS ('dbx_subdomain' = 'portfolio_analytics');
ALTER TABLE `power_and_utilities_v2`.`trading`.`pricing_node` ALTER COLUMN `pricing_node_id` SET TAGS ('dbx_business_glossary_term' = 'Pricing Node Identifier');
ALTER TABLE `power_and_utilities_v2`.`trading`.`pricing_node` ALTER COLUMN `aggregate_pricing_node_id` SET TAGS ('dbx_self_ref_fk' = 'true');
