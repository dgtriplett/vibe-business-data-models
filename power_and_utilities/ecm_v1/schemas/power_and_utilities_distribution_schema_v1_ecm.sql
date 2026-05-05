-- Schema for Domain: distribution | Business: Power and Utilities | Version: v1_ecm
-- Generated on: 2026-05-05 03:11:15

-- ========= DATABASE =========
CREATE DATABASE IF NOT EXISTS `power_and_utilities_v2`.`distribution` COMMENT 'Owns the medium- and low-voltage electric distribution network and natural gas pipeline distribution infrastructure delivering energy to end customers. Serves as the SSOT for circuit topology, feeder configurations, poles, transformers, service connections, DMS/OMS events, outage records, and SAIDI/SAIFI/CAIDI reliability metrics. Integrates with GE PowerOn DMS/OMS and Esri ArcGIS for geospatial network modeling.';

-- ========= TABLES =========
CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`feeder` (
    `feeder_id` BIGINT COMMENT 'Unique system-generated identifier for the distribution feeder.',
    `aggregation_group_id` BIGINT COMMENT 'Foreign key linking to der.aggregation_group. Business justification: Grid planning and market participation link feeders to aggregation groups to coordinate dispatch and settlement across the distribution network.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Load forecasting and balancing area reporting require mapping each feeder to its balancing area; this is standard in ISO/RTO operations.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Required for OPEX budgeting; feeder maintenance costs allocated to cost center in Cost Center Management Report.',
    `distribution_substation_id` BIGINT COMMENT 'Identifier of the substation bus to which the feeder is attached.',
    `emergency_response_plan_id` BIGINT COMMENT 'Reference to the emergency response plan applicable to the feeder.',
    `load_profile_id` BIGINT COMMENT 'Reference to the typical load shape profile applied to the feeder.',
    `rate_case_id` BIGINT COMMENT 'Foreign key linking to regulatory.rate_case. Business justification: Rate case determines allowed rates for each feeder; required for regulatory rate filing and internal rate application.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: SCADA system monitors feeder status; required for real‑time outage management and compliance reporting.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to customer.service_territory. Business justification: Load forecasting and outage management reports require mapping each feeder to a Service Territory entity to aggregate demand and assign responsibility.',
    `asset_group` STRING COMMENT 'Logical grouping of the feeder within asset management (e.g., primary, secondary).',
    `average_daily_load_mwh` DECIMAL(18,2) COMMENT 'Mean daily energy delivered by the feeder.',
    `average_outage_duration_min` DECIMAL(18,2) COMMENT 'Mean duration of outages on the feeder, expressed in minutes.',
    `capacity_mva` DECIMAL(18,2) COMMENT 'Maximum apparent power the feeder can carry, expressed in megavolt‑amps.',
    `commissioning_date` DATE COMMENT 'Date the feeder entered service.',
    `created_timestamp` TIMESTAMP COMMENT 'Date and time when the feeder record was first created in the data lake.',
    `data_source_system` STRING COMMENT 'Originating operational system (e.g., GE PowerOn DMS, Esri ArcGIS).',
    `decommission_date` DATE COMMENT 'Date the feeder was removed from service, if applicable.',
    `estimated_annual_energy_mwh` DECIMAL(18,2) COMMENT 'Projected total energy delivered by the feeder each year.',
    `estimated_peak_load_mw` DECIMAL(18,2) COMMENT 'Projected maximum load the feeder experiences during peak conditions.',
    `fault_count_year` STRING COMMENT 'Number of fault events recorded on the feeder in the most recent year.',
    `feeder_code` STRING COMMENT 'External code or tag assigned by the utility for the feeder (e.g., legacy SCADA code).',
    `feeder_name` STRING COMMENT 'Human‑readable name of the feeder used in operational reports and GIS displays.',
    `feeder_status` STRING COMMENT 'Current operational state of the feeder.. Valid values are `active|inactive|planned|retired|decommissioned`',
    `feeder_type` STRING COMMENT 'Physical construction type of the feeder.. Valid values are `overhead|underground|mixed`',
    `gis_geometry_reference` BIGINT COMMENT 'Reference to the GIS polyline that models the feeder route.',
    `is_critical_infrastructure` BOOLEAN COMMENT 'True if the feeder is designated as critical infrastructure under NERC/ISO standards.',
    `is_metered` BOOLEAN COMMENT 'True if the feeder is equipped with AMI or SCADA metering.',
    `is_outage_prone` BOOLEAN COMMENT 'True if the feeder historically experiences frequent outages.',
    `is_under_construction` BOOLEAN COMMENT 'True if the feeder is currently being built or upgraded.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the feeder.',
    `last_outage_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent outage event on the feeder.',
    `length_km` DECIMAL(18,2) COMMENT 'Total linear length of the feeder route in kilometers.',
    `maintenance_cycle_months` STRING COMMENT 'Planned interval between major maintenance activities.',
    `max_recorded_load_mw` DECIMAL(18,2) COMMENT 'Highest instantaneous load observed on the feeder.',
    `meter_data_source` STRING COMMENT 'System that provides metered data for the feeder.. Valid values are `AMI|SCADA|Manual`',
    `min_recorded_load_mw` DECIMAL(18,2) COMMENT 'Lowest instantaneous load observed on the feeder.',
    `notes` STRING COMMENT 'Free‑form comments or operational notes about the feeder.',
    `outage_count_year` STRING COMMENT 'Number of recorded outages on the feeder in the most recent calendar year.',
    `protection_device_id` BIGINT COMMENT 'Identifier of the primary protective device (e.g., recloser, breaker) for the feeder.',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance state of the feeder with FERC/NERC regulations.. Valid values are `compliant|non_compliant|pending`',
    `reliability_caidi` DECIMAL(18,2) COMMENT 'Average outage duration per interruption for the feeder, measured in minutes.',
    `reliability_saidi` DECIMAL(18,2) COMMENT 'Average outage duration per customer for the feeder, measured in minutes.',
    `reliability_saifi` DECIMAL(18,2) COMMENT 'Average number of interruptions per customer for the feeder per year.',
    `transformer_rating_mva` DECIMAL(18,2) COMMENT 'MVA rating of the primary transformer feeding the feeder.',
    `updated_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent update to the feeder record.',
    `voltage_kv` DECIMAL(18,2) COMMENT 'Design voltage level of the feeder in kilovolts.',
    `voltage_regulation_percent` DECIMAL(18,2) COMMENT 'Typical voltage variation as a percentage of nominal voltage.',
    CONSTRAINT pk_feeder PRIMARY KEY(`feeder_id`)
) COMMENT 'Master record for each medium-voltage distribution feeder (circuit) emanating from a substation bus. Captures feeder identifier, nominal voltage (kV), rated capacity (MVA), feeder type (overhead/underground/mixed), operating territory, associated substation, protective device configuration, GIS feeder route geometry reference, SCADA tag, commissioning date, and operational status. Serves as the backbone topology anchor for the distribution network in GE PowerOn DMS and Esri ArcGIS.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` (
    `distribution_substation_id` BIGINT COMMENT 'Surrogate primary key for the distribution substation.',
    `location_id` BIGINT COMMENT 'Foreign key linking to asset.location. Business justification: Substation GIS reporting and NERC filing need a direct link to the location entity storing latitude/longitude and jurisdiction data.',
    `balancing_area_id` BIGINT COMMENT 'Foreign key linking to gridops.balancing_area. Business justification: Reliability and outage reports are generated per balancing area; substations must be linked to the area they serve.',
    `control_zone_id` BIGINT COMMENT 'Foreign key linking to gridops.control_zone. Business justification: Control zones manage voltage/frequency for groups of substations; linking enables zone‑level dispatch and SCADA coordination.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Substation capital and OPEX expenses tracked per cost center for regulatory Cost of Service reporting.',
    `network_device_id` BIGINT COMMENT 'Foreign key linking to technology.network_device. Business justification: Substations use network devices for remote telemetry; needed for SCADA integration and asset health dashboards.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Regulatory compliance and emergency response plans require substation locations to be linked to their underlying land parcels.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to regulatory.environmental_permit. Business justification: Substations need environmental permits; permits are tracked in regulatory system for compliance reporting.',
    `service_territory_id` BIGINT COMMENT 'Foreign key linking to customer.service_territory. Business justification: Regulatory Service Territory Mapping report requires each substation to be linked to a defined Service Territory entity for compliance and planning.',
    `transmission_substation_id` BIGINT COMMENT 'Foreign key linking to transmission.transmission_substation. Business justification: Required for Transmission‑Distribution Substation mapping used in power flow studies and outage coordination reports.',
    `address_line1` STRING COMMENT 'Primary street address of the substation facility.',
    `asset_manager` STRING COMMENT 'Name of the internal manager responsible for the substation asset.',
    `bus_configuration` STRING COMMENT 'Logical bus arrangement of the substation.. Valid values are `single|double|ring|breaker`',
    `city` STRING COMMENT 'City where the substation is located.',
    `commissioning_date` DATE COMMENT 'Date the substation was placed into service.',
    `country_code` STRING COMMENT 'Three‑letter ISO country code of the substation location.. Valid values are `USA|CAN|MEX`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the substation record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date the substation was retired or removed from service, if applicable.',
    `distribution_substation_status` STRING COMMENT 'Current lifecycle status of the substation.. Valid values are `active|inactive|planned|decommissioned|maintenance`',
    `gis_polygon_reference` STRING COMMENT 'Identifier of the GIS polygon that represents the substation footprint.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.. Valid values are `passed|failed|pending|not_applicable`',
    `is_critical_infrastructure` BOOLEAN COMMENT 'Indicates whether the substation is designated as critical infrastructure under CIP regulations.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the substation.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the substation center point.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the substation center point.',
    `maintenance_cycle_months` STRING COMMENT 'Planned maintenance interval in months.',
    `number_of_feeder_bays` STRING COMMENT 'Number of feeder bays available for connecting distribution feeders.',
    `number_of_transformers` STRING COMMENT 'Count of power transformers housed in the substation.',
    `owner_organization` STRING COMMENT 'Legal entity that owns the substation.',
    `postal_code` STRING COMMENT 'Postal (ZIP) code for the substation address.. Valid values are `^[0-9]{5}(-[0-9]{4})?$`',
    `regulatory_compliance_status` STRING COMMENT 'Current compliance status with applicable regulatory requirements (e.g., FERC, NERC).. Valid values are `compliant|non_compliant|exempt|pending`',
    `state_province` STRING COMMENT 'State or province of the substation location.',
    `substation_code` STRING COMMENT 'External code or NERC location identifier assigned to the substation.',
    `substation_description` STRING COMMENT 'Free‑form description providing additional context about the substation.',
    `substation_name` STRING COMMENT 'Human‑readable name of the distribution substation.',
    `substation_type` STRING COMMENT 'Classification of the substation based on its functional role.. Valid values are `distribution|intertie|switching|recloser`',
    `transformer_capacity_mva` DECIMAL(18,2) COMMENT 'Total installed transformer capacity at the substation in megavolt‑amps.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the substation record.',
    `voltage_primary_kv` DECIMAL(18,2) COMMENT 'Primary voltage level of the substation in kilovolts.',
    `voltage_secondary_kv` DECIMAL(18,2) COMMENT 'Secondary voltage level of the substation in kilovolts.',
    CONSTRAINT pk_distribution_substation PRIMARY KEY(`distribution_substation_id`)
) COMMENT 'Master record for each distribution-level substation (distinct from bulk transmission substations owned by the transmission domain). Captures substation name, NERC location identifier, address, GPS coordinates, service territory, voltage transformation levels (e.g., 69kV/12.47kV), installed transformer capacity (MVA), number of feeder bays, bus configuration (single bus/double bus/ring), SCADA connectivity status, GIS polygon reference, and commissioning date. SSOT for distribution substation identity and topology anchor within the distribution domain; serves as the root node for feeder-level network traversal. Transmission substations are owned by the transmission domain.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` (
    `distribution_service_point_id` BIGINT COMMENT 'System-generated unique identifier for the distribution service point record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Service points are customer‑facing assets; the registry link enables condition assessment and outage impact analysis.',
    `billing_account_id` BIGINT COMMENT 'Foreign key linking to billing.billing_account. Business justification: Required for Bill Generation: associates each service point with its customers billing account so the billing system can create accurate monthly bills.',
    `compliance_obligation_id` BIGINT COMMENT 'Foreign key linking to regulatory.compliance_obligation. Business justification: Service points must satisfy safety/compliance obligations; linking supports obligation tracking per point.',
    `nem_account_id` BIGINT COMMENT 'Foreign key linking to der.nem_account. Business justification: NEM settlement and regulatory filing require associating each service point with its Net Energy Metering account for accurate credit allocation.',
    `facility_id` BIGINT COMMENT 'Foreign key linking to property.facility. Business justification: Energy consumption reporting for commercial facilities tracks service points within each facility.',
    `feeder_id` BIGINT COMMENT 'Identifier of the feeder that supplies the service point.',
    `it_service_id` BIGINT COMMENT 'Foreign key linking to technology.it_service. Business justification: Service points are served by IT services (meter data collection); linking supports service performance metrics.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Routine service‑point maintenance is assigned to a specific technician; required for maintenance work orders and reliability KPI tracking.',
    `microgrid_id` BIGINT COMMENT 'Foreign key linking to der.microgrid. Business justification: Microgrid operation requires identifying service points that participate in a microgrid for islanding, load balancing, and dispatch decisions.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Regulatory reporting and outage management require linking each service point to the land parcel it serves for accurate billing and incident response.',
    `pole_id` BIGINT COMMENT 'Identifier of the pole or structure where the service point is attached.',
    `premise_id` BIGINT COMMENT 'Foreign key linking to customer.premise. Business justification: Asset Management process ties each physical distribution service point to the customer premise address for inspection scheduling and billing accuracy.',
    `product_program_id` BIGINT COMMENT 'Foreign key linking to product.product_program. Business justification: Supports Program Enrollment tracking, assigning incentive programs to service points for eligibility verification and reporting.',
    `rate_schedule_id` BIGINT COMMENT 'Foreign key linking to product.rate_schedule. Business justification: Required for Billing Rate Assignment process that maps each service point to its applicable rate schedule for invoicing and regulatory reporting.',
    `gl_account_id` BIGINT COMMENT 'Foreign key linking to finance.gl_account. Business justification: Each service point posts revenue to a specific GL account; needed for Revenue Recognition Report and billing.',
    `service_plan_id` BIGINT COMMENT 'Foreign key linking to product.service_plan. Business justification: Needed for Service Plan enrollment process, linking each service point to its selected plan for demand‑response and renewable‑energy offerings.',
    `tariff_schedule_id` BIGINT COMMENT 'Foreign key linking to regulatory.tariff_schedule. Business justification: Each service point is billed under a specific tariff schedule; required for billing and regulatory rate case reporting.',
    `vault_id` BIGINT COMMENT 'Identifier of the underground vault (if applicable) serving the service point.',
    `connection_status` STRING COMMENT 'Current electrical/gas connection state of the service point.. Valid values are `connected|disconnected|pending|planned`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the service point record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date the service point was retired or removed from service.',
    `identifier` STRING COMMENT 'External business identifier assigned to the physical delivery point.',
    `installation_date` DATE COMMENT 'Date the service point was first energized or commissioned.',
    `is_primary_service_point` BOOLEAN COMMENT 'True if this is the primary service point for the associated customer account.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the service point assets.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the service point in decimal degrees.',
    `lifecycle_status` STRING COMMENT 'Overall lifecycle state of the service point record.. Valid values are `active|inactive|retired|planned|decommissioned`',
    `load_class` STRING COMMENT 'Customer load classification used for planning and rate design.. Valid values are `residential|commercial|industrial|agricultural`',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the service point in decimal degrees.',
    `meter_socket_type` STRING COMMENT 'Physical type of the meter socket installed at the service point.. Valid values are `split-phase|single-phase|three-phase|smart|analog`',
    `nem_eligibility_flag` BOOLEAN COMMENT 'Indicates whether the service point qualifies for Net Energy Metering.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or operational notes about the service point.',
    `phase_configuration` STRING COMMENT 'Phase arrangement of the service point (single‑phase or three‑phase).. Valid values are `1PH|3PH`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'Indicates whether the service point meets all current regulatory requirements.',
    `reliability_caidi` DECIMAL(18,2) COMMENT 'Customer Average Interruption Duration Index for the service point (hours).',
    `reliability_saidi` DECIMAL(18,2) COMMENT 'System Average Interruption Duration Index for the service point (hours).',
    `reliability_saifi` DECIMAL(18,2) COMMENT 'System Average Interruption Frequency Index for the service point (interruptions per year).',
    `service_address_line1` STRING COMMENT 'Primary street address of the service point.',
    `service_address_line2` STRING COMMENT 'Secondary address information (suite, unit, etc.).',
    `service_amperage` DECIMAL(18,2) COMMENT 'Rated amperage for the service point connection.',
    `service_capacity_kw` DECIMAL(18,2) COMMENT 'Maximum electrical load capacity at the service point in kilowatts.',
    `service_capacity_mw` DECIMAL(18,2) COMMENT 'Maximum electrical load capacity at the service point in megawatts.',
    `service_city` STRING COMMENT 'City where the service point is located.',
    `service_country` STRING COMMENT 'ISO‑3166‑1 alpha‑3 country code for the service point.',
    `service_point_name` STRING COMMENT 'Human‑readable name or label for the service point used in reports and maps.',
    `service_state` STRING COMMENT 'State or province code for the service point location.',
    `service_type` STRING COMMENT 'Energy type delivered at the service point.. Valid values are `electric|gas`',
    `service_zip_code` STRING COMMENT 'Postal code for the service point address.. Valid values are `^d{5}(-d{4})?$`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the service point record.',
    `voltage_class` STRING COMMENT 'Design voltage level of the service point.. Valid values are `120V|240V|277V|480V|208V`',
    CONSTRAINT pk_distribution_service_point PRIMARY KEY(`distribution_service_point_id`)
) COMMENT 'Master record representing the physical point of delivery where the utilitys distribution network connects to a customers premises. Captures service point identifier (SPID), service address, GPS coordinates, service voltage class (120V/240V/277V/480V), phase configuration (1Φ/3Φ), load class (residential/commercial/industrial), associated feeder, transformer, and pole/vault reference, meter socket type, NEM eligibility flag, and connection status. SSOT for the physical delivery point; distinct from the customer account (owned by customer domain) and the meter device (owned by metering domain).';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` (
    `distribution_transformer_id` BIGINT COMMENT 'Unique system-generated identifier for the distribution transformer record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Regulatory asset register requires each transformer to be linked to its master asset record for compliance reporting and lifecycle tracking.',
    `distribution_service_point_id` BIGINT COMMENT 'Identifier of the service point(s) downstream of the transformer.',
    `feeder_id` BIGINT COMMENT 'Identifier of the feeder to which the transformer is assigned.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Transformer is a capital asset; link enables depreciation schedule in Fixed Asset Register.',
    `location_id` BIGINT COMMENT 'Identifier linking to the GIS spatial object for the transformer.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Transformer monitoring hardware is tracked as IT asset for maintenance schedules and regulatory audits.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Transformer inspections/repairs are technician‑driven; linking enables inspection scheduling and regulatory compliance reporting.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Spare Parts Management links transformer to its material master record, enabling inventory planning for replacement parts.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Asset tax assessment and compliance reporting need each transformer tied to the parcel where it is installed.',
    `pole_id` BIGINT COMMENT 'Identifier of the pole or structure supporting the transformer (if applicable).',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Asset Procurement & Warranty Management process records the supplying vendor for each transformer, required for NERC CIP asset inventory and warranty compliance.',
    `age_years` STRING COMMENT 'Number of years since installation (derived from installation_date).',
    `asset_condition` STRING COMMENT 'Current condition assessment of the transformer.. Valid values are `excellent|good|fair|poor|unknown`',
    `asset_tag` STRING COMMENT 'Company‑assigned tag used to uniquely identify the transformer in field operations.. Valid values are `^[A-Z0-9-]{1,20}$`',
    `average_load_kva` DECIMAL(18,2) COMMENT 'Mean apparent power drawn over the reporting period.',
    `capital_asset_number` STRING COMMENT 'Enterprise‑wide asset identifier used for financial tracking.',
    `compliance_status` STRING COMMENT 'Current compliance standing with applicable utility regulations.. Valid values are `compliant|non_compliant|pending`',
    `cooling_type` STRING COMMENT 'Cooling method employed by the transformer.. Valid values are `onan|onaf|forced_air|oil_immersed`',
    `cost_basis_usd` DECIMAL(18,2) COMMENT 'Capital cost of the transformer in US dollars.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the transformer record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date the transformer was removed from service (if applicable).',
    `depreciation_years` STRING COMMENT 'Number of years over which the asset is depreciated for accounting.',
    `distribution_transformer_name` STRING COMMENT 'Human‑readable name or label for the transformer (e.g., "Transformer A12").',
    `distribution_transformer_status` STRING COMMENT 'Current operational status of the transformer.. Valid values are `in_service|out_of_service|retired|maintenance`',
    `installation_date` DATE COMMENT 'Date the transformer was placed into service.',
    `installation_type` STRING COMMENT 'How the transformer is installed within the distribution network.. Valid values are `overhead|underground|substation`',
    `installation_year` STRING COMMENT 'Calendar year the transformer was installed (derived from installation_date).',
    `is_automated` BOOLEAN COMMENT 'True if the transformer is equipped with remote monitoring/smart sensors.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the transformer is deemed critical for reliability (True) or not (False).',
    `is_transformer_protected` BOOLEAN COMMENT 'True if the transformer is protected against vandalism or environmental hazards.',
    `is_under_warranty` BOOLEAN COMMENT 'Indicates whether the transformer is still under manufacturer warranty.',
    `last_inspection_date` DATE COMMENT 'Most recent date a physical inspection was performed.',
    `last_maintenance_date` DATE COMMENT 'Most recent date preventive or corrective maintenance was performed.',
    `last_regulatory_inspection_date` DATE COMMENT 'Date of the most recent regulatory compliance inspection.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the transformer location (WGS‑84).',
    `load_factor_percent` DECIMAL(18,2) COMMENT 'Average load as a percentage of nameplate rating.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the transformer location (WGS‑84).',
    `max_load_kva` DECIMAL(18,2) COMMENT 'Peak apparent power recorded for the transformer.',
    `model_number` STRING COMMENT 'Manufacturer‑assigned model designation.',
    `notes` STRING COMMENT 'Free‑form text for additional remarks or observations.',
    `phase_configuration` STRING COMMENT 'Electrical phase arrangement of the transformer.. Valid values are `single_phase|three_phase`',
    `primary_voltage_kv` DECIMAL(18,2) COMMENT 'Rated primary (high) voltage of the transformer in kilovolts.',
    `rating_kva` DECIMAL(18,2) COMMENT 'Nameplate apparent power rating of the transformer in kilovolt‑amps.',
    `secondary_voltage_kv` DECIMAL(18,2) COMMENT 'Rated secondary (low) voltage of the transformer in kilovolts.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the transformer.. Valid values are `^[A-Z0-9]{1,30}$`',
    `tap_position` STRING COMMENT 'Current tap position setting for voltage regulation.',
    `transformer_type` STRING COMMENT 'Physical configuration of the transformer (pad‑mount, pole‑mount, vault, or underground).. Valid values are `pad_mount|pole_mount|vault|underground`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the transformer record.',
    `voltage_regulation_percent` DECIMAL(18,2) COMMENT 'Typical voltage regulation percentage of the transformer under load.',
    `warranty_expiration_date` DATE COMMENT 'Date when the warranty coverage ends.',
    CONSTRAINT pk_distribution_transformer PRIMARY KEY(`distribution_transformer_id`)
) COMMENT 'Master record for each pad-mount, pole-mount, or vault distribution transformer on the medium-to-low voltage network. Captures transformer identifier, kVA rating, primary/secondary voltage, phase configuration, cooling type (ONAN/ONAF), installation type (overhead/underground), GIS location coordinates, pole or structure reference, feeder assignment, manufacturer, model, serial number, installation date, and operational status. Distinct from transmission transformers (owned by transmission domain) and the enterprise asset record (owned by asset domain); this record captures distribution-network topology context.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`pole` (
    `pole_id` BIGINT COMMENT 'System-generated unique identifier for each pole record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Poles are capital assets; linking to the asset registry enables inventory, depreciation, and maintenance scheduling.',
    `feeder_id` BIGINT COMMENT 'Identifier of the feeder to which the pole belongs.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Poles are capitalized; linking to Fixed Asset allows depreciation and asset tracking per regulatory requirements.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Pole condition inspections are performed by field technicians; required for asset health dashboards and outage prevention plans.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Pole inventory uses material master to standardize part numbers, supporting inventory replenishment.',
    `network_device_id` BIGINT COMMENT 'Foreign key linking to technology.network_device. Business justification: Smart poles host IoT/network devices; linking supports smart‑grid communication management.',
    `parcel_id` BIGINT COMMENT 'Foreign key linking to property.parcel. Business justification: Right‑of‑way and maintenance scheduling depend on knowing the parcel that owns each pole.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Pole Procurement process captures the vendor supplying each pole, needed for vendor performance analysis and warranty tracking.',
    `ansi_class` STRING COMMENT 'ANSI class rating (1‑7) indicating pole strength and load capability.',
    `asset_status` STRING COMMENT 'Current operational status of the pole.. Valid values are `in_service|retired|out_of_service|planned`',
    `asset_tag` STRING COMMENT 'External asset tag or barcode assigned to the pole for inventory tracking.',
    `attachment_count` STRING COMMENT 'Number of conductors, hardware, or devices attached to the pole.',
    `commissioning_date` DATE COMMENT 'Date the pole entered service.',
    `condition_rating` STRING COMMENT 'Overall condition assessment of the pole.. Valid values are `good|fair|poor|critical|unknown`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the pole record was first created in the system.',
    `datum` STRING COMMENT 'Reference datum for the geographic coordinates (e.g., NAD83).',
    `decommission_date` DATE COMMENT 'Date the pole was removed from service.',
    `elevation_ft` DECIMAL(18,2) COMMENT 'Elevation of the pole above mean sea level.',
    `gps_accuracy_m` DECIMAL(18,2) COMMENT 'Estimated positional accuracy of the GPS coordinates.',
    `height_ft` DECIMAL(18,2) COMMENT 'Physical height of the pole measured in feet.',
    `installation_year` STRING COMMENT 'Calendar year the pole was installed.',
    `joint_use_flag` BOOLEAN COMMENT 'Indicates whether the pole is shared with other utilities.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent condition inspection.',
    `last_storm_event_date` DATE COMMENT 'Date of the most recent storm event affecting the pole.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the pole location.',
    `loading_capacity_pct` DECIMAL(18,2) COMMENT 'Maximum permissible load as a percentage of design capacity.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the pole location.',
    `maintenance_due_date` DATE COMMENT 'Planned date for the next maintenance activity.',
    `maintenance_status` STRING COMMENT 'Current status of scheduled maintenance for the pole.. Valid values are `scheduled|completed|overdue|not_required`',
    `municipality` STRING COMMENT 'Municipality or city where the pole is located.',
    `owner_type` STRING COMMENT 'Ownership classification of the pole.. Valid values are `utility|joint_use|third_party`',
    `pole_name` STRING COMMENT 'Human‑readable name or label for the pole used in work orders and field maps.',
    `record_source_system` STRING COMMENT 'Name of the source system that supplied the pole data (e.g., GE PowerOn DMS).',
    `replacement_year_estimate` STRING COMMENT 'Projected year when the pole will need replacement based on lifecycle analysis.',
    `storm_damage_flag` BOOLEAN COMMENT 'True if the pole has reported storm‑related damage.',
    `structure_type` STRING COMMENT 'Category of the distribution structure (e.g., pole, vault, manhole, pedestal, riser).. Valid values are `pole|vault|manhole|pedestal|riser`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the pole record.',
    `voltage_rating_kv` DECIMAL(18,2) COMMENT 'Maximum voltage the pole is rated to support.',
    CONSTRAINT pk_pole PRIMARY KEY(`pole_id`)
) COMMENT 'Master record for each utility-owned distribution structure supporting overhead and underground infrastructure, including poles, vaults, manholes, and pedestals. Captures structure identifier, structure type (pole/vault/manhole/pedestal/riser), GIS coordinates, pole class (ANSI class 1–7 for poles), height (ft), material (wood/steel/concrete/composite/fiberglass), owner (utility/joint-use/third-party), installation year, last inspection date, condition rating, loading capacity (%), number of attachments, associated feeder, and municipality. Supports joint-use attachment management, storm damage assessment, underground access point tracking, and serves as the node element in the distribution network topology (conductor spans connect between structures).';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`protective_device` (
    `protective_device_id` BIGINT COMMENT 'System-generated unique identifier for the protective device record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Protective devices are tracked as assets for reliability studies and regulatory compliance; a FK to registry provides the required traceability.',
    `feeder_id` BIGINT COMMENT 'Identifier of the feeder segment to which the device is attached.',
    `technician_id` BIGINT COMMENT 'Foreign key linking to workforce.technician. Business justification: Protective devices need periodic testing by qualified technicians; link supports test‑record tracking and NERC compliance.',
    `primary_upstream_device_protective_device_id` BIGINT COMMENT 'Protective device located electrically upstream in the network.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Links protective device to purchase order for capital cost tracking and audit.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: Protective devices are configured and operated via SCADA; linking enables protection scheme validation reports.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Protective Device procurement records vendor for each device, supporting compliance reporting and warranty management.',
    `asset_category` STRING COMMENT 'High‑level categorization of the asset within the utilitys asset hierarchy.',
    `asset_classification` STRING COMMENT 'Criticality or importance classification (e.g., critical, non‑critical).',
    `commissioning_date` DATE COMMENT 'Date the device entered operational service after testing.',
    `control_mode` STRING COMMENT 'Operational control mode of the device.. Valid values are `fixed|automatic|scada_controlled`',
    `coordination_group` STRING COMMENT 'Group identifier used for protection coordination studies.',
    `current_class` STRING COMMENT 'Current classification of the device (low, medium, high).',
    `decommission_date` DATE COMMENT 'Date the device was retired or removed from service.',
    `device_code` STRING COMMENT 'Internal code used to uniquely identify the device within the distribution network.',
    `device_type` STRING COMMENT 'Category of the protective device indicating its primary function.. Valid values are `recloser|sectionalizer|fuse|automated_switch|capacitor_bank`',
    `fault_current_rating_ka` DECIMAL(18,2) COMMENT 'Maximum fault current the device is designed to withstand.',
    `installation_date` DATE COMMENT 'Date the device was first installed in service.',
    `last_maintenance_date` DATE COMMENT 'Date of the most recent preventive maintenance activity.',
    `last_test_date` DATE COMMENT 'Most recent date a functional test was performed.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the device location.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the device location.',
    `maintenance_interval_days` STRING COMMENT 'Standard interval between preventive maintenance events.',
    `model_number` STRING COMMENT 'Model identifier assigned by the manufacturer.',
    `next_maintenance_due` DATE COMMENT 'Scheduled date for the next maintenance based on interval.',
    `notes` STRING COMMENT 'Free‑form field for additional remarks or observations.',
    `number_of_steps` STRING COMMENT 'Count of discrete switching steps (relevant for multi‑step capacitor banks).',
    `operational_status` STRING COMMENT 'Current operational state of the device.. Valid values are `in_service|out_of_service|maintenance|decommissioned`',
    `protection_scheme` STRING COMMENT 'Protection principle applied (e.g., overcurrent, distance, differential).',
    `protective_device_name` STRING COMMENT 'Human‑readable name or label for the protective device.',
    `rated_interrupting_current_ka` DECIMAL(18,2) COMMENT 'Maximum fault current the device can safely interrupt, expressed in kilo‑amperes.',
    `rated_kvar` DECIMAL(18,2) COMMENT 'Maximum reactive power rating for capacitor banks, in kilovolt‑amperes reactive.',
    `rated_voltage_kv` DECIMAL(18,2) COMMENT 'Nominal operating voltage rating of the device in kilovolts.',
    `record_created_timestamp` TIMESTAMP COMMENT 'Timestamp when the protective device record was first created in the system.',
    `record_updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the protective device record.',
    `remote_operation_mode` STRING COMMENT 'Specifies if the device is normally operated remotely or manually.. Valid values are `remote|manual`',
    `scada_controllable_flag` BOOLEAN COMMENT 'Indicates whether the device can be operated directly from SCADA.',
    `serial_number` STRING COMMENT 'Unique serial number stamped on the device hardware.',
    `sub_type` STRING COMMENT 'More specific classification within the device type, e.g., "single‑phase recloser".',
    `switching_operations_count` BIGINT COMMENT 'Cumulative count of switching actions performed by the device.',
    `voltage_class` STRING COMMENT 'Voltage classification of the device (low, medium, high).',
    CONSTRAINT pk_protective_device PRIMARY KEY(`protective_device_id`)
) COMMENT 'Master record for distribution-level protective and switching devices including reclosers, sectionalizers, fuses, automated switches, and capacitor banks. Captures device identifier, device type/subtype (protective/switching/reactive compensation), manufacturer, model, rated interrupting current (kA) or rated kVAR, rated voltage (kV), number of steps (for capacitor banks), control mode (fixed/automatic/SCADA-controlled), SCADA-controllable flag, remote/manual operation mode, GIS location, associated feeder segment, upstream/downstream connectivity references, installation date, last test/maintenance date, switching operations count, and operational status. Critical for fault isolation modeling, FLISR automation in GE PowerOn DMS, volt/VAR optimization (VVO), and SAIDI/SAIFI improvement through automated switching.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`gas_main` (
    `gas_main_id` BIGINT COMMENT 'Unique system-generated identifier for the gas main record.',
    `registry_id` BIGINT COMMENT 'Foreign key linking to asset.registry. Business justification: Gas mains are high‑value assets; linking to the master asset register supports PHMSA reporting and capital planning.',
    `fixed_asset_id` BIGINT COMMENT 'Foreign key linking to finance.fixed_asset. Business justification: Gas mains are capital assets; link supports depreciation and asset accounting in Fixed Asset system.',
    `gas_pressure_district_id` BIGINT COMMENT 'FK to distribution.gas_pressure_district',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Gas‑main maintenance is crew‑based; crew_id enables work‑order assignment, safety tracking, and PHMSA reporting.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Associates gas main with purchase order for cost tracking and compliance.',
    `environmental_permit_id` BIGINT COMMENT 'Foreign key linking to regulatory.environmental_permit. Business justification: Gas mains require environmental permits; linking enables audit of permit status per asset.',
    `scada_system_id` BIGINT COMMENT 'Foreign key linking to technology.scada_system. Business justification: SCADA monitors gas pipeline pressure and flow, essential for NERC compliance and leak detection.',
    `gas_network_node_id` BIGINT COMMENT 'Identifier of the upstream network node where the gas main begins.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Gas Main procurement records supplier vendor, required for regulatory reporting and asset lifecycle management.',
    `asset_condition` STRING COMMENT 'Current physical condition of the gas main.. Valid values are `good|fair|poor|critical`',
    `asset_tag` STRING COMMENT 'Company‑wide asset tag or code used to reference the gas main in work orders and inventory.',
    `cathodic_protection_zone` STRING COMMENT 'Identifier of the cathodic protection zone covering the pipe.',
    `coating_type` STRING COMMENT 'External coating applied to the pipe for corrosion protection.. Valid values are `epoxy|polyethylene|none`',
    `corrosion_rate_mpy` DECIMAL(18,2) COMMENT 'Measured corrosion rate in mils per year.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the gas main record was first created in the system.',
    `decommission_date` DATE COMMENT 'Date on which the gas main was officially taken out of service.',
    `design_pressure_psi` DECIMAL(18,2) COMMENT 'Maximum pressure the pipe was designed to safely contain.',
    `end_node_code` BIGINT COMMENT 'Identifier of the downstream network node where the gas main terminates.',
    `gas_main_name` STRING COMMENT 'Human‑readable name or label for the gas main segment.',
    `gis_geometry_reference` BIGINT COMMENT 'Reference to the GIS feature storing the line geometry of the gas main.',
    `installation_year` STRING COMMENT 'Calendar year the gas main was installed.',
    `last_leak_survey_date` DATE COMMENT 'Date of the most recent leak detection survey.',
    `leak_survey_class` STRING COMMENT 'Regulatory class for leak survey frequency and methodology.. Valid values are `class_a|class_b|class_c`',
    `length_ft` DECIMAL(18,2) COMMENT 'Total linear length of the gas main segment in feet.',
    `maintenance_priority` STRING COMMENT 'Priority level for scheduled maintenance activities.. Valid values are `high|medium|low`',
    `material_grade` STRING COMMENT 'Specific grade or specification of the pipe material.',
    `max_operating_pressure_psi` DECIMAL(18,2) COMMENT 'Highest recorded operating pressure for the gas main.',
    `min_operating_pressure_psi` DECIMAL(18,2) COMMENT 'Lowest recorded operating pressure for the gas main.',
    `municipality` STRING COMMENT 'Local municipality where the gas main is located.',
    `next_leak_survey_due` DATE COMMENT 'Scheduled date for the next required leak survey.',
    `nominal_diameter_in` DECIMAL(18,2) COMMENT 'Standard inside diameter of the pipe in inches.',
    `notes` STRING COMMENT 'Free‑form text field for additional comments or observations.',
    `operating_pressure_psi` DECIMAL(18,2) COMMENT 'Current operating pressure of the gas main in pounds per square inch.',
    `operational_status` STRING COMMENT 'Current operational state of the gas main.. Valid values are `in_service|out_of_service|planned_retirement|decommissioned`',
    `pressure_class` STRING COMMENT 'Designated pressure class: Low (LP), Medium (MP) or High (HP).. Valid values are `LP|MP|HP`',
    `risk_score` DECIMAL(18,2) COMMENT 'Composite risk rating used for integrity management prioritization.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the gas main record.',
    `wall_thickness_mm` DECIMAL(18,2) COMMENT 'Measured wall thickness of the pipe in millimetres.',
    `year_of_last_inspection` STRING COMMENT 'Calendar year when the most recent physical inspection was performed.',
    CONSTRAINT pk_gas_main PRIMARY KEY(`gas_main_id`)
) COMMENT 'Master record for natural gas distribution main pipeline segments. Captures main identifier, GIS line geometry reference, pipe material (steel/PE/cast iron), nominal diameter (inches), operating pressure class (LP/MP/HP), installation year, coating type, cathodic protection zone, leak survey class, associated pressure district, municipality, and operational status. SSOT for gas distribution pipeline topology; supports PHMSA integrity management and leak survey scheduling.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` (
    `gas_service_line_id` BIGINT COMMENT 'Unique surrogate key for each gas service line record.',
    `distribution_service_point_id` BIGINT COMMENT 'Reference to the service point (customer connection) served by this line.',
    `gas_main_id` BIGINT COMMENT 'Identifier of the upstream gas main to which this service line connects.',
    `location_id` BIGINT COMMENT 'Reference to the geographic location record (e.g., substation, region).',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Service‑line repairs are performed by crews; linking supports outage management and regulatory leak‑survey coordination.',
    `meter_set_id` BIGINT COMMENT 'Reference to the meter set assembly attached to the service line.',
    `pm_schedule_id` BIGINT COMMENT 'Reference to the planned maintenance schedule for the line.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Links service line to purchase order for financial tracking.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Gas Service Line supplier vendor captured for procurement compliance and performance monitoring.',
    `asset_owner` STRING COMMENT 'Internal department or business unit responsible for the line.',
    `compliance_flag` BOOLEAN COMMENT 'Indicates whether the line currently meets PHMSA regulatory requirements.',
    `condition_rating` STRING COMMENT 'Numeric rating (1‑5) of the lines physical condition.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the record was first created in the data lake.',
    `decommission_date` DATE COMMENT 'Date the line was removed from service, if applicable.',
    `diameter_in` DOUBLE COMMENT 'Nominal inner diameter of the pipe in inches.',
    `elevation_ft` DOUBLE COMMENT 'Elevation above sea level at the lines midpoint, in feet.',
    `external_reference_number` STRING COMMENT 'Regulatory filing or permit number associated with the line.',
    `gas_service_line_status` STRING COMMENT 'Current lifecycle state of the service line.. Valid values are `active|inactive|retired|suspended|planned`',
    `geometry_wkt` STRING COMMENT 'Well‑Known Text representation of the lines spatial path.',
    `inspection_status` STRING COMMENT 'Current status of the last inspection.. Valid values are `passed|failed|pending|deferred`',
    `installation_year` STRING COMMENT 'Calendar year the service line was placed in service.',
    `is_critical_infrastructure` BOOLEAN COMMENT 'Indicates if the line is designated as critical infrastructure under CIP regulations.',
    `is_under_pressure_test` BOOLEAN COMMENT 'True if the line is currently undergoing a pressure test.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent visual or non‑destructive inspection.',
    `last_maintenance_date` DATE COMMENT 'Date the line most recently underwent scheduled maintenance.',
    `last_pressure_test_pressure` DOUBLE COMMENT 'Measured pressure during the most recent pressure test (psig).',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the lines midpoint.',
    `leak_survey_date` DATE COMMENT 'Date of the most recent PHMSA‑required leak detection survey.',
    `leak_survey_notes` STRING COMMENT 'Free‑form notes captured during the leak survey.',
    `leak_survey_result` STRING COMMENT 'Outcome of the latest leak survey.. Valid values are `pass|fail|not_applicable`',
    `length_ft` DOUBLE COMMENT 'Total installed length of the service line in feet.',
    `line_code` STRING COMMENT 'External code assigned by the utility (e.g., GIS asset number) that uniquely identifies the line in field systems.',
    `line_name` STRING COMMENT 'Human‑readable name or label for the gas service line used in operations and GIS displays.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the lines midpoint.',
    `material_grade` STRING COMMENT 'Standard grade or specification of the pipe material (e.g., ASTM A53).',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next scheduled maintenance activity.',
    `operating_pressure_psig` DOUBLE COMMENT 'Design or current operating pressure of the line in pounds per square inch gauge.',
    `pressure_test_date` DATE COMMENT 'Date the line was last pressure‑tested.',
    `pressure_test_result` STRING COMMENT 'Result of the most recent pressure test.. Valid values are `pass|fail|not_tested`',
    `retirement_reason` STRING COMMENT 'Reason for retiring or decommissioning the line (e.g., corrosion, replacement).',
    `risk_classification` STRING COMMENT 'Risk level assigned based on condition, location, and operating parameters.. Valid values are `low|medium|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the record.',
    CONSTRAINT pk_gas_service_line PRIMARY KEY(`gas_service_line_id`)
) COMMENT 'Master record for individual natural gas service lines connecting the gas main to a customers meter set. Captures service line identifier, GIS geometry, pipe material, diameter (inches), operating pressure (psig), service line length (ft), associated gas main, service point reference, meter set assembly reference, installation year, and operational status. Supports PHMSA leak survey, pressure testing records, and customer connection management.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` (
    `distribution_outage_event_id` BIGINT COMMENT 'System‑generated unique identifier for the outage event record.',
    `crew_id` BIGINT COMMENT 'Reference to the crew dispatch record that performed restoration work.',
    `docket_id` BIGINT COMMENT 'Foreign key linking to regulatory.docket. Business justification: Major outage events are reported in regulatory dockets; linkage enables automated docket creation and status tracking.',
    `generation_outage_id` BIGINT COMMENT 'Foreign key linking to generation.generation_outage. Business justification: Supports Distribution Outage Impact Attribution report, linking each outage event to the upstream generation outage that caused it for regulatory reporting.',
    `gridops_outage_event_id` BIGINT COMMENT 'Foreign key linking to gridops.gridops_outage_event. Business justification: Integrated outage management requires correlating distribution and transmission outage events for unified reporting and restoration planning.',
    `incident_id` BIGINT COMMENT 'Foreign key linking to safety.incident. Business justification: Regulatory outage reporting requires linking each outage event to the safety incident record for NERC/OSHA compliance.',
    `incident_ticket_id` BIGINT COMMENT 'Foreign key linking to technology.incident_ticket. Business justification: Outage events generate IT incident tickets for resolution tracking and service level reporting.',
    `cost_center_id` BIGINT COMMENT 'Foreign key linking to finance.cost_center. Business justification: Outage events cost allocation to a cost center is required for Outage Cost Analysis and regulatory reporting.',
    `protective_device_id` BIGINT COMMENT 'Identifier of the protective device (breaker, recloser) that operated to isolate the fault.',
    `resource_id` BIGINT COMMENT 'Foreign key linking to der.der_resource. Business justification: Reliability reports and SAIDI/SAIFI calculations need to capture which DER contributed to or were affected by a distribution outage.',
    `storm_event_id` BIGINT COMMENT 'Identifier of the associated storm event, if the outage is storm‑related.',
    `work_order_id` BIGINT COMMENT 'Link to the work order generated for outage restoration activities.',
    `actual_customers_affected` STRING COMMENT 'Final count of customers who experienced interruption.',
    `actual_duration_minutes` STRING COMMENT 'Measured outage duration in minutes from start to restoration.',
    `affected_feeder_ids` STRING COMMENT 'Comma‑separated list of feeder identifiers impacted by the outage.',
    `caidi_contribution` DECIMAL(18,2) COMMENT 'Average interruption duration contributed by this event to the Customer Average Interruption Duration Index.',
    `cause_code` STRING COMMENT 'Root‑cause code describing why the outage occurred, aligned with utility standard cause taxonomy.. Valid values are `weather|equipment_failure|animal|vegetation|third_party|unknown`',
    `customer_notification_status` STRING COMMENT 'Indicates whether affected customers were notified about the outage.. Valid values are `notified|not_notified|partial`',
    `distribution_outage_event_description` STRING COMMENT 'Free‑form text describing the outage circumstances, equipment involved, or special notes.',
    `distribution_outage_event_status` STRING COMMENT 'Current lifecycle status of the outage event.. Valid values are `open|in_progress|closed|cancelled`',
    `estimated_customers_affected` STRING COMMENT 'Projected number of customers impacted at outage initiation.',
    `estimated_duration_minutes` STRING COMMENT 'Planned outage duration in minutes, used for crew planning.',
    `ieee_1366_exclusion_flag` BOOLEAN COMMENT 'True if the event is excluded from IEEE 1366 reliability calculations (e.g., major event day).',
    `location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the primary outage location (WGS84).',
    `location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the primary outage location (WGS84).',
    `outage_end_timestamp` TIMESTAMP COMMENT 'Date‑time when service was fully restored.',
    `outage_event_number` STRING COMMENT 'External business identifier assigned to the outage event, used in operational reports and regulatory filings.',
    `outage_start_timestamp` TIMESTAMP COMMENT 'Date‑time when the outage began (actual or scheduled start).',
    `outage_type` STRING COMMENT 'Classification of the outage as planned, unplanned, or momentary.. Valid values are `planned|unplanned|momentary`',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the outage record was first created in the data lake.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the outage record.',
    `region_code` STRING COMMENT 'Three‑letter code representing the utility service region where the outage occurred.',
    `saidi_contribution` DECIMAL(18,2) COMMENT 'Customer‑minutes of interruption contributed by this event to the System Average Interruption Duration Index.',
    `saifi_contribution` DECIMAL(18,2) COMMENT 'Customer interruptions contributed by this event to the System Average Interruption Frequency Index.',
    `updated_by` STRING COMMENT 'User or system account that performed the latest update.',
    `created_by` STRING COMMENT 'User or system account that created the outage record.',
    CONSTRAINT pk_distribution_outage_event PRIMARY KEY(`distribution_outage_event_id`)
) COMMENT 'Transactional record for each discrete electric distribution outage event (planned or unplanned) managed in GE PowerOn OMS. Captures outage event identifier, outage type (planned/unplanned/momentary), cause code (weather/equipment failure/animal/vegetation/third-party/unknown), affected feeder(s), protective device that operated, estimated and actual customers affected, outage start and restoration timestamps, outage duration (minutes), crew dispatch reference, customer notification status, associated work order reference, SAIDI/SAIFI/CAIDI contribution values (customer minutes interrupted per event), IEEE 1366 major event day exclusion flag, and storm event association. Includes detail-level affected customer/service point records with individual customer minutes interrupted (CMI). Primary source for calculating SAIDI/SAIFI/CAIDI reliability indices, PUC reliability reporting, storm restoration performance tracking, and customer outage history. Retains all raw data needed for IEEE 1366 reliability index computation.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` (
    `distribution_switching_order_id` BIGINT COMMENT 'System-generated unique identifier for the switching order record.',
    `approved_by_operator_employee_id` BIGINT COMMENT 'Identifier of the operator who approved the switching order before execution.',
    `change_request_id` BIGINT COMMENT 'Foreign key linking to technology.change_request. Business justification: Switching orders are processed as change requests in IT change management, required for audit trails.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Switching orders are executed by a field crew; crew_id links order to crew for work‑order tracking and compliance reporting.',
    `distribution_outage_event_id` BIGINT COMMENT 'Identifier linking the switching order to the associated outage event record.',
    `employee_id` BIGINT COMMENT 'Identifier of the operator who created/issued the switching order.',
    `gridops_switching_order_id` BIGINT COMMENT 'Foreign key linking to gridops.gridops_switching_order. Business justification: Coordinated switching between distribution and transmission assets is tracked via a cross‑reference in the switching order workflow.',
    `technician_id` BIGINT COMMENT 'Identifier of the operator who created/issued the switching order.',
    `actual_customers_affected` STRING COMMENT 'Number of customer service points that experienced outage during execution.',
    `actual_end_timestamp` TIMESTAMP COMMENT 'Real‑time timestamp when the switching operation completed.',
    `actual_outage_duration_minutes` STRING COMMENT 'Measured total outage duration in minutes for the affected customers.',
    `actual_start_timestamp` TIMESTAMP COMMENT 'Real‑time timestamp when the switching operation actually began.',
    `affected_feeder_ids` STRING COMMENT 'Comma‑separated list of feeder identifiers impacted by the switching order.',
    `completion_status` STRING COMMENT 'Result of the switching operation: fully successful, partially successful, or failed.. Valid values are `success|partial|failed`',
    `creation_timestamp` TIMESTAMP COMMENT 'Date and time when the switching order record was first created in the system.',
    `distribution_switching_order_status` STRING COMMENT 'Current lifecycle status of the switching order.. Valid values are `draft|approved|in_progress|completed|cancelled`',
    `estimated_customers_affected` STRING COMMENT 'Projected number of customer service points that will lose service during the switching operation.',
    `estimated_outage_duration_minutes` STRING COMMENT 'Projected total outage duration in minutes for the affected customers.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the order is classified as critical for system reliability.',
    `last_update_timestamp` TIMESTAMP COMMENT 'Date and time of the most recent modification to the switching order record.',
    `order_number` STRING COMMENT 'External business identifier assigned to the switching order, used in operations and reporting.',
    `order_type` STRING COMMENT 'Classifies the order as planned, emergency, or automated Fault‑Location‑Isolation‑Service‑Restoration (FLISR).. Valid values are `planned|emergency|flisr`',
    `planned_end_timestamp` TIMESTAMP COMMENT 'Scheduled end time for the switching operation as planned by the dispatcher.',
    `planned_start_timestamp` TIMESTAMP COMMENT 'Scheduled start time for the switching operation as planned by the dispatcher.',
    `priority` STRING COMMENT 'Operational priority assigned to the order to guide scheduling.. Valid values are `high|medium|low`',
    `regulatory_compliance_flag` BOOLEAN COMMENT 'True if the order meets all applicable regulatory requirements (e.g., FERC, NERC).',
    `remarks` STRING COMMENT 'Free‑form notes entered by operators or supervisors about the order.',
    `safety_clearance_reference` STRING COMMENT 'Reference to the safety clearance document or ticket authorizing the switching activity.',
    `switching_step_count` STRING COMMENT 'Total number of individual open/close steps executed in this order.',
    `switching_steps_detail` STRING COMMENT 'JSON‑encoded list of steps (device tag, operation type, sequence number) performed.',
    `work_order_reference` STRING COMMENT 'Reference to the associated work order that initiates this switching activity.',
    CONSTRAINT pk_distribution_switching_order PRIMARY KEY(`distribution_switching_order_id`)
) COMMENT 'Transactional record for planned or emergency switching operations executed on the distribution network. Captures switching order number, order type (planned/emergency/FLISR), initiating work order reference, issuing operator, approved-by operator, planned execution window, actual start/end timestamps, list of switching steps (device tag, operation type open/close, sequence number), safety clearance reference, affected feeder(s), estimated customer impact, and completion status. Sourced from GE PowerOn DMS switching order module; critical for safe switching compliance and outage coordination.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` (
    `gas_pressure_district_id` BIGINT COMMENT 'Unique surrogate key for the gas pressure district.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the district record was first created in the lakehouse.',
    `data_source_record_reference` STRING COMMENT 'Identifier of the source record in the originating system.',
    `data_source_system` STRING COMMENT 'Name of the operational system that supplied the record (e.g., "GE PowerOn DMS").',
    `district_code` STRING COMMENT 'Business identifier code assigned to the district (e.g., "GPD‑001").',
    `district_manager_contact_phone` STRING COMMENT 'Primary contact phone number for the district manager.',
    `district_manager_email` STRING COMMENT 'Email address of the district manager.',
    `district_manager_name` STRING COMMENT 'Name of the manager responsible for the district.',
    `district_name` STRING COMMENT 'Human‑readable name of the gas pressure district.',
    `effective_end_date` DATE COMMENT 'Date on which the district was retired or re‑classified (null if still active).',
    `effective_start_date` DATE COMMENT 'Date on which the district became operational.',
    `emergency_isolation_plan_available` BOOLEAN COMMENT 'True if a documented emergency isolation plan exists for the district.',
    `gas_pressure_district_status` STRING COMMENT 'Current operational status of the pressure district.. Valid values are `active|inactive|planned|decommissioned`',
    `geographic_boundary_wkt` STRING COMMENT 'Well‑Known Text representation of the districts polygon boundary.',
    `geometry_type` STRING COMMENT 'Type of GIS geometry used for the district boundary.. Valid values are `polygon|multipolygon`',
    `last_pressure_audit_date` DATE COMMENT 'Date of the most recent pressure integrity audit.',
    `notes` STRING COMMENT 'Free‑form field for additional comments or observations.',
    `number_of_customers_served` STRING COMMENT 'Count of end‑use customers whose service connections lie within the district.',
    `operating_pressure_max_psig` DECIMAL(18,2) COMMENT 'Maximum authorized operating pressure for the district, expressed in pounds per square inch gauge.',
    `operating_pressure_min_psig` DECIMAL(18,2) COMMENT 'Minimum authorized operating pressure for the district, expressed in pounds per square inch gauge.',
    `phmsa_compliant` BOOLEAN COMMENT 'Indicates whether the district meets PHMSA integrity management requirements.',
    `pressure_class` STRING COMMENT 'Classification of the district based on operating pressure range.. Valid values are `LP|MP|HP`',
    `pressure_monitoring_system_installed` BOOLEAN COMMENT 'True if real‑time pressure monitoring equipment is installed in the district.',
    `pressure_unit` STRING COMMENT 'Unit of measure used for pressure values in this record.. Valid values are `psig|kPa`',
    `regulating_station_ids` STRING COMMENT 'Comma‑separated list of identifiers for pressure regulating stations that bound the district.',
    `regulating_station_locations` STRING COMMENT 'Human‑readable description of the geographic locations of the regulating stations.',
    `regulatory_reporting_status` STRING COMMENT 'Current status of required regulatory filings for the district.. Valid values are `compliant|non_compliant|pending`',
    `service_area_code` STRING COMMENT 'Code representing the broader service area or region containing the district.',
    `total_main_miles` DECIMAL(18,2) COMMENT 'Total length of primary gas mains (in miles) that run within the district.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the district record.',
    CONSTRAINT pk_gas_pressure_district PRIMARY KEY(`gas_pressure_district_id`)
) COMMENT 'Master record defining a gas pressure district — a contiguous section of the gas distribution network operating at a common pressure level, bounded by pressure regulating stations (PRS). Captures district identifier, district name, operating pressure range (psig), pressure class (LP/MP/HP), associated regulating station identifiers and locations, geographic boundary (GIS polygon), number of customers served, total main miles, and operational status. SSOT for gas network pressure zone topology; supports PHMSA integrity management, pressure monitoring compliance, and emergency isolation planning.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` (
    `gas_leak_survey_id` BIGINT COMMENT 'Unique system-generated identifier for each gas leak survey record.',
    `registry_id` BIGINT COMMENT 'Unique identifier of the gas main or service line surveyed.',
    `crew_id` BIGINT COMMENT 'Internal identifier of the crew that performed the survey.',
    `gas_main_id` BIGINT COMMENT 'Foreign key linking to distribution.gas_main. Business justification: gas_leak_survey.gas_asset_id refers to the gas asset surveyed. Linking to gas_main provides a clear relationship and eliminates the ambiguous column.',
    `asset_identifier` STRING COMMENT 'Human‑readable tag or code assigned to the gas pipe (e.g., "GAS‑P‑12345").',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the survey record was first entered into the system.',
    `data_source_system` STRING COMMENT 'Originating operational system (e.g., GE PowerOn, ArcGIS).',
    `follow_up_required` BOOLEAN COMMENT 'Indicates whether corrective action is mandated after the survey.',
    `gps_accuracy_meters` DECIMAL(18,2) COMMENT 'Estimated positional accuracy of the recorded latitude/longitude.',
    `instrument_type` STRING COMMENT 'Technology used to detect leaks during the survey.. Valid values are `infrared|ultrasonic|sniffer|laser|visual`',
    `jurisdiction` STRING COMMENT 'Two‑letter state or province code where the survey was performed.',
    `leak_classification` STRING COMMENT 'Severity grade of the most significant leak found, per PHMSA guidelines.. Valid values are `grade1|grade2|grade3`',
    `leak_indication_count` STRING COMMENT 'Total count of leak indications detected during the survey.',
    `location_latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the surveyed point, expressed in decimal degrees.',
    `location_longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the surveyed point, expressed in decimal degrees.',
    `notes` STRING COMMENT 'Free‑form observations or comments recorded by the crew.',
    `pressure_psi` DECIMAL(18,2) COMMENT 'Operating pressure of the gas pipe during the survey, in pounds per square inch.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the survey must be reported to PHMSA or other regulator.',
    `report_status` STRING COMMENT 'Current processing status of the regulatory report.. Valid values are `pending|submitted|rejected|approved`',
    `report_submitted_date` DATE COMMENT 'Date the survey report was filed with the regulatory authority.',
    `survey_completed` BOOLEAN COMMENT 'True when the survey activity has been fully executed and documented.',
    `survey_duration_minutes` STRING COMMENT 'Total time spent conducting the survey, in minutes.',
    `survey_number` STRING COMMENT 'Business-facing identifier assigned to the survey, used in reports and regulatory filings.',
    `survey_status` STRING COMMENT 'Current lifecycle state of the survey record.. Valid values are `scheduled|in_progress|completed|cancelled`',
    `survey_timestamp` TIMESTAMP COMMENT 'Date and time when the survey activity was performed on the gas asset.',
    `survey_type` STRING COMMENT 'Method used to conduct the leak survey, per PHMSA definitions.. Valid values are `bar-hole|cgi|walking|mobile|aerial`',
    `temperature_c` DECIMAL(18,2) COMMENT 'Air temperature in degrees Celsius measured at the survey site.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the survey record.',
    `weather_conditions` STRING COMMENT 'General weather at the time of the survey.. Valid values are `clear|cloudy|rain|snow|windy`',
    `wind_speed_mph` DECIMAL(18,2) COMMENT 'Wind speed in miles per hour at the time of the survey.',
    CONSTRAINT pk_gas_leak_survey PRIMARY KEY(`gas_leak_survey_id`)
) COMMENT 'Transactional record for scheduled and ad-hoc gas leak survey activities conducted on gas mains and service lines per PHMSA requirements. Captures survey identifier, survey date, survey type (bar-hole/CGI/walking/mobile/aerial), surveyed gas main or service line reference, survey crew reference, instrument type, leak indications found (count), leak classification (Grade 1/2/3 per GPTC), follow-up action required flag, and survey completion status. SSOT for PHMSA-mandated leak survey records; supports DOT annual reporting and integrity management program (IMP).';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` (
    `gas_leak_id` BIGINT COMMENT 'System‑generated unique identifier for each gas leak record.',
    `crew_id` BIGINT COMMENT 'Identifier of the workforce crew responsible for leak remediation.',
    `gas_main_id` BIGINT COMMENT 'Foreign key linking to distribution.gas_main. Business justification: gas_leak.gas_asset_id represents the gas asset where the leak was detected. The asset is a gas_main. Adding gas_main_id FK creates a proper relationship and removes the ambiguous gas_asset_id column.',
    `location_id` BIGINT COMMENT 'Reference to the GIS feature storing the precise leak geometry.',
    `it_asset_id` BIGINT COMMENT 'Foreign key linking to technology.it_asset. Business justification: Leak detection sensors are IT assets; tracking enables maintenance planning and incident reporting.',
    `violation_notice_id` BIGINT COMMENT 'Foreign key linking to regulatory.violation_notice. Business justification: Gas leaks can trigger violation notices; linking records the notice associated with each leak incident.',
    `actual_repair_cost_usd` DECIMAL(18,2) COMMENT 'Final amount paid for the repair work.',
    `asset_manager` STRING COMMENT 'Person or team accountable for the maintenance of the gas asset.',
    `closure_status` STRING COMMENT 'Overall lifecycle state of the leak record.. Valid values are `open|closed|cancelled`',
    `created_timestamp` TIMESTAMP COMMENT 'Date‑time when the leak record was initially loaded.',
    `discovery_date` DATE COMMENT 'Calendar date when the leak was initially identified.',
    `discovery_method` STRING COMMENT 'How the leak was found: routine survey, customer report, third‑party damage, or automated sensor detection.. Valid values are `survey|customer_report|third_party_damage|sensor_detection`',
    `emergency_response_required` BOOLEAN COMMENT 'True when the leak triggered an emergency response action.',
    `estimated_repair_cost_usd` DECIMAL(18,2) COMMENT 'Projected financial cost for leak remediation.',
    `estimated_total_release_mcf` DECIMAL(18,2) COMMENT 'Projected cumulative gas volume released before repair.',
    `field_notes` STRING COMMENT 'Free‑form text capturing observations, challenges, or additional actions taken.',
    `gas_leak_status` STRING COMMENT 'Current operational status of the leak.. Valid values are `active|monitored|resolved`',
    `impacted_customers_count` STRING COMMENT 'Count of residential/commercial customers whose service was affected.',
    `inspection_status` STRING COMMENT 'Outcome of the latest inspection: pass, fail, or pending.. Valid values are `pass|fail|pending`',
    `last_inspection_date` DATE COMMENT 'Date when the leak location was last inspected post‑repair.',
    `latitude` DECIMAL(18,2) COMMENT 'Geographic latitude of the leak location in decimal degrees.',
    `leak_code` STRING COMMENT 'Alphanumeric code assigned to the leak for easy reference on maps and work orders.',
    `leak_grade` STRING COMMENT 'Classification of leak severity: Grade 1 (immediate repair), Grade 2 (scheduled), Grade 3 (monitored).. Valid values are `grade_1|grade_2|grade_3`',
    `leak_name` STRING COMMENT 'Short descriptive name (e.g., "Main St. 12" or "Valve 3B") used by crews.',
    `leak_size_mcf_per_day` DECIMAL(18,2) COMMENT 'Estimated gas release rate expressed in thousand cubic feet per day.',
    `longitude` DECIMAL(18,2) COMMENT 'Geographic longitude of the leak location in decimal degrees.',
    `outage_end_timestamp` TIMESTAMP COMMENT 'Date‑time when service was restored after the leak was mitigated.',
    `outage_start_timestamp` TIMESTAMP COMMENT 'Date‑time when service interruption began due to the leak.',
    `owner_organization` STRING COMMENT 'Business unit or subsidiary that owns the asset containing the leak.',
    `phmsa_report_number` STRING COMMENT 'Unique identifier assigned by PHMSA for the incident report.',
    `phmsa_report_required` BOOLEAN COMMENT 'Indicates whether the leak must be reported to the Pipeline and Hazardous Materials Safety Administration.',
    `regulatory_compliance_status` STRING COMMENT 'Indicates whether all required regulatory filings have been completed.. Valid values are `compliant|non_compliant|pending`',
    `repair_date` DATE COMMENT 'Calendar date when the leak was successfully repaired.',
    `repair_method` STRING COMMENT 'Technique applied to stop the leak, such as section replacement, welding, clamping, or sealant.. Valid values are `replace_section|weld|clamp|sealant|other`',
    `repair_priority` STRING COMMENT 'Operational priority for fixing the leak, used for crew dispatch planning.. Valid values are `high|medium|low`',
    `reported_by` STRING COMMENT 'Identifier of the individual, crew, or automated system that submitted the leak report.',
    `safety_hazard_level` STRING COMMENT 'Risk classification based on leak size, location, and proximity to populated areas.. Valid values are `low|moderate|high|critical`',
    `updated_timestamp` TIMESTAMP COMMENT 'Date‑time of the latest modification to the leak record.',
    CONSTRAINT pk_gas_leak PRIMARY KEY(`gas_leak_id`)
) COMMENT 'Master record for each identified natural gas leak on the distribution system. Captures leak identifier, discovery date, discovery method (survey/customer report/third-party damage), associated gas main or service line, GIS location coordinates, leak grade (Grade 1 immediate/Grade 2 scheduled/Grade 3 monitored), leak size estimate (MCF/day), repair priority, assigned crew reference, repair date, repair method, and closure status. SSOT for gas leak lifecycle management; supports PHMSA incident reporting and IMP compliance.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` (
    `service_connection_order_id` BIGINT COMMENT 'Unique surrogate key for the service connection order record.',
    `crew_id` BIGINT COMMENT 'Foreign key linking to workforce.crew. Business justification: Service connection jobs are performed by a crew; crew_id enables crew scheduling and cost allocation in the service‑connection report.',
    `customer_account_id` BIGINT COMMENT 'Reference to the customer account that owns the service.',
    `distribution_service_point_id` BIGINT COMMENT 'Reference to the physical service point (meter location) being connected or modified.',
    `employee_id` BIGINT COMMENT 'Identifier of the design engineer responsible for engineering the service connection.',
    `resource_id` BIGINT COMMENT 'Foreign key linking to der.der_resource. Business justification: Installation work orders for DERs must reference the specific DER asset being installed to track labor, materials, and compliance.',
    `technician_id` BIGINT COMMENT 'Identifier of the design engineer responsible for engineering the service connection.',
    `commodity_type` STRING COMMENT 'Energy commodity for the service connection (electricity or natural gas).. Valid values are `electric|gas`',
    `completion_date` DATE COMMENT 'Actual date the service connection work was finished and the service became active.',
    `compliance_status` STRING COMMENT 'Overall compliance posture of the order with internal and external standards.. Valid values are `compliant|non_compliant|exempt`',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the order record was first created in the system.',
    `currency_code` STRING COMMENT 'Three‑letter ISO currency code for monetary amounts.. Valid values are `USD|CAD|EUR|GBP|JPY|AUD`',
    `estimated_cost` DECIMAL(18,2) COMMENT 'Projected cost of the service connection work before final billing.',
    `inspection_date` DATE COMMENT 'Date the inspection was performed or is scheduled to be performed.',
    `inspection_status` STRING COMMENT 'Current status of the required safety or regulatory inspection.. Valid values are `pending|scheduled|passed|failed|not_required`',
    `is_critical_infrastructure` BOOLEAN COMMENT 'True if the work involves assets designated as critical infrastructure under NERC/ISO regulations.',
    `is_emergency` BOOLEAN COMMENT 'Indicates whether the order is an emergency service restoration or safety‑critical request.',
    `notes` STRING COMMENT 'Free‑form field for additional comments or special instructions.',
    `order_number` STRING COMMENT 'External business identifier assigned to the order, used in customer communications and regulatory filings.',
    `order_submitted_timestamp` TIMESTAMP COMMENT 'Timestamp when the order was formally submitted by the customer or sales representative.',
    `order_type` STRING COMMENT 'Category of service change requested by the customer.. Valid values are `new_connect|upgrade|downgrade|disconnect|reconnect`',
    `permit_number` STRING COMMENT 'Regulatory permit identifier authorizing the construction work.',
    `priority` STRING COMMENT 'Business priority assigned to the order for scheduling and resource allocation.. Valid values are `low|medium|high|critical`',
    `regulatory_approval_status` STRING COMMENT 'Status of required regulatory approvals for the order.. Valid values are `pending|approved|rejected`',
    `requested_service_date` DATE COMMENT 'Date the customer requests the new or modified service to become active.',
    `scheduled_end_date` DATE COMMENT 'Planned completion date for the field work.',
    `scheduled_start_date` DATE COMMENT 'Planned start date for field work to implement the service change.',
    `service_connection_order_status` STRING COMMENT 'Current lifecycle state of the service connection order.. Valid values are `draft|submitted|approved|in_progress|completed|cancelled`',
    `tax_amount` DECIMAL(18,2) COMMENT 'Applicable taxes calculated on the estimated cost.',
    `total_cost` DECIMAL(18,2) COMMENT 'Final cost of the order including taxes and any adjustments.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the order record.',
    `work_description` STRING COMMENT 'Narrative description of the infrastructure work required (e.g., transformer upgrade, line extension).',
    CONSTRAINT pk_service_connection_order PRIMARY KEY(`service_connection_order_id`)
) COMMENT 'Transactional record for new service connection, upgrade, or disconnection orders for electric or gas distribution service. Captures order identifier, order type (new connect/upgrade/downgrade/disconnect/reconnect), energy commodity (electric/gas), service point reference, customer account reference, requested service date, scheduled date, completion date, required infrastructure work (transformer upgrade/main extension/service line installation), design engineer reference, permit number, inspection status, and order status. Bridges the customer domain (account enrollment) and distribution operations (physical network connection work).';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` (
    `conductor_span_id` BIGINT COMMENT 'Unique identifier for the conductor span record.',
    `structure_id` BIGINT COMMENT 'Identifier of the upstream structure (pole, vault, etc.) where the span originates.',
    `material_master_id` BIGINT COMMENT 'Foreign key linking to supply.material_master. Business justification: Links conductor span to material master for standardized part identification and inventory control.',
    `feeder_id` BIGINT COMMENT 'Identifier of the feeder that the span belongs to.',
    `pole_id` BIGINT COMMENT 'Identifier of the upstream structure (pole, vault, etc.) where the span originates.',
    `purchase_order_id` BIGINT COMMENT 'Foreign key linking to supply.purchase_order. Business justification: Associates conductor span with purchase order for CAPEX reporting.',
    `to_structure_pole_id` BIGINT COMMENT 'Identifier of the downstream structure (pole, vault, etc.) where the span terminates.',
    `vendor_id` BIGINT COMMENT 'Foreign key linking to supply.vendor. Business justification: Conductor Span supplier vendor recorded for procurement compliance and warranty.',
    `replaced_conductor_span_id` BIGINT COMMENT 'Self-referencing FK on conductor_span (replaced_conductor_span_id)',
    `age_years` STRING COMMENT 'Number of years since installation.',
    `asset_condition` STRING COMMENT 'Current condition assessment of the span.. Valid values are `good|fair|poor|critical`',
    `asset_manager` STRING COMMENT 'Person or team responsible for managing the span.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the span record was created.',
    `decommission_date` DATE COMMENT 'Date the span was removed from service, if applicable.',
    `gis_line_geometry` STRING COMMENT 'Well‑known text representation of the span geometry for GIS mapping.',
    `inspection_status` STRING COMMENT 'Result of the most recent inspection.. Valid values are `passed|failed|pending`',
    `installation_year` STRING COMMENT 'Calendar year the conductor span was installed.',
    `is_critical_infrastructure` BOOLEAN COMMENT 'Indicates whether the span is part of critical infrastructure.',
    `is_under_maintenance` BOOLEAN COMMENT 'True if the span is currently undergoing maintenance.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent inspection of the span.',
    `last_maintenance_date` DATE COMMENT 'Date the span last underwent maintenance.',
    `length_ft` DECIMAL(18,2) COMMENT 'Physical length of the conductor span in feet.',
    `line_category` STRING COMMENT 'Physical placement of the span.. Valid values are `overhead|underground`',
    `line_code` STRING COMMENT 'Alphanumeric code used to reference the span in work orders and GIS.',
    `line_current_ka` DECIMAL(18,2) COMMENT 'Typical current flow on the span under load.',
    `line_voltage_kv` DECIMAL(18,2) COMMENT 'Operating voltage of the conductor span.',
    `maintenance_cycle_months` STRING COMMENT 'Planned interval between routine maintenance activities.',
    `maintenance_status` STRING COMMENT 'Current status of any ongoing maintenance work.. Valid values are `scheduled|in_progress|completed`',
    `next_inspection_due` DATE COMMENT 'Planned date for the next scheduled inspection.',
    `next_maintenance_due` DATE COMMENT 'Planned date for the next maintenance activity.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the span.',
    `operational_status` STRING COMMENT 'Current operational state of the conductor span.. Valid values are `active|inactive|planned|decommissioned`',
    `owner_organization` STRING COMMENT 'Business unit or subsidiary that owns the span.',
    `phase_configuration` STRING COMMENT 'Electrical phase arrangement for the span (e.g., A, B, C, AB, BC, CA, ABC).',
    `rated_ampacity_amps` STRING COMMENT 'Maximum continuous current the conductor can carry safely.',
    `regulatory_compliance_status` STRING COMMENT 'Compliance status with applicable utility regulations.. Valid values are `compliant|non_compliant|pending`',
    `sag_design_temp_c` DECIMAL(18,2) COMMENT 'Ambient temperature used for sag calculations.',
    `sag_ft` DECIMAL(18,2) COMMENT 'Measured sag of the conductor at design temperature.',
    `span_name` STRING COMMENT 'Human‑readable name or label for the conductor span.',
    `thermal_rating_c` DECIMAL(18,2) COMMENT 'Maximum conductor temperature under continuous load.',
    `to_structure_code` BIGINT COMMENT 'Identifier of the downstream structure (pole, vault, etc.) where the span terminates.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the span record.',
    `voltage_class_kv` DECIMAL(18,2) COMMENT 'Nominal voltage class for which the span is rated.',
    CONSTRAINT pk_conductor_span PRIMARY KEY(`conductor_span_id`)
) COMMENT 'Master record for each discrete overhead or underground conductor segment (span) connecting two distribution structures (pole-to-pole, pole-to-device, or vault-to-vault). Captures span identifier, conductor type (ACSR/AAC/copper/XLPE/EPR), gauge (AWG/kcmil), phase configuration (A/B/C/N), length (ft), rated ampacity, installation year, sag at design temperature, associated feeder, from-structure reference (pole/vault), to-structure reference (pole/vault), GIS line geometry, and operational status. Fundamental topology element for GIS-based network modeling, storm damage assessment (broken spans), vegetation management targeting, capacity analysis, and outage extent determination.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`feeder_crew_assignment` (
    `feeder_crew_assignment_id` BIGINT COMMENT 'Primary key for the feeder_crew_assignment association',
    `crew_id` BIGINT COMMENT 'Foreign key linking to the crew',
    `feeder_id` BIGINT COMMENT 'Foreign key linking to the feeder',
    `assignment_end_timestamp` TIMESTAMP COMMENT 'Timestamp when the crew completed work on the feeder',
    `assignment_start_timestamp` TIMESTAMP COMMENT 'Timestamp when the crew began work on the feeder',
    `role` STRING COMMENT 'The functional role of the crew for this assignment (e.g., maintenance, emergency restoration)',
    CONSTRAINT pk_feeder_crew_assignment PRIMARY KEY(`feeder_crew_assignment_id`)
) COMMENT 'Represents the assignment of a workforce crew to a distribution feeder. Each record captures when the crew started and ended work on the feeder and the role the crew performed (e.g., maintenance, restoration).. Existence Justification: Crews are dispatched to maintain distribution feeders, and a single feeder may be serviced by multiple crews over time. The utility records each assignment with start/end timestamps and the crews role, and crews regularly work on many different feeders.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`vault` (
    `vault_id` BIGINT COMMENT 'Primary key for vault',
    `feeder_id` BIGINT COMMENT 'Identifier of the feeder circuit associated with the vault.',
    `distribution_substation_id` BIGINT COMMENT 'Identifier of the substation to which the vault is electrically connected.',
    `connected_vault_id` BIGINT COMMENT 'Self-referencing FK on vault (connected_vault_id)',
    `address` STRING COMMENT 'Street address or site description where the vault is located.',
    `capacity_mwh` DECIMAL(18,2) COMMENT 'Maximum energy capacity the vault can safely contain, expressed in megawatt‑hours.',
    `vault_code` STRING COMMENT 'Unique business code assigned to the vault by the utility.',
    `commissioning_date` DATE COMMENT 'Date the vault entered service and became operational.',
    `compliance_status` STRING COMMENT 'Current compliance status of the vault with applicable regulations.',
    `condition_rating` STRING COMMENT 'Assessment of the vaults physical condition based on inspection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the vault record was first created in the data lake.',
    `decommission_date` DATE COMMENT 'Date the vault was retired from service, if applicable.',
    `depth_feet` DECIMAL(18,2) COMMENT 'Vertical depth of the vault below ground level, expressed in feet.',
    `external_reference` STRING COMMENT 'Identifier used by external asset management systems to reference this vault.',
    `inspection_due_date` DATE COMMENT 'Date by which the next mandatory inspection must be performed.',
    `inspection_status` STRING COMMENT 'Result of the latest inspection.',
    `installation_date` DATE COMMENT 'Date the vault was originally installed.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the vault is considered critical to grid reliability.',
    `last_inspection_date` DATE COMMENT 'Date the most recent inspection was completed.',
    `last_maintenance_date` DATE COMMENT 'Date the most recent maintenance activity was completed.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the vault location in decimal degrees.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the vault location in decimal degrees.',
    `maintenance_cycle_months` STRING COMMENT 'Planned interval between routine maintenance activities, expressed in months.',
    `material` STRING COMMENT 'Primary material used in the vault construction (e.g., concrete, steel).',
    `vault_name` STRING COMMENT 'Human‑readable name or designation of the vault.',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the upcoming maintenance activity.',
    `notes` STRING COMMENT 'Free‑form field for additional comments or observations about the vault.',
    `owner_organization` STRING COMMENT 'Business unit or subsidiary that owns the vault.',
    `region_code` STRING COMMENT 'Three‑letter code identifying the utility operating region (e.g., NERC region).',
    `risk_level` STRING COMMENT 'Overall risk rating for the vault based on condition, location, and criticality.',
    `vault_status` STRING COMMENT 'Current lifecycle status of the vault.',
    `vault_type` STRING COMMENT 'Classification of the vault based on its function or equipment housed.',
    `updated_by` STRING COMMENT 'User or system identifier that performed the latest update.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the vault record.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level of equipment housed in the vault, expressed in kilovolts.',
    `created_by` STRING COMMENT 'User or system identifier that created the vault record.',
    CONSTRAINT pk_vault PRIMARY KEY(`vault_id`)
) COMMENT 'Master reference table for vault. Referenced by vault_id.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`load_profile` (
    `load_profile_id` BIGINT COMMENT 'Primary key for load_profile',
    `baseline_load_profile_id` BIGINT COMMENT 'Self-referencing FK on load_profile (baseline_load_profile_id)',
    `approval_timestamp` TIMESTAMP COMMENT 'Timestamp when the load profile was approved.',
    `approved_by` STRING COMMENT 'Identifier of the person or role that approved the load profile.',
    `average_daily_kwh` DECIMAL(18,2) COMMENT 'Average daily energy consumption (kWh) represented by the profile.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the load profile record was created.',
    `data_source_system` STRING COMMENT 'Source system that provided the load profile definition (e.g., GE PowerOn, Esri ArcGIS).',
    `load_profile_description` STRING COMMENT 'Detailed textual description of the load profile characteristics.',
    `effective_from` DATE COMMENT 'Date from which the load profile is effective for new assignments.',
    `effective_until` DATE COMMENT 'Date until which the load profile remains effective (null if open‑ended).',
    `is_default` BOOLEAN COMMENT 'Indicates whether this profile is the default for its category.',
    `load_factor` DECIMAL(18,2) COMMENT 'Load factor (average load divided by peak demand) for the profile.',
    `measurement_interval_minutes` STRING COMMENT 'Time interval in minutes between measurement points that define the profile shape.',
    `peak_demand_kw` DECIMAL(18,2) COMMENT 'Maximum demand (kW) observed in the profile.',
    `profile_category` STRING COMMENT 'Category of customers or service area the profile applies to.',
    `profile_code` STRING COMMENT 'External code used to reference the load profile in operational systems.',
    `profile_name` STRING COMMENT 'Human‑readable name of the load profile (e.g., Residential‑Weekday).',
    `seasonality` STRING COMMENT 'Seasonal pattern classification of the load profile.',
    `load_profile_status` STRING COMMENT 'Current lifecycle status of the load profile.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the load profile record.',
    `version_number` STRING COMMENT 'Version number of the load profile definition.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal voltage level (kV) associated with the profile.',
    CONSTRAINT pk_load_profile PRIMARY KEY(`load_profile_id`)
) COMMENT 'Master reference table for load_profile. Referenced by load_profile_id.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`gas_network_node` (
    `gas_network_node_id` BIGINT COMMENT 'Primary key for gas_network_node',
    `upstream_gas_network_node_id` BIGINT COMMENT 'Self-referencing FK on gas_network_node (upstream_gas_network_node_id)',
    `asset_tag` STRING COMMENT 'Physical tag identifier attached to the node for field identification.',
    `capacity_mcf_per_day` DOUBLE COMMENT 'Planned gas throughput capacity for the node.',
    `commissioning_timestamp` TIMESTAMP COMMENT 'Exact moment the node entered operational service.',
    `compliance_last_checked` DATE COMMENT 'Date when compliance status was most recently reviewed.',
    `compliance_notes` STRING COMMENT 'Additional remarks or observations related to regulatory compliance.',
    `compliance_status` STRING COMMENT 'Current compliance standing with applicable gas distribution regulations.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the node record was first created in the data lake.',
    `criticality_score` STRING COMMENT 'Quantitative score representing the nodes criticality to the network.',
    `data_source_system` STRING COMMENT 'Name of the operational system of record (e.g., GE PowerOn DMS) that provided the data.',
    `decommission_timestamp` TIMESTAMP COMMENT 'Exact moment the node was taken out of service.',
    `gas_network_node_description` STRING COMMENT 'Narrative description providing additional context about the node.',
    `diameter_inch` DOUBLE COMMENT 'Nominal pipe diameter at the node.',
    `elevation_m` DOUBLE COMMENT 'Vertical elevation of the node relative to mean sea level.',
    `external_reference_code` STRING COMMENT 'Reference identifier linking to the node record in external GIS/OMS platforms.',
    `inspection_status` STRING COMMENT 'Outcome of the latest inspection activity.',
    `installation_date` DATE COMMENT 'Calendar date when the node was physically installed.',
    `is_critical_infrastructure` BOOLEAN COMMENT 'True if the node is designated as critical for service continuity.',
    `is_remote_controlled` BOOLEAN COMMENT 'True if the node supports remote operation (e.g., valve actuation).',
    `last_inspection_date` DATE COMMENT 'Calendar date when the node was last inspected.',
    `latitude` DOUBLE COMMENT 'Latitude coordinate of the node location.',
    `length_m` DOUBLE COMMENT 'Physical length of the pipe segment linked to the node.',
    `lifecycle_status` STRING COMMENT 'Lifecycle phase of the gas network node within the asset management process.',
    `longitude` DOUBLE COMMENT 'Longitude coordinate of the node location.',
    `maintenance_contact_name` STRING COMMENT 'Primary internal contact responsible for node maintenance.',
    `maintenance_contact_phone` STRING COMMENT 'Phone number for the maintenance contact.',
    `maintenance_cycle_months` STRING COMMENT 'Planned interval between routine maintenance activities.',
    `material` STRING COMMENT 'Primary material used for the nodes construction.',
    `max_flow_rate_m3h` DOUBLE COMMENT 'Design maximum gas flow rate the node can handle.',
    `next_inspection_due` DATE COMMENT 'Planned date for the upcoming inspection.',
    `node_code` STRING COMMENT 'Unique alphanumeric code that identifies the node in external systems such as GE PowerOn DMS/OMS.',
    `node_name` STRING COMMENT 'Descriptive name assigned to the gas network node for operational use.',
    `node_type` STRING COMMENT 'Functional classification of the gas network node.',
    `operating_pressure_psi` DOUBLE COMMENT 'Measured pressure at the node during normal operation.',
    `owner_company` STRING COMMENT 'Business entity that owns the node asset.',
    `pressure_rating_psi` DOUBLE COMMENT 'Design pressure rating for the node equipment.',
    `region` STRING COMMENT 'Broad geographic region where the node is located.',
    `remote_control_capability` STRING COMMENT 'Type of remote control functionality available at the node.',
    `risk_category` STRING COMMENT 'Risk level assigned based on safety and reliability analyses.',
    `service_area` STRING COMMENT 'Named service area or district that the node serves.',
    `gas_network_node_status` STRING COMMENT 'Indicates whether the node is currently in service, under maintenance, or retired.',
    `temperature_c` DOUBLE COMMENT 'Ambient or gas temperature recorded at the node.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent modification to the node record.',
    `zone` STRING COMMENT 'Operational zone code used for planning and outage management.',
    CONSTRAINT pk_gas_network_node PRIMARY KEY(`gas_network_node_id`)
) COMMENT 'Master reference table for gas_network_node. Referenced by start_node_id.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`meter_set` (
    `meter_set_id` BIGINT COMMENT 'Primary key for meter_set',
    `replaced_meter_set_id` BIGINT COMMENT 'Self-referencing FK on meter_set (replaced_meter_set_id)',
    `average_age_years` DECIMAL(18,2) COMMENT 'Average age of meters within the set, expressed in years.',
    `communication_protocol` STRING COMMENT 'Primary communication protocol used by smart meters in the set.',
    `compliance_status` STRING COMMENT 'Regulatory compliance status of the meter set.',
    `data_source_system` STRING COMMENT 'Name of the upstream operational system that supplied the meter set data.',
    `decommission_date` DATE COMMENT 'Date when the meter set was retired or removed from service, if applicable.',
    `demand_factor` DECIMAL(18,2) COMMENT 'Ratio of average demand to peak demand for the meter set.',
    `effective_from` DATE COMMENT 'Date from which the meter set definition becomes effective.',
    `effective_until` DATE COMMENT 'Date after which the meter set definition is no longer valid (nullable for open‑ended).',
    `firmware_version` STRING COMMENT 'Version identifier of the meter firmware deployed across the set.',
    `geographic_region` STRING COMMENT 'Three‑letter ISO country or region code where the meter set is located.',
    `installation_date` DATE COMMENT 'Date when the meter set was first installed in the field.',
    `is_virtual` BOOLEAN COMMENT 'Indicates whether the meter set represents virtual/metered aggregation rather than physical meters.',
    `last_firmware_update` DATE COMMENT 'Date when the firmware was last updated for the meter set.',
    `last_inspection_date` DATE COMMENT 'Date of the most recent physical inspection of the meter set.',
    `maintenance_schedule` STRING COMMENT 'Textual description of the routine maintenance plan for the meter set.',
    `meter_set_category` STRING COMMENT 'Business category describing the purpose of the meter set.',
    `meter_set_subtype` STRING COMMENT 'More granular classification of the meter set based on location or usage.',
    `metering_technology` STRING COMMENT 'Technology type of meters in the set.',
    `notes` STRING COMMENT 'Free‑form comments or remarks about the meter set.',
    `owner_organization` STRING COMMENT 'Organizational unit within the utility that owns or manages the meter set.',
    `peak_demand_kw` DECIMAL(18,2) COMMENT 'Maximum recorded demand across the meter set, in kilowatts.',
    `record_audit_created` TIMESTAMP COMMENT 'Timestamp when the meter set record was first created in the lakehouse.',
    `record_audit_updated` TIMESTAMP COMMENT 'Timestamp of the most recent update to the meter set record.',
    `regulatory_reporting_flag` BOOLEAN COMMENT 'True if the meter set is required for mandatory regulatory reporting (e.g., NERC).',
    `service_area` STRING COMMENT 'Name of the distribution service area or zone for the meter set.',
    `set_code` STRING COMMENT 'External business code used to reference the meter set in operational systems.',
    `set_name` STRING COMMENT 'Human‑readable name describing the meter set.',
    `set_type` STRING COMMENT 'Classification of the meter set based on customer or service segment.',
    `smart_meter_enabled` BOOLEAN COMMENT 'Indicates whether the meters in the set support smart‑metering capabilities.',
    `meter_set_status` STRING COMMENT 'Current lifecycle status of the meter set.',
    `total_capacity_kw` DECIMAL(18,2) COMMENT 'Aggregate rated capacity of all meters in the set, expressed in kilowatts.',
    `total_meter_count` STRING COMMENT 'Number of individual meters included in the set.',
    `voltage_level` STRING COMMENT 'Standard voltage classification for the meter set.',
    CONSTRAINT pk_meter_set PRIMARY KEY(`meter_set_id`)
) COMMENT 'Master reference table for meter_set. Referenced by meter_set_id.';

CREATE OR REPLACE TABLE `power_and_utilities_v2`.`distribution`.`structure` (
    `structure_id` BIGINT COMMENT 'Primary key for structure',
    `adjacent_structure_id` BIGINT COMMENT 'Self-referencing FK on structure (adjacent_structure_id)',
    `address` STRING COMMENT 'Street address or site description where the structure is located.',
    `asset_tag` STRING COMMENT 'Unique asset tag or catalogue number assigned by the utility for inventory tracking.',
    `commissioning_date` DATE COMMENT 'Date the structure became operational after testing and acceptance.',
    `condition_rating` STRING COMMENT 'Numeric rating (1‑5) of the structures physical condition after inspection.',
    `created_timestamp` TIMESTAMP COMMENT 'Timestamp when the structure record was first created in the data lake.',
    `decommission_date` DATE COMMENT 'Date the structure was retired or removed from service (nullable).',
    `external_reference_code` STRING COMMENT 'Identifier used by external partners or regulatory bodies to reference this structure.',
    `height_m` DECIMAL(18,2) COMMENT 'Physical height of the structure in meters.',
    `installation_date` DATE COMMENT 'Date the structure was first installed in the field.',
    `is_critical` BOOLEAN COMMENT 'Indicates whether the structure is designated as critical for grid reliability.',
    `is_under_construction` BOOLEAN COMMENT 'True if the structure is currently being built and not yet operational.',
    `last_maintenance_date` DATE COMMENT 'Date the most recent maintenance work was performed.',
    `latitude` DOUBLE COMMENT 'Geographic latitude of the structure (WGS84).',
    `length_m` DECIMAL(18,2) COMMENT 'Length of the structure (relevant for line spans) in meters.',
    `load_capacity_amps` DECIMAL(18,2) COMMENT 'Maximum continuous current the structure can safely carry, expressed in amperes.',
    `longitude` DOUBLE COMMENT 'Geographic longitude of the structure (WGS84).',
    `maintenance_cycle_months` STRING COMMENT 'Planned interval in months between routine maintenance activities.',
    `material` STRING COMMENT 'Primary construction material of the structure.',
    `structure_name` STRING COMMENT 'Human‑readable name or label for the structure (e.g., Pole‑A12, Transformer‑TX5).',
    `next_maintenance_date` DATE COMMENT 'Scheduled date for the upcoming maintenance activity.',
    `notes` STRING COMMENT 'Free‑form comments or observations about the structure.',
    `owner_organization` STRING COMMENT 'Internal business unit or subsidiary that owns the structure.',
    `region_code` STRING COMMENT 'Three‑letter code representing the utility service region (e.g., NWE, SEU).',
    `source_system` STRING COMMENT 'Name of the operational system of record (e.g., GE PowerOn DMS, Esri ArcGIS) that supplied the data.',
    `structure_status` STRING COMMENT 'Current operational status of the structure.',
    `structure_type` STRING COMMENT 'Category of the physical structure within the distribution network.',
    `updated_timestamp` TIMESTAMP COMMENT 'Timestamp of the most recent update to the structure record.',
    `voltage_level_kv` DECIMAL(18,2) COMMENT 'Nominal operating voltage level of the structure in kilovolts.',
    CONSTRAINT pk_structure PRIMARY KEY(`structure_id`)
) COMMENT 'Master reference table for structure. Referenced by from_structure_id.';

-- ========= FOREIGN KEYS =========
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ADD CONSTRAINT `fk_distribution_feeder_load_profile_id` FOREIGN KEY (`load_profile_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`load_profile`(`load_profile_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_pole_id` FOREIGN KEY (`pole_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`pole`(`pole_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ADD CONSTRAINT `fk_distribution_distribution_service_point_vault_id` FOREIGN KEY (`vault_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`vault`(`vault_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ADD CONSTRAINT `fk_distribution_distribution_transformer_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ADD CONSTRAINT `fk_distribution_distribution_transformer_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ADD CONSTRAINT `fk_distribution_distribution_transformer_pole_id` FOREIGN KEY (`pole_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`pole`(`pole_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ADD CONSTRAINT `fk_distribution_pole_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ADD CONSTRAINT `fk_distribution_protective_device_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ADD CONSTRAINT `fk_distribution_protective_device_primary_upstream_device_protective_device_id` FOREIGN KEY (`primary_upstream_device_protective_device_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`protective_device`(`protective_device_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_gas_pressure_district_id` FOREIGN KEY (`gas_pressure_district_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`gas_pressure_district`(`gas_pressure_district_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ADD CONSTRAINT `fk_distribution_gas_main_gas_network_node_id` FOREIGN KEY (`gas_network_node_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`gas_network_node`(`gas_network_node_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ADD CONSTRAINT `fk_distribution_gas_service_line_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ADD CONSTRAINT `fk_distribution_gas_service_line_gas_main_id` FOREIGN KEY (`gas_main_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`gas_main`(`gas_main_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ADD CONSTRAINT `fk_distribution_gas_service_line_meter_set_id` FOREIGN KEY (`meter_set_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`meter_set`(`meter_set_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ADD CONSTRAINT `fk_distribution_distribution_outage_event_protective_device_id` FOREIGN KEY (`protective_device_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`protective_device`(`protective_device_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ADD CONSTRAINT `fk_distribution_distribution_switching_order_distribution_outage_event_id` FOREIGN KEY (`distribution_outage_event_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_outage_event`(`distribution_outage_event_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ADD CONSTRAINT `fk_distribution_gas_leak_survey_gas_main_id` FOREIGN KEY (`gas_main_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`gas_main`(`gas_main_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ADD CONSTRAINT `fk_distribution_gas_leak_gas_main_id` FOREIGN KEY (`gas_main_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`gas_main`(`gas_main_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ADD CONSTRAINT `fk_distribution_service_connection_order_distribution_service_point_id` FOREIGN KEY (`distribution_service_point_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_service_point`(`distribution_service_point_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ADD CONSTRAINT `fk_distribution_conductor_span_structure_id` FOREIGN KEY (`structure_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`structure`(`structure_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ADD CONSTRAINT `fk_distribution_conductor_span_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ADD CONSTRAINT `fk_distribution_conductor_span_pole_id` FOREIGN KEY (`pole_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`pole`(`pole_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ADD CONSTRAINT `fk_distribution_conductor_span_to_structure_pole_id` FOREIGN KEY (`to_structure_pole_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`pole`(`pole_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ADD CONSTRAINT `fk_distribution_conductor_span_replaced_conductor_span_id` FOREIGN KEY (`replaced_conductor_span_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`conductor_span`(`conductor_span_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder_crew_assignment` ADD CONSTRAINT `fk_distribution_feeder_crew_assignment_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`vault` ADD CONSTRAINT `fk_distribution_vault_feeder_id` FOREIGN KEY (`feeder_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`feeder`(`feeder_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`vault` ADD CONSTRAINT `fk_distribution_vault_distribution_substation_id` FOREIGN KEY (`distribution_substation_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`distribution_substation`(`distribution_substation_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`vault` ADD CONSTRAINT `fk_distribution_vault_connected_vault_id` FOREIGN KEY (`connected_vault_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`vault`(`vault_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`load_profile` ADD CONSTRAINT `fk_distribution_load_profile_baseline_load_profile_id` FOREIGN KEY (`baseline_load_profile_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`load_profile`(`load_profile_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_network_node` ADD CONSTRAINT `fk_distribution_gas_network_node_upstream_gas_network_node_id` FOREIGN KEY (`upstream_gas_network_node_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`gas_network_node`(`gas_network_node_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`meter_set` ADD CONSTRAINT `fk_distribution_meter_set_replaced_meter_set_id` FOREIGN KEY (`replaced_meter_set_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`meter_set`(`meter_set_id`);
ALTER TABLE `power_and_utilities_v2`.`distribution`.`structure` ADD CONSTRAINT `fk_distribution_structure_adjacent_structure_id` FOREIGN KEY (`adjacent_structure_id`) REFERENCES `power_and_utilities_v2`.`distribution`.`structure`(`structure_id`);

-- ========= TAGS =========
ALTER SCHEMA `power_and_utilities_v2`.`distribution` SET TAGS ('dbx_division' = 'operations');
ALTER SCHEMA `power_and_utilities_v2`.`distribution` SET TAGS ('dbx_domain' = 'distribution');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` SET TAGS ('dbx_subdomain' = 'electric_network');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `aggregation_group_id` SET TAGS ('dbx_business_glossary_term' = 'Aggregation Group Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Substation Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `emergency_response_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Plan Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `load_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `rate_case_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Rate Case Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `asset_group` SET TAGS ('dbx_business_glossary_term' = 'Asset Group');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `average_daily_load_mwh` SET TAGS ('dbx_business_glossary_term' = 'Average Daily Load (MWh)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `average_outage_duration_min` SET TAGS ('dbx_business_glossary_term' = 'Average Outage Duration (min)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `capacity_mva` SET TAGS ('dbx_business_glossary_term' = 'Rated Capacity (MVA)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `estimated_annual_energy_mwh` SET TAGS ('dbx_business_glossary_term' = 'Estimated Annual Energy (MWh)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `estimated_peak_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Estimated Peak Load (MW)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `fault_count_year` SET TAGS ('dbx_business_glossary_term' = 'Annual Fault Count');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `feeder_code` SET TAGS ('dbx_business_glossary_term' = 'Feeder Code');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `feeder_name` SET TAGS ('dbx_business_glossary_term' = 'Feeder Name');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `feeder_status` SET TAGS ('dbx_business_glossary_term' = 'Feeder Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `feeder_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|retired|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `feeder_type` SET TAGS ('dbx_business_glossary_term' = 'Feeder Type (Overhead/Underground/Mixed)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `feeder_type` SET TAGS ('dbx_value_regex' = 'overhead|underground|mixed');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `gis_geometry_reference` SET TAGS ('dbx_business_glossary_term' = 'GIS Geometry Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Indicator');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `is_metered` SET TAGS ('dbx_business_glossary_term' = 'Metered Indicator');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `is_outage_prone` SET TAGS ('dbx_business_glossary_term' = 'Outage Prone Indicator');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `is_under_construction` SET TAGS ('dbx_business_glossary_term' = 'Under Construction Indicator');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `last_outage_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Outage Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `length_km` SET TAGS ('dbx_business_glossary_term' = 'Feeder Length (km)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `maintenance_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (Months)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `max_recorded_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Maximum Recorded Load (MW)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `meter_data_source` SET TAGS ('dbx_business_glossary_term' = 'Meter Data Source');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `meter_data_source` SET TAGS ('dbx_value_regex' = 'AMI|SCADA|Manual');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `min_recorded_load_mw` SET TAGS ('dbx_business_glossary_term' = 'Minimum Recorded Load (MW)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Feeder Notes');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `outage_count_year` SET TAGS ('dbx_business_glossary_term' = 'Annual Outage Count');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_business_glossary_term' = 'Protection Device Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `protection_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `reliability_caidi` SET TAGS ('dbx_business_glossary_term' = 'CAIDI (Customer Average Interruption Duration Index)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `reliability_saidi` SET TAGS ('dbx_business_glossary_term' = 'SAIDI (System Average Interruption Duration Index)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `reliability_saifi` SET TAGS ('dbx_business_glossary_term' = 'SAIFI (System Average Interruption Frequency Index)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `transformer_rating_mva` SET TAGS ('dbx_business_glossary_term' = 'Transformer Rating (MVA)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Nominal Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder` ALTER COLUMN `voltage_regulation_percent` SET TAGS ('dbx_business_glossary_term' = 'Voltage Regulation (%)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` SET TAGS ('dbx_subdomain' = 'electric_network');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `distribution_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Substation ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Location Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `balancing_area_id` SET TAGS ('dbx_business_glossary_term' = 'Balancing Area Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `control_zone_id` SET TAGS ('dbx_business_glossary_term' = 'Control Zone Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `network_device_id` SET TAGS ('dbx_business_glossary_term' = 'Network Device Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `network_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `network_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Environmental Permit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `service_territory_id` SET TAGS ('dbx_business_glossary_term' = 'Service Territory Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `transmission_substation_id` SET TAGS ('dbx_business_glossary_term' = 'Transmission Substation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `address_line1` SET TAGS ('dbx_business_glossary_term' = 'Address Line 1 (ADDRESS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `address_line1` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `asset_manager` SET TAGS ('dbx_business_glossary_term' = 'Asset Manager (PERSON)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `bus_configuration` SET TAGS ('dbx_business_glossary_term' = 'Bus Configuration (CONFIGURATION)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `bus_configuration` SET TAGS ('dbx_value_regex' = 'single|double|ring|breaker');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `city` SET TAGS ('dbx_business_glossary_term' = 'City (CITY)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `city` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date (DATE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `country_code` SET TAGS ('dbx_business_glossary_term' = 'Country Code (ISO)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `country_code` SET TAGS ('dbx_value_regex' = 'USA|CAN|MEX');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp (TS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date (DATE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `distribution_substation_status` SET TAGS ('dbx_business_glossary_term' = 'Substation Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `distribution_substation_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned|maintenance');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `gis_polygon_reference` SET TAGS ('dbx_business_glossary_term' = 'GIS Polygon Identifier (ID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag (FLAG)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (DATE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (DEGREES)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (DEGREES)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `maintenance_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (MONTHS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `number_of_feeder_bays` SET TAGS ('dbx_business_glossary_term' = 'Number of Feeder Bays (COUNT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `number_of_transformers` SET TAGS ('dbx_business_glossary_term' = 'Number of Transformers (COUNT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization (ORG)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `postal_code` SET TAGS ('dbx_business_glossary_term' = 'Postal Code (ZIP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `postal_code` SET TAGS ('dbx_value_regex' = '^[0-9]{5}(-[0-9]{4})?$');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `postal_code` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `postal_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt|pending');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `state_province` SET TAGS ('dbx_business_glossary_term' = 'State/Province (STATE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `state_province` SET TAGS ('dbx_confidential' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `state_province` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `substation_code` SET TAGS ('dbx_business_glossary_term' = 'Substation Code (CODE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `substation_description` SET TAGS ('dbx_business_glossary_term' = 'Substation Description (DESCRIPTION)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `substation_name` SET TAGS ('dbx_business_glossary_term' = 'Substation Name (NAME)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `substation_type` SET TAGS ('dbx_business_glossary_term' = 'Substation Type (TYPE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `substation_type` SET TAGS ('dbx_value_regex' = 'distribution|intertie|switching|recloser');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `transformer_capacity_mva` SET TAGS ('dbx_business_glossary_term' = 'Transformer Capacity (MVA)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp (TS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `voltage_primary_kv` SET TAGS ('dbx_business_glossary_term' = 'Primary Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_substation` ALTER COLUMN `voltage_secondary_kv` SET TAGS ('dbx_business_glossary_term' = 'Secondary Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` SET TAGS ('dbx_subdomain' = 'electric_network');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Service Point ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `billing_account_id` SET TAGS ('dbx_business_glossary_term' = 'Billing Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `compliance_obligation_id` SET TAGS ('dbx_business_glossary_term' = 'Compliance Obligation Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `nem_account_id` SET TAGS ('dbx_business_glossary_term' = 'Der Nem Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `facility_id` SET TAGS ('dbx_business_glossary_term' = 'Facility Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `it_service_id` SET TAGS ('dbx_business_glossary_term' = 'It Service Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `microgrid_id` SET TAGS ('dbx_business_glossary_term' = 'Microgrid Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `pole_id` SET TAGS ('dbx_business_glossary_term' = 'Pole ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `premise_id` SET TAGS ('dbx_business_glossary_term' = 'Premise Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `product_program_id` SET TAGS ('dbx_business_glossary_term' = 'Program Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `rate_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Rate Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `gl_account_id` SET TAGS ('dbx_business_glossary_term' = 'Revenue Gl Account Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_plan_id` SET TAGS ('dbx_business_glossary_term' = 'Service Plan Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `tariff_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Tariff Schedule Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `vault_id` SET TAGS ('dbx_business_glossary_term' = 'Vault ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `connection_status` SET TAGS ('dbx_business_glossary_term' = 'Connection Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `connection_status` SET TAGS ('dbx_value_regex' = 'connected|disconnected|pending|planned');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `identifier` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (SPID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `is_primary_service_point` SET TAGS ('dbx_business_glossary_term' = 'Primary Service Point Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (°)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_business_glossary_term' = 'Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `lifecycle_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|planned|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `load_class` SET TAGS ('dbx_business_glossary_term' = 'Load Class');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `load_class` SET TAGS ('dbx_value_regex' = 'residential|commercial|industrial|agricultural');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (°)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `meter_socket_type` SET TAGS ('dbx_business_glossary_term' = 'Meter Socket Type');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `meter_socket_type` SET TAGS ('dbx_value_regex' = 'split-phase|single-phase|three-phase|smart|analog');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `nem_eligibility_flag` SET TAGS ('dbx_business_glossary_term' = 'NEM Eligibility Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_value_regex' = '1PH|3PH');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `reliability_caidi` SET TAGS ('dbx_business_glossary_term' = 'CAIDI (Hours)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `reliability_saidi` SET TAGS ('dbx_business_glossary_term' = 'SAIDI (Hours)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `reliability_saifi` SET TAGS ('dbx_business_glossary_term' = 'SAIFI (Interruptions)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 1');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_address_line1` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_business_glossary_term' = 'Service Address Line 2');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_address_line2` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_amperage` SET TAGS ('dbx_business_glossary_term' = 'Service Amperage (A)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_capacity_kw` SET TAGS ('dbx_business_glossary_term' = 'Service Capacity (kW)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_capacity_mw` SET TAGS ('dbx_business_glossary_term' = 'Service Capacity (MW)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_city` SET TAGS ('dbx_business_glossary_term' = 'Service City');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_city` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_city` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_country` SET TAGS ('dbx_business_glossary_term' = 'Service Country');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_country` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_country` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_point_name` SET TAGS ('dbx_business_glossary_term' = 'Service Point Name');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_state` SET TAGS ('dbx_business_glossary_term' = 'Service State');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_state` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_state` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_type` SET TAGS ('dbx_business_glossary_term' = 'Service Type');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_type` SET TAGS ('dbx_value_regex' = 'electric|gas');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_zip_code` SET TAGS ('dbx_business_glossary_term' = 'Service ZIP Code');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_zip_code` SET TAGS ('dbx_value_regex' = '^d{5}(-d{4})?$');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_zip_code` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `service_zip_code` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `voltage_class` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_service_point` ALTER COLUMN `voltage_class` SET TAGS ('dbx_value_regex' = '120V|240V|277V|480V|208V');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` SET TAGS ('dbx_subdomain' = 'electric_network');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `distribution_transformer_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Transformer ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'GIS Location ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `pole_id` SET TAGS ('dbx_business_glossary_term' = 'Pole ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `age_years` SET TAGS ('dbx_business_glossary_term' = 'Asset Age (Years)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `asset_condition` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `asset_condition` SET TAGS ('dbx_value_regex' = 'excellent|good|fair|poor|unknown');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag (Identifier)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `asset_tag` SET TAGS ('dbx_value_regex' = '^[A-Z0-9-]{1,20}$');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `average_load_kva` SET TAGS ('dbx_business_glossary_term' = 'Average Load (kVA)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `capital_asset_number` SET TAGS ('dbx_business_glossary_term' = 'Capital Asset Number');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `cooling_type` SET TAGS ('dbx_business_glossary_term' = 'Cooling Type');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `cooling_type` SET TAGS ('dbx_value_regex' = 'onan|onaf|forced_air|oil_immersed');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `cost_basis_usd` SET TAGS ('dbx_business_glossary_term' = 'Cost Basis (USD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `depreciation_years` SET TAGS ('dbx_business_glossary_term' = 'Depreciation Period (Years)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `distribution_transformer_name` SET TAGS ('dbx_business_glossary_term' = 'Transformer Name');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `distribution_transformer_status` SET TAGS ('dbx_business_glossary_term' = 'Transformer Lifecycle Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `distribution_transformer_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|retired|maintenance');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `installation_type` SET TAGS ('dbx_business_glossary_term' = 'Installation Type');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `installation_type` SET TAGS ('dbx_value_regex' = 'overhead|underground|substation');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `is_automated` SET TAGS ('dbx_business_glossary_term' = 'Automated Monitoring Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Asset Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `is_transformer_protected` SET TAGS ('dbx_business_glossary_term' = 'Physical Protection Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `is_under_warranty` SET TAGS ('dbx_business_glossary_term' = 'Warranty Coverage Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `last_regulatory_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Regulatory Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Geographic Coordinate)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `load_factor_percent` SET TAGS ('dbx_business_glossary_term' = 'Load Factor (%)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Geographic Coordinate)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `max_load_kva` SET TAGS ('dbx_business_glossary_term' = 'Maximum Load (kVA)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_value_regex' = 'single_phase|three_phase');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `primary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Primary Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `rating_kva` SET TAGS ('dbx_business_glossary_term' = 'Transformer Rating (kVA)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `secondary_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Secondary Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `serial_number` SET TAGS ('dbx_value_regex' = '^[A-Z0-9]{1,30}$');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `tap_position` SET TAGS ('dbx_business_glossary_term' = 'Tap Position');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `transformer_type` SET TAGS ('dbx_business_glossary_term' = 'Transformer Type');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `transformer_type` SET TAGS ('dbx_value_regex' = 'pad_mount|pole_mount|vault|underground');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `voltage_regulation_percent` SET TAGS ('dbx_business_glossary_term' = 'Voltage Regulation (%)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_transformer` ALTER COLUMN `warranty_expiration_date` SET TAGS ('dbx_business_glossary_term' = 'Warranty Expiration Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` SET TAGS ('dbx_subdomain' = 'electric_network');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `pole_id` SET TAGS ('dbx_business_glossary_term' = 'Pole Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Inspection Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `network_device_id` SET TAGS ('dbx_business_glossary_term' = 'Network Device Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `network_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `network_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `parcel_id` SET TAGS ('dbx_business_glossary_term' = 'Parcel Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `ansi_class` SET TAGS ('dbx_business_glossary_term' = 'ANSI Pole Class');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `asset_status` SET TAGS ('dbx_business_glossary_term' = 'Asset Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `asset_status` SET TAGS ('dbx_value_regex' = 'in_service|retired|out_of_service|planned');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag (Pole)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `attachment_count` SET TAGS ('dbx_business_glossary_term' = 'Attachment Count');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `condition_rating` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical|unknown');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `datum` SET TAGS ('dbx_business_glossary_term' = 'Geodetic Datum');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation (Feet)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `gps_accuracy_m` SET TAGS ('dbx_business_glossary_term' = 'GPS Accuracy (Meters)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `height_ft` SET TAGS ('dbx_business_glossary_term' = 'Pole Height (Feet)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `joint_use_flag` SET TAGS ('dbx_business_glossary_term' = 'Joint‑Use Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `last_storm_event_date` SET TAGS ('dbx_business_glossary_term' = 'Last Storm Event Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `loading_capacity_pct` SET TAGS ('dbx_business_glossary_term' = 'Loading Capacity (%)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (Decimal Degrees)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `maintenance_due_date` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Due Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'scheduled|completed|overdue|not_required');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `municipality` SET TAGS ('dbx_business_glossary_term' = 'Municipality');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `owner_type` SET TAGS ('dbx_business_glossary_term' = 'Owner Type');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `owner_type` SET TAGS ('dbx_value_regex' = 'utility|joint_use|third_party');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `pole_name` SET TAGS ('dbx_business_glossary_term' = 'Pole Name');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `record_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `replacement_year_estimate` SET TAGS ('dbx_business_glossary_term' = 'Estimated Replacement Year');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `storm_damage_flag` SET TAGS ('dbx_business_glossary_term' = 'Storm Damage Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `structure_type` SET TAGS ('dbx_business_glossary_term' = 'Structure Type');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `structure_type` SET TAGS ('dbx_value_regex' = 'pole|vault|manhole|pedestal|riser');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`pole` ALTER COLUMN `voltage_rating_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Rating (kV)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` SET TAGS ('dbx_subdomain' = 'electric_network');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `protective_device_id` SET TAGS ('dbx_business_glossary_term' = 'Protective Device ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `protective_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `protective_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Technician Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `primary_upstream_device_protective_device_id` SET TAGS ('dbx_business_glossary_term' = 'Upstream Device ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `primary_upstream_device_protective_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `primary_upstream_device_protective_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `asset_category` SET TAGS ('dbx_business_glossary_term' = 'Asset Category');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `asset_classification` SET TAGS ('dbx_business_glossary_term' = 'Asset Classification');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `commissioning_date` SET TAGS ('dbx_business_glossary_term' = 'Commissioning Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `control_mode` SET TAGS ('dbx_business_glossary_term' = 'Control Mode');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `control_mode` SET TAGS ('dbx_value_regex' = 'fixed|automatic|scada_controlled');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `coordination_group` SET TAGS ('dbx_business_glossary_term' = 'Coordination Group');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `current_class` SET TAGS ('dbx_business_glossary_term' = 'Current Class');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `device_code` SET TAGS ('dbx_business_glossary_term' = 'Protective Device Code');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `device_type` SET TAGS ('dbx_business_glossary_term' = 'Protective Device Type (PDT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `device_type` SET TAGS ('dbx_value_regex' = 'recloser|sectionalizer|fuse|automated_switch|capacitor_bank');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `fault_current_rating_ka` SET TAGS ('dbx_business_glossary_term' = 'Fault Current Rating (kA)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `installation_date` SET TAGS ('dbx_business_glossary_term' = 'Installation Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `last_test_date` SET TAGS ('dbx_business_glossary_term' = 'Last Test Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (degrees)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (degrees)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `maintenance_interval_days` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Interval (Days)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `model_number` SET TAGS ('dbx_business_glossary_term' = 'Model Number');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `number_of_steps` SET TAGS ('dbx_business_glossary_term' = 'Number of Steps');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|maintenance|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `protection_scheme` SET TAGS ('dbx_business_glossary_term' = 'Protection Scheme');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `protective_device_name` SET TAGS ('dbx_business_glossary_term' = 'Protective Device Name (PDN)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `rated_interrupting_current_ka` SET TAGS ('dbx_business_glossary_term' = 'Rated Interrupting Current (kA)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `rated_kvar` SET TAGS ('dbx_business_glossary_term' = 'Rated Reactive Power (kVAR)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `rated_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Rated Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `record_created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `record_updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `remote_operation_mode` SET TAGS ('dbx_business_glossary_term' = 'Remote Operation Mode');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `remote_operation_mode` SET TAGS ('dbx_value_regex' = 'remote|manual');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `scada_controllable_flag` SET TAGS ('dbx_business_glossary_term' = 'SCADA Controllable Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `serial_number` SET TAGS ('dbx_business_glossary_term' = 'Serial Number');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `sub_type` SET TAGS ('dbx_business_glossary_term' = 'Protective Device Sub‑type');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `switching_operations_count` SET TAGS ('dbx_business_glossary_term' = 'Switching Operations Count');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`protective_device` ALTER COLUMN `voltage_class` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` SET TAGS ('dbx_subdomain' = 'gas_distribution');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `gas_main_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Main Identifier (GMI)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Asset Registry Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `fixed_asset_id` SET TAGS ('dbx_business_glossary_term' = 'Fixed Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `gas_pressure_district_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `environmental_permit_id` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Environmental Permit Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `scada_system_id` SET TAGS ('dbx_business_glossary_term' = 'Scada System Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `gas_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Start Node Identifier (SNI)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `asset_condition` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition (AC)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `asset_condition` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `asset_tag` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag (AT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `cathodic_protection_zone` SET TAGS ('dbx_business_glossary_term' = 'Cathodic Protection Zone (CPZ)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `coating_type` SET TAGS ('dbx_business_glossary_term' = 'Coating Type (CT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `coating_type` SET TAGS ('dbx_value_regex' = 'epoxy|polyethylene|none');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `corrosion_rate_mpy` SET TAGS ('dbx_business_glossary_term' = 'Corrosion Rate (mpy) (CR)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date (DCMD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `design_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Design Pressure (psi) (DP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `end_node_code` SET TAGS ('dbx_business_glossary_term' = 'End Node Identifier (ENI)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `gas_main_name` SET TAGS ('dbx_business_glossary_term' = 'Gas Main Name (GMN)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `gis_geometry_reference` SET TAGS ('dbx_business_glossary_term' = 'GIS Geometry Identifier (GGI)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year (IY)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `last_leak_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Last Leak Survey Date (LLSD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `leak_survey_class` SET TAGS ('dbx_business_glossary_term' = 'Leak Survey Class (LSC)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `leak_survey_class` SET TAGS ('dbx_value_regex' = 'class_a|class_b|class_c');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `length_ft` SET TAGS ('dbx_business_glossary_term' = 'Length (feet) (LEN)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `maintenance_priority` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Priority (MPR)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `maintenance_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `material_grade` SET TAGS ('dbx_business_glossary_term' = 'Material Grade (MG)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `max_operating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Maximum Operating Pressure (psi) (MOP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `min_operating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Minimum Operating Pressure (psi) (mOP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `municipality` SET TAGS ('dbx_business_glossary_term' = 'Municipality (MUN)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `next_leak_survey_due` SET TAGS ('dbx_business_glossary_term' = 'Next Leak Survey Due Date (NLSD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `nominal_diameter_in` SET TAGS ('dbx_business_glossary_term' = 'Nominal Diameter (inches) (ND)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes (NTS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `operating_pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure (psi) (OP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status (OS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'in_service|out_of_service|planned_retirement|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `pressure_class` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure Class (OPC)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `pressure_class` SET TAGS ('dbx_value_regex' = 'LP|MP|HP');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `risk_score` SET TAGS ('dbx_business_glossary_term' = 'Risk Score (RS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `wall_thickness_mm` SET TAGS ('dbx_business_glossary_term' = 'Wall Thickness (mm) (WT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_main` ALTER COLUMN `year_of_last_inspection` SET TAGS ('dbx_business_glossary_term' = 'Year of Last Inspection (YLI)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` SET TAGS ('dbx_subdomain' = 'gas_distribution');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `gas_service_line_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Service Line Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point Identifier (SPID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `gas_main_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Main Identifier (GMID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'Location Identifier (LID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `meter_set_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Set Identifier (MSID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `pm_schedule_id` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Schedule Identifier (MSID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `asset_owner` SET TAGS ('dbx_business_glossary_term' = 'Asset Owner (AO)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag (RCF)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `condition_rating` SET TAGS ('dbx_business_glossary_term' = 'Condition Rating (CR)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (RCT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date (DCMD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `diameter_in` SET TAGS ('dbx_business_glossary_term' = 'Pipe Diameter (IN)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `elevation_ft` SET TAGS ('dbx_business_glossary_term' = 'Elevation (FT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `external_reference_number` SET TAGS ('dbx_business_glossary_term' = 'External Reference Number (ERN)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `gas_service_line_status` SET TAGS ('dbx_business_glossary_term' = 'Service Line Status (STS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `gas_service_line_status` SET TAGS ('dbx_value_regex' = 'active|inactive|retired|suspended|planned');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `geometry_wkt` SET TAGS ('dbx_business_glossary_term' = 'GIS Geometry (WKT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status (IS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending|deferred');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year (YR)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag (CIF)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `is_under_pressure_test` SET TAGS ('dbx_business_glossary_term' = 'Under Pressure Test Flag (UPTF)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (LID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date (LMD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `last_pressure_test_pressure` SET TAGS ('dbx_business_glossary_term' = 'Last Test Pressure (LTP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LAT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `leak_survey_date` SET TAGS ('dbx_business_glossary_term' = 'Leak Survey Date (LSD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `leak_survey_notes` SET TAGS ('dbx_business_glossary_term' = 'Leak Survey Notes (LSN)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `leak_survey_result` SET TAGS ('dbx_business_glossary_term' = 'Leak Survey Result (LSR)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `leak_survey_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_applicable');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `length_ft` SET TAGS ('dbx_business_glossary_term' = 'Service Line Length (FT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Service Line Code (SLC)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `line_name` SET TAGS ('dbx_business_glossary_term' = 'Service Line Name (SLN)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LON)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `material_grade` SET TAGS ('dbx_business_glossary_term' = 'Material Grade (MG)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date (NMDD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `operating_pressure_psig` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure (PSIG)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `pressure_test_date` SET TAGS ('dbx_business_glossary_term' = 'Pressure Test Date (PTD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `pressure_test_result` SET TAGS ('dbx_business_glossary_term' = 'Pressure Test Result (PTR)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `pressure_test_result` SET TAGS ('dbx_value_regex' = 'pass|fail|not_tested');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `retirement_reason` SET TAGS ('dbx_business_glossary_term' = 'Retirement Reason (RR)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `risk_classification` SET TAGS ('dbx_business_glossary_term' = 'Risk Classification (RC)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `risk_classification` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_service_line` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (RUT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` SET TAGS ('dbx_subdomain' = 'operations_management');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `distribution_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Outage Event ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Dispatch ID (CREW_DISP_ID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `docket_id` SET TAGS ('dbx_business_glossary_term' = 'Docket Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `generation_outage_id` SET TAGS ('dbx_business_glossary_term' = 'Generation Outage Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `gridops_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Gridops Outage Event Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `incident_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `incident_ticket_id` SET TAGS ('dbx_business_glossary_term' = 'Incident Ticket Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `cost_center_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Cost Center Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `protective_device_id` SET TAGS ('dbx_business_glossary_term' = 'Protective Device ID (PROT_DEV_ID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `protective_device_id` SET TAGS ('dbx_internal' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `protective_device_id` SET TAGS ('dbx_pii' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Der Resource Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `storm_event_id` SET TAGS ('dbx_business_glossary_term' = 'Storm Event ID (STORM_EVT_ID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `work_order_id` SET TAGS ('dbx_business_glossary_term' = 'Work Order ID (WO_ID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `actual_customers_affected` SET TAGS ('dbx_business_glossary_term' = 'Actual Customers Affected (ACT_CUST_AFF)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `actual_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Duration (ACT_DURATION_MIN)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `affected_feeder_ids` SET TAGS ('dbx_business_glossary_term' = 'Affected Feeder IDs (FEEDER_IDS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `caidi_contribution` SET TAGS ('dbx_business_glossary_term' = 'CAIDI Contribution (CAIDI_CONTR)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `cause_code` SET TAGS ('dbx_business_glossary_term' = 'Cause Code (CAUSE_CD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `cause_code` SET TAGS ('dbx_value_regex' = 'weather|equipment_failure|animal|vegetation|third_party|unknown');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `customer_notification_status` SET TAGS ('dbx_business_glossary_term' = 'Customer Notification Status (CUST_NOTIF_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `customer_notification_status` SET TAGS ('dbx_value_regex' = 'notified|not_notified|partial');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `distribution_outage_event_description` SET TAGS ('dbx_business_glossary_term' = 'Outage Description (OUTAGE_DESC)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `distribution_outage_event_status` SET TAGS ('dbx_business_glossary_term' = 'Outage Status (OUTAGE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `distribution_outage_event_status` SET TAGS ('dbx_value_regex' = 'open|in_progress|closed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `estimated_customers_affected` SET TAGS ('dbx_business_glossary_term' = 'Estimated Customers Affected (EST_CUST_AFF)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `estimated_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Duration (EST_DURATION_MIN)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `ieee_1366_exclusion_flag` SET TAGS ('dbx_business_glossary_term' = 'IEEE 1366 Exclusion Flag (IEEE_EXCL_FLG)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude (LATITUDE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude (LONGITUDE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `outage_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage End Timestamp (OUTAGE_END_TSTMP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `outage_event_number` SET TAGS ('dbx_business_glossary_term' = 'Outage Event Number (OUTAGE_EVT_NUM)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `outage_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage Start Timestamp (OUTAGE_START_TSTMP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `outage_type` SET TAGS ('dbx_business_glossary_term' = 'Outage Type (OUTAGE_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `outage_type` SET TAGS ('dbx_value_regex' = 'planned|unplanned|momentary');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `record_audit_created` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Created (REC_CREATED_TSTMP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `record_audit_updated` SET TAGS ('dbx_business_glossary_term' = 'Record Audit Updated (REC_UPDATED_TSTMP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `region_code` SET TAGS ('dbx_business_glossary_term' = 'Region Code (REGION_CD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `saidi_contribution` SET TAGS ('dbx_business_glossary_term' = 'SAIDI Contribution (SAIDI_CONTR)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `saifi_contribution` SET TAGS ('dbx_business_glossary_term' = 'SAIFI Contribution (SAIFI_CONTR)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `updated_by` SET TAGS ('dbx_business_glossary_term' = 'Updated By (UPDATED_BY)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_outage_event` ALTER COLUMN `created_by` SET TAGS ('dbx_business_glossary_term' = 'Created By (CREATED_BY)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` SET TAGS ('dbx_subdomain' = 'operations_management');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `distribution_switching_order_id` SET TAGS ('dbx_business_glossary_term' = 'Distribution Switching Order ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `approved_by_operator_employee_id` SET TAGS ('dbx_business_glossary_term' = 'Approving Operator ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `change_request_id` SET TAGS ('dbx_business_glossary_term' = 'Change Request Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `distribution_outage_event_id` SET TAGS ('dbx_business_glossary_term' = 'Outage Event ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Operator ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `gridops_switching_order_id` SET TAGS ('dbx_business_glossary_term' = 'Gridops Switching Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Issuing Operator ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `actual_customers_affected` SET TAGS ('dbx_business_glossary_term' = 'Actual Customers Affected');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `actual_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Execution End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `actual_outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Actual Outage Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `actual_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Actual Execution Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `affected_feeder_ids` SET TAGS ('dbx_business_glossary_term' = 'Affected Feeder IDs');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `completion_status` SET TAGS ('dbx_business_glossary_term' = 'Completion Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `completion_status` SET TAGS ('dbx_value_regex' = 'success|partial|failed');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `creation_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `distribution_switching_order_status` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Status (SO)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `distribution_switching_order_status` SET TAGS ('dbx_value_regex' = 'draft|approved|in_progress|completed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `estimated_customers_affected` SET TAGS ('dbx_business_glossary_term' = 'Estimated Customers Affected');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `estimated_outage_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Estimated Outage Duration (Minutes)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `is_critical` SET TAGS ('dbx_business_glossary_term' = 'Critical Switching Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `last_update_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Last Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Number (SO)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Type (SO)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'planned|emergency|flisr');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `planned_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Execution End Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `planned_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Planned Execution Start Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Switching Order Priority');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `regulatory_compliance_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `remarks` SET TAGS ('dbx_business_glossary_term' = 'Remarks');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `safety_clearance_reference` SET TAGS ('dbx_business_glossary_term' = 'Safety Clearance Reference');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `switching_step_count` SET TAGS ('dbx_business_glossary_term' = 'Switching Step Count');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `switching_steps_detail` SET TAGS ('dbx_business_glossary_term' = 'Switching Steps Detail');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`distribution_switching_order` ALTER COLUMN `work_order_reference` SET TAGS ('dbx_business_glossary_term' = 'Work Order Reference (WO)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` SET TAGS ('dbx_subdomain' = 'gas_distribution');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `gas_pressure_district_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Pressure District ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `data_source_record_reference` SET TAGS ('dbx_business_glossary_term' = 'Source System Record ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Source System Name');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `district_code` SET TAGS ('dbx_business_glossary_term' = 'District Code');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `district_manager_contact_phone` SET TAGS ('dbx_business_glossary_term' = 'District Manager Phone');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `district_manager_contact_phone` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `district_manager_contact_phone` SET TAGS ('dbx_pii_phone' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `district_manager_email` SET TAGS ('dbx_business_glossary_term' = 'District Manager Email');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `district_manager_email` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `district_manager_email` SET TAGS ('dbx_pii_email' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `district_manager_name` SET TAGS ('dbx_business_glossary_term' = 'District Manager Name');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `district_name` SET TAGS ('dbx_business_glossary_term' = 'District Name');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `effective_end_date` SET TAGS ('dbx_business_glossary_term' = 'Effective End Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `effective_start_date` SET TAGS ('dbx_business_glossary_term' = 'Effective Start Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `emergency_isolation_plan_available` SET TAGS ('dbx_business_glossary_term' = 'Emergency Isolation Plan Available');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `gas_pressure_district_status` SET TAGS ('dbx_business_glossary_term' = 'District Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `gas_pressure_district_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `geographic_boundary_wkt` SET TAGS ('dbx_business_glossary_term' = 'Geographic Boundary (WKT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `geometry_type` SET TAGS ('dbx_business_glossary_term' = 'Geometry Type');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `geometry_type` SET TAGS ('dbx_value_regex' = 'polygon|multipolygon');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `last_pressure_audit_date` SET TAGS ('dbx_business_glossary_term' = 'Last Pressure Audit Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'District Notes');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `number_of_customers_served` SET TAGS ('dbx_business_glossary_term' = 'Number of Customers Served');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `operating_pressure_max_psig` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure Maximum (psig)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `operating_pressure_min_psig` SET TAGS ('dbx_business_glossary_term' = 'Operating Pressure Minimum (psig)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `phmsa_compliant` SET TAGS ('dbx_business_glossary_term' = 'PHMSA Compliance Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `pressure_class` SET TAGS ('dbx_business_glossary_term' = 'Pressure Class (Low/Medium/High)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `pressure_class` SET TAGS ('dbx_value_regex' = 'LP|MP|HP');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `pressure_monitoring_system_installed` SET TAGS ('dbx_business_glossary_term' = 'Pressure Monitoring System Installed');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `pressure_unit` SET TAGS ('dbx_business_glossary_term' = 'Pressure Unit');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `pressure_unit` SET TAGS ('dbx_value_regex' = 'psig|kPa');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `regulating_station_ids` SET TAGS ('dbx_business_glossary_term' = 'Regulating Station Identifiers');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `regulating_station_locations` SET TAGS ('dbx_business_glossary_term' = 'Regulating Station Locations');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `regulatory_reporting_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `service_area_code` SET TAGS ('dbx_business_glossary_term' = 'Service Area Code');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `total_main_miles` SET TAGS ('dbx_business_glossary_term' = 'Total Main Pipe Miles');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_pressure_district` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` SET TAGS ('dbx_subdomain' = 'operations_management');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `gas_leak_survey_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Leak Survey Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `registry_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Asset Identifier (ASSET_ID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Survey Crew Identifier (CREW_ID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `gas_main_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Main Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `asset_identifier` SET TAGS ('dbx_business_glossary_term' = 'Asset Tag (ASSET_TAG)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `data_source_system` SET TAGS ('dbx_business_glossary_term' = 'Data Source System (SOURCE_SYS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `follow_up_required` SET TAGS ('dbx_business_glossary_term' = 'Follow‑Up Required Flag (FOLLOW_UP_REQ)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `gps_accuracy_meters` SET TAGS ('dbx_business_glossary_term' = 'GPS Accuracy (GPS_ACC_M)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `instrument_type` SET TAGS ('dbx_business_glossary_term' = 'Instrument Type (INSTRUMENT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `instrument_type` SET TAGS ('dbx_value_regex' = 'infrared|ultrasonic|sniffer|laser|visual');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `jurisdiction` SET TAGS ('dbx_business_glossary_term' = 'Jurisdiction (JURISDICTION)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_classification` SET TAGS ('dbx_business_glossary_term' = 'Leak Classification (LEAK_CLASS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_classification` SET TAGS ('dbx_value_regex' = 'grade1|grade2|grade3');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `leak_indication_count` SET TAGS ('dbx_business_glossary_term' = 'Leak Indication Count (LEAK_COUNT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `location_latitude` SET TAGS ('dbx_business_glossary_term' = 'Location Latitude (LATITUDE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `location_latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `location_latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `location_longitude` SET TAGS ('dbx_business_glossary_term' = 'Location Longitude (LONGITUDE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `location_longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `location_longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Survey Notes (NOTES)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `pressure_psi` SET TAGS ('dbx_business_glossary_term' = 'Pipe Pressure (PRESSURE_PSI)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `regulatory_reporting_flag` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Reporting Flag (REG_REPORT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `report_status` SET TAGS ('dbx_business_glossary_term' = 'Report Status (REPORT_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `report_status` SET TAGS ('dbx_value_regex' = 'pending|submitted|rejected|approved');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `report_submitted_date` SET TAGS ('dbx_business_glossary_term' = 'Report Submission Date (REPORT_DATE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_completed` SET TAGS ('dbx_business_glossary_term' = 'Survey Completed Flag (COMPLETED)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_duration_minutes` SET TAGS ('dbx_business_glossary_term' = 'Survey Duration (DURATION_MIN)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_number` SET TAGS ('dbx_business_glossary_term' = 'Survey Number (SURVEY_NUM)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_business_glossary_term' = 'Survey Status (SURVEY_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Survey Timestamp (SURVEY_TS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_business_glossary_term' = 'Survey Type (SURVEY_TYPE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `survey_type` SET TAGS ('dbx_value_regex' = 'bar-hole|cgi|walking|mobile|aerial');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `temperature_c` SET TAGS ('dbx_business_glossary_term' = 'Ambient Temperature (TEMP_C)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_business_glossary_term' = 'Weather Conditions (WEATHER)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `weather_conditions` SET TAGS ('dbx_value_regex' = 'clear|cloudy|rain|snow|windy');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak_survey` ALTER COLUMN `wind_speed_mph` SET TAGS ('dbx_business_glossary_term' = 'Wind Speed (WIND_MPH)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` SET TAGS ('dbx_subdomain' = 'gas_distribution');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `gas_leak_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Leak Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Assigned Crew Identifier (ASSIGNED_CREW_ID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `gas_main_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Main Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `location_id` SET TAGS ('dbx_business_glossary_term' = 'GIS Location Identifier (GIS_LOCATION_ID)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `it_asset_id` SET TAGS ('dbx_business_glossary_term' = 'It Asset Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `violation_notice_id` SET TAGS ('dbx_business_glossary_term' = 'Violation Notice Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `actual_repair_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Actual Repair Cost (USD) (ACTUAL_REPAIR_COST_USD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `asset_manager` SET TAGS ('dbx_business_glossary_term' = 'Asset Manager (ASSET_MANAGER)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `closure_status` SET TAGS ('dbx_business_glossary_term' = 'Closure Status (CLOSURE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `closure_status` SET TAGS ('dbx_value_regex' = 'open|closed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp (CREATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `discovery_date` SET TAGS ('dbx_business_glossary_term' = 'Discovery Date (DISCOVERY_DATE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `discovery_method` SET TAGS ('dbx_business_glossary_term' = 'Discovery Method (DISCOVERY_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `discovery_method` SET TAGS ('dbx_value_regex' = 'survey|customer_report|third_party_damage|sensor_detection');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `emergency_response_required` SET TAGS ('dbx_business_glossary_term' = 'Emergency Response Required (EMERGENCY_RESPONSE_REQUIRED)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `estimated_repair_cost_usd` SET TAGS ('dbx_business_glossary_term' = 'Estimated Repair Cost (USD) (ESTIMATED_REPAIR_COST_USD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `estimated_total_release_mcf` SET TAGS ('dbx_business_glossary_term' = 'Estimated Total Release (MCF) (ESTIMATED_TOTAL_RELEASE_MCF)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `field_notes` SET TAGS ('dbx_business_glossary_term' = 'Field Notes (FIELD_NOTES)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `gas_leak_status` SET TAGS ('dbx_business_glossary_term' = 'Leak Status (STATUS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `gas_leak_status` SET TAGS ('dbx_value_regex' = 'active|monitored|resolved');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `impacted_customers_count` SET TAGS ('dbx_business_glossary_term' = 'Impacted Customers Count (IMPACTED_CUSTOMERS_COUNT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status (INSPECTION_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pass|fail|pending');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date (LAST_INSPECTION_DATE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `latitude` SET TAGS ('dbx_business_glossary_term' = 'Latitude (LATITUDE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `latitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `latitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `leak_code` SET TAGS ('dbx_business_glossary_term' = 'Leak Code (LEAK_CODE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `leak_grade` SET TAGS ('dbx_business_glossary_term' = 'Leak Grade (LEAK_GRADE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `leak_grade` SET TAGS ('dbx_value_regex' = 'grade_1|grade_2|grade_3');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `leak_name` SET TAGS ('dbx_business_glossary_term' = 'Leak Name (LEAK_NAME)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `leak_size_mcf_per_day` SET TAGS ('dbx_business_glossary_term' = 'Leak Size (MCF/Day) (LEAK_SIZE_MCF_PER_DAY)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `longitude` SET TAGS ('dbx_business_glossary_term' = 'Longitude (LONGITUDE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `longitude` SET TAGS ('dbx_restricted' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `longitude` SET TAGS ('dbx_pii_address' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `outage_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage End Timestamp (OUTAGE_END_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `outage_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Outage Start Timestamp (OUTAGE_START_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization (OWNER_ORGANIZATION)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `phmsa_report_number` SET TAGS ('dbx_business_glossary_term' = 'PHMSA Report Number (PHMSA_REPORT_NUMBER)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `phmsa_report_required` SET TAGS ('dbx_business_glossary_term' = 'PHMSA Report Required (PHMSA_REPORT_REQUIRED)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status (REGULATORY_COMPLIANCE_STATUS)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `repair_date` SET TAGS ('dbx_business_glossary_term' = 'Repair Date (REPAIR_DATE)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `repair_method` SET TAGS ('dbx_business_glossary_term' = 'Repair Method (REPAIR_METHOD)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `repair_method` SET TAGS ('dbx_value_regex' = 'replace_section|weld|clamp|sealant|other');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `repair_priority` SET TAGS ('dbx_business_glossary_term' = 'Repair Priority (REPAIR_PRIORITY)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `repair_priority` SET TAGS ('dbx_value_regex' = 'high|medium|low');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `reported_by` SET TAGS ('dbx_business_glossary_term' = 'Reported By (REPORTED_BY)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `safety_hazard_level` SET TAGS ('dbx_business_glossary_term' = 'Safety Hazard Level (SAFETY_HAZARD_LEVEL)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `safety_hazard_level` SET TAGS ('dbx_value_regex' = 'low|moderate|high|critical');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_leak` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp (UPDATED_TIMESTAMP)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` SET TAGS ('dbx_data_type' = 'transactional_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` SET TAGS ('dbx_subdomain' = 'operations_management');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `service_connection_order_id` SET TAGS ('dbx_business_glossary_term' = 'Service Connection Order ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Crew Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `customer_account_id` SET TAGS ('dbx_business_glossary_term' = 'Customer Account ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `distribution_service_point_id` SET TAGS ('dbx_business_glossary_term' = 'Service Point ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `employee_id` SET TAGS ('dbx_business_glossary_term' = 'Design Engineer ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `resource_id` SET TAGS ('dbx_business_glossary_term' = 'Der Resource Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `technician_id` SET TAGS ('dbx_business_glossary_term' = 'Design Engineer ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `commodity_type` SET TAGS ('dbx_business_glossary_term' = 'Commodity Type');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `commodity_type` SET TAGS ('dbx_value_regex' = 'electric|gas');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `completion_date` SET TAGS ('dbx_business_glossary_term' = 'Completion Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|exempt');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Created Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_business_glossary_term' = 'Currency Code');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `currency_code` SET TAGS ('dbx_value_regex' = 'USD|CAD|EUR|GBP|JPY|AUD');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `estimated_cost` SET TAGS ('dbx_business_glossary_term' = 'Estimated Cost');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'pending|scheduled|passed|failed|not_required');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `is_emergency` SET TAGS ('dbx_business_glossary_term' = 'Emergency Order Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Order Notes');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `order_number` SET TAGS ('dbx_business_glossary_term' = 'Order Number');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `order_submitted_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Order Submitted Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `order_type` SET TAGS ('dbx_business_glossary_term' = 'Order Type');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `order_type` SET TAGS ('dbx_value_regex' = 'new_connect|upgrade|downgrade|disconnect|reconnect');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `permit_number` SET TAGS ('dbx_business_glossary_term' = 'Permit Number');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `priority` SET TAGS ('dbx_business_glossary_term' = 'Order Priority');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `priority` SET TAGS ('dbx_value_regex' = 'low|medium|high|critical');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Approval Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `regulatory_approval_status` SET TAGS ('dbx_value_regex' = 'pending|approved|rejected');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `requested_service_date` SET TAGS ('dbx_business_glossary_term' = 'Requested Service Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `scheduled_end_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled End Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `scheduled_start_date` SET TAGS ('dbx_business_glossary_term' = 'Scheduled Start Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `service_connection_order_status` SET TAGS ('dbx_business_glossary_term' = 'Order Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `service_connection_order_status` SET TAGS ('dbx_value_regex' = 'draft|submitted|approved|in_progress|completed|cancelled');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `tax_amount` SET TAGS ('dbx_business_glossary_term' = 'Tax Amount');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `total_cost` SET TAGS ('dbx_business_glossary_term' = 'Total Cost');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Updated Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`service_connection_order` ALTER COLUMN `work_description` SET TAGS ('dbx_business_glossary_term' = 'Work Description');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` SET TAGS ('dbx_subdomain' = 'electric_network');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `conductor_span_id` SET TAGS ('dbx_business_glossary_term' = 'Conductor Span ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `structure_id` SET TAGS ('dbx_business_glossary_term' = 'From Structure ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `material_master_id` SET TAGS ('dbx_business_glossary_term' = 'Material Master Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Associated Feeder ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `pole_id` SET TAGS ('dbx_business_glossary_term' = 'From Structure ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `purchase_order_id` SET TAGS ('dbx_business_glossary_term' = 'Purchase Order Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `to_structure_pole_id` SET TAGS ('dbx_business_glossary_term' = 'To Structure ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `vendor_id` SET TAGS ('dbx_business_glossary_term' = 'Vendor Id (Foreign Key)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `replaced_conductor_span_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `age_years` SET TAGS ('dbx_business_glossary_term' = 'Span Age (Years)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `asset_condition` SET TAGS ('dbx_business_glossary_term' = 'Asset Condition');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `asset_condition` SET TAGS ('dbx_value_regex' = 'good|fair|poor|critical');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `asset_manager` SET TAGS ('dbx_business_glossary_term' = 'Asset Manager');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `created_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Creation Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `decommission_date` SET TAGS ('dbx_business_glossary_term' = 'Decommission Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `gis_line_geometry` SET TAGS ('dbx_business_glossary_term' = 'GIS Line Geometry (WKT)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `inspection_status` SET TAGS ('dbx_business_glossary_term' = 'Inspection Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `inspection_status` SET TAGS ('dbx_value_regex' = 'passed|failed|pending');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `installation_year` SET TAGS ('dbx_business_glossary_term' = 'Installation Year');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `is_critical_infrastructure` SET TAGS ('dbx_business_glossary_term' = 'Critical Infrastructure Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `is_under_maintenance` SET TAGS ('dbx_business_glossary_term' = 'Under Maintenance Flag');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `last_inspection_date` SET TAGS ('dbx_business_glossary_term' = 'Last Inspection Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `last_maintenance_date` SET TAGS ('dbx_business_glossary_term' = 'Last Maintenance Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `length_ft` SET TAGS ('dbx_business_glossary_term' = 'Span Length (Feet)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `line_category` SET TAGS ('dbx_business_glossary_term' = 'Line Category');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `line_category` SET TAGS ('dbx_value_regex' = 'overhead|underground');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `line_code` SET TAGS ('dbx_business_glossary_term' = 'Line Code');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `line_current_ka` SET TAGS ('dbx_business_glossary_term' = 'Line Current (kA)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `line_voltage_kv` SET TAGS ('dbx_business_glossary_term' = 'Line Voltage (kV)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `maintenance_cycle_months` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Cycle (Months)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_business_glossary_term' = 'Maintenance Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `maintenance_status` SET TAGS ('dbx_value_regex' = 'scheduled|in_progress|completed');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `next_inspection_due` SET TAGS ('dbx_business_glossary_term' = 'Next Inspection Due Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `next_maintenance_due` SET TAGS ('dbx_business_glossary_term' = 'Next Maintenance Due Date');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `notes` SET TAGS ('dbx_business_glossary_term' = 'Notes');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `operational_status` SET TAGS ('dbx_business_glossary_term' = 'Operational Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `operational_status` SET TAGS ('dbx_value_regex' = 'active|inactive|planned|decommissioned');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `owner_organization` SET TAGS ('dbx_business_glossary_term' = 'Owner Organization');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `phase_configuration` SET TAGS ('dbx_business_glossary_term' = 'Phase Configuration');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `rated_ampacity_amps` SET TAGS ('dbx_business_glossary_term' = 'Rated Ampacity (Amps)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_business_glossary_term' = 'Regulatory Compliance Status');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `regulatory_compliance_status` SET TAGS ('dbx_value_regex' = 'compliant|non_compliant|pending');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `sag_design_temp_c` SET TAGS ('dbx_business_glossary_term' = 'Design Temperature for Sag (°C)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `sag_ft` SET TAGS ('dbx_business_glossary_term' = 'Sag (Feet)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `span_name` SET TAGS ('dbx_business_glossary_term' = 'Conductor Span Name');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `thermal_rating_c` SET TAGS ('dbx_business_glossary_term' = 'Thermal Rating (°C)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `to_structure_code` SET TAGS ('dbx_business_glossary_term' = 'To Structure ID');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `updated_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Record Update Timestamp');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`conductor_span` ALTER COLUMN `voltage_class_kv` SET TAGS ('dbx_business_glossary_term' = 'Voltage Class (kV)');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder_crew_assignment` SET TAGS ('dbx_data_type' = 'association_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder_crew_assignment` SET TAGS ('dbx_subdomain' = 'operations_management');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder_crew_assignment` SET TAGS ('dbx_association_edges' = 'distribution.feeder,workforce.crew');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder_crew_assignment` ALTER COLUMN `feeder_crew_assignment_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Crew Assignment - Feeder Crew Assignment Id');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder_crew_assignment` ALTER COLUMN `crew_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Crew Assignment - Crew Id');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder_crew_assignment` ALTER COLUMN `feeder_id` SET TAGS ('dbx_business_glossary_term' = 'Feeder Crew Assignment - Feeder Id');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder_crew_assignment` ALTER COLUMN `assignment_end_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment End Time');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder_crew_assignment` ALTER COLUMN `assignment_start_timestamp` SET TAGS ('dbx_business_glossary_term' = 'Assignment Start Time');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`feeder_crew_assignment` ALTER COLUMN `role` SET TAGS ('dbx_business_glossary_term' = 'Crew Role');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`vault` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`vault` SET TAGS ('dbx_subdomain' = 'electric_network');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`vault` ALTER COLUMN `vault_id` SET TAGS ('dbx_business_glossary_term' = 'Vault Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`vault` ALTER COLUMN `connected_vault_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`load_profile` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`load_profile` SET TAGS ('dbx_subdomain' = 'electric_network');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`load_profile` ALTER COLUMN `load_profile_id` SET TAGS ('dbx_business_glossary_term' = 'Load Profile Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`load_profile` ALTER COLUMN `baseline_load_profile_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_network_node` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_network_node` SET TAGS ('dbx_subdomain' = 'gas_distribution');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_network_node` ALTER COLUMN `gas_network_node_id` SET TAGS ('dbx_business_glossary_term' = 'Gas Network Node Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`gas_network_node` ALTER COLUMN `upstream_gas_network_node_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`meter_set` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`meter_set` SET TAGS ('dbx_subdomain' = 'electric_network');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`meter_set` ALTER COLUMN `meter_set_id` SET TAGS ('dbx_business_glossary_term' = 'Meter Set Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`meter_set` ALTER COLUMN `replaced_meter_set_id` SET TAGS ('dbx_self_ref_fk' = 'true');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`structure` SET TAGS ('dbx_data_type' = 'master_data');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`structure` SET TAGS ('dbx_subdomain' = 'electric_network');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`structure` ALTER COLUMN `structure_id` SET TAGS ('dbx_business_glossary_term' = 'Structure Identifier');
ALTER TABLE `power_and_utilities_v2`.`distribution`.`structure` ALTER COLUMN `adjacent_structure_id` SET TAGS ('dbx_self_ref_fk' = 'true');
