-- Schema for Domain: supply | Business: Power and Utilities | Version: v1_mvm
-- Generated on: 2026-04-29 23:12:58

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities`.`supply` COMMENT 'Governs procurement of materials, equipment, fuel, and services for utility operations. Manages vendor/contractor master records, purchase orders, contracts, inventory management, warehousing, and logistics for generation fuel, T&D equipment, and O&M supplies. Integrates with ERP (SAP S/4HANA) for procurement-to-pay and supports CAPEX project material management and storm restoration logistics.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`vendor` (
    `vendor_id` BIGINT COMMENT 'Unique identifier for the vendor record. Primary key.',
    `bank_account_number` STRING COMMENT 'Vendor bank account number for EFT payment processing. Encrypted at rest and in transit per PCI DSS standards.',
    `bank_name` STRING COMMENT 'Name of the financial institution holding the vendors account for Electronic Funds Transfer (EFT) payments.',
    `bank_routing_number` STRING COMMENT 'ABA routing transit number for the vendors bank. Used for ACH and wire transfer payments.',
    `bonding_capacity_usd` DECIMAL(18,2) COMMENT 'Maximum dollar value of performance and payment bonds the vendor can secure from surety. Critical for large CAPEX construction projects (transmission lines, substations, generation plant construction). Expressed in US dollars.',
    `classification` STRING COMMENT 'Primary classification of vendor by service or product category. Material supplier provides T&D equipment and O&M supplies; fuel supplier provides coal, natural gas, or uranium for generation; T&D contractor performs transmission and distribution construction and maintenance; generation services provides plant O&M and outage support; professional services includes engineering, legal, and consulting; IT vendor provides software, hardware, and technology services.. Valid values are `material_supplier|fuel_supplier|td_contractor|generation_services|professional_services|it_vendor`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created in the system. Audit field for data lineage and compliance.',
    `dba_name` STRING COMMENT 'Trade name or doing-business-as name if different from legal name. Used for operational communications and invoice matching.',
    `diversity_classification` STRING COMMENT 'Supplier diversity certification status. Minority Business Enterprise (MBE), Women Business Enterprise (WBE), Small Business Enterprise (SBE), Service-Disabled Veteran-Owned Business (SDVOB), or other diversity designations. Supports regulatory supplier diversity reporting and corporate social responsibility goals. [ENUM-REF-CANDIDATE: mbe|wbe|sbe|sdvob|dbe|lgbtbe|vbe|none — promote to reference product]',
    `duns_number` STRING COMMENT 'Dun & Bradstreet DUNS number for vendor identity verification, credit assessment, and supplier risk management.',
    `insurance_certificate_status` STRING COMMENT 'Status of the vendors certificate of insurance (COI) demonstrating required liability, workers compensation, and other coverage. Current indicates valid coverage on file; expired triggers procurement hold; pending indicates renewal in process.. Valid values are `current|expired|pending|not_required`',
    `insurance_expiration_date` DATE COMMENT 'Expiration date of the vendors current certificate of insurance. Monitored for proactive renewal to avoid procurement disruption.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was most recently updated. Audit field for change tracking and data governance.',
    `last_transaction_date` DATE COMMENT 'Date of the most recent purchase order, invoice, or payment transaction with the vendor. Used to identify inactive vendors for master data cleanup.',
    `legal_name` STRING COMMENT 'Full legal name of the vendor organization as registered with governing authorities. Used for contract execution, tax reporting, and regulatory filings.',
    `modified_by_user` STRING COMMENT 'User ID or system account that last modified the vendor record. Supports audit trail and accountability for master data changes.',
    `notes` STRING COMMENT 'Free-text field for additional vendor information, special handling instructions, performance notes, or procurement restrictions not captured in structured fields.',
    `osha_emr` DECIMAL(18,2) COMMENT 'OSHA Experience Modification Rate (EMR) reflecting the vendors workplace safety record. EMR below 1.0 indicates better-than-average safety performance; above 1.0 indicates higher incident rates. Used for contractor prequalification and risk assessment for T&D and generation services contractors.',
    `payment_method` STRING COMMENT 'Preferred method for remitting payment to the vendor. Electronic Funds Transfer (EFT) and Automated Clearing House (ACH) are standard for recurring payments; wire transfer for large or urgent payments; check for vendors without electronic banking; credit card for small purchases.. Valid values are `eft|ach|wire|check|credit_card`',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor. Net 30/45/60/90 indicates payment due within that number of days from invoice date; 2/10 Net 30 offers 2% discount if paid within 10 days, otherwise net 30.. Valid values are `net_30|net_45|net_60|net_90|due_on_receipt|2_10_net_30`',
    `preferred_currency` STRING COMMENT 'Three-letter ISO 4217 currency code for vendor invoicing and payment (e.g., USD, CAD, EUR). Determines currency for purchase orders and remittance.',
    `prequalification_expiration_date` DATE COMMENT 'Date when the vendors prequalification status expires and must be renewed. Typically annual or biennial review cycle.',
    `prequalification_status` STRING COMMENT 'Indicates whether the vendor has completed and passed the utilitys prequalification process for technical capability, financial stability, safety record, and regulatory compliance. Prequalified vendors are eligible for competitive bidding on major projects.. Valid values are `prequalified|not_prequalified|under_review|expired`',
    `primary_contact_email` STRING COMMENT 'Email address of the primary vendor contact for purchase order acknowledgments, invoice inquiries, and operational coordination.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Full name of the primary business contact at the vendor organization for procurement and operational communications.',
    `primary_contact_phone` STRING COMMENT 'Business phone number of the primary vendor contact.',
    `remittance_address_line1` STRING COMMENT 'Primary street address line for vendor payment remittance. Used for check mailing and correspondence.',
    `remittance_address_line2` STRING COMMENT 'Secondary address line for vendor payment remittance (suite, floor, building).',
    `remittance_city` STRING COMMENT 'City for vendor payment remittance address.',
    `remittance_country` STRING COMMENT 'Three-letter ISO country code for vendor payment remittance address (e.g., USA, CAN, MEX).',
    `remittance_postal_code` STRING COMMENT 'Postal or ZIP code for vendor payment remittance address.',
    `remittance_state` STRING COMMENT 'State or province code for vendor payment remittance address. Two-letter US state code or equivalent.',
    `since_date` DATE COMMENT 'Date the vendor relationship was established and the vendor record was first created in the system. Used for vendor tenure analysis and relationship management.',
    `tax_identifier` STRING COMMENT 'Federal Employer Identification Number (EIN) or Tax Identification Number (TIN) for the vendor. Required for IRS Form 1099 reporting and tax compliance.',
    `vendor_number` STRING COMMENT 'External business identifier for the vendor as recorded in SAP S/4HANA vendor master (LFA1-LIFNR). Used in procurement-to-pay workflows, purchase orders, and invoice processing.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor relationship. Active vendors are approved for procurement; prequalified vendors have passed initial screening but not yet transacted; suspended vendors are temporarily blocked due to performance or compliance issues; disqualified vendors are permanently barred; pending approval vendors are under review.. Valid values are `active|inactive|suspended|prequalified|disqualified|pending_approval`',
    `vendor_type` STRING COMMENT 'Categorization of vendor by transaction type. Goods vendors supply materials and equipment; services vendors provide labor, consulting, or professional services; goods and services vendors provide both.. Valid values are `goods|services|goods_and_services`',
    `w9_on_file` BOOLEAN COMMENT 'Boolean flag indicating whether a current IRS Form W-9 (Request for Taxpayer Identification Number and Certification) is on file for the vendor. Required for 1099 reporting and tax compliance.',
    `website_url` STRING COMMENT 'Public website URL for the vendor organization. Used for vendor research, catalog access, and due diligence.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all vendors, suppliers, and contractors engaged by the utility for procurement of materials, equipment, fuel, and services. Captures vendor identity, classification (material supplier, fuel supplier, T&D contractor, generation services, professional services, IT vendor), tax identifiers (EIN/TIN), remittance addresses, payment terms (Net 30/45/60), preferred currency, bank details for EFT, diversity classification (MBE/WBE/SBE/SDVOB), OSHA safety rating (EMR), insurance certificate status and expiration, bonding capacity, prequalification status, and SAP S/4HANA vendor master number (LFA1). Serves as the SSOT for vendor identity across procurement-to-pay workflows, contractor safety management, and supplier diversity reporting.';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`material_master` (
    `material_master_id` BIGINT COMMENT 'Unique identifier for the material master record. Primary key for the material catalog.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Hazmat materials have specific regulatory obligations for storage, handling, labeling, and reporting under EPA and OSHA regulations. Material master records must reference applicable compliance obliga',
    `abc_classification` STRING COMMENT 'Inventory management classification based on consumption value and criticality. A-items are high-value/high-usage; C-items are low-value/low-usage. Used for cycle counting and reorder prioritization.. Valid values are `A|B|C`',
    `base_unit_of_measure` STRING COMMENT 'Primary unit of measure for inventory and procurement transactions. Examples: EA (each), FT (feet), LB (pounds), GAL (gallons), TON (tons), KWH (kilowatt-hours), MCF (thousand cubic feet).. Valid values are `^[A-Z]{2,3}$`',
    `batch_managed_indicator` BOOLEAN COMMENT 'Flag indicating whether the material requires batch-level tracking for quality control, traceability, and expiration management.',
    `created_date` DATE COMMENT 'Date when the material master record was first created in the system.',
    `deletion_indicator` BOOLEAN COMMENT 'Flag marking the material for deletion. Materials flagged for deletion cannot be used in new transactions but remain for historical reporting.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether the material meets environmental regulations and sustainability standards (e.g., RoHS, REACH, EPA requirements).',
    `gross_weight` DECIMAL(18,2) COMMENT 'Total weight of the material including packaging. Used for transportation planning and freight cost calculation.',
    `hazmat_class` STRING COMMENT 'Department of Transportation hazard class for hazardous materials (e.g., Class 3 Flammable Liquids, Class 2 Gases). Null for non-hazardous materials.',
    `hazmat_indicator` BOOLEAN COMMENT 'Flag indicating whether the material is classified as hazardous and requires special handling, storage, and transportation procedures per OSHA and PHMSA regulations.',
    `last_modified_date` DATE COMMENT 'Date when the material master record was last updated. Used for data governance and change tracking.',
    `long_description` STRING COMMENT 'Extended technical description providing detailed specifications, usage instructions, or technical characteristics of the material.',
    `manufacturer_name` STRING COMMENT 'Name of the original equipment manufacturer or producer of the material.',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer part number used for cross-referencing, warranty claims, and technical support.',
    `material_description` STRING COMMENT 'Short textual description of the material, equipment, or spare part. Used for display in purchase orders, work orders, and inventory transactions.',
    `material_group` STRING COMMENT 'Hierarchical grouping code used for procurement analytics, vendor assignment, and inventory segmentation. Examples include transformers, cables, meters, coal, natural gas, safety equipment.',
    `material_number` STRING COMMENT 'Externally-known unique material identifier used across procurement, inventory, and work management systems. Aligns with SAP material number or equivalent ERP material code.. Valid values are `^[A-Z0-9]{8,18}$`',
    `material_status` STRING COMMENT 'Current lifecycle status of the material in the catalog. Active materials are available for procurement; obsolete materials are phased out; restricted materials require special authorization.. Valid values are `active|inactive|obsolete|pending_approval|restricted`',
    `material_type` STRING COMMENT 'High-level classification of the material distinguishing between raw materials, spare parts, equipment, consumables, fuel, services, and trading goods. [ENUM-REF-CANDIDATE: raw_material|spare_part|equipment|consumable|fuel|service|trading_good — 7 candidates stripped; promote to reference product]',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Upper inventory limit used to prevent overstocking and optimize warehouse space utilization.',
    `moving_average_price` DECIMAL(18,2) COMMENT 'Weighted average cost per unit recalculated with each goods receipt. Used for materials valued at moving average price.',
    `mrp_type` STRING COMMENT 'Planning strategy code defining how the material is replenished (e.g., reorder point planning, forecast-based planning, consumption-based planning).',
    `net_weight` DECIMAL(18,2) COMMENT 'Weight of the material excluding packaging. Used for technical specifications and load calculations.',
    `planned_delivery_time_days` STRING COMMENT 'Expected lead time in days from purchase order creation to goods receipt. Used for MRP planning and project material scheduling.',
    `plant_specific_status` STRING COMMENT 'Material status at the plant or warehouse level, allowing different availability across locations (e.g., active at one plant, restricted at another).',
    `price_control_indicator` STRING COMMENT 'Defines the valuation method for the material: standard cost or moving average price.. Valid values are `standard|moving_average`',
    `procurement_type` STRING COMMENT 'Indicates whether the material is procured externally from vendors, produced/transferred internally, or both.. Valid values are `external|internal|both`',
    `purchase_unit_of_measure` STRING COMMENT 'Unit of measure used for procurement and purchase order creation. May differ from base UOM when materials are purchased in bulk (e.g., purchased by pallet but stocked by each).. Valid values are `^[A-Z]{2,3}$`',
    `purchasing_group` STRING COMMENT 'Buyer or procurement team responsible for sourcing this material. Used for workload distribution and vendor relationship management.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Inventory level threshold that triggers automatic replenishment. When stock falls below this level, a purchase requisition is generated.',
    `safety_stock_level` DECIMAL(18,2) COMMENT 'Minimum inventory buffer maintained to protect against demand variability and supply disruptions. Critical for storm restoration and emergency response materials.',
    `serial_number_profile` STRING COMMENT 'Configuration code defining serial number management requirements. Used for high-value equipment and assets requiring individual tracking.',
    `shelf_life_days` STRING COMMENT 'Maximum storage duration in days before the material expires or degrades. Critical for chemicals, lubricants, and perishable materials.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Standard unit cost used for inventory valuation, project costing, and financial reporting. Updated periodically through cost roll-up processes.',
    `storage_class` STRING COMMENT 'Warehouse storage classification defining storage conditions and location requirements (e.g., indoor, outdoor, climate-controlled, hazmat-certified).',
    `unspsc_code` STRING COMMENT 'Eight-digit commodity classification code used for spend analytics, supplier discovery, and regulatory reporting. Aligns with global procurement standards.. Valid values are `^[0-9]{8}$`',
    `valuation_class` STRING COMMENT 'Accounting classification code that determines the general ledger accounts for inventory postings (e.g., raw materials, spare parts, fuel inventory).',
    `volume` DECIMAL(18,2) COMMENT 'Physical volume of the material used for warehouse space planning and transportation optimization.',
    `volume_unit` STRING COMMENT 'Unit of measure for volume (e.g., CFT for cubic feet, M3 for cubic meters, GAL for gallons).. Valid values are `^[A-Z]{2,3}$`',
    `weight_unit` STRING COMMENT 'Unit of measure for weight fields (e.g., LB for pounds, KG for kilograms, TON for tons).. Valid values are `^[A-Z]{2,3}$`',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Enterprise catalog of all procurable materials, equipment, and spare parts used across generation, T&D, and gas infrastructure operations. Captures material number, description, material group, unit of measure, hazardous material classification, UNSPSC commodity code, lead time, reorder point, safety stock level, standard cost, and storage class. Aligned with SAP MM material master (MARA/MARC) and supports CAPEX project BOM management and storm restoration kitting. Distinct from the asset domains physical asset records — this is the catalog definition, not the installed asset instance.';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'Unique identifier for the purchase order record. Primary key for the purchase order entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Purchase orders are issued against cost center budgets for budget control and encumbrance accounting. Budget managers approve POs against their cost center allocations, fundamental to utility procurem',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Rate case proceedings and prudency reviews require PO documentation for capital expenditure justification. Regulatory audits trace approved rate base investments back to procurement records. Essential',
    `employee_id` BIGINT COMMENT 'Reference to the procurement specialist or purchasing agent responsible for this PO. Links to employee master record.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: PO encumbrances post to GL accounts for commitment accounting and funds reservation. Required for accurate available budget calculations and preventing over-commitment of budgeted funds in utility fin',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: Purchase orders can be created as releases against procurement contracts (blanket POs, fuel contracts). Currently denormalized as contract_number (STRING). Adding procurement_contract_id FK enables co',
    `vendor_id` BIGINT COMMENT 'Reference to the supplier or contractor providing the materials, equipment, fuel, or services. Links to vendor master record in ERP system.',
    `approval_date` DATE COMMENT 'Date the purchase order received final authorization from the approving authority based on delegation of authority matrix and spending thresholds.',
    `approved_by` STRING COMMENT 'Name or employee ID of the manager or executive who provided final approval for this purchase order based on spending authority limits.',
    `buyer_name` STRING COMMENT 'Full name of the procurement specialist responsible for this purchase order. Denormalized for reporting and audit trail.',
    `cancellation_date` DATE COMMENT 'Date the purchase order was cancelled before fulfillment. Used for tracking procurement process failures and vendor performance issues.',
    `cancellation_reason` STRING COMMENT 'Business justification for purchase order cancellation (e.g., project cancelled, vendor unable to deliver, duplicate order, budget cut). Supports root cause analysis for procurement process improvement.',
    `closed_date` DATE COMMENT 'Date the purchase order was administratively closed after all goods receipts, invoice verifications, and payments were completed. Marks the end of the procurement-to-pay cycle.',
    `company_code` STRING COMMENT 'Legal entity code in the ERP system representing the utility company or subsidiary issuing the purchase order. Used for financial consolidation and regulatory reporting.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase order record was first created in the ERP system. Audit trail for procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the purchase order monetary values. Typically USD for US-based utilities, but may vary for international procurement or fuel hedging contracts.. Valid values are `^[A-Z]{3}$`',
    `delivery_address` STRING COMMENT 'Full physical address for material delivery or service performance location. May differ from plant master address for field construction or emergency restoration sites.',
    `erp_document_number` STRING COMMENT 'Native document identifier from SAP S/4HANA or Oracle ERP Cloud. Provides traceability to source system for audit and reconciliation.',
    `freight_amount` DECIMAL(18,2) COMMENT 'Shipping, transportation, or logistics charges associated with material delivery. May be vendor-charged or utility-arranged depending on incoterms.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether goods receipt posting is required for this PO. True for materials requiring inventory management and quality inspection; false for services and direct-charge items.',
    `incoterms` STRING COMMENT 'International Commercial Terms defining the division of costs, risks, and responsibilities between buyer and seller for transportation and delivery. Critical for imported equipment and international fuel procurement. [ENUM-REF-CANDIDATE: EXW|FCA|CPT|CIP|DAP|DPU|DDP|FAS|FOB|CFR|CIF — 11 candidates stripped; promote to reference product]',
    `invoice_receipt_indicator` BOOLEAN COMMENT 'Flag indicating whether invoice verification is required before payment. Supports three-way match control (PO, goods receipt, invoice) for SOX compliance.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the purchase order record. Tracks changes to quantities, prices, delivery dates, or status throughout the procurement lifecycle.',
    `material_group` STRING COMMENT 'Commodity classification or material category for purchased items (e.g., transformers, conductors, natural gas, coal, IT hardware, professional services). Used for spend analytics and category management.',
    `payment_terms` STRING COMMENT 'Contractual payment terms negotiated with the vendor (e.g., Net 30, Net 45, 2/10 Net 30). Defines due date calculation and early payment discount eligibility.',
    `plant_code` STRING COMMENT 'Destination facility, power plant, substation, service center, or warehouse where materials or services will be delivered or performed. Links to asset location master.',
    `po_date` DATE COMMENT 'Date the purchase order was created and issued to the vendor. Establishes the contractual commitment date and payment terms baseline.',
    `po_number` STRING COMMENT 'Externally-known business identifier for the purchase order. Unique document number assigned by SAP S/4HANA or Oracle ERP Cloud for procurement tracking and vendor communication.. Valid values are `^[A-Z0-9]{8,20}$`',
    `po_status` STRING COMMENT 'Current lifecycle state of the purchase order in the procurement-to-pay workflow. Tracks progression from creation through goods receipt and final closure. [ENUM-REF-CANDIDATE: draft|approved|issued|partially_received|fully_received|closed|cancelled — 7 candidates stripped; promote to reference product]',
    `po_type` STRING COMMENT 'Classification of the purchase order based on procurement strategy. Standard for one-time purchases, blanket for recurring material releases, framework for long-term agreements, service for labor/consulting, contract for multi-year commitments.. Valid values are `standard|blanket|framework|service|contract`',
    `priority_code` STRING COMMENT 'Urgency classification for procurement processing and vendor expediting. Emergency and critical priorities used for storm restoration and forced outage response.. Valid values are `routine|expedite|emergency|critical`',
    `promised_delivery_date` DATE COMMENT 'Date committed by the vendor for delivery or service completion. Used for supplier performance tracking and expediting follow-up.',
    `purchasing_group` STRING COMMENT 'Specialized procurement team or category management group responsible for specific material classes or vendor relationships (e.g., generation fuel, T&D equipment, IT services).',
    `purchasing_organization` STRING COMMENT 'Organizational unit responsible for procurement activities. Typically aligned with business unit, region, or legal entity for centralized or decentralized procurement models.',
    `requested_delivery_date` DATE COMMENT 'Date by which the utility requires materials or services to be delivered. Drives vendor lead time planning and expediting priorities for outage restoration or project schedules.',
    `requisition_number` STRING COMMENT 'Source purchase requisition document number that originated this PO. Provides traceability from internal demand to external procurement.',
    `storage_location` STRING COMMENT 'Specific warehouse, yard, or inventory storage area within the plant where materials will be received and stocked.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total sales tax, use tax, or value-added tax (VAT) applicable to the purchase order based on jurisdiction and material tax classification.',
    `total_po_value` DECIMAL(18,2) COMMENT 'Total monetary value of the purchase order including all line items, before taxes and freight. Represents the committed spend amount for budget tracking and vendor payment.',
    `total_po_value_with_tax` DECIMAL(18,2) COMMENT 'Grand total of the purchase order including base value, taxes, and freight. Represents the maximum payment obligation to the vendor.',
    `vendor_site_code` STRING COMMENT 'Specific vendor location or branch code for multi-site suppliers. Identifies the remit-to address and payment processing location.',
    `wbs_element` STRING COMMENT 'Project work breakdown structure element for CAPEX purchases tied to capital projects (new generation capacity, transmission line construction, substation upgrades). Enables AFUDC calculation and asset capitalization.',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Authoritative transactional record for all purchase orders issued to vendors for materials, equipment, fuel, and services. Captures PO number, PO type (standard, blanket, framework, service), vendor reference, plant/delivery location, requested delivery date, total PO value, currency, payment terms, incoterms, approval status, SAP S/4HANA document number, and associated cost object (WBS element for CAPEX, cost center for OPEX). Supports procurement-to-pay cycle from requisition through goods receipt and invoice verification.';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`po_line_item` (
    `po_line_item_id` BIGINT COMMENT 'Unique identifier for the purchase order line item. Primary key for the po_line_item product.',
    `master_id` BIGINT COMMENT 'Foreign key linking to asset.asset_master. Business justification: Capital equipment purchases must link to asset master for AFUDC calculation, depreciation start date, regulatory asset base inclusion, and FERC account classification. Utilities capitalize equipment a',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record for stock items. Links to the specific material, equipment, or supply being procured (e.g., transformers, conductors, generation fuel, meters, tools). Null for service-only line items.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: PO line items can be release orders against blanket purchase agreements or fuel supply contracts. This FK links the release to the master contract, enabling contract spend tracking, quantity commitmen',
    `purchase_order_id` BIGINT COMMENT 'Foreign key reference to the parent purchase order header. Links this line item to its containing purchase order document.',
    `account_assignment_category` STRING COMMENT 'Category code that determines how the line item cost will be allocated in the financial system. K=Cost Center (OPEX), A=Asset (direct capitalization), P=Project/WBS Element (CAPEX), F=Order (internal order), N=Network (project network). Critical for proper CAPEX/OPEX classification and regulatory cost recovery.. Valid values are `K|A|P|F|N`',
    `confirmation_control_key` STRING COMMENT 'Control key that determines whether and how the vendor must confirm the purchase order line item. Used for critical or long-lead-time materials (e.g., large transformers, generation turbines) where vendor acknowledgment of delivery dates is required before proceeding.',
    `cost_center_code` STRING COMMENT 'Cost center code for OPEX account assignment (when account_assignment_category = K). Identifies the organizational unit responsible for the expense, such as a generation plant O&M cost center, T&D maintenance cost center, or administrative department.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this line item record was first created in the system. Represents the initial capture of the line item as part of the purchase order creation process. Used for audit trail and procurement cycle time analysis.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the unit price and net value. Typically USD for U.S. utilities, but may vary for international procurement or cross-border fuel purchases.. Valid values are `^[A-Z]{3}$`',
    `deletion_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this line item has been marked for deletion. True if the line item is logically deleted (soft delete) but retained for audit trail. False for active line items. Deleted line items are excluded from goods receipt and invoice processing.',
    `delivery_date` DATE COMMENT 'Scheduled delivery date for this line item. Represents the date by which the material or service is expected to be delivered or performed. Critical for generation fuel delivery schedules, storm restoration material logistics, and CAPEX project material planning.',
    `gl_account_code` STRING COMMENT 'General ledger account code for financial posting. Determines the expense or asset account to which the line item cost will be posted. For utilities, this includes accounts for fuel inventory, materials and supplies, construction work in progress (CWIP), and O&M expenses per the FERC Uniform System of Accounts.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether a goods receipt (GR) is required for this line item. True for material line items that require physical receipt confirmation. False for service line items or limit items where goods receipt is not applicable. Used to control three-way match logic (PO-GR-Invoice).',
    `incoterms` STRING COMMENT 'Incoterms code defining the delivery terms and transfer of risk between buyer and seller (e.g., FOB, CIF, DDP). Determines who pays for shipping, insurance, and customs, and when title transfers. Critical for fuel procurement and international equipment purchases.',
    `incoterms_location` STRING COMMENT 'Named location associated with the Incoterms code (e.g., port of shipment, destination facility). Specifies the geographic point where risk and cost responsibility transfer per the Incoterms agreement.',
    `item_category` STRING COMMENT 'Category of the line item that determines procurement processing rules. Standard=normal material procurement, Consignment=vendor-owned inventory, Subcontracting=material provided to vendor for processing, Service=service procurement with service entry sheet, Limit=value-based item without quantity, Text=informational text line.. Valid values are `standard|consignment|subcontracting|service|limit|text`',
    `line_number` STRING COMMENT 'Sequential line number within the purchase order. Determines the ordering and position of this line item within the parent PO document.',
    `line_status` STRING COMMENT 'Current processing status of the line item. Open=awaiting delivery, Partially_received=some quantity received, Fully_received=all quantity received, Invoiced=invoice posted, Closed=administratively closed, Cancelled=line item cancelled. Drives procurement workflow and three-way match processing.. Valid values are `open|partially_received|fully_received|invoiced|closed|cancelled`',
    `manufacturer_part_number` STRING COMMENT 'Original equipment manufacturer (OEM) part number for the material. Critical for T&D equipment and generation spare parts where OEM specifications must be maintained for warranty, safety, and regulatory compliance. Used for asset management and maintenance planning.',
    `material_description` STRING COMMENT 'Short text description of the material or service being procured. For stock materials, this typically mirrors the material master description. For non-stock items and services, this is a free-text description entered at line creation.',
    `modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this line item record was last modified. Captures changes to quantity, price, delivery date, or other line item attributes. Used for change tracking and procurement audit compliance.',
    `net_value` DECIMAL(18,2) COMMENT 'Total net value of this line item, calculated as ordered_quantity multiplied by unit_price, before taxes and additional charges. This is the base procurement cost for this line item and is used for three-way match validation and cost allocation to CAPEX or OPEX accounts.',
    `ordered_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service ordered on this line item. Expressed in the unit of measure specified in the uom field. For materials, this is the physical quantity (e.g., 100 meters of cable, 5 transformers). For services, this may represent hours, days, or service units.',
    `over_delivery_tolerance_pct` DECIMAL(18,2) COMMENT 'Percentage by which the delivered quantity may exceed the ordered quantity without requiring approval. For example, 5.00 allows up to 5% over-delivery. Used to accommodate normal shipping variances while controlling excess inventory and cost overruns.',
    `plant_code` STRING COMMENT 'Plant or facility code where the material will be received or the service will be performed. For utilities, this may represent a generation plant, service center, warehouse, or regional operations center. Links to the organizational structure for inventory management and cost allocation.',
    `requisitioner_name` STRING COMMENT 'Name of the employee or department that originated the purchase requisition leading to this PO line item. Used for procurement tracking, approval workflow, and accountability for material and service requests.',
    `service_entry_sheet_required` BOOLEAN COMMENT 'Boolean flag indicating whether a service entry sheet is required for this line item. True for service line items where service performance must be confirmed before invoice approval. False for material line items. Used for contractor labor, engineering services, and maintenance services.',
    `storage_location` STRING COMMENT 'Storage location code within the plant where the material will be stocked upon receipt. Used for warehouse management and inventory tracking of T&D equipment, generation spare parts, and O&M supplies. Null for direct-to-project deliveries or service line items.',
    `tax_code` STRING COMMENT 'Tax code that determines the applicable sales tax, use tax, or VAT treatment for this line item. Tax treatment varies by jurisdiction, material type (e.g., fuel may be tax-exempt), and account assignment (CAPEX vs OPEX). Used for invoice verification and tax reporting.',
    `under_delivery_tolerance_pct` DECIMAL(18,2) COMMENT 'Percentage by which the delivered quantity may fall short of the ordered quantity without requiring follow-up action. For example, 2.00 allows up to 2% under-delivery. Used to close line items with minor shortages without administrative burden.',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of measure for this line item. Expressed in the currency specified in the currency_code field. For materials, this is the negotiated or catalog price per unit. For services, this is the rate per service unit (e.g., hourly rate for contractor labor).',
    `uom` STRING COMMENT 'Unit of measure for the ordered quantity. Standard utility procurement units include EA (each), M (meter), FT (foot), GAL (gallon), TON (ton), HR (hour), KWH (kilowatt-hour), MCF (thousand cubic feet), BBL (barrel) for fuel oil, and service-specific units.',
    `vendor_material_number` STRING COMMENT 'Vendors own material or catalog number for the item being procured. Used for cross-reference between the utilitys material master and the vendors product catalog. Facilitates order processing and invoice reconciliation with vendor systems.',
    `wbs_element` STRING COMMENT 'WBS element code for CAPEX project account assignment (when account_assignment_category = P). Links the line item to a specific capital project such as a transmission line upgrade, substation expansion, generation plant construction, or AMI deployment project. Enables project cost tracking and AFUDC calculation.',
    CONSTRAINT pk_po_line_item PRIMARY KEY(`po_line_item_id`)
) COMMENT 'Individual line-item detail within a purchase order, representing a specific material, equipment item, or service quantity and price. Captures line number, material reference (linked to material_master for stock items), ordered quantity, unit of measure, unit price, net value, delivery schedule date, account assignment category (cost center for OPEX, WBS element for CAPEX, asset number for direct capitalization), goods receipt indicator, and service entry sheet flag for service POs. Enables granular tracking of multi-line POs for T&D equipment procurement, generation fuel orders, and O&M supply requisitions. Supports three-way match at line level and CAPEX/OPEX cost allocation.';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt transaction. Primary key for the goods receipt record in the lakehouse silver layer.',
    `capex_project_id` BIGINT COMMENT 'Reference to the CAPEX project if the goods receipt is for project-specific materials. Links to capital project tracking for T&D infrastructure upgrades, generation plant construction, or major asset installations.',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_event. Business justification: Hazmat and fuel receipts trigger environmental compliance tracking. Spills, quality violations, and storage incidents during receiving must be documented for EPA and state reporting. Links material mo',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Goods receipts charge actual material costs to cost centers for budget consumption tracking. Essential for converting PO encumbrances to actual expenses and tracking cost center spend against budget i',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Goods receipts post to GL accounts for inventory valuation (asset accounts) or direct expense recognition. Required for three-way match (PO-GR-Invoice), inventory accounting, and FERC plant accounting',
    `master_id` BIGINT COMMENT 'Foreign key linking to asset.asset_master. Business justification: Receiving capital equipment triggers asset capitalization, installation tracking, and in-service date determination for depreciation and rate base. Utilities must link goods receipts to asset records ',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record for the item received. Links to the material catalog for T&D equipment, generation fuel, or O&M supplies.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Three-way match process: PO → goods receipt → meter installation. Utilities receive serialized meters into inventory and must track which specific meter was received against which PO. Critical for ass',
    `po_line_item_id` BIGINT COMMENT 'Foreign key linking to supply.po_line_item. Business justification: Goods receipts are posted against specific PO line items, not just the header. Currently denormalized as po_line_item_number (INT). Adding po_line_item_id FK enables precise 3-way matching (PO line → ',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this goods receipt is posted. Links to the originating procurement document.',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor master record from whom the materials were received. Links to the supplier providing the goods.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Goods receipts are physically received at specific warehouses. Currently denormalized as storage_location_code and plant_code. Adding warehouse_id FK normalizes receiving location and enables warehous',
    `work_order_id` BIGINT COMMENT 'Reference to the work order if the goods receipt is for maintenance or operational work. Links to asset management work order for O&M supplies or equipment repairs.',
    `batch_number` STRING COMMENT 'Batch or lot number assigned to the received materials for traceability. Critical for materials requiring batch management such as chemicals, fuels, or serialized equipment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods receipt record was first created in the ERP system. Audit field for data lineage and record creation tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation amount. Typically USD for US-based utilities.. Valid values are `^[A-Z]{3}$`',
    `delivery_completed_flag` BOOLEAN COMMENT 'Indicates whether this goods receipt completes the delivery for the purchase order line item. True if no further deliveries are expected; false if partial delivery with more to come.',
    `delivery_note_number` STRING COMMENT 'Delivery note or shipment document number provided by the vendor. Used to match physical delivery documentation with the goods receipt.',
    `document_date` DATE COMMENT 'Date on the goods receipt document itself, typically the date the physical receipt occurred. May differ from posting date if there is a delay in system entry.',
    `gr_document_number` STRING COMMENT 'Externally-known goods receipt document number generated by the ERP system. Used for cross-system reconciliation and audit trail.. Valid values are `^[A-Z0-9]{10}$`',
    `gr_status` STRING COMMENT 'Current lifecycle status of the goods receipt transaction. Posted indicates the GR is complete and inventory updated; pending inspection indicates quality hold; reversed indicates the GR was cancelled or corrected.. Valid values are `posted|pending_inspection|inspection_complete|reversed|cancelled`',
    `inspection_outcome` STRING COMMENT 'Result of the quality inspection process. Accepted materials move to unrestricted stock; rejected materials are returned to vendor or scrapped; partially accepted materials are split between accepted and rejected quantities.. Valid values are `accepted|rejected|partially_accepted|pending|not_applicable`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the goods receipt record was last updated in the ERP system. Audit field for change tracking and data quality monitoring.',
    `movement_type` STRING COMMENT 'SAP movement type code indicating the nature of the goods receipt. Common types: 101 (GR to unrestricted stock), 103 (GR to blocked/quality inspection stock), 105 (release from quality inspection), 161 (return delivery to vendor), 501 (receipt without PO).. Valid values are `101|103|105|161|501`',
    `notes` STRING COMMENT 'Free-text notes or comments entered by receiving personnel regarding the goods receipt. May include observations about packaging condition, discrepancies, or special handling instructions.',
    `over_delivery_tolerance_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the received quantity exceeds the over-delivery tolerance defined in the purchase order. True if the receipt quantity is beyond acceptable limits and requires approval.',
    `packing_slip_reference` STRING COMMENT 'Vendor packing slip or bill of lading reference number. Provides traceability to the vendors shipping documentation.',
    `posting_date` DATE COMMENT 'Date on which the goods receipt was posted in the ERP system. Determines the accounting period for inventory valuation and financial posting.',
    `quality_inspection_required_flag` BOOLEAN COMMENT 'Indicates whether the received materials require quality inspection before being released to unrestricted stock. True if inspection is mandatory per material master or vendor agreement.',
    `received_quantity` DECIMAL(18,2) COMMENT 'Quantity of material physically received and recorded in this goods receipt transaction. Used for inventory stock position update and three-way match.',
    `receiving_person_name` STRING COMMENT 'Name of the warehouse or storeroom personnel who physically received and verified the materials. Provides accountability for the receipt transaction.',
    `receiving_timestamp` TIMESTAMP COMMENT 'Timestamp when the materials were physically received at the storage location. Captures the actual receipt event time for logistics and supply chain analytics.',
    `reversal_document_number` STRING COMMENT 'Document number of the reversal transaction if this goods receipt was reversed. Links to the correcting GR document for audit trail.',
    `reversal_indicator` BOOLEAN COMMENT 'Indicates whether this goods receipt has been reversed or cancelled. True if the GR was subsequently reversed due to error, return to vendor, or other correction.',
    `serial_number` STRING COMMENT 'Serial number for individually tracked equipment or materials. Used for high-value assets such as transformers, meters, or specialized T&D equipment requiring unique identification.',
    `stock_type` STRING COMMENT 'Classification of the stock status after goods receipt. Unrestricted stock is available for use; blocked stock is held pending inspection or resolution; quality inspection stock is under testing; restricted stock has usage limitations.. Valid values are `unrestricted|blocked|quality_inspection|restricted`',
    `under_delivery_tolerance_exceeded_flag` BOOLEAN COMMENT 'Indicates whether the received quantity is below the under-delivery tolerance defined in the purchase order. True if the receipt quantity is insufficient and requires follow-up.',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the received quantity. Common utility units include EA (each), FT (feet), M (meters), KG (kilograms), GAL (gallons), TON (tons), MCF (thousand cubic feet), THERM (heat energy unit), KWH (kilowatt-hour), MWH (megawatt-hour). [ENUM-REF-CANDIDATE: EA|FT|M|KG|LB|GAL|L|TON|MCF|THERM|KWH|MWH — 12 candidates stripped; promote to reference product]',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Total valuation amount for the goods receipt in the local currency. Calculated as received quantity multiplied by the material price from the purchase order. Posted to inventory and accounts payable.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Transactional record capturing the physical receipt of materials and equipment at a utility warehouse, storeroom, or project site against a purchase order. Records GR document number, posting date, PO reference, PO line item reference, delivery note number, vendor packing slip reference, received quantity, unit of measure, receiving storage location (linked to warehouse), movement type (101 standard receipt to unrestricted stock, 103 GR to blocked/quality inspection stock, 105 release from quality inspection), quality inspection required flag, inspection outcome (accepted, rejected, partially accepted), batch/lot number for traceable materials, and receiving plant. Triggers inventory stock position update and initiates the three-way match process (PO–GR–invoice) in SAP S/4HANA. Critical for CAPEX project material tracking, storm restoration supply chain verification, and inventory valuation posting.';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`procurement_contract` (
    `procurement_contract_id` BIGINT COMMENT 'Unique identifier for the procurement contract record. Primary key for the procurement contract entity.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Long-term fuel and equipment contracts require regulatory approval in rate cases and CPCN applications. Contracts are exhibits in regulatory filings. Prudency reviews examine contract terms and pricin',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier or contractor party to this procurement contract. Links to vendor master record in ERP (Enterprise Resource Planning) system for payment terms, contact information, and performance history.',
    `amendment_count` STRING COMMENT 'Total number of formal amendments executed against this contract. High amendment counts may indicate scope creep, pricing volatility, or contract management challenges. Used for contract performance analysis and vendor relationship assessment.',
    `base_price` DECIMAL(18,2) COMMENT 'Initial unit price or rate established at contract execution. For fuel contracts, may represent the base commodity price before index adjustments. For equipment, the negotiated unit price. For services, the hourly or daily rate. Subject to escalation clauses and index linkage adjustments over contract life.',
    `commodity_category` STRING COMMENT 'High-level classification of goods or services covered by this contract. Examples include generation fuel (coal, natural gas, nuclear fuel), T&D equipment (transformers, conductors, poles), fleet services (vehicles, maintenance), IT hardware, professional services, or construction services. Used for spend analytics and category management.',
    `contract_approval_date` DATE COMMENT 'Date when the procurement contract received final internal authorization and was approved for execution. May represent board approval for high-value contracts, executive approval, or procurement authority approval depending on contract value and organizational delegation of authority.',
    `contract_document_repository_path` STRING COMMENT 'File path or URL to the executed contract document and amendments in the enterprise document management system. Enables quick access to full contract terms for legal review, audit, or dispute resolution. May reference SharePoint, SAP DMS (Document Management System), or dedicated contract management system.',
    `contract_execution_date` DATE COMMENT 'Date when the contract was signed by both utility and vendor, making it legally binding. May differ from effective start date if contract includes a future commencement provision. Used for contract age analysis and audit trail.',
    `contract_number` STRING COMMENT 'Externally-known unique business identifier for the procurement contract. Used for vendor communication, invoice reconciliation, and cross-system reference. May follow organizational numbering schemes or SAP outline agreement document number format.',
    `contract_owner` STRING COMMENT 'Name or identifier of the utility employee responsible for managing this procurement contract. Typically a procurement specialist, category manager, or fuel supply manager. Accountable for contract performance monitoring, renewal negotiations, and vendor relationship management.',
    `contract_status` STRING COMMENT 'Current lifecycle state of the procurement contract. Draft indicates contract under negotiation; pending approval awaiting internal authorization; active indicates contract in force and available for release; suspended temporarily halted; expired past validity period; terminated ended before expiration; closed completed and archived. [ENUM-REF-CANDIDATE: draft|pending_approval|active|suspended|expired|terminated|closed — 7 candidates stripped; promote to reference product]',
    `contract_type` STRING COMMENT 'Classification of the procurement contract based on commitment structure. Quantity contract commits to specific volumes; value contract commits to dollar amounts; fuel PPA (Power Purchase Agreement) for generation fuel supply; service agreement for O&M (Operations and Maintenance) services; blanket PO (Purchase Order) for recurring purchases; framework agreement for multi-year supply arrangements.. Valid values are `quantity_contract|value_contract|fuel_ppa|service_agreement|blanket_po|framework_agreement`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this procurement contract record was first created in the system. Represents initial data capture, which may precede contract negotiation completion. Used for data lineage and audit trail.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for contract financial terms. Typically USD for domestic utility operations; may include CAD, MXN, or EUR for cross-border procurement or international equipment suppliers.. Valid values are `^[A-Z]{3}$`',
    `effective_end_date` DATE COMMENT 'Date when the procurement contract expires and is no longer available for new purchase order releases. Nullable for evergreen or open-ended contracts. May trigger renewal evaluation or contract closeout procedures.',
    `effective_start_date` DATE COMMENT 'Date when the procurement contract becomes legally binding and available for purchase order release. Marks the beginning of the contract validity period.',
    `fuel_index_linkage` STRING COMMENT 'Specific commodity price index used for fuel contract price adjustments. Examples include Henry Hub natural gas spot price, NYMEX futures, regional coal price indices, or uranium spot price. Enables pass-through of commodity price volatility and aligns contract pricing with market conditions. Applicable primarily to generation fuel supply contracts.',
    `insurance_requirements` STRING COMMENT 'Contractually mandated insurance coverage the vendor must maintain. Typically includes general liability, workers compensation, professional liability (for service contracts), and automobile liability. May specify minimum coverage amounts and require utility to be named as additional insured. Critical for risk transfer and regulatory compliance.',
    `last_amendment_date` DATE COMMENT 'Date of the most recent contract amendment or modification. Amendments may adjust pricing, quantities, scope, or terms. Nullable if no amendments have been executed. Used for contract change tracking and version control.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to this procurement contract record. Captures updates to status, pricing, quantities, or any other contract attribute. Used for change tracking and data freshness assessment.',
    `maximum_quantity_commitment` DECIMAL(18,2) COMMENT 'Contractually allowed maximum purchase quantity over the contract period. Protects vendor from unlimited demand and utility from supply shortages. Common in fuel supply contracts and equipment framework agreements. Nullable for open-ended service agreements.',
    `minimum_quantity_commitment` DECIMAL(18,2) COMMENT 'Contractually obligated minimum purchase quantity over the contract period. Common in fuel supply contracts (e.g., minimum annual MCF (Thousand Cubic Feet) of natural gas or tons of coal) and equipment blanket orders. Failure to meet minimum may trigger penalties or price adjustments. Nullable for value contracts or service agreements without quantity commitments.',
    `notes` STRING COMMENT 'Free-text field for additional contract information, special conditions, negotiation history, or operational notes. May capture unique contract provisions, vendor relationship context, or procurement strategy rationale not captured in structured fields.',
    `payment_terms` STRING COMMENT 'Contractual payment schedule and conditions. Examples include Net 30, Net 60, 2/10 Net 30 (2% discount if paid within 10 days), progress payments for construction contracts, or milestone-based payments for project services. Impacts cash flow management and vendor relationship.',
    `performance_guarantee` STRING COMMENT 'Contractual performance commitments and associated remedies. May include delivery time guarantees, quality specifications, service level agreements (SLAs), equipment performance warranties, or fuel quality specifications (BTU content, sulfur content). Defines vendor accountability and utility recourse for non-performance.',
    `price_escalation_clause` STRING COMMENT 'Description of contractual price adjustment mechanism over time. May reference inflation indices (CPI, PPI), commodity indices (Henry Hub for natural gas, coal price indices), labor rate adjustments, or fixed annual percentage increases. Critical for multi-year contract cost forecasting and budget planning.',
    `price_unit_of_measure` STRING COMMENT 'Unit of measure for pricing. Examples include per MCF for natural gas, per ton for coal, per MWh for power, per each for equipment, per hour for labor services. Must align with quantity unit of measure for accurate cost calculation.',
    `purchasing_group` STRING COMMENT 'Buyer group or category team responsible for this contract. Examples include generation fuel team, substation equipment team, fleet services team, or IT procurement team. Used for workload distribution and specialized procurement expertise.',
    `purchasing_organization` STRING COMMENT 'Organizational unit within the utility responsible for procurement activities under this contract. May represent corporate procurement, generation fuel procurement, T&D (Transmission and Distribution) materials, or regional procurement centers. Aligns with SAP purchasing organization structure.',
    `quantity_unit_of_measure` STRING COMMENT 'Unit of measure for quantity commitments and releases. Examples include MCF (Thousand Cubic Feet) or BCF (Billion Cubic Feet) for natural gas, tons for coal, MWh (Megawatt-Hour) for purchased power, each for equipment units, or hours for service contracts. Must align with vendor invoicing and inventory management units.',
    `regulatory_compliance_requirements` STRING COMMENT 'Contractual obligations for vendor compliance with utility industry regulations. May include NERC (North American Electric Reliability Corporation) CIP (Critical Infrastructure Protection) requirements for cyber security, OSHA (Occupational Safety and Health Administration) safety standards, EPA (Environmental Protection Agency) environmental regulations, or state PUC (Public Utility Commission) procurement rules. Ensures vendor activities do not create regulatory risk for utility.',
    `renewal_terms` STRING COMMENT 'Contractual provisions for contract extension or renewal. May specify automatic renewal unless notice given, option periods with defined pricing, or requirement for renegotiation. Includes notice period requirements (e.g., 90 days prior to expiration) and conditions for renewal pricing adjustments.',
    `sap_outline_agreement_number` STRING COMMENT 'SAP S/4HANA system document number for the outline agreement (contract or scheduling agreement) record. Enables integration between procurement contract master data and SAP MM (Materials Management) purchase order release, goods receipt, and invoice verification processes. Critical for ERP (Enterprise Resource Planning) system traceability.',
    `termination_clause` STRING COMMENT 'Contractual provisions allowing early termination by either party. May include termination for convenience (with notice period and penalties), termination for cause (vendor non-performance, safety violations), force majeure provisions, or change-in-law provisions. Critical for risk management and contract flexibility.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Maximum financial commitment under this contract in USD (United States Dollars). For value contracts, represents the spending limit; for quantity contracts, represents estimated total value based on committed quantities and unit prices. Used for budget planning, spend tracking, and contract authority approval thresholds.',
    CONSTRAINT pk_procurement_contract PRIMARY KEY(`procurement_contract_id`)
) COMMENT 'Master record for long-term supply agreements, blanket purchase agreements, fuel supply contracts, and framework contracts with vendors. Captures contract number, contract type (quantity contract, value contract, fuel PPA, service agreement), validity period, total contract value, minimum/maximum quantity commitments, price escalation clauses, fuel index linkage (e.g., Henry Hub for gas), renewal terms, and SAP outline agreement document number. Distinct from regulatory contracts (owned by regulatory domain) and customer service agreements (owned by customer domain).';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`inventory_stock` (
    `inventory_stock_id` BIGINT COMMENT 'Unique identifier for the inventory stock position record. Primary key for the inventory_stock product.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record. Links to the material_master product to identify the specific material (spare part, equipment, fuel, consumable) held in inventory.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse or storage location where the material is physically held. Links to the warehouse product to identify the facility (central warehouse, field storeroom, generation plant stores).',
    `abc_classification` STRING COMMENT 'ABC inventory classification based on consumption value or criticality. A = high-value/high-turnover items requiring tight control; B = moderate-value items; C = low-value/low-turnover items; X = unclassified or new materials. Used for cycle count frequency and inventory management strategy.. Valid values are `A|B|C|X`',
    `blocked_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material blocked from use due to quality issues, damage, obsolescence, or regulatory hold. Material in this status cannot be issued and may require disposition (scrap, return to vendor, rework).',
    `consignment_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material held on consignment from a vendor. Material is physically at the utility location but remains vendor-owned until consumed. Common for high-value spare parts and generation fuel.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this inventory stock position record was first created in the system. Typically corresponds to the first goods receipt at this storage location for this material.',
    `expiration_date` DATE COMMENT 'Expiration or shelf-life end date for perishable or time-sensitive materials (chemicals, lubricants, safety equipment, medical supplies). Material should not be issued after this date. Null for non-perishable materials.',
    `in_transit_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material currently in transit between storage locations or from vendor to warehouse. Material in this status is owned but not yet physically available at the destination location. Tracked via stock transfer orders.',
    `issued_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of material issued from this stock position during the current period. Backed by goods_issue transactions. Used for consumption tracking and inventory turnover analysis.',
    `last_goods_issue_date` DATE COMMENT 'Date of the most recent goods issue transaction that decreased stock at this location. Used for inventory turnover analysis and obsolescence detection.',
    `last_goods_receipt_date` DATE COMMENT 'Date of the most recent goods receipt transaction that increased stock at this location. Used for inventory aging analysis and slow-moving stock identification.',
    `last_physical_inventory_count_date` DATE COMMENT 'Date of the most recent physical inventory count (cycle count or annual inventory) performed for this material at this location. Used for inventory accuracy tracking and audit compliance. Regulatory requirements may mandate minimum count frequency.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this inventory stock position record. Updated by goods receipt, goods issue, stock transfer, physical inventory, or reservation transactions. Used for data freshness validation and change tracking.',
    `lot_number` STRING COMMENT 'Manufacturer or vendor lot/batch number for lot-managed materials. Used for traceability, quality control, and recall management. Critical for generation fuel, chemicals, and safety equipment. May be null for non-lot-managed materials.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `maximum_stock_level` DECIMAL(18,2) COMMENT 'Maximum stock quantity threshold for this material at this location. Used to prevent overstocking and optimize working capital. Replenishment orders target this level. Breach indicates potential excess inventory.',
    `moving_average_cost_per_unit` DECIMAL(18,2) COMMENT 'Moving average cost per unit of measure for this material. Recalculated with each goods receipt based on actual purchase prices. Used for inventory valuation when moving average costing method is applied. Confidential business financial data.',
    `mrp_controller` STRING COMMENT 'Three-character code identifying the MRP controller or inventory planner responsible for managing replenishment and stock levels for this material. Used for workload distribution and accountability.. Valid values are `^[A-Z0-9]{3}$`',
    `physical_inventory_variance_quantity` DECIMAL(18,2) COMMENT 'Quantity difference between system book stock and physical count from the last inventory count. Positive values indicate physical surplus; negative values indicate shortage. Used for inventory accuracy metrics and shrinkage analysis.',
    `plant_code` STRING COMMENT 'Four-character code identifying the utility plant or operational facility to which this inventory stock position belongs (generation plant, service center, operations hub).. Valid values are `^[A-Z0-9]{4}$`',
    `procurement_type` STRING COMMENT 'Indicates how this material is procured. External = purchased from vendors; internal = manufactured or transferred from other plants; both = can be procured either way. Drives replenishment logic.. Valid values are `external|internal|both`',
    `quality_inspection_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material currently held in quality inspection status. Material in this status cannot be issued until quality control approval is received. Common for critical spare parts and generation fuel deliveries.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Minimum stock level threshold that triggers automatic replenishment. When unrestricted stock falls below this level, a purchase requisition or stock transfer request is generated. Set based on lead time and consumption rate.',
    `reorder_point_breach_flag` BOOLEAN COMMENT 'Boolean indicator that the current unrestricted stock quantity has fallen below the reorder point threshold. True indicates replenishment action is required. Used for inventory exception reporting and automated procurement triggers.',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Quantity of material reserved for specific work orders, CAPEX projects, or planned maintenance activities. Reserved stock is committed but not yet issued. Backed by material_reservation transactions.',
    `safety_stock` DECIMAL(18,2) COMMENT 'Minimum buffer stock level maintained to protect against demand variability and supply disruptions. Safety stock is not intended for normal consumption and breach indicates critical shortage risk. Critical for storm restoration materials and generation spare parts.',
    `safety_stock_breach_flag` BOOLEAN COMMENT 'Boolean indicator that the current unrestricted stock quantity has fallen below the safety stock threshold. True indicates critical shortage condition requiring immediate attention. Triggers escalated replenishment and potential emergency procurement.',
    `special_stock_indicator` STRING COMMENT 'Indicator for special stock types that require separate tracking. Project = stock allocated to specific CAPEX projects; sales_order = stock for specific customer orders; consignment = vendor-owned stock; returnable_packaging = containers/pallets; pipeline = in-transit between locations; subcontractor = stock at contractor site; none = standard stock. [ENUM-REF-CANDIDATE: project|sales_order|consignment|returnable_packaging|pipeline|subcontractor|none — 7 candidates stripped; promote to reference product]',
    `standard_cost_per_unit` DECIMAL(18,2) COMMENT 'Standard cost per unit of measure for this material. Used for inventory valuation when standard costing method is applied. Represents the planned or budgeted cost per unit. Confidential business financial data.',
    `stock_determination_group` STRING COMMENT 'Four-character code used for automatic stock determination logic in goods issue processes. Groups materials with similar characteristics for automated picking and allocation rules.. Valid values are `^[A-Z0-9]{4}$`',
    `stock_status` STRING COMMENT 'Current operational status of the stock position. Available = normal stock levels; low_stock = below reorder point; out_of_stock = zero unrestricted quantity; excess = above maximum level; obsolete = material no longer used; inactive = location no longer stocking this material.. Valid values are `available|low_stock|out_of_stock|excess|obsolete|inactive`',
    `stock_type` STRING COMMENT 'High-level categorization of stock ownership and purpose. Own = utility-owned unrestricted stock; consignment = vendor-owned stock at utility location; returnable_packaging = containers requiring return; project = stock allocated to specific projects.. Valid values are `own|consignment|returnable_packaging|project`',
    `storage_location_code` STRING COMMENT 'Four-character alphanumeric code identifying the specific storage location within the warehouse (e.g., bin, aisle, zone). Used for physical inventory management and picking operations.. Valid values are `^[A-Z0-9]{4}$`',
    `total_inventory_valuation_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the unrestricted stock quantity at this location, calculated as unrestricted_stock_quantity multiplied by the applicable cost per unit (standard or moving average). Used for balance sheet reporting and working capital analysis. Confidential business financial data.',
    `unit_of_measure` STRING COMMENT 'Base unit of measure for all quantity fields in this stock position record (e.g., EA for each, FT for feet, GAL for gallons, TON for tons). Aligns with the material master base UOM.. Valid values are `^[A-Z]{2,3}$`',
    `unrestricted_stock_quantity` DECIMAL(18,2) COMMENT 'Quantity of material available for unrestricted use and issue. This is the freely available stock that can be issued to work orders, projects, or consumption without restrictions. Measured in the material base unit of measure (UOM).',
    `valuation_currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this record (standard cost, moving average cost, total valuation). Typically USD for US-based utilities.. Valid values are `^[A-Z]{3}$`',
    CONSTRAINT pk_inventory_stock PRIMARY KEY(`inventory_stock_id`)
) COMMENT 'Real-time and period-end inventory stock position for materials held at utility warehouses, field storerooms, and generation plant stores. Tracks material reference (linked to material_master), storage location (linked to warehouse), unrestricted stock quantity, quality inspection stock, blocked stock, in-transit stock, reserved quantity (backed by material_reservation transactions), issued quantity (backed by goods_issue transactions), consignment stock, reorder point breach flag, safety stock breach flag, last physical inventory count date, and inventory valuation amount at standard or moving average cost. Supports O&M spare parts availability, storm restoration pre-positioning, CAPEX project material staging, and year-end physical inventory reconciliation. Sourced from SAP S/4HANA MM inventory management (MARD/MSKU/MBEW). Stock position is updated by goods_receipt (increase), goods_issue (decrease), stock_transfer (rebalance), and material_reservation (commitment).';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`warehouse` (
    `warehouse_id` BIGINT COMMENT 'Unique identifier for the warehouse facility. Primary key for the warehouse master record.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Warehouses storing hazmat or PCB equipment must track facility-level compliance obligations (EPA storage permits, fire codes, OSHA safety requirements). Real process: facility compliance audits and pe',
    `address_line_1` STRING COMMENT 'Primary street address of the warehouse facility including street number and name. Organizational contact data classified as confidential business information.',
    `address_line_2` STRING COMMENT 'Secondary address information such as building number, suite, or unit designation. Organizational contact data classified as confidential business information.',
    `backup_power_available` BOOLEAN COMMENT 'Indicates whether the warehouse facility has backup power generation capability (e.g., diesel generator, battery storage) to maintain operations during grid outages. Critical for facilities supporting emergency restoration.',
    `building_year` STRING COMMENT 'Year the warehouse facility was originally constructed. Used for asset age analysis and maintenance planning.',
    `city` STRING COMMENT 'City or municipality where the warehouse facility is located. Organizational contact data classified as confidential business information.',
    `climate_controlled` BOOLEAN COMMENT 'Indicates whether the warehouse facility has climate control capabilities (heating, ventilation, and air conditioning) required for temperature-sensitive materials and equipment.',
    `contact_email` STRING COMMENT 'Primary email address for warehouse facility communications. Organizational contact data classified as confidential business information.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary contact phone number for the warehouse facility. Organizational contact data classified as confidential business information.. Valid values are `^+?[0-9]{10,15}$`',
    `cost_center_code` STRING COMMENT 'Financial cost center code for tracking Operating Expenditure (OPEX) and Capital Expenditure (CAPEX) associated with warehouse operations. Used for financial reporting and budget management.. Valid values are `^[A-Z0-9]{6,12}$`',
    `country_code` STRING COMMENT 'Three-letter ISO country code where the warehouse facility is located.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse facility record was first created in the system. Used for data lineage and audit trail purposes.',
    `effective_end_date` DATE COMMENT 'Date when the warehouse facility ceased operations or was decommissioned. Null for currently active facilities.',
    `effective_start_date` DATE COMMENT 'Date when the warehouse facility became operational and available for material storage and distribution.',
    `facility_type` STRING COMMENT 'Classification of the warehouse facility based on its operational purpose and scope. Central warehouses serve as primary distribution hubs, field storerooms support local Transmission and Distribution (T&D) operations, generation plant stores support power plant Operations and Maintenance (O&M), mobile storm units provide emergency restoration logistics, and yards support outdoor equipment staging.. Valid values are `central_warehouse|field_storeroom|generation_plant_store|mobile_storm_unit|distribution_yard|transmission_yard`',
    `fire_suppression_system` STRING COMMENT 'Type of fire suppression system installed in the warehouse facility. Required for insurance compliance and Occupational Safety and Health Administration (OSHA) safety standards.. Valid values are `sprinkler|foam|gas|none`',
    `hazmat_certification_expiry_date` DATE COMMENT 'Expiration date of the hazardous materials storage certification. Facilities must maintain current certification to store regulated substances.',
    `hazmat_certification_number` STRING COMMENT 'Official certification number issued by regulatory authority for hazardous materials storage. Required for facilities storing regulated substances under Pipeline and Hazardous Materials Safety Administration (PHMSA) and Occupational Safety and Health Administration (OSHA) regulations.',
    `hazmat_certified` BOOLEAN COMMENT 'Indicates whether the warehouse facility is certified for storage of hazardous materials including transformer oil, sulfur hexafluoride (SF6), and other regulated substances. Certification required by Pipeline and Hazardous Materials Safety Administration (PHMSA) and Occupational Safety and Health Administration (OSHA).',
    `inventory_system_code` STRING COMMENT 'Code identifying the inventory management system or Warehouse Management System (WMS) used at this facility. Supports integration with Enterprise Resource Planning (ERP) systems (SAP S/4HANA or Oracle ERP Cloud) for procurement-to-pay processes.',
    `last_renovation_year` STRING COMMENT 'Year of the most recent major renovation or upgrade to the warehouse facility. Used for asset condition assessment and capital planning.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse facility record was most recently modified. Used for data lineage and change tracking.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude coordinate of the warehouse facility in decimal degrees. Used for Geographic Information System (GIS) mapping, logistics routing, and storm restoration planning. Integrates with ESRI ArcGIS for spatial analysis.',
    `lease_expiry_date` DATE COMMENT 'Expiration date of the lease agreement for leased warehouse facilities. Used for contract management and facility planning. Null for owned facilities.',
    `loading_docks` STRING COMMENT 'Number of loading docks available at the warehouse facility for receiving and shipping materials. Used for logistics capacity planning and delivery scheduling.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude coordinate of the warehouse facility in decimal degrees. Used for Geographic Information System (GIS) mapping, logistics routing, and storm restoration planning. Integrates with ESRI ArcGIS for spatial analysis.',
    `manager_name` STRING COMMENT 'Name of the individual responsible for day-to-day operations of the warehouse facility. Business reference, not direct Personally Identifiable Information (PII).',
    `operating_hours` STRING COMMENT 'Standard operating hours for the warehouse facility (e.g., Monday-Friday 7:00 AM - 5:00 PM). Used for logistics planning and material delivery scheduling.',
    `operational_status` STRING COMMENT 'Current operational state of the warehouse facility. Active facilities are fully operational, inactive facilities are temporarily closed, seasonal facilities operate during specific periods (e.g., storm season), under construction facilities are being built or renovated, and decommissioned facilities are permanently closed.. Valid values are `active|inactive|seasonal|under_construction|decommissioned`',
    `ownership_type` STRING COMMENT 'Classification of warehouse facility ownership. Owned facilities are utility-owned assets, leased facilities are under rental agreements, and third-party logistics facilities are operated by external vendors. Impacts financial reporting and Capital Expenditure (CAPEX) versus Operating Expenditure (OPEX) classification.. Valid values are `owned|leased|third_party_logistics`',
    `pallet_positions` STRING COMMENT 'Number of standard pallet positions available in the warehouse facility. Used for inventory capacity planning and material staging for Capital Expenditure (CAPEX) projects and storm restoration.',
    `postal_code` STRING COMMENT 'Postal or ZIP code for the warehouse facility address. Organizational contact data classified as confidential business information.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `responsible_plant_code` STRING COMMENT 'Code identifying the organizational plant or operating unit responsible for managing the warehouse facility. Used for cost allocation and operational accountability in Enterprise Resource Planning (ERP) systems.. Valid values are `^[A-Z0-9]{4,10}$`',
    `security_level` STRING COMMENT 'Physical security classification of the warehouse facility. Standard facilities have basic access controls, enhanced facilities have additional monitoring and restricted access, and critical infrastructure facilities have maximum security measures required by North American Electric Reliability Corporation (NERC) Critical Infrastructure Protection (CIP) standards.. Valid values are `standard|enhanced|critical_infrastructure`',
    `state_province` STRING COMMENT 'Two-letter state or province code where the warehouse facility is located. Uses standard postal abbreviations.. Valid values are `^[A-Z]{2}$`',
    `storage_capacity_sqft` DECIMAL(18,2) COMMENT 'Total indoor storage capacity of the warehouse facility measured in square feet. Used for capacity planning and inventory allocation decisions.',
    `storm_staging_capable` BOOLEAN COMMENT 'Indicates whether the warehouse facility is designated and equipped for pre-positioning materials and equipment for storm restoration events. Critical for emergency response planning and System Average Interruption Duration Index (SAIDI) performance.',
    `twenty_four_seven_access` BOOLEAN COMMENT 'Indicates whether the warehouse facility provides 24-hour, 7-day-per-week access for emergency storm restoration and critical outage response. Essential for Outage Management System (OMS) integration and Demand Response (DR) program support.',
    `warehouse_name` STRING COMMENT 'Official name of the warehouse facility used for identification and reporting purposes.',
    `warehouse_number` STRING COMMENT 'Business identifier for the warehouse facility used in operational systems and documentation. Typically assigned by Enterprise Resource Planning (ERP) system (SAP S/4HANA or Oracle ERP Cloud) for procurement and inventory management.. Valid values are `^[A-Z0-9]{4,12}$`',
    `yard_storage_available` BOOLEAN COMMENT 'Indicates whether the warehouse facility has outdoor yard storage for large Transmission and Distribution (T&D) equipment such as transformers, poles, and cable reels.',
    `yard_storage_capacity_sqft` DECIMAL(18,2) COMMENT 'Total outdoor yard storage capacity measured in square feet. Used for planning storage of large Transmission and Distribution (T&D) equipment and Capital Expenditure (CAPEX) project materials.',
    CONSTRAINT pk_warehouse PRIMARY KEY(`warehouse_id`)
) COMMENT 'Master record for all utility warehouse facilities, field storerooms, and generation plant stores used for material storage and distribution. Captures warehouse number, warehouse name, facility type (central warehouse, field storeroom, generation plant store, mobile storm unit), physical address, GIS coordinates, storage capacity (sq ft, pallet positions), climate control capability, hazmat storage certification, responsible plant code, and operational status. Supports logistics planning for T&D equipment staging and storm restoration pre-positioning.';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`stock_transfer` (
    `stock_transfer_id` BIGINT COMMENT 'Unique identifier for the stock transfer transaction. Primary key for the stock transfer record.',
    `capex_project_id` BIGINT COMMENT 'Identifier of the capital project for which material is being transferred. Links stock transfers to CAPEX construction projects for Work in Progress (WIP) tracking and Allowance for Funds Used During Construction (AFUDC) capitalization.',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_event. Business justification: Transfers of hazmat or regulated materials may trigger compliance events (spills during transport, improper handling, documentation violations). Real process: incident tracking for EPA and DOT reporti',
    `material_master_id` BIGINT COMMENT 'Identifier of the material master record being transferred. References the specific item, equipment, fuel, or supply being moved between locations.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Utilities track individual serialized meter movements between warehouses for asset accountability, especially during storm staging, mutual aid operations, and regional inventory balancing. Critical fo',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or storage location to which material is being transferred. References the destination facility in the utility supply network.',
    `sending_warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or storage location from which material is being transferred. References the originating facility in the utility supply network.',
    `work_order_id` BIGINT COMMENT 'Identifier of the maintenance or construction work order for which material is being transferred. Links stock transfers to preventive maintenance, corrective maintenance, or emergency restoration work orders in Oracle WAM or IBM Maximo.',
    `actual_receipt_date` DATE COMMENT 'Date on which material was physically received at the destination location. Captures the actual goods receipt date for inventory reconciliation and completion tracking.',
    `actual_shipment_date` DATE COMMENT 'Date on which material was physically shipped or issued from the sending location. Captures the actual goods movement date for inventory and logistics tracking.',
    `batch_number` STRING COMMENT 'Batch or lot number of the material being transferred. Enables traceability for quality control, warranty tracking, and recall management of generation plant consumables and T&D equipment.',
    `carrier_name` STRING COMMENT 'Name of the transportation carrier or logistics provider handling the material movement. May be internal utility fleet or external common carrier.',
    `cost_center_code` STRING COMMENT 'Cost center to which the transfer transaction is charged. Used for internal cost allocation and departmental expense tracking for O&M material movements.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the stock transfer record was first created in the system. Audit timestamp for record creation tracking.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation amount. Typically USD for US-based utilities but supports multi-currency operations for international utilities.. Valid values are `^[A-Z]{3}$`',
    `issuing_person_name` STRING COMMENT 'Name of the utility employee who issued the material from the sending location. Provides accountability for goods issue and inventory control.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the stock transfer record was last updated. Audit timestamp for tracking changes to transfer status, quantities, or other attributes.',
    `movement_type` STRING COMMENT 'SAP movement type code classifying the nature of the stock transfer. 301=plant-to-plant transfer in one step, 311=storage-location-to-storage-location transfer within same plant, 303=plant-to-plant transfer in two steps (issue from sending plant), 305=plant-to-plant transfer receipt, 309=material-to-material transfer.. Valid values are `301|311|303|305|309`',
    `mutual_aid_reference` STRING COMMENT 'Reference number for inter-utility mutual aid material loans during major storm events or emergencies. Tracks material borrowed from or loaned to neighboring utilities for Federal Emergency Management Agency (FEMA) reimbursement documentation.',
    `mutual_aid_utility_name` STRING COMMENT 'Name of the external utility involved in the mutual aid material transfer. Identifies the lending or borrowing utility for inter-utility material loan tracking and settlement.',
    `priority_level` STRING COMMENT 'Priority classification for the stock transfer. Emergency and critical priorities are used for storm restoration material deployments and generation plant critical consumable replenishment.. Valid values are `routine|urgent|emergency|critical`',
    `receipt_timestamp` TIMESTAMP COMMENT 'Precise date and time when material was received at the destination warehouse. Enables calculation of transit time and supports real-time inventory visibility.',
    `receiving_person_name` STRING COMMENT 'Name of the utility employee who physically received the material at the destination location. Provides accountability for goods receipt and inventory control.',
    `receiving_plant_code` STRING COMMENT 'ERP plant code for the destination facility. Identifies the generation plant, service center, or operational facility to which material is being transferred.',
    `receiving_storage_location` STRING COMMENT 'Storage location code within the receiving plant or warehouse. Identifies the specific storeroom, bin, or inventory zone where material will be received.',
    `requested_transfer_date` DATE COMMENT 'Date on which the material transfer was requested or scheduled to occur. Represents the planned transfer date for logistics planning and coordination.',
    `reversal_document_number` STRING COMMENT 'Document number of the reversal transaction if this stock transfer was reversed. Links to the correcting entry for audit trail and inventory reconciliation.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this stock transfer has been reversed or cancelled. True if the transfer was reversed due to error correction or material return.',
    `sending_plant_code` STRING COMMENT 'ERP plant code for the originating facility. Identifies the generation plant, service center, or operational facility from which material is being transferred.',
    `sending_storage_location` STRING COMMENT 'Storage location code within the sending plant or warehouse. Identifies the specific storeroom, bin, or inventory zone from which material is issued.',
    `serial_number` STRING COMMENT 'Serial number of the specific material unit being transferred. Used for high-value serialized assets such as transformers, meters, or specialized equipment requiring individual tracking.',
    `shipment_timestamp` TIMESTAMP COMMENT 'Precise date and time when material was issued from the sending warehouse. Provides granular tracking for time-sensitive transfers such as storm restoration emergency deployments.',
    `shipping_document_number` STRING COMMENT 'Reference number of the shipping document or bill of lading accompanying the material transfer. Used for carrier tracking and proof of shipment.',
    `storm_event_reference` STRING COMMENT 'Reference identifier for the storm or emergency event driving the stock transfer. Links emergency material pre-positioning and deployment to specific named storms or major outage events for restoration cost tracking.',
    `transfer_notes` STRING COMMENT 'Free-text notes or comments regarding the stock transfer. Captures special handling instructions, condition observations, or other relevant information for logistics and receiving personnel.',
    `transfer_order_number` STRING COMMENT 'Business identifier for the stock transfer order. Externally-known reference number used in SAP S/4HANA or Oracle ERP for tracking material movements between locations.',
    `transfer_quantity` DECIMAL(18,2) COMMENT 'Quantity of material being transferred from sending to receiving location. Measured in the unit of measure specified for the material.',
    `transfer_reason_code` STRING COMMENT 'Code indicating the business reason for the stock transfer. Examples include stock balancing, project material allocation, emergency restoration, planned maintenance support, or mutual aid deployment.',
    `transfer_status` STRING COMMENT 'Current lifecycle status of the stock transfer. Tracks progression from order creation through shipment, receipt, and completion or cancellation.. Valid values are `open|in-transit|received|completed|cancelled`',
    `transport_mode` STRING COMMENT 'Method of transportation used for the stock transfer. Includes utility-owned vehicles, third-party carriers, emergency air transport for storm restoration, and mutual aid logistics.. Valid values are `company-truck|common-carrier|emergency-helicopter|rail|barge|mutual-aid-vehicle`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the transfer quantity. Examples include EA (each), FT (feet), GAL (gallons), TON (tons), KWH (kilowatt-hours), MCF (thousand cubic feet), or other standard utility material units.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the material being transferred. Calculated based on material standard cost or moving average price for financial inventory accounting and CAPEX project material tracking.',
    CONSTRAINT pk_stock_transfer PRIMARY KEY(`stock_transfer_id`)
) COMMENT 'Transactional record for inter-plant and inter-warehouse material movements within the utilitys supply network. Covers transfers between central warehouse and field storerooms, storm restoration emergency stock pre-positioning and deployment, generation plant consumable replenishment, and mutual aid material loans to/from neighboring utilities during major events. Captures transfer order number, sending warehouse (FK to warehouse), receiving warehouse (FK to warehouse), material reference (FK to material_master), transfer quantity, unit of measure, movement type (301 plant-to-plant transfer, 311 storage-location-to-storage-location transfer, 303 plant-to-plant in two steps), transport mode (company truck, common carrier, emergency helicopter), carrier name, requested transfer date, actual shipment date, actual receipt date, completion status (open, in-transit, received, cancelled), and mutual aid tracking reference for inter-utility loans. Enables real-time visibility into material logistics across the utility service territory and supports FEMA reimbursement documentation for storm restoration material movements.';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`purchase_requisition` (
    `purchase_requisition_id` BIGINT COMMENT 'Unique identifier for the purchase requisition record. Primary key for the purchase requisition entity.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Purchase requisitions originate from cost centers and require cost center manager approval against budget. First step in budget authorization workflow, essential for budget control and procurement aut',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Requisitions specify GL accounts for budget checking and eventual posting. Required for validating budget availability at requisition stage and ensuring proper account coding flows through to PO and i',
    `material_master_id` BIGINT COMMENT 'Reference to the cataloged material master record for standard inventory items. Populated for requisitions requesting materials from the enterprise material catalog. Null for non-catalog or free-text service requisitions.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: Purchase requisitions can reference existing procurement contracts for pricing and vendor selection. Currently denormalized as contract_reference_number (STRING). Adding procurement_contract_id FK ena',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order that was created from this requisition after approval. Null if the requisition has not yet been converted to a PO or was cancelled.',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who created the requisition. Links to the human capital management system for organizational hierarchy and approval routing.. Valid values are `^[A-Z0-9]{6,10}$`',
    `vendor_id` BIGINT COMMENT 'Suggested or assigned vendor for fulfilling this requisition. May be pre-populated by the requester based on preferred supplier relationships or assigned by the purchasing group during PO creation.',
    `approval_date` DATE COMMENT 'Date on which the requisition received final approval and became eligible for conversion to a purchase order. Null if not yet approved.',
    `approval_workflow_code` STRING COMMENT 'Identifier for the approval workflow instance routing this requisition through the release strategy. Tracks the multi-level approval process based on requisition value thresholds and organizational hierarchy.. Valid values are `^[A-Z0-9]{10,20}$`',
    `approved_by_name` STRING COMMENT 'Name of the manager or authorized approver who granted final approval for the requisition. Null if requisition is still pending approval or was rejected.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the purchase requisition record was first created in the system. Represents the initiation of the procurement demand.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the estimated price and total value. Typically USD for US-based utility operations.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `estimated_total_value` DECIMAL(18,2) COMMENT 'Total estimated value of the requisition line, calculated as requested quantity multiplied by estimated unit price. Used for approval threshold determination and budget commitment.',
    `estimated_unit_price` DECIMAL(18,2) COMMENT 'Estimated or budgeted price per unit of measure for the requested item or service. Used for budget validation and purchase order creation. May be based on historical pricing, catalog rates, or requester estimate.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the requisition record. Tracks changes to quantity, delivery date, status, or other requisition attributes during the approval and procurement workflow.',
    `plant_code` STRING COMMENT 'SAP plant code representing the physical location or operational facility where the material or service will be delivered and used. May represent a generation plant, service center, warehouse, or district office.. Valid values are `^[A-Z0-9]{4,6}$`',
    `po_conversion_date` DATE COMMENT 'Date on which the approved requisition was converted into a purchase order by the purchasing group. Marks the transition from internal demand to external vendor commitment.',
    `priority_indicator` STRING COMMENT 'Urgency classification for the requisition. Normal for standard procurement lead times, urgent for expedited processing, emergency for immediate operational needs (e.g., equipment failure), critical for safety or regulatory compliance requirements.. Valid values are `normal|urgent|emergency|critical`',
    `purchasing_group` STRING COMMENT 'Buyer or purchasing group code assigned to process this requisition and convert it to a purchase order. Represents the procurement team responsible for sourcing, vendor selection, and contract negotiation.. Valid values are `^[A-Z0-9]{3,6}$`',
    `rejection_reason` STRING COMMENT 'Free-text explanation for why the requisition was rejected during the approval workflow. Captures business justification for denial such as budget unavailability, duplicate request, or insufficient justification.',
    `requested_quantity` DECIMAL(18,2) COMMENT 'Quantity of material or service units requested in this requisition line. Expressed in the unit of measure specified in the unit_of_measure field.',
    `requester_department` STRING COMMENT 'Organizational department or functional area of the requester. Examples include Generation Operations, Transmission Maintenance, Distribution Field Services, Gas Operations, or Capital Projects.',
    `requester_name` STRING COMMENT 'Name of the employee or contractor who created the purchase requisition. Typically a field operations supervisor, maintenance planner, project manager, or generation plant staff member.',
    `required_delivery_date` DATE COMMENT 'Date by which the requested material or service must be delivered to meet operational or project schedule requirements. Used for procurement planning and vendor lead time evaluation.',
    `requisition_notes` STRING COMMENT 'Free-text notes and comments providing additional context, special instructions, or business justification for the requisition. May include technical specifications, delivery instructions, or project background.',
    `requisition_number` STRING COMMENT 'Business identifier for the purchase requisition document. Externally visible requisition number used for tracking and reference in procurement workflows.. Valid values are `^[A-Z0-9]{10,20}$`',
    `requisition_status` STRING COMMENT 'Current lifecycle state of the purchase requisition in the approval and procurement workflow. Tracks progression from initial creation through approval gates to conversion into a purchase order or rejection. [ENUM-REF-CANDIDATE: created|pending_approval|approved|rejected|converted_to_po|cancelled|on_hold — 7 candidates stripped; promote to reference product]',
    `requisition_type` STRING COMMENT 'Classification of the purchase requisition based on the nature of the procurement request. Standard material for cataloged inventory items, service for contracted labor or professional services, fuel for generation plant coal/gas/oil purchases, emergency for urgent unplanned needs, storm restoration for outage recovery materials, and capital project for CAPEX-funded equipment and construction materials.. Valid values are `standard_material|service|fuel|emergency|storm_restoration|capital_project`',
    `storage_location_code` STRING COMMENT 'Storage location within the plant where the material will be received and stocked. Represents a warehouse, yard, or inventory staging area. Applicable only for material requisitions, not services.. Valid values are `^[A-Z0-9]{4,6}$`',
    `unit_of_measure` STRING COMMENT 'Standard unit of measure for the requested quantity. EA for each/piece, FT for feet of cable or pipe, GAL for gallons of liquid, LB for pounds, TON for tons of coal or equipment weight, KWH/MWH for energy, MCF/THERM for natural gas, HR/DAY for service labor time. [ENUM-REF-CANDIDATE: EA|FT|GAL|LB|TON|KWH|MWH|MCF|THERM|HR|DAY|EACH — 12 candidates stripped; promote to reference product]',
    `wbs_element` STRING COMMENT 'Work Breakdown Structure element identifier for CAPEX (capital expenditure) project-related requisitions. Links the requisition to a specific capital project phase or deliverable for project cost tracking and AFUDC calculation. Mutually exclusive with cost center for OPEX items.. Valid values are `^[A-Z0-9-.]{8,24}$`',
    CONSTRAINT pk_purchase_requisition PRIMARY KEY(`purchase_requisition_id`)
) COMMENT 'Internal request document initiating the procurement process for materials, equipment, or services before a purchase order is issued. Captures requisition number, requisition type (standard material, service, fuel, emergency/storm), requested material reference (linked to material_master for cataloged items) or free-text description for non-catalog items, quantity, unit of measure, required delivery date, estimated unit price and total value, requesting cost center (OPEX) or WBS element (CAPEX), approval workflow status (created, pending approval, approved, rejected, converted to PO), assigned buyer/purchasing group, priority indicator (normal, urgent, emergency), and conversion-to-PO reference. Supports the procure-to-pay process from demand identification through PO creation in SAP S/4HANA. Originated by field operations, maintenance planners, project managers, and generation plant staff.';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`vendor_invoice` (
    `vendor_invoice_id` BIGINT COMMENT 'Unique identifier for the vendor invoice record. Primary key for the vendor invoice product.',
    `capex_project_id` BIGINT COMMENT 'Reference to the CAPEX project if the invoice is for capital equipment or construction. Used for work-in-progress (WIP) tracking and asset capitalization.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor invoices are charged to cost centers for budget tracking, variance analysis, and departmental cost allocation. Essential for monthly budget-to-actual reporting and cost center manager accountab',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Capital project invoices under regulatory review must be linked to rate case or CPCN dockets. Prudency reviews examine actual costs vs. estimates. Invoices are evidence in cost recovery proceedings.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Every vendor invoice posts to a GL account per GAAP and FERC accounting requirements. Required for financial statement preparation, FERC Form 1/2 reporting, and audit trail from invoice to general led',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Vendor invoices must link to goods receipts for 3-way match (PO → GR → Invoice). Currently denormalized as delivery_note_number (STRING). Adding goods_receipt_id FK enables automated 3-way matching, q',
    `purchase_order_id` BIGINT COMMENT 'Reference to the purchase order against which this invoice is being verified. Required for three-way match (PO-GR-Invoice).',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor master record from whom materials, equipment, fuel, or services were procured.',
    `work_order_id` BIGINT COMMENT 'Reference to the maintenance or construction work order if the invoice is for services or materials related to asset maintenance or project work.',
    `approval_date` DATE COMMENT 'Date the invoice was approved for payment. Marks completion of invoice verification and approval workflow.',
    `approver_name` STRING COMMENT 'Name of the person who approved the invoice for payment. Used for audit trail and accountability.',
    `company_code` STRING COMMENT 'Company code representing the legal entity within the utility that is responsible for this invoice. Used for multi-entity financial consolidation.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor invoice record was first created in the system. Used for audit trail and data lineage.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the invoice amount. Typically USD for domestic US utility operations.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Cash discount or early payment discount amount available if payment is made within discount period.',
    `document_date` DATE COMMENT 'Date the invoice document was received by the utility. Used for document control and audit trail.',
    `duplicate_invoice_flag` BOOLEAN COMMENT 'Flag indicating whether this invoice has been identified as a potential duplicate of a previously processed invoice. True if duplicate detected.',
    `fi_document_number` STRING COMMENT 'SAP FI document number assigned when the invoice is posted to the general ledger. Links invoice to financial accounting entries.',
    `fiscal_period` STRING COMMENT 'Fiscal period (month) within the fiscal year when the invoice was posted. Typically 1-12 for monthly periods.',
    `fiscal_year` STRING COMMENT 'Fiscal year in which the invoice was posted. Used for financial period reporting and year-end closing.',
    `gross_invoice_amount` DECIMAL(18,2) COMMENT 'Total invoice amount before any deductions or adjustments. Includes line item amounts and freight charges.',
    `invoice_date` DATE COMMENT 'Date the vendor issued the invoice. Used for aging analysis and payment term calculation.',
    `invoice_description` STRING COMMENT 'Free-text description of the invoice contents or purpose. Provides additional context for invoice review and approval.',
    `invoice_number` STRING COMMENT 'Vendor-assigned invoice number as printed on the invoice document. Business identifier for external reference and three-way matching.',
    `invoice_status` STRING COMMENT 'Current lifecycle status of the vendor invoice in the accounts payable workflow. [ENUM-REF-CANDIDATE: pending|approved|blocked|posted|paid|cancelled|disputed — 7 candidates stripped; promote to reference product]',
    `invoice_type` STRING COMMENT 'Classification of the invoice document type. Determines accounting treatment and workflow.. Valid values are `standard|credit_memo|debit_memo|prepayment|down_payment|final_invoice`',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor invoice record was last updated. Tracks changes for audit and data quality monitoring.',
    `net_invoice_amount` DECIMAL(18,2) COMMENT 'Net payable amount after applying taxes, discounts, and adjustments. Amount to be paid to vendor.',
    `payment_block_indicator` BOOLEAN COMMENT 'Flag indicating whether payment is blocked pending resolution of discrepancies or approval. True if payment is blocked.',
    `payment_block_reason` STRING COMMENT 'Reason code or description explaining why payment is blocked (e.g., price variance, quantity variance, missing approval, duplicate invoice).',
    `payment_date` DATE COMMENT 'Actual date payment was made to the vendor. Used for cash flow reporting and vendor payment history.',
    `payment_due_date` DATE COMMENT 'Date by which payment is due to the vendor per payment terms. Calculated from invoice date plus payment term days.',
    `payment_method` STRING COMMENT 'Method by which payment will be made to the vendor. Determines payment processing workflow.. Valid values are `ach|wire_transfer|check|credit_card|procurement_card`',
    `payment_reference_number` STRING COMMENT 'Payment document number or check number assigned when payment is executed. Links invoice to payment transaction.',
    `payment_terms_code` STRING COMMENT 'Code representing the payment terms agreed with the vendor (e.g., Net 30, 2/10 Net 30). Determines due date and discount eligibility.',
    `plant_code` STRING COMMENT 'Plant or facility code where the materials or services were received. Links invoice to operational location.',
    `posting_date` DATE COMMENT 'Date the invoice was posted to the financial accounting ledger. Determines the fiscal period for financial reporting.',
    `reversal_document_number` STRING COMMENT 'FI document number of the reversal document if this invoice was reversed. Links to the reversing entry.',
    `reversal_indicator` BOOLEAN COMMENT 'Flag indicating whether this invoice has been reversed or cancelled. True if invoice was reversed.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax amount charged on the invoice. Includes sales tax, use tax, and other applicable taxes.',
    `three_way_match_status` STRING COMMENT 'Result of the three-way match verification comparing purchase order, goods receipt, and invoice. Indicates whether invoice can be approved for payment.. Valid values are `matched|quantity_variance|price_variance|not_matched|bypassed`',
    `vendor_reference_number` STRING COMMENT 'Vendors internal reference number or order confirmation number cited on the invoice. Used for vendor inquiry and dispute resolution.',
    `withholding_tax_amount` DECIMAL(18,2) COMMENT 'Amount of withholding tax deducted from vendor payment per tax regulations. Reduces net payment to vendor.',
    CONSTRAINT pk_vendor_invoice PRIMARY KEY(`vendor_invoice_id`)
) COMMENT 'Transactional record for vendor invoices received for materials, equipment, fuel, and services procured by the utility. Captures invoice number, vendor reference, invoice date, posting date, gross invoice amount, tax amount, currency, payment due date, three-way match status (PO–GR–invoice), payment block reason, and SAP FI document number. Drives accounts payable processing and supports CAPEX/OPEX cost allocation. Distinct from customer-facing invoices owned by the billing domain.';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`fuel_delivery` (
    `fuel_delivery_id` BIGINT COMMENT 'Unique identifier for the fuel delivery transaction. Primary key for the fuel delivery record.',
    `compliance_event_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_event. Business justification: Fuel quality violations, delivery incidents, and sulfur/ash content exceedances are compliance events. Real-world process: tracking fuel specification violations and environmental incidents at generat',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Fuel deliveries are charged to generation plant cost centers for fuel expense tracking and heat rate analysis. Essential for generation cost accounting, FERC Form 1 fuel statistics, and plant-level pr',
    `emissions_report_id` BIGINT COMMENT 'Foreign key linking to regulatory.emissions_report. Business justification: Fuel deliveries are source data for emissions calculations. BTU content, sulfur content, and quantity delivered feed directly into EPA emissions reports. Essential for CEMS data validation and quarter',
    `fuel_contract_id` BIGINT COMMENT 'Reference to the master fuel supply contract governing this delivery. Links to the contract that defines pricing, terms, and delivery obligations.',
    `plant_id` BIGINT COMMENT 'Reference to the generation facility receiving the fuel delivery. Identifies the power plant site where fuel is delivered.',
    `fuel_plant_id` BIGINT COMMENT 'FK to generation.plant.plant_id — Traces fuel deliveries to generation facilities — required for fuel cost allocation, FAC cost recovery filings, and fuel inventory reconciliation at each plant.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Fuel deliveries post to fuel inventory or fuel expense GL accounts per FERC Uniform System of Accounts (Account 151 for inventory, 501 for expense). Required for regulatory reporting and financial sta',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Fuel deliveries are executed against purchase orders. Currently denormalized as purchase_order_number (STRING). Adding purchase_order_id FK enables proper linkage to PO terms, pricing, and vendor. Rem',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or transporter master record for the carrier. Links to the supplier managing fuel logistics.',
    `warehouse_id` BIGINT COMMENT 'Foreign key linking to supply.warehouse. Business justification: Fuel deliveries are received at utility warehouses or generation plant fuel storage facilities. The storage_location_code should be normalized to warehouse_id FK. Warehouse table contains storage_loca',
    `ash_content_percent` DECIMAL(18,2) COMMENT 'Percentage of ash residue by weight in coal deliveries. Affects combustion efficiency and waste disposal requirements.',
    `batch_number` STRING COMMENT 'Batch or lot number assigned to the delivered fuel for traceability. Enables tracking of fuel quality and usage by delivery batch.',
    `btu_content` DECIMAL(18,2) COMMENT 'Heat energy content of the delivered fuel measured in BTU per unit. Critical for heat rate calculations and energy conversion efficiency analysis.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when this fuel delivery record was first created in the system. Audit timestamp for record creation.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for all monetary amounts in this delivery record. Typically USD for US utility operations.. Valid values are `USD|CAD|MXN`',
    `delivered_quantity` DECIMAL(18,2) COMMENT 'Physical quantity of fuel delivered in the specified unit of measure. Core measurement for inventory management and billing.',
    `delivery_date` DATE COMMENT 'Calendar date when the fuel was physically delivered to the generation plant site. Principal business event date for the transaction.',
    `delivery_notes` STRING COMMENT 'Free-text comments or special instructions related to the fuel delivery. Captures operational details, exceptions, or delivery conditions.',
    `delivery_point_code` STRING COMMENT 'Specific location identifier within the generation plant where fuel was delivered. May reference a storage tank, pipeline tie-in, or receiving dock.',
    `delivery_point_description` STRING COMMENT 'Human-readable description of the physical delivery location within the plant site. Provides operational context for the delivery point code.',
    `delivery_status` STRING COMMENT 'Current lifecycle state of the fuel delivery transaction. Tracks the delivery from scheduling through final acceptance or rejection.. Valid values are `scheduled|in_transit|delivered|accepted|rejected|disputed`',
    `delivery_ticket_number` STRING COMMENT 'External delivery ticket or bill of lading number issued by the carrier or transporter. Serves as the business identifier for the physical delivery event.',
    `delivery_timestamp` TIMESTAMP COMMENT 'Precise date and time when the fuel delivery was completed and accepted at the plant. Used for time-of-delivery pricing and scheduling reconciliation.',
    `environmental_compliance_flag` BOOLEAN COMMENT 'Indicates whether the delivered fuel meets environmental quality standards and emissions compliance requirements. True if compliant with EPA and state regulations.',
    `fuel_type` STRING COMMENT 'Classification of the fuel commodity delivered. Categorizes the energy source type for generation operations.. Valid values are `natural_gas|coal|fuel_oil|diesel|nuclear_fuel|biomass`',
    `heat_rate_mmbtu_per_unit` DECIMAL(18,2) COMMENT 'Million BTU per unit of measure for the delivered fuel. Used in generation efficiency calculations and Fuel Adjustment Clause (FAC) reporting.',
    `inspection_outcome` STRING COMMENT 'Result of the fuel quality inspection or lab analysis. Determines whether the delivery is accepted for use or rejected for non-conformance.. Valid values are `passed|failed|pending|waived|not_required`',
    `inspection_required_flag` BOOLEAN COMMENT 'Indicates whether quality inspection or lab testing is required before the fuel can be used in generation. True if inspection is mandatory per contract terms.',
    `invoice_number` STRING COMMENT 'Vendor invoice number associated with this fuel delivery. Links the physical delivery to accounts payable processing.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when this fuel delivery record was most recently updated. Audit timestamp for tracking record changes.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Percentage of moisture by weight in solid fuel deliveries. Impacts effective heat content and storage handling requirements.',
    `origin_location` STRING COMMENT 'Geographic source or production location of the delivered fuel. May reference a mine, well field, refinery, or supply basin.',
    `pipeline_receipt_point` STRING COMMENT 'Named receipt point on the natural gas pipeline system where gas entered the utilitys system. Used for gas delivery tracking and tariff application.',
    `quality_certificate_number` STRING COMMENT 'Reference number for the fuel quality assurance certificate or lab analysis report accompanying the delivery. Documents compliance with contract specifications.',
    `receiving_person_name` STRING COMMENT 'Name of the plant operations or warehouse staff member who accepted and verified the fuel delivery on site.',
    `scheduled_delivery_date` DATE COMMENT 'Originally planned or contracted delivery date. Used to track on-time delivery performance and schedule variance.',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'Percentage of sulfur by weight in the delivered fuel. Critical for environmental compliance and emissions calculations under EPA regulations.',
    `total_delivery_cost` DECIMAL(18,2) COMMENT 'Total cost for the fuel delivery including base fuel cost and transportation charges. Represents the complete delivered cost for accounting and rate recovery.',
    `transportation_cost` DECIMAL(18,2) COMMENT 'Separate transportation or freight charges for delivering the fuel to the plant site. May be billed separately from commodity cost.',
    `transporter_duns_number` STRING COMMENT 'Dun & Bradstreet unique identifier for the transportation company. Provides standardized carrier identification for regulatory reporting.',
    `unit_of_measure` STRING COMMENT 'Standard unit used to quantify the delivered fuel. MCF for natural gas, tons for coal, barrels for oil, assemblies for nuclear fuel.. Valid values are `MCF|tons|barrels|gallons|kilograms|assemblies`',
    `unit_price` DECIMAL(18,2) COMMENT 'Contract price per unit of measure for the delivered fuel. Used for invoice validation and Fuel Adjustment Clause (FAC) cost recovery calculations.',
    CONSTRAINT pk_fuel_delivery PRIMARY KEY(`fuel_delivery_id`)
) COMMENT 'Transactional record capturing physical delivery of generation fuel (natural gas, coal, oil, nuclear fuel) to generation plant sites. Records delivery ticket number, fuel type, delivery date and time, delivered quantity (MCF for gas, tons for coal, barrels for oil), unit of measure, BTU content or heat rate, delivery point (plant and tank/pipeline tie-in), carrier/transporter, contract reference, and quality certificate number. Supports fuel inventory management, heat rate calculations, and FAC (Fuel Adjustment Clause) regulatory reporting.';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`vendor_performance` (
    `vendor_performance_id` BIGINT COMMENT 'Unique identifier for the vendor performance evaluation record.',
    `employee_id` BIGINT COMMENT 'Reference to the procurement manager or director who approved the final performance evaluation. Null if not yet approved.',
    `capex_project_id` BIGINT COMMENT 'Reference to the CAPEX project if this is a project-based evaluation for major T&D construction or generation outage work. Null for periodic evaluations.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Contractor safety and environmental performance is tracked against specific OSHA and EPA obligations. Real process: vendor OSHA EMR scores and environmental incidents are evaluated against regulatory ',
    `evaluator_employee_id` BIGINT COMMENT 'Reference to the buyer, contract manager, or procurement specialist who conducted the performance evaluation.',
    `procurement_contract_id` BIGINT COMMENT 'Foreign key linking to supply.procurement_contract. Business justification: Vendor performance evaluations are often conducted at the contract level (e.g., annual fuel supply contract performance review). This FK links the evaluation to the contract being assessed, enabling c',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Vendor performance evaluations can be tied to specific purchase orders (especially for project-based procurement or large capital equipment orders). This enables PO-level performance tracking and link',
    `vendor_id` BIGINT COMMENT 'Reference to the vendor or contractor being evaluated in this performance assessment.',
    `approved_date` DATE COMMENT 'The date on which the performance evaluation was formally approved by management. Null if not yet approved.',
    `bid_evaluation_score_adjustment` DECIMAL(18,2) COMMENT 'Adjustment factor (positive or negative) applied to future bid evaluation scores based on historical performance. High performers receive positive adjustments; poor performers receive negative adjustments.',
    `contract_renewal_recommendation` STRING COMMENT 'Evaluators recommendation regarding contract renewal or continuation based on the performance assessment. Used in contract renewal negotiations.. Valid values are `strongly_recommend|recommend|neutral|not_recommend|terminate`',
    `corrective_action_plan_due_date` DATE COMMENT 'The date by which the vendor must complete the corrective action plan. Null if no CAP is required.',
    `corrective_action_plan_required_flag` BOOLEAN COMMENT 'Indicates whether a corrective action plan (CAP) is required due to performance deficiencies identified in this evaluation. True if CAP is required, False otherwise.',
    `corrective_action_plan_status` STRING COMMENT 'Current status of the corrective action plan if one was required. Tracks whether the vendor has submitted, is implementing, or has completed the required improvements.. Valid values are `not_required|pending|in_progress|completed|overdue`',
    `created_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor performance evaluation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the total spend amount (e.g., USD for US Dollar).. Valid values are `^[A-Z]{3}$`',
    `delivery_weight_percentage` DECIMAL(18,2) COMMENT 'The weighting percentage applied to on-time delivery performance in the overall performance rating calculation. Default is 30.00%.',
    `diversity_spend_percentage` DECIMAL(18,2) COMMENT 'Percentage of the vendors subcontractor spend or workforce that qualifies under the utilitys supplier diversity program (minority-owned, women-owned, veteran-owned, small business). Expressed as a percentage (0.00 to 100.00).',
    `diversity_weight_percentage` DECIMAL(18,2) COMMENT 'The weighting percentage applied to diversity spend performance in the overall performance rating calculation. Default is 10.00%.',
    `emr_score` DECIMAL(18,2) COMMENT 'The Experience Modification Rate (EMR) for the contractor, a multiplier used by insurance companies to price workers compensation premiums. A score of 1.0 is average; below 1.0 indicates better-than-average safety performance; above 1.0 indicates worse-than-average. Critical for field service contractors.',
    `environmental_compliance_incidents` STRING COMMENT 'Count of environmental compliance violations or incidents (spills, emissions exceedances, permit violations) attributed to the vendor during the evaluation period.',
    `evaluation_date` DATE COMMENT 'The date on which the performance evaluation was completed and recorded.',
    `evaluation_notes` STRING COMMENT 'Free-text notes and comments from the evaluator providing additional context, highlighting specific incidents, commendations, or concerns not captured in quantitative metrics.',
    `evaluation_period_end_date` DATE COMMENT 'The end date of the performance evaluation period.',
    `evaluation_period_start_date` DATE COMMENT 'The start date of the performance evaluation period (quarterly, annual, or project-specific).',
    `evaluation_status` STRING COMMENT 'Current workflow status of the performance evaluation record. Tracks progression from draft through approval and finalization.. Valid values are `draft|submitted|approved|disputed|final`',
    `evaluation_type` STRING COMMENT 'The type or frequency of the performance evaluation (quarterly for strategic suppliers, annual for standard vendors, project-based for major T&D construction and generation outage contractors, or contract renewal assessment).. Valid values are `quarterly|annual|project_based|contract_renewal`',
    `evaluator_name` STRING COMMENT 'Full name of the person who conducted the vendor performance evaluation.',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of vendor invoices that were accurate and required no correction or dispute during the evaluation period. Expressed as a percentage (0.00 to 100.00).',
    `invoice_accuracy_weight_percentage` DECIMAL(18,2) COMMENT 'The weighting percentage applied to invoice accuracy performance in the overall performance rating calculation. Default is 10.00%.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'The timestamp when this vendor performance evaluation record was last updated or modified.',
    `material_rejection_rate` DECIMAL(18,2) COMMENT 'Percentage of received materials or services that failed quality inspection and were rejected during the evaluation period. Expressed as a percentage (0.00 to 100.00).',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of purchase orders or deliverables delivered on or before the scheduled delivery date during the evaluation period. Expressed as a percentage (0.00 to 100.00).',
    `osha_recordable_incident_rate` DECIMAL(18,2) COMMENT 'The number of OSHA recordable safety incidents per 200,000 work hours for contractor field crews during the evaluation period. Critical for T&D construction and generation outage contractors.',
    `overall_performance_rating` DECIMAL(18,2) COMMENT 'Weighted overall performance rating on a 1.00 to 5.00 scale, calculated using configurable weighting: 30% delivery, 25% quality, 25% safety, 10% invoice accuracy, 10% diversity. Used for vendor qualification and contract renewal decisions.',
    `preferred_vendor_list_eligible_flag` BOOLEAN COMMENT 'Indicates whether the vendor qualifies for inclusion on the preferred vendor list based on this performance evaluation. True if eligible, False if performance does not meet preferred vendor criteria.',
    `quality_weight_percentage` DECIMAL(18,2) COMMENT 'The weighting percentage applied to quality performance (material rejection rate) in the overall performance rating calculation. Default is 25.00%.',
    `safety_compliance_score` DECIMAL(18,2) COMMENT 'Overall safety compliance score based on adherence to utility safety protocols, completion of required safety training, and audit results. Expressed as a percentage (0.00 to 100.00).',
    `safety_weight_percentage` DECIMAL(18,2) COMMENT 'The weighting percentage applied to safety performance (OSHA rate, EMR, compliance score) in the overall performance rating calculation. Default is 25.00%.',
    `total_purchase_orders_evaluated` STRING COMMENT 'The total number of purchase orders or delivery events included in this performance evaluation period.',
    `total_spend_amount` DECIMAL(18,2) COMMENT 'The total dollar amount spent with this vendor during the evaluation period. Used to weight vendor importance in strategic sourcing decisions.',
    CONSTRAINT pk_vendor_performance PRIMARY KEY(`vendor_performance_id`)
) COMMENT 'Periodic evaluation record tracking vendor and contractor performance against delivery, quality, safety, and compliance KPIs over a defined assessment period. Captures evaluation period (quarterly, annual, or per-project), vendor reference, evaluating buyer or contract manager, on-time delivery rate, material rejection rate, invoice accuracy rate, OSHA recordable incident rate and Experience Modification Rate (EMR) for contractor field crews, safety compliance score, environmental compliance incidents, diversity spend percentage, overall weighted performance rating (1-5 scale with configurable weighting: 30% delivery, 25% quality, 25% safety, 10% invoice accuracy, 10% diversity), corrective action plan status, and preferred vendor list eligibility flag. Supports vendor qualification decisions, contract renewal negotiations, bid evaluation scoring, and supplier diversity program reporting. Evaluated quarterly for strategic suppliers and per-project for major T&D construction and generation outage contractors. Distinct from vendor master (which captures static identity and classification) — this product captures time-series performance measurement.';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`material_reservation` (
    `material_reservation_id` BIGINT COMMENT 'Unique identifier for the material reservation record. Primary key for the material reservation entity.',
    `capex_project_id` BIGINT COMMENT 'Reference to the Capital Expenditure (CAPEX) project for which materials are being reserved. Links to the project master record for Transmission and Distribution (T&D) construction, generation plant upgrades, or other capital investment initiatives.',
    `material_master_id` BIGINT COMMENT 'Reference to the material master record being reserved. Links to the specific material, equipment, spare part, or supply item from inventory that is being allocated for future use.',
    `purchase_requisition_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_requisition. Business justification: Material reservations can be created directly from purchase requisitions before PO conversion (e.g., emergency work orders reserve materials while procurement is in progress). This links the reservati',
    `employee_id` BIGINT COMMENT 'Employee identifier for the person who created the material reservation. Links to the human resources system (SuccessFactors or Workday) for organizational hierarchy and authorization validation.',
    `warehouse_id` BIGINT COMMENT 'Reference to the warehouse master record where the reserved material is physically stored. Links to the warehouse entity for detailed facility information, capacity, and operational attributes.',
    `work_order_id` BIGINT COMMENT 'Reference to the work order for which materials are being reserved. Links to the Enterprise Asset Management (EAM) work order record in Oracle WAM or IBM Maximo that defines the maintenance or operational task requiring these materials.',
    `superseded_material_reservation_id` BIGINT COMMENT 'Self-referencing FK on material_reservation (superseded_material_reservation_id)',
    `batch_number` STRING COMMENT 'Manufacturer batch or lot number for batch-managed materials. Enables traceability for quality control, warranty claims, and regulatory compliance, particularly for critical spare parts, hazardous materials, and generation plant components.',
    `closed_date` DATE COMMENT 'Date when the material reservation was closed and removed from active planning. Set when the reservation status transitions to fully issued or cancelled, marking the end of the reservations operational lifecycle.',
    `cost_center_code` STRING COMMENT 'Financial accounting code identifying the organizational unit or functional area responsible for the costs associated with this material reservation. Used for Operations and Maintenance (O&M) expense allocation and Operating Expenditure (OPEX) tracking when materials are not charged to a Capital Expenditure (CAPEX) project.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the material reservation record was first created in the Enterprise Resource Planning (ERP) system. Audit timestamp capturing the initial transaction event in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation amount. Typically USD for United States-based utility operations, but may vary for international subsidiaries or cross-border procurement.',
    `deletion_indicator` BOOLEAN COMMENT 'Flag marking the reservation for deletion or archival. True when the reservation has been cancelled, superseded, or is no longer needed. Soft-delete flag that preserves the record for audit trail while excluding it from active operational views.',
    `erp_document_number` STRING COMMENT 'Native document identifier from the source Enterprise Resource Planning (ERP) system (SAP S/4HANA or Oracle ERP Cloud). Provides traceability back to the originating system transaction for audit, reconciliation, and support purposes.',
    `final_issue_indicator` BOOLEAN COMMENT 'Flag set by the issuing warehouse or planner to indicate that no additional material will be issued against this reservation, even if the full reserved quantity has not been withdrawn. Used to close reservations when requirements change or work is completed with less material than originally planned.',
    `gl_account_code` STRING COMMENT 'General Ledger (GL) account number to which the material cost will be posted when issued. Determines the financial statement line item and expense or asset category for Generally Accepted Accounting Principles (GAAP) reporting and regulatory rate case cost studies.',
    `goods_issue_completed_flag` BOOLEAN COMMENT 'Indicator that all required material has been issued from inventory against this reservation. True when issued quantity equals or exceeds reserved quantity and no further withdrawals are expected.',
    `issued_quantity` DECIMAL(18,2) COMMENT 'Cumulative quantity of material that has been physically issued from inventory against this reservation. Tracks the amount already withdrawn via goods issue transactions (movement type 261 in SAP).',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Date and time when the material reservation record was most recently updated. Tracks changes to reservation status, quantities, or other attributes. Audit timestamp in ISO 8601 format (yyyy-MM-ddTHH:mm:ss.SSSXXX).',
    `material_number` STRING COMMENT 'Business identifier for the material being reserved. The externally-known material code or Stock Keeping Unit (SKU) from the material master that identifies the specific item type.',
    `movement_type` STRING COMMENT 'Enterprise Resource Planning (ERP) transaction code that defines the type of inventory movement when goods are issued against this reservation. Standard SAP movement type 261 represents goods issue for order, while other codes may apply for returns, scrapping, or transfers.',
    `mutual_aid_indicator` BOOLEAN COMMENT 'Flag indicating whether this material reservation supports mutual aid assistance to another utility. True when materials are being pre-staged or allocated for deployment to support neighboring utilities during major storm events or grid emergencies.',
    `plant_code` STRING COMMENT 'Enterprise Resource Planning (ERP) organizational unit code representing the physical location or operational facility where the material is reserved. Corresponds to generation plants, transmission substations, distribution service centers, or regional operations hubs in the utility network.',
    `priority_code` STRING COMMENT 'Business priority level assigned to the material reservation. Determines the sequence for material allocation when inventory is constrained. Emergency and urgent priorities are used for storm restoration, outage response, and critical infrastructure repairs.. Valid values are `emergency|urgent|high|normal|low`',
    `requester_name` STRING COMMENT 'Name of the employee, planner, or supervisor who created the material reservation. Identifies the person responsible for requesting the material allocation for the work order or project.',
    `required_quantity` DECIMAL(18,2) COMMENT 'Total quantity of material requested for reservation. Represents the full amount needed to complete the associated work order, Capital Expenditure (CAPEX) project, or maintenance activity.',
    `requirement_date` DATE COMMENT 'Date by which the reserved material is needed at the work location or project site. Drives material availability planning, warehouse picking schedules, and logistics coordination for Transmission and Distribution (T&D) construction projects, planned maintenance outages, and storm restoration activities.',
    `reservation_date` DATE COMMENT 'Date when the material reservation was created in the Enterprise Resource Planning (ERP) system. Represents the business event timestamp for the reservation transaction.',
    `reservation_notes` STRING COMMENT 'Free-text field for additional information, special handling instructions, or business context related to the material reservation. May include details about material substitutions, delivery constraints, safety requirements, or coordination with field crews.',
    `reservation_number` STRING COMMENT 'Business identifier for the material reservation document. Externally-known unique number assigned by the Enterprise Resource Planning (ERP) system (SAP S/4HANA or Oracle ERP Cloud) to track the reservation throughout its lifecycle.',
    `reservation_status` STRING COMMENT 'Current lifecycle state of the material reservation. Tracks progression from open (newly created), partially issued (some quantity issued), fully issued (all quantity issued), cancelled (reservation voided), to closed (reservation completed and archived).. Valid values are `open|partially_issued|fully_issued|cancelled|closed`',
    `reservation_type` STRING COMMENT 'Classification of the material reservation based on the business purpose. Distinguishes between work order reservations, Capital Expenditure (CAPEX) project reservations, maintenance activity reservations, storm restoration pre-staging, planned generation outage reservations, and emergency response reservations.. Valid values are `work_order|capex_project|maintenance_activity|storm_restoration|planned_outage|emergency`',
    `reserved_quantity` DECIMAL(18,2) COMMENT 'Actual quantity of material successfully reserved from available inventory stock. May differ from required quantity if insufficient stock is available. This quantity is committed and reduces the unrestricted stock available for other reservations.',
    `serial_number` STRING COMMENT 'Unique serial number for serialized materials and equipment. Provides individual asset-level traceability for high-value components such as transformers, circuit breakers, meters, and generation equipment.',
    `storage_location_code` STRING COMMENT 'Warehouse or storage location code within the plant from which the material will be issued. Identifies the specific inventory stocking point, yard, or storeroom holding the reserved material.',
    `storm_event_reference` STRING COMMENT 'Identifier for the storm or emergency event associated with this material reservation. Used for storm restoration logistics, mutual aid coordination, and Federal Energy Regulatory Commission (FERC) or Public Utility Commission (PUC) storm cost recovery reporting.',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the material quantity is expressed. Examples include each (EA), meter (M), kilogram (KG), liter (L), foot (FT), or other industry-standard units aligned with the material master base unit of measure.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the reserved material quantity. Calculated as reserved quantity multiplied by the material standard cost or moving average price. Used for inventory valuation, Work in Progress (WIP) tracking, and Capital Expenditure (CAPEX) project cost accumulation.',
    `wbs_element` STRING COMMENT 'Hierarchical project structure code from the Capital Expenditure (CAPEX) project Work Breakdown Structure (WBS). Identifies the specific project phase, deliverable, or cost element to which this material reservation is charged. Used for project cost tracking and Allowance for Funds Used During Construction (AFUDC) capitalization.',
    CONSTRAINT pk_material_reservation PRIMARY KEY(`material_reservation_id`)
) COMMENT 'Transactional record reserving specific materials from inventory stock against a planned work order, CAPEX project WBS element, or maintenance activity. Captures reservation number, material number, required quantity, reserved quantity, movement type (261 goods issue for order), requesting cost center or WBS element, requirement date, reservation status (open, partially issued, fully issued, cancelled), issuing storage location, and SAP reservation document number. Ensures material availability planning for planned maintenance outages, T&D construction projects, and storm restoration pre-staging. Drives the reserved quantity in inventory_stock and prevents over-commitment of critical spare parts.';

