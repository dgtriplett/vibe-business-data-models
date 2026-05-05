-- Schema for Domain: property | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:18

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`property` COMMENT 'Manages utility-owned real property, land rights, easements, buildings, facilities, and physical site master data. Serves as SSOT for all geographic and property assets distinct from electrical/gas infrastructure.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`parcel` (
    `parcel_id` BIGINT COMMENT 'System-generated unique identifier for the land parcel record.',
    `gis_boundary_id` BIGINT COMMENT 'Identifier of the GIS polygon representing the parcel geometry in the ArcGIS system.',
    `zoning_classification_id` BIGINT COMMENT 'FK to property.zoning_classification',
    `subdivided_from_parcel_id` BIGINT COMMENT 'Self-referencing FK on parcel (subdivided_from_parcel_id)',
    `acquisition_cost` DECIMAL(18,2) COMMENT 'Total monetary amount paid (or capitalized) to acquire the parcel.',
    `acquisition_date` DATE COMMENT 'Date the utility acquired ownership or lease rights to the parcel.',
    `acreage` DECIMAL(18,2) COMMENT 'Total land area of the parcel expressed in acres.',
    `apn` STRING COMMENT 'Official parcel number assigned by the county assessor, used as the external business identifier.',
    `building_count` STRING COMMENT 'Number of distinct buildings on the parcel.',
    `building_sqft` DECIMAL(18,2) COMMENT 'Total square footage of structures located on the parcel.',
    `county` STRING COMMENT 'County in which the parcel is located.',
    `current_market_value` DECIMAL(18,2) COMMENT 'Most recent assessed market value of the parcel.',
    `easement_flag` BOOLEAN COMMENT 'True if the parcel is subject to an easement.',
    `easement_type` STRING COMMENT 'Classification of the easement, if present.. Valid values are `right_of_way|utility|access|other`',
    `encumbrance_flag` BOOLEAN COMMENT 'True if any encumbrance (e.g., lien, easement) exists on the parcel.',
    `environmental_status` STRING COMMENT 'Environmental condition of the parcel based on site assessments.. Valid values are `clean|contaminated|investigation|remediated`',
    `flood_zone` STRING COMMENT 'FEMA flood zone designation for the parcel.. Valid values are `X|AE|A|VE|V|D`',
    `gis_polygon_reference` STRING COMMENT 'Identifier of the GIS polygon representing the parcel geometry in the ArcGIS system.',
    `historic_status` STRING COMMENT 'Historic preservation status of the parcel.. Valid values are `none|registered|protected`',
    `jurisdiction` STRING COMMENT 'Legal jurisdiction (city, township, etc.) governing the parcel.',
    `land_use_type` STRING COMMENT 'Primary intended use of the land as defined by the utilitys land‑use classification.. Valid values are `residential|commercial|industrial|agricultural|utility|mixed`',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the parcel centroid.',
    `lease_cost` DECIMAL(18,2) COMMENT 'Annual cost associated with leasing the parcel.',
    `lease_expiration_date` DATE COMMENT 'Date the current lease on the parcel expires, if applicable.',
    `legal_description` STRING COMMENT 'Full legal description of the parcel boundaries as recorded in the deed.',
    `lifecycle_status` STRING COMMENT 'Current lifecycle state of the parcel within the utilitys portfolio.. Valid values are `active|inactive|pending|retired|sold`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the parcel centroid.',
    `market_value_date` DATE COMMENT 'Date on which the current market value was determined.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the parcel.',
    `parcel_name` STRING COMMENT 'Human‑readable name or label for the parcel, often derived from legal description or common name.',
    `property_tax_status` STRING COMMENT 'Current payment status of property taxes for the parcel.. Valid values are `paid|delinquent|exempt`',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the parcel record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the parcel record.',
    `source_system` STRING COMMENT 'Originating source system that supplied the parcel data.. Valid values are `SAP|ArcGIS|MDM`',
    `tax_assessed_value` DECIMAL(18,2) COMMENT 'Assessed value of the parcel for property tax purposes.',
    `tax_assessed_year` STRING COMMENT 'Fiscal year for which the tax assessed value applies.',
    `title_status` STRING COMMENT 'Current status of the parcel title.. Valid values are `clear|lien|encumbered|pending`',
    `utility_service_flag` BOOLEAN COMMENT 'True if the parcel currently hosts utility service infrastructure.',
    `zoning_classification` STRING COMMENT 'Zoning code assigned by the local jurisdiction governing permissible uses.. Valid values are `R-1|R-2|C-1|C-2|I-1|M-1`',
    CONSTRAINT pk_parcel PRIMARY KEY(`parcel_id`)
) COMMENT 'Master record for each land parcel owned, leased, or otherwise held by the utility. Captures assessor parcel number (APN), legal description, acreage, zoning classification, land use designation, acquisition date, acquisition cost, current market value, county/jurisdiction, GIS polygon reference, title status, and encumbrance flags. Serves as the SSOT for all utility-owned and utility-controlled land parcels distinct from infrastructure asset locations.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`facility` (
    `facility_id` BIGINT COMMENT 'System-generated unique identifier for each facility record.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Asset‑management and reliability reporting need every utility facility (e.g., substations, warehouses) associated with its balancing area.',
    `control_zone_id` BIGINT COMMENT 'Foreign key linking to gridops.control_zone. Business justification: Load management process assigns each facility to a control zone to aggregate load forecasts and dispatch decisions.',
    `parent_facility_id` BIGINT COMMENT 'Self-referencing FK on facility (parent_facility_id)',
    `access_control_system` STRING COMMENT 'Primary method used to control entry to the facility.. Valid values are `card|biometric|keypad|none`',
    `annual_energy_consumption_mwh` DECIMAL(18,2) COMMENT 'Total electricity consumption of the facility in megawatt‑hours per year.',
    `annual_water_consumption_gallons` DECIMAL(18,2) COMMENT 'Total water usage of the facility in gallons per year.',
    `building_condition_rating` STRING COMMENT 'Assessment of the buildings overall condition.. Valid values are `excellent|good|fair|poor`',
    `city` STRING COMMENT 'City where the facility is located.',
    `construction_year` STRING COMMENT 'Calendar year the facility was constructed.',
    `country` STRING COMMENT 'Three‑letter ISO country code of the facility location.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the facility record was first created in the system.',
    `critical_infrastructure_flag` BOOLEAN COMMENT 'True if the facility is designated as critical infrastructure under CIP regulations.',
    `environmental_certification` STRING COMMENT 'Sustainability certification held by the facility.. Valid values are `LEED|BREEAM|ENERGY_STAR|NONE`',
    `facility_code` STRING COMMENT 'External or legacy code used to identify the facility in operational systems (e.g., GIS tag).',
    `facility_name` STRING COMMENT 'Human‑readable name of the facility (e.g., Main Office, Substation A).',
    `facility_status` STRING COMMENT 'Current lifecycle status of the facility.. Valid values are `active|inactive|planned|decommissioned|under_construction`',
    `facility_type` STRING COMMENT 'Category of the facility such as office, operations center, warehouse, control room, substation, or other.. Valid values are `office|operations|warehouse|control_room|substation|other`',
    `fire_suppression_type` STRING COMMENT 'Type of fire suppression system installed (e.g., sprinkler, FM‑200).',
    `geolocation_latitude` DOUBLE COMMENT 'Latitude coordinate of the facility (decimal degrees).',
    `geolocation_longitude` DOUBLE COMMENT 'Longitude coordinate of the facility (decimal degrees).',
    `gross_square_feet` DECIMAL(18,2) COMMENT 'Total usable floor area of the facility measured in square feet.',
    `hvac_system_type` STRING COMMENT 'Primary heating, ventilation, and air‑conditioning system type.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent facility inspection.',
    `last_maintenance_date` DATE COMMENT 'Date the facility most recently underwent preventive maintenance.',
    `lease_expiration_date` DATE COMMENT 'Date the current lease agreement ends (null for owned facilities).',
    `lease_owned_flag` BOOLEAN COMMENT 'True if the facility is owned by the utility; False if leased.',
    `manager_name` STRING COMMENT 'Full name of the person responsible for facility operations.',
    `manager_phone` STRING COMMENT 'Primary contact phone number for the facility manager.',
    `next_inspection_due` DATE COMMENT 'Planned date for the next required inspection.',
    `next_maintenance_due` DATE COMMENT 'Scheduled date for the next preventive maintenance activity.',
    `occupancy_capacity` STRING COMMENT 'Maximum number of people the facility can safely accommodate.',
    `parking_spaces` STRING COMMENT 'Number of vehicle parking spaces available on site.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the facility address.',
    `regional_area_code` STRING COMMENT 'Internal code representing the utilitys service region or planning area.',
    `state` STRING COMMENT 'State or province of the facility location.',
    `street_address` STRING COMMENT 'Street portion of the facilitys physical address.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the facility record.',
    CONSTRAINT pk_facility PRIMARY KEY(`facility_id`)
) COMMENT 'Master record for each utility-owned or utility-operated building and facility structure including administrative offices, operations centers, control buildings, maintenance shops, warehouses, substations buildings, and visitor centers. Captures facility name, facility type (office, operations, warehouse, control room), address, gross square footage, construction year, occupancy capacity, building condition rating, lease vs. owned flag, and facility manager. Distinct from infrastructure assets (poles, transformers) which are owned by the asset domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`easement` (
    `easement_id` BIGINT COMMENT 'System-generated unique identifier for the easement record.',
    `parent_easement_id` BIGINT COMMENT 'Self-referencing FK on easement (parent_easement_id)',
    `area_acres` DECIMAL(18,2) COMMENT 'Total land area covered by the easement expressed in acres.',
    `centerline_length_ft` DECIMAL(18,2) COMMENT 'Length of the easement centerline measured in feet.',
    `compensation_amount` DECIMAL(18,2) COMMENT 'Monetary compensation paid to the grantor for the easement.',
    `compensation_currency` STRING COMMENT 'Currency of the compensation amount (e.g., USD).. Valid values are `USD`',
    `compliance_regulation` STRING COMMENT 'Regulatory framework governing the easement (e.g., FERC, NERC).',
    `county` STRING COMMENT 'County where the easement is located.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the easement record was first created in the system.',
    `document_url` STRING COMMENT 'Link to the digital copy of the recorded easement document.',
    `easement_description` STRING COMMENT 'Free‑form description of the easement purpose and conditions.',
    `easement_number` STRING COMMENT 'External business identifier or reference number assigned to the easement.',
    `easement_status` STRING COMMENT 'Current lifecycle status of the easement.. Valid values are `active|expired|disputed|vacated`',
    `easement_type` STRING COMMENT 'Category of easement right (e.g., transmission right‑of‑way, distribution corridor).. Valid values are `transmission_row|distribution_corridor|pipeline_corridor|access_road|drainage`',
    `effective_from` DATE COMMENT 'Date the easement rights become effective.',
    `effective_until` DATE COMMENT 'Expiration date of the easement if it is term‑based; null for perpetual rights.',
    `expiration_reason` STRING COMMENT 'Reason why the easement expired or was terminated.. Valid values are `term_end|relinquished|court_action|other`',
    `gis_feature_reference` BIGINT COMMENT 'Identifier linking to the GIS feature representing the easement geometry.',
    `grantor_name` STRING COMMENT 'Legal name of the landowner or entity granting the easement.',
    `grantor_parcel_apn` STRING COMMENT 'Assessors Parcel Number (APN) of the grantors land parcel.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the easement corridor.',
    `last_inspection_result` STRING COMMENT 'Outcome of the most recent inspection.. Valid values are `satisfactory|issues|pending`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the easement record.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the easement centroid.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the easement centroid.',
    `recorded_document_number` STRING COMMENT 'Official document number of the recorded easement agreement.',
    `recorder_book_page` STRING COMMENT 'Book and page reference in the county recorders office where the easement is filed.',
    `recording_date` DATE COMMENT 'Date the easement was officially recorded with the county.',
    `regulatory_filing_number` STRING COMMENT 'Identifier of any regulatory filing associated with the easement.',
    `source_system` STRING COMMENT 'Source system that originally captured the easement record (e.g., ArcGIS, SAP).',
    `source_system_code` STRING COMMENT 'Native identifier of the easement in the source system.',
    `state` STRING COMMENT 'Two‑letter state abbreviation for the easement location.. Valid values are `^[A-Z]{2}$`',
    `status_notes` STRING COMMENT 'Additional notes regarding the current status or disputes.',
    `term_years` STRING COMMENT 'Number of years the easement is granted for, if term‑based.',
    `width_ft` DECIMAL(18,2) COMMENT 'Width of the easement corridor measured in feet.',
    `zip_code` STRING COMMENT 'Five‑digit postal ZIP code for the easement location.. Valid values are `^d{5}$`',
    CONSTRAINT pk_easement PRIMARY KEY(`easement_id`)
) COMMENT 'Master record for each utility easement, right-of-entry, or access agreement held by the utility over third-party land. Captures easement type (transmission ROW, distribution corridor, pipeline corridor, access road, drainage), grantor name, grantor parcel APN, easement width (feet), centerline length, recorded document number, county recorder book/page, recording date, expiration date (if term easement), compensation paid, and current status (active, expired, disputed, vacated). Serves as SSOT for all utility land rights over non-owned property.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`land_right` (
    `land_right_id` BIGINT COMMENT 'System-generated unique identifier for each land right record.',
    `parcel_id` BIGINT COMMENT 'Identifier of the land parcel associated with the right, referencing the property master data.',
    `parent_land_right_id` BIGINT COMMENT 'Self-referencing FK on land_right (parent_land_right_id)',
    `annual_fee_amount` DECIMAL(18,2) COMMENT 'Monetary amount payable annually for the land right.',
    `approval_date` DATE COMMENT 'Date when regulatory approval was granted.',
    `corridor_reference` STRING COMMENT 'Identifier for a linear corridor (e.g., right-of-way) when the right applies to a corridor rather than a single parcel.',
    `effective_end_date` DATE COMMENT 'Date when the land right expires or terminates, if known.',
    `effective_start_date` DATE COMMENT 'Date when the land right becomes legally effective.',
    `expiration_notice_date` DATE COMMENT 'Date on which notice of upcoming expiration must be sent.',
    `fee_currency` STRING COMMENT 'Currency code for the annual fee.. Valid values are `USD|CAD|EUR`',
    `fee_payment_frequency` STRING COMMENT 'How often the annual fee is invoiced.. Valid values are `annual|quarterly|monthly|one_time`',
    `governing_body` STRING COMMENT 'Regulatory or governmental body whose rules govern the land right.. Valid values are `FERC|NERC|PUC|State|Local`',
    `governing_document_reference` STRING COMMENT 'Reference to the legal document (e.g., deed, contract) that establishes the right.',
    `grantee_name` STRING COMMENT 'Name of the utility company or subsidiary receiving the land right.',
    `grantor_name` STRING COMMENT 'Name of the party granting the land right (e.g., municipality, private landowner).',
    `grantor_type` STRING COMMENT 'Classification of the grantor entity.. Valid values are `municipality|private_owner|state_agency|federal_agency|tribal`',
    `is_assignable` BOOLEAN COMMENT 'True if the right can be assigned to a third party without utility consent.',
    `is_exclusive` BOOLEAN COMMENT 'True if the right grants exclusive use of the land area.',
    `is_transferable` BOOLEAN COMMENT 'True if the right can be transferred to another party.',
    `land_right_status` STRING COMMENT 'Current lifecycle status of the land right.. Valid values are `active|inactive|pending|terminated|suspended|expired`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the land right record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the land right record.',
    `regulatory_approval_status` STRING COMMENT 'Current status of any required regulatory approvals.. Valid values are `approved|pending|rejected|under_review`',
    `renewal_option` STRING COMMENT 'Whether the right automatically renews, requires action, or does not renew.. Valid values are `automatic|optional|none`',
    `renewal_term_years` STRING COMMENT 'Number of years for each renewal period after the initial term.',
    `right_description` STRING COMMENT 'Narrative description of the land right, including purpose and scope.',
    `right_number` STRING COMMENT 'External reference number or code assigned to the land right by the utility.',
    `right_type` STRING COMMENT 'Category of the land right indicating the legal instrument type.. Valid values are `easement|license|permit|franchise|temporary_construction|surface_use`',
    `termination_date` DATE COMMENT 'Date when the land right was terminated prior to its scheduled end.',
    `termination_reason` STRING COMMENT 'Reason for early termination of the land right.',
    CONSTRAINT pk_land_right PRIMARY KEY(`land_right_id`)
) COMMENT 'Master record for all other utility land rights beyond easements, including licenses, permits-to-enter, temporary construction licenses, franchise agreements with municipalities, and surface use agreements. Captures right type, grantor/licensor, affected parcel or corridor, term start/end dates, annual fee, renewal terms, governing document reference, and right status. Complements the easement entity by covering non-easement land access instruments.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`site` (
    `site_id` BIGINT COMMENT 'Unique surrogate key for each site record.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Generation‑site reporting to market operators requires linking each site to its balancing area for LMP and settlement.',
    `parcel_id` BIGINT COMMENT 'Identifier of the land parcel on which the site resides.',
    `parent_site_id` BIGINT COMMENT 'Self-referencing FK on site (parent_site_id)',
    `access_restriction_flag` BOOLEAN COMMENT 'True if the site has access restrictions (e.g., fenced, permit‑only).',
    `address_line` STRING COMMENT 'Street address of the site.',
    `boundary_polygon_ref` STRING COMMENT 'Reference (e.g., URI or file name) to the GIS polygon defining the site boundary.',
    `city` STRING COMMENT 'City where the site is located.',
    `contact_email` STRING COMMENT 'Primary email address for site communications.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `contact_phone` STRING COMMENT 'Primary telephone number for site communications.',
    `country` STRING COMMENT 'Three‑letter ISO country code.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the site record was first created in the system.',
    `criticality_rating` STRING COMMENT 'Business‑assigned criticality rating (1‑5) indicating importance to operations.',
    `decommission_date` DATE COMMENT 'Date the site was officially decommissioned, if applicable.',
    `effective_from` DATE COMMENT 'Date from which the site record is considered active for reporting.',
    `effective_until` DATE COMMENT 'Date after which the site record is no longer active (null if open‑ended).',
    `elevation_meters` DECIMAL(18,2) COMMENT 'Site elevation above mean sea level, expressed in meters.',
    `environmental_classification` STRING COMMENT 'Environmental sensitivity classification of the site.. Valid values are `wetland|habitat|protected|none`',
    `facility_ids` STRING COMMENT 'Comma‑separated list of facility identifiers located at the site.',
    `fuel_type` STRING COMMENT 'Primary fuel source used at the site.. Valid values are `renewable|fossil|nuclear|hydro|biomass|other`',
    `generation_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum electrical generation capacity at the site, expressed in megawatts.',
    `grid_connection_point` STRING COMMENT 'Identifier of the point where the site connects to the transmission grid.',
    `grid_voltage_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level of the grid connection, in kilovolts.',
    `land_use_type` STRING COMMENT 'Primary land‑use designation for the site.. Valid values are `industrial|commercial|residential|agricultural|undeveloped`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent site inspection.',
    `last_inspection_result` STRING COMMENT 'Outcome of the most recent inspection.. Valid values are `pass|fail|conditional`',
    `last_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the site record.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the site centroid in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the site centroid in decimal degrees.',
    `maintenance_schedule` STRING COMMENT 'Standard maintenance frequency for the site.. Valid values are `annual|semiannual|quarterly`',
    `manager` STRING COMMENT 'Name of the manager responsible for the site.',
    `operational_since` DATE COMMENT 'Date the site began active operations.',
    `owner_department` STRING COMMENT 'Internal department that owns the site.',
    `region` STRING COMMENT 'Broad geographic region (e.g., Northeast, Southwest).',
    `remediation_status` STRING COMMENT 'Current status of any environmental remediation activities.. Valid values are `not_started|in_progress|completed|not_applicable`',
    `renewable_flag` BOOLEAN COMMENT 'Indicates whether the site generates renewable energy (true) or not (false).',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk score derived from safety, environmental, and operational factors.',
    `security_level` STRING COMMENT 'Security classification governing access controls.. Valid values are `low|medium|high|restricted`',
    `site_code` STRING COMMENT 'External business identifier or code assigned to the site.',
    `site_description` STRING COMMENT 'Narrative description of the site, including purpose and notable features.',
    `site_name` STRING COMMENT 'Human‑readable name of the site.',
    `site_status` STRING COMMENT 'Current lifecycle state of the site.. Valid values are `active|inactive|decommissioned|remediation|planned|closed`',
    `site_type` STRING COMMENT 'Classification of the site by its primary function.. Valid values are `generation|substation|service_center|laydown|remediation|transmission`',
    `state` STRING COMMENT 'Two‑letter state or province code.',
    `timezone` STRING COMMENT 'IANA time zone identifier for the site.',
    `total_acreage` DECIMAL(18,2) COMMENT 'Total land area of the site in acres.',
    `zip_code` STRING COMMENT 'Postal ZIP code for the site location.. Valid values are `^d{5}$`',
    CONSTRAINT pk_site PRIMARY KEY(`site_id`)
) COMMENT 'Master record for each distinct physical site or geographic location managed by the utility as a property unit, including generation plant sites, substation sites, service center yards, laydown areas, and environmental remediation sites. Captures site name, site type, GIS coordinates (centroid lat/long), site boundary polygon reference, total acreage, site status (active, inactive, remediation, decommissioned), associated facility IDs, and environmental classification. Acts as the geographic anchor linking parcels, facilities, and infrastructure.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`property_lease` (
    `property_lease_id` BIGINT COMMENT 'System-generated unique identifier for the property lease record.',
    `business_entity_id` BIGINT COMMENT 'Foreign key linking to customer.business_entity. Business justification: Lease management reports require identifying the business entity tenant of each property lease for commercial billing and compliance.',
    `counterparty_id` BIGINT COMMENT 'Foreign key linking to trading.counterparty. Business justification: Leases involve external counterparties; lease accounting and regulatory filings need a direct counterparty link.',
    `renewed_property_lease_id` BIGINT COMMENT 'Self-referencing FK on property_lease (renewed_property_lease_id)',
    `city` STRING COMMENT 'City where the leased premises are located.',
    `commencement_date` DATE COMMENT 'Date the lessee takes possession of the premises.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance conditions attached to the lease.',
    `counterparty_type` STRING COMMENT 'Indicates whether the utility is the lessor or lessee in the lease.. Valid values are `lessor|lessee`',
    `country` STRING COMMENT 'Three‑letter ISO country code of the leased premises.',
    `document_url` STRING COMMENT 'Link to the electronic lease agreement document.',
    `early_termination_fee` DECIMAL(18,2) COMMENT 'Fee payable if the lease is terminated before the effective end date.',
    `effective_end_date` DATE COMMENT 'Date the lease terminates or expires; null for open‑ended agreements.',
    `effective_start_date` DATE COMMENT 'Date the lease becomes legally binding.',
    `is_exclusive_use` BOOLEAN COMMENT 'Indicates whether the lessee has exclusive rights to the premises.',
    `is_sublease_allowed` BOOLEAN COMMENT 'Indicates whether the lessee may sub‑lease the premises.',
    `lease_number` STRING COMMENT 'External lease number or code used in contracts and communications.',
    `lease_status` STRING COMMENT 'Current lifecycle status of the lease agreement.. Valid values are `active|inactive|terminated|pending|draft`',
    `lease_type` STRING COMMENT 'Category of lease indicating the nature of the property (e.g., ground lease, building lease).. Valid values are `ground|building|tower|cell_antenna|other`',
    `notes` STRING COMMENT 'Free‑form notes or comments about the lease.',
    `postal_code` STRING COMMENT 'Postal/ZIP code for the leased premises.',
    `premises_address` STRING COMMENT 'Street address of the leased property.',
    `premises_description` STRING COMMENT 'Narrative description of the leased premises, including building name or site details.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the lease record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lease record.',
    `regulatory_filing_status` STRING COMMENT 'Status of any required regulatory filings for the lease.. Valid values are `filed|pending|exempt`',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to lease end that renewal notice must be given.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the lease includes a renewal option.',
    `renewal_term_months` STRING COMMENT 'Length of the renewal term in months, if renewal option is exercised.',
    `rent_amount` DECIMAL(18,2) COMMENT 'Base rent payable per rent frequency period.',
    `rent_currency` STRING COMMENT 'Currency of the rent amount, using ISO 4217 codes.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `rent_escalation_amount` DECIMAL(18,2) COMMENT 'Fixed amount added to rent at each escalation interval (used when escalation type is fixed).',
    `rent_escalation_interval_months` STRING COMMENT 'Number of months between rent escalations.',
    `rent_escalation_percent` DECIMAL(18,2) COMMENT 'Percentage increase applied to rent at each escalation interval (used when escalation type is percentage).',
    `rent_escalation_type` STRING COMMENT 'Method used to increase rent over time.. Valid values are `fixed|percentage|none`',
    `rent_frequency` STRING COMMENT 'How often rent is due (e.g., monthly, annual).. Valid values are `monthly|annual|quarterly`',
    `security_deposit_amount` DECIMAL(18,2) COMMENT 'Monetary security deposit held against the lease.',
    `security_deposit_currency` STRING COMMENT 'Currency of the security deposit.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `square_feet` DECIMAL(18,2) COMMENT 'Total rentable area of the premises in square feet.',
    `state` STRING COMMENT 'State or province of the leased premises.',
    `termination_notice_period_days` STRING COMMENT 'Number of days required to give notice for early termination.',
    CONSTRAINT pk_property_lease PRIMARY KEY(`property_lease_id`)
) COMMENT 'Master record for real property leases where the utility is either the lessor (leasing utility-owned property to third parties) or lessee (leasing property from third-party owners for utility use). Captures lease type (ground lease, building lease, tower lease, cell antenna lease), counterparty name, leased premises description, lease term start/end, base rent amount, rent escalation schedule, renewal options, security deposit, and lease status. Distinct from ASC 842 finance/operating lease accounting records owned by the finance domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`acquisition` (
    `acquisition_id` BIGINT COMMENT 'Unique identifier for the property acquisition record.',
    `acquirer_business_entity_id` BIGINT COMMENT 'Internal utility party identifier acquiring the property.',
    `business_entity_id` BIGINT COMMENT 'Internal utility party identifier acquiring the property.',
    `parcel_id` BIGINT COMMENT 'Unique identifier of the land parcel (e.g., APN).',
    `person_id` BIGINT COMMENT 'External party identifier selling the property.',
    `seller_business_entity_id` BIGINT COMMENT 'External party identifier selling the property.',
    `related_acquisition_id` BIGINT COMMENT 'Self-referencing FK on acquisition (related_acquisition_id)',
    `acquisition_number` STRING COMMENT 'External reference number assigned to the acquisition transaction.',
    `acquisition_status` STRING COMMENT 'Current lifecycle status of the acquisition.. Valid values are `pending|under_review|closed|cancelled`',
    `acquisition_type` STRING COMMENT 'Category of acquisition method.. Valid values are `fee_simple|condemnation|donation|tax_deed`',
    `appraisal_date` DATE COMMENT 'Date the appraisal was performed.',
    `appraisal_value` DECIMAL(18,2) COMMENT 'Independent appraisal value of the property at acquisition time.',
    `closing_date` DATE COMMENT 'Date when the acquisition transaction closed and title transferred.',
    `comments` STRING COMMENT 'Free-text notes regarding the acquisition.',
    `country` STRING COMMENT 'Country code of the property location.. Valid values are `USA|CAN|MEX`',
    `county` STRING COMMENT 'County where the property is located.',
    `deed_type` STRING COMMENT 'Legal type of deed recorded for the acquisition.. Valid values are `warranty|quitclaim|grant|easement|lease`',
    `environmental_status` STRING COMMENT 'Known environmental condition of the property.. Valid values are `clear|contaminated|under_remediation|unknown`',
    `escrow_number` STRING COMMENT 'Escrow reference number for the transaction.',
    `event_timestamp` TIMESTAMP COMMENT 'Date and time when the acquisition event (e.g., contract signing) occurred.',
    `financing_source` STRING COMMENT 'Source of funds used for the acquisition.. Valid values are `capital|debt|grant|bond|other`',
    `geographic_latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the property centroid.',
    `geographic_longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the property centroid.',
    `internal_project_code` STRING COMMENT 'Utility internal project identifier associated with the acquisition.',
    `is_critical_infrastructure` BOOLEAN COMMENT 'Indicates whether the property is part of critical infrastructure.',
    `land_area_acres` DECIMAL(18,2) COMMENT 'Total land area acquired, measured in acres.',
    `land_use_zoning` STRING COMMENT 'Zoning classification of the acquired land.',
    `net_price` DECIMAL(18,2) COMMENT 'Net amount after taxes and fees.',
    `purchase_price` DECIMAL(18,2) COMMENT 'Gross purchase price paid for the property before adjustments.',
    `purchase_price_currency` STRING COMMENT 'Currency code of the purchase price.. Valid values are `USD|CAD|EUR`',
    `purpose` STRING COMMENT 'Business purpose for acquiring the property.. Valid values are `generation_siting|transmission_corridor|service_center|environmental_mitigation|other`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the acquisition record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the acquisition record.',
    `recording_date` DATE COMMENT 'Date the deed was recorded with the appropriate authority.',
    `regulatory_approval_status` STRING COMMENT 'Status of any required regulatory approvals for the acquisition.. Valid values are `approved|pending|denied|not_required`',
    `seller_name` STRING COMMENT 'Legal name of the seller or grantor.',
    `state` STRING COMMENT 'State where the property is located.',
    `taxes_and_fees` DECIMAL(18,2) COMMENT 'Total taxes, recording fees, and other adjustments associated with the acquisition.',
    `title_company` STRING COMMENT 'Name of the title company handling the closing.',
    CONSTRAINT pk_acquisition PRIMARY KEY(`acquisition_id`)
) COMMENT 'Transactional record for each real property acquisition event including fee simple purchases, condemnation proceedings (eminent domain), donation/dedication, and tax deed acquisitions. Captures acquisition type, seller/grantor name, purchase price, appraisal value, closing date, title company, escrow number, deed type, recording information, associated parcel IDs, and acquisition purpose (generation siting, T&D corridor, service center, environmental mitigation). Tracks the full lifecycle from offer through closing and title recording.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`disposition` (
    `disposition_id` BIGINT COMMENT 'Unique identifier for the disposition record.',
    `business_entity_id` BIGINT COMMENT 'Identifier of the party acquiring the property.',
    `disposition_business_entity_id` BIGINT COMMENT 'Identifier of the party acquiring the property.',
    `disposition_seller_party_business_entity_id` BIGINT COMMENT 'Identifier of the party disposing of the property.',
    `parcel_id` BIGINT COMMENT 'Unique identifier for the land parcel within the GIS system.',
    `seller_party_business_entity_id` BIGINT COMMENT 'Identifier of the party disposing of the property.',
    `related_disposition_id` BIGINT COMMENT 'Self-referencing FK on disposition (related_disposition_id)',
    `adjustment_amount` DECIMAL(18,2) COMMENT 'Total of fees, taxes, or other monetary adjustments applied to the sale price.',
    `appraisal_date` DATE COMMENT 'Date the appraisal was performed.',
    `appraisal_value` DECIMAL(18,2) COMMENT 'Independent appraisal value of the property at disposition time.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the disposition record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.',
    `deed_type` STRING COMMENT 'Legal instrument used to transfer the property.. Valid values are `warranty|quitclaim|grant|easement`',
    `disposition_number` STRING COMMENT 'Business identifier assigned to the disposition event.',
    `disposition_status` STRING COMMENT 'Current lifecycle status of the disposition record.. Valid values are `draft|pending|approved|closed|cancelled`',
    `disposition_type` STRING COMMENT 'Category of the property disposition transaction.. Valid values are `sale|quitclaim|abandonment|dedication|exchange`',
    `effective_date` DATE COMMENT 'Date on which the disposition legally takes effect.',
    `event_timestamp` TIMESTAMP COMMENT 'Timestamp of the primary disposition event (e.g., closing date and time).',
    `expiration_date` DATE COMMENT 'Date when any rights or obligations from the disposition expire, if applicable.',
    `gain_loss_amount` DECIMAL(18,2) COMMENT 'Monetary gain or loss realized from the disposition.',
    `gain_loss_indicator` STRING COMMENT 'Indicator of whether the disposition resulted in a gain, loss, or break‑even.. Valid values are `gain|loss|break_even`',
    `land_area_sqft` DECIMAL(18,2) COMMENT 'Total land area of the parcel in square feet.',
    `land_use_type` STRING COMMENT 'Primary use classification of the property.. Valid values are `residential|commercial|industrial|agricultural|public|other`',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the property location.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the property location.',
    `net_proceeds` DECIMAL(18,2) COMMENT 'Net amount received after subtracting adjustments from the sale price.',
    `notes` STRING COMMENT 'Free‑text field for any additional remarks or comments.',
    `property_address` STRING COMMENT 'Street address of the property being disposed.',
    `recording_date` DATE COMMENT 'Date the deed was recorded in the public land records.',
    `recording_number` STRING COMMENT 'Official recording number assigned by the county recorder.',
    `regulatory_approval_number` STRING COMMENT 'Reference number for any required regulatory approval.',
    `regulatory_approval_status` STRING COMMENT 'Current status of the regulatory approval process.. Valid values are `pending|approved|denied`',
    `sale_price` DECIMAL(18,2) COMMENT 'Gross sale price agreed for the property disposition.',
    `source_system` STRING COMMENT 'Name of the source system where the disposition record originated.',
    `tax_assessment_value` DECIMAL(18,2) COMMENT 'Assessed value used for property tax calculations.',
    `tax_implications` STRING COMMENT 'Narrative description of tax consequences arising from the disposition.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the disposition record.',
    `zoning_code` STRING COMMENT 'Zoning designation assigned by the local jurisdiction.',
    CONSTRAINT pk_disposition PRIMARY KEY(`disposition_id`)
) COMMENT 'Transactional record for each real property disposition event including fee simple sales, quitclaim deeds, abandonments, dedications to public agencies, and exchanges. Captures disposition type, buyer/grantee name, sale price, appraisal value, closing date, deed type, recording information, associated parcel IDs, regulatory approval reference (CPUC/FERC approval if required), and gain/loss on sale. Tracks the full lifecycle from listing/approval through closing.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`encroachment` (
    `encroachment_id` BIGINT COMMENT 'Unique system-generated identifier for each encroachment record.',
    `business_entity_id` BIGINT COMMENT 'Identifier of the third‑party entity that is encroaching on utility land.',
    `easement_id` BIGINT COMMENT 'Identifier of the easement corridor affected by the encroachment.',
    `parcel_id` BIGINT COMMENT 'Identifier of the land parcel where the encroachment occurred.',
    `person_id` BIGINT COMMENT 'Identifier of the third‑party entity that is encroaching on utility land.',
    `recurring_encroachment_id` BIGINT COMMENT 'Self-referencing FK on encroachment (recurring_encroachment_id)',
    `area_affected_sqft` DECIMAL(18,2) COMMENT 'Estimated area of the encroachment in square feet.',
    `discovery_timestamp` TIMESTAMP COMMENT 'Date and time when the encroachment was first identified.',
    `encroaching_party_name` STRING COMMENT 'Legal name of the third‑party organization or individual.',
    `encroachment_description` STRING COMMENT 'Narrative description of the encroachment condition.',
    `encroachment_number` STRING COMMENT 'External reference number assigned to the encroachment for tracking and reporting.',
    `encroachment_status` STRING COMMENT 'Current lifecycle state of the encroachment case.. Valid values are `open|notice_issued|resolved|legal_action`',
    `encroachment_type` STRING COMMENT 'Category of the encroachment (e.g., structure, fence, vegetation, fill, excavation).. Valid values are `structure|fence|vegetation|fill|excavation`',
    `latitude` DECIMAL(18,2) COMMENT 'Latitude coordinate of the encroachment location.',
    `longitude` DECIMAL(18,2) COMMENT 'Longitude coordinate of the encroachment location.',
    `notes` STRING COMMENT 'Additional remarks or observations recorded by field staff.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the encroachment record was created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the encroachment record.',
    `report_source` STRING COMMENT 'Origin of the encroachment report (system generated, field observation, or customer complaint).. Valid values are `system|field|customer`',
    `reported_by` STRING COMMENT 'Name or identifier of the employee who reported the encroachment.',
    `resolution_date` DATE COMMENT 'Date when the encroachment was resolved or closed.',
    `resolution_method` STRING COMMENT 'Method used to resolve the encroachment.. Valid values are `notice|removal|legal_action|other`',
    `severity` STRING COMMENT 'Severity level of the encroachment based on impact to utility operations.. Valid values are `minor|moderate|major`',
    CONSTRAINT pk_encroachment PRIMARY KEY(`encroachment_id`)
) COMMENT 'Transactional record for each identified encroachment on utility-owned land or easement corridors by third parties. Captures encroachment type (structure, fence, vegetation, fill, excavation), encroaching party name and contact, affected parcel or easement ID, discovery date, GIS location, encroachment severity (minor, moderate, major), resolution status (open, notice issued, resolved, legal action), resolution date, and resolution method. Supports ROW protection and legal enforcement workflows.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`permit` (
    `permit_id` BIGINT COMMENT 'Unique system-generated identifier for the permit record.',
    `parcel_id` BIGINT COMMENT 'Legal parcel identifier (e.g., APN) for the land covered by the permit.',
    `asset_capex_project_id` BIGINT COMMENT 'Identifier of the capital project associated with the permit.',
    `finance_capex_project_id` BIGINT COMMENT 'Identifier of the capital project associated with the permit.',
    `site_id` BIGINT COMMENT 'Identifier of the utility-owned site or property associated with the permit.',
    `renewed_permit_id` BIGINT COMMENT 'Self-referencing FK on permit (renewed_permit_id)',
    `activity_description` STRING COMMENT 'Narrative description of the activity authorized by the permit.',
    `amendment_date` DATE COMMENT 'Date the amendment was filed or approved.',
    `amendment_number` STRING COMMENT 'Sequential number of the amendment to the original permit.',
    `area_acres` DECIMAL(18,2) COMMENT 'Size of the land parcel covered by the permit.',
    `authorized_by` STRING COMMENT 'Name of the internal authority who approved the permit request.',
    `authorized_date` DATE COMMENT 'Date the internal authorization was granted.',
    `compliance_deadline` DATE COMMENT 'Date by which all permit conditions must be satisfied.',
    `compliance_status` STRING COMMENT 'Current compliance status relative to permit conditions.. Valid values are `compliant|non_compliant|pending|exempt`',
    `conditions` STRING COMMENT 'Specific conditions, restrictions, or requirements imposed by the agency.',
    `construction_end_date` DATE COMMENT 'Planned completion date for construction activities covered by the permit.',
    `construction_start_date` DATE COMMENT 'Planned start date for construction activities covered by the permit.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the permit record was first created in the system.',
    `document_url` STRING COMMENT 'Link to the digital copy of the permit document.',
    `effective_date` DATE COMMENT 'Date the permit becomes effective for the authorized activity.',
    `environmental_impact_flag` BOOLEAN COMMENT 'Indicates whether the permit involves environmental impact considerations.',
    `expiration_date` DATE COMMENT 'Date the permit expires unless renewed or extended.',
    `expiration_notice_date` DATE COMMENT 'Date the expiration notice was sent.',
    `expiration_notice_sent` BOOLEAN COMMENT 'Indicates whether an expiration notice has been sent to stakeholders.',
    `fee_amount` DECIMAL(18,2) COMMENT 'Monetary fee charged for the permit.',
    `fee_currency` STRING COMMENT 'Three‑letter ISO currency code for the permit fee.',
    `geocode_latitude` DOUBLE COMMENT 'Geographic latitude of the permit location.',
    `geocode_longitude` DOUBLE COMMENT 'Geographic longitude of the permit location.',
    `inspection_due_date` DATE COMMENT 'Date by which the required inspection must be completed.',
    `inspection_required` BOOLEAN COMMENT 'Indicates whether a site inspection is required for compliance.',
    `issue_date` DATE COMMENT 'Date the permit was officially issued by the agency.',
    `issuing_agency` STRING COMMENT 'Name of the governmental or regulatory agency that issued the permit.',
    `land_use_type` STRING COMMENT 'Primary land use designation (e.g., residential, commercial, industrial).',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection performed for this permit.',
    `last_inspection_result` STRING COMMENT 'Outcome of the most recent inspection.. Valid values are `pass|fail|conditional`',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the permit.',
    `payment_status` STRING COMMENT 'Current payment status of the permit fee.. Valid values are `unpaid|paid|partial|waived|pending`',
    `permit_category` STRING COMMENT 'Broad classification of the permit based on jurisdictional level.. Valid values are `federal|state|local|private`',
    `permit_number` STRING COMMENT 'Official permit number assigned by the issuing agency.',
    `permit_status` STRING COMMENT 'Current lifecycle status of the permit.. Valid values are `active|inactive|expired|revoked|pending|closed`',
    `permit_type` STRING COMMENT 'Category of the permit indicating its purpose and regulatory scope.. Valid values are `building|grading|encroachment|conditional_use|variance|special_use`',
    `renewal_date` DATE COMMENT 'Planned date for permit renewal submission.',
    `renewal_required` BOOLEAN COMMENT 'Indicates whether the permit must be renewed after expiration.',
    `status_reason` STRING COMMENT 'Explanation or code describing why the permit is in its current status.',
    `title` STRING COMMENT 'Short descriptive title of the permit.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the permit record.',
    `zoning_code` STRING COMMENT 'Zoning classification code applicable to the parcel.',
    CONSTRAINT pk_permit PRIMARY KEY(`permit_id`)
) COMMENT 'Master record for all land use, building, grading, and environmental permits obtained by the utility for property development, construction, and operations. Captures permit type (building, grading, encroachment, conditional use, variance, special use), issuing agency, permit number, issue date, expiration date, permitted activity description, associated site or parcel, permit conditions, inspection requirements, and permit status. Distinct from environmental operating permits (owned by regulatory domain) and generation environmental permits (owned by generation domain).';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`title_record` (
    `title_record_id` BIGINT COMMENT 'System-generated unique identifier for the title record.',
    `parcel_id` BIGINT COMMENT 'Unique identifier of the utility‑owned parcel to which this title record applies.',
    `prior_title_record_id` BIGINT COMMENT 'Self-referencing FK on title_record (prior_title_record_id)',
    `claim_history_flag` BOOLEAN COMMENT 'Indicates whether any title insurance claims have been filed for this parcel.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the title record was first created in the system.',
    `curative_action_deadline` DATE COMMENT 'Deadline by which required title curative actions must be completed.',
    `curative_action_required` BOOLEAN COMMENT 'Indicates whether title curative work is needed to resolve exceptions.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the policy amount (e.g., USD).',
    `deductible_amount` DECIMAL(18,2) COMMENT 'Deductible amount that must be satisfied before the title insurance pays a claim.',
    `encumbrances` STRING COMMENT 'List of recorded encumbrances affecting the parcel (e.g., easements, mortgages).',
    `filing_deadline` DATE COMMENT 'Date by which the title record must be submitted to the regulator.',
    `insurance_coverage_type` STRING COMMENT 'Indicates whether the title insurance provides full, partial, or no coverage.. Valid values are `full|partial|none`',
    `jurisdiction` STRING COMMENT 'State or jurisdiction governing the title; many possible values, consider reference table.',
    `notes` STRING COMMENT 'Free‑form notes entered by staff regarding the title record.',
    `policy_amount` DECIMAL(18,2) COMMENT 'Maximum monetary coverage provided by the title insurance policy.',
    `policy_effective_date` DATE COMMENT 'Date when the title insurance policy becomes effective.',
    `policy_expiration_date` DATE COMMENT 'Date when the title insurance policy expires or is scheduled to be renewed.',
    `policy_limit` DECIMAL(18,2) COMMENT 'Maximum liability limit of the title insurance policy.',
    `policy_number` STRING COMMENT 'Unique number assigned by the title insurance company to the policy.',
    `regulatory_filing_required` BOOLEAN COMMENT 'True if the title record must be filed with a public utility commission or other regulator.',
    `title_company` STRING COMMENT 'Name of the title company that issued the policy.',
    `title_document_url` STRING COMMENT 'Link to the digital copy of the title insurance policy or related documents.',
    `title_exceptions` STRING COMMENT 'Narrative description of any exceptions, liens, or encumbrances noted in the title search.',
    `title_insurer` STRING COMMENT 'Name of the insurance carrier providing the title insurance.',
    `title_search_date` DATE COMMENT 'Date the title search was performed for the parcel.',
    `title_status` STRING COMMENT 'Current status of the title: clear, clouded, disputed, or under examination.. Valid values are `clear|clouded|disputed|under_examination`',
    `title_type` STRING COMMENT 'Classification of the title document (e.g., deed, mortgage, easement).',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the title record.',
    `vesting_deed_reference` STRING COMMENT 'Reference identifier for the deed that conveys ownership rights.',
    CONSTRAINT pk_title_record PRIMARY KEY(`title_record_id`)
) COMMENT 'Master record for the chain of title and title insurance documentation for each utility-owned parcel. Captures title insurance policy number, title company, policy effective date, policy amount, title exceptions and encumbrances listed, title search date, vesting deed reference, and title status (clear, clouded, disputed, under examination). Supports title curative work, financing, and regulatory property filings.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`appraisal` (
    `appraisal_id` BIGINT COMMENT 'System-generated unique identifier for the appraisal record.',
    `person_id` BIGINT COMMENT 'Identifier of the person who approved the appraisal.',
    `appraisal_person_id` BIGINT COMMENT 'Identifier of the certified appraiser who performed the appraisal.',
    `appraisal_reviewed_by_person_id` BIGINT COMMENT 'Identifier of the person who reviewed the appraisal.',
    `approved_by_employee_id` BIGINT COMMENT 'Identifier of the person who approved the appraisal.',
    `easement_id` BIGINT COMMENT 'Identifier of any easement linked to the appraisal.',
    `employee_id` BIGINT COMMENT 'Identifier of the person who reviewed the appraisal.',
    `parcel_id` BIGINT COMMENT 'Identifier of the land parcel associated with the appraisal.',
    `vendor_id` BIGINT COMMENT 'Identifier of the certified appraiser who performed the appraisal.',
    `prior_appraisal_id` BIGINT COMMENT 'Self-referencing FK on appraisal (prior_appraisal_id)',
    `appraisal_date` TIMESTAMP COMMENT 'Timestamp when the appraisal was performed or signed.',
    `appraisal_number` STRING COMMENT 'External business identifier or reference number assigned to the appraisal.',
    `appraisal_scope` STRING COMMENT 'Scope of the appraisal coverage.. Valid values are `full|partial|site_specific`',
    `appraisal_status` STRING COMMENT 'Current lifecycle status of the appraisal.. Valid values are `draft|completed|approved|cancelled`',
    `appraisal_type` STRING COMMENT 'Classification of the appraisal based on its purpose and methodology.. Valid values are `fee|review|condemnation|insurance`',
    `appraised_value` DECIMAL(18,2) COMMENT 'Gross monetary value determined by the appraisal before any adjustments.',
    `approval_date` DATE COMMENT 'Date when the appraisal was formally approved.',
    `building_count` STRING COMMENT 'Count of distinct structures on the parcel.',
    `building_sqft` DECIMAL(18,2) COMMENT 'Total building floor area on the parcel in square feet.',
    `city` STRING COMMENT 'City where the appraised property is located.',
    `condition_rating` STRING COMMENT 'Overall physical condition rating of the property.. Valid values are `excellent|good|fair|poor`',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 code of the currency used for the appraisal values. [ENUM-REF-CANDIDATE: USD|EUR|CAD|GBP|JPY|AUD — promote to reference product]',
    `depreciation_rate_pct` DECIMAL(18,2) COMMENT 'Annual depreciation rate applied to the property value, expressed as a percentage.',
    `expiration_date` DATE COMMENT 'Date after which the appraisal value is no longer considered valid.',
    `fee` DECIMAL(18,2) COMMENT 'Fee charged for conducting the appraisal, treated as an adjustment to the gross value.',
    `is_confidential` BOOLEAN COMMENT 'Flag indicating whether the appraisal details are marked as confidential.',
    `land_area_sqft` DECIMAL(18,2) COMMENT 'Total land area of the parcel in square feet.',
    `land_use_type` STRING COMMENT 'Primary land use classification for the parcel.. Valid values are `residential|commercial|industrial|agricultural|utility`',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the property center point.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the property center point.',
    `market_trend_indicator` STRING COMMENT 'Qualitative indicator of current market trends affecting the appraisal (e.g., rising, stable, declining).',
    `net_appraised_value` DECIMAL(18,2) COMMENT 'Final monetary value after applying fees and adjustments.',
    `notes` STRING COMMENT 'Free‑form notes entered by the appraiser or reviewer.',
    `postal_code` STRING COMMENT 'Postal code of the appraised property address.',
    `purpose` STRING COMMENT 'Business reason for conducting the appraisal.. Valid values are `acquisition|disposition|rate_base|condemnation|insurance`',
    `reason` STRING COMMENT 'Narrative description of why the appraisal was initiated.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the appraisal record was first created in the system.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the appraisal record.',
    `region_code` STRING COMMENT 'Standardized code for the geographic region (e.g., state abbreviation).',
    `report_reference` STRING COMMENT 'Reference number or code of the formal appraisal report document.',
    `report_url` STRING COMMENT 'Link to the digital copy of the appraisal report.',
    `review_date` DATE COMMENT 'Date when a review appraisal was performed, if applicable.',
    `source_system` STRING COMMENT 'Originating system that created the appraisal record (e.g., SAP, Oracle).',
    `status_reason` STRING COMMENT 'Explanation for the current status, such as why an appraisal was cancelled.',
    `valuation_date` DATE COMMENT 'Date used for the market valuation component of the appraisal.',
    `valuation_methodology` STRING COMMENT 'Primary methodology used to determine the appraisal value.. Valid values are `sales_comparison|income|cost`',
    `version_number` STRING COMMENT 'Sequential version number for the appraisal record.',
    `year_built` STRING COMMENT 'Calendar year the primary building was constructed.',
    CONSTRAINT pk_appraisal PRIMARY KEY(`appraisal_id`)
) COMMENT 'Transactional record for each formal real property appraisal or valuation conducted for utility-owned or target-acquisition parcels. Captures appraisal type (fee appraisal, review appraisal, condemnation appraisal, insurance replacement cost), appraiser name and certification, appraisal date, appraised value, valuation methodology (sales comparison, income, cost), associated parcel or easement ID, appraisal purpose (acquisition, disposition, rate base, condemnation), and report reference. Supports rate base valuation and eminent domain proceedings.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`environmental_condition` (
    `environmental_condition_id` BIGINT COMMENT 'Unique identifier for the environmental condition record.',
    `business_entity_id` BIGINT COMMENT 'Identifier of the internal or external party responsible for remediation.',
    `location_id` BIGINT COMMENT 'Reference to the geographic location or parcel where the condition exists.',
    `person_id` BIGINT COMMENT 'Identifier of the internal or external party responsible for remediation.',
    `originating_environmental_condition_id` BIGINT COMMENT 'Self-referencing FK on environmental_condition (originating_environmental_condition_id)',
    `actual_remediation_cost` DECIMAL(18,2) COMMENT 'Final cost incurred for remediation after completion.',
    `comments` STRING COMMENT 'Free‑form notes or remarks about the condition.',
    `condition_description` STRING COMMENT 'Detailed narrative describing the nature, extent, and characteristics of the condition.',
    `condition_severity` STRING COMMENT 'Severity rating of the environmental condition based on risk and impact.. Valid values are `low|moderate|high|critical`',
    `condition_type` STRING COMMENT 'Category of environmental condition (e.g., soil contamination, groundwater contamination, PCB, asbestos, lead paint, underground storage tank).. Valid values are `soil|groundwater|pcb|asbestos|lead_paint|ust`',
    `contamination_level` DECIMAL(18,2) COMMENT 'Measured concentration of contaminant in the medium.',
    `contamination_unit` STRING COMMENT 'Unit of measure for the contamination level.. Valid values are `mg/kg|ppm|µg/L|mg/L`',
    `cost_currency` STRING COMMENT 'Three‑letter ISO currency code for cost values.. Valid values are `USD|CAD|EUR|GBP|JPY`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the system.',
    `discovery_date` DATE COMMENT 'Date the environmental condition was first identified or discovered.',
    `estimated_remediation_cost` DECIMAL(18,2) COMMENT 'Projected cost to remediate the condition, expressed in the reporting currency.',
    `last_monitoring_date` DATE COMMENT 'Date of the most recent monitoring event.',
    `monitoring_frequency` STRING COMMENT 'How often post‑remediation monitoring is performed.. Valid values are `monthly|quarterly|semiannual|annual|ad_hoc`',
    `next_monitoring_date` DATE COMMENT 'Planned date for the upcoming monitoring event.',
    `notification_date` DATE COMMENT 'Date the regulatory agency was notified about the condition.',
    `notification_status` STRING COMMENT 'Current status of regulatory notification for the condition.. Valid values are `notified|pending|exempt|unknown`',
    `record_status` STRING COMMENT 'Current lifecycle status of the record itself.. Valid values are `active|inactive|archived`',
    `regulatory_agency` STRING COMMENT 'Regulatory body overseeing the condition and remediation requirements.. Valid values are `FERC|NERC|EPA|PUC|State`',
    `regulatory_case_number` STRING COMMENT 'Unique identifier assigned by the regulatory agency for the case.',
    `remediation_end_date` DATE COMMENT 'Date remediation activities were completed or closed.',
    `remediation_method` STRING COMMENT 'Technique selected to remediate the condition.. Valid values are `excavation|pump_and_treat|in_situ|capping|bioremediation|none`',
    `remediation_start_date` DATE COMMENT 'Date remediation activities commenced.',
    `remediation_status` STRING COMMENT 'Current lifecycle status of remediation activities.. Valid values are `assessment|active|monitoring|closed|deferred`',
    `source_system` STRING COMMENT 'Originating system that supplied the condition data.. Valid values are `ArcGIS|Maximo|SAP|Custom`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_environmental_condition PRIMARY KEY(`environmental_condition_id`)
) COMMENT 'Master record for known environmental conditions, contamination findings, and remediation obligations associated with utility-owned or operated sites and parcels. Captures condition type (soil contamination, groundwater contamination, PCB, asbestos, lead paint, underground storage tank), discovery date, regulatory agency notification status, regulatory case number, remediation status (assessment, active remediation, monitoring, closed), responsible party designation, and estimated remediation cost. Supports environmental liability tracking and rate base regulatory asset filings.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`remediation_activity` (
    `remediation_activity_id` BIGINT COMMENT 'Unique identifier for the remediation activity record.',
    `environmental_condition_id` BIGINT COMMENT 'Link to the parent environmental condition record.',
    `finance_capex_project_id` BIGINT COMMENT 'Identifier of the overall remediation project to which this activity belongs.',
    `primary_remediation_vendor_id` BIGINT COMMENT 'Unique identifier for the contractor.',
    `site_id` BIGINT COMMENT 'Identifier of the utility‑owned site where the activity occurred.',
    `vendor_id` BIGINT COMMENT 'Unique identifier for the contractor.',
    `followup_remediation_activity_id` BIGINT COMMENT 'Self-referencing FK on remediation_activity (followup_remediation_activity_id)',
    `activity_date` TIMESTAMP COMMENT 'Date and time when the remediation activity was performed or scheduled.',
    `activity_number` STRING COMMENT 'Unique identifier assigned to the remediation activity by the utility.',
    `activity_status` STRING COMMENT 'Current lifecycle status of the remediation activity.. Valid values are `planned|in_progress|completed|cancelled|deferred`',
    `activity_type` STRING COMMENT 'Category of remediation work performed.. Valid values are `soil_excavation|groundwater_pump_treat|vapor_extraction|monitoring_well_sampling|cap_installation`',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Actual end date and time when the activity was completed.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Actual start date and time when the activity began.',
    `analytical_results_summary` STRING COMMENT 'Summary of lab analysis results for the removed material.',
    `approval_date` DATE COMMENT 'Date when the activity was approved by the regulator or internal authority.',
    `approved_by` STRING COMMENT 'Name of the internal employee who approved the activity.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the remediation activity.. Valid values are `compliant|non_compliant|pending_review`',
    `contractor_name` STRING COMMENT 'Name of the contractor performing the remediation.',
    `cost_incurred` DECIMAL(18,2) COMMENT 'Total cost incurred for the remediation activity.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the remediation activity record was first created.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for the cost amount.. Valid values are `USD|CAD|EUR`',
    `is_hazardous_material` BOOLEAN COMMENT 'Indicates if the removed material is classified as hazardous.',
    `latitude` DOUBLE COMMENT 'Latitude of the activity location in decimal degrees.',
    `location_description` STRING COMMENT 'Human‑readable description of the activity location (e.g., address, landmark).',
    `longitude` DOUBLE COMMENT 'Longitude of the activity location in decimal degrees.',
    `notes` STRING COMMENT 'Additional free‑text comments about the activity.',
    `regulatory_approval_reference` STRING COMMENT 'Reference number of the regulatory agency approval for the activity.',
    `scheduled_end_timestamp` TIMESTAMP COMMENT 'Planned end date and time for the remediation activity.',
    `scheduled_start_timestamp` TIMESTAMP COMMENT 'Planned start date and time for the remediation activity.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the remediation activity record.',
    `volume_removed` DECIMAL(18,2) COMMENT 'Quantity of material removed during the activity.',
    `volume_unit` STRING COMMENT 'Unit of measure for the removed volume.. Valid values are `cubic_meters|cubic_feet|tons`',
    `waste_disposal_certificate` STRING COMMENT 'Reference to the certificate documenting proper waste disposal.',
    `waste_disposal_method` STRING COMMENT 'Method used to dispose of waste generated by the activity.. Valid values are `landfill|incineration|recycling|on_site_treatment`',
    CONSTRAINT pk_remediation_activity PRIMARY KEY(`remediation_activity_id`)
) COMMENT 'Transactional record for each discrete remediation or environmental cleanup activity performed at a contaminated utility site. Captures activity type (soil excavation, groundwater pump-and-treat, vapor extraction, monitoring well sampling, cap installation), activity date, contractor name, volume of material removed, analytical results summary, regulatory agency approval reference, cost incurred, and activity status. Links to environmental_condition as the parent record and supports CERCLA/RCRA compliance tracking.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`space_allocation` (
    `space_allocation_id` BIGINT COMMENT 'System-generated unique identifier for each space allocation record.',
    `cost_center_id` BIGINT COMMENT 'Identifier of the internal department or business unit occupying the space.',
    `facility_id` BIGINT COMMENT 'Identifier of the utility facility (plant, office campus, warehouse) that contains the allocated space.',
    `superseded_space_allocation_id` BIGINT COMMENT 'Self-referencing FK on space_allocation (superseded_space_allocation_id)',
    `allocated_sqft` DECIMAL(18,2) COMMENT 'Total interior square footage assigned to the department or function.',
    `allocation_code` STRING COMMENT 'Business-visible code assigned to the allocation for tracking and reference.',
    `allocation_status` STRING COMMENT 'Current lifecycle status of the space allocation.. Valid values are `active|pending|terminated|closed`',
    `building_code` STRING COMMENT 'Code or identifier for the building within the facility where the space resides.',
    `chargeback_amount` DECIMAL(18,2) COMMENT 'Monetary amount allocated to the department for charge‑back accounting.',
    `chargeback_flag` BOOLEAN COMMENT 'Indicates whether the space cost is charged back to the occupying department.',
    `cost_center_code` STRING COMMENT 'Financial cost‑center code used for charge‑back and budgeting of the space.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the space allocation record was first created in the system.',
    `floor_number` STRING COMMENT 'Numeric floor level of the allocated space within the building.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.. Valid values are `passed|failed|pending|not_applicable`',
    `is_accessible` BOOLEAN COMMENT 'True if the space meets ADA or other accessibility requirements.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent safety or compliance inspection of the space.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or special conditions.',
    `occupancy_end_date` DATE COMMENT 'Date when the occupancy ended or is scheduled to end; null if ongoing.',
    `occupancy_start_date` DATE COMMENT 'Date when the department or function began occupying the space.',
    `rent_amount` DECIMAL(18,2) COMMENT 'Monetary amount charged for the space on each rent cycle.',
    `rent_currency` STRING COMMENT 'Three‑letter ISO currency code for the rent amount.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `rent_frequency` STRING COMMENT 'Billing frequency for the rent charge.. Valid values are `monthly|quarterly|annual`',
    `room_number` STRING COMMENT 'Room or suite number that uniquely identifies the space on the floor.',
    `security_level` STRING COMMENT 'Classification of the space based on security or data sensitivity.. Valid values are `public|confidential|restricted`',
    `source_system` STRING COMMENT 'Name of the source system that supplied the record (e.g., SAP, ArcGIS).',
    `space_label` STRING COMMENT 'Human‑readable label describing the allocated interior space (e.g., "Bldg A‑2nd Floor‑Room 203").',
    `space_type` STRING COMMENT 'Categorization of the space purpose (e.g., office, laboratory, operations floor, storage, common area).. Valid values are `office|lab|operations|storage|common_area|other`',
    `updated_by` STRING COMMENT 'User identifier of the person who last modified the record.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the space allocation record.',
    `wing` STRING COMMENT 'Alphabetic or alphanumeric identifier for the wing or section of the floor.',
    `created_by` STRING COMMENT 'User identifier of the person who created the record.',
    CONSTRAINT pk_space_allocation PRIMARY KEY(`space_allocation_id`)
) COMMENT 'Master record tracking the allocation and assignment of interior space within utility facilities to organizational units, departments, and functions. Captures facility ID, floor/wing/room identifier, allocated square footage, assigned department or cost center, occupancy start date, occupancy end date, space type (office, lab, operations floor, storage, common area), and allocation status. Supports facility space planning, chargeback cost allocation, and real estate portfolio optimization.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`facility_inspection` (
    `facility_inspection_id` BIGINT COMMENT 'System-generated unique identifier for each facility inspection record.',
    `facility_id` BIGINT COMMENT 'Unique identifier of the utility-owned facility that was inspected.',
    `reinspection_of_facility_inspection_id` BIGINT COMMENT 'Self-referencing FK on facility_inspection (reinspection_of_facility_inspection_id)',
    `auditor_comments` STRING COMMENT 'Comments added by the audit reviewer after evaluating the inspection report.',
    `compliance_flag` BOOLEAN COMMENT 'True if the facility meets all applicable regulatory requirements at the time of inspection.',
    `corrective_action_required` BOOLEAN COMMENT 'Indicates whether any corrective actions are mandated as a result of the inspection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the inspection record was first created in the system.',
    `deficiency_count` STRING COMMENT 'Total number of deficiencies recorded in the inspection.',
    `deficiency_severity` STRING COMMENT 'Highest severity level among all deficiencies identified.. Valid values are `critical|high|medium|low|none`',
    `equipment_status` STRING COMMENT 'Overall operational status of critical equipment observed during inspection.',
    `facility_inspection_status` STRING COMMENT 'Current lifecycle status of the inspection record.. Valid values are `scheduled|in_progress|completed|cancelled`',
    `findings_summary` STRING COMMENT 'Narrative summary of key findings identified during the inspection.',
    `follow_up_action_summary` STRING COMMENT 'Summary of corrective actions that must be completed after the inspection.',
    `follow_up_required_flag` BOOLEAN COMMENT 'Indicates whether a follow‑up inspection or action is required.',
    `high_severity_deficiency_count` STRING COMMENT 'Number of deficiencies classified as high or critical severity.',
    `inspection_date` TIMESTAMP COMMENT 'Date and time when the inspection was conducted.',
    `inspection_duration_minutes` STRING COMMENT 'Total time spent conducting the inspection, measured in minutes.',
    `inspection_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude where the inspection took place.',
    `inspection_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude where the inspection took place.',
    `inspection_report_url` STRING COMMENT 'Link to the digital copy of the full inspection report.',
    `inspection_type` STRING COMMENT 'Category of the inspection performed (e.g., fire safety, ADA compliance, structural, HVAC, regulatory).. Valid values are `fire|ada|structural|hvac|regulatory`',
    `inspector_affiliation` STRING COMMENT 'Organization or department the inspector belongs to (internal, third‑party, regulatory).',
    `inspector_name` STRING COMMENT 'Full legal name of the person who performed the inspection.',
    `low_severity_deficiency_count` STRING COMMENT 'Number of deficiencies classified as low or medium severity.',
    `next_inspection_due_date` DATE COMMENT 'Planned date for the next required inspection of the facility.',
    `notes` STRING COMMENT 'Free‑form field for any extra comments or observations not captured elsewhere.',
    `outcome` STRING COMMENT 'Result of the inspection: pass, conditional pass, or fail.. Valid values are `pass|conditional_pass|fail`',
    `regulatory_body` STRING COMMENT 'Regulatory authority overseeing the inspection (e.g., FERC, NERC, State PUC, EPA).. Valid values are `FERC|NERC|PUC|EPA`',
    `total_findings` STRING COMMENT 'Count of all distinct findings (deficiencies, observations, recommendations) recorded.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the inspection record.',
    `weather_conditions` STRING COMMENT 'Brief description of weather at the time of inspection (e.g., clear, rain, snow).',
    CONSTRAINT pk_facility_inspection PRIMARY KEY(`facility_inspection_id`)
) COMMENT 'Transactional record for each formal inspection of a utility facility or building including fire safety inspections, ADA compliance inspections, structural inspections, HVAC inspections, and regulatory building inspections. Captures inspection type, inspection date, inspector name and affiliation (internal, third-party, regulatory), facility ID, inspection findings summary, deficiency count, deficiency severity, corrective action required flag, and inspection outcome (pass, conditional pass, fail). Distinct from infrastructure asset inspections owned by the asset domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`lease_payment` (
    `lease_payment_id` BIGINT COMMENT 'System-generated unique identifier for the lease payment record.',
    `business_entity_id` BIGINT COMMENT 'Identifier of the counter‑party (tenant or landlord) involved in the payment.',
    `property_lease_id` BIGINT COMMENT 'Unique identifier of the lease agreement to which this payment applies.',
    `adjusted_lease_payment_id` BIGINT COMMENT 'Self-referencing FK on lease_payment (adjusted_lease_payment_id)',
    `amount_adjustments` DECIMAL(18,2) COMMENT 'Sum of all adjustments applied to the gross amount (taxes, fees, discounts).',
    `amount_gross` DECIMAL(18,2) COMMENT 'Total amount before any adjustments, taxes, or discounts.',
    `amount_net` DECIMAL(18,2) COMMENT 'Final amount after adjustments; the amount actually settled.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the lease payment record was first created in the data lake.',
    `currency_code` STRING COMMENT 'Three‑letter ISO 4217 currency code of the payment.. Valid values are `^[A-Z]{3}$`',
    `discount_amount` DECIMAL(18,2) COMMENT 'Any discount applied to the gross amount.',
    `dispute_reason` STRING COMMENT 'Text describing why a payment is in dispute, if applicable.',
    `exchange_rate` DECIMAL(18,2) COMMENT 'Currency conversion rate applied if payment currency differs from reporting currency.',
    `external_payment_reference` STRING COMMENT 'Identifier of the payment in an external financial system or bank reference.',
    `invoice_number` STRING COMMENT 'Reference to the invoice generated for this payment, if any.',
    `is_reconciled` BOOLEAN COMMENT 'Indicates whether the payment has been matched to accounting records.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Fee charged for late payment, if applicable.',
    `notes` STRING COMMENT 'Free‑form text for additional comments or remarks about the payment.',
    `payment_channel` STRING COMMENT 'Interface or channel through which the payment was initiated.. Valid values are `web|mobile|mail|batch|phone|branch`',
    `payment_date` TIMESTAMP COMMENT 'Timestamp of the actual financial transaction (when funds were transferred).',
    `payment_direction` STRING COMMENT 'Indicates whether the payment is inbound (received from tenant) or outbound (paid to landlord).. Valid values are `inbound|outbound`',
    `payment_method` STRING COMMENT 'Instrument used to settle the payment.. Valid values are `credit_card|ach|check|cash|wire|online_portal`',
    `payment_number` STRING COMMENT 'External business identifier or reference number assigned to the payment.',
    `payment_period_end` DATE COMMENT 'Last day of the lease period that this payment covers.',
    `payment_period_start` DATE COMMENT 'First day of the lease period that this payment covers.',
    `payment_source_system` STRING COMMENT 'Name of the source system that originated the payment record (e.g., SAP ERP, Oracle CC&B).',
    `payment_status` STRING COMMENT 'Current lifecycle status of the payment.. Valid values are `scheduled|paid|overdue|disputed|cancelled|pending`',
    `reconciliation_date` DATE COMMENT 'Date on which the payment was reconciled.',
    `remittance_reference` STRING COMMENT 'External reference supplied by the payer (e.g., check number, ACH trace).',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax component of the payment.',
    `tax_code` STRING COMMENT 'Code identifying the tax regime applied to the payment.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the lease payment record.',
    CONSTRAINT pk_lease_payment PRIMARY KEY(`lease_payment_id`)
) COMMENT 'Transactional record for each rent or lease payment made or received under a property lease agreement. Captures payment direction (inbound from tenant, outbound to landlord), payment date, payment amount, payment period covered, payment method, associated property_lease ID, invoice or remittance reference, and payment status (scheduled, paid, overdue, disputed). Supports lease portfolio cash flow tracking and AP/AR reconciliation with the finance domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` (
    `condemnation_proceeding_id` BIGINT COMMENT 'System‑generated unique identifier for each condemnation proceeding.',
    `easement_id` BIGINT COMMENT 'Identifier of the easement impacted by the proceeding, if applicable.',
    `parcel_id` BIGINT COMMENT 'Identifier of the land parcel subject to the proceeding.',
    `business_entity_id` BIGINT COMMENT 'Unique identifier of the property owner (party) involved in the proceeding.',
    `person_id` BIGINT COMMENT 'Unique identifier of the property owner (party) involved in the proceeding.',
    `appealed_condemnation_proceeding_id` BIGINT COMMENT 'Self-referencing FK on condemnation_proceeding (appealed_condemnation_proceeding_id)',
    `appeal_deadline_date` DATE COMMENT 'Last date by which an appeal could be filed.',
    `appeal_filed_flag` BOOLEAN COMMENT 'True if the proceeding was appealed after judgment.',
    `award_currency` STRING COMMENT 'Three‑letter currency code for the final award.. Valid values are `^[A-Z]{3}$`',
    `court_case_number` STRING COMMENT 'Identifier assigned by the court to track the case.',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the condemnation proceeding record was initially loaded.',
    `filing_date` DATE COMMENT 'Calendar date the condemnation proceeding was officially filed.',
    `final_award_amount` DECIMAL(18,2) COMMENT 'Monetary amount awarded to the property owner after adjudication.',
    `hearing_date` DATE COMMENT 'Date of the court‑ordered hearing for the proceeding.',
    `is_confidential` BOOLEAN COMMENT 'True if the proceeding is marked as confidential for regulatory or legal reasons.',
    `judgment_date` DATE COMMENT 'Date the court issued its final judgment.',
    `jurisdiction` STRING COMMENT 'State, province, or regulatory authority under which the proceeding is filed.',
    `just_compensation_offer_amount` DECIMAL(18,2) COMMENT 'Monetary amount offered by the utility as just compensation.',
    `legal_counsel_firm` STRING COMMENT 'Name of the law firm providing counsel for the proceeding.',
    `legal_counsel_name` STRING COMMENT 'Name of the attorney or law firm representing the utility in the proceeding.',
    `notes` STRING COMMENT 'Additional comments, observations, or special instructions related to the proceeding.',
    `offer_currency` STRING COMMENT 'Three‑letter currency code for the compensation offer.. Valid values are `^[A-Z]{3}$`',
    `proceeding_number` STRING COMMENT 'External reference number assigned to the condemnation proceeding.',
    `proceeding_status` STRING COMMENT 'Current state of the condemnation proceeding within its lifecycle.. Valid values are `pre_filing|filed|negotiation|trial|settled|closed`',
    `proceeding_type` STRING COMMENT 'Category of condemnation proceeding: quick‑take, standard, or inverse condemnation defense.. Valid values are `quick_take|standard|inverse_defense`',
    `property_owner_name` STRING COMMENT 'Full legal name of the property owner.',
    `regulatory_filing_number` STRING COMMENT 'Identifier assigned by the public utility commission or other regulator.',
    `resolution_type` STRING COMMENT 'Final resolution category of the proceeding.. Valid values are `settlement|trial|withdrawn|dismissed`',
    `settlement_amount` DECIMAL(18,2) COMMENT 'Total amount paid to the property owner as part of the settlement.',
    `settlement_date` DATE COMMENT 'Calendar date the parties reached a settlement.',
    `source_system` STRING COMMENT 'Name of the operational system of record (e.g., SAP, Oracle CC&B) that supplied the data.',
    `source_system_code` STRING COMMENT 'Unique identifier of the proceeding in the originating source system.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the proceeding record.',
    CONSTRAINT pk_condemnation_proceeding PRIMARY KEY(`condemnation_proceeding_id`)
) COMMENT 'Transactional record for each eminent domain or condemnation proceeding initiated by the utility to acquire property rights for infrastructure projects. Captures proceeding type (quick-take, standard condemnation, inverse condemnation defense), affected parcel or easement, property owner name, filing date, court case number, just compensation offer amount, final award amount, settlement date, legal counsel, and proceeding status (pre-filing, filed, negotiation, trial, settled, closed). Supports legal and regulatory compliance for utility infrastructure expansion.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`gis_boundary` (
    `gis_boundary_id` BIGINT COMMENT 'Unique identifier for the GIS boundary record.',
    `superseded_gis_boundary_id` BIGINT COMMENT 'Self-referencing FK on gis_boundary (superseded_gis_boundary_id)',
    `area_sqft` DECIMAL(18,2) COMMENT 'Surface area of the boundary in square feet (relevant for polygon type).',
    `boundary_code` STRING COMMENT 'Unique business code assigned to the boundary by the utility.. Valid values are `^[A-Z0-9_-]+$`',
    `boundary_name` STRING COMMENT 'Human‑readable name of the property boundary.',
    `boundary_type` STRING COMMENT 'Category of the boundary such as parcel, easement, site, right‑of‑way, facility, or substation.. Valid values are `parcel|easement|site|right_of_way|facility|substation`',
    `centroid_latitude` DOUBLE COMMENT 'Latitude of the geometric centroid of the boundary.',
    `centroid_longitude` DOUBLE COMMENT 'Longitude of the geometric centroid of the boundary.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the boundary.. Valid values are `compliant|non_compliant|pending`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the boundary record was first created in the lakehouse.',
    `crs_epsg` STRING COMMENT 'EPSG code defining the coordinate reference system for the geometry.. Valid values are `^EPSG:d{4,5}$`',
    `effective_from` DATE COMMENT 'Date when the boundary becomes legally effective.',
    `effective_until` DATE COMMENT 'Date when the boundary ceases to be effective (null if open‑ended).',
    `flood_zone` STRING COMMENT 'FEMA flood zone designation for the boundary area.. Valid values are `X|AE|A|B|C|D`',
    `geometry_type` STRING COMMENT 'Spatial geometry type of the boundary.. Valid values are `polygon|polyline|point`',
    `geometry_wkt` STRING COMMENT 'Well‑known text representation of the boundary geometry.',
    `gis_boundary_description` STRING COMMENT 'Free‑form description of the boundary purpose or characteristics.',
    `gis_boundary_status` STRING COMMENT 'Current lifecycle status of the boundary.. Valid values are `current|superseded|under_revision|retired`',
    `historical_boundary_flag` BOOLEAN COMMENT 'True if the record represents a historical (superseded) boundary.',
    `is_critical_infrastructure` BOOLEAN COMMENT 'Indicates whether the boundary contains critical infrastructure assets.',
    `is_protected_area` BOOLEAN COMMENT 'True if the boundary is designated as a protected environmental area.',
    `jurisdiction` STRING COMMENT 'County and state governing the boundary.',
    `land_use_type` STRING COMMENT 'Primary land use classification for the parcel.. Valid values are `residential|commercial|industrial|utility|agricultural|mixed_use`',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection of the boundary.',
    `last_survey_date` DATE COMMENT 'Date of the most recent field survey for the boundary.',
    `layer_name` STRING COMMENT 'Name of the GIS layer where the boundary is stored.',
    `length_ft` DECIMAL(18,2) COMMENT 'Linear length of the boundary in feet (relevant for polyline type).',
    `next_inspection_due` DATE COMMENT 'Scheduled date for the next required inspection.',
    `notes` STRING COMMENT 'Supplemental notes or comments from GIS analysts.',
    `regulatory_filing_number` STRING COMMENT 'Identifier of any regulatory filing associated with the boundary.',
    `source_system` STRING COMMENT 'Originating GIS system for the boundary record.. Valid values are `Esri ArcGIS|Oracle GIS|Custom GIS`',
    `source_system_code` STRING COMMENT 'Identifier of the boundary in the source GIS system.. Valid values are `^[A-Za-z0-9_-]+$`',
    `survey_accuracy_class` STRING COMMENT 'Class of survey accuracy (high, medium, low).. Valid values are `high|medium|low`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the boundary record.',
    `version_number` STRING COMMENT 'Revision number of the boundary record.',
    `zoning_classification` STRING COMMENT 'Zoning code or classification applicable to the boundary.',
    CONSTRAINT pk_gis_boundary PRIMARY KEY(`gis_boundary_id`)
) COMMENT 'Master record for the GIS spatial boundary definitions associated with utility property assets including parcel polygons, easement corridors, site boundaries, and ROW centerlines. Captures geometry type (polygon, polyline, point), coordinate reference system (CRS/EPSG code), GIS layer name, source system (Esri ArcGIS, GIS platform), last survey date, survey accuracy class, associated property entity type and ID, and boundary status (current, superseded, under revision). Serves as the spatial geometry SSOT for the property domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`survey` (
    `survey_id` BIGINT COMMENT 'Unique system-generated identifier for each land survey transaction.',
    `easement_id` BIGINT COMMENT 'Identifier of the easement corridor covered by the survey.',
    `parcel_id` BIGINT COMMENT 'Identifier of the land parcel associated with the survey.',
    `resurvey_of_survey_id` BIGINT COMMENT 'Self-referencing FK on survey (resurvey_of_survey_id)',
    `approval_status` STRING COMMENT 'Result of the surveys approval workflow.. Valid values are `approved|rejected|pending`',
    `approval_timestamp` TIMESTAMP COMMENT 'Date‑time the approval status was set.',
    `compliance_regulation` STRING COMMENT 'Regulatory framework or internal policy governing the survey.',
    `compliance_status` STRING COMMENT 'Result of compliance review for the survey.. Valid values are `compliant|non_compliant|pending_review`',
    `cost_amount` DECIMAL(18,2) COMMENT 'Monetary amount billed for the survey services before taxes.',
    `cost_currency` STRING COMMENT 'Currency in which the survey cost is expressed (e.g., USD).',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time the survey record was initially loaded.',
    `data_source_system` STRING COMMENT 'Name of the operational system that supplied the survey record.',
    `drawing_reference` STRING COMMENT 'File name or URI of the survey drawing produced.',
    `firm` STRING COMMENT 'Name of the surveying firm contracted for the work.',
    `is_confidential_flag` BOOLEAN COMMENT 'True if the survey contains sensitive information requiring restricted handling.',
    `legal_description` STRING COMMENT 'Narrative legal description of the surveyed parcel or easement.',
    `location_latitude` DOUBLE COMMENT 'Geographic latitude (decimal degrees) of the survey location.',
    `location_longitude` DOUBLE COMMENT 'Geographic longitude (decimal degrees) of the survey location.',
    `notes` STRING COMMENT 'Additional comments or observations captured by the surveyor.',
    `survey_date` DATE COMMENT 'Calendar date on which the survey was conducted.',
    `survey_method` STRING COMMENT 'Data‑capture method employed for the survey.. Valid values are `gps|total_station|drone|lidar`',
    `survey_number` STRING COMMENT 'External reference number assigned by the surveying firm or utility for tracking.',
    `survey_status` STRING COMMENT 'Lifecycle status indicating where the survey is in the workflow.. Valid values are `pending|in_progress|completed|rejected|cancelled`',
    `survey_type` STRING COMMENT 'Category of the survey (e.g., boundary, ALTA/NSPS, topographic, as‑built, route).. Valid values are `boundary|alta_nsps|topographic|as_built|route`',
    `surveyor_license_number` STRING COMMENT 'Professional license identifier for the surveyor.',
    `surveyor_name` STRING COMMENT 'Full legal name of the licensed surveyor.',
    `tax_amount` DECIMAL(18,2) COMMENT 'Tax amount levied on the survey cost.',
    `total_amount` DECIMAL(18,2) COMMENT 'Aggregate monetary amount due for the survey.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the survey record.',
    CONSTRAINT pk_survey PRIMARY KEY(`survey_id`)
) COMMENT 'Transactional record for each land survey conducted on utility-owned or target parcels and easement corridors. Captures survey type (boundary survey, ALTA/NSPS survey, topographic survey, as-built survey, route survey), licensed surveyor name and license number, survey date, survey firm, associated parcel or easement ID, survey drawing reference, legal description produced, and survey status. Supports title insurance, condemnation, and infrastructure siting workflows.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`tax_record` (
    `tax_record_id` BIGINT COMMENT 'Unique surrogate key for each property tax record.',
    `parcel_id` BIGINT COMMENT 'Surrogate key linking to the parcel master record.',
    `amended_tax_record_id` BIGINT COMMENT 'Self-referencing FK on tax_record (amended_tax_record_id)',
    `assessed_improvement_value` DECIMAL(18,2) COMMENT 'Assessed monetary value of improvements (buildings, structures) on the parcel.',
    `assessed_land_value` DECIMAL(18,2) COMMENT 'Assessed monetary value of the land component of the parcel.',
    `assessment_date` DATE COMMENT 'Date the tax authority performed the property assessment.',
    `county` STRING COMMENT 'County in which the parcel is located and the tax authority resides.',
    `exemption_amount` DECIMAL(18,2) COMMENT 'Monetary value of the exemption applied to the tax amount.',
    `exemption_flag` BOOLEAN COMMENT 'Indicates whether any exemption applies to this tax record.',
    `exemption_type` STRING COMMENT 'Category of exemption granted, if any.. Valid values are `none|state|federal|municipal|other`',
    `interest_amount` DECIMAL(18,2) COMMENT 'Interest accrued on overdue tax balances.',
    `late_fee_amount` DECIMAL(18,2) COMMENT 'Penalty charged for late payment, if applicable.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the tax record.',
    `parcel_apn` STRING COMMENT 'County assessors parcel identifier linking the tax record to the land parcel.',
    `payment_date` DATE COMMENT 'Date the tax payment was actually received.',
    `payment_due_date` DATE COMMENT 'Date by which the tax payment must be received to avoid penalties.',
    `payment_method` STRING COMMENT 'Means by which the tax payment was made.. Valid values are `check|electronic|cash|credit|debit`',
    `payment_reference_number` STRING COMMENT 'Reference number provided by the payer for reconciliation.',
    `payment_status` STRING COMMENT 'Current payment lifecycle status of the tax bill.. Valid values are `paid|pending|overdue|waived|partial`',
    `payment_status_date` DATE COMMENT 'Date when the payment status last changed.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the tax record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the tax record.',
    `source_system` STRING COMMENT 'Originating system of record (e.g., SAP FI, Oracle CC&B).',
    `tax_abatement_amount` DECIMAL(18,2) COMMENT 'Monetary value of the abatement applied.',
    `tax_abatement_flag` BOOLEAN COMMENT 'Indicates whether an abatement (reduction) applies to the tax.',
    `tax_abatement_type` STRING COMMENT 'Category of abatement (e.g., state incentive).. Valid values are `state|federal|local|other`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Base tax amount before exemptions, abatements, or penalties.',
    `tax_appeal_filed_date` DATE COMMENT 'Date the appeal was formally filed.',
    `tax_appeal_notes` STRING COMMENT 'Comments or details regarding the appeal process.',
    `tax_appeal_outcome` STRING COMMENT 'Result of the tax appeal.. Valid values are `approved|denied|settled|withdrawn`',
    `tax_appeal_resolution_date` DATE COMMENT 'Date the appeal was resolved.',
    `tax_appeal_status` STRING COMMENT 'Current status of any tax appeal process.. Valid values are `none|filed|under_review|resolved|rejected`',
    `tax_assessment_notes` STRING COMMENT 'Additional remarks from the assessor or internal team.',
    `tax_assessment_source` STRING COMMENT 'Origin of the assessment data (e.g., county assessor, internal valuation).. Valid values are `assessor|internal|third_party`',
    `tax_bill_number` STRING COMMENT 'Official identifier assigned by the tax authority for the tax bill.',
    `tax_bill_url` STRING COMMENT 'Link to the electronic tax bill document.',
    `tax_currency` STRING COMMENT 'Three‑letter ISO currency code for the tax amount.. Valid values are `USD|CAD|EUR|GBP|JPY|CHF`',
    `tax_exemption_approval_date` DATE COMMENT 'Date the exemption was approved by the authority.',
    `tax_exemption_expiration_date` DATE COMMENT 'Date the granted exemption expires, if applicable.',
    `tax_rate_area` STRING COMMENT 'Geographic rate area that determines the applicable tax rate.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable tax rate expressed as a percentage.',
    `tax_type` STRING COMMENT 'Classification of the tax (e.g., regular property tax, special assessment).. Valid values are `property|special_assessment|other`',
    `tax_year` STRING COMMENT 'Fiscal year for which the property tax is assessed.',
    `total_assessed_value` DECIMAL(18,2) COMMENT 'Sum of land and improvement assessed values.',
    `total_due_amount` DECIMAL(18,2) COMMENT 'Sum of tax amount, late fees, and interest after exemptions.',
    CONSTRAINT pk_tax_record PRIMARY KEY(`tax_record_id`)
) COMMENT 'Master record for annual property tax assessments and payments for each utility-owned parcel. Captures tax year, county assessor parcel number (APN), assessed land value, assessed improvement value, total assessed value, tax rate area, annual tax amount, tax bill number, payment due dates, payment status, and any exemption or abatement applied (utility property tax exemptions vary by state). Supports property tax expense tracking, rate base filings, and tax appeal management.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`license_agreement` (
    `license_agreement_id` BIGINT COMMENT 'System-generated unique identifier for the license agreement record.',
    `easement_id` BIGINT COMMENT 'Identifier of the easement record linked to the license, if applicable.',
    `parcel_id` BIGINT COMMENT 'Identifier of the land parcel associated with the license.',
    `renewed_license_agreement_id` BIGINT COMMENT 'Self-referencing FK on license_agreement (renewed_license_agreement_id)',
    `agreement_number` STRING COMMENT 'External reference number or code assigned to the license agreement by the utility.',
    `annual_license_fee` DECIMAL(18,2) COMMENT 'Base amount payable by the licensee each year for the license.',
    `compliance_requirements` STRING COMMENT 'Regulatory or internal compliance conditions attached to the license.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the license agreement record was first created in the system.',
    `effective_end_date` DATE COMMENT 'Date on which the license agreement terminates or expires (null for open‑ended).',
    `effective_start_date` DATE COMMENT 'Date on which the license agreement becomes binding.',
    `fee_currency` STRING COMMENT 'Three‑letter ISO currency code for the license fee (e.g., USD).',
    `gis_feature_reference` STRING COMMENT 'Identifier of the GIS feature representing the licensed area.',
    `insurance_expiration_date` DATE COMMENT 'Date on which the required insurance coverage expires.',
    `insurance_policy_number` STRING COMMENT 'Policy number of the required insurance.',
    `insurance_provider` STRING COMMENT 'Name of the insurance company providing coverage for the license.',
    `insurance_required_flag` BOOLEAN COMMENT 'Indicates whether the licensee must maintain insurance coverage.',
    `is_exclusive_flag` BOOLEAN COMMENT 'Indicates whether the license grants exclusive rights to the licensee.',
    `is_transferable_flag` BOOLEAN COMMENT 'Indicates whether the licensee may assign or transfer the license to another party.',
    `jurisdiction_state` STRING COMMENT 'State or jurisdiction governing the license agreement.',
    `license_agreement_status` STRING COMMENT 'Current lifecycle status of the license agreement.. Valid values are `active|pending|draft|terminated|expired`',
    `license_area_sqft` DECIMAL(18,2) COMMENT 'Size of the licensed area expressed in square feet.',
    `license_type` STRING COMMENT 'Category of the license indicating the permitted use of the utility-owned property.. Valid values are `cell_tower|fiber|billboard|agricultural|pipeline_crossing|other`',
    `licensed_area_acres` DECIMAL(18,2) COMMENT 'Size of the licensed area expressed in acres.',
    `licensed_area_description` STRING COMMENT 'Narrative description of the portion of property covered by the license.',
    `licensee_address` STRING COMMENT 'Mailing address of the licensee organization.',
    `licensee_contact_email` STRING COMMENT 'Email address for the licensees primary contact.. Valid values are `^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$`',
    `licensee_contact_name` STRING COMMENT 'Name of the primary contact person for the licensee.',
    `licensee_contact_phone` STRING COMMENT 'Phone number for the licensees primary contact.',
    `licensee_name` STRING COMMENT 'Legal name of the third‑party entity receiving the license.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the license agreement.',
    `payment_due_day_of_month` STRING COMMENT 'Day of the month when payment is due.',
    `payment_frequency` STRING COMMENT 'How often the license fee is invoiced.. Valid values are `annual|quarterly|monthly`',
    `regulatory_filing_number` STRING COMMENT 'Identifier of the filing submitted to the regulator for this license.',
    `renewal_notice_period_days` STRING COMMENT 'Number of days prior to expiration that a renewal notice must be provided.',
    `renewal_option_flag` BOOLEAN COMMENT 'Indicates whether the license includes an automatic renewal option.',
    `revenue_share_amount` DECIMAL(18,2) COMMENT 'Monetary amount derived from the revenue share percentage.',
    `revenue_share_currency` STRING COMMENT 'Currency of the revenue share amount.',
    `revenue_share_percentage` DECIMAL(18,2) COMMENT 'Percentage of the license fee that is shared with the utility as revenue.',
    `tax_exempt_flag` BOOLEAN COMMENT 'Indicates whether the license fee is exempt from tax.',
    `tax_exempt_reason` STRING COMMENT 'Reason or regulatory basis for tax exemption, if applicable.',
    `termination_date` DATE COMMENT 'Date on which the license was formally terminated, if earlier than the effective end date.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the license agreement record.',
    CONSTRAINT pk_license_agreement PRIMARY KEY(`license_agreement_id`)
) COMMENT 'Master record for license agreements where the utility grants third parties the right to use utility-owned property for compatible uses such as cell tower colocation, fiber optic attachments, billboard placements, agricultural licenses, and pipeline crossings. Captures licensee name, license type, licensed area description, associated parcel or easement ID, license term, annual license fee, revenue share terms, insurance requirements, and license status. Supports utility property revenue generation and ROW compatibility management.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`zoning_classification` (
    `zoning_classification_id` BIGINT COMMENT 'Unique surrogate key for each zoning classification record.',
    `superseded_zoning_classification_id` BIGINT COMMENT 'Self-referencing FK on zoning_classification (superseded_zoning_classification_id)',
    `air_quality_impact_flag` BOOLEAN COMMENT 'True if the zone has air quality impact constraints for new projects.',
    `compliance_notes` STRING COMMENT 'Free‑text notes on regulatory considerations or exemptions for the zone.',
    `conditional_uses` STRING COMMENT 'Uses that may be allowed subject to special approvals or conditions.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the zoning record was first loaded into the lakehouse.',
    `easement_impact_flag` BOOLEAN COMMENT 'True if existing easements affect development potential in the zone.',
    `effective_date` DATE COMMENT 'Date on which the zoning classification became effective.',
    `environmental_restrictions` STRING COMMENT 'Specific environmental constraints (e.g., wetlands, protected habitats) applicable to the zone.',
    `expiration_date` DATE COMMENT 'Date on which the zoning classification expires or is superseded; null if indefinite.',
    `fire_safety_requirements` STRING COMMENT 'Specific fire protection standards applicable to the zone.',
    `flood_zone_designation` STRING COMMENT 'FEMA flood zone classification for the zoning area.. Valid values are `X|AE|A|B|C|D`',
    `height_limit_ft` DECIMAL(18,2) COMMENT 'Maximum allowable building height in feet for the zone.',
    `historic_preservation_flag` BOOLEAN COMMENT 'Indicates whether the zone contains historic resources requiring preservation.',
    `jurisdiction_name` STRING COMMENT 'Name of the city, county, or municipality that defines the zoning rules.',
    `land_use_type` STRING COMMENT 'Primary land‑use classification associated with the zone.. Valid values are `single_family|multi_family|mixed_use|industrial|agricultural|public`',
    `last_review_date` DATE COMMENT 'Date when the zoning classification was last reviewed for accuracy.',
    `map_layer_reference` STRING COMMENT 'Identifier of the GIS layer where the zoning polygon is stored.',
    `maximum_building_coverage_pct` DECIMAL(18,2) COMMENT 'Maximum percentage of the parcel that may be covered by building footprints.',
    `minimum_parcel_size_acres` DECIMAL(18,2) COMMENT 'Smallest parcel area in acres that may be developed under this zoning.',
    `noise_abatement_requirements` STRING COMMENT 'Noise mitigation measures required for developments in the zone.',
    `parking_requirements_spaces_per_acre` STRING COMMENT 'Required number of parking spaces per acre of developable land.',
    `permitted_uses` STRING COMMENT 'Comma‑separated list of land uses explicitly allowed in this zoning classification.',
    `renewable_energy_compatibility_flag` BOOLEAN COMMENT 'Indicates whether renewable energy projects (e.g., solar, wind) are permissible.',
    `review_frequency_months` STRING COMMENT 'Number of months between mandatory reviews of the zoning classification.',
    `setback_requirements_ft` DECIMAL(18,2) COMMENT 'Minimum required distance in feet between structures and property lines as mandated by the zone.',
    `source_system` STRING COMMENT 'System of record that supplied the zoning data.. Valid values are `ArcGIS|LocalGov|Custom`',
    `source_system_code` STRING COMMENT 'Unique identifier for the zoning record in the source system.',
    `tax_rate_percent` DECIMAL(18,2) COMMENT 'Applicable property tax rate for parcels in this zoning classification.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the zoning record.',
    `utility_infrastructure_compatible_flag` BOOLEAN COMMENT 'Indicates whether standard utility infrastructure (e.g., transmission lines, pipelines) can be sited within this zone.',
    `water_resource_protection_flag` BOOLEAN COMMENT 'Indicates whether the zone is subject to water resource protection restrictions.',
    `zoning_category` STRING COMMENT 'Broad category describing the primary land use intent of the zone.. Valid values are `residential|commercial|industrial|agricultural|open_space|special_use`',
    `zoning_change_history` STRING COMMENT 'Chronological log of amendments to the zoning classification, stored as JSON text.',
    `zoning_classification_description` STRING COMMENT 'Narrative description of the zoning classification, including intent and typical applications.',
    `zoning_classification_status` STRING COMMENT 'Current lifecycle status of the zoning classification.. Valid values are `active|inactive|retired`',
    `zoning_code` STRING COMMENT 'Official alphanumeric code assigned to the zoning classification by the jurisdiction.',
    CONSTRAINT pk_zoning_classification PRIMARY KEY(`zoning_classification_id`)
) COMMENT 'Reference master for land use zoning classifications and designations applicable to utility-owned parcels and project sites. Captures jurisdiction name, zoning code, zoning category (residential, commercial, industrial, agricultural, open space, special use), permitted uses, conditional uses, utility infrastructure compatibility flag, setback requirements, height limits, and effective date. Supports siting studies, permitting workflows, and land use planning for utility infrastructure projects.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`property`.`document` (
    `document_id` BIGINT COMMENT 'Unique identifier for the property document record.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Property documents are always associated with a specific land parcel; adding parcel_id FK eliminates the silo and enables joins to parcel for location, ownership, and tax data.',
    `superseded_document_id` BIGINT COMMENT 'Self-referencing FK on document (superseded_document_id)',
    `archival_date` DATE COMMENT 'Date the document was moved to archival storage.',
    `archival_location` STRING COMMENT 'Location where the document is archived after its active lifecycle.',
    `checksum` STRING COMMENT 'Cryptographic hash used to verify file integrity.',
    `compliance_review_date` DATE COMMENT 'Date of the most recent compliance review.',
    `compliance_review_user` STRING COMMENT 'Name of the person who performed the compliance review.',
    `compliance_status` STRING COMMENT 'Current compliance assessment of the document.. Valid values are `compliant|non_compliant|pending`',
    `confidentiality_level` STRING COMMENT 'Classification indicating the sensitivity of the document.. Valid values are `public|internal|confidential|restricted`',
    `county_recorder_jurisdiction` STRING COMMENT 'County or jurisdiction that recorded the document.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the document record was first created in the system.',
    `digital_signature_hash` STRING COMMENT 'Cryptographic hash of the digital signature, if applicable.',
    `disposal_date` DATE COMMENT 'Date the document was disposed of according to retention policy.',
    `disposal_method` STRING COMMENT 'Method used to dispose of the document.. Valid values are `recycle|destroy|donate|sell`',
    `document_description` STRING COMMENT 'Free‑form description providing context or summary of the document.',
    `document_status` STRING COMMENT 'Current lifecycle status of the document.. Valid values are `current|superseded|archived|pending_review`',
    `document_type` STRING COMMENT 'Category of the document indicating its legal purpose. [ENUM-REF-CANDIDATE: deed|easement|title_policy|survey|environmental_report|lease|permit — 7 candidates stripped; promote to reference product]',
    `effective_date` DATE COMMENT 'Date the document becomes legally effective.',
    `expiration_date` DATE COMMENT 'Date the document expires or is no longer in force, if applicable.',
    `file_format` STRING COMMENT 'File format of the stored document.. Valid values are `pdf|docx|tiff|jpg`',
    `file_path` STRING COMMENT 'Logical path to the document file in the document management system.',
    `file_size_bytes` BIGINT COMMENT 'Size of the document file in bytes.',
    `legal_hold_flag` BOOLEAN COMMENT 'Indicates whether a legal hold prevents disposal of the document.',
    `notes` STRING COMMENT 'Additional free‑form notes or comments about the document.',
    `owner_department` STRING COMMENT 'Organizational department responsible for the document.',
    `page_count` STRING COMMENT 'Number of pages in the document.',
    `recorder_book_page` STRING COMMENT 'Book and page reference in the recorders ledger.',
    `recording_date` DATE COMMENT 'Date the document was officially recorded with the county recorder.',
    `recording_number` STRING COMMENT 'Official recording number assigned by the county recorder.',
    `regulatory_filing_number` STRING COMMENT 'Identifier for any regulatory filing associated with the document.',
    `retention_expiration_date` DATE COMMENT 'Date when the document may be disposed of per retention policy.',
    `retention_policy` STRING COMMENT 'Policy governing how long the document must be retained.',
    `signed_by` STRING COMMENT 'Name of the individual or entity that signed the document.',
    `signed_date` DATE COMMENT 'Date the document was signed.',
    `signed_flag` BOOLEAN COMMENT 'Indicates whether the document has been signed.',
    `source_system` STRING COMMENT 'Source system that originally created or supplied the document.',
    `source_system_code` STRING COMMENT 'Identifier of the document in the source system.',
    `storage_location` STRING COMMENT 'Physical or cloud storage location identifier (e.g., S3 bucket, on‑prem archive).',
    `subtype` STRING COMMENT 'More specific classification within the document type, if applicable.',
    `title` STRING COMMENT 'Descriptive title of the legal or administrative document.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the document record.',
    `version_number` STRING COMMENT 'Sequential version identifier for revisions of the document.',
    CONSTRAINT pk_document PRIMARY KEY(`document_id`)
) COMMENT 'Master record for all legal and administrative documents associated with utility property assets including deeds, recorded easements, title policies, survey plats, environmental reports, lease agreements, and permit documents. Captures document type, document title, recording date, recording number, county recorder jurisdiction, associated property entity type and ID, document storage reference (document management system path), and document status (current, superseded, archived). Serves as the document registry for the property domain.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ADD CONSTRAINT `fk_property_parcel_gis_boundary_id` FOREIGN KEY (`gis_boundary_id`) REFERENCES `power_and_utilities_v2`.`property`.`gis_boundary`(`gis_boundary_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ADD CONSTRAINT `fk_property_parcel_zoning_classification_id` FOREIGN KEY (`zoning_classification_id`) REFERENCES `power_and_utilities_v2`.`property`.`zoning_classification`(`zoning_classification_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ADD CONSTRAINT `fk_property_parcel_subdivided_from_parcel_id` FOREIGN KEY (`subdivided_from_parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ADD CONSTRAINT `fk_property_facility_parent_facility_id` FOREIGN KEY (`parent_facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ADD CONSTRAINT `fk_property_easement_parent_easement_id` FOREIGN KEY (`parent_easement_id`) REFERENCES `power_and_utilities_v2`.`property`.`easement`(`easement_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ADD CONSTRAINT `fk_property_land_right_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ADD CONSTRAINT `fk_property_land_right_parent_land_right_id` FOREIGN KEY (`parent_land_right_id`) REFERENCES `power_and_utilities_v2`.`property`.`land_right`(`land_right_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ADD CONSTRAINT `fk_property_site_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ADD CONSTRAINT `fk_property_site_parent_site_id` FOREIGN KEY (`parent_site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ADD CONSTRAINT `fk_property_property_lease_renewed_property_lease_id` FOREIGN KEY (`renewed_property_lease_id`) REFERENCES `power_and_utilities_v2`.`property`.`property_lease`(`property_lease_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ADD CONSTRAINT `fk_property_acquisition_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ADD CONSTRAINT `fk_property_acquisition_related_acquisition_id` FOREIGN KEY (`related_acquisition_id`) REFERENCES `power_and_utilities_v2`.`property`.`acquisition`(`acquisition_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ADD CONSTRAINT `fk_property_disposition_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ADD CONSTRAINT `fk_property_disposition_related_disposition_id` FOREIGN KEY (`related_disposition_id`) REFERENCES `power_and_utilities_v2`.`property`.`disposition`(`disposition_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ADD CONSTRAINT `fk_property_encroachment_easement_id` FOREIGN KEY (`easement_id`) REFERENCES `power_and_utilities_v2`.`property`.`easement`(`easement_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ADD CONSTRAINT `fk_property_encroachment_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ADD CONSTRAINT `fk_property_encroachment_recurring_encroachment_id` FOREIGN KEY (`recurring_encroachment_id`) REFERENCES `power_and_utilities_v2`.`property`.`encroachment`(`encroachment_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ADD CONSTRAINT `fk_property_permit_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ADD CONSTRAINT `fk_property_permit_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ADD CONSTRAINT `fk_property_permit_renewed_permit_id` FOREIGN KEY (`renewed_permit_id`) REFERENCES `power_and_utilities_v2`.`property`.`permit`(`permit_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ADD CONSTRAINT `fk_property_title_record_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ADD CONSTRAINT `fk_property_title_record_prior_title_record_id` FOREIGN KEY (`prior_title_record_id`) REFERENCES `power_and_utilities_v2`.`property`.`title_record`(`title_record_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ADD CONSTRAINT `fk_property_appraisal_easement_id` FOREIGN KEY (`easement_id`) REFERENCES `power_and_utilities_v2`.`property`.`easement`(`easement_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ADD CONSTRAINT `fk_property_appraisal_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ADD CONSTRAINT `fk_property_appraisal_prior_appraisal_id` FOREIGN KEY (`prior_appraisal_id`) REFERENCES `power_and_utilities_v2`.`property`.`appraisal`(`appraisal_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ADD CONSTRAINT `fk_property_environmental_condition_originating_environmental_condition_id` FOREIGN KEY (`originating_environmental_condition_id`) REFERENCES `power_and_utilities_v2`.`property`.`environmental_condition`(`environmental_condition_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ADD CONSTRAINT `fk_property_remediation_activity_environmental_condition_id` FOREIGN KEY (`environmental_condition_id`) REFERENCES `power_and_utilities_v2`.`property`.`environmental_condition`(`environmental_condition_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ADD CONSTRAINT `fk_property_remediation_activity_site_id` FOREIGN KEY (`site_id`) REFERENCES `power_and_utilities_v2`.`property`.`site`(`site_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ADD CONSTRAINT `fk_property_remediation_activity_followup_remediation_activity_id` FOREIGN KEY (`followup_remediation_activity_id`) REFERENCES `power_and_utilities_v2`.`property`.`remediation_activity`(`remediation_activity_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ADD CONSTRAINT `fk_property_space_allocation_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ADD CONSTRAINT `fk_property_space_allocation_superseded_space_allocation_id` FOREIGN KEY (`superseded_space_allocation_id`) REFERENCES `power_and_utilities_v2`.`property`.`space_allocation`(`space_allocation_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ADD CONSTRAINT `fk_property_facility_inspection_facility_id` FOREIGN KEY (`facility_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility`(`facility_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ADD CONSTRAINT `fk_property_facility_inspection_reinspection_of_facility_inspection_id` FOREIGN KEY (`reinspection_of_facility_inspection_id`) REFERENCES `power_and_utilities_v2`.`property`.`facility_inspection`(`facility_inspection_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ADD CONSTRAINT `fk_property_lease_payment_property_lease_id` FOREIGN KEY (`property_lease_id`) REFERENCES `power_and_utilities_v2`.`property`.`property_lease`(`property_lease_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ADD CONSTRAINT `fk_property_lease_payment_adjusted_lease_payment_id` FOREIGN KEY (`adjusted_lease_payment_id`) REFERENCES `power_and_utilities_v2`.`property`.`lease_payment`(`lease_payment_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ADD CONSTRAINT `fk_property_condemnation_proceeding_easement_id` FOREIGN KEY (`easement_id`) REFERENCES `power_and_utilities_v2`.`property`.`easement`(`easement_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ADD CONSTRAINT `fk_property_condemnation_proceeding_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ADD CONSTRAINT `fk_property_condemnation_proceeding_appealed_condemnation_proceeding_id` FOREIGN KEY (`appealed_condemnation_proceeding_id`) REFERENCES `power_and_utilities_v2`.`property`.`condemnation_proceeding`(`condemnation_proceeding_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ADD CONSTRAINT `fk_property_gis_boundary_superseded_gis_boundary_id` FOREIGN KEY (`superseded_gis_boundary_id`) REFERENCES `power_and_utilities_v2`.`property`.`gis_boundary`(`gis_boundary_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ADD CONSTRAINT `fk_property_survey_easement_id` FOREIGN KEY (`easement_id`) REFERENCES `power_and_utilities_v2`.`property`.`easement`(`easement_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ADD CONSTRAINT `fk_property_survey_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ADD CONSTRAINT `fk_property_survey_resurvey_of_survey_id` FOREIGN KEY (`resurvey_of_survey_id`) REFERENCES `power_and_utilities_v2`.`property`.`survey`(`survey_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ADD CONSTRAINT `fk_property_tax_record_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ADD CONSTRAINT `fk_property_tax_record_amended_tax_record_id` FOREIGN KEY (`amended_tax_record_id`) REFERENCES `power_and_utilities_v2`.`property`.`tax_record`(`tax_record_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ADD CONSTRAINT `fk_property_license_agreement_easement_id` FOREIGN KEY (`easement_id`) REFERENCES `power_and_utilities_v2`.`property`.`easement`(`easement_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ADD CONSTRAINT `fk_property_license_agreement_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ADD CONSTRAINT `fk_property_license_agreement_renewed_license_agreement_id` FOREIGN KEY (`renewed_license_agreement_id`) REFERENCES `power_and_utilities_v2`.`property`.`license_agreement`(`license_agreement_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ADD CONSTRAINT `fk_property_zoning_classification_superseded_zoning_classification_id` FOREIGN KEY (`superseded_zoning_classification_id`) REFERENCES `power_and_utilities_v2`.`property`.`zoning_classification`(`zoning_classification_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ADD CONSTRAINT `fk_property_document_parcel_id` FOREIGN KEY (`parcel_id`) REFERENCES `power_and_utilities_v2`.`property`.`parcel`(`parcel_id`);
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ADD CONSTRAINT `fk_property_document_superseded_document_id` FOREIGN KEY (`superseded_document_id`) REFERENCES `power_and_utilities_v2`.`property`.`document`(`document_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`property` SET TAGS ('dbx_division' = 'corporate');
ALTER SCHEMA `power_and_utilities_v2`.`property` SET TAGS ('dbx_domain' = 'property');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `gis_boundary_id` SET TAGS ('dbx_business_glossary_term' = 'GIS Polygon Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `zoning_classification_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `subdivided_from_parcel_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `acquisition_cost` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `acquisition_date` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `acreage` SET TAGS ('dbx_business_glossary_term' = 'Parcel Acreage (AC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `apn` SET TAGS ('dbx_business_glossary_term' = 'Assessor Parcel Number (APN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `building_count` SET TAGS ('dbx_business_glossary_term' = 'Building Count');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `building_sqft` SET TAGS ('dbx_business_glossary_term' = 'Building Square Footage');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `current_market_value` SET TAGS ('dbx_business_glossary_term' = 'Current Market Value (USD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `easement_flag` SET TAGS ('dbx_business_glossary_term' = 'Easement Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `easement_type` SET TAGS ('dbx_business_glossary_term' = 'Easement Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `easement_type` SET TAGS ('dbx_value_regex' = 'right_of_way|utility|access|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `encumbrance_flag` SET TAGS ('dbx_business_glossary_term' = 'Encumbrance Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `environmental_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `environmental_status` SET TAGS ('dbx_value_regex' = 'clean|contaminated|investigation|remediated');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `flood_zone` SET TAGS ('dbx_business_glossary_term' = 'Flood Zone');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `flood_zone` SET TAGS ('dbx_value_regex' = 'X|AE|A|VE|V|D');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `gis_polygon_reference` SET TAGS ('dbx_business_glossary_term' = 'GIS Polygon Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `historic_status` SET TAGS ('dbx_business_glossary_term' = 'Historic Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `historic_status` SET TAGS ('dbx_value_regex' = 'none|registered|protected');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `land_use_type` SET TAGS ('dbx_business_glossary_term' = 'Land Use Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `land_use_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|utility|mixed');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (°)');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `lease_cost` SET TAGS ('dbx_business_glossary_term' = 'Lease Cost (USD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|retired|sold');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (°)');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `market_value_date` SET TAGS ('dbx_business_glossary_term' = 'Market Value Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `parcel_name` SET TAGS ('dbx_business_glossary_term' = 'Parcel Name');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `property_tax_status` SET TAGS ('dbx_business_glossary_term' = 'Property Tax Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `property_tax_status` SET TAGS ('dbx_value_regex' = 'paid|delinquent|exempt');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'SAP|ArcGIS|MDM');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `tax_assessed_value` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessed Value (USD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `tax_assessed_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessed Year');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `title_status` SET TAGS ('dbx_business_glossary_term' = 'Title Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `title_status` SET TAGS ('dbx_value_regex' = 'clear|lien|encumbered|pending');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `utility_service_flag` SET TAGS ('dbx_business_glossary_term' = 'Utility Service Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `zoning_classification` SET TAGS ('dbx_business_glossary_term' = 'Zoning Classification');
ALTER TABLE `power_and_utilities_v2`.`property`.`parcel` ALTER COLUMN `zoning_classification` SET TAGS ('dbx_value_regex' = 'R-1|R-2|C-1|C-2|I-1|M-1');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `control_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Control Zone Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `parent_facility_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `access_control_system` SET TAGS ('dbx_business_glossary_term' = 'Access Control System');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `access_control_system` SET TAGS ('dbx_value_regex' = 'card|biometric|keypad|none');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `annual_energy_consumption_mwh` SET TAGS ('dbx_business_glossary_term' = 'Annual Energy Consumption (MWh)');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `annual_water_consumption_gallons` SET TAGS ('dbx_business_glossary_term' = 'Annual Water Consumption (Gallons)');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `building_condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Building Condition Rating');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `building_condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `construction_year` SET TAGS ('dbx_business_glossary_term' = 'Construction Year');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `country` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `critical_infrastructure_flag` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Certification');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `environmental_certification` SET TAGS ('dbx_value_regex' = 'LEED|BREEAM|ENERGY_STAR|NONE');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `facility_code` SET TAGS ('dbx_business_glossary_term' = 'Facility Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `facility_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Name');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_business_glossary_term' = 'Facility Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `facility_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|under_construction');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_business_glossary_term' = 'Facility Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `facility_type` SET TAGS ('dbx_value_regex' = 'office|operations|warehouse|control_room|substation|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `fire_suppression_type` SET TAGS ('dbx_business_glossary_term' = 'Fire Suppression Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `geolocation_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `geolocation_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `gross_square_feet` SET TAGS ('dbx_business_glossary_term' = 'Gross Square Feet');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `hvac_system_type` SET TAGS ('dbx_business_glossary_term' = 'HVAC System Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `lease_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `lease_owned_flag` SET TAGS ('dbx_business_glossary_term' = 'Owned or Leased Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `manager_name` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Name');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `manager_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `manager_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `manager_phone` SET TAGS ('dbx_business_glossary_term' = 'Facility Manager Phone');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `manager_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `manager_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `occupancy_capacity` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Capacity');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `parking_spaces` SET TAGS ('dbx_business_glossary_term' = 'Parking Spaces');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `regional_area_code` SET TAGS ('dbx_business_glossary_term' = 'Regional Area Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `state` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `street_address` SET TAGS ('dbx_business_glossary_term' = 'Street Address');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `street_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `street_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `easement_id` SET TAGS ('dbx_business_glossary_term' = 'Easement Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `parent_easement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `area_acres` SET TAGS ('dbx_business_glossary_term' = 'Easement Area (Acres)');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `centerline_length_ft` SET TAGS ('dbx_business_glossary_term' = 'Centerline Length (Feet)');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_business_glossary_term' = 'Compensation Amount');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `compensation_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_business_glossary_term' = 'Compensation Currency');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_value_regex' = 'USD');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `compensation_currency` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Easement Document URL');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `easement_description` SET TAGS ('dbx_business_glossary_term' = 'Easement Description');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `easement_number` SET TAGS ('dbx_business_glossary_term' = 'Easement Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `easement_status` SET TAGS ('dbx_business_glossary_term' = 'Easement Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `easement_status` SET TAGS ('dbx_value_regex' = 'active|expired|disputed|vacated');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `easement_type` SET TAGS ('dbx_business_glossary_term' = 'Easement Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `easement_type` SET TAGS ('dbx_value_regex' = 'transmission_row|distribution_corridor|pipeline_corridor|access_road|drainage');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `expiration_reason` SET TAGS ('dbx_business_glossary_term' = 'Easement Expiration Reason');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `expiration_reason` SET TAGS ('dbx_value_regex' = 'term_end|relinquished|court_action|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `grantor_name` SET TAGS ('dbx_business_glossary_term' = 'Grantor Name');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `grantor_parcel_apn` SET TAGS ('dbx_business_glossary_term' = 'Grantor Parcel APN');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Result');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_value_regex' = 'satisfactory|issues|pending');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `recorded_document_number` SET TAGS ('dbx_business_glossary_term' = 'Recorded Document Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `recorder_book_page` SET TAGS ('dbx_business_glossary_term' = 'Recorder Book/Page');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `regulatory_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Easement Source System');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Easement Source System Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State (Two‑Letter Code)');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `state` SET TAGS ('dbx_value_regex' = '^[A-Z]{2}$');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `status_notes` SET TAGS ('dbx_business_glossary_term' = 'Easement Status Notes');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `term_years` SET TAGS ('dbx_business_glossary_term' = 'Easement Term (Years)');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `width_ft` SET TAGS ('dbx_business_glossary_term' = 'Easement Width (Feet)');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'ZIP Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^d{5}$');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`easement` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `land_right_id` SET TAGS ('dbx_business_glossary_term' = 'Land Right Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `parent_land_right_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `annual_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Annual Fee Amount');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `corridor_reference` SET TAGS ('dbx_business_glossary_term' = 'Corridor Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `expiration_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `fee_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `fee_payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Fee Payment Frequency');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `fee_payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly|one_time');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `governing_body` SET TAGS ('dbx_business_glossary_term' = 'Governing Body');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `governing_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|State|Local');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `governing_document_reference` SET TAGS ('dbx_business_glossary_term' = 'Governing Document Reference');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `grantee_name` SET TAGS ('dbx_business_glossary_term' = 'Grantee Name');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `grantor_name` SET TAGS ('dbx_business_glossary_term' = 'Grantor Name');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `grantor_type` SET TAGS ('dbx_business_glossary_term' = 'Grantor Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `grantor_type` SET TAGS ('dbx_value_regex' = 'municipality|private_owner|state_agency|federal_agency|tribal');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `is_assignable` SET TAGS ('dbx_business_glossary_term' = 'Assignable Right Indicator');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `is_exclusive` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Right Indicator');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `is_transferable` SET TAGS ('dbx_business_glossary_term' = 'Transferable Right Indicator');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `land_right_status` SET TAGS ('dbx_business_glossary_term' = 'Land Right Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `land_right_status` SET TAGS ('dbx_value_regex' = 'active|inactive|pending|terminated|suspended|expired');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|rejected|under_review');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `renewal_option` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `renewal_option` SET TAGS ('dbx_value_regex' = 'automatic|optional|none');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `renewal_term_years` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (Years)');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `right_description` SET TAGS ('dbx_business_glossary_term' = 'Land Right Description');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `right_number` SET TAGS ('dbx_business_glossary_term' = 'Land Right Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `right_type` SET TAGS ('dbx_business_glossary_term' = 'Land Right Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `right_type` SET TAGS ('dbx_value_regex' = 'easement|license|permit|franchise|temporary_construction|surface_use');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`land_right` ALTER COLUMN `termination_reason` SET TAGS ('dbx_business_glossary_term' = 'Termination Reason');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier (PARCEL_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `parent_site_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `access_restriction_flag` SET TAGS ('dbx_business_glossary_term' = 'Site Access Restriction Flag (ACCESS_RESTRICT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `address_line` SET TAGS ('dbx_business_glossary_term' = 'Site Address Line (ADDRESS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `address_line` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `address_line` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `boundary_polygon_ref` SET TAGS ('dbx_business_glossary_term' = 'Boundary Polygon Reference (REF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'Site City (CITY)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `contact_email` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Email (EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `contact_email` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `contact_email` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Site Contact Phone (PHONE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `contact_phone` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Site Country (COUNTRY)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `criticality_rating` SET TAGS ('dbx_business_glossary_term' = 'Site Criticality Rating (CRIT_RATING)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date (DECOM_DATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFF_FROM)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EFF_UNTIL)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `elevation_meters` SET TAGS ('dbx_business_glossary_term' = 'Elevation (M)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_business_glossary_term' = 'Environmental Classification (ENV_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `environmental_classification` SET TAGS ('dbx_value_regex' = 'wetland|habitat|protected|none');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `facility_ids` SET TAGS ('dbx_business_glossary_term' = 'Associated Facility Identifiers (FACILITY_IDS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `fuel_type` SET TAGS ('dbx_business_glossary_term' = 'Fuel Type (FUEL)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `fuel_type` SET TAGS ('dbx_value_regex' = 'renewable|fossil|nuclear|hydro|biomass|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `generation_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Generation Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `grid_connection_point` SET TAGS ('dbx_business_glossary_term' = 'Grid Connection Point (GRID_CONN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `grid_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Grid Voltage (KV)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `land_use_type` SET TAGS ('dbx_business_glossary_term' = 'Land Use Type (LAND_USE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `land_use_type` SET TAGS ('dbx_value_regex' = 'industrial|commercial|residential|agricultural|undeveloped');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (INSP_DATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Result (INSP_RESULT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `last_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule (MAINT_SCH)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `maintenance_schedule` SET TAGS ('dbx_value_regex' = 'annual|semiannual|quarterly');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `manager` SET TAGS ('dbx_business_glossary_term' = 'Site Manager (MANAGER)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `operational_since` SET TAGS ('dbx_business_glossary_term' = 'Operational Since Date (OP_SINCE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Owner Department (DEPT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `region` SET TAGS ('dbx_business_glossary_term' = 'Geographic Region (REGION)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status (REMED_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'not_started|in_progress|completed|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `renewable_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Flag (RENEWABLE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Site Risk Score (RISK_SCORE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Site Security Level (SEC_LEVEL)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'low|medium|high|restricted');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `site_code` SET TAGS ('dbx_business_glossary_term' = 'Site Code (CODE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `site_description` SET TAGS ('dbx_business_glossary_term' = 'Site Description (DESC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `site_name` SET TAGS ('dbx_business_glossary_term' = 'Site Name (NAME)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `site_status` SET TAGS ('dbx_business_glossary_term' = 'Site Lifecycle Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `site_status` SET TAGS ('dbx_value_regex' = 'active|inactive|decommissioned|remediation|planned|closed');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `site_type` SET TAGS ('dbx_business_glossary_term' = 'Site Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `site_type` SET TAGS ('dbx_value_regex' = 'generation|substation|service_center|laydown|remediation|transmission');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'Site State (STATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `timezone` SET TAGS ('dbx_business_glossary_term' = 'Site Time Zone (TZ)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `total_acreage` SET TAGS ('dbx_business_glossary_term' = 'Total Acreage (ACRE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `zip_code` SET TAGS ('dbx_business_glossary_term' = 'Site ZIP Code (ZIP)');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `zip_code` SET TAGS ('dbx_value_regex' = '^d{5}$');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`site` ALTER COLUMN `zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `property_lease_id` SET TAGS ('dbx_business_glossary_term' = 'Property Lease Identifier (LEASE_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Business Entity Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `counterparty_id` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `renewed_property_lease_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `commencement_date` SET TAGS ('dbx_business_glossary_term' = 'Lease Commencement Date (LEASE_COMMENCE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (COMPLIANCE_REQ)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_business_glossary_term' = 'Counterparty Role (COUNTERPARTY_ROLE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `counterparty_type` SET TAGS ('dbx_value_regex' = 'lessor|lessee');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country (COUNTRY)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Lease Document URL (LEASE_DOC_URL)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `early_termination_fee` SET TAGS ('dbx_business_glossary_term' = 'Early Termination Fee (EARLY_TERM_FEE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (LEASE_END)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (LEASE_START)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `is_exclusive_use` SET TAGS ('dbx_business_glossary_term' = 'Exclusive Use Flag (EXCLUSIVE_USE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `is_sublease_allowed` SET TAGS ('dbx_business_glossary_term' = 'Sublease Allowed Flag (SUBLEASE_ALLOWED)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `lease_number` SET TAGS ('dbx_business_glossary_term' = 'Lease Number (LEASE_NO)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `lease_status` SET TAGS ('dbx_business_glossary_term' = 'Lease Status (LEASE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `lease_status` SET TAGS ('dbx_value_regex' = 'active|inactive|terminated|pending|draft');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_business_glossary_term' = 'Lease Type (LEASE_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `lease_type` SET TAGS ('dbx_value_regex' = 'ground|building|tower|cell_antenna|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Lease Notes (LEASE_NOTES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (POSTAL_CODE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `premises_address` SET TAGS ('dbx_business_glossary_term' = 'Premises Address (PREMISES_ADDR)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `premises_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `premises_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `premises_description` SET TAGS ('dbx_business_glossary_term' = 'Premises Description (PREMISES_DESC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (AUDIT_CREATED)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (AUDIT_UPDATED)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Status (REG_FILING_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `regulatory_filing_status` SET TAGS ('dbx_value_regex' = 'filed|pending|exempt');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (RENEWAL_NOTICE_DAYS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag (RENEWAL_OPT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `renewal_term_months` SET TAGS ('dbx_business_glossary_term' = 'Renewal Term (RENEWAL_TERM_MTH)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Base Rent Amount (RENT_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `rent_currency` SET TAGS ('dbx_business_glossary_term' = 'Rent Currency (RENT_CURR)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `rent_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `rent_escalation_amount` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Amount (ESCALATION_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `rent_escalation_interval_months` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Interval (ESCALATION_INT_MTH)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `rent_escalation_percent` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Percent (ESCALATION_PCT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_business_glossary_term' = 'Rent Escalation Type (ESCALATION_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `rent_escalation_type` SET TAGS ('dbx_value_regex' = 'fixed|percentage|none');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `rent_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rent Frequency (RENT_FREQ)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `rent_frequency` SET TAGS ('dbx_value_regex' = 'monthly|annual|quarterly');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `security_deposit_amount` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Amount (SEC_DEP_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `security_deposit_currency` SET TAGS ('dbx_business_glossary_term' = 'Security Deposit Currency (SEC_DEP_CURR)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `security_deposit_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `square_feet` SET TAGS ('dbx_business_glossary_term' = 'Premises Size (SQFT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`property_lease` ALTER COLUMN `termination_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Termination Notice Period (TERM_NOTICE_DAYS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `acquisition_id` SET TAGS ('dbx_business_glossary_term' = 'Acquisition ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `acquirer_business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Acquirer ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `seller_business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Seller ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `related_acquisition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `acquisition_number` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `acquisition_status` SET TAGS ('dbx_value_regex' = 'pending|under_review|closed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `acquisition_type` SET TAGS ('dbx_value_regex' = 'fee_simple|condemnation|donation|tax_deed');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `appraisal_date` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `appraisal_value` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Value (USD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `closing_date` SET TAGS ('dbx_business_glossary_term' = 'Closing Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Comments');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `country` SET TAGS ('dbx_business_glossary_term' = 'Country');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `country` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `deed_type` SET TAGS ('dbx_business_glossary_term' = 'Deed Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `deed_type` SET TAGS ('dbx_value_regex' = 'warranty|quitclaim|grant|easement|lease');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `environmental_status` SET TAGS ('dbx_business_glossary_term' = 'Environmental Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `environmental_status` SET TAGS ('dbx_value_regex' = 'clear|contaminated|under_remediation|unknown');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `escrow_number` SET TAGS ('dbx_business_glossary_term' = 'Escrow Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Event Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `financing_source` SET TAGS ('dbx_business_glossary_term' = 'Financing Source');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `financing_source` SET TAGS ('dbx_value_regex' = 'capital|debt|grant|bond|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Latitude');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `geographic_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_business_glossary_term' = 'Geographic Longitude');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `geographic_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `internal_project_code` SET TAGS ('dbx_business_glossary_term' = 'Internal Project Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `land_area_acres` SET TAGS ('dbx_business_glossary_term' = 'Land Area (Acres)');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `land_use_zoning` SET TAGS ('dbx_business_glossary_term' = 'Land Use Zoning');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `net_price` SET TAGS ('dbx_business_glossary_term' = 'Net Acquisition Price');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `purchase_price` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price (USD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `purchase_price_currency` SET TAGS ('dbx_business_glossary_term' = 'Purchase Price Currency');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `purchase_price_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Acquisition Purpose');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'generation_siting|transmission_corridor|service_center|environmental_mitigation|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'approved|pending|denied|not_required');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `seller_name` SET TAGS ('dbx_business_glossary_term' = 'Seller Name');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `state` SET TAGS ('dbx_business_glossary_term' = 'State');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `taxes_and_fees` SET TAGS ('dbx_business_glossary_term' = 'Taxes and Fees');
ALTER TABLE `power_and_utilities_v2`.`property`.`acquisition` ALTER COLUMN `title_company` SET TAGS ('dbx_business_glossary_term' = 'Title Company');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `disposition_id` SET TAGS ('dbx_business_glossary_term' = 'Disposition ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Party Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `disposition_business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Buyer Party Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `disposition_seller_party_business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Party Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier (Unique Property Parcel ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `seller_party_business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Seller Party Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `related_disposition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `adjustment_amount` SET TAGS ('dbx_business_glossary_term' = 'Adjustment Amount (Fees, Taxes, or Other Adjustments)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `appraisal_date` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Date (Date of Property Appraisal)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `appraisal_value` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Value (Assessed Market Value of Property)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (ISO 4217 Currency Identifier)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `deed_type` SET TAGS ('dbx_business_glossary_term' = 'Deed Type (Legal Instrument Type for Property Transfer)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `deed_type` SET TAGS ('dbx_value_regex' = 'warranty|quitclaim|grant|easement');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `disposition_number` SET TAGS ('dbx_business_glossary_term' = 'Disposition Number (DISP_NO)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_business_glossary_term' = 'Disposition Status (Current Lifecycle State)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `disposition_status` SET TAGS ('dbx_value_regex' = 'draft|pending|approved|closed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `disposition_type` SET TAGS ('dbx_business_glossary_term' = 'Disposition Type (e.g., Sale, Quitclaim, Abandonment, Dedication, Exchange)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `disposition_type` SET TAGS ('dbx_value_regex' = 'sale|quitclaim|abandonment|dedication|exchange');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (Date Disposition Becomes Effective)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `event_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Disposition Event Timestamp (Date and Time of Disposition Event)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (Date Disposition Rights Expire, if applicable)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `gain_loss_amount` SET TAGS ('dbx_business_glossary_term' = 'Gain/Loss Amount (Financial Result of Disposition)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `gain_loss_indicator` SET TAGS ('dbx_business_glossary_term' = 'Gain/Loss Indicator (Result Classification: Gain, Loss, Break-even)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `gain_loss_indicator` SET TAGS ('dbx_value_regex' = 'gain|loss|break_even');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `land_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Land Area (Square Feet of Property Land Area)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `land_use_type` SET TAGS ('dbx_business_glossary_term' = 'Land Use Type (Classification of Property Use)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `land_use_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|public|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Geographic Coordinate Latitude in Decimal Degrees)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Geographic Coordinate Longitude in Decimal Degrees)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `net_proceeds` SET TAGS ('dbx_business_glossary_term' = 'Net Proceeds (Sale Price Minus Adjustments)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (Additional Free-text Information Regarding Disposition)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `property_address` SET TAGS ('dbx_business_glossary_term' = 'Property Address (Physical Location of Property)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `property_address` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `property_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date (Date of Official Recording)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `recording_number` SET TAGS ('dbx_business_glossary_term' = 'Recording Number (Official Recording Identifier)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `regulatory_approval_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Number (Identifier for CPUC/FERC Approval)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status (Current Status of Regulatory Approval)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|denied');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `sale_price` SET TAGS ('dbx_business_glossary_term' = 'Sale Price (Monetary Amount of Sale)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (Originating System of Record for Disposition Data)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `tax_assessment_value` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Value (Assessed Taxable Value of Property)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `tax_implications` SET TAGS ('dbx_business_glossary_term' = 'Tax Implications (Description of Tax Consequences)');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Last Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`disposition` ALTER COLUMN `zoning_code` SET TAGS ('dbx_business_glossary_term' = 'Zoning Code (Regulatory Zoning Classification)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `encroachment_id` SET TAGS ('dbx_business_glossary_term' = 'Encroachment Identifier (ENC_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Encroaching Party Identifier (ENC_PARTY_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `easement_id` SET TAGS ('dbx_business_glossary_term' = 'Easement Identifier (EASE_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier (PARCEL_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Encroaching Party Identifier (ENC_PARTY_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `recurring_encroachment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `area_affected_sqft` SET TAGS ('dbx_business_glossary_term' = 'Area Affected (SQFT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `discovery_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Discovery Timestamp (DISC_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `encroaching_party_name` SET TAGS ('dbx_business_glossary_term' = 'Encroaching Party Name (ENC_PARTY_NAME)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `encroaching_party_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `encroaching_party_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `encroachment_description` SET TAGS ('dbx_business_glossary_term' = 'Encroachment Description (ENC_DESC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `encroachment_number` SET TAGS ('dbx_business_glossary_term' = 'Encroachment Number (ENC_NO)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `encroachment_status` SET TAGS ('dbx_business_glossary_term' = 'Encroachment Status (ENC_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `encroachment_status` SET TAGS ('dbx_value_regex' = 'open|notice_issued|resolved|legal_action');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `encroachment_type` SET TAGS ('dbx_business_glossary_term' = 'Encroachment Type (ENC_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `encroachment_type` SET TAGS ('dbx_value_regex' = 'structure|fence|vegetation|fill|excavation');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Encroachment Notes (ENC_NOTES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (REC_CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (REC_UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `report_source` SET TAGS ('dbx_business_glossary_term' = 'Report Source (REPORT_SRC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `report_source` SET TAGS ('dbx_value_regex' = 'system|field|customer');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By (REPORTED_BY)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Resolution Date (RES_DATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `resolution_method` SET TAGS ('dbx_business_glossary_term' = 'Resolution Method (RES_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `resolution_method` SET TAGS ('dbx_value_regex' = 'notice|removal|legal_action|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `severity` SET TAGS ('dbx_business_glossary_term' = 'Encroachment Severity (ENC_SEVERITY)');
ALTER TABLE `power_and_utilities_v2`.`property`.`encroachment` ALTER COLUMN `severity` SET TAGS ('dbx_value_regex' = 'minor|moderate|major');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `permit_id` SET TAGS ('dbx_business_glossary_term' = 'Permit Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `asset_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `finance_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Related Project Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `renewed_permit_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `activity_description` SET TAGS ('dbx_business_glossary_term' = 'Authorized Activity Description');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `amendment_date` SET TAGS ('dbx_business_glossary_term' = 'Amendment Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `amendment_number` SET TAGS ('dbx_business_glossary_term' = 'Amendment Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `area_acres` SET TAGS ('dbx_business_glossary_term' = 'Area (Acres)');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `authorized_by` SET TAGS ('dbx_business_glossary_term' = 'Authorized By');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `authorized_date` SET TAGS ('dbx_business_glossary_term' = 'Authorization Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `compliance_deadline` SET TAGS ('dbx_business_glossary_term' = 'Compliance Deadline');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending|exempt');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `conditions` SET TAGS ('dbx_business_glossary_term' = 'Permit Conditions');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `construction_end_date` SET TAGS ('dbx_business_glossary_term' = 'Construction End Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `construction_start_date` SET TAGS ('dbx_business_glossary_term' = 'Construction Start Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `document_url` SET TAGS ('dbx_business_glossary_term' = 'Permit Document URL');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `environmental_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Environmental Impact Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `expiration_notice_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `expiration_notice_sent` SET TAGS ('dbx_business_glossary_term' = 'Expiration Notice Sent Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Permit Fee Amount');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency (ISO 4217)');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `geocode_latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `geocode_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `geocode_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `geocode_longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `geocode_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `geocode_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Due Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `inspection_required` SET TAGS ('dbx_business_glossary_term' = 'Inspection Required Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `issue_date` SET TAGS ('dbx_business_glossary_term' = 'Issue Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `issuing_agency` SET TAGS ('dbx_business_glossary_term' = 'Issuing Agency');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `land_use_type` SET TAGS ('dbx_business_glossary_term' = 'Land Use Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Result');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `last_inspection_result` SET TAGS ('dbx_value_regex' = 'pass|fail|conditional');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Permit Notes');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'unpaid|paid|partial|waived|pending');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `permit_category` SET TAGS ('dbx_business_glossary_term' = 'Permit Category');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `permit_category` SET TAGS ('dbx_value_regex' = 'federal|state|local|private');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number (ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_business_glossary_term' = 'Permit Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `permit_status` SET TAGS ('dbx_value_regex' = 'active|inactive|expired|revoked|pending|closed');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_business_glossary_term' = 'Permit Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `permit_type` SET TAGS ('dbx_value_regex' = 'building|grading|encroachment|conditional_use|variance|special_use');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `renewal_date` SET TAGS ('dbx_business_glossary_term' = 'Renewal Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `renewal_required` SET TAGS ('dbx_business_glossary_term' = 'Renewal Required Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Permit Status Reason');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Permit Title');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`permit` ALTER COLUMN `zoning_code` SET TAGS ('dbx_business_glossary_term' = 'Zoning Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `title_record_id` SET TAGS ('dbx_business_glossary_term' = 'Title Record Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier (PARCEL_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `prior_title_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `claim_history_flag` SET TAGS ('dbx_business_glossary_term' = 'Claim History Exists Flag (CLAIM_HIST)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `curative_action_deadline` SET TAGS ('dbx_business_glossary_term' = 'Curative Action Deadline (CURATIVE_DL)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `curative_action_required` SET TAGS ('dbx_business_glossary_term' = 'Curative Action Required Flag (CURATIVE_REQ)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR_CD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `deductible_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Deductible Amount (DEDUCT_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `encumbrances` SET TAGS ('dbx_business_glossary_term' = 'Encumbrances (ENCUMBR)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `filing_deadline` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Deadline (FILING_DL)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `insurance_coverage_type` SET TAGS ('dbx_business_glossary_term' = 'Insurance Coverage Type (COV_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `insurance_coverage_type` SET TAGS ('dbx_value_regex' = 'full|partial|none');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JURIS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'General Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `policy_amount` SET TAGS ('dbx_business_glossary_term' = 'Policy Coverage Amount (POLICY_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `policy_effective_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Effective Date (POLICY_EFF_DT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `policy_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Policy Expiration Date (POLICY_EXP_DT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `policy_limit` SET TAGS ('dbx_business_glossary_term' = 'Policy Limit (POLICY_LIMIT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `policy_number` SET TAGS ('dbx_business_glossary_term' = 'Title Insurance Policy Number (POLICY_NO)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `regulatory_filing_required` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Required Flag (REG_FILING_REQ)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `title_company` SET TAGS ('dbx_business_glossary_term' = 'Title Company Name (TITLE_CO)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `title_document_url` SET TAGS ('dbx_business_glossary_term' = 'Title Document URL (DOC_URL)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `title_exceptions` SET TAGS ('dbx_business_glossary_term' = 'Title Exceptions (EXCEPTIONS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `title_insurer` SET TAGS ('dbx_business_glossary_term' = 'Title Insurer Name (INSURER)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `title_search_date` SET TAGS ('dbx_business_glossary_term' = 'Title Search Date (SEARCH_DT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `title_status` SET TAGS ('dbx_business_glossary_term' = 'Title Status (TITLE_STS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `title_status` SET TAGS ('dbx_value_regex' = 'clear|clouded|disputed|under_examination');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `title_type` SET TAGS ('dbx_business_glossary_term' = 'Title Document Type (TITLE_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`title_record` ALTER COLUMN `vesting_deed_reference` SET TAGS ('dbx_business_glossary_term' = 'Vesting Deed Reference (VEST_DEED_REF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `appraisal_id` SET TAGS ('dbx_business_glossary_term' = 'Appraisal ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `appraisal_person_id` SET TAGS ('dbx_business_glossary_term' = 'Appraiser ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `appraisal_reviewed_by_person_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `approved_by_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approved By ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `easement_id` SET TAGS ('dbx_business_glossary_term' = 'Easement ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Reviewed By ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Appraiser ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `prior_appraisal_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `appraisal_date` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `appraisal_number` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `appraisal_scope` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Scope');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `appraisal_scope` SET TAGS ('dbx_value_regex' = 'full|partial|site_specific');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `appraisal_status` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `appraisal_status` SET TAGS ('dbx_value_regex' = 'draft|completed|approved|cancelled');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `appraisal_type` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `appraisal_type` SET TAGS ('dbx_value_regex' = 'fee|review|condemnation|insurance');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `appraised_value` SET TAGS ('dbx_business_glossary_term' = 'Appraised Value (USD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `building_count` SET TAGS ('dbx_business_glossary_term' = 'Number of Buildings');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `building_sqft` SET TAGS ('dbx_business_glossary_term' = 'Building Area (sq ft)');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `depreciation_rate_pct` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Rate (%)');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `fee` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Fee');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Is Confidential');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `land_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Land Area (sq ft)');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `land_use_type` SET TAGS ('dbx_business_glossary_term' = 'Land Use Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `land_use_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|utility');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `latitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `longitude` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `market_trend_indicator` SET TAGS ('dbx_business_glossary_term' = 'Market Trend Indicator');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `net_appraised_value` SET TAGS ('dbx_business_glossary_term' = 'Net Appraised Value (USD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Notes');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `purpose` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Purpose');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `purpose` SET TAGS ('dbx_value_regex' = 'acquisition|disposition|rate_base|condemnation|insurance');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `reason` SET TAGS ('dbx_business_glossary_term' = 'Appraisal Reason');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `report_reference` SET TAGS ('dbx_business_glossary_term' = 'Report Reference');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `report_url` SET TAGS ('dbx_business_glossary_term' = 'Report URL');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `review_date` SET TAGS ('dbx_business_glossary_term' = 'Review Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `status_reason` SET TAGS ('dbx_business_glossary_term' = 'Status Reason');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `valuation_date` SET TAGS ('dbx_business_glossary_term' = 'Valuation Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `valuation_methodology` SET TAGS ('dbx_business_glossary_term' = 'Valuation Methodology');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `valuation_methodology` SET TAGS ('dbx_value_regex' = 'sales_comparison|income|cost');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`appraisal` ALTER COLUMN `year_built` SET TAGS ('dbx_business_glossary_term' = 'Year Built');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `environmental_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Responsible Party Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `originating_environmental_condition_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `actual_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Actual Remediation Cost');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `comments` SET TAGS ('dbx_business_glossary_term' = 'Comments');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `condition_description` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition Description');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `condition_severity` SET TAGS ('dbx_business_glossary_term' = 'Condition Severity');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `condition_severity` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `condition_type` SET TAGS ('dbx_value_regex' = 'soil|groundwater|pcb|asbestos|lead_paint|ust');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `contamination_level` SET TAGS ('dbx_business_glossary_term' = 'Contamination Level');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `contamination_unit` SET TAGS ('dbx_business_glossary_term' = 'Contamination Unit of Measure');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `contamination_unit` SET TAGS ('dbx_value_regex' = 'mg/kg|ppm|µg/L|mg/L');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Cost Currency');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `cost_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Condition Discovery Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `estimated_remediation_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Remediation Cost');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `last_monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Last Monitoring Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_business_glossary_term' = 'Monitoring Frequency');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `monitoring_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|semiannual|annual|ad_hoc');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `next_monitoring_date` SET TAGS ('dbx_business_glossary_term' = 'Next Monitoring Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `notification_date` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `notification_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Notification Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `notification_status` SET TAGS ('dbx_value_regex' = 'notified|pending|exempt|unknown');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `record_status` SET TAGS ('dbx_business_glossary_term' = 'Record Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `record_status` SET TAGS ('dbx_value_regex' = 'active|inactive|archived');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Agency');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `regulatory_agency` SET TAGS ('dbx_value_regex' = 'FERC|NERC|EPA|PUC|State');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `regulatory_case_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Case Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `remediation_end_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation End Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `remediation_method` SET TAGS ('dbx_business_glossary_term' = 'Remediation Method');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `remediation_method` SET TAGS ('dbx_value_regex' = 'excavation|pump_and_treat|in_situ|capping|bioremediation|none');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `remediation_start_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Start Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `remediation_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `remediation_status` SET TAGS ('dbx_value_regex' = 'assessment|active|monitoring|closed|deferred');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ArcGIS|Maximo|SAP|Custom');
ALTER TABLE `power_and_utilities_v2`.`property`.`environmental_condition` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `remediation_activity_id` SET TAGS ('dbx_business_glossary_term' = 'Remediation Activity ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `environmental_condition_id` SET TAGS ('dbx_business_glossary_term' = 'Environmental Condition ID (ENV_COND_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `finance_capex_project_id` SET TAGS ('dbx_business_glossary_term' = 'Project ID (PROJECT_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `primary_remediation_vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID (CONTRACTOR_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `site_id` SET TAGS ('dbx_business_glossary_term' = 'Site ID (SITE_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Contractor ID (CONTRACTOR_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `followup_remediation_activity_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `activity_date` SET TAGS ('dbx_business_glossary_term' = 'Remediation Activity Date (ACT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `activity_number` SET TAGS ('dbx_business_glossary_term' = 'Remediation Activity Number (ACT_NUM)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_business_glossary_term' = 'Remediation Activity Status (ACT_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `activity_status` SET TAGS ('dbx_value_regex' = 'planned|in_progress|completed|cancelled|deferred');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_business_glossary_term' = 'Remediation Activity Type (ACT_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `activity_type` SET TAGS ('dbx_value_regex' = 'soil_excavation|groundwater_pump_treat|vapor_extraction|monitoring_well_sampling|cap_installation');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual End Timestamp (ACT_END_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Start Timestamp (ACT_START_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `analytical_results_summary` SET TAGS ('dbx_business_glossary_term' = 'Analytical Results Summary (ANL_SUM)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `approval_date` SET TAGS ('dbx_business_glossary_term' = 'Approval Date (APPROVAL_DATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `approved_by` SET TAGS ('dbx_business_glossary_term' = 'Approved By (APPROVED_BY)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMP_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `contractor_name` SET TAGS ('dbx_business_glossary_term' = 'Contractor Name (CONTRACTOR_NAME)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `contractor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `contractor_name` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `cost_incurred` SET TAGS ('dbx_business_glossary_term' = 'Cost Incurred (COST)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `is_hazardous_material` SET TAGS ('dbx_business_glossary_term' = 'Hazardous Material Flag (HAZ_MAT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `location_description` SET TAGS ('dbx_business_glossary_term' = 'Location Description (LOC_DESC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `regulatory_approval_reference` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Reference (REG_REF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `scheduled_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Timestamp (SCH_END_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `scheduled_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Timestamp (SCH_START_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `volume_removed` SET TAGS ('dbx_business_glossary_term' = 'Volume Removed (VOL_REM)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `volume_unit` SET TAGS ('dbx_business_glossary_term' = 'Volume Unit (VOL_UNIT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `volume_unit` SET TAGS ('dbx_value_regex' = 'cubic_meters|cubic_feet|tons');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `waste_disposal_certificate` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Certificate (WASTE_CERT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `waste_disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Waste Disposal Method (WASTE_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`remediation_activity` ALTER COLUMN `waste_disposal_method` SET TAGS ('dbx_value_regex' = 'landfill|incineration|recycling|on_site_treatment');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `space_allocation_id` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Department Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `superseded_space_allocation_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `allocated_sqft` SET TAGS ('dbx_business_glossary_term' = 'Allocated Square Feet');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `allocation_code` SET TAGS ('dbx_business_glossary_term' = 'Space Allocation Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_business_glossary_term' = 'Allocation Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `allocation_status` SET TAGS ('dbx_value_regex' = 'active|pending|terminated|closed');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `building_code` SET TAGS ('dbx_business_glossary_term' = 'Building Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `chargeback_amount` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Amount');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `chargeback_flag` SET TAGS ('dbx_business_glossary_term' = 'Chargeback Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `cost_center_code` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Code');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `floor_number` SET TAGS ('dbx_business_glossary_term' = 'Floor Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `is_accessible` SET TAGS ('dbx_business_glossary_term' = 'Accessibility Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `occupancy_end_date` SET TAGS ('dbx_business_glossary_term' = 'Occupancy End Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `occupancy_start_date` SET TAGS ('dbx_business_glossary_term' = 'Occupancy Start Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `rent_amount` SET TAGS ('dbx_business_glossary_term' = 'Rent Amount');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `rent_currency` SET TAGS ('dbx_business_glossary_term' = 'Rent Currency');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `rent_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `rent_frequency` SET TAGS ('dbx_business_glossary_term' = 'Rent Frequency');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `rent_frequency` SET TAGS ('dbx_value_regex' = 'monthly|quarterly|annual');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `room_number` SET TAGS ('dbx_business_glossary_term' = 'Room Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `security_level` SET TAGS ('dbx_business_glossary_term' = 'Security Level');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `security_level` SET TAGS ('dbx_value_regex' = 'public|confidential|restricted');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `space_label` SET TAGS ('dbx_business_glossary_term' = 'Space Label');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `space_type` SET TAGS ('dbx_business_glossary_term' = 'Space Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `space_type` SET TAGS ('dbx_value_regex' = 'office|lab|operations|storage|common_area|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By User Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `wing` SET TAGS ('dbx_business_glossary_term' = 'Wing Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`space_allocation` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By User Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `facility_inspection_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Inspection ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `reinspection_of_facility_inspection_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `auditor_comments` SET TAGS ('dbx_business_glossary_term' = 'Auditor Comments');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `corrective_action_required` SET TAGS ('dbx_business_glossary_term' = 'Corrective Action Required');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Count');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `deficiency_severity` SET TAGS ('dbx_business_glossary_term' = 'Deficiency Severity');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `deficiency_severity` SET TAGS ('dbx_value_regex' = 'critical|high|medium|low|none');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `equipment_status` SET TAGS ('dbx_business_glossary_term' = 'Equipment Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `facility_inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `facility_inspection_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `findings_summary` SET TAGS ('dbx_business_glossary_term' = 'Findings Summary');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `follow_up_action_summary` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Action Summary');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `follow_up_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `high_severity_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'High Severity Deficiency Count');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspection_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Inspection Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspection_latitude` SET TAGS ('dbx_business_glossary_term' = 'Inspection Latitude');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspection_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspection_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspection_longitude` SET TAGS ('dbx_business_glossary_term' = 'Inspection Longitude');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspection_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspection_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspection_report_url` SET TAGS ('dbx_business_glossary_term' = 'Inspection Report URL');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_business_glossary_term' = 'Inspection Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspection_type` SET TAGS ('dbx_value_regex' = 'fire|ada|structural|hvac|regulatory');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspector_affiliation` SET TAGS ('dbx_business_glossary_term' = 'Inspector Affiliation');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_business_glossary_term' = 'Inspector Name');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `inspector_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `low_severity_deficiency_count` SET TAGS ('dbx_business_glossary_term' = 'Low Severity Deficiency Count');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `next_inspection_due_date` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `outcome` SET TAGS ('dbx_business_glossary_term' = 'Inspection Outcome');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `outcome` SET TAGS ('dbx_value_regex' = 'pass|conditional_pass|fail');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Body');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `regulatory_body` SET TAGS ('dbx_value_regex' = 'FERC|NERC|PUC|EPA');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `total_findings` SET TAGS ('dbx_business_glossary_term' = 'Total Findings');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`facility_inspection` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `lease_payment_id` SET TAGS ('dbx_business_glossary_term' = 'Lease Payment ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Party ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `property_lease_id` SET TAGS ('dbx_business_glossary_term' = 'Property Lease ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `adjusted_lease_payment_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `amount_adjustments` SET TAGS ('dbx_business_glossary_term' = 'Payment Adjustments Amount (ADJ_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `amount_gross` SET TAGS ('dbx_business_glossary_term' = 'Gross Payment Amount (GROSS_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `amount_net` SET TAGS ('dbx_business_glossary_term' = 'Net Payment Amount (NET_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code (CURR)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `discount_amount` SET TAGS ('dbx_business_glossary_term' = 'Discount Amount (DISCOUNT_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `dispute_reason` SET TAGS ('dbx_business_glossary_term' = 'Dispute Reason (DISPUTE_REASON)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `exchange_rate` SET TAGS ('dbx_business_glossary_term' = 'Exchange Rate (EXCH_RATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `external_payment_reference` SET TAGS ('dbx_business_glossary_term' = 'External Payment ID (EXT_PAY_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `invoice_number` SET TAGS ('dbx_business_glossary_term' = 'Invoice Number (INV_NO)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `is_reconciled` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Flag (RECONCILED)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount (LATE_FEE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_business_glossary_term' = 'Payment Channel (CHANNEL)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_channel` SET TAGS ('dbx_value_regex' = 'web|mobile|mail|batch|phone|branch');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date (PAY_DATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_direction` SET TAGS ('dbx_business_glossary_term' = 'Payment Direction (DIR)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_direction` SET TAGS ('dbx_value_regex' = 'inbound|outbound');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (METHOD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'credit_card|ach|check|cash|wire|online_portal');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Number (PAYMENT_NO)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_period_end` SET TAGS ('dbx_business_glossary_term' = 'Payment Period End Date (PERIOD_END)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_period_start` SET TAGS ('dbx_business_glossary_term' = 'Payment Period Start Date (PERIOD_START)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_source_system` SET TAGS ('dbx_business_glossary_term' = 'Payment Source System (SRC_SYS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'scheduled|paid|overdue|disputed|cancelled|pending');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `reconciliation_date` SET TAGS ('dbx_business_glossary_term' = 'Reconciliation Date (RECON_DATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `remittance_reference` SET TAGS ('dbx_business_glossary_term' = 'Remittance Reference (REMIT_REF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `tax_code` SET TAGS ('dbx_business_glossary_term' = 'Tax Code (TAX_CODE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`lease_payment` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `condemnation_proceeding_id` SET TAGS ('dbx_business_glossary_term' = 'Condemnation Proceeding ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `easement_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Easement ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Affected Parcel ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `business_entity_id` SET TAGS ('dbx_business_glossary_term' = 'Property Owner ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `person_id` SET TAGS ('dbx_business_glossary_term' = 'Property Owner ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `appealed_condemnation_proceeding_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `appeal_deadline_date` SET TAGS ('dbx_business_glossary_term' = 'Appeal Deadline Date (ADD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `appeal_filed_flag` SET TAGS ('dbx_business_glossary_term' = 'Appeal Filed Flag (AFF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `award_currency` SET TAGS ('dbx_business_glossary_term' = 'Award Currency (AC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `award_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `court_case_number` SET TAGS ('dbx_business_glossary_term' = 'Court Case Number (CCN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `filing_date` SET TAGS ('dbx_business_glossary_term' = 'Filing Date (FD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `final_award_amount` SET TAGS ('dbx_business_glossary_term' = 'Final Award Amount (FAA)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `hearing_date` SET TAGS ('dbx_business_glossary_term' = 'Hearing Date (HD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `is_confidential` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag (CF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `judgment_date` SET TAGS ('dbx_business_glossary_term' = 'Judgment Date (JD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JUR)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `just_compensation_offer_amount` SET TAGS ('dbx_business_glossary_term' = 'Just Compensation Offer Amount (JCOA)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `just_compensation_offer_amount` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `just_compensation_offer_amount` SET TAGS ('dbx_pii_financial' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `legal_counsel_firm` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Firm (LCF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `legal_counsel_name` SET TAGS ('dbx_business_glossary_term' = 'Legal Counsel Name (LCN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `legal_counsel_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `legal_counsel_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Proceeding Notes (PN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `offer_currency` SET TAGS ('dbx_business_glossary_term' = 'Offer Currency (OC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `offer_currency` SET TAGS ('dbx_value_regex' = '^[A-Z]{3}$');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `proceeding_number` SET TAGS ('dbx_business_glossary_term' = 'Proceeding Number (PN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `proceeding_status` SET TAGS ('dbx_business_glossary_term' = 'Proceeding Status (PS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `proceeding_status` SET TAGS ('dbx_value_regex' = 'pre_filing|filed|negotiation|trial|settled|closed');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `proceeding_type` SET TAGS ('dbx_business_glossary_term' = 'Proceeding Type (PT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `proceeding_type` SET TAGS ('dbx_value_regex' = 'quick_take|standard|inverse_defense');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `property_owner_name` SET TAGS ('dbx_business_glossary_term' = 'Property Owner Name (PON)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `property_owner_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `property_owner_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `regulatory_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Number (RFN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `resolution_type` SET TAGS ('dbx_business_glossary_term' = 'Resolution Type (RT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `resolution_type` SET TAGS ('dbx_value_regex' = 'settlement|trial|withdrawn|dismissed');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `settlement_amount` SET TAGS ('dbx_business_glossary_term' = 'Settlement Amount (SA)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `settlement_date` SET TAGS ('dbx_business_glossary_term' = 'Settlement Date (SD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID (SSRI)');
ALTER TABLE `power_and_utilities_v2`.`property`.`condemnation_proceeding` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `gis_boundary_id` SET TAGS ('dbx_business_glossary_term' = 'GIS Boundary ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `superseded_gis_boundary_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `area_sqft` SET TAGS ('dbx_business_glossary_term' = 'Boundary Area (sqft) (BA)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `boundary_code` SET TAGS ('dbx_business_glossary_term' = 'Boundary Code (BC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `boundary_code` SET TAGS ('dbx_value_regex' = '^[A-Z0-9_-]+$');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `boundary_name` SET TAGS ('dbx_business_glossary_term' = 'Boundary Name (BN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `boundary_type` SET TAGS ('dbx_business_glossary_term' = 'Boundary Type (BT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `boundary_type` SET TAGS ('dbx_value_regex' = 'parcel|easement|site|right_of_way|facility|substation');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Latitude (CLAT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `centroid_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_business_glossary_term' = 'Centroid Longitude (CLON)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `centroid_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (CSTAT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `crs_epsg` SET TAGS ('dbx_business_glossary_term' = 'Coordinate Reference System EPSG Code (CRS_EPSG)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `crs_epsg` SET TAGS ('dbx_value_regex' = '^EPSG:d{4,5}$');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `effective_from` SET TAGS ('dbx_business_glossary_term' = 'Effective From Date (EFD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `effective_until` SET TAGS ('dbx_business_glossary_term' = 'Effective Until Date (EUD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `flood_zone` SET TAGS ('dbx_business_glossary_term' = 'Flood Zone Designation (FZD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `flood_zone` SET TAGS ('dbx_value_regex' = 'X|AE|A|B|C|D');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `geometry_type` SET TAGS ('dbx_business_glossary_term' = 'Geometry Type (GT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `geometry_type` SET TAGS ('dbx_value_regex' = 'polygon|polyline|point');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geometry Well‑Known Text (WKT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `gis_boundary_description` SET TAGS ('dbx_business_glossary_term' = 'Boundary Description (BDESC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `gis_boundary_status` SET TAGS ('dbx_business_glossary_term' = 'Boundary Status (BS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `gis_boundary_status` SET TAGS ('dbx_value_regex' = 'current|superseded|under_revision|retired');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `historical_boundary_flag` SET TAGS ('dbx_business_glossary_term' = 'Historical Boundary Flag (HBF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag (CIF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `is_protected_area` SET TAGS ('dbx_business_glossary_term' = 'Protected Area Flag (PAF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (County/State) (JUR)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `land_use_type` SET TAGS ('dbx_business_glossary_term' = 'Land Use Type (LUT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `land_use_type` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|utility|agricultural|mixed_use');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (LID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `last_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Survey Date (LSD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `layer_name` SET TAGS ('dbx_business_glossary_term' = 'GIS Layer Name (GLN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `length_ft` SET TAGS ('dbx_business_glossary_term' = 'Boundary Length (ft) (BL)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date (NID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Additional Notes (ANOTES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `regulatory_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Number (RFN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'Esri ArcGIS|Oracle GIS|Custom GIS');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (SSI)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `source_system_code` SET TAGS ('dbx_value_regex' = '^[A-Za-z0-9_-]+$');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `survey_accuracy_class` SET TAGS ('dbx_business_glossary_term' = 'Survey Accuracy Class (SAC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `survey_accuracy_class` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number (VER)');
ALTER TABLE `power_and_utilities_v2`.`property`.`gis_boundary` ALTER COLUMN `zoning_classification` SET TAGS ('dbx_business_glossary_term' = 'Zoning Classification (ZONING)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `survey_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Identifier (SID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `easement_id` SET TAGS ('dbx_business_glossary_term' = 'Easement Identifier (EASEMENT_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier (PARCEL_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `resurvey_of_survey_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `approval_status` SET TAGS ('dbx_business_glossary_term' = 'Approval Status (APPROVAL_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `approval_status` SET TAGS ('dbx_value_regex' = 'approved|rejected|pending');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `approval_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Approval Timestamp (APPROVAL_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `compliance_regulation` SET TAGS ('dbx_business_glossary_term' = 'Compliance Regulation (REGULATION)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status (COMP_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending_review');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `cost_amount` SET TAGS ('dbx_business_glossary_term' = 'Survey Cost Amount (COST_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `cost_currency` SET TAGS ('dbx_business_glossary_term' = 'Survey Cost Currency (COST_CUR)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `drawing_reference` SET TAGS ('dbx_business_glossary_term' = 'Drawing Reference (DRAW_REF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `firm` SET TAGS ('dbx_business_glossary_term' = 'Survey Firm (FIRM)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `is_confidential_flag` SET TAGS ('dbx_business_glossary_term' = 'Confidential Flag (CONF_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `legal_description` SET TAGS ('dbx_business_glossary_term' = 'Legal Description (LEGAL_DESC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Survey Latitude (LAT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Survey Longitude (LON)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `survey_date` SET TAGS ('dbx_business_glossary_term' = 'Survey Date (DATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_business_glossary_term' = 'Survey Method (METHOD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `survey_method` SET TAGS ('dbx_value_regex' = 'gps|total_station|drone|lidar');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `survey_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Number (SURV_NO)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'pending|in_progress|completed|rejected|cancelled');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'boundary|alta_nsps|topographic|as_built|route');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `surveyor_license_number` SET TAGS ('dbx_business_glossary_term' = 'Surveyor License Number (LIC_NO)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `surveyor_license_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `surveyor_license_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `surveyor_name` SET TAGS ('dbx_business_glossary_term' = 'Surveyor Name (SURVEYOR)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `surveyor_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `surveyor_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TAX_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `total_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Survey Amount (TOTAL_AMT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` SET TAGS ('dbx_subdomain' = 'financial_operations');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_record_id` SET TAGS ('dbx_business_glossary_term' = 'Property Tax Record Identifier (PTRID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier (PID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `amended_tax_record_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `assessed_improvement_value` SET TAGS ('dbx_business_glossary_term' = 'Assessed Improvement Value (AIV)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `assessed_land_value` SET TAGS ('dbx_business_glossary_term' = 'Assessed Land Value (ALV)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `assessment_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Date (TAD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `county` SET TAGS ('dbx_business_glossary_term' = 'County (County)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `exemption_amount` SET TAGS ('dbx_business_glossary_term' = 'Exemption Amount (EA)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `exemption_flag` SET TAGS ('dbx_business_glossary_term' = 'Exemption Flag (EF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `exemption_type` SET TAGS ('dbx_business_glossary_term' = 'Exemption Type (ET)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `exemption_type` SET TAGS ('dbx_value_regex' = 'none|state|federal|municipal|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `interest_amount` SET TAGS ('dbx_business_glossary_term' = 'Interest Amount (IA)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `late_fee_amount` SET TAGS ('dbx_business_glossary_term' = 'Late Fee Amount (LFA)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (Notes)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `parcel_apn` SET TAGS ('dbx_business_glossary_term' = 'Assessor Parcel Number (APN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `payment_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Date (PD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `payment_due_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Date (PDD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_business_glossary_term' = 'Payment Method (PM)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `payment_method` SET TAGS ('dbx_value_regex' = 'check|electronic|cash|credit|debit');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `payment_reference_number` SET TAGS ('dbx_business_glossary_term' = 'Payment Reference Number (PRN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `payment_status` SET TAGS ('dbx_business_glossary_term' = 'Payment Status (PS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `payment_status` SET TAGS ('dbx_value_regex' = 'paid|pending|overdue|waived|partial');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `payment_status_date` SET TAGS ('dbx_business_glossary_term' = 'Payment Status Date (PSD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created Timestamp (RACT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated Timestamp (RAUT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_abatement_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Abatement Amount (TAA)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_abatement_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Abatement Flag (TAF)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_abatement_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Abatement Type (TAT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_abatement_type` SET TAGS ('dbx_value_regex' = 'state|federal|local|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount (TA)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_appeal_filed_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Appeal Filed Date (TAFD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_appeal_notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Appeal Notes (TAN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_appeal_outcome` SET TAGS ('dbx_business_glossary_term' = 'Tax Appeal Outcome (TAO)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_appeal_outcome` SET TAGS ('dbx_value_regex' = 'approved|denied|settled|withdrawn');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_appeal_resolution_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Appeal Resolution Date (TARD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_appeal_status` SET TAGS ('dbx_business_glossary_term' = 'Tax Appeal Status (TAS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_appeal_status` SET TAGS ('dbx_value_regex' = 'none|filed|under_review|resolved|rejected');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_assessment_notes` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Notes (TAN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_assessment_source` SET TAGS ('dbx_business_glossary_term' = 'Tax Assessment Source (TAS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_assessment_source` SET TAGS ('dbx_value_regex' = 'assessor|internal|third_party');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_bill_number` SET TAGS ('dbx_business_glossary_term' = 'Tax Bill Number (TBN)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_bill_url` SET TAGS ('dbx_business_glossary_term' = 'Tax Bill URL (TBU)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_currency` SET TAGS ('dbx_business_glossary_term' = 'Tax Currency (TC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_currency` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|CHF');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_exemption_approval_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Approval Date (TEAD)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_exemption_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Tax Exemption Expiration Date (TEED)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_rate_area` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Area (TRA)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage (TR%)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_type` SET TAGS ('dbx_business_glossary_term' = 'Tax Type (TT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_type` SET TAGS ('dbx_value_regex' = 'property|special_assessment|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `tax_year` SET TAGS ('dbx_business_glossary_term' = 'Tax Year (TY)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `total_assessed_value` SET TAGS ('dbx_business_glossary_term' = 'Total Assessed Value (TAV)');
ALTER TABLE `power_and_utilities_v2`.`property`.`tax_record` ALTER COLUMN `total_due_amount` SET TAGS ('dbx_business_glossary_term' = 'Total Due Amount (TDA)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `license_agreement_id` SET TAGS ('dbx_business_glossary_term' = 'License Agreement Identifier');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `easement_id` SET TAGS ('dbx_business_glossary_term' = 'Easement Identifier (EASEMENT_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Identifier (PARCEL_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `renewed_license_agreement_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `agreement_number` SET TAGS ('dbx_business_glossary_term' = 'Agreement Number (AGREEMENT_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `annual_license_fee` SET TAGS ('dbx_business_glossary_term' = 'Annual License Fee (ANNUAL_LICENSE_FEE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `compliance_requirements` SET TAGS ('dbx_business_glossary_term' = 'Compliance Requirements (COMPLIANCE_REQUIREMENTS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date (EFFECTIVE_END_DATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date (EFFECTIVE_START_DATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `fee_currency` SET TAGS ('dbx_business_glossary_term' = 'Fee Currency (FEE_CURRENCY)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `gis_feature_reference` SET TAGS ('dbx_business_glossary_term' = 'GIS Feature Identifier (GIS_FEATURE_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `insurance_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Insurance Expiration Date (INSURANCE_EXPIRATION_DATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_business_glossary_term' = 'Insurance Policy Number (INSURANCE_POLICY_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `insurance_policy_number` SET TAGS ('dbx_pii_identifier' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `insurance_provider` SET TAGS ('dbx_business_glossary_term' = 'Insurance Provider (INSURANCE_PROVIDER)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `insurance_required_flag` SET TAGS ('dbx_business_glossary_term' = 'Insurance Required Flag (INSURANCE_REQUIRED_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `is_exclusive_flag` SET TAGS ('dbx_business_glossary_term' = 'Exclusive License Flag (IS_EXCLUSIVE_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `is_transferable_flag` SET TAGS ('dbx_business_glossary_term' = 'Transferable License Flag (IS_TRANSFERABLE_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `jurisdiction_state` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction State (JURISDICTION_STATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `license_agreement_status` SET TAGS ('dbx_business_glossary_term' = 'License Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `license_agreement_status` SET TAGS ('dbx_value_regex' = 'active|pending|draft|terminated|expired');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `license_area_sqft` SET TAGS ('dbx_business_glossary_term' = 'License Area (SQFT) (LICENSE_AREA_SQFT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `license_type` SET TAGS ('dbx_business_glossary_term' = 'License Type (LICENSE_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `license_type` SET TAGS ('dbx_value_regex' = 'cell_tower|fiber|billboard|agricultural|pipeline_crossing|other');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensed_area_acres` SET TAGS ('dbx_business_glossary_term' = 'Licensed Area (ACRES) (LICENSED_AREA_ACRES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensed_area_description` SET TAGS ('dbx_business_glossary_term' = 'Licensed Area Description (LICENSED_AREA_DESCRIPTION)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_address` SET TAGS ('dbx_business_glossary_term' = 'Licensee Address (LICENSEE_ADDRESS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_address` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_address` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_contact_email` SET TAGS ('dbx_business_glossary_term' = 'Licensee Contact Email (LICENSEE_CONTACT_EMAIL)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_contact_email` SET TAGS ('dbx_value_regex' = '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_contact_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_contact_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_contact_name` SET TAGS ('dbx_business_glossary_term' = 'Licensee Contact Name (LICENSEE_CONTACT_NAME)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_contact_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_contact_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'Licensee Contact Phone (LICENSEE_CONTACT_PHONE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_name` SET TAGS ('dbx_business_glossary_term' = 'Licensee Name (LICENSEE_NAME)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_name` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `licensee_name` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `payment_due_day_of_month` SET TAGS ('dbx_business_glossary_term' = 'Payment Due Day of Month (PAYMENT_DUE_DAY_OF_MONTH)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_business_glossary_term' = 'Payment Frequency (PAYMENT_FREQUENCY)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `payment_frequency` SET TAGS ('dbx_value_regex' = 'annual|quarterly|monthly');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `regulatory_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Number (REGULATORY_FILING_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `renewal_notice_period_days` SET TAGS ('dbx_business_glossary_term' = 'Renewal Notice Period (DAYS) (RENEWAL_NOTICE_PERIOD_DAYS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `renewal_option_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewal Option Flag (RENEWAL_OPTION_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `revenue_share_amount` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Amount (REVENUE_SHARE_AMOUNT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `revenue_share_currency` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Currency (REVENUE_SHARE_CURRENCY)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `revenue_share_percentage` SET TAGS ('dbx_business_glossary_term' = 'Revenue Share Percentage (REVENUE_SHARE_PERCENTAGE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `tax_exempt_flag` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Flag (TAX_EXEMPT_FLAG)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `tax_exempt_reason` SET TAGS ('dbx_business_glossary_term' = 'Tax Exempt Reason (TAX_EXEMPT_REASON)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `termination_date` SET TAGS ('dbx_business_glossary_term' = 'Termination Date (TERMINATION_DATE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`license_agreement` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` SET TAGS ('dbx_data_type' = 'reference_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` SET TAGS ('dbx_subdomain' = 'regulatory_compliance');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `zoning_classification_id` SET TAGS ('dbx_business_glossary_term' = 'Zoning Classification Identifier (ZC_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `superseded_zoning_classification_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `air_quality_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Air Quality Impact Flag (AIR_QUAL)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `compliance_notes` SET TAGS ('dbx_business_glossary_term' = 'Compliance Notes (COMP_NOTES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `conditional_uses` SET TAGS ('dbx_business_glossary_term' = 'Conditional Uses (COND_USES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CRE_TSTMP)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `easement_impact_flag` SET TAGS ('dbx_business_glossary_term' = 'Easement Impact Flag (EASE_IMP)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date (EFF_DT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `environmental_restrictions` SET TAGS ('dbx_business_glossary_term' = 'Environmental Restrictions (ENV_RESTR)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date (EXP_DT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `fire_safety_requirements` SET TAGS ('dbx_business_glossary_term' = 'Fire Safety Requirements (FIRE_REQ)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `flood_zone_designation` SET TAGS ('dbx_business_glossary_term' = 'Flood Zone Designation (FLOOD_Z)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `flood_zone_designation` SET TAGS ('dbx_value_regex' = 'X|AE|A|B|C|D');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `height_limit_ft` SET TAGS ('dbx_business_glossary_term' = 'Height Limit (FT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `historic_preservation_flag` SET TAGS ('dbx_business_glossary_term' = 'Historic Preservation Flag (HIST_PRES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `jurisdiction_name` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction Name (JUR_NAME)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `land_use_type` SET TAGS ('dbx_business_glossary_term' = 'Land Use Type (LU_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `land_use_type` SET TAGS ('dbx_value_regex' = 'single_family|multi_family|mixed_use|industrial|agricultural|public');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `last_review_date` SET TAGS ('dbx_business_glossary_term' = 'Last Review Date (LRV_DT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `map_layer_reference` SET TAGS ('dbx_business_glossary_term' = 'Map Layer Identifier (MAP_LAYER_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `maximum_building_coverage_pct` SET TAGS ('dbx_business_glossary_term' = 'Maximum Building Coverage Percentage (BLDG_COV_PCT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `minimum_parcel_size_acres` SET TAGS ('dbx_business_glossary_term' = 'Minimum Parcel Size (ACRES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `noise_abatement_requirements` SET TAGS ('dbx_business_glossary_term' = 'Noise Abatement Requirements (NOISE_REQ)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `parking_requirements_spaces_per_acre` SET TAGS ('dbx_business_glossary_term' = 'Parking Requirements (SPACES_PER_ACRE)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `permitted_uses` SET TAGS ('dbx_business_glossary_term' = 'Permitted Uses (PERM_USES)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `renewable_energy_compatibility_flag` SET TAGS ('dbx_business_glossary_term' = 'Renewable Energy Compatibility Flag (RE_COMP)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `review_frequency_months` SET TAGS ('dbx_business_glossary_term' = 'Review Frequency (MONTHS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `setback_requirements_ft` SET TAGS ('dbx_business_glossary_term' = 'Setback Requirements (FT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System (SRC_SYS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `source_system` SET TAGS ('dbx_value_regex' = 'ArcGIS|LocalGov|Custom');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Source System Identifier (SRC_ID)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `tax_rate_percent` SET TAGS ('dbx_business_glossary_term' = 'Tax Rate Percentage (TAX_PCT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPD_TSTMP)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `utility_infrastructure_compatible_flag` SET TAGS ('dbx_business_glossary_term' = 'Utility Infrastructure Compatibility Flag (UTIL_COMP)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `water_resource_protection_flag` SET TAGS ('dbx_business_glossary_term' = 'Water Resource Protection Flag (WATER_PROT)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `zoning_category` SET TAGS ('dbx_business_glossary_term' = 'Zoning Category (ZCATEG)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `zoning_category` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural|open_space|special_use');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `zoning_change_history` SET TAGS ('dbx_business_glossary_term' = 'Zoning Change History (ZC_HISTORY)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `zoning_classification_description` SET TAGS ('dbx_business_glossary_term' = 'Zoning Description (ZC_DESC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `zoning_classification_status` SET TAGS ('dbx_business_glossary_term' = 'Zoning Status (ZC_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `zoning_classification_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired');
ALTER TABLE `power_and_utilities_v2`.`property`.`zoning_classification` ALTER COLUMN `zoning_code` SET TAGS ('dbx_business_glossary_term' = 'Zoning Code (ZC)');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` SET TAGS ('dbx_subdomain' = 'asset_management');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `document_id` SET TAGS ('dbx_business_glossary_term' = 'Property Document ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `superseded_document_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `archival_date` SET TAGS ('dbx_business_glossary_term' = 'Archival Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `archival_location` SET TAGS ('dbx_business_glossary_term' = 'Archival Location');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `checksum` SET TAGS ('dbx_business_glossary_term' = 'Checksum (SHA‑256)');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `compliance_review_date` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `compliance_review_user` SET TAGS ('dbx_business_glossary_term' = 'Compliance Review User');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `compliance_review_user` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `compliance_review_user` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_business_glossary_term' = 'Confidentiality Level');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `confidentiality_level` SET TAGS ('dbx_value_regex' = 'public|internal|confidential|restricted');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `county_recorder_jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'County Recorder Jurisdiction');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `digital_signature_hash` SET TAGS ('dbx_business_glossary_term' = 'Digital Signature Hash');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `disposal_date` SET TAGS ('dbx_business_glossary_term' = 'Disposal Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `disposal_method` SET TAGS ('dbx_business_glossary_term' = 'Disposal Method');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `disposal_method` SET TAGS ('dbx_value_regex' = 'recycle|destroy|donate|sell');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `document_description` SET TAGS ('dbx_business_glossary_term' = 'Document Description');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `document_status` SET TAGS ('dbx_business_glossary_term' = 'Document Status');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `document_status` SET TAGS ('dbx_value_regex' = 'current|superseded|archived|pending_review');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `document_type` SET TAGS ('dbx_business_glossary_term' = 'Document Type');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `effective_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `file_format` SET TAGS ('dbx_business_glossary_term' = 'File Format');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `file_format` SET TAGS ('dbx_value_regex' = 'pdf|docx|tiff|jpg');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `file_path` SET TAGS ('dbx_business_glossary_term' = 'File Path');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `file_size_bytes` SET TAGS ('dbx_business_glossary_term' = 'File Size (Bytes)');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `legal_hold_flag` SET TAGS ('dbx_business_glossary_term' = 'Legal Hold Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `owner_department` SET TAGS ('dbx_business_glossary_term' = 'Document Owner Department');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `page_count` SET TAGS ('dbx_business_glossary_term' = 'Page Count');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `recorder_book_page` SET TAGS ('dbx_business_glossary_term' = 'Recorder Book Page');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `recording_date` SET TAGS ('dbx_business_glossary_term' = 'Recording Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `recording_number` SET TAGS ('dbx_business_glossary_term' = 'Recording Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `regulatory_filing_number` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Filing Number');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `retention_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Retention Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `retention_policy` SET TAGS ('dbx_business_glossary_term' = 'Retention Policy');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `signed_by` SET TAGS ('dbx_business_glossary_term' = 'Signed By');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `signed_by` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `signed_by` SET TAGS ('dbx_pii_name' = 'true');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `signed_date` SET TAGS ('dbx_business_glossary_term' = 'Signed Date');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `signed_flag` SET TAGS ('dbx_business_glossary_term' = 'Signed Flag');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `source_system` SET TAGS ('dbx_business_glossary_term' = 'Document Source System');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `source_system_code` SET TAGS ('dbx_business_glossary_term' = 'Document Source ID');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `storage_location` SET TAGS ('dbx_business_glossary_term' = 'Storage Location');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `subtype` SET TAGS ('dbx_business_glossary_term' = 'Document Subtype');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `title` SET TAGS ('dbx_business_glossary_term' = 'Document Title');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`property`.`document` ALTER COLUMN `version_number` SET TAGS ('dbx_business_glossary_term' = 'Version Number');
