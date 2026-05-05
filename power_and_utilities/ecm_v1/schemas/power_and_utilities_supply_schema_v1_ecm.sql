-- Schema for Domain: supply | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:20

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`supply` COMMENT 'Procurement and supply chain management for fuel (coal, natural gas, uranium), materials, equipment, and services. Manages vendor relationships, purchase orders, contracts, inventory, logistics, and supplier performance. Supports CAPEX project material staging, storm restoration inventory, and fuel supply chain for generation plants. Integrates with SAP MM for procurement operations.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`vendor` (
    `vendor_id` BIGINT COMMENT 'System-generated unique identifier for the vendor record.',
    `employee_id` BIGINT COMMENT 'Foreign key linking to workforce.employee. Business justification: Vendor Management assigns an internal employee as primary liaison; required for contact reporting, compliance, and escalation handling.',
    `tech_vendor_id` BIGINT COMMENT 'Foreign key linking to technology.tech_vendor. Business justification: Unified vendor governance maps each supply vendor to its technology vendor record for integrated compliance reporting.',
    `address_line1` STRING COMMENT 'First line of the vendors mailing address.',
    `address_line2` STRING COMMENT 'Second line of the vendors mailing address (optional).',
    `approved_commodity_categories` STRING COMMENT 'Comma‑separated list of commodity categories the vendor is approved to supply. [ENUM-REF-CANDIDATE: fuel|equipment|services|mro|spare_parts|consulting|software|other — promote to reference product]',
    `bonding_amount` DECIMAL(18,2) COMMENT 'Maximum bonding liability the vendor provides for contract performance.',
    `bonding_expiry_date` DATE COMMENT 'Date when the vendors bonding coverage expires.',
    `city` STRING COMMENT 'City component of the vendors mailing address.',
    `country` STRING COMMENT 'Three‑letter ISO country code for the vendors primary location.. Valid values are `^[A-Z]{3}$`',
    `credit_limit` DECIMAL(18,2) COMMENT 'Maximum credit amount the utility extends to the vendor.',
    `diversity_status` STRING COMMENT 'Indicates if the vendor holds a recognized diversity certification.. Valid values are `none|mbe|wbe|sbe`',
    `duns_number` STRING COMMENT 'Unique DUNS identifier for the vendor used for credit and risk assessment.',
    `ferc_compliance_flag` BOOLEAN COMMENT 'True if the vendor complies with Federal Energy Regulatory Commission requirements.',
    `financial_rating` STRING COMMENT 'External credit rating indicating the vendors financial stability.',
    `insurance_company` STRING COMMENT 'Name of the insurer providing coverage for the vendor.',
    `insurance_expiry_date` DATE COMMENT 'Date when the vendors insurance policy expires.',
    `insurance_policy_number` STRING COMMENT 'Policy identifier for the vendors insurance coverage.',
    `last_review_timestamp` TIMESTAMP COMMENT 'Timestamp of the last formal review of the vendors qualifications and performance.',
    `legal_name` STRING COMMENT 'Full legal name of the vendor as registered with government authorities.',
    `nerc_cip_compliance_flag` BOOLEAN COMMENT 'True if the vendor meets NERC Critical Infrastructure Protection standards.',
    `notes` STRING COMMENT 'Free‑form text field for additional remarks or comments about the vendor.',
    `payment_method` STRING COMMENT 'Preferred method for paying the vendor (e.g., ACH, check).',
    `payment_terms` STRING COMMENT 'Standard payment terms negotiated with the vendor (e.g., Net 30).',
    `postal_code` STRING COMMENT 'Postal/ZIP code of the vendors mailing address.',
    `primary_contact_email` STRING COMMENT 'Email address of the vendors primary contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `primary_contact_name` STRING COMMENT 'Name of the main point of contact for the vendor.',
    `primary_contact_phone` STRING COMMENT 'Telephone number for the vendors primary contact.',
    `qualification_review_date` DATE COMMENT 'Date of the most recent qualification review for the vendor.',
    `qualification_status` STRING COMMENT 'Current status of the vendors qualification within the utilitys approved vendor list.. Valid values are `qualified|pending|rejected|under_review`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vendor record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vendor record.',
    `safety_incident_count` STRING COMMENT 'Number of safety incidents reported for the vendor in the past 12 months.',
    `safety_last_incident_date` DATE COMMENT 'Date of the most recent safety incident involving the vendor.',
    `safety_record_status` STRING COMMENT 'Current status of the vendors safety performance record.. Valid values are `clear|pending|suspended`',
    `state` STRING COMMENT 'State or province component of the vendors mailing address.',
    `tax_exempt_code` STRING COMMENT 'Code representing the reason for tax exemption.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the vendor is exempt from sales tax.',
    `tax_identifier` STRING COMMENT 'Federal tax identifier for the vendor organization.',
    `vendor_category` STRING COMMENT 'Primary classification of the vendor based on the goods or services supplied.. Valid values are `fuel_supplier|equipment_oem|contractor|mro_distributor|service_provider`',
    `vendor_name` STRING COMMENT 'Common name used to refer to the vendor in business communications.',
    `vendor_number` STRING COMMENT 'External vendor code used in procurement and contract documents.',
    `vendor_status` STRING COMMENT 'Current lifecycle status of the vendor record.. Valid values are `active|inactive|suspended|pending|terminated`',
    `website_url` STRING COMMENT 'Public website address of the vendor.',
    CONSTRAINT pk_vendor PRIMARY KEY(`vendor_id`)
) COMMENT 'Master record for all suppliers, contractors, and service providers in the utility supply chain. Captures vendor identity, classification (fuel supplier, equipment OEM, contractor, MRO distributor), tax identifiers, remittance details, diversity certifications (MBE/WBE/SBE), bonding and insurance status, and FERC/NERC compliance flags. Encompasses the full vendor lifecycle including pre-qualification assessment, approved vendor list (AVL) management, qualification status, commodity categories approved, safety record, financial stability rating, insurance certificate expiry, bonding limit, NERC CIP compliance status, diversity classification, and qualification review scheduling. Serves as the SSOT for vendor identity, qualification, and approved-supplier status within the supply domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`material_master` (
    `material_master_id` BIGINT COMMENT 'System-generated unique identifier for each material record.',
    `vendor_id` BIGINT COMMENT 'Preferred vendor for the material; used for automatic source determination.',
    `alternative_uom` STRING COMMENT 'Secondary unit of measure allowed for the material (e.g., cases, pallets).',
    `base_uom` STRING COMMENT 'Standard unit of measure in which the material is stocked and procured (e.g., EA, KG, L).',
    `batch_management_flag` BOOLEAN COMMENT 'Indicates whether the material is managed in batches for traceability.',
    `country_of_origin` STRING COMMENT 'ISO 3166‑1 alpha‑3 code of the country where the material was produced.. Valid values are `^[A-Z]{3}$`',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the material record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter code of the currency in which the standard cost is expressed.. Valid values are `^[A-Z]{3}$`',
    `customs_tariff_code` STRING COMMENT 'Eight‑digit HS code used for import/export duty calculations.. Valid values are `^[0-9]{8}$`',
    `expiration_date` DATE COMMENT 'Date after which the material must not be used or sold.',
    `gross_weight_kg` DECIMAL(18,2) COMMENT 'Total weight including packaging.',
    `hazard_class` STRING COMMENT 'Regulatory hazard class for the material (e.g., Class 1 – Explosives).',
    `hazardous_material_flag` BOOLEAN COMMENT 'True if the material is classified as hazardous under regulatory standards.',
    `height_cm` DECIMAL(18,2) COMMENT 'Height dimension of the material packaging.',
    `is_obsolete` BOOLEAN COMMENT 'True if the material is no longer used or purchased.',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent change to the material record.',
    `lead_time_days` STRING COMMENT 'Average number of days from order placement to receipt of the material.',
    `length_cm` DECIMAL(18,2) COMMENT 'Length dimension of the material packaging.',
    `lot_size` DECIMAL(18,2) COMMENT 'Standard quantity for production or procurement batches.',
    `material_description` STRING COMMENT 'Full textual description of the material, including purpose and key characteristics.',
    `material_group` STRING COMMENT 'Classification code that groups materials by similar usage or function for reporting and planning.',
    `material_master_status` STRING COMMENT 'Current lifecycle status of the material.. Valid values are `active|inactive|discontinued`',
    `material_number` STRING COMMENT 'External business identifier for the material as used in procurement and inventory systems.',
    `material_type` STRING COMMENT 'High‑level categorization of the material (e.g., raw material, spare part).. Valid values are `raw|spare|consumable|equipment`',
    `max_order_qty` DECIMAL(18,2) COMMENT 'Largest quantity that can be ordered in a single purchase order.',
    `min_order_qty` DECIMAL(18,2) COMMENT 'Smallest quantity that can be ordered for the material.',
    `mrp_type` STRING COMMENT 'Determines how the system calculates procurement proposals for the material.. Valid values are `PD|VB|VV|FO|FOB`',
    `net_weight_kg` DECIMAL(18,2) COMMENT 'Weight of the material excluding packaging.',
    `plant_code` STRING COMMENT 'Identifier of the plant or location where the material is managed.',
    `price_valid_from` DATE COMMENT 'Start date of the price validity period.',
    `price_valid_to` DATE COMMENT 'End date of the price validity period; null if open‑ended.',
    `procurement_type` STRING COMMENT 'Indicates whether the material is purchased externally, produced internally, or consigned.. Valid values are `external|internal|consignment`',
    `purchasing_group` STRING COMMENT 'Organizational unit responsible for purchasing the material.',
    `safety_stock_qty` DECIMAL(18,2) COMMENT 'Minimum inventory level maintained to protect against demand variability.',
    `serial_number_flag` BOOLEAN COMMENT 'Indicates whether each unit of the material is tracked with a unique serial number.',
    `shelf_life_days` STRING COMMENT 'Number of days the material remains usable from receipt.',
    `standard_cost` DECIMAL(18,2) COMMENT 'Default cost used for inventory valuation and cost‑of‑goods‑sold calculations.',
    `storage_condition` STRING COMMENT 'Required storage environment for the material.. Valid values are `ambient|refrigerated|frozen|hazardous`',
    `temperature_control_flag` BOOLEAN COMMENT 'True if the material requires temperature‑controlled storage.',
    `un_number` STRING COMMENT 'Four‑digit United Nations number identifying hazardous substances.',
    `valuation_class` STRING COMMENT 'Financial classification used for inventory valuation and accounting.',
    `volume_cubic_m` DECIMAL(18,2) COMMENT 'Physical volume occupied by a single unit of the material.',
    `width_cm` DECIMAL(18,2) COMMENT 'Width dimension of the material packaging.',
    CONSTRAINT pk_material_master PRIMARY KEY(`material_master_id`)
) COMMENT 'Authoritative catalog of all materials, spare parts, equipment components, and consumables managed in the utility supply chain. Captures material number, description, material group, unit of measure, plant-specific data, MRP type, valuation class, hazardous material flags, and UNSPSC commodity code. Covers MRO parts, generation fuel materials, T&D equipment components, and storm restoration inventory items. Serves as the single reference for material identity, classification, and planning parameters across procurement, inventory, and maintenance processes.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`purchase_order` (
    `purchase_order_id` BIGINT COMMENT 'System-generated unique identifier for the purchase order record.',
    `approved_by_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the PO.',
    `asset_capex_project_id` BIGINT COMMENT 'Identifier of the CAPEX or O&M project associated with the PO.',
    `cost_center_id` BIGINT COMMENT 'Financial cost center to which the PO expense is charged.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Installation and equipment purchase orders are issued per customer account for billing and service tracking.',
    `customer_service_point_id` BIGINT COMMENT 'Foreign key linking to customer.service_point. Business justification: Purchase orders for service installations must be tied to the exact service point where work will occur.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the PO.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: CAPEX procurement for facility construction/maintenance; required for Facility Capital Expenditure Report linking PO to the specific facility.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Capital project procurement of IT assets records the purchased IT asset in the PO for asset registration and depreciation.',
    `large_customer_contract_id` BIGINT COMMENT 'Foreign key linking to engagement.large_customer_contract. Business justification: Required for Contract‑Based Procurement Process: ensures each PO for a large customer is linked to that customers contract for compliance and cost allocation.',
    `last_modified_by_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the latest update.',
    `plant_id` BIGINT COMMENT 'Identifier of the generation or distribution plant receiving the goods/services.',
    `procurement_contract_id` BIGINT COMMENT 'Identifier of the underlying contract (e.g., framework agreement) linked to the PO.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor supplying the goods or services.',
    `wbs_element_id` BIGINT COMMENT 'WBS element for project‑level accounting of the PO.',
    `account_assignment_type` STRING COMMENT 'Method used to assign the PO cost to financial structures.. Valid values are `cost_center|wbs|asset|order|project`',
    `approval_status` STRING COMMENT 'Current approval state of the purchase order.. Valid values are `pending|approved|rejected`',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the PO received approval.',
    `created_timestamp` TIMESTAMP COMMENT 'System timestamp when the PO record was first captured in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the PO amounts. [ENUM-REF-CANDIDATE: USD|EUR|GBP|JPY|CAD|AUD|CHF|CNY|INR|MXN|BRL|ZAR — promote to reference product]',
    `currency_rate` DECIMAL(18,2) COMMENT 'Exchange rate applied when converting PO amounts to the corporate reporting currency.',
    `delivery_date` DATE COMMENT 'Planned date for goods or services to be delivered.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the PO.',
    `is_blanket_release` BOOLEAN COMMENT 'True if this record represents a release against a blanket PO.',
    `is_goods_receipt_required` BOOLEAN COMMENT 'Indicates whether a goods receipt must be posted before invoice processing.',
    `is_three_way_match` BOOLEAN COMMENT 'True when PO, goods receipt, and invoice must all match before payment.',
    `line_count` STRING COMMENT 'Number of line items contained in the purchase order.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final payable amount after tax and discount.',
    `notes` STRING COMMENT 'Additional remarks or special instructions from the buyer.',
    `order_date` TIMESTAMP COMMENT 'Timestamp when the purchase order was created/submitted.',
    `order_status` STRING COMMENT 'Current lifecycle state of the purchase order.. Valid values are `draft|open|approved|rejected|closed|cancelled`',
    `order_type` STRING COMMENT 'Classification of the PO indicating its procurement strategy.. Valid values are `standard|blanket|framework|service|contract|planned`',
    `payment_terms` STRING COMMENT 'Contractual terms defining when payment is due (e.g., Net 30).',
    `po_description` STRING COMMENT 'Free‑text description of the purpose or scope of the PO.',
    `po_number` STRING COMMENT 'External business identifier assigned to the purchase order, used in vendor communications and reporting.',
    `price_condition` STRING COMMENT 'Pricing condition applied to the PO (e.g., net price, gross price).. Valid values are `net|gross|discounted|rebated`',
    `purchasing_org_code` STRING COMMENT 'Code of the internal purchasing organization responsible for the PO.',
    `release_number` STRING COMMENT 'Identifier for a specific release of a blanket or framework PO.',
    `source_system` STRING COMMENT 'Originating ERP or procurement system (e.g., SAP, Oracle).',
    `status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent status transition for the PO.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Total tax calculated for the PO.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applicable to the PO. [ENUM-REF-CANDIDATE: TAX01|TAX02|TAX03|TAX04|TAX05|TAX06|TAX07|TAX08 — promote to reference product]',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross monetary value of the purchase order before taxes, discounts, and adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'System timestamp of the most recent modification to the PO record.',
    `valid_from` DATE COMMENT 'Start date of the POs validity period.',
    `valid_to` DATE COMMENT 'End date of the POs validity period (null if open‑ended).',
    CONSTRAINT pk_purchase_order PRIMARY KEY(`purchase_order_id`)
) COMMENT 'Core procurement transaction representing a formal commitment to a vendor for materials, equipment, fuel, or services. Encompasses header-level data (PO number, type, vendor, plant, purchasing organization, total value, currency, payment terms, approval status) and all line-level detail (line number, material, quantity ordered, unit price, delivery date, account assignment to cost center/WBS element/asset, plant, storage location, goods receipt indicator). Supports standard, blanket, framework, and service PO types. Covers CAPEX project material procurement, fuel supply, O&M materials, and contractor services. Links to requisition as upstream demand signal and to goods_receipt/invoice_verification for downstream fulfillment and three-way match.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`po_line_item` (
    `po_line_item_id` BIGINT COMMENT 'Unique surrogate key for each purchase order line item record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for expense allocation reporting on each PO line; finance cost center tracking is essential for budgeting and regulatory cost reporting.',
    `material_master_id` BIGINT COMMENT 'Master data identifier for the material or service being procured.',
    `material_material_master_id` BIGINT COMMENT 'Master data identifier for the material or service being procured.',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order to which this line belongs.',
    `vendor_id` BIGINT COMMENT 'Supplier providing the material or service.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Enables linking each PO line to the project WBS for capital project accounting and compliance with FERC reporting.',
    `actual_delivery_date` DATE COMMENT 'Date the goods or services were actually received.',
    `approval_status` STRING COMMENT 'Current approval state of the line item.. Valid values are `approved|rejected|pending`',
    `approved_by` STRING COMMENT 'Identifier of the employee who approved the line.',
    `asset_number` STRING COMMENT 'Asset identifier if the line item is capitalized as a fixed asset.',
    `contract_number` STRING COMMENT 'Reference to a purchase contract or framework agreement.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the line record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the transaction currency.. Valid values are `USD|EUR|CAD|GBP|JPY|CHF`',
    `delivery_date` DATE COMMENT 'Date the vendor is expected to deliver the goods or services.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Total discount applied to the line.',
    `external_reference_number` STRING COMMENT 'Vendor‑supplied reference number for the line item.',
    `goods_receipt_indicator` BOOLEAN COMMENT 'True if a goods receipt has been posted for this line.',
    `is_service_item` BOOLEAN COMMENT 'True if the line represents a service rather than a tangible good.',
    `last_receipt_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent goods receipt for this line.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle stage of the line item from planning to retirement.. Valid values are `planned|ordered|received|in_use|retired`',
    `line_amount` DECIMAL(18,2) COMMENT 'Total gross amount for the line (quantity × unit price).',
    `line_number` STRING COMMENT 'Sequential number of the line within the purchase order.',
    `line_status` STRING COMMENT 'Current processing status of the line item.. Valid values are `open|closed|cancelled|pending|rejected`',
    `material_description` STRING COMMENT 'Human‑readable description of the material or service.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value after tax and discount (line_amount + tax_amount - discount_amount).',
    `plant_code` STRING COMMENT 'Organizational plant where the material will be used or stored.',
    `price_variance_percent` DECIMAL(18,2) COMMENT 'Percentage difference between contract price and actual unit price.',
    `procurement_category` STRING COMMENT 'Classification of spend type for the line item.. Valid values are `CAPEX|MRO|FUEL|SERVICE|SPARE|OTHER`',
    `purchase_group` STRING COMMENT 'Organizational group responsible for the purchase.',
    `purchasing_organization` STRING COMMENT 'Legal entity that owns the procurement process.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of the material or service ordered on this line.',
    `receipt_quantity` DECIMAL(18,2) COMMENT 'Quantity that has been received against the ordered quantity.',
    `remarks` STRING COMMENT 'Free‑form comments or notes entered by procurement staff.',
    `requested_delivery_date` DATE COMMENT 'Date requested by the purchasing organization for delivery.',
    `service_end_date` DATE COMMENT 'End date of the contracted service period.',
    `service_start_date` DATE COMMENT 'Start date of the contracted service period.',
    `source_system` STRING COMMENT 'Name of the source system that originated the record (e.g., SAP_MM).',
    `split_indicator` BOOLEAN COMMENT 'True if the original line has been split into multiple lines.',
    `storage_location_code` STRING COMMENT 'Physical storage location within the plant.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Monetary tax amount calculated for the line.',
    `tax_code` STRING COMMENT 'Tax classification code applied to the line.. Valid values are `TX01|TX02|TX03|TX04|TX05|TX06`',
    `unit_of_measure` STRING COMMENT 'Standard unit in which the quantity is expressed.. Valid values are `EA|KG|L|M3|MWH|MCF`',
    `unit_price` DECIMAL(18,2) COMMENT 'Price per unit of the material or service, before taxes and discounts.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the line record.',
    CONSTRAINT pk_po_line_item PRIMARY KEY(`po_line_item_id`)
) COMMENT 'Individual line-level detail of a purchase order, representing a specific material or service being procured. Captures line number, material number, quantity ordered, unit price, delivery date, account assignment (cost center, WBS element, asset), plant, storage location, and goods receipt indicator. Enables line-level tracking of CAPEX material staging, fuel deliveries, and MRO parts procurement.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` (
    `goods_receipt_id` BIGINT COMMENT 'Unique identifier for the goods receipt record.',
    `customer_service_point_id` BIGINT COMMENT 'Foreign key linking to customer.service_point. Business justification: Goods receipt records the location (service point) where delivered equipment is installed for the customer.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the receipt.',
    `received_by_user_employee_id` BIGINT COMMENT 'Identifier of the employee who recorded the receipt.',
    `supplier_vendor_id` BIGINT COMMENT 'Unique identifier of the supplier delivering the goods.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the supplier delivering the goods.',
    `ash_content_percent` DECIMAL(18,2) COMMENT 'Ash percentage by weight in the fuel.',
    `batch_number` STRING COMMENT 'Batch identifier for the received material, if applicable.',
    `btu_content` DECIMAL(18,2) COMMENT 'Energy content of the fuel per unit of measure (BTU).',
    `calorific_value` DECIMAL(18,2) COMMENT 'Heat value of the fuel (e.g., MJ/kg).',
    `carrier_name` STRING COMMENT 'Name of the transportation carrier.',
    `comments` STRING COMMENT 'Additional remarks or notes about the receipt.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `eia_923_reporting_flag` BOOLEAN COMMENT 'Flag indicating if the receipt must be reported to EIA‑923.',
    `expiration_date` DATE COMMENT 'Expiration or best‑before date of the received item, if applicable.',
    `fuel_type` STRING COMMENT 'Type of fuel delivered, if applicable.. Valid values are `coal|natural_gas|uranium|oil|biomass`',
    `goods_receipt_status` STRING COMMENT 'Current processing status of the receipt.. Valid values are `posted|reversed|pending|cancelled`',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total gross monetary value of the received goods before taxes and adjustments.',
    `inspection_date` DATE COMMENT 'Date the quality inspection was completed.',
    `is_three_way_match_completed` BOOLEAN COMMENT 'Indicates whether the three‑way match (PO, receipt, invoice) has been completed.',
    `lot_number` STRING COMMENT 'Lot identifier for fuel or material shipments.',
    `material_number` STRING COMMENT 'Material master identifier for the received item.',
    `movement_type` STRING COMMENT 'ERP movement type that classifies the receipt transaction.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary value after taxes and adjustments.',
    `nrc_chain_of_custody_doc` STRING COMMENT 'Reference to the NRC chain‑of‑custody documentation for nuclear fuel.',
    `pipeline_nomination_confirmed` BOOLEAN COMMENT 'Indicates whether pipeline nomination was confirmed for fuel deliveries.',
    `plant_code` STRING COMMENT 'Code of the plant or facility where the receipt occurred.',
    `posting_date` DATE COMMENT 'Date the receipt was posted to the general ledger.',
    `purchase_order_number` STRING COMMENT 'Purchase order number associated with the receipt.',
    `quality_inspection_status` STRING COMMENT 'Result of the quality inspection performed on receipt.. Valid values are `passed|failed|pending`',
    `quantity_received` DECIMAL(18,2) COMMENT 'Amount of goods received, expressed in the unit of measure.',
    `receipt_number` STRING COMMENT 'Document number assigned to the receipt in the ERP system.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the goods were physically received.',
    `receipt_type` STRING COMMENT 'Category of the received item (e.g., material, equipment, fuel, service).. Valid values are `material|equipment|fuel|service`',
    `received_by_name` STRING COMMENT 'Name of the employee who recorded the receipt.',
    `regulatory_reporting_code` STRING COMMENT 'Code used for regulatory reporting of the receipt event.',
    `serial_number` STRING COMMENT 'Serial number of equipment or component received.',
    `storage_location` STRING COMMENT 'Location within the plant where the goods are stored.',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'Sulfur percentage by weight in the fuel.',
    `supplier_name` STRING COMMENT 'Legal name of the supplier.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount applicable to the receipt.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity received.. Valid values are `kg|m3|pcs|l|bbl`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the receipt record.',
    CONSTRAINT pk_goods_receipt PRIMARY KEY(`goods_receipt_id`)
) COMMENT 'Records the physical receipt and acceptance of all materials, equipment, fuel deliveries, and contractor services against purchase orders at utility plants, warehouses, and staging yards. Captures document number, posting date, receipt type, quantity received, unit of measure, storage location, plant, movement type, and quality inspection status. For generation fuel deliveries: captures fuel type, BTU content, sulfur/ash content (coal), calorific value, supplier, carrier, pipeline nomination confirmation, and EIA-923 reporting fields. For nuclear fuel: captures fuel assembly serial numbers and NRC chain-of-custody documentation. Triggers inventory update and three-way match for invoice verification. Serves as the single source of truth for ALL receipt events across the utility — MRO parts, CAPEX equipment, fuel delivery confirmation at generation plants, and contractor service acceptance.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` (
    `inventory_stock_id` BIGINT COMMENT 'Unique surrogate key for each inventory stock record.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Required for Customer Inventory Allocation: tracks inventory reserved for a specific customer account, supporting service delivery and billing.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Fuel inventory levels are subject to compliance obligations; linking stock to the obligation provides audit linkage.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: IT asset inventory reconciliation requires linking stock records to the corresponding IT asset for depreciation and audit.',
    `material_master_id` BIGINT COMMENT 'FK to supply.material_master',
    `plant_id` BIGINT COMMENT 'Identifier of the generation or processing plant where the stock is located.',
    `vendor_id` BIGINT COMMENT 'Identifier of the supplier providing the material.',
    `warehouse_id` BIGINT COMMENT 'Identifier of the warehouse or storage facility.',
    `batch_number` STRING COMMENT 'Batch identifier for materials tracked by batch.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inventory record was created.',
    `current_unit_price` DECIMAL(18,2) COMMENT 'Most recent unit price of the material.',
    `effective_date` DATE COMMENT 'Date on which the stock quantity becomes effective for reporting.',
    `expiration_date` DATE COMMENT 'Date after which the material is considered expired or unusable.',
    `inventory_stock_status` STRING COMMENT 'Current lifecycle status of the inventory record.. Valid values are `active|inactive|pending`',
    `inventory_valuation_date` DATE COMMENT 'Date of the most recent inventory valuation run.',
    `inventory_valuation_method` STRING COMMENT 'Method used for inventory valuation.. Valid values are `FIFO|LIFO|Weighted_Average`',
    `is_capex_staged` BOOLEAN COMMENT 'Flag indicating material is staged for a capital project.',
    `is_fuel_inventory` BOOLEAN COMMENT 'Flag indicating whether the material is a fuel used for generation.',
    `is_quality_inspection_passed` BOOLEAN COMMENT 'Result of the latest quality inspection for the material.',
    `is_storm_reserve` BOOLEAN COMMENT 'Flag indicating stock reserved for storm restoration activities.',
    `last_issue_date` DATE COMMENT 'Date when the material was last issued or consumed.',
    `last_physical_count_date` DATE COMMENT 'Date when the most recent physical inventory count was performed.',
    `last_physical_count_user` STRING COMMENT 'Identifier of the employee who performed the last physical count.',
    `last_physical_count_variance` DECIMAL(18,2) COMMENT 'Difference between system quantity and counted quantity in the last physical count.',
    `last_receipt_date` DATE COMMENT 'Date when the most recent receipt of the material was recorded.',
    `lot_number` STRING COMMENT 'Lot identifier for materials tracked by lot.',
    `material_category` STRING COMMENT 'High-level grouping of material types for reporting and planning.. Valid values are `raw_material|fuel|spare_part|equipment|consumable`',
    `material_code` STRING COMMENT 'Unique code identifying the material as defined in SAP MM Material Master.',
    `material_description` STRING COMMENT 'Detailed description of the material.',
    `material_name` STRING COMMENT 'Descriptive name of the material.',
    `physical_count_method` STRING COMMENT 'Method used to perform the physical count.. Valid values are `manual|barcode|rfid`',
    `price_control_method` STRING COMMENT 'Method used to determine the unit price of the material.. Valid values are `standard|moving_average`',
    `purchase_order_number` STRING COMMENT 'Reference number of the purchase order that supplied the material.',
    `quality_inspection_date` DATE COMMENT 'Date when the last quality inspection was performed.',
    `quality_inspection_result` STRING COMMENT 'Outcome of the latest quality inspection.. Valid values are `pass|fail|rework`',
    `quantity_on_hand` DECIMAL(18,2) COMMENT 'Current quantity of material available in stock.',
    `reorder_point` DECIMAL(18,2) COMMENT 'Stock level that triggers a replenishment order.',
    `safety_stock_level` DECIMAL(18,2) COMMENT 'Minimum stock buffer to protect against demand variability.',
    `stock_type` STRING COMMENT 'Classification of stock based on availability and usage constraints.. Valid values are `unrestricted|quality_inspection|blocked|in_transit|storm_reserve`',
    `storage_location_code` STRING COMMENT 'Code representing the specific storage location within a warehouse.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity.. Valid values are `kg|lb|m3|kWh|MWh|gal`',
    `unit_price_currency` STRING COMMENT 'Currency of the unit price.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inventory record.',
    `valuation_amount` DECIMAL(18,2) COMMENT 'Monetary value of the stock based on valuation method.',
    CONSTRAINT pk_inventory_stock PRIMARY KEY(`inventory_stock_id`)
) COMMENT 'Real-time and period-end inventory stock positions for materials across all utility plants, warehouses, substations, and staging yards. Captures material, plant, storage location, stock type (unrestricted, quality inspection, blocked, in-transit, storm reserve), quantity on hand, unit of measure, valuation amount, price control method (standard vs. moving average), current unit price, reorder point, safety stock level, and last physical count date/variance. Supports storm restoration readiness (including designated reserve quantities and replenishment triggers), CAPEX project material staging visibility, generation fuel inventory management, and regulatory asset base reporting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`stock_movement` (
    `stock_movement_id` BIGINT COMMENT 'Unique identifier for each stock movement record.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Required for Customer Stock Transfer Log: records movement of inventory on behalf of a customer account, needed for audit and service fulfillment.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Inventory movements must be charged to the appropriate cost center for OPEX tracking and regulatory cost allocation.',
    `location_id` BIGINT COMMENT 'Identifier of the storage location where material was received.',
    `employee_id` BIGINT COMMENT 'Identifier of the user who posted the movement.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Asset relocation workflow records each IT asset movement, needing FK to it_asset for traceability and compliance.',
    `posted_by_user_employee_id` BIGINT COMMENT 'Identifier of the user who posted the movement.',
    `material_master_id` BIGINT COMMENT 'Identifier of the material being moved.',
    `asset_capex_project_id` BIGINT COMMENT 'Project identifier if movement is tied to a CAPEX project.',
    `finance_capex_project_id` BIGINT COMMENT 'Project identifier if movement is tied to a CAPEX project.',
    `source_location_id` BIGINT COMMENT 'Identifier of the storage location where material was issued.',
    `stock_material_master_id` BIGINT COMMENT 'Identifier of the material being moved.',
    `wbs_element_id` BIGINT COMMENT 'Foreign key linking to finance.wbs_element. Business justification: Tracks inventory moves against project WBS elements, supporting capital project cost roll‑up and compliance reporting.',
    `batch_number` STRING COMMENT 'Batch identifier for the material, if applicable.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates if the movement complies with regulatory requirements.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the stock movement record was created in the system.',
    `event_timestamp` TIMESTAMP COMMENT 'Exact time the material movement occurred.',
    `external_order_number` STRING COMMENT 'Vendor or external order reference associated with the movement.',
    `inventory_valuation_amount` DECIMAL(18,2) COMMENT 'Monetary value of the material movement based on valuation price.',
    `is_critical` BOOLEAN COMMENT 'Indicates if the movement is critical for operations (e.g., emergency repair).',
    `lot_number` STRING COMMENT 'Lot identifier for the material, if applicable.',
    `material_description` STRING COMMENT 'Human readable description of the material.',
    `movement_number` STRING COMMENT 'External business identifier for the stock movement transaction.',
    `movement_reason_code` STRING COMMENT 'Code indicating the business reason for the movement (e.g., production, maintenance).',
    `movement_type` STRING COMMENT 'Category of material movement.. Valid values are `issue|transfer|return|scrap|adjustment`',
    `posting_date` DATE COMMENT 'Date the movement was posted to inventory.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of material moved, in the specified unit of measure.',
    `reference_document_number` STRING COMMENT 'Document number linking to the source transaction (e.g., purchase order, work order).',
    `stock_movement_status` STRING COMMENT 'Current processing status of the stock movement.. Valid values are `posted|reversed|pending|cancelled`',
    `storage_condition` STRING COMMENT 'Condition requirements for the material (e.g., temperature-controlled).',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the quantity.. Valid values are `kg|lb|m3|gal|kWh|MWh`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the stock movement record.',
    `valuation_currency` STRING COMMENT 'Currency code (ISO 4217) for the valuation amount.',
    `variance_quantity` DECIMAL(18,2) COMMENT 'Difference between counted quantity and system quantity during reconciliation.',
    `variance_reason` STRING COMMENT 'Explanation for quantity variance.',
    CONSTRAINT pk_stock_movement PRIMARY KEY(`stock_movement_id`)
) COMMENT 'Transactional log of all material movements within and between utility storage locations including goods issues, transfers, returns, scrapping, and physical inventory count adjustments. Captures movement type, material, quantity, source and destination plant/storage location, posting date, reference document, cost center, WBS element, and count variance details for inventory reconciliation postings. Provides full audit trail for inventory changes supporting O&M cost tracking, CAPEX project material consumption, annual inventory reconciliation, and storm restoration readiness audits.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` (
    `procurement_contract_id` BIGINT COMMENT 'System-generated unique identifier for the procurement contract.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Service contracts are tied to a site (e.g., maintenance, fuel supply); required for Site Contract Management and regulatory compliance.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor supplying the commodity or service.',
    `amendment_date` TIMESTAMP COMMENT 'Timestamp when the latest amendment was executed.',
    `amendment_number` STRING COMMENT 'Sequential number of the most recent amendment to the contract.',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract received final approval.',
    `approved_by` STRING COMMENT 'Name or identifier of the individual who approved the contract.',
    `commodity` STRING COMMENT 'Primary commodity or service covered by the contract.. Valid values are `coal|natural_gas|uranium|equipment|services`',
    `compliance_status` STRING COMMENT 'Current compliance standing of the contract with applicable regulations.. Valid values are `compliant|non_compliant|pending|exempt`',
    `confidentiality_level` STRING COMMENT 'Data classification level for the contract document.. Valid values are `public|internal|confidential|restricted`',
    `contract_category` STRING COMMENT 'High‑level classification of the contract purpose.. Valid values are `fuel_supply|equipment_supply|service_agreement|maintenance|construction`',
    `contract_document_url` STRING COMMENT 'Link to the stored electronic copy of the signed contract.',
    `contract_manager` STRING COMMENT 'Person who manages day‑to‑day contract administration.',
    `contract_number` STRING COMMENT 'External contract number assigned by the vendor or utility for reference.',
    `contract_owner` STRING COMMENT 'Business unit or individual responsible for overall contract performance.',
    `contract_scope_description` STRING COMMENT 'Detailed textual description of goods, services, and obligations covered.',
    `contract_status_reason` STRING COMMENT 'Free‑text explanation for the current status (e.g., pending regulatory approval).',
    `contract_type` STRING COMMENT 'Classification of the contract based on its structure and obligations.. Valid values are `value|quantity|framework|scheduling`',
    `contract_version` STRING COMMENT 'Version number of the contract document after each amendment.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the contract record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the contract value (e.g., USD, EUR).',
    `delivery_schedule` STRING COMMENT 'Narrative description of delivery timing, frequency, and milestones.',
    `discount_rate` DECIMAL(18,2) COMMENT 'Percentage discount applied to the base price, if any.',
    `effective_end_date` TIMESTAMP COMMENT 'Timestamp when the contract expires or terminates, if applicable.',
    `effective_start_date` TIMESTAMP COMMENT 'Timestamp when the contract becomes legally binding.',
    `escalation_clause` STRING COMMENT 'Text describing price escalation mechanisms (e.g., CPI linked).',
    `insurance_requirements` STRING COMMENT 'Minimum insurance coverage and certificates required from the vendor.',
    `invoicing_frequency` STRING COMMENT 'How often invoices are issued under the contract.. Valid values are `monthly|quarterly|annually|upon_delivery`',
    `jurisdiction` STRING COMMENT 'Geographic or regulatory jurisdiction governing the contract.',
    `last_amendment_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent amendment change.',
    `notice_period_days` STRING COMMENT 'Number of days notice required for termination or renewal.',
    `payment_terms` STRING COMMENT 'Standard payment terms (e.g., Net 30, 2% 10 Net 30).',
    `performance_bond_amount` DECIMAL(18,2) COMMENT 'Monetary guarantee required from the vendor to ensure performance.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Unit price agreed in the contract, expressed in the contract currency.',
    `pricing_type` STRING COMMENT 'Method used to calculate pricing under the contract.. Valid values are `fixed|variable|indexed|market`',
    `procurement_contract_status` STRING COMMENT 'Current lifecycle status of the contract.. Valid values are `active|inactive|pending|terminated|draft`',
    `quantity` DECIMAL(18,2) COMMENT 'Total quantity of the commodity or service covered by the contract.',
    `renewal_date` TIMESTAMP COMMENT 'Planned date for contract renewal evaluation or execution.',
    `renewal_option` STRING COMMENT 'Whether the contract auto‑renews, requires manual renewal, or does not renew.. Valid values are `auto|manual|none`',
    `risk_rating` STRING COMMENT 'Overall risk rating assigned to the contract based on financial, operational, and compliance factors.. Valid values are `low|medium|high|critical`',
    `termination_date` TIMESTAMP COMMENT 'Date on which either party may terminate the contract, if applicable.',
    `total_contract_value` DECIMAL(18,2) COMMENT 'Aggregate monetary value of the contract over its full term.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the quantity (e.g., MMBtu for gas, ton for coal).. Valid values are `MMBtu|ton|kg|unit|MW|MWh`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the contract record.',
    CONSTRAINT pk_procurement_contract PRIMARY KEY(`procurement_contract_id`)
) COMMENT 'Long-term supply agreements and framework contracts with vendors covering fuel supply (coal, natural gas, uranium), equipment, and services. Captures contract number, contract type (value contract, quantity contract, scheduling agreement), vendor, validity period, total contract value, commodity, pricing conditions, renewal terms, and regulatory filing references (e.g., FERC-jurisdictional gas supply contracts). Distinct from trading PPAs which are owned by the trading domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` (
    `fuel_supply_schedule_id` BIGINT COMMENT 'Unique identifier for the fuel supply schedule record.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Fuel supply schedules are submitted as part of regulatory filings; linking schedule to filing enables compliance verification.',
    `plant_id` BIGINT COMMENT 'Identifier of the generation plant receiving the fuel.',
    `vendor_id` BIGINT COMMENT 'Identifier of the fuel supplier organization.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Fuel deliveries are scheduled to a specific site where the plant resides; essential for Fuel Delivery Compliance reporting.',
    `actual_delivery_timestamp` TIMESTAMP COMMENT 'Actual date and time when the fuel was delivered.',
    `carrier_name` STRING COMMENT 'Name of the carrier or logistics provider handling the delivery.',
    `confirmation_status` STRING COMMENT 'Status of supplier confirmation for the schedule.. Valid values are `pending|confirmed|rejected|awaiting|cancelled`',
    `contract_number` STRING COMMENT 'Reference to the fuel supply contract governing this schedule.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the schedule record was first created in the system.',
    `delivery_window_end` TIMESTAMP COMMENT 'End of the allowed delivery time window.',
    `delivery_window_start` TIMESTAMP COMMENT 'Start of the allowed delivery time window.',
    `fuel_supply_schedule_status` STRING COMMENT 'Current lifecycle status of the fuel delivery schedule.. Valid values are `planned|confirmed|delivered|canceled|postponed|in_transit`',
    `fuel_type` STRING COMMENT 'Type of fuel to be supplied.. Valid values are `coal|natural_gas|uranium|biomass|hydrogen|oil`',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the delivery is critical for plant operation.',
    `last_modified_by` STRING COMMENT 'User identifier who last modified the schedule record.',
    `notes` STRING COMMENT 'Free-text field for additional information or remarks.',
    `price_per_unit` DECIMAL(18,2) COMMENT 'Contracted price per unit of fuel.',
    `priority` STRING COMMENT 'Priority level of the fuel delivery schedule.. Valid values are `high|medium|low`',
    `quantity_unit` STRING COMMENT 'Unit of measure for the quantity value.. Valid values are `tons|mcf|kg|bbl|gallons`',
    `quantity_value` DECIMAL(18,2) COMMENT 'Amount of fuel scheduled for delivery.',
    `regulatory_compliance_code` STRING COMMENT 'Code indicating compliance requirement (e.g., EPA emission code).',
    `schedule_number` STRING COMMENT 'External schedule number assigned by the utility for tracking.',
    `scheduled_delivery_timestamp` TIMESTAMP COMMENT 'Planned date and time when the fuel is expected to be delivered.',
    `source_system` STRING COMMENT 'Source system where the schedule originated, e.g., SAP MM.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total monetary cost for the scheduled fuel quantity.',
    `transportation_mode` STRING COMMENT 'Mode of transport used for fuel delivery.. Valid values are `pipeline|rail|barge|truck|ship|truck_rail_intermodal`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the schedule record.',
    CONSTRAINT pk_fuel_supply_schedule PRIMARY KEY(`fuel_supply_schedule_id`)
) COMMENT 'Planned and confirmed delivery schedules for generation fuels (coal, natural gas, uranium/nuclear fuel) from suppliers to generation plants. Captures schedule number, fuel type, supplier, generation plant, scheduled delivery date, quantity (tons, MCF, or fuel assemblies), transportation mode, pipeline/rail/barge carrier, and confirmation status. Supports generation dispatch planning and IRP fuel cost modeling.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` (
    `fuel_receipt_id` BIGINT COMMENT 'System-generated unique identifier for each fuel receipt record.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Fuel receipts must be reported in EIA 923 filings; the FK ties each receipt to the specific filing record.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the transportation carrier that delivered the fuel.',
    `plant_id` BIGINT COMMENT 'Identifier of the generation plant where fuel was received.',
    `primary_fuel_vendor_id` BIGINT COMMENT 'Unique identifier of the fuel supplier (vendor).',
    `tertiary_fuel_supplier_vendor_id` BIGINT COMMENT 'Unique identifier of the fuel supplier (vendor).',
    `ash_content_percent` DECIMAL(18,2) COMMENT 'Percentage of ash residue remaining after combustion.',
    `btu_content_total` DECIMAL(18,2) COMMENT 'Total heat content of the received fuel batch in BTU.',
    `calorific_value_btu_per_unit` DECIMAL(18,2) COMMENT 'Energy content per unit of fuel measured in BTU.',
    `contract_number` STRING COMMENT 'Reference number of the fuel supply contract governing this receipt.',
    `cost_per_unit` DECIMAL(18,2) COMMENT 'Purchase price per unit of fuel (in the specified currency).',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the fuel receipt record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the transaction.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `delivery_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the delivery location.',
    `delivery_location` STRING COMMENT 'Physical location (e.g., yard, dock) where fuel was received.',
    `delivery_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the delivery location.',
    `eia_923_fuel_code` STRING COMMENT 'Standardized fuel code used for EIA‑923 reporting.',
    `eia_923_reporting_month` DATE COMMENT 'Month for which the fuel receipt is reported to EIA‑923.',
    `fuel_receipt_status` STRING COMMENT 'Current lifecycle status of the fuel receipt.. Valid values are `received|rejected|pending|cancelled`',
    `fuel_type` STRING COMMENT 'Classification of the fuel received.. Valid values are `coal|natural_gas|uranium|oil|biomass|hydrogen`',
    `gross_weight_tons` DECIMAL(18,2) COMMENT 'Total weight of the fuel batch before tare subtraction.',
    `invoice_number` STRING COMMENT 'Invoice issued by the supplier for the fuel receipt.',
    `is_quality_approved` BOOLEAN COMMENT 'Indicates whether the fuel passed quality inspection.',
    `moisture_content_percent` DECIMAL(18,2) COMMENT 'Percentage of moisture present in the fuel batch.',
    `net_weight_tons` DECIMAL(18,2) COMMENT 'Weight of the fuel after subtracting tare weight.',
    `purchase_order_number` STRING COMMENT 'Purchase order identifier associated with the fuel delivery.',
    `quality_approval_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel quality was approved.',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of fuel received expressed in the unit indicated by unit_of_measure.',
    `receipt_number` STRING COMMENT 'Business identifier assigned by the procurement system for the fuel receipt.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date and time when the fuel was physically received at the plant gate.',
    `remarks` STRING COMMENT 'Free‑form notes or comments about the receipt.',
    `sulfur_content_percent` DECIMAL(18,2) COMMENT 'Percentage of sulfur present in the fuel batch.',
    `supplier_name` STRING COMMENT 'Legal name of the fuel supplier.',
    `tare_weight_tons` DECIMAL(18,2) COMMENT 'Weight of the container or vehicle without fuel.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax applied to the fuel purchase.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction or type applied.',
    `temperature_celsius` DECIMAL(18,2) COMMENT 'Ambient temperature at the time of fuel delivery.',
    `total_cost` DECIMAL(18,2) COMMENT 'Total monetary amount paid for the fuel receipt (quantity × cost_per_unit).',
    `unit_of_measure` STRING COMMENT 'Unit used for the quantity field (e.g., tons, MCF, MWh).. Valid values are `tons|mcf|mwh`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the fuel receipt record.',
    CONSTRAINT pk_fuel_receipt PRIMARY KEY(`fuel_receipt_id`)
) COMMENT 'Records actual delivery and receipt of generation fuels at plant gate including coal yard receipts, natural gas pipeline nominations confirmed, and nuclear fuel assembly deliveries. Captures receipt date, fuel type, quantity received (tons, MCF, MWh equivalent), BTU content, sulfur content, ash content (coal quality), calorific value, supplier, carrier, and EIA-923 reporting fields. Feeds generation cost accounting and regulatory fuel cost reporting.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`requisition` (
    `requisition_id` BIGINT COMMENT 'System-generated unique identifier for the requisition record.',
    `approver_employee_id` BIGINT COMMENT 'Identifier of the person who approved the requisition.',
    `approver_id` BIGINT COMMENT 'Identifier of the person who approved the requisition.',
    `asset_capex_project_id` BIGINT COMMENT 'Identifier of the capital or maintenance project associated with the requisition.',
    `budget_line_id` BIGINT COMMENT 'Identifier of the budget line item to which the requisition expense is allocated.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or department member who created the requisition.',
    `requisition_employee_id` BIGINT COMMENT 'Identifier of the employee or department member who created the requisition.',
    `actual_delivery_date` DATE COMMENT 'Date the goods were actually delivered.',
    `approval_date` TIMESTAMP COMMENT 'Timestamp when the requisition was approved.',
    `approval_status` STRING COMMENT 'Current approval state of the requisition.. Valid values are `pending|approved|rejected`',
    `attached_document_flag` BOOLEAN COMMENT 'True if supporting documents (e.g., specifications) are attached.',
    `compliance_review_required` BOOLEAN COMMENT 'Indicates whether the requisition must undergo regulatory or safety compliance review.',
    `contract_number` STRING COMMENT 'Reference to an existing contract or purchase agreement, if applicable.',
    `cost_center_code` STRING COMMENT 'Financial cost center to which the requisition expense will be charged.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the monetary values (e.g., USD, EUR).',
    `delivery_address` STRING COMMENT 'Physical address for delivery when a location code is insufficient.',
    `delivery_location_code` STRING COMMENT 'Code identifying the plant, substation, or warehouse where goods are to be delivered.',
    `department_code` STRING COMMENT 'Code representing the internal department requesting the goods or services.',
    `estimated_gross_amount` DECIMAL(18,2) COMMENT 'Pre‑tax estimated monetary value of the requisition.',
    `estimated_net_amount` DECIMAL(18,2) COMMENT 'Estimated total after tax (gross minus tax).',
    `estimated_tax_amount` DECIMAL(18,2) COMMENT 'Estimated tax component of the requisition value.',
    `external_reference_number` STRING COMMENT 'Reference number from an external system (e.g., vendor quote ID).',
    `last_status_change_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent change to the requisition status.',
    `material_service_code` STRING COMMENT 'Catalog or service code for the requested item.',
    `material_service_description` STRING COMMENT 'Human‑readable description of the material or service being requested.',
    `notes` STRING COMMENT 'Free‑form text field for additional information or special instructions.',
    `payment_terms` STRING COMMENT 'Standard payment terms for the purchase (e.g., Net 30).',
    `priority_level` STRING COMMENT 'Business priority assigned to the requisition.. Valid values are `low|medium|high|critical`',
    `procurement_type` STRING COMMENT 'Indicates whether the requisition is part of planned procurement, ad‑hoc, or emergency response.. Valid values are `planned|unplanned|emergency`',
    `quantity` DECIMAL(18,2) COMMENT 'Amount of the material or service requested.',
    `receipt_confirmed_flag` BOOLEAN COMMENT 'True when the receiving department has confirmed receipt of the items.',
    `receipt_expected_date` DATE COMMENT 'Date the receiving department expects the goods to arrive.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the requisition record was first captured in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the requisition record.',
    `request_timestamp` TIMESTAMP COMMENT 'Date and time when the requisition was initially submitted.',
    `required_delivery_date` DATE COMMENT 'Date by which the requested goods or services must be delivered.',
    `requisition_number` STRING COMMENT 'Business identifier assigned to the requisition (e.g., PR-2023-000123).',
    `requisition_status` STRING COMMENT 'Current lifecycle status of the requisition.. Valid values are `draft|submitted|approved|rejected|cancelled|fulfilled`',
    `shipping_method` STRING COMMENT 'Preferred shipping method (e.g., truck, rail, air).',
    `source_system` STRING COMMENT 'Source ERP or procurement system where the requisition originated.. Valid values are `SAP|Oracle|Other`',
    `unit_of_measure` STRING COMMENT 'Unit of measure for the requested quantity (e.g., EA, KG, M3).',
    `updated_by` STRING COMMENT 'User ID of the system account that last modified the requisition record.',
    `urgency_flag` BOOLEAN COMMENT 'True if the requisition requires expedited handling.',
    `vendor_preferred_flag` BOOLEAN COMMENT 'True if the requisition specifies a preferred vendor.',
    `wbs_element` STRING COMMENT 'WBS element identifier linking the requisition to a capital project or maintenance work package.',
    `created_by` STRING COMMENT 'User ID of the system account that created the requisition record.',
    CONSTRAINT pk_requisition PRIMARY KEY(`requisition_id`)
) COMMENT 'Internal purchase requisition initiated by utility departments (generation, T&D, asset management, workforce) requesting procurement of materials or services. Captures requisition number, requester, department, cost center, WBS element, material or service description, quantity, estimated value, required delivery date, and approval workflow status. Precedes and triggers purchase order creation. Supports both planned procurement (maintenance schedules, project material lists) and unplanned/emergency requests (storm restoration, equipment failure).';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`rfq` (
    `rfq_id` BIGINT COMMENT 'System-generated unique identifier for the RFQ record.',
    `approved_by_employee_id` BIGINT COMMENT 'Identifier of the person who approved the RFQ.',
    `business_entity_id` BIGINT COMMENT 'Identifier of the internal organization issuing the RFQ.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: RFQ budgeting requires assignment to a cost center for spend authority and audit trail in procurement.',
    `location_id` BIGINT COMMENT 'Reference to the location where goods or services are to be delivered.',
    `employee_id` BIGINT COMMENT 'Identifier of the person who approved the RFQ.',
    `vendor_id` BIGINT COMMENT 'System identifier of the vendor selected as the awardee.',
    `approval_status` STRING COMMENT 'Current approval state of the RFQ.. Valid values are `not_approved|approved|rejected`',
    `approved_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ received final approval.',
    `award_date` DATE COMMENT 'Date on which the RFQ was awarded to a vendor.',
    `award_status` STRING COMMENT 'Current status of the award decision for the RFQ.. Valid values are `pending|awarded|rejected`',
    `budget_code` STRING COMMENT 'Internal budgeting code associated with the RFQ.',
    `commodity` STRING COMMENT 'Primary commodity or service being sourced through the RFQ. [ENUM-REF-CANDIDATE: coal|natural_gas|uranium|solar|wind|equipment|services — 7 candidates stripped; promote to reference product]',
    `contract_term_months` STRING COMMENT 'Duration of the contract in months.',
    `contract_type` STRING COMMENT 'Nature of the contract to be executed after award.. Valid values are `fixed_price|cost_plus|time_and_materials`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the RFQ record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `^[A-Z]{3}$`',
    `evaluation_criteria` STRING COMMENT 'Factors and weighting used to assess vendor quotations.',
    `financial_compliance_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) reflecting financial compliance of the winning quotation.',
    `has_attachments` BOOLEAN COMMENT 'Indicates whether supporting documents are attached to the RFQ.',
    `issue_timestamp` TIMESTAMP COMMENT 'Date and time when the RFQ was officially issued.',
    `issuing_department` STRING COMMENT 'Name of the department within the organization that created the RFQ.',
    `issuing_organization_code` BIGINT COMMENT 'Identifier of the internal organization issuing the RFQ.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net monetary total after tax and any adjustments.',
    `notes` STRING COMMENT 'Free‑form notes or comments captured by the procurement team.',
    `payment_terms` STRING COMMENT 'Standard payment conditions (e.g., Net 30, 2% 10 Net 30).',
    `procurement_category` STRING COMMENT 'Business classification of the procurement (e.g., capital, operational).. Valid values are `CAPEX|OPEX|maintenance|storm_restoration`',
    `quantity` DECIMAL(18,2) COMMENT 'Quantity of the commodity or service requested.',
    `required_delivery_date` DATE COMMENT 'Date by which the delivered goods/services must be received.',
    `rfq_description` STRING COMMENT 'Detailed narrative describing the requirements, specifications, and scope of the RFQ.',
    `rfq_number` STRING COMMENT 'Business identifier assigned to the RFQ, used in external communications.',
    `rfq_status` STRING COMMENT 'Current lifecycle state of the RFQ.. Valid values are `draft|issued|closed|cancelled|awarded`',
    `source_system` STRING COMMENT 'Originating source system for the RFQ record (e.g., SAP_MM).',
    `submission_deadline` TIMESTAMP COMMENT 'Final date and time by which vendors must submit their quotations.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Estimated tax component associated with the RFQ.',
    `technical_compliance_score` DECIMAL(18,2) COMMENT 'Numeric score (0‑100) reflecting technical compliance of the winning quotation.',
    `title` STRING COMMENT 'Brief descriptive title of the RFQ for quick identification.',
    `total_estimated_amount` DECIMAL(18,2) COMMENT 'Gross monetary value estimated for the RFQ before adjustments.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the requested quantity.. Valid values are `MWh|kWh|MW|MCF|Therm|Each`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the RFQ record.',
    `validity_end_date` DATE COMMENT 'Date after which vendor quotations expire.',
    `validity_start_date` DATE COMMENT 'Date from which vendor quotations are considered valid.',
    `version` STRING COMMENT 'Version number for revisions of the RFQ.',
    CONSTRAINT pk_rfq PRIMARY KEY(`rfq_id`)
) COMMENT 'Manages the full competitive sourcing lifecycle from Request for Quotation issuance through vendor bid submission, evaluation, and award. Captures RFQ number, commodity description, issuing purchasing organization, bid submission deadline, evaluation criteria, invited vendors, and status. Encompasses all vendor-submitted quotations as child records including quotation number, line-item pricing, validity period, delivery lead time, payment terms, and technical compliance scoring. Enables price comparison, vendor selection, and least-cost procurement analysis for rate case filings. Supports competitive procurement for major CAPEX equipment, fuel supply contracts, and storm restoration services.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` (
    `vendor_quotation_id` BIGINT COMMENT 'System-generated unique identifier for the vendor quotation record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Vendor quotations are evaluated against cost center budgets; linking ensures accurate financial commitment tracking.',
    `opportunity_id` BIGINT COMMENT 'Foreign key linking to engagement.opportunity. Business justification: Required for Opportunity Evaluation Report: vendor quotations are evaluated against a sales opportunity to select a solution and finalize pricing.',
    `rfq_id` BIGINT COMMENT 'Identifier of the RFQ to which this quotation responds.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor who submitted the quotation.',
    `approval_date` DATE COMMENT 'Date the quotation was approved for award consideration.',
    `approval_status` STRING COMMENT 'Current approval workflow state for the quotation.. Valid values are `pending|approved|rejected`',
    `attachment_url` STRING COMMENT 'Link to the scanned PDF or digital copy of the vendor quotation.',
    `comments` STRING COMMENT 'Free‑form notes or remarks added by procurement analysts.',
    `contract_reference` STRING COMMENT 'Identifier of the downstream contract that may be created from this quotation.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the quotation record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the quotation amounts.. Valid values are `USD|EUR|GBP|CAD|JPY|AUD`',
    `delivery_lead_time_days` STRING COMMENT 'Estimated number of days from order receipt to delivery of goods/services.',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discount offered by the vendor within the quotation.',
    `expiration_date` DATE COMMENT 'Date after which the quotation is no longer valid, regardless of the validity period.',
    `is_discount_applicable` BOOLEAN COMMENT 'True if the discount amount can be applied to the net total.',
    `is_price_fixed` BOOLEAN COMMENT 'Indicates whether the quoted price is locked for the validity period.',
    `is_tax_included` BOOLEAN COMMENT 'True if tax is already incorporated in the total amount.',
    `line_item_count` STRING COMMENT 'Number of individual line‑item entries included in the quotation.',
    `net_amount` DECIMAL(18,2) COMMENT 'Net amount after tax and discount adjustments.',
    `payment_terms` STRING COMMENT 'Standard payment condition offered by the vendor.. Valid values are `net_30|net_60|net_90|upon_delivery`',
    `procurement_category` STRING COMMENT 'High‑level classification of the goods or services being quoted.. Valid values are `fuel|equipment|services|software|consulting`',
    `quotation_number` STRING COMMENT 'Business identifier assigned to the quotation by the procurement system.',
    `quotation_type` STRING COMMENT 'Classification of the quotation based on its content focus.. Valid values are `price|technical|combined`',
    `source_system` STRING COMMENT 'Originating system that supplied the quotation data (e.g., SAP_MM).',
    `submission_date` DATE COMMENT 'Date the quotation was formally submitted to the procuring organization.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component included in the quotation.',
    `technical_compliance_notes` STRING COMMENT 'Vendors statements regarding compliance with technical specifications and standards.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross amount quoted before taxes, discounts, or adjustments.',
    `updated_by` STRING COMMENT 'User identifier of the employee who last modified the quotation record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the quotation record.',
    `validity_end_date` DATE COMMENT 'Last date on which the quotation can be accepted.',
    `validity_start_date` DATE COMMENT 'First date on which the quotation is considered valid.',
    `vendor_quotation_status` STRING COMMENT 'Current lifecycle status of the quotation.. Valid values are `draft|submitted|approved|rejected|expired`',
    `created_by` STRING COMMENT 'User identifier of the employee who created the quotation record.',
    CONSTRAINT pk_vendor_quotation PRIMARY KEY(`vendor_quotation_id`)
) COMMENT 'Vendor-submitted price quotation in response to an RFQ. Captures quotation number, vendor, RFQ reference, line-item pricing, validity period, delivery lead time, payment terms, and technical compliance notes. Enables price comparison and vendor selection for procurement awards. Supports least-cost procurement analysis for rate case filings.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` (
    `vendor_performance_id` BIGINT COMMENT 'System-generated unique identifier for each vendor performance evaluation record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who performed the evaluation.',
    `evaluator_employee_id` BIGINT COMMENT 'Identifier of the employee who performed the evaluation.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor being evaluated.',
    `comments` STRING COMMENT 'Free-text comments or observations from the evaluator.',
    `commodity_category` STRING COMMENT 'Primary commodity supplied by the vendor for this evaluation.. Valid values are `coal|natural_gas|uranium|renewable|oil|other`',
    `corrective_action_status` STRING COMMENT 'Current status of any corrective actions required from the evaluation.. Valid values are `none|open|closed|in_progress`',
    `evaluation_number` STRING COMMENT 'External reference number assigned to the performance evaluation (e.g., VP-2023-Q1-001).',
    `evaluation_period_end` DATE COMMENT 'Last day of the period covered by this performance evaluation.',
    `evaluation_period_start` DATE COMMENT 'First day of the period covered by this performance evaluation.',
    `evaluation_timestamp` TIMESTAMP COMMENT 'Date and time when the evaluation was performed or recorded.',
    `evaluation_type` STRING COMMENT 'Frequency of the evaluation (annual, quarterly, or monthly).. Valid values are `annual|quarterly|monthly`',
    `invoice_accuracy_rate` DECIMAL(18,2) COMMENT 'Percentage of invoices that matched contract terms without discrepancies.',
    `on_time_delivery_rate` DECIMAL(18,2) COMMENT 'Percentage of deliveries that arrived on or before the promised date.',
    `overall_score` DECIMAL(18,2) COMMENT 'Aggregated score (0-100) summarizing vendor performance across all metrics.',
    `quality_rejection_rate` DECIMAL(18,2) COMMENT 'Percentage of delivered items rejected due to quality issues.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when this performance record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to this performance record.',
    `safety_incident_count` STRING COMMENT 'Number of safety incidents reported for the vendor during the evaluation period.',
    `vendor_performance_status` STRING COMMENT 'Current lifecycle status of the performance evaluation.. Valid values are `pending|completed|in_review|rejected`',
    CONSTRAINT pk_vendor_performance PRIMARY KEY(`vendor_performance_id`)
) COMMENT 'Periodic supplier performance evaluation records tracking delivery reliability, quality, pricing compliance, and service levels for utility vendors. Captures evaluation period, vendor, commodity category, on-time delivery rate, quality rejection rate, invoice accuracy rate, safety incident count, overall score, and corrective action status. Supports vendor qualification, contract renewal decisions, and supply chain risk management.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` (
    `invoice_verification_id` BIGINT COMMENT 'System-generated unique identifier for each invoice verification record.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee or system user who performed the verification.',
    `goods_receipt_id` BIGINT COMMENT 'Identifier of the goods receipt record confirming receipt of materials.',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order linked to the invoice for three‑way matching.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor whose invoice is being verified.',
    `verification_user_employee_id` BIGINT COMMENT 'Identifier of the employee or system user who performed the verification.',
    `commodity_category` STRING COMMENT 'Classification of the material or fuel being procured.. Valid values are `coal|natural_gas|uranium|renewable|oil`',
    `contract_number` STRING COMMENT 'Reference to the procurement contract governing the purchase.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the verification record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the invoice amounts. [ENUM-REF-CANDIDATE: USD|EUR|CAD|GBP|JPY|AUD|... — promote to reference product]',
    `discrepancy_description` STRING COMMENT 'Free‑text explanation of the discrepancy.',
    `discrepancy_type` STRING COMMENT 'Category of mismatch identified during three‑way matching.. Valid values are `quantity|price|tax|missing|duplicate|other`',
    `due_date` DATE COMMENT 'Date by which payment must be made according to contract terms.',
    `gross_amount` DECIMAL(18,2) COMMENT 'Total amount billed on the vendor invoice before taxes and adjustments.',
    `invoice_date` DATE COMMENT 'Date the vendor issued the invoice.',
    `invoice_number` STRING COMMENT 'Vendor‑assigned invoice document number.',
    `invoiced_quantity` DECIMAL(18,2) COMMENT 'Quantity recorded on the vendor invoice.',
    `matched_quantity` DECIMAL(18,2) COMMENT 'Quantity that successfully matched between PO, GR, and invoice.',
    `net_amount` DECIMAL(18,2) COMMENT 'Invoice amount after tax and any discounts, representing the payable sum.',
    `payment_block_flag` BOOLEAN COMMENT 'Indicates whether payment on the invoice is blocked due to unresolved issues.',
    `po_quantity` DECIMAL(18,2) COMMENT 'Quantity originally ordered on the purchase order.',
    `posting_date` DATE COMMENT 'Date the verification record was posted to the procurement ledger.',
    `posting_status` STRING COMMENT 'State of posting the verification result to the financial system.. Valid values are `not_posted|posted|error`',
    `receipt_location` STRING COMMENT 'Plant or site code where the goods were received.',
    `receipt_quantity` DECIMAL(18,2) COMMENT 'Quantity of material recorded on the goods receipt.',
    `receipt_timestamp` TIMESTAMP COMMENT 'Date‑time when the goods receipt was recorded in the system.',
    `source_system` STRING COMMENT 'Originating operational system for the invoice data.. Valid values are `SAP_MM|Oracle_CC&B|Custom`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component captured on the invoice.',
    `tax_code` STRING COMMENT 'Code representing the tax jurisdiction and rate applied.',
    `tax_exempt_code` STRING COMMENT 'Code identifying the reason or authority for tax exemption.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the invoice is tax‑exempt.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for quantities (e.g., MWh, MCF, kg).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the verification record.',
    `verification_notes` STRING COMMENT 'Additional comments or observations captured during verification.',
    `verification_number` STRING COMMENT 'Human‑readable identifier assigned to the verification transaction for tracking and reference.',
    `verification_status` STRING COMMENT 'Current lifecycle state of the verification process.. Valid values are `pending|matched|mismatched|blocked|posted`',
    `verification_timestamp` TIMESTAMP COMMENT 'Exact date‑time when the verification was performed.',
    CONSTRAINT pk_invoice_verification PRIMARY KEY(`invoice_verification_id`)
) COMMENT 'Logistics invoice verification records matching vendor invoices against purchase orders and goods receipts (three-way match). Captures invoice document number, vendor, invoice date, PO reference, GR reference, invoiced amount, tax amount, payment block status, discrepancy type, and posting status. Enables automated and manual matching for payment release. Distinct from financial AP invoices owned by the finance domain — this product owns the procurement-side matching logic and discrepancy resolution.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`warehouse` (
    `warehouse_id` BIGINT COMMENT 'System generated unique identifier for the warehouse record.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Warehouse operating expenses are allocated to a cost center for internal cost accounting and regulatory reporting.',
    `site_id` BIGINT COMMENT 'Foreign key linking to property.site. Business justification: Warehouse location is physically on a site; needed for Site Asset Management and inventory allocation reports.',
    `access_control_method` STRING COMMENT 'Mechanism used to control entry to the warehouse.. Valid values are `badge|biometric|keycard|pin|none`',
    `address_line1` STRING COMMENT 'Primary street address of the warehouse.',
    `address_line2` STRING COMMENT 'Secondary address information (suite, building, etc.).',
    `capacity_total_cubic_m` DECIMAL(18,2) COMMENT 'Maximum storage volume the warehouse can hold, expressed in cubic meters.',
    `capacity_utilized_cubic_m` DECIMAL(18,2) COMMENT 'Current occupied volume within the warehouse.',
    `city` STRING COMMENT 'City where the warehouse is located.',
    `climate_control_flag` BOOLEAN COMMENT 'Indicates if the warehouse has climate‑control systems (true/false).',
    `closing_date` DATE COMMENT 'Date the warehouse was decommissioned or closed (null if still active).',
    `country` STRING COMMENT 'Three‑letter ISO country code of the warehouse location.. Valid values are `^[A-Z]{3}$`',
    `fire_suppression_type` STRING COMMENT 'Type of fire suppression system installed.. Valid values are `sprinkler|foam|gas|none`',
    `gis_coordinates` STRING COMMENT 'Well‑known text representation of the warehouse footprint for GIS mapping.',
    `hazmat_certification_number` STRING COMMENT 'Regulatory certification number for hazardous‑material storage.',
    `hazmat_storage_certified_flag` BOOLEAN COMMENT 'True if the warehouse is certified to store hazardous materials.',
    `humidity_control_max_percent` DECIMAL(18,2) COMMENT 'Highest relative humidity level the warehouse can maintain.',
    `humidity_control_min_percent` DECIMAL(18,2) COMMENT 'Lowest relative humidity level the warehouse can maintain.',
    `inventory_audit_status` STRING COMMENT 'Result of the latest inventory audit.. Valid values are `passed|failed|pending|deferred`',
    `last_inventory_audit_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent physical inventory audit.',
    `latitude` DOUBLE COMMENT 'Geographic latitude coordinate of the warehouse.',
    `longitude` DOUBLE COMMENT 'Geographic longitude coordinate of the warehouse.',
    `maintenance_schedule` STRING COMMENT 'Standard frequency for preventive maintenance activities.. Valid values are `monthly|quarterly|annual|as_needed`',
    `manager_name` STRING COMMENT 'Name of the person managing day‑to‑day warehouse operations.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or special instructions.',
    `opening_date` DATE COMMENT 'Date the warehouse became operational.',
    `ownership_type` STRING COMMENT 'Indicates whether the warehouse is owned, leased, or a joint‑venture asset.. Valid values are `owned|leased|joint`',
    `postal_code` STRING COMMENT 'ZIP or postal code for the warehouse address.. Valid values are `^d{5}(-d{4})?$`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the warehouse record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the warehouse record.',
    `responsible_department` STRING COMMENT 'Department that owns operational responsibility for the warehouse.',
    `security_level` STRING COMMENT 'Security classification of the warehouse based on asset criticality.. Valid values are `low|medium|high|critical`',
    `state` STRING COMMENT 'State or province of the warehouse location.',
    `temperature_control_max_celsius` DECIMAL(18,2) COMMENT 'Highest temperature the climate‑control system can maintain.',
    `temperature_control_min_celsius` DECIMAL(18,2) COMMENT 'Lowest temperature the climate‑control system can maintain.',
    `warehouse_code` STRING COMMENT 'Unique alphanumeric code used in ERP to reference the warehouse.. Valid values are `^[A-Z0-9]{3,10}$`',
    `warehouse_name` STRING COMMENT 'Human‑readable name of the warehouse or storage location.',
    `warehouse_status` STRING COMMENT 'Current lifecycle status of the warehouse.. Valid values are `active|inactive|closed|maintenance|planned`',
    `warehouse_type` STRING COMMENT 'Classification of the warehouse based on its function and mobility.. Valid values are `central|field|mobile|storm_trailer|laydown`',
    CONSTRAINT pk_warehouse PRIMARY KEY(`warehouse_id`)
) COMMENT 'Master record for utility warehouses, storerooms, laydown yards, staging areas, and mobile storm trailers where materials and equipment are stored. Captures warehouse number, description, location (plant, address, GIS coordinates), warehouse type (central, field, mobile), capacity, climate control flag, hazmat storage certification, responsible cost center, and granular storage locations within (bins, racks, yards with capacity and utilization tracking). Supports inventory positioning for storm restoration, CAPEX project staging, and generation plant fuel storage areas.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`shipment` (
    `shipment_id` BIGINT COMMENT 'System-generated unique identifier for the shipment record.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Required for Delivery Tracking Dashboard: ties each shipment to the receiving customer account, supporting delivery status, billing, and regulatory reporting.',
    `customer_account_id` BIGINT COMMENT 'Foreign key linking to customer.customer_account. Business justification: Shipments of equipment or materials are associated with the customer account they serve for tracking and invoicing.',
    `location_id` BIGINT COMMENT 'Identifier of the destination facility or site.',
    `filing_id` BIGINT COMMENT 'Foreign key linking to regulatory.filing. Business justification: Hazardous material shipments must be reported in regulatory filings; the FK connects each shipment to its filing.',
    `network_device_id` BIGINT COMMENT 'Foreign key linking to technology.network_device. Business justification: Capital project asset acquisition tracks each network device shipment to ensure proper installation and NERC CIP compliance.',
    `origin_location_id` BIGINT COMMENT 'Identifier of the origin facility or site.',
    `vendor_id` BIGINT COMMENT 'Identifier of the vendor supplying the shipped material.',
    `purchase_order_id` BIGINT COMMENT 'Identifier of the purchase order linked to this shipment.',
    `shipment_carrier_vendor_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for the shipment.',
    `shipment_vendor_id` BIGINT COMMENT 'Identifier of the transportation carrier responsible for the shipment.',
    `actual_arrival_date` DATE COMMENT 'Date the shipment actually arrived at the destination.',
    `bill_of_lading_number` STRING COMMENT 'Official bill of lading reference for the shipment.',
    `carrier_contact_email` STRING COMMENT 'Primary email address for carrier communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `carrier_contact_phone` STRING COMMENT 'Primary phone number for carrier communications.',
    `container_number` STRING COMMENT 'Identifier of the shipping container used.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the shipment record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `^[A-Z]{3}$`',
    `customs_clearance_status` STRING COMMENT 'Current status of customs processing for the shipment.. Valid values are `pending|cleared|rejected`',
    `customs_document_number` STRING COMMENT 'Reference number of the customs documentation.',
    `customs_tariff_code` STRING COMMENT 'HS tariff code applied to the shipment for customs duties.',
    `delay_reason` STRING COMMENT 'Explanation for any delay in shipment delivery.',
    `destination_address` STRING COMMENT 'Street address of the shipment destination.',
    `expected_arrival_date` DATE COMMENT 'Planned date for shipment arrival at the destination.',
    `freight_cost` DECIMAL(18,2) COMMENT 'Base freight charge for the shipment before taxes and fees.',
    `freight_terms` STRING COMMENT 'Incoterms governing responsibility and cost allocation.. Valid values are `FOB|CIF|EXW|DDP`',
    `hazmat_class` STRING COMMENT 'Classification of hazardous material per UN standards. [ENUM-REF-CANDIDATE: class_1|class_2|class_3|class_4|class_5|class_6|class_7|class_8|class_9 — promote to reference product]',
    `hazmat_flag` BOOLEAN COMMENT 'Indicates whether the shipment contains hazardous materials.',
    `insurance_coverage_flag` BOOLEAN COMMENT 'Indicates whether the shipment is covered by insurance.',
    `insurance_policy_number` STRING COMMENT 'Policy number for the shipments insurance coverage.',
    `is_expedited` BOOLEAN COMMENT 'Indicates whether the shipment is being expedited.',
    `origin_address` STRING COMMENT 'Street address of the shipment origin.',
    `refrigeration_flag` BOOLEAN COMMENT 'Indicates whether the shipment uses refrigerated equipment.',
    `required_temperature_c` DECIMAL(18,2) COMMENT 'Target temperature for temperature‑controlled shipments.',
    `ship_date` DATE COMMENT 'Date the shipment was dispatched from the origin.',
    `shipment_number` STRING COMMENT 'External reference number assigned to the shipment by the logistics system.',
    `shipment_status` STRING COMMENT 'Current processing state of the shipment.. Valid values are `planned|in_transit|delivered|cancelled|exception`',
    `special_handling_instructions` STRING COMMENT 'Free‑text field for any additional handling requirements.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax applied to the freight cost.',
    `temperature_control_flag` BOOLEAN COMMENT 'Indicates if temperature control is required for the shipment.',
    `total_amount` DECIMAL(18,2) COMMENT 'Total monetary value of the shipment (freight + tax).',
    `tracking_number` STRING COMMENT 'Carrier-provided tracking identifier for the shipment.',
    `transportation_mode` STRING COMMENT 'Mode of transport used for the shipment.. Valid values are `truck|rail|barge|pipeline|air`',
    `un_number` STRING COMMENT 'Four‑digit United Nations number identifying the hazardous material.. Valid values are `^[0-9]{4}$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the shipment record.',
    `volume_cubic_m` DECIMAL(18,2) COMMENT 'Total cubic meter volume of the shipment.',
    `weight_kg` DECIMAL(18,2) COMMENT 'Total weight of the shipment in kilograms.',
    CONSTRAINT pk_shipment PRIMARY KEY(`shipment_id`)
) COMMENT 'Inbound and outbound logistics shipment records tracking the physical movement of materials and equipment to/from utility facilities. Captures shipment number, carrier, origin, destination, ship date, expected arrival, actual arrival, freight cost, transportation mode (truck, rail, barge, pipeline), tracking number, and hazmat placard requirements. Supports fuel delivery logistics and CAPEX equipment delivery tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` (
    `service_entry_sheet_id` BIGINT COMMENT 'System-generated unique identifier for the service entry sheet record.',
    `ci_account_id` BIGINT COMMENT 'Foreign key linking to engagement.ci_account. Business justification: Required for Service Billing Report: links each service entry to the customer account it serves, enabling accurate invoicing and service performance tracking.',
    `employee_id` BIGINT COMMENT 'Identifier of the employee who approved the service entry sheet.',
    `finance_capex_project_id` BIGINT COMMENT 'Identifier of the capital project to which the service is charged.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: IT service billing uses service entry sheets linked to the IT service catalog for cost allocation and SLA tracking.',
    `location_id` BIGINT COMMENT 'Identifier of the physical location where the service was performed.',
    `posted_by_user_employee_id` BIGINT COMMENT 'Identifier of the system user who posted the entry sheet.',
    `primary_service_employee_id` BIGINT COMMENT 'Identifier of the employee who approved the service entry sheet.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor who performed the service.',
    `work_order_id` BIGINT COMMENT 'Work order that triggered the service activity.',
    `acceptance_status` STRING COMMENT 'Indicates whether the service has been accepted, rejected, or is pending acceptance.. Valid values are `accepted|rejected|pending`',
    `approved_timestamp` TIMESTAMP COMMENT 'Timestamp when the service entry sheet received formal approval.',
    `compliance_ferc_flag` BOOLEAN COMMENT 'True if the service entry sheet is subject to Federal Energy Regulatory Commission compliance reporting.',
    `compliance_nerc_cip_flag` BOOLEAN COMMENT 'True if the service relates to assets covered by NERC Critical Infrastructure Protection standards.',
    `contract_number` STRING COMMENT 'Contract under which the service was procured.',
    `cost_center_code` STRING COMMENT 'Internal cost center associated with the service expense.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service entry sheet record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary values.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Discounts granted on the service line.',
    `entry_sheet_number` STRING COMMENT 'Business identifier assigned to the service entry sheet by the procurement system.',
    `external_reference_number` STRING COMMENT 'Reference number from an external system (e.g., contractor invoice).',
    `is_critical_service` BOOLEAN COMMENT 'Indicates whether the service is classified as critical for grid reliability or safety.',
    `net_amount` DECIMAL(18,2) COMMENT 'Final payable amount after tax and discount.',
    `notes` STRING COMMENT 'Additional free‑form comments or observations captured on the entry sheet.',
    `payment_status` STRING COMMENT 'Current payment state of the service entry sheet.. Valid values are `paid|unpaid|partial|hold`',
    `posted_by_user_name` STRING COMMENT 'Display name of the user who posted the entry sheet.',
    `posting_timestamp` TIMESTAMP COMMENT 'Date‑time when the service entry sheet was posted to finance for payment.',
    `receipt_number` STRING COMMENT 'Number of the receipt generated for the service payment.',
    `service_category` STRING COMMENT 'High‑level classification of the service (e.g., construction, vegetation management, meter installation).',
    `service_description` STRING COMMENT 'Free‑text description of the service performed.',
    `service_end_date` DATE COMMENT 'Date when the service work was completed.',
    `service_entry_sheet_status` STRING COMMENT 'Current lifecycle state of the service entry sheet.. Valid values are `draft|submitted|approved|posted|closed|cancelled`',
    `service_location_description` STRING COMMENT 'Narrative description of the service site (e.g., pole number, substation name).',
    `service_po_number` STRING COMMENT 'Reference number of the service purchase order linked to this entry sheet.',
    `service_quantity` DECIMAL(18,2) COMMENT 'Number of service units performed (e.g., labor hours, linear feet).',
    `service_start_date` DATE COMMENT 'Date when the service work began.',
    `service_type` STRING COMMENT 'Specific type of service within the category (e.g., line construction, tree trimming).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component applied to the total amount.',
    `total_amount` DECIMAL(18,2) COMMENT 'Gross amount before taxes, discounts, or adjustments.',
    `unit_of_measure` STRING COMMENT 'Measurement unit for the service quantity.. Valid values are `hour|day|unit|km|mwh|kwh`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the service entry sheet record.',
    CONSTRAINT pk_service_entry_sheet PRIMARY KEY(`service_entry_sheet_id`)
) COMMENT 'Confirmation of services rendered by contractors and service vendors against a service purchase order. Captures entry sheet number, service PO reference, vendor, service description, quantity of service units performed, acceptance status, approver, and posting date. Required for contractor payment processing. Covers field construction services, vegetation management, meter installation, and storm restoration labor.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` (
    `vendor_qualification_id` BIGINT COMMENT 'System-generated unique identifier for each vendor qualification record.',
    `document_id` BIGINT COMMENT 'Reference to the supporting qualification document stored in the document repository.',
    `vendor_id` BIGINT COMMENT 'Unique identifier of the vendor being qualified, linking to the vendor master record.',
    `approved_commodity_categories` STRING COMMENT 'Comma‑separated list of commodity categories the vendor is approved to supply.',
    `bonding_amount` DECIMAL(18,2) COMMENT 'Maximum bonding amount the vendor has provided.',
    `bonding_expiry_date` DATE COMMENT 'Expiration date of the vendors bonding agreement.',
    `diversity_status` STRING COMMENT 'Vendors classification for diversity programs.. Valid values are `minority|women|veteran|none`',
    `financial_rating` STRING COMMENT 'Credit rating assigned to the vendor by the utilitys finance team. [ENUM-REF-CANDIDATE: AAA|AA|A|BBB|BB|B|CCC|CC|C|D — 10 candidates stripped; promote to reference product]',
    `insurance_company` STRING COMMENT 'Name of the insurance carrier providing coverage for the vendor.',
    `insurance_expiry_date` DATE COMMENT 'Expiration date of the vendors insurance coverage.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the vendors liability insurance.',
    `nerc_cip_compliance_flag` BOOLEAN COMMENT 'Indicates whether the vendor complies with NERC CIP requirements.',
    `qualification_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the qualification record was first created in the system.',
    `qualification_effective_date` DATE COMMENT 'Date when the qualification becomes effective.',
    `qualification_expiration_date` DATE COMMENT 'Date when the qualification expires or must be renewed.',
    `qualification_number` STRING COMMENT 'External reference number assigned to the qualification record by the utility.',
    `qualification_review_notes` STRING COMMENT 'Free‑form notes captured during the qualification review.',
    `qualification_score` DECIMAL(18,2) COMMENT 'Composite numeric score derived from the qualification assessment.',
    `qualification_source` STRING COMMENT 'Origin of the qualification data (e.g., internal assessment, vendor‑submitted, third‑party audit).. Valid values are `internal|vendor_self|third_party_audit`',
    `qualification_status` STRING COMMENT 'Current lifecycle status of the vendor qualification.. Valid values are `qualified|disqualified|pending|revoked`',
    `qualification_status_reason` STRING COMMENT 'Free‑text explanation for the current qualification status.',
    `qualification_type` STRING COMMENT 'Category of qualification process (e.g., pre‑qualification, annual re‑qualification, special project qualification).. Valid values are `prequal|annual|requal|special`',
    `qualification_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the qualification record.',
    `qualification_validated_by` STRING COMMENT 'Name of the employee or team that validated the qualification.',
    `qualification_validated_date` DATE COMMENT 'Date when the qualification was validated.',
    `review_date` DATE COMMENT 'Date of the most recent qualification review.',
    `safety_incident_count` STRING COMMENT 'Number of safety incidents recorded for the vendor in the past 12 months.',
    `safety_last_incident_date` DATE COMMENT 'Date of the most recent safety incident involving the vendor.',
    `safety_record_status` STRING COMMENT 'Overall safety performance classification for the vendor.. Valid values are `good|fair|poor|none`',
    CONSTRAINT pk_vendor_qualification PRIMARY KEY(`vendor_qualification_id`)
) COMMENT 'Vendor pre-qualification and approved vendor list (AVL) records capturing the formal assessment of a vendors capability to supply materials or services to the utility. Captures qualification status, commodity categories approved, safety record, financial stability rating, insurance certificate expiry, bonding limit, NERC CIP compliance status, diversity classification, and qualification review date.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ADD CONSTRAINT `fk_supply_material_master_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_procurement_contract_id` FOREIGN KEY (`procurement_contract_id`) REFERENCES `power_and_utilities_v2`.`supply`.`procurement_contract`(`procurement_contract_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ADD CONSTRAINT `fk_supply_purchase_order_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities_v2`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_material_material_master_id` FOREIGN KEY (`material_material_master_id`) REFERENCES `power_and_utilities_v2`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ADD CONSTRAINT `fk_supply_po_line_item_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_supplier_vendor_id` FOREIGN KEY (`supplier_vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ADD CONSTRAINT `fk_supply_goods_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities_v2`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ADD CONSTRAINT `fk_supply_inventory_stock_warehouse_id` FOREIGN KEY (`warehouse_id`) REFERENCES `power_and_utilities_v2`.`supply`.`warehouse`(`warehouse_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_material_master_id` FOREIGN KEY (`material_master_id`) REFERENCES `power_and_utilities_v2`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ADD CONSTRAINT `fk_supply_stock_movement_stock_material_master_id` FOREIGN KEY (`stock_material_master_id`) REFERENCES `power_and_utilities_v2`.`supply`.`material_master`(`material_master_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ADD CONSTRAINT `fk_supply_procurement_contract_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ADD CONSTRAINT `fk_supply_fuel_supply_schedule_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ADD CONSTRAINT `fk_supply_fuel_receipt_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ADD CONSTRAINT `fk_supply_fuel_receipt_primary_fuel_vendor_id` FOREIGN KEY (`primary_fuel_vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ADD CONSTRAINT `fk_supply_fuel_receipt_tertiary_fuel_supplier_vendor_id` FOREIGN KEY (`tertiary_fuel_supplier_vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ADD CONSTRAINT `fk_supply_rfq_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ADD CONSTRAINT `fk_supply_vendor_quotation_rfq_id` FOREIGN KEY (`rfq_id`) REFERENCES `power_and_utilities_v2`.`supply`.`rfq`(`rfq_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ADD CONSTRAINT `fk_supply_vendor_quotation_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ADD CONSTRAINT `fk_supply_vendor_performance_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_goods_receipt_id` FOREIGN KEY (`goods_receipt_id`) REFERENCES `power_and_utilities_v2`.`supply`.`goods_receipt`(`goods_receipt_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ADD CONSTRAINT `fk_supply_invoice_verification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_purchase_order_id` FOREIGN KEY (`purchase_order_id`) REFERENCES `power_and_utilities_v2`.`supply`.`purchase_order`(`purchase_order_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_shipment_carrier_vendor_id` FOREIGN KEY (`shipment_carrier_vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ADD CONSTRAINT `fk_supply_shipment_shipment_vendor_id` FOREIGN KEY (`shipment_vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ADD CONSTRAINT `fk_supply_service_entry_sheet_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ADD CONSTRAINT `fk_supply_vendor_qualification_vendor_id` FOREIGN KEY (`vendor_id`) REFERENCES `power_and_utilities_v2`.`supply`.`vendor`(`vendor_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`supply` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities_v2`.`supply` SET TAGS ('dbx_domain' = 'supply');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` SET TAGS ('dbx_subdomain' = 'vendor_relations');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Employee Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `tech_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Tech Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `approved_commodity_categories` SET TAGS ('dbx_business_glossary_term' = 'Approved Commodity Categories');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `bonding_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonding Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `bonding_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `bonding_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `bonding_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Bonding Expiry Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO 3166-1 Alpha-3)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `credit_limit` SET TAGS ('dbx_business_glossary_term' = 'Credit Limit (USD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `credit_limit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `credit_limit` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `diversity_status` SET TAGS ('dbx_business_glossary_term' = 'Diversity Certification Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `diversity_status` SET TAGS ('dbx_value_regex' = 'none|mbe|wbe|sbe');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_business_glossary_term' = 'Data Universal Numbering System (DUNS) Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `duns_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `ferc_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'FERC Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `financial_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Credit Rating');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `insurance_company` SET TAGS ('dbx_business_glossary_term' = 'Insurance Company Name');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `last_review_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Review Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `legal_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Entity Name (Legal Name)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `nerc_cip_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Vendor Notes');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Preferred Payment Method');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Email Address');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `primary_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Name');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `primary_contact_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Primary Contact Phone Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `primary_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `qualification_review_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Review Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|pending|rejected|under_review');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `safety_last_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Date of Last Safety Incident');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `safety_record_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Record Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `safety_record_status` SET TAGS ('dbx_value_regex' = 'clear|pending|suspended');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `tax_exempt_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_business_glossary_term' = 'Employer Identification Number (EIN)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `tax_identifier` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `vendor_category` SET TAGS ('dbx_business_glossary_term' = 'Vendor Category (Category)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `vendor_category` SET TAGS ('dbx_value_regex' = 'fuel_supplier|equipment_oem|contractor|mro_distributor|service_provider');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `vendor_name` SET TAGS ('dbx_business_glossary_term' = 'Vendor Name');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `vendor_number` SET TAGS ('dbx_business_glossary_term' = 'Vendor Number (Vendor ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_business_glossary_term' = 'Vendor Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `vendor_status` SET TAGS ('dbx_value_regex' = 'active|inactive|suspended|pending|terminated');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor` ALTER COLUMN `website_url` SET TAGS ('dbx_business_glossary_term' = 'Website URL');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Default Vendor ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `alternative_uom` SET TAGS ('dbx_business_glossary_term' = 'Alternative Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `base_uom` SET TAGS ('dbx_business_glossary_term' = 'Base Unit of Measure (BASE_UOM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `batch_management_flag` SET TAGS ('dbx_business_glossary_term' = 'Batch Management Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_business_glossary_term' = 'Country of Origin');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `country_of_origin` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `customs_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Tariff Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `customs_tariff_code` SET TAGS ('dbx_value_regex' = '^[0-9]{8}$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `gross_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (kg)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `hazard_class` SET TAGS ('dbx_business_glossary_term' = 'Hazard Class');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `hazardous_material_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `height_cm` SET TAGS ('dbx_business_glossary_term' = 'Height (cm)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `is_obsolete` SET TAGS ('dbx_business_glossary_term' = 'Obsolete Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Lead Time (Days)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `length_cm` SET TAGS ('dbx_business_glossary_term' = 'Length (cm)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `lot_size` SET TAGS ('dbx_business_glossary_term' = 'Lot Size');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `material_group` SET TAGS ('dbx_business_glossary_term' = 'Material Group (MATKL)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `material_master_status` SET TAGS ('dbx_business_glossary_term' = 'Material Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `material_master_status` SET TAGS ('dbx_value_regex' = 'active|inactive|discontinued');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (MATNR)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_business_glossary_term' = 'Material Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `material_type` SET TAGS ('dbx_value_regex' = 'raw|spare|consumable|equipment');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `max_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Maximum Order Quantity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `min_order_qty` SET TAGS ('dbx_business_glossary_term' = 'Minimum Order Quantity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `mrp_type` SET TAGS ('dbx_business_glossary_term' = 'Material Requirements Planning (MRP) Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `mrp_type` SET TAGS ('dbx_value_regex' = 'PD|VB|VV|FO|FOB');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `net_weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (kg)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `price_valid_from` SET TAGS ('dbx_business_glossary_term' = 'Price Valid From Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `price_valid_to` SET TAGS ('dbx_business_glossary_term' = 'Price Valid To Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'external|internal|consignment');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `purchasing_group` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Group');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `safety_stock_qty` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Quantity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `serial_number_flag` SET TAGS ('dbx_business_glossary_term' = 'Serial Number Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `shelf_life_days` SET TAGS ('dbx_business_glossary_term' = 'Shelf Life (Days)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `standard_cost` SET TAGS ('dbx_business_glossary_term' = 'Standard Cost');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `storage_condition` SET TAGS ('dbx_value_regex' = 'ambient|refrigerated|frozen|hazardous');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `temperature_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'UN Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `valuation_class` SET TAGS ('dbx_business_glossary_term' = 'Valuation Class');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `volume_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Volume (cubic meters)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`material_master` ALTER COLUMN `width_cm` SET TAGS ('dbx_business_glossary_term' = 'Width (cm)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `asset_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `customer_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Employee ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `large_customer_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Large Customer Contract Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `last_modified_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By Employee ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Contract ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `account_assignment_type` SET TAGS ('dbx_business_glossary_term' = 'Account Assignment Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `account_assignment_type` SET TAGS ('dbx_value_regex' = 'cost_center|wbs|asset|order|project');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `currency_rate` SET TAGS ('dbx_business_glossary_term' = 'Currency Exchange Rate');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `is_blanket_release` SET TAGS ('dbx_business_glossary_term' = 'Blanket Release Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `is_goods_receipt_required` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Required Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `is_three_way_match` SET TAGS ('dbx_business_glossary_term' = 'Three‑Way Match Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `line_count` SET TAGS ('dbx_business_glossary_term' = 'Line Count');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net PO Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Notes');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `order_date` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `order_status` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `order_status` SET TAGS ('dbx_value_regex' = 'draft|open|approved|rejected|closed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'standard|blanket|framework|service|contract|planned');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `po_description` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Description');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `po_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `price_condition` SET TAGS ('dbx_business_glossary_term' = 'Price Condition');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `price_condition` SET TAGS ('dbx_value_regex' = 'net|gross|discounted|rebated');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `purchasing_org_code` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `release_number` SET TAGS ('dbx_business_glossary_term' = 'Release Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Status Change Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total PO Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `valid_from` SET TAGS ('dbx_business_glossary_term' = 'Valid From Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`purchase_order` ALTER COLUMN `valid_to` SET TAGS ('dbx_business_glossary_term' = 'Valid To Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `po_line_item_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Line Item Identifier (PO_LINE_ITEM_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (MAT_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `material_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Identifier (MAT_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Identifier (PO_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier (VENDOR_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date (ACT_DELIV_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVED_BY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `asset_number` SET TAGS ('dbx_business_glossary_term' = 'Asset Number (ASSET_NO)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CONTRACT_NO)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|CAD|GBP|JPY|CHF');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Planned Delivery Date (DELIV_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISC_AMT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number (EXT_REF_NO)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `goods_receipt_indicator` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Indicator (GR_IND)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `is_service_item` SET TAGS ('dbx_business_glossary_term' = 'Service Item Indicator (IS_SERVICE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `last_receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Receipt Timestamp (LAST_GR_TS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status (LIFECYCLE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'planned|ordered|received|in_use|retired');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `line_amount` SET TAGS ('dbx_business_glossary_term' = 'Line Gross Amount (LINE_GROSS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `line_number` SET TAGS ('dbx_business_glossary_term' = 'Line Sequence Number (LINE_NO)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `line_status` SET TAGS ('dbx_business_glossary_term' = 'Line Status (LINE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `line_status` SET TAGS ('dbx_value_regex' = 'open|closed|cancelled|pending|rejected');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description (MAT_DESC)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Line Amount (NET_AMT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `price_variance_percent` SET TAGS ('dbx_business_glossary_term' = 'Price Variance Percent (PRICE_VAR_PCT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category (PROC_CAT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `procurement_category` SET TAGS ('dbx_value_regex' = 'CAPEX|MRO|FUEL|SERVICE|SPARE|OTHER');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `purchase_group` SET TAGS ('dbx_business_glossary_term' = 'Purchase Group (PUR_GROUP)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `purchasing_organization` SET TAGS ('dbx_business_glossary_term' = 'Purchasing Organization (PUR_ORG)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Ordered Quantity (QTY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Receipt Quantity (REC_QTY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks (REMARKS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `requested_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Delivery Date (REQ_DELIV_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date (SRV_END)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date (SRV_START)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `split_indicator` SET TAGS ('dbx_business_glossary_term' = 'Split Indicator (IS_SPLIT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code (STGE_LOC)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `tax_code` SET TAGS ('dbx_value_regex' = 'TX01|TX02|TX03|TX04|TX05|TX06');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'EA|KG|L|M3|MWH|MCF');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `unit_price` SET TAGS ('dbx_business_glossary_term' = 'Unit Price (UNIT_PRICE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`po_line_item` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `customer_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User Identifier (RECEIVED_BY_UID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `received_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Receiving User Identifier (RECEIVED_BY_UID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `received_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `received_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `supplier_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `ash_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Ash Content Percentage (ASH_PCT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH_NUM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `btu_content` SET TAGS ('dbx_business_glossary_term' = 'BTU Content per Unit (BTU_PER_UNIT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `calorific_value` SET TAGS ('dbx_business_glossary_term' = 'Calorific Value (CALORIFIC_VAL)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name (CARRIER_NAME)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments / Remarks (COMMENTS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217) (CURR_CD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `eia_923_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'EIA‑923 Reporting Flag (EIA923_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type (FUEL_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'coal|natural_gas|uranium|oil|biomass');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Receipt Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `goods_receipt_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|cancelled');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Amount (Currency) (GROSS_AMT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Date (QI_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `is_three_way_match_completed` SET TAGS ('dbx_business_glossary_term' = 'Three‑Way Match Completion Flag (THREE_WAY_MATCHED)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NUM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `material_number` SET TAGS ('dbx_business_glossary_term' = 'Material Number (MAT_NUM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type Code (MOV_TYPE_CD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (NET_AMT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `nrc_chain_of_custody_doc` SET TAGS ('dbx_business_glossary_term' = 'NRC Chain of Custody Document Reference (NRC_CUSTODY_DOC)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `nrc_chain_of_custody_doc` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `pipeline_nomination_confirmed` SET TAGS ('dbx_business_glossary_term' = 'Pipeline Nomination Confirmation Flag (PIPELINE_NOM_CONF)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `plant_code` SET TAGS ('dbx_business_glossary_term' = 'Plant Code (PLANT_CD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date (Date) (POST_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NUM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Status (QI_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `quality_inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `quantity_received` SET TAGS ('dbx_business_glossary_term' = 'Quantity Received (QTY_RCVD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Document Number (REC_NUM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Receipt Event Timestamp (UTC)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_business_glossary_term' = 'Receipt Type (REC_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `receipt_type` SET TAGS ('dbx_value_regex' = 'material|equipment|fuel|service');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `received_by_name` SET TAGS ('dbx_business_glossary_term' = 'Receiving User Name (RECEIVED_BY_NAME)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `received_by_name` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `regulatory_reporting_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Code (REG_REPORT_CD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number (SERIAL_NUM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code (STOR_LOC_CD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content Percentage (SULFUR_PCT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name (SUPPLIER_NAME)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|m3|pcs|l|bbl');
ALTER TABLE `power_and_utilities_v2`.`supply`.`goods_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `inventory_stock_id` SET TAGS ('dbx_business_glossary_term' = 'Inventory Stock ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `material_master_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID (PLANT_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID (SUPPLIER_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse ID (WAREHOUSE_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH_NO)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `current_unit_price` SET TAGS ('dbx_business_glossary_term' = 'Current Unit Price (UNIT_PRICE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFFECTIVE_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXPIRY_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `inventory_stock_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `inventory_stock_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `inventory_valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Date (VAL_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Method (VAL_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `inventory_valuation_method` SET TAGS ('dbx_value_regex' = 'FIFO|LIFO|Weighted_Average');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `is_capex_staged` SET TAGS ('dbx_business_glossary_term' = 'Is CAPEX Staged (IS_CAPEX_STAGED)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `is_fuel_inventory` SET TAGS ('dbx_business_glossary_term' = 'Is Fuel Inventory (IS_FUEL)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `is_quality_inspection_passed` SET TAGS ('dbx_business_glossary_term' = 'Is Quality Inspection Passed (QUALITY_PASS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `is_storm_reserve` SET TAGS ('dbx_business_glossary_term' = 'Is Storm Reserve (IS_STORM_RESERVE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `last_issue_date` SET TAGS ('dbx_business_glossary_term' = 'Last Issue Date (LAST_ISSUE_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `last_physical_count_date` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Date (LAST_COUNT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `last_physical_count_user` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count User (LAST_COUNT_USER)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `last_physical_count_variance` SET TAGS ('dbx_business_glossary_term' = 'Last Physical Count Variance (LAST_COUNT_VAR)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `last_receipt_date` SET TAGS ('dbx_business_glossary_term' = 'Last Receipt Date (LAST_RECEIPT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NO)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `material_category` SET TAGS ('dbx_business_glossary_term' = 'Material Category (MATERIAL_CATEGORY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `material_category` SET TAGS ('dbx_value_regex' = 'raw_material|fuel|spare_part|equipment|consumable');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `material_code` SET TAGS ('dbx_business_glossary_term' = 'Material Code (MATERIAL_CODE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description (MATERIAL_DESCRIPTION)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `material_name` SET TAGS ('dbx_business_glossary_term' = 'Material Name (MATERIAL_NAME)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `physical_count_method` SET TAGS ('dbx_business_glossary_term' = 'Physical Count Method (COUNT_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `physical_count_method` SET TAGS ('dbx_value_regex' = 'manual|barcode|rfid');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `price_control_method` SET TAGS ('dbx_business_glossary_term' = 'Price Control Method (PRICE_CTRL_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `price_control_method` SET TAGS ('dbx_value_regex' = 'standard|moving_average');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number (PO_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `quality_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Date (QUALITY_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Quality Inspection Result (QUALITY_RESULT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `quality_inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|rework');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `quantity_on_hand` SET TAGS ('dbx_business_glossary_term' = 'Quantity On Hand (QTY_ON_HAND)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `reorder_point` SET TAGS ('dbx_business_glossary_term' = 'Reorder Point (REORDER_PT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `safety_stock_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Stock Level (SAFETY_STOCK)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `stock_type` SET TAGS ('dbx_business_glossary_term' = 'Stock Type (STOCK_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `stock_type` SET TAGS ('dbx_value_regex' = 'unrestricted|quality_inspection|blocked|in_transit|storm_reserve');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `storage_location_code` SET TAGS ('dbx_business_glossary_term' = 'Storage Location Code (STORAGE_LOC_CODE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|m3|kWh|MWh|gal');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `unit_price_currency` SET TAGS ('dbx_business_glossary_term' = 'Unit Price Currency (CURRENCY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `unit_price_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`inventory_stock` ALTER COLUMN `valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Valuation Amount (VAL_AMT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_id` SET TAGS ('dbx_business_glossary_term' = 'Stock Movement ID (SMID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID (DEST_LOC_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID (POSTED_BY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `posted_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID (POSTED_BY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `posted_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `posted_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID (MAT_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `asset_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project ID (PROJ_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `finance_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project ID (PROJ_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `source_location_id` SET TAGS ('dbx_business_glossary_term' = 'Source Location ID (SRC_LOC_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `stock_material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material ID (MAT_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `wbs_element_id` SET TAGS ('dbx_business_glossary_term' = 'Wbs Element Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `batch_number` SET TAGS ('dbx_business_glossary_term' = 'Batch Number (BATCH_NO)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Compliance Flag (COMPLIANCE_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Event Timestamp (EVT_TS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `external_order_number` SET TAGS ('dbx_business_glossary_term' = 'External Order Number (EXT_ORD_NO)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `inventory_valuation_amount` SET TAGS ('dbx_business_glossary_term' = 'Inventory Valuation Amount (INV_VAL_AMT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Movement Flag (CRITICAL_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `lot_number` SET TAGS ('dbx_business_glossary_term' = 'Lot Number (LOT_NO)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `material_description` SET TAGS ('dbx_business_glossary_term' = 'Material Description (MAT_DESC)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `movement_number` SET TAGS ('dbx_business_glossary_term' = 'Movement Number (MOV_NUM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `movement_reason_code` SET TAGS ('dbx_business_glossary_term' = 'Movement Reason Code (REASON_CD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_business_glossary_term' = 'Movement Type (MOV_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `movement_type` SET TAGS ('dbx_value_regex' = 'issue|transfer|return|scrap|adjustment');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date (POST_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Quantity (QTY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `reference_document_number` SET TAGS ('dbx_business_glossary_term' = 'Reference Document Number (REF_DOC_NO)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_status` SET TAGS ('dbx_business_glossary_term' = 'Movement Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `stock_movement_status` SET TAGS ('dbx_value_regex' = 'posted|reversed|pending|cancelled');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `storage_condition` SET TAGS ('dbx_business_glossary_term' = 'Storage Condition (STOR_COND)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'kg|lb|m3|gal|kWh|MWh');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `valuation_currency` SET TAGS ('dbx_business_glossary_term' = 'Valuation Currency (VAL_CURR)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `variance_quantity` SET TAGS ('dbx_business_glossary_term' = 'Variance Quantity (VAR_QTY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`stock_movement` ALTER COLUMN `variance_reason` SET TAGS ('dbx_business_glossary_term' = 'Variance Reason (VAR_REASON)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `procurement_contract_id` SET TAGS ('dbx_business_glossary_term' = 'Procurement Contract Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `commodity` SET TAGS ('dbx_value_regex' = 'coal|natural_gas|uranium|equipment|services');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `contract_category` SET TAGS ('dbx_business_glossary_term' = 'Contract Category');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `contract_category` SET TAGS ('dbx_value_regex' = 'fuel_supply|equipment_supply|service_agreement|maintenance|construction');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `contract_document_url` SET TAGS ('dbx_business_glossary_term' = 'Contract Document URL');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `contract_manager` SET TAGS ('dbx_business_glossary_term' = 'Contract Manager');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `contract_owner` SET TAGS ('dbx_business_glossary_term' = 'Contract Owner');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `contract_scope_description` SET TAGS ('dbx_business_glossary_term' = 'Contract Scope Description');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `contract_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Contract Status Reason');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'value|quantity|framework|scheduling');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `contract_version` SET TAGS ('dbx_business_glossary_term' = 'Contract Version');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `delivery_schedule` SET TAGS ('dbx_business_glossary_term' = 'Delivery Schedule');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `discount_rate` SET TAGS ('dbx_business_glossary_term' = 'Discount Rate');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `discount_rate` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `escalation_clause` SET TAGS ('dbx_business_glossary_term' = 'Escalation Clause');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `insurance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Insurance Requirements');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_business_glossary_term' = 'Invoicing Frequency');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `invoicing_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annually|upon_delivery');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `last_amendment_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Amendment Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Notice Period (Days)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_business_glossary_term' = 'Performance Bond Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `performance_bond_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `pricing_type` SET TAGS ('dbx_business_glossary_term' = 'Pricing Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `pricing_type` SET TAGS ('dbx_value_regex' = 'fixed|variable|indexed|market');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `procurement_contract_status` SET TAGS ('dbx_business_glossary_term' = 'Contract Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `procurement_contract_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|draft');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Contract Quantity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `quantity` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'auto|manual|none');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `risk_rating` SET TAGS ('dbx_business_glossary_term' = 'Risk Rating');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `risk_rating` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_business_glossary_term' = 'Total Contract Value');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `total_contract_value` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'MMBtu|ton|kg|unit|MW|MWh');
ALTER TABLE `power_and_utilities_v2`.`supply`.`procurement_contract` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` SET TAGS ('dbx_subdomain' = 'fuel_logistics');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `fuel_supply_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Supply Schedule ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Plant ID (GP_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID (SUP_ID)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `actual_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Timestamp (ADT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `carrier_name` SET TAGS ('dbx_business_glossary_term' = 'Carrier Name (CN)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_business_glossary_term' = 'Confirmation Status (CS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `confirmation_status` SET TAGS ('dbx_value_regex' = 'pending|confirmed|rejected|awaiting|cancelled');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CNTR)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `delivery_window_end` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window End (DWE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `delivery_window_start` SET TAGS ('dbx_business_glossary_term' = 'Delivery Window Start (DWS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `fuel_supply_schedule_status` SET TAGS ('dbx_business_glossary_term' = 'Schedule Status (STAT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `fuel_supply_schedule_status` SET TAGS ('dbx_value_regex' = 'planned|confirmed|delivered|canceled|postponed|in_transit');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type (FT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'coal|natural_gas|uranium|biomass|hydrogen|oil');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Delivery Flag (CRIT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `last_modified_by` SET TAGS ('dbx_business_glossary_term' = 'Last Modified By (LMB)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `price_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Price Per Unit (PPU)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Priority (PRIO)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_business_glossary_term' = 'Quantity Unit (QU)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `quantity_unit` SET TAGS ('dbx_value_regex' = 'tons|mcf|kg|bbl|gallons');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `quantity_value` SET TAGS ('dbx_business_glossary_term' = 'Quantity Value (QV)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `regulatory_compliance_code` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Code (RCC)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `schedule_number` SET TAGS ('dbx_business_glossary_term' = 'Schedule Number (SCH)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `scheduled_delivery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Delivery Timestamp (SDT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost (TC)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode (TM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'pipeline|rail|barge|truck|ship|truck_rail_intermodal');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_supply_schedule` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` SET TAGS ('dbx_subdomain' = 'fuel_logistics');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `fuel_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Fuel Receipt ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `plant_id` SET TAGS ('dbx_business_glossary_term' = 'Plant ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `primary_fuel_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `tertiary_fuel_supplier_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Supplier ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `ash_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Ash Content (%)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `btu_content_total` SET TAGS ('dbx_business_glossary_term' = 'Total BTU Content');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `calorific_value_btu_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Calorific Value (BTU per Unit)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `cost_per_unit` SET TAGS ('dbx_business_glossary_term' = 'Cost Per Unit');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Latitude');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `delivery_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `delivery_location` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_business_glossary_term' = 'Delivery Longitude');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `delivery_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `eia_923_fuel_code` SET TAGS ('dbx_business_glossary_term' = 'EIA‑923 Fuel Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `eia_923_reporting_month` SET TAGS ('dbx_business_glossary_term' = 'EIA‑923 Reporting Month');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `fuel_receipt_status` SET TAGS ('dbx_business_glossary_term' = 'Fuel Receipt Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `fuel_receipt_status` SET TAGS ('dbx_value_regex' = 'received|rejected|pending|cancelled');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'coal|natural_gas|uranium|oil|biomass|hydrogen');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `gross_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Gross Weight (tons)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `is_quality_approved` SET TAGS ('dbx_business_glossary_term' = 'Quality Approved Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `moisture_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Moisture Content (%)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `net_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Net Weight (tons)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `purchase_order_number` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `quality_approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Quality Approval Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Fuel Quantity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Fuel Receipt Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Fuel Receipt Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `sulfur_content_percent` SET TAGS ('dbx_business_glossary_term' = 'Sulfur Content (%)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `supplier_name` SET TAGS ('dbx_business_glossary_term' = 'Supplier Name');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `tare_weight_tons` SET TAGS ('dbx_business_glossary_term' = 'Tare Weight (tons)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `temperature_celsius` SET TAGS ('dbx_business_glossary_term' = 'Delivery Temperature (°C)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'tons|mcf|mwh');
ALTER TABLE `power_and_utilities_v2`.`supply`.`fuel_receipt` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `requisition_id` SET TAGS ('dbx_business_glossary_term' = 'Requisition ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `approver_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `approver_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `asset_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `budget_line_id` SET TAGS ('dbx_business_glossary_term' = 'Budget Line ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `requisition_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Requester ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `requisition_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `requisition_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `actual_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Delivery Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `attached_document_flag` SET TAGS ('dbx_business_glossary_term' = 'Attached Document Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `compliance_review_required` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Required');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `delivery_address` SET TAGS ('dbx_business_glossary_term' = 'Delivery Address');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `delivery_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `delivery_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `delivery_location_code` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `department_code` SET TAGS ('dbx_business_glossary_term' = 'Department Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `estimated_gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Gross Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `estimated_net_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Net Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `estimated_tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Estimated Tax Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `last_status_change_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Status Change Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `material_service_code` SET TAGS ('dbx_business_glossary_term' = 'Material/Service Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `material_service_description` SET TAGS ('dbx_business_glossary_term' = 'Material/Service Description');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Requisition Notes');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_business_glossary_term' = 'Priority Level');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `priority_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `procurement_type` SET TAGS ('dbx_business_glossary_term' = 'Procurement Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `procurement_type` SET TAGS ('dbx_value_regex' = 'planned|unplanned|emergency');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `receipt_confirmed_flag` SET TAGS ('dbx_business_glossary_term' = 'Receipt Confirmed Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `receipt_expected_date` SET TAGS ('dbx_business_glossary_term' = 'Receipt Expected Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `request_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Requisition Request Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `requisition_number` SET TAGS ('dbx_business_glossary_term' = 'Requisition Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_business_glossary_term' = 'Requisition Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `requisition_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|cancelled|fulfilled');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `shipping_method` SET TAGS ('dbx_business_glossary_term' = 'Shipping Method');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|Oracle|Other');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `urgency_flag` SET TAGS ('dbx_business_glossary_term' = 'Urgency Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `vendor_preferred_flag` SET TAGS ('dbx_business_glossary_term' = 'Vendor Preferred Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `wbs_element` SET TAGS ('dbx_business_glossary_term' = 'Work Breakdown Structure (WBS) Element');
ALTER TABLE `power_and_utilities_v2`.`supply`.`requisition` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Organization Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Delivery Location Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Winning Vendor Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'not_approved|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `award_date` SET TAGS ('dbx_business_glossary_term' = 'Award Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `award_status` SET TAGS ('dbx_business_glossary_term' = 'Award Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `award_status` SET TAGS ('dbx_value_regex' = 'pending|awarded|rejected');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `budget_code` SET TAGS ('dbx_business_glossary_term' = 'Budget Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `commodity` SET TAGS ('dbx_business_glossary_term' = 'Commodity (Commodity)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `contract_term_months` SET TAGS ('dbx_business_glossary_term' = 'Contract Term (Months)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `contract_type` SET TAGS ('dbx_business_glossary_term' = 'Contract Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `contract_type` SET TAGS ('dbx_value_regex' = 'fixed_price|cost_plus|time_and_materials');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `evaluation_criteria` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Criteria');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `financial_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Financial Compliance Score');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `has_attachments` SET TAGS ('dbx_business_glossary_term' = 'Attachment Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `issue_timestamp` SET TAGS ('dbx_business_glossary_term' = 'RFQ Issue Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `issuing_department` SET TAGS ('dbx_business_glossary_term' = 'Issuing Department');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `issuing_organization_code` SET TAGS ('dbx_business_glossary_term' = 'Issuing Organization Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'RFQ Notes');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `procurement_category` SET TAGS ('dbx_value_regex' = 'CAPEX|OPEX|maintenance|storm_restoration');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `quantity` SET TAGS ('dbx_business_glossary_term' = 'Requested Quantity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `required_delivery_date` SET TAGS ('dbx_business_glossary_term' = 'Required Delivery Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `rfq_description` SET TAGS ('dbx_business_glossary_term' = 'RFQ Description');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `rfq_number` SET TAGS ('dbx_business_glossary_term' = 'RFQ Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_business_glossary_term' = 'RFQ Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `rfq_status` SET TAGS ('dbx_value_regex' = 'draft|issued|closed|cancelled|awarded');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `submission_deadline` SET TAGS ('dbx_business_glossary_term' = 'RFQ Submission Deadline');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `technical_compliance_score` SET TAGS ('dbx_business_glossary_term' = 'Technical Compliance Score');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'RFQ Title');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `total_estimated_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Estimated Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'MWh|kWh|MW|MCF|Therm|Each');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Validity End Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Validity Start Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`rfq` ALTER COLUMN `version` SET TAGS ('dbx_business_glossary_term' = 'RFQ Version');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` SET TAGS ('dbx_subdomain' = 'vendor_relations');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `vendor_quotation_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Quotation ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `opportunity_id` SET TAGS ('dbx_business_glossary_term' = 'Opportunity Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `rfq_id` SET TAGS ('dbx_business_glossary_term' = 'Request for Quotation (RFQ) ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Approval Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `attachment_url` SET TAGS ('dbx_business_glossary_term' = 'Attachment URL');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `contract_reference` SET TAGS ('dbx_business_glossary_term' = 'Contract Reference');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|EUR|GBP|CAD|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `delivery_lead_time_days` SET TAGS ('dbx_business_glossary_term' = 'Delivery Lead Time (Days)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `discount_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `is_discount_applicable` SET TAGS ('dbx_business_glossary_term' = 'Is Discount Applicable');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `is_price_fixed` SET TAGS ('dbx_business_glossary_term' = 'Is Price Fixed');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `is_tax_included` SET TAGS ('dbx_business_glossary_term' = 'Is Tax Included');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `line_item_count` SET TAGS ('dbx_business_glossary_term' = 'Line Item Count');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Quotation Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `net_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `net_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `payment_terms` SET TAGS ('dbx_business_glossary_term' = 'Payment Terms');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `payment_terms` SET TAGS ('dbx_value_regex' = 'net_30|net_60|net_90|upon_delivery');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `procurement_category` SET TAGS ('dbx_business_glossary_term' = 'Procurement Category');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `procurement_category` SET TAGS ('dbx_value_regex' = 'fuel|equipment|services|software|consulting');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `quotation_number` SET TAGS ('dbx_business_glossary_term' = 'Quotation Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `quotation_type` SET TAGS ('dbx_business_glossary_term' = 'Quotation Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `quotation_type` SET TAGS ('dbx_value_regex' = 'price|technical|combined');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `submission_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Submission Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `tax_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `technical_compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Technical Compliance Notes');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Quotation Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `total_amount` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `total_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Record Updated By');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `updated_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `updated_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `validity_end_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Validity End Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `validity_start_date` SET TAGS ('dbx_business_glossary_term' = 'Quotation Validity Start Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `vendor_quotation_status` SET TAGS ('dbx_business_glossary_term' = 'Quotation Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `vendor_quotation_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|rejected|expired');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Record Created By');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `created_by` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_quotation` ALTER COLUMN `created_by` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` SET TAGS ('dbx_subdomain' = 'vendor_relations');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `vendor_performance_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Performance Record ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `evaluator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Evaluator ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Evaluator Comments');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `commodity_category` SET TAGS ('dbx_value_regex' = 'coal|natural_gas|uranium|renewable|oil|other');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `corrective_action_status` SET TAGS ('dbx_value_regex' = 'none|open|closed|in_progress');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_number` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_period_end` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period End Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_period_start` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Period Start Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `evaluation_type` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `invoice_accuracy_rate` SET TAGS ('dbx_business_glossary_term' = 'Invoice Accuracy Rate (Percent)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `on_time_delivery_rate` SET TAGS ('dbx_business_glossary_term' = 'On-Time Delivery Rate (Percent)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `overall_score` SET TAGS ('dbx_business_glossary_term' = 'Overall Performance Score');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `quality_rejection_rate` SET TAGS ('dbx_business_glossary_term' = 'Quality Rejection Rate (Percent)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `vendor_performance_status` SET TAGS ('dbx_business_glossary_term' = 'Evaluation Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_performance` ALTER COLUMN `vendor_performance_status` SET TAGS ('dbx_value_regex' = 'pending|completed|in_review|rejected');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `invoice_verification_id` SET TAGS ('dbx_business_glossary_term' = 'Invoice Verification ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verification User ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `goods_receipt_id` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `verification_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Verification User ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `verification_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `verification_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `commodity_category` SET TAGS ('dbx_business_glossary_term' = 'Commodity Category');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `commodity_category` SET TAGS ('dbx_value_regex' = 'coal|natural_gas|uranium|renewable|oil');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number (CNT_NUM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `discrepancy_description` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Description');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_business_glossary_term' = 'Discrepancy Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `discrepancy_type` SET TAGS ('dbx_value_regex' = 'quantity|price|tax|missing|duplicate|other');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `due_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Due Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `gross_amount` SET TAGS ('dbx_business_glossary_term' = 'Gross Invoice Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `invoice_date` SET TAGS ('dbx_business_glossary_term' = 'Invoice Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number (INV_NUM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `invoiced_quantity` SET TAGS ('dbx_business_glossary_term' = 'Invoiced Quantity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `matched_quantity` SET TAGS ('dbx_business_glossary_term' = 'Matched Quantity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Invoice Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `payment_block_flag` SET TAGS ('dbx_business_glossary_term' = 'Payment Block Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `po_quantity` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Quantity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `posting_date` SET TAGS ('dbx_business_glossary_term' = 'Posting Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `posting_status` SET TAGS ('dbx_business_glossary_term' = 'Posting Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `posting_status` SET TAGS ('dbx_value_regex' = 'not_posted|posted|error');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `receipt_location` SET TAGS ('dbx_business_glossary_term' = 'Receipt Location');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `receipt_quantity` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Quantity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `receipt_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Goods Receipt Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP_MM|Oracle_CC&B|Custom');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (USD)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `tax_exempt_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure (UOM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `verification_notes` SET TAGS ('dbx_business_glossary_term' = 'Verification Notes');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `verification_number` SET TAGS ('dbx_business_glossary_term' = 'Verification Number (VER_NUM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_business_glossary_term' = 'Verification Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `verification_status` SET TAGS ('dbx_value_regex' = 'pending|matched|mismatched|blocked|posted');
ALTER TABLE `power_and_utilities_v2`.`supply`.`invoice_verification` ALTER COLUMN `verification_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Verification Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `warehouse_id` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `access_control_method` SET TAGS ('dbx_business_glossary_term' = 'Access Control Method');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `access_control_method` SET TAGS ('dbx_value_regex' = 'badge|biometric|keycard|pin|none');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_business_glossary_term' = 'Address Line 2');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `capacity_total_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Total Capacity (Cubic Meters)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `capacity_utilized_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Utilized Capacity (Cubic Meters)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `climate_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Climate Control Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `fire_suppression_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `fire_suppression_type` SET TAGS ('dbx_value_regex' = 'sprinkler|foam|gas|none');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `gis_coordinates` SET TAGS ('dbx_business_glossary_term' = 'GIS Coordinates (WKT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `hazmat_certification_number` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Certification Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `hazmat_storage_certified_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Certification Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `humidity_control_max_percent` SET TAGS ('dbx_business_glossary_term' = 'Maximum Humidity (%)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `humidity_control_min_percent` SET TAGS ('dbx_business_glossary_term' = 'Minimum Humidity (%)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `inventory_audit_status` SET TAGS ('dbx_business_glossary_term' = 'Inventory Audit Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `inventory_audit_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|deferred');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `last_inventory_audit_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Inventory Audit Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual|as_needed');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Manager Name');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `opening_date` SET TAGS ('dbx_business_glossary_term' = 'Opening Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `ownership_type` SET TAGS ('dbx_business_glossary_term' = 'Ownership Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `ownership_type` SET TAGS ('dbx_value_regex' = 'owned|leased|joint');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `responsible_department` SET TAGS ('dbx_business_glossary_term' = 'Responsible Department');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `temperature_control_max_celsius` SET TAGS ('dbx_business_glossary_term' = 'Maximum Temperature (°C)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `temperature_control_min_celsius` SET TAGS ('dbx_business_glossary_term' = 'Minimum Temperature (°C)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `warehouse_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{3,10}$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `warehouse_name` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Name');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `warehouse_status` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `warehouse_status` SET TAGS ('dbx_value_regex' = 'active|inactive|closed|maintenance|planned');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `warehouse_type` SET TAGS ('dbx_business_glossary_term' = 'Warehouse Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`warehouse` ALTER COLUMN `warehouse_type` SET TAGS ('dbx_value_regex' = 'central|field|mobile|storm_trailer|laydown');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` SET TAGS ('dbx_subdomain' = 'fuel_logistics');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `shipment_id` SET TAGS ('dbx_business_glossary_term' = 'Shipment ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Destination Location ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `filing_id` SET TAGS ('dbx_business_glossary_term' = 'Filing Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `network_device_id` SET TAGS ('dbx_business_glossary_term' = 'Network Device Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `network_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `network_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `origin_location_id` SET TAGS ('dbx_business_glossary_term' = 'Origin Location ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `shipment_carrier_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `shipment_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Carrier ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `actual_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Actual Arrival Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `bill_of_lading_number` SET TAGS ('dbx_business_glossary_term' = 'Bill of Lading Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Email');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `carrier_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Carrier Contact Phone');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `carrier_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `container_number` SET TAGS ('dbx_business_glossary_term' = 'Container Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_business_glossary_term' = 'Customs Clearance Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `customs_clearance_status` SET TAGS ('dbx_value_regex' = 'pending|cleared|rejected');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `customs_document_number` SET TAGS ('dbx_business_glossary_term' = 'Customs Document Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `customs_tariff_code` SET TAGS ('dbx_business_glossary_term' = 'Customs Tariff Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `delay_reason` SET TAGS ('dbx_business_glossary_term' = 'Delay Reason');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `destination_address` SET TAGS ('dbx_business_glossary_term' = 'Destination Address');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `destination_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `destination_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `expected_arrival_date` SET TAGS ('dbx_business_glossary_term' = 'Expected Arrival Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `freight_cost` SET TAGS ('dbx_business_glossary_term' = 'Freight Cost');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_business_glossary_term' = 'Freight Terms');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `freight_terms` SET TAGS ('dbx_value_regex' = 'FOB|CIF|EXW|DDP');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `hazmat_class` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Class');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `hazmat_flag` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `insurance_coverage_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `is_expedited` SET TAGS ('dbx_business_glossary_term' = 'Expedited Shipment Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `origin_address` SET TAGS ('dbx_business_glossary_term' = 'Origin Address');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `origin_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `origin_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `refrigeration_flag` SET TAGS ('dbx_business_glossary_term' = 'Refrigeration Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `required_temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Required Temperature (°C)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `ship_date` SET TAGS ('dbx_business_glossary_term' = 'Ship Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `shipment_number` SET TAGS ('dbx_business_glossary_term' = 'Shipment Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_business_glossary_term' = 'Shipment Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `shipment_status` SET TAGS ('dbx_value_regex' = 'planned|in_transit|delivered|cancelled|exception');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `special_handling_instructions` SET TAGS ('dbx_business_glossary_term' = 'Special Handling Instructions');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `temperature_control_flag` SET TAGS ('dbx_business_glossary_term' = 'Temperature Control Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Shipment Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `tracking_number` SET TAGS ('dbx_business_glossary_term' = 'Tracking Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_business_glossary_term' = 'Transportation Mode');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `transportation_mode` SET TAGS ('dbx_value_regex' = 'truck|rail|barge|pipeline|air');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `un_number` SET TAGS ('dbx_business_glossary_term' = 'UN Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `un_number` SET TAGS ('dbx_value_regex' = '^[0-9]{4}$');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `volume_cubic_m` SET TAGS ('dbx_business_glossary_term' = 'Volume (cubic meters)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`shipment` ALTER COLUMN `weight_kg` SET TAGS ('dbx_business_glossary_term' = 'Weight (kg)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` SET TAGS ('dbx_subdomain' = 'purchase_execution');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_id` SET TAGS ('dbx_business_glossary_term' = 'Service Entry Sheet ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `ci_account_id` SET TAGS ('dbx_business_glossary_term' = 'Ci Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `finance_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `posted_by_user_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Posted By User ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `posted_by_user_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `posted_by_user_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `primary_service_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approver ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `primary_service_employee_id` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `primary_service_employee_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_business_glossary_term' = 'Acceptance Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `acceptance_status` SET TAGS ('dbx_value_regex' = 'accepted|rejected|pending');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `approved_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approved Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `compliance_ferc_flag` SET TAGS ('dbx_business_glossary_term' = 'FERC Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `compliance_nerc_cip_flag` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `contract_number` SET TAGS ('dbx_business_glossary_term' = 'Contract Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `entry_sheet_number` SET TAGS ('dbx_business_glossary_term' = 'Entry Sheet Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `is_critical_service` SET TAGS ('dbx_business_glossary_term' = 'Critical Service Flag');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `net_amount` SET TAGS ('dbx_business_glossary_term' = 'Net Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'paid|unpaid|partial|hold');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `posted_by_user_name` SET TAGS ('dbx_business_glossary_term' = 'Posted By User Name');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `posted_by_user_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `posted_by_user_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `posting_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Posting Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `receipt_number` SET TAGS ('dbx_business_glossary_term' = 'Receipt Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `service_category` SET TAGS ('dbx_business_glossary_term' = 'Service Category');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `service_description` SET TAGS ('dbx_business_glossary_term' = 'Service Description');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `service_end_date` SET TAGS ('dbx_business_glossary_term' = 'Service End Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `service_entry_sheet_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|posted|closed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `service_location_description` SET TAGS ('dbx_business_glossary_term' = 'Service Location Description');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `service_po_number` SET TAGS ('dbx_business_glossary_term' = 'Service Purchase Order Number');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `service_quantity` SET TAGS ('dbx_business_glossary_term' = 'Service Quantity');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `service_start_date` SET TAGS ('dbx_business_glossary_term' = 'Service Start Date');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Amount');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_business_glossary_term' = 'Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `unit_of_measure` SET TAGS ('dbx_value_regex' = 'hour|day|unit|km|mwh|kwh');
ALTER TABLE `power_and_utilities_v2`.`supply`.`service_entry_sheet` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` SET TAGS ('dbx_subdomain' = 'vendor_relations');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `vendor_qualification_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Qualification Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Qualification Document Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Identifier');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `approved_commodity_categories` SET TAGS ('dbx_business_glossary_term' = 'Approved Commodity Categories (QUAL_COMMODITY_CAT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `bonding_amount` SET TAGS ('dbx_business_glossary_term' = 'Bonding Amount (QUAL_BOND_AMT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `bonding_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Bonding Expiry Date (QUAL_BOND_EXP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `diversity_status` SET TAGS ('dbx_business_glossary_term' = 'Diversity Status (QUAL_DIVERSITY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `diversity_status` SET TAGS ('dbx_value_regex' = 'minority|women|veteran|none');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `financial_rating` SET TAGS ('dbx_business_glossary_term' = 'Financial Rating (QUAL_FIN_RATING)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `insurance_company` SET TAGS ('dbx_business_glossary_term' = 'Insurance Company (QUAL_INS_COMPANY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `insurance_expiry_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiry Date (QUAL_INS_EXP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number (QUAL_INS_POLICY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `nerc_cip_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'NERC CIP Compliance Flag (QUAL_NERC_CIP)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Qualification Record Created Timestamp (QUAL_CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Effective Date (QUAL_EFF_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Expiration Date (QUAL_EXP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_number` SET TAGS ('dbx_business_glossary_term' = 'Qualification Number (QUAL_NUM)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_review_notes` SET TAGS ('dbx_business_glossary_term' = 'Qualification Review Notes (QUAL_REVIEW_NOTES)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_score` SET TAGS ('dbx_business_glossary_term' = 'Qualification Score (QUAL_SCORE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_source` SET TAGS ('dbx_business_glossary_term' = 'Qualification Source (QUAL_SOURCE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_source` SET TAGS ('dbx_value_regex' = 'internal|vendor_self|third_party_audit');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status (QUAL_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_status` SET TAGS ('dbx_value_regex' = 'qualified|disqualified|pending|revoked');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_status_reason` SET TAGS ('dbx_business_glossary_term' = 'Qualification Status Reason (QUAL_STATUS_REASON)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_business_glossary_term' = 'Qualification Type (QUAL_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_type` SET TAGS ('dbx_value_regex' = 'prequal|annual|requal|special');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Qualification Record Updated Timestamp (QUAL_UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_validated_by` SET TAGS ('dbx_business_glossary_term' = 'Qualification Validated By (QUAL_VALIDATED_BY)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `qualification_validated_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Validated Date (QUAL_VALIDATED_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Qualification Review Date (QUAL_REVIEW_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `safety_incident_count` SET TAGS ('dbx_business_glossary_term' = 'Safety Incident Count (QUAL_SAFETY_COUNT)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `safety_last_incident_date` SET TAGS ('dbx_business_glossary_term' = 'Safety Last Incident Date (QUAL_SAFETY_LAST_DATE)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `safety_record_status` SET TAGS ('dbx_business_glossary_term' = 'Safety Record Status (QUAL_SAFETY_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`supply`.`vendor_qualification` ALTER COLUMN `safety_record_status` SET TAGS ('dbx_value_regex' = 'good|fair|poor|none');