CREATE OR REPLACE TABLE `power_and_utilities`.`supply`.`goods_issue` (
    `goods_issue_id` BIGINT COMMENT 'Unique identifier for the goods issue transaction. Primary key for the goods issue record.',
    `capex_project_id` BIGINT COMMENT 'Foreign key reference to the CAPEX project that consumed this material. Used for capital project cost tracking and AFUDC calculations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Goods issues charge material costs from inventory to consuming cost centers. Core cost accounting process for tracking departmental material consumption, maintenance costs, and operational expenses in',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Goods issues post to GL accounts for expense recognition or asset capitalization (CWIP). Required for proper FERC accounting treatment, distinguishing O&M expense from capital additions, and financial',
    `goods_receipt_id` BIGINT COMMENT 'Foreign key linking to supply.goods_receipt. Business justification: Goods issues should trace back to the original goods receipt for batch/serial number traceability, FIFO/LIFO costing, and quality issue root cause analysis. This is critical for regulated utility mate',
    `employee_id` BIGINT COMMENT 'Employee identifier of the person who issued the material, used for accountability and audit trail.',
    `master_id` BIGINT COMMENT 'Foreign key linking to asset.asset_master. Business justification: Issuing materials to capitalize an asset (vs. expensing to work order) requires proper asset linkage for FERC account classification, regulatory asset base tracking, and depreciation calculation. Util',
    `material_reservation_id` BIGINT COMMENT 'Foreign key reference to the material reservation record that committed this inventory for issuance. Links the goods issue to the upstream reservation.',
    `meter_id` BIGINT COMMENT 'Foreign key linking to metering.meter. Business justification: Tracks specific serialized meter issued from warehouse for field installation. Critical for asset lifecycle tracking, inventory reconciliation, and connecting supply chain to field operations. Utiliti',
    `material_master_id` BIGINT COMMENT 'Foreign key reference to the material master record identifying the specific material being issued from inventory.',
    `warehouse_id` BIGINT COMMENT 'Foreign key reference to the warehouse from which the material was issued.',
    `work_order_id` BIGINT COMMENT 'Foreign key reference to the work order that consumed this material. Used for maintenance and operations cost tracking.',
    `reversal_goods_issue_id` BIGINT COMMENT 'Self-referencing FK on goods_issue (reversal_goods_issue_id)',
    `batch_number` STRING COMMENT 'Batch or lot number for traceable materials, enabling traceability for quality control, warranty claims, and regulatory compliance.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when this goods issue record was first created in the system.',
    `currency_code` STRING COMMENT 'Three-letter ISO 4217 currency code for the valuation amount.. Valid values are `USD|CAD|EUR|GBP|MXN`',
    `document_date` DATE COMMENT 'The date on the physical goods issue document, which may differ from the posting date. Used for audit and reconciliation purposes.',
    `fiscal_period` STRING COMMENT 'The fiscal period (month) within the fiscal year when the goods issue was posted.',
    `fiscal_year` STRING COMMENT 'The fiscal year in which the goods issue was posted, used for financial period reporting and cost allocation.',
    `gi_document_number` STRING COMMENT 'The externally-known goods issue document number generated by the ERP system (SAP material document number). Used for audit trail and cross-system reconciliation.',
    `issue_status` STRING COMMENT 'Current lifecycle status of the goods issue transaction indicating whether it has been posted to inventory, reversed, pending approval, or cancelled.. Valid values are `posted|reversed|pending|cancelled`',
    `issue_timestamp` TIMESTAMP COMMENT 'The precise date and time when the material was physically issued from the warehouse or storage location.',
    `issued_quantity` DECIMAL(18,2) COMMENT 'The quantity of material issued from inventory stock. This is the principal quantitative fact for the goods issue transaction.',
    `issuing_person_name` STRING COMMENT 'Name of the warehouse clerk or storekeeper who physically issued the material from inventory.',
    `last_modified_timestamp` TIMESTAMP COMMENT 'Timestamp when this goods issue record was last modified or updated in the system.',
    `movement_type` STRING COMMENT 'SAP movement type code indicating the nature of the goods issue: 261 (goods issue for order), 262 (reversal of goods issue), 201 (goods issue for cost center), 281 (goods issue for network/project).. Valid values are `261|262|201|281`',
    `mutual_aid_reference` STRING COMMENT 'Reference identifier for mutual aid agreements if this material was issued to support another utility during emergency response.',
    `notes` STRING COMMENT 'Free-text notes or comments related to the goods issue transaction, capturing special handling instructions, exceptions, or additional context.',
    `plant_code` STRING COMMENT 'The plant or facility code where the goods issue occurred. Used for multi-site inventory management and cost allocation.',
    `posting_date` DATE COMMENT 'The date when the goods issue transaction was posted to the financial and inventory ledgers. This is the principal business event timestamp for inventory valuation and cost accounting.',
    `priority_code` STRING COMMENT 'Priority level of the goods issue request, used for expediting critical work orders or emergency restoration activities.. Valid values are `emergency|high|normal|low`',
    `receiving_cost_object_type` STRING COMMENT 'The type of cost object receiving the material: work order (maintenance), CAPEX project (capital construction), cost center (operational expense), or asset (capitalization).. Valid values are `work_order|capex_project|cost_center|asset`',
    `reversal_document_number` STRING COMMENT 'The document number of the reversal transaction if this goods issue was reversed. Null if not reversed.',
    `reversal_indicator` BOOLEAN COMMENT 'Boolean flag indicating whether this goods issue has been reversed (movement type 262). True if reversed, False otherwise.',
    `reversal_reason_code` STRING COMMENT 'Code indicating the reason for reversing the goods issue (e.g., incorrect quantity, wrong material, data entry error).',
    `serial_number` STRING COMMENT 'Serial number for individually tracked materials or equipment, enabling asset-level traceability.',
    `storage_location_code` STRING COMMENT 'The specific storage location code within the warehouse from which the material was issued.',
    `storm_event_reference` STRING COMMENT 'Reference identifier for the storm or emergency event if this goods issue is related to storm restoration or emergency response activities. Critical for tracking storm restoration material consumption for regulatory cost recovery.',
    `three_way_match_completed_flag` BOOLEAN COMMENT 'Boolean flag indicating whether the three-way match (purchase order, goods receipt, goods issue) has been completed for this material consumption. Critical for procurement-to-pay cycle closure.',
    `unit_of_measure` STRING COMMENT 'The unit of measure for the issued quantity (e.g., EA for each, FT for feet, LB for pounds, GAL for gallons).',
    `valuation_amount` DECIMAL(18,2) COMMENT 'The total monetary value of the issued material calculated using standard cost or moving average price. This is the principal monetary fact for cost accounting.',
    `wbs_element` STRING COMMENT 'The WBS element or network activity to which the material cost is charged for project-based consumption (movement type 281).',
    CONSTRAINT pk_goods_issue PRIMARY KEY(`goods_issue_id`)
) COMMENT 'Transactional record capturing the physical issuance and consumption of materials from inventory stock against a work order, CAPEX project, cost center, or material reservation. Records goods issue document number, posting date, material reference (linked to material_master), issuing storage location (linked to warehouse), reservation reference (linked to material_reservation), receiving cost object (work order, WBS element, cost center, or asset number), issued quantity, unit of measure, movement type (261 goods issue for order, 262 reversal of goods issue, 201 goods issue for cost center, 281 goods issue for network/project), batch/lot number for traceable materials, issuing warehouse clerk, and SAP material document number. Triggers inventory stock position reduction and drives actual material cost posting to work orders and CAPEX projects. Critical for closing the inventory movement lifecycle (goods_receipt IN → material_reservation COMMIT → goods_issue OUT), supporting three-way match completion, work order costing, storm restoration material consumption tracking, and FERC/PUC cost reporting for rate case filings.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `power_and_utilities`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `power_and_utilities`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_po_line_item_id` FOREIGN KEY (`po_line_item_id`) REFERENCES `power_and_utilities`.`supply`.`po_line_item`(`po_line_item_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `power_and_utilities`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `power_and_utilities`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ADD CONSTRAINT `fk_supply_stock_transfer_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ADD CONSTRAINT `fk_supply_stock_transfer_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `power_and_utilities`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ADD CONSTRAINT `fk_supply_stock_transfer_sending_warehouse_id` FOREIGN KEY (`sending_warehouse_id`) REFERENCES `power_and_utilities`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `power_and_utilities`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ADD CONSTRAINT `fk_supply_purchase_requisition_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `power_and_utilities`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ADD CONSTRAINT `fk_supply_vendor_invoice_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ADD CONSTRAINT `fk_supply_fuel_delivery_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ADD CONSTRAINT `fk_supply_fuel_delivery_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ADD CONSTRAINT `fk_supply_fuel_delivery_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `power_and_utilities`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `power_and_utilities`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ADD CONSTRAINT `fk_supply_material_reservation_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ADD CONSTRAINT `fk_supply_material_reservation_purchase_requisition_id` FOREIGN KEY (`purchase_requisition_id`) REFERENCES `power_and_utilities`.`supply`.`purchase_requisition`(`purchase_requisition_id`);
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ADD CONSTRAINT `fk_supply_material_reservation_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `power_and_utilities`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ADD CONSTRAINT `fk_supply_material_reservation_superseded_material_reservation_id` FOREIGN KEY (`superseded_material_reservation_id`) REFERENCES `power_and_utilities`.`supply`.`material_reservation`(`material_reservation_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `power_and_utilities`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_material_reservation_id` FOREIGN KEY (`material_reservation_id`) REFERENCES `power_and_utilities`.`supply`.`material_reservation`(`material_reservation_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `power_and_utilities`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ADD CONSTRAINT `fk_supply_goods_issue_reversal_goods_issue_id` FOREIGN KEY (`reversal_goods_issue_id`) REFERENCES `power_and_utilities`.`supply`.`goods_issue`(`goods_issue_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Account Number');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `bank_account_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_business_glossary_term' = 'Bank Name');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `bank_name` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_business_glossary_term' = 'Bank Routing Number (ABA)');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `bank_routing_number` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `bonding_capacity_usd` SET TAGS ('dbx_business_glossary_term' = 'Bonding Capacity (USD)');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `bonding_capacity_usd` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_business_glossary_term' = 'Vendor Classification');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `classification` SET TAGS ('dbx_value_regex' = 'material_supplier|fuel_supplier|td_contractor|generation_services|professional_services|it_vendor');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `dba_name` SET TAGS ('dbx_business_glossary_term' = 'Doing Business As (DBA) Name');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `diversity_classification` SET TAGS ('dbx_business_glossary_term' = 'Diversity Classification');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `insurance_certificate_status` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Status');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `insurance_certificate_status` SET TAGS ('dbx_value_regex' = 'current|expired|pending|not_required');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Certificate Expiration Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `last_transaction_date` SET TAGS ('dbx_business_glossary_term' = 'Last Transaction Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Legal Name');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `modified_by_user` SET TAGS ('dbx_business_glossary_term' = 'Modified By User Identifier');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notes');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `osha_emr` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Experience Modification Rate (EMR)');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'eft|ach|wire|check|credit_card');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_45|net_60|net_90|due_on_receipt|2_10_net_30');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `preferred_currency` SET TAGS ('dbx_business_glossary_term' = 'Preferred Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `prequalification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Expiration Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_business_glossary_term' = 'Prequalification Status');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `prequalification_status` SET TAGS ('dbx_value_regex' = 'prequalified|not_prequalified|under_review|expired');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Remittance Address Line 1');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Remittance Address Line 2');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_city` SET TAGS ('dbx_business_glossary_term' = 'Remittance City');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_country` SET TAGS ('dbx_business_glossary_term' = 'Remittance Country Code');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_business_glossary_term' = 'Remittance Postal Code');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_state` SET TAGS ('dbx_business_glossary_term' = 'Remittance State or Province');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `remittance_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `since_date` SET TAGS ('dbx_business_glossary_term' = 'Vendor Since Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Tax Identification Number (TIN/EIN)');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `vendor_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Number');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Status');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|prequalified|disqualified|pending_approval');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_business_glossary_term' = 'Vendor Type');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `vendor_type` SET TAGS ('dbx_value_regex' = 'goods|services|goods_and_services');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `w9_on_file` SET TAGS ('dbx_business_glossary_term' = 'IRS Form W-9 On File Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Vendor Website URL');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `base_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `batch_managed_indicator` SET TAGS ('dbx_business_glossary_term' = 'Batch Managed Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `created_date` SET TAGS ('dbx_business_glossary_term' = 'Material Master Created Date');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `gross_weight` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Class');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `hazmat_indicator` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material (HAZMAT) Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `last_modified_date` SET TAGS ('dbx_business_glossary_term' = 'Material Master Last Modified Date');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `long_description` SET TAGS ('dbx_business_glossary_term' = 'Material Long Description');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `manufacturer_name` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Name');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number (MPN)');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,18}$');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `material_status` SET TAGS ('dbx_value_regex' = 'active|inactive|obsolete|pending_approval|restricted');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Price (MAP)');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `moving_average_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `net_weight` SET TAGS ('dbx_business_glossary_term' = 'Net Weight');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `planned_delivery_time_days` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Time (Days)');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `plant_specific_status` SET TAGS ('dbx_business_glossary_term' = 'Plant-Specific Material Status');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `price_control_indicator` SET TAGS ('dbx_business_glossary_term' = 'Price Control Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `price_control_indicator` SET TAGS ('dbx_value_regex' = 'standard|moving_average');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external|internal|both');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `purchase_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Purchase Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `purchase_unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `serial_number_profile` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Profile');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `standard_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `storage_class` SET TAGS ('dbx_business_glossary_term' = 'Storage Class');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_business_glossary_term' = 'United Nations Standard Products and Services Code (UNSPSC)');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `unspsc_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `volume` SET TAGS ('dbx_business_glossary_term' = 'Volume');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit of Measure');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `weight_unit` SET TAGS ('dbx_business_glossary_term' = 'Weight Unit of Measure');
ALTER TABLE `power_and_utilities`.`supply`.`material_master` ALTER COLUMN `weight_unit` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'procurement_transactions');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer ID');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `buyer_name` SET TAGS ('dbx_business_glossary_term' = 'Buyer Name');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `cancellation_date` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Date');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `cancellation_reason` SET TAGS ('dbx_business_glossary_term' = 'Cancellation Reason');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `erp_document_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Document Number');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `freight_amount` SET TAGS ('dbx_business_glossary_term' = 'Freight Amount');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'Incoterms');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `invoice_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Invoice Receipt Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `po_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Date');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Number');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{8,20}$');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `po_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Status');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Type');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `po_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|framework|service|contract');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'routine|expedite|emergency|critical');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `promised_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Promised Delivery Date');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `total_po_value` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `total_po_value_with_tax` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Order (PO) Value with Tax');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `vendor_site_code` SET TAGS ('dbx_business_glossary_term' = 'Vendor Site Code');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_order` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` SET TAGS ('dbx_subdomain' = 'procurement_transactions');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Line Item ID');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Header ID');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Category');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `account_assignment_category` SET TAGS ('dbx_value_regex' = 'K|A|P|F|N');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `confirmation_control_key` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Control Key');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `incoterms` SET TAGS ('dbx_business_glossary_term' = 'International Commercial Terms (Incoterms)');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `incoterms_location` SET TAGS ('dbx_business_glossary_term' = 'Incoterms Location');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_business_glossary_term' = 'Item Category');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `item_category` SET TAGS ('dbx_value_regex' = 'standard|consignment|subcontracting|service|limit|text');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Item Number');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Item Status');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|partially_received|fully_received|invoiced|closed|cancelled');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `manufacturer_part_number` SET TAGS ('dbx_business_glossary_term' = 'Manufacturer Part Number');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Modified Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `net_value` SET TAGS ('dbx_business_glossary_term' = 'Net Line Value');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `ordered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `over_delivery_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Percentage');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `requisitioner_name` SET TAGS ('dbx_business_glossary_term' = 'Requisitioner Name');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `service_entry_sheet_required` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet Required');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `under_delivery_tolerance_pct` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Percentage');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `uom` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `vendor_material_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Material Number');
ALTER TABLE `power_and_utilities`.`supply`.`po_line_item` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) ID');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project ID');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Po Line Item Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch or Lot Number');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `delivery_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Delivery Completed Flag');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `delivery_note_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Note Number');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Date');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Document Number');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `gr_document_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10}$');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Status');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `gr_status` SET TAGS ('dbx_value_regex' = 'posted|pending_inspection|inspection_complete|reversed|cancelled');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Outcome');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'accepted|rejected|partially_accepted|pending|not_applicable');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Inventory Movement Type');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '101|103|105|161|501');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Notes');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `over_delivery_tolerance_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Over-Delivery Tolerance Exceeded Flag');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `packing_slip_reference` SET TAGS ('dbx_business_glossary_term' = 'Vendor Packing Slip Reference');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Posting Date');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `quality_inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Required Flag');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `received_quantity` SET TAGS ('dbx_business_glossary_term' = 'Received Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Person Name');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `receiving_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Physical Receiving Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt (GR) Reversal Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|blocked|quality_inspection|restricted');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `under_delivery_tolerance_exceeded_flag` SET TAGS ('dbx_business_glossary_term' = 'Under-Delivery Tolerance Exceeded Flag');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_receipt` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Valuation Amount');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract ID');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `amendment_count` SET TAGS ('dbx_business_glossary_term' = 'Amendment Count');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `base_price` SET TAGS ('dbx_business_glossary_term' = 'Base Price');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `base_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `contract_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Approval Date');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `contract_document_repository_path` SET TAGS ('dbx_business_glossary_term' = 'Contract Document Repository Path');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `contract_execution_date` SET TAGS ('dbx_business_glossary_term' = 'Contract Execution Date');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'quantity_contract|value_contract|fuel_ppa|service_agreement|blanket_po|framework_agreement');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `fuel_index_linkage` SET TAGS ('dbx_business_glossary_term' = 'Fuel Index Linkage');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `last_amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Date');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `maximum_quantity_commitment` SET TAGS ('dbx_business_glossary_term' = 'Maximum Quantity Commitment');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `minimum_quantity_commitment` SET TAGS ('dbx_business_glossary_term' = 'Minimum Quantity Commitment');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Contract Notes');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `performance_guarantee` SET TAGS ('dbx_business_glossary_term' = 'Performance Guarantee');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `price_escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Price Escalation Clause');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `price_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Price Unit of Measure');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `quantity_unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit of Measure');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `regulatory_compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Requirements');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `renewal_terms` SET TAGS ('dbx_business_glossary_term' = 'Renewal Terms');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `sap_outline_agreement_number` SET TAGS ('dbx_business_glossary_term' = 'SAP Outline Agreement Number');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `termination_clause` SET TAGS ('dbx_business_glossary_term' = 'Termination Clause');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `power_and_utilities`.`supply`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `inventory_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Stock ID');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `abc_classification` SET TAGS ('dbx_business_glossary_term' = 'ABC Classification');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `abc_classification` SET TAGS ('dbx_value_regex' = 'A|B|C|X');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `blocked_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Blocked Stock Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `consignment_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Consignment Stock Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `in_transit_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'In-Transit Stock Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `issued_quantity` SET TAGS ('dbx_business_glossary_term' = 'Issued Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `last_goods_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Issue Date');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `last_goods_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Goods Receipt Date');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `last_physical_inventory_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Inventory Count Date');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `lot_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `maximum_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Maximum Stock Level');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `moving_average_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Moving Average Cost Per Unit');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `moving_average_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Controller');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `mrp_controller` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3}$');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `physical_inventory_variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Physical Inventory Variance Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external|internal|both');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `quality_inspection_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Stock Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `reorder_point_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point Breach Flag');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `safety_stock` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `safety_stock_breach_flag` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Breach Flag');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `special_stock_indicator` SET TAGS ('dbx_business_glossary_term' = 'Special Stock Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `standard_cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost Per Unit');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `standard_cost_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `stock_determination_group` SET TAGS ('dbx_business_glossary_term' = 'Stock Determination Group');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `stock_determination_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_business_glossary_term' = 'Stock Status');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `stock_status` SET TAGS ('dbx_value_regex' = 'available|low_stock|out_of_stock|excess|obsolete|inactive');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'own|consignment|returnable_packaging|project');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4}$');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `total_inventory_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Inventory Valuation Amount');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `total_inventory_valuation_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = '^[A-Z]{2,3}$');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `unrestricted_stock_quantity` SET TAGS ('dbx_business_glossary_term' = 'Unrestricted Stock Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`inventory_stock` ALTER COLUMN `valuation_currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `address_line_1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `address_line_1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `address_line_1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `address_line_2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `address_line_2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `address_line_2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `backup_power_available` SET TAGS ('dbx_business_glossary_term' = 'Backup Power Available Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `building_year` SET TAGS ('dbx_business_glossary_term' = 'Building Year');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `climate_controlled` SET TAGS ('dbx_business_glossary_term' = 'Climate Controlled Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Contact Email Address');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Contact Phone Number');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('dbx_value_regex' = '^+?[0-9]{10,15}$');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,12}$');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'central_warehouse|field_storeroom|generation_plant_store|mobile_storm_unit|distribution_yard|transmission_yard');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression System Type');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `fire_suppression_system` SET TAGS ('dbx_value_regex' = 'sprinkler|foam|gas|none');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `hazmat_certification_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certification Expiry Date');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `hazmat_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certification Number');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `hazmat_certified` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Materials (HAZMAT) Certified Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `inventory_system_code` SET TAGS ('dbx_business_glossary_term' = 'Inventory System Code');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `last_renovation_year` SET TAGS ('dbx_business_glossary_term' = 'Last Renovation Year');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `lease_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiry Date');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `loading_docks` SET TAGS ('dbx_business_glossary_term' = 'Loading Docks Count');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Manager Name');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `operating_hours` SET TAGS ('dbx_business_glossary_term' = 'Operating Hours');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|seasonal|under_construction|decommissioned');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|third_party_logistics');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `pallet_positions` SET TAGS ('dbx_business_glossary_term' = 'Pallet Positions');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `responsible_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Responsible Plant Code');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `responsible_plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,10}$');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'standard|enhanced|critical_infrastructure');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State or Province');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `state_province` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `storage_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Storage Capacity (Square Feet)');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `storm_staging_capable` SET TAGS ('dbx_business_glossary_term' = 'Storm Staging Capable Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `twenty_four_seven_access` SET TAGS ('dbx_business_glossary_term' = 'Twenty-Four Seven (24/7) Access Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Name');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `warehouse_number` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Number');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `warehouse_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,12}$');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `yard_storage_available` SET TAGS ('dbx_business_glossary_term' = 'Yard Storage Available Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`warehouse` ALTER COLUMN `yard_storage_capacity_sqft` SET TAGS ('dbx_business_glossary_term' = 'Yard Storage Capacity (Square Feet)');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `stock_transfer_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Transfer ID');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project ID');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving Warehouse ID');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `sending_warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Sending Warehouse ID');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `actual_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Receipt Date');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `actual_shipment_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Shipment Date');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `issuing_person_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Person Name');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `issuing_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '301|311|303|305|309');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `mutual_aid_reference` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Reference');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `mutual_aid_utility_name` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Utility Name');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'routine|urgent|emergency|critical');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Person Name');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `receiving_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Receiving Plant Code');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `receiving_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Receiving Storage Location');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `requested_transfer_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Transfer Date');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `sending_plant_code` SET TAGS ('dbx_business_glossary_term' = 'Sending Plant Code');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `sending_storage_location` SET TAGS ('dbx_business_glossary_term' = 'Sending Storage Location');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `shipment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Shipment Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `shipping_document_number` SET TAGS ('dbx_business_glossary_term' = 'Shipping Document Number');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `storm_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Reference');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `transfer_notes` SET TAGS ('dbx_business_glossary_term' = 'Transfer Notes');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `transfer_order_number` SET TAGS ('dbx_business_glossary_term' = 'Transfer Order Number');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `transfer_quantity` SET TAGS ('dbx_business_glossary_term' = 'Transfer Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `transfer_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Transfer Reason Code');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_business_glossary_term' = 'Transfer Status');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `transfer_status` SET TAGS ('dbx_value_regex' = 'open|in-transit|received|completed|cancelled');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `transport_mode` SET TAGS ('dbx_business_glossary_term' = 'Transport Mode');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `transport_mode` SET TAGS ('dbx_value_regex' = 'company-truck|common-carrier|emergency-helicopter|rail|barge|mutual-aid-vehicle');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`supply`.`stock_transfer` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` SET TAGS ('dbx_subdomain' = 'procurement_transactions');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition ID');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee ID');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{6,10}$');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `approval_workflow_code` SET TAGS ('dbx_business_glossary_term' = 'Approval Workflow ID');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `approval_workflow_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_business_glossary_term' = 'Approved By Name');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `approved_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `estimated_total_value` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Value');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `estimated_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Estimated Unit Price');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `plant_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `po_conversion_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) Conversion Date');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `priority_indicator` SET TAGS ('dbx_business_glossary_term' = 'Priority Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `priority_indicator` SET TAGS ('dbx_value_regex' = 'normal|urgent|emergency|critical');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,6}$');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `rejection_reason` SET TAGS ('dbx_business_glossary_term' = 'Rejection Reason');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `requested_quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `requester_department` SET TAGS ('dbx_business_glossary_term' = 'Requester Department');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `requester_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Number');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{10,20}$');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_business_glossary_term' = 'Requisition Type');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `requisition_type` SET TAGS ('dbx_value_regex' = 'standard_material|service|fuel|emergency|storm_restoration|capital_project');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{4,6}$');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `power_and_utilities`.`supply`.`purchase_requisition` ALTER COLUMN `wbs_element` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-.]{8,24}$');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `vendor_invoice_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Invoice ID');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project ID');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order (PO) ID');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `approver_name` SET TAGS ('dbx_business_glossary_term' = 'Approver Name');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `company_code` SET TAGS ('dbx_business_glossary_term' = 'Company Code');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `duplicate_invoice_flag` SET TAGS ('dbx_business_glossary_term' = 'Duplicate Invoice Flag');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `fi_document_number` SET TAGS ('dbx_business_glossary_term' = 'Financial Accounting (FI) Document Number');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `gross_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_description` SET TAGS ('dbx_business_glossary_term' = 'Invoice Description');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_status` SET TAGS ('dbx_business_glossary_term' = 'Invoice Status');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_business_glossary_term' = 'Invoice Type');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `invoice_type` SET TAGS ('dbx_value_regex' = 'standard|credit_memo|debit_memo|prepayment|down_payment|final_invoice');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `net_invoice_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `payment_block_indicator` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `payment_block_reason` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Reason');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'ach|wire_transfer|check|credit_card|procurement_card');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `payment_terms_code` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms Code');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Status');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `three_way_match_status` SET TAGS ('dbx_value_regex' = 'matched|quantity_variance|price_variance|not_matched|bypassed');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `vendor_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Reference Number');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_invoice` ALTER COLUMN `withholding_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Withholding Tax Amount');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` SET TAGS ('dbx_subdomain' = 'procurement_transactions');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `fuel_delivery_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Delivery ID');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `compliance_event_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `emissions_report_id` SET TAGS ('dbx_business_glossary_term' = 'Emissions Report Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `fuel_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Contract ID');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Plant ID');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `ash_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Ash Content Percent');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `btu_content` SET TAGS ('dbx_business_glossary_term' = 'British Thermal Unit (BTU) Content');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|MXN');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `delivered_quantity` SET TAGS ('dbx_business_glossary_term' = 'Delivered Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Delivery Date');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `delivery_notes` SET TAGS ('dbx_business_glossary_term' = 'Delivery Notes');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `delivery_point_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Code');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `delivery_point_description` SET TAGS ('dbx_business_glossary_term' = 'Delivery Point Description');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_business_glossary_term' = 'Delivery Status');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `delivery_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_transit|delivered|accepted|rejected|disputed');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `delivery_ticket_number` SET TAGS ('dbx_business_glossary_term' = 'Delivery Ticket Number');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Delivery Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `environmental_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Flag');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'natural_gas|coal|fuel_oil|diesel|nuclear_fuel|biomass');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `heat_rate_mmbtu_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Heat Rate (MMBTU per Unit)');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `inspection_outcome` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|waived|not_required');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `inspection_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content Percent');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `origin_location` SET TAGS ('dbx_business_glossary_term' = 'Origin Location');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `pipeline_receipt_point` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Receipt Point');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `quality_certificate_number` SET TAGS ('dbx_business_glossary_term' = 'Quality Certificate Number');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving Person Name');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `receiving_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `scheduled_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Date');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percent');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `total_delivery_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Delivery Cost');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `total_delivery_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `transportation_cost` SET TAGS ('dbx_business_glossary_term' = 'Transportation Cost');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `transportation_cost` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `transporter_duns_number` SET TAGS ('dbx_business_glossary_term' = 'Transporter Data Universal Numbering System (DUNS) Number');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'MCF|tons|barrels|gallons|kilograms|assemblies');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price');
ALTER TABLE `power_and_utilities`.`supply`.`fuel_delivery` ALTER COLUMN `unit_price` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` SET TAGS ('dbx_subdomain' = 'vendor_management');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `vendor_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance ID');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project ID');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `evaluator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Employee ID');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `evaluator_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `evaluator_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `approved_date` SET TAGS ('dbx_business_glossary_term' = 'Approved Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `bid_evaluation_score_adjustment` SET TAGS ('dbx_business_glossary_term' = 'Bid Evaluation Score Adjustment');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `contract_renewal_recommendation` SET TAGS ('dbx_business_glossary_term' = 'Contract Renewal Recommendation');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `contract_renewal_recommendation` SET TAGS ('dbx_value_regex' = 'strongly_recommend|recommend|neutral|not_recommend|terminate');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `corrective_action_plan_due_date` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Due Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `corrective_action_plan_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Required Flag');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Plan Status');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `corrective_action_plan_status` SET TAGS ('dbx_value_regex' = 'not_required|pending|in_progress|completed|overdue');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `delivery_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Delivery Weight Percentage');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `diversity_spend_percentage` SET TAGS ('dbx_business_glossary_term' = 'Diversity Spend Percentage');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `diversity_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Diversity Weight Percentage');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `emr_score` SET TAGS ('dbx_business_glossary_term' = 'Experience Modification Rate (EMR) Score');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `environmental_compliance_incidents` SET TAGS ('dbx_business_glossary_term' = 'Environmental Compliance Incidents');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_notes` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Notes');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_period_end_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_period_start_date` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|disputed|final');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'quarterly|annual|project_based|contract_renewal');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `evaluator_name` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Name');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `invoice_accuracy_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Weight Percentage');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `material_rejection_rate` SET TAGS ('dbx_business_glossary_term' = 'Material Rejection Rate');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `osha_recordable_incident_rate` SET TAGS ('dbx_business_glossary_term' = 'Occupational Safety and Health Administration (OSHA) Recordable Incident Rate');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `overall_performance_rating` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Rating');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `preferred_vendor_list_eligible_flag` SET TAGS ('dbx_business_glossary_term' = 'Preferred Vendor List Eligible Flag');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `quality_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Quality Weight Percentage');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `safety_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Safety Compliance Score');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `safety_weight_percentage` SET TAGS ('dbx_business_glossary_term' = 'Safety Weight Percentage');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `total_purchase_orders_evaluated` SET TAGS ('dbx_business_glossary_term' = 'Total Purchase Orders Evaluated');
ALTER TABLE `power_and_utilities`.`supply`.`vendor_performance` ALTER COLUMN `total_spend_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Spend Amount');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `material_reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Material Reservation Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `purchase_requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Requisition Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester Employee Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `superseded_material_reservation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `closed_date` SET TAGS ('dbx_business_glossary_term' = 'Closed Date');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `deletion_indicator` SET TAGS ('dbx_business_glossary_term' = 'Deletion Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `erp_document_number` SET TAGS ('dbx_business_glossary_term' = 'Enterprise Resource Planning (ERP) Document Number');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `final_issue_indicator` SET TAGS ('dbx_business_glossary_term' = 'Final Issue Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `gl_account_code` SET TAGS ('dbx_business_glossary_term' = 'General Ledger (GL) Account Code');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `goods_issue_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Completed Flag');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `issued_quantity` SET TAGS ('dbx_business_glossary_term' = 'Issued Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `mutual_aid_indicator` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Indicator');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'emergency|urgent|high|normal|low');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `requester_name` SET TAGS ('dbx_business_glossary_term' = 'Requester Name');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `required_quantity` SET TAGS ('dbx_business_glossary_term' = 'Required Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `requirement_date` SET TAGS ('dbx_business_glossary_term' = 'Requirement Date');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `reservation_date` SET TAGS ('dbx_business_glossary_term' = 'Reservation Date');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `reservation_notes` SET TAGS ('dbx_business_glossary_term' = 'Reservation Notes');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `reservation_number` SET TAGS ('dbx_business_glossary_term' = 'Reservation Number');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_business_glossary_term' = 'Reservation Status');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `reservation_status` SET TAGS ('dbx_value_regex' = 'open|partially_issued|fully_issued|cancelled|closed');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_business_glossary_term' = 'Reservation Type');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `reservation_type` SET TAGS ('dbx_value_regex' = 'work_order|capex_project|maintenance_activity|storm_restoration|planned_outage|emergency');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `reserved_quantity` SET TAGS ('dbx_business_glossary_term' = 'Reserved Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `storm_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Reference');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `power_and_utilities`.`supply`.`material_reservation` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` SET TAGS ('dbx_subdomain' = 'inventory_operations');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `goods_issue_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Capital Expenditure (CAPEX) Project Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Employee Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `master_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `material_reservation_id` SET TAGS ('dbx_business_glossary_term' = 'Material Reservation Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `meter_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Id (Foreign Key)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order Identifier (ID)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `reversal_goods_issue_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|MXN');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `document_date` SET TAGS ('dbx_business_glossary_term' = 'Document Date');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `fiscal_period` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Period');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `fiscal_year` SET TAGS ('dbx_business_glossary_term' = 'Fiscal Year');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `gi_document_number` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue (GI) Document Number');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `issue_status` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Status');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `issue_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|cancelled');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Issue Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `issued_quantity` SET TAGS ('dbx_business_glossary_term' = 'Issued Quantity');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `issuing_person_name` SET TAGS ('dbx_business_glossary_term' = 'Issuing Person Name');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `issuing_person_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `issuing_person_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `last_modified_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Modified Timestamp');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Code');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = '261|262|201|281');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `mutual_aid_reference` SET TAGS ('dbx_business_glossary_term' = 'Mutual Aid Reference');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Goods Issue Notes');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `priority_code` SET TAGS ('dbx_business_glossary_term' = 'Priority Code');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `priority_code` SET TAGS ('dbx_value_regex' = 'emergency|high|normal|low');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `receiving_cost_object_type` SET TAGS ('dbx_business_glossary_term' = 'Receiving Cost Object Type');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `receiving_cost_object_type` SET TAGS ('dbx_value_regex' = 'work_order|capex_project|cost_center|asset');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `reversal_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reversal Document Number');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `reversal_indicator` SET TAGS ('dbx_business_glossary_term' = 'Reversal Indicator Flag');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `reversal_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Reversal Reason Code');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `storm_event_reference` SET TAGS ('dbx_business_glossary_term' = 'Storm Event Reference');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `three_way_match_completed_flag` SET TAGS ('dbx_business_glossary_term' = 'Three-Way Match Completed Flag');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount');
ALTER TABLE `power_and_utilities`.`supply`.`goods_issue` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
